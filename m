Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D6AC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 09:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbiDAJ3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 05:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbiDAJ3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 05:29:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBB426A966
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 02:27:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id pv16so4722552ejb.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3jVxDd/01H77coZZDph0lfkgFrD0d0OE3bGNGP0Xq50=;
        b=UlxHyXv2Od7N5QB0pGJ1EbN112rTEdtdIm5BQr/WaAUNvCJCXdHkKzBX6TxRYvaTKR
         XMFkM6Rb8cSOG+AnMCQ4VGrH1qM6vnCTLqjoYwAoL8uQEGqChICl+OSJvdL4tbIw60G+
         IThFpMGK5PUqD+UpGGe0ehqRpX+xj+59mVw8p6qY12KjKtb4IBpLZO+w9GgUGaVT5vNA
         w6s6rSum+x0qXt2aiAUVFYOH+HLqI8sFIQYIKc3vGgeQMlYPGSN9iDS4h9k2uNOBBgRP
         INYmB+jraO37qQ6S1iIE2dmO/lHvEBe73WSQccKqlecQuCYhxCvUa1/f5tgWlRCRB1Pc
         ORAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3jVxDd/01H77coZZDph0lfkgFrD0d0OE3bGNGP0Xq50=;
        b=X9/AAkWIi85+rYIx9U4mAuXQBao7RBk6T/t8G3yLg5jTZBURvSpA0FJSRVIKe0fo8E
         kcRt+of9vzMA/4uZcpfgvYdAj095keiu+WSS75FAubgIGTNFypjwFQsW/edh78pEDdzf
         ZWZdcg25eWYKne3WVA90gnMEdFru3EaJnq3SVZ1immTP9A45EEcnKy+ApOqhxiPMcJ/P
         /SHrpT2YX0K7zc8M7sWM4MGqq5lqFh8D8edVN30rt6Mpa0EesErVNzQKXb89SAIqjErj
         upQYugIKNBLzm+rcJxaqGZiyofFZ/qiA+1CYaL1TdpIyKlOM4gqjFIVidQu6sM3r3uU1
         kKYg==
X-Gm-Message-State: AOAM533tJjQQMa+Wyse4anuT8/MMwonvvtFwSi/b6XgfyKIW8ypU31r+
        xLxGZqtR59slTsepiVCLe5s=
X-Google-Smtp-Source: ABdhPJw3xyyXBkkXRIdG94+64Y6KQ8NUiAHSfe40jWX39kERUL7aozHLZNAZqcd1iUlypGuPB1bnQQ==
X-Received: by 2002:a17:907:6e0d:b0:6e0:59ae:21f1 with SMTP id sd13-20020a1709076e0d00b006e059ae21f1mr8823270ejc.362.1648805273963;
        Fri, 01 Apr 2022 02:27:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906161800b006d420027b63sm823079ejd.18.2022.04.01.02.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 02:27:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naDZQ-000zBt-Q3;
        Fri, 01 Apr 2022 11:27:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Garrit Franke <garrit@slashdev.space>, git@vger.kernel.org,
        Taylor Blau <ttaylorr@github.com>
Subject: Re: [PATCH v2] cli: add -v and -h shorthands
Date:   Fri, 01 Apr 2022 11:23:39 +0200
References: <20220330190956.21447-1-garrit@slashdev.space>
 <xmqq5ynv6rb4.fsf@gitster.g>
 <fb915b91-ead2-ac35-4431-ad35674da463@slashdev.space>
 <220331.86tubfrngz.gmgdl@evledraar.gmail.com>
 <f3935840-e2a0-953e-0e7c-ac921d414ddc@slashdev.space>
 <xmqqsfqx28dv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqsfqx28dv.fsf@gitster.g>
Message-ID: <220401.86y20pnofb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, Junio C Hamano wrote:

> Garrit Franke <garrit@slashdev.space> writes:
>
>> On 31.03.22 02:07, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> I think this is a good trade-off in this case. I.e. -v and -h are
>>> commonly understood.
>>
>> An interesting observation I just made is that curl [0] uses both
>> "--verbose" and "--version" on the top level [1][2] including
>> shorthands. "-v" corresponds to "verbose", "-V" corresponds to
>> "version.
>>
>> Not that I'm a fan of this clutter, but it's a possible path to go
>> down if we actually needed a second shorthand using this letter.
>
> Do you mean you want to use "-V" for version, instead of the "-v"
> used in the patch, so that "-v" can be left for "--verbose"?
>
> I am not sure consistency with whom we are aiming for anymore with
> that mixed to the proposal X-<.

Maybe you've been convinced to accept -v and -h (I don't care much
either way, honestly), but if not I wonder if this alternate approach
would make everyone in this thread happy (or at least mostly so):

diff --git a/git.c b/git.c
index a25940d72e8..929faa12537 100644
--- a/git.c
+++ b/git.c
@@ -323,7 +323,12 @@ static int handle_options(const char ***argv, int *arg=
c, int *envchanged)
 				exit(list_cmds(cmd));
 			}
 		} else {
-			fprintf(stderr, _("unknown option: %s\n"), cmd);
+			if (!strcmp(cmd, "-h"))
+				fprintf(stderr, _("unknown option: %s, did you mean --help?\n"), cmd);
+			else if (!strcmp(cmd, "-v"))
+				fprintf(stderr, _("unknown option: %s, did you mean --version?\n"), cm=
d);
+			else
+				fprintf(stderr, _("unknown option: %s\n"), cmd);
 			usage(git_usage_string);
 		}

(Better to pass those as a parameter to the translation, but it's just a
throwaway demo patch for discussion)

I.e. we could help the user in these cases by suggesting that they may
have meant --help or --version, while still leaving the door open to
using these short options for something else.

In git.c we don't use parse-options.c, but that might be a useful
addition for it in general. I.e. to allow an option to define a list of
known alternative (but not understood!) aliases for itself.

So for the cases where we're about to emit an error about -v or whatever
anyway, we could be a bit more helpful and suggest --version, even if we
didn't want to define that as a short option for whatever reason.
