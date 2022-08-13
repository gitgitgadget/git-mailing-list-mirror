Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D39C00140
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 00:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiHMAQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 20:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHMAQa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 20:16:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7C196FDE
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 17:16:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so8152239pjz.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=ANbzgcB82+PRIAFgTgjJewhDZ5MCpyQiFLazKHb1JBA=;
        b=qQRPllyGqDm6InmQUWpdBoiWgaRdCy8gCQCBvUEt++u85Pqem+HLG5MjH4Lod+6hdf
         dZFjPfLZ9Hp11G+Md+jFYw0HM/Bfcmw1AzcJRL2fEG6HbmYclgRj5J+Q/qsxDoEiJ2NC
         0ggK9jA0CHUi0KtxPHqsrawfV5nrNJGLeZoW9QX8GXweS3YBA4mbC1Ql9klDHActbjyc
         O84+XK6f14FUkcs4NuL0i2oHtX0PAJMT47Yf8rAjjGUI8hFBIvudBamDvd1M3fnrmKlH
         bdvBukKzcaZF3DNiFslltk5mALmoOwsJH8rhJlBXcvKWctX/f+jzDVA9grHfXvxXYIjP
         5JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=ANbzgcB82+PRIAFgTgjJewhDZ5MCpyQiFLazKHb1JBA=;
        b=mpT63cBNT0sgaVYwAhDS0V6tyebQWNjt4HK5GwXo+XPjop2AE0lfMgsA7hiM3k8S4a
         LHQb5/VbpPTBRkCBUjcucPM1viqUn2cMVDppclKcoTbkRuSz3MUELpVpdpwXwWxq8AZf
         IORo7MpsibepZxTkvqXvTIYbZTw3kqWUN8cfrffgU5rvH8qsZlLm0Lea7jdunkVe+DxI
         BIBEG5QND5uVkqV4HQsZbUjL9cPeOSbDx2PPp8DTMNz+PfxGNAtghsoEjqaoe7EIxeMU
         Cn/tRmQhghP7uumPmgPlI7hkcBSWAjqwQfZnDK7ZRN9x6wljESJSSuxSPHkacqqFgykd
         UgGQ==
X-Gm-Message-State: ACgBeo2JXklxj+HYIkr3yUrUVQ84y5Zl9AkWUpzhQERgZSLR+qYYIOrP
        3MTv+BT9GINPdMQIXx+R0KplnW2F+zU=
X-Google-Smtp-Source: AA6agR6iEoEXi7wPusGi9zKcyqx1C+xhcw6n0qK92yQgeUOnAMd6mWSpHDOPB+OyDfpHP9G1hXJUww==
X-Received: by 2002:a17:902:f54b:b0:16e:f07b:46d7 with SMTP id h11-20020a170902f54b00b0016ef07b46d7mr6554582plf.18.1660349788813;
        Fri, 12 Aug 2022 17:16:28 -0700 (PDT)
Received: from localhost ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id 63-20020a620542000000b0052d50e14f1dsm2205800pff.78.2022.08.12.17.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 17:16:28 -0700 (PDT)
Date:   Sat, 13 Aug 2022 07:16:22 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
Subject: Re: t7527 intermittent failure on macOS APFS and possible fix
Message-ID: <YvbtVoP01fHF2ka3@danh.dev>
References: <YvZbGAf+82WtNXcJ@danh.dev>
 <xmqqmtc9baht.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmtc9baht.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-08-12 11:08:30-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > Running t7527 on macOS with encrypted APFS filesystem.
> > I observes intermittent failure, however, when I manually check the
> > test cases, they're all passed.
> >
> > I suspected fileystem caching issue.
> > I added those sync-s into test steps and the test pass.
> > I'm not sure if this is the intending "fix" for the tests
> > since we're testing the fsmonitor with t7527.
> >
> > Please advise!
> 
> fsmonitor experts, please do.
> 
> My gut feeling is that, unless the production code internally calls
> the equivalent of "sync" done here and the failure in tests are
> coming from the fact that the "sync" is missing in "test-tool
> fsmonitor-client" (i.e. test-tool does not emulate the real world
> closely enough and fails in cases where the machinery does not fail
> in the real world), these "sync" calls only sweep the problem under
> the rug.

It's my gut feeling, too.
Anyway, I'm running the test again, too confirm your suggestion on
t/helper/test-fsmonitor-client.c

t7527.63 (Unicode nfc/nfd) also failed intermittently, too.
Here is the content of unicode.trace:
---- 8< ----
$ cat unicode.trace
statfs('/path/to/src/git/t/trash directory.t7527-builtin-fsmonitor/test_unicode') [type 0x0000001a][flags 0x04909080] 'apfs'
statfs('/path/to/src/git/t/trash directory.t7527-builtin-fsmonitor/test_unicode') [type 0x0000001a][flags 0x04909080] 'apfs'
Watching: worktree '/path/to/src/git/t/trash directory.t7527-builtin-fsmonitor/test_unicode'
statfs('/path/to/src/git/t/trash directory.t7527-builtin-fsmonitor/test_unicode') [type 0x0000001a][flags 0x04909080] 'apfs'
requested token: quit
---------- >8 ------------------

> 
> > P/S: When debugging, I also found out that:
> > "test-tool fsmonitor-client query" doesn't write the final newline
> > character, thus making the output harder to read. The diff also have
> > the final newline added.
> >
> > ----- 8< -------
> > diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
> > index 54a4856c48..98d6cf1440 100644
> > --- a/t/helper/test-fsmonitor-client.c
> > +++ b/t/helper/test-fsmonitor-client.c
> > @@ -55,6 +55,7 @@ static int do_send_query(const char *token)
> >  
> >  	write_in_full(1, answer.buf, answer.len);
> >  	strbuf_release(&answer);
> > +	write_in_full(1, "\n", 1);
> >  
> >  	return 0;
> >  }
> > @@ -77,6 +78,7 @@ static int do_send_flush(void)
> >  
> >  	write_in_full(1, answer.buf, answer.len);
> >  	strbuf_release(&answer);
> > +	write_in_full(1, "\n", 1);
> >  
> >  	return 0;
> >  }
> 
> Aren't these protocol drivers?

The "answer" strbuf is the response from fsmonitor daemon, I think.
The write_in_full to fd 1 is test-tool writes down the answer to
stdout.

> If the protocol is defined without
> the trailing LF, would it make sense to update only the sending end
> to do this?  Or does the protocol makes it clear that a trailing LF,
> or lack of it, should be tolerated by all the implementations?
> 
> If we are absolutely sure that no implementation of the other side
> will get upset by seeing an extra LF, It would be fine, but as the
> original code wants to call write_in_full(), it would be more
> preferrable to do it this way instead, I suspect.
> 
> +	strbuf_complete(&answer, '\n');
> 	write_in_full(1, answer.buf, answer.len);
> 	strbuf_release(&answer);

This could work, since we don't send "answer" back to
fsmonitor-daemon.

-- 
Danh
