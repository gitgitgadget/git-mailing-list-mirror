Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6781A1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 17:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfA2Rjs (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 12:39:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46341 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfA2Rjs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 12:39:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so22983694wrt.13
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 09:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=h+ifemftFeCBVippVuSMekOFGyuHoDVAvZQ/geGC9yc=;
        b=V78wjIa7YCKx/FCwnClXeBYxEjk3i2rABp9rDgn4U5jYHsftCSenUZmkm2RmsNQhP7
         E9qkdeuoF1wijT4nct6QM2XxnMD9NFUeVTA278+ZDDzYhjtLOBNnpaXToLamTciXF8Ov
         QCvNdtEq1O/g8L6dD54J4gQxf0iNUT5xRt4lsSBQWjQAc/dZ+sHAB2uohtSpto1xxry4
         4hfG4OjCtm8Z/G96cF0zp4RTTyleJ8nKE7w502BniJfg9bLRy5r+UwguEHN9r9uA4nV6
         lBbJnCDwfHf4P5RphwEpAiRFhfRgDPSNv2Zzqxao0jwWD3egQCJNM3WLRC+t5CbxqAUV
         7UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=h+ifemftFeCBVippVuSMekOFGyuHoDVAvZQ/geGC9yc=;
        b=UU0p7TE0yfqNhkjVcmu0b5Ql0LYIpM7V9Z2zq0z4UBqrEyQHyU5KV0xixP38RElZ52
         jcLT+El8/UtB579P7KZ2mae8tQ1FXs3aZ9M13mFs29X/XjEa+KorvOf7wPNqEeTIzyW/
         TX2ez6Iaw/x5SpBUkKs7UvaIkgSDy8z7IDbRwt7eW4LS2GmVytrVQkFiVVQegCtJ7gR7
         GZnUeh8q+rSLgz+5W0SHi+3EmLYTgUD74AjVhb9HHkoAb57cwtSTPhLOXUYJkozhtbhC
         q0lX/FnPiw2HbFdSsCRDVcvjJQWIHEAb9BwucfxQvFLVMlpYz1pNjA5T9QBKUYX62stZ
         545g==
X-Gm-Message-State: AJcUukdduece5HttoheKwsv+n+59sKKNE/Y9Wpemui4m9jIgLaYl/Qi6
        JqYoL+/I75JXYNHkTlkXhQc=
X-Google-Smtp-Source: ALg8bN5n2ITW9PsJxIKZv+as8mowGjpYi5sKIHkGpkmAyFcX/Lyy24Tvfqh6o1cbz8ijKNgiH9k/8g==
X-Received: by 2002:adf:e9d1:: with SMTP id l17mr25107414wrn.73.1548783585995;
        Tue, 29 Jan 2019 09:39:45 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m6sm90777364wrv.24.2019.01.29.09.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 09:39:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sebastian Staudt <koraktor@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/3] Setup working tree in describe
References: <20190129051859.12830-1-koraktor@gmail.com>
        <20190129051859.12830-2-koraktor@gmail.com>
        <20190129131151.GB22211@sigill.intra.peff.net>
Date:   Tue, 29 Jan 2019 09:39:44 -0800
In-Reply-To: <20190129131151.GB22211@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 29 Jan 2019 08:11:51 -0500")
Message-ID: <xmqqr2cv8isf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 29, 2019 at 06:18:58AM +0100, Sebastian Staudt wrote:
>
>> Subject: Re: [PATCH v3 2/3] Setup working tree in describe
>
> We usually write subjects as "area: do some thing" which is a little
> easier when scanning big lists of "git log --oneline".
>
> I think it's key, too, that we only do this for the --dirty case, not
> always. So maybe:
>
>   describe: setup working tree for --dirty
>
> or something?

Thanks as always for being an excellent reviewer who not just
reviews but also gives good suggestions.

>> This ensures the given working tree is used for --dirty.
>
> There's been a lot of digging and discussion on the list about what
> happens if we don't do this. Could we summarize it here?
>
> Perhaps:
>
>   We don't use NEED_WORK_TREE when running the git-describe builtin,
>   since you should be able to describe a commit even in a bare
>   repository. However, the --dirty flag does need a working tree. Since
>   we don't call setup_work_tree(), it uses whatever directory we happen
>   to be in. That's unlikely to match our index, meaning we'd say "dirty"
>   even when the real working tree is clean.
>
>   We can fix that by calling setup_work_tree() once we know that the
>   user has asked for --dirty.
>
>> The implementation of --broken uses diff-index which calls
>> setup_work_tree() itself.
>
> If I hadn't just read the rest of the thread, I'd probably wonder why we
> are talking about --broken at all. Maybe:
>
>   The --broken option similarly needs a working tree. But because the
>   current implementation calls an external diff-index to do the work,
>   we don't have to bother setting up the working tree in the
>   git-describe process.
>
>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index cc118448ee..b5b7abdc8f 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> @@ -629,6 +629,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>>  			struct argv_array args = ARGV_ARRAY_INIT;
>>  			int fd, result;
>>  
>> +			setup_work_tree();
>>  			read_cache();
>>  			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
>>  				      NULL, NULL, NULL);
>
> The patch itself looks good. :)
>
> -Peff
