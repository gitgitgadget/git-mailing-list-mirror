Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E281F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfAQUNQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:13:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52600 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbfAQUNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:13:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so2407023wml.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b9sZUxMxylM9b6GDnxy+VEtPHspcTE1mnkQMgHs77fA=;
        b=WCOqjzZQo0zshHC1Vj8njOqAJatsT0S/jUjESiYXQpWgV9iYRGZ4/i3RjAENgIrDNm
         /XZeYJ9TKkWXoj61pksZxHiC+3BjRT2QUft+QjwFVbE1rgOH3rJGNE50LGj2nAIpiQZC
         Ix442OjawJVGjY9EyW28Sllbp4264TOrwRAcEJmqUG08Si7uTNoM/gZ4qx8wQmwWKNtu
         YL1fTtufiMNmPGvRVpWFl18zOqKZrzSlwirjNxk2PZ6evYmJ7Xi0KLlIyyhxjjyppgAl
         7EmlhdKfvR0PoCYDvzlPUW7eT/qZlp8O+8KSIIw0S771gUcKo2dsmCduFQPQxJwve8zG
         Cpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b9sZUxMxylM9b6GDnxy+VEtPHspcTE1mnkQMgHs77fA=;
        b=Bc0//b08v7S6HhWiUfZMzwkFAPubhKEQvc0Y17gkYKITyc9uJYX/7aVfUzoux6Vndq
         iGW/8w4zRzFfJG76QaG6A0raW3SALujceK1UWORLyLl91nVF62zTTEGPsFvQY03cr0br
         xnI4eU4yRtKG+5+GHo53C6OWzFkA+hoDOeLkWFi90f+q/sZk4nfqClaPKEl34NpfI4pJ
         iyg5DwftrV3CEYafdo167ulGszB55WdLwOTPfCvKv9iPgOW2PNPAqBCbzZm2OyT/rf9P
         bFLT86yPQiWc4UkfPLIn4zLiU+EwQgXfox9zyQvnfq8lQdDtEUFm/i2yAt7H2dpf3kHH
         5NcQ==
X-Gm-Message-State: AJcUukdlF5D3JeUoI3cX66cx72NhULI31IFun2pJFAI2OHcKLAZi0EGx
        zHl7PKpDZKpL9DPlZW0ALPA=
X-Google-Smtp-Source: ALg8bN7lt/+fRC3CVAAAKrRNmp+wABeTfm21ECKZDybfqV90ZcuW8w7MtzMocApQhDPtesKG6DfpOA==
X-Received: by 2002:a1c:c64e:: with SMTP id w75mr13859544wmf.46.1547755993239;
        Thu, 17 Jan 2019 12:13:13 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 199sm44387829wmh.21.2019.01.17.12.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:13:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH/RFC] fsck: complain when .gitignore and .gitattributes are symlinks
References: <20190114230902.GG162110@google.com>
        <20190117170005.GA27667@sigill.intra.peff.net>
Date:   Thu, 17 Jan 2019 12:13:12 -0800
In-Reply-To: <20190117170005.GA27667@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 17 Jan 2019 12:00:06 -0500")
Message-ID: <xmqq1s5bniuf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm. I think this commit message isn't quite right, because we also
> skipped the patches to touch gitignore/gitattributes in verify_path().
>
> Are you thinking we should resurrect that behavior[1], too, or just
> protect at the fsck level?
>
>> It was omitted from that series because it does not address any known
>> exploit, but to me it seems worthwhile anyway:
>> 
>> - if a client enables transfer.fsckObjects, this helps them protect
>>   themselves against weird input that does *not* have a known exploit
>>   attached, to
>> 
>> - it generally feels more simple and robust.  Git-related tools can
>>   benefit from this kind of check as an indication of input they can
>>   bail out on instead of trying to support.
>
> I think I may just be restating your two points above, but what I'd
> argue is:
>
>   - even though there's no known-interesting exploit, this can cause Git
>     to unexpectedly read arbitrary files outside of the repository
>     directory. That in itself isn't necessarily evil, but it's weird.
>
>   - there are potentially non-malicious bugs here, where we try to read
>     .gitattributes out of the index, but obviously don't follow symlinks
>     there

FWIW, you two can count me as the third person who agrees with the
above points.

> [1] This wasn't a separate patch, but just an early iteration of the
>     "ban symlinks in .gitmodules" patch. I think the incremental is
>     just:
>
> diff --git a/read-cache.c b/read-cache.c
> index bfff271a3d..121c0bec69 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -937,7 +937,9 @@ static int verify_dotfile(const char *rest, unsigned mode)
>  			return 0;
>  		if (S_ISLNK(mode)) {
>  			rest += 3;
> -			if (skip_iprefix(rest, "modules", &rest) &&
> +			if ((skip_iprefix(rest, "modules", &rest) ||
> +			     skip_iprefix(rest, "ignore", &rest) ||
> +			     skip_iprefix(rest, "attributes", &rest)) &&
>  			    (*rest == '\0' || is_dir_sep(*rest)))
>  				return 0;
>  		}

OK.

> @@ -966,7 +968,9 @@ int verify_path(const char *path, unsigned mode)
>  				if (is_hfs_dotgit(path))
>  					return 0;
>  				if (S_ISLNK(mode)) {
> -					if (is_hfs_dotgitmodules(path))
> +					if (is_hfs_dotgitmodules(path) ||
> +					    is_hfs_dotgitignore(path) ||
> +					    is_hfs_dotgitattributes(path))
>  						return 0;
>  				}
>  			}
> @@ -974,7 +978,9 @@ int verify_path(const char *path, unsigned mode)
>  				if (is_ntfs_dotgit(path))
>  					return 0;
>  				if (S_ISLNK(mode)) {
> -					if (is_ntfs_dotgitmodules(path))
> +					if (is_ntfs_dotgitmodules(path) ||
> +					    is_ntfs_dotgitignore(path) ||
> +					    is_ntfs_dotgitattributes(path))
>  						return 0;

Curious that we already have these helpers, nobody seems to call
them in the current codebase, and we haven't seen the "these are
unused" linter message on the list for a while ;-).


