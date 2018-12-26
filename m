Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12DED211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 21:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeLZVWE (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 16:22:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53510 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbeLZVWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 16:22:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so15322704wmb.3
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 13:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yOgeCWtIR85SljVyOoAs2MspTG/xCx67/6BXMsK+r/M=;
        b=WoyfKV550Fz6Fw+hXjZywxkLVvLdNw2QJI8YwwCj9f6A247oUL9+VUslYgHDGViX/0
         lKJKrEcMpYc9MiRG+/hTd67zfblwMmib2J/zZ/99lyDWo/xiRDEC+ByBHzdNrnMw/0yO
         HGalr3kNbJ9Yj/hO1T1PN+A5R56sKgi8HLswxB6ye31VG03tDWqW4OxZ3ZTVoT9IsTXX
         Tsf72ymAUch8OTUyHhCwSXSD3A9lvp/j9KiVtDFmsMabkNIusptRxjglOBFDP5stgyhn
         Qbw6Ldrt0DUfQdLOToFFaYGWwDCa2gNJPAXGUgAhVngqVs1gKmXomTyZP/6/NQ/Gh8yD
         ricg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yOgeCWtIR85SljVyOoAs2MspTG/xCx67/6BXMsK+r/M=;
        b=r4sKNP3TqPiKJwn6mB/Qsf+2BzorIuai55LoFAhkrhP47HFuHRFIROmO8R3/RHU+1Q
         m4hrRSmDbOVeN4bLiN9ChSsmKaPNi8PHBBsFIrE2zSw84v6JkB22M3jSs+xMurqV0TSG
         9nIYKplrVy0DIuVtIPDYl4bYtOkixdbIY+o8YhnvsONQiq44VbymgVOsvcS+PET8k7X1
         WIC43zzuejyD4PDf3lG3Wtj+qjS5RckbtIeAdghAtjCXnyGLsZ0V1mD1SIzKAJLQS3Nc
         UdaApWkDOr0GADEx+AXFROmor0addso9+H5ZxuZNSp7wjQGIJ0LSrIXUagPoBHA8fiPp
         Jx2w==
X-Gm-Message-State: AJcUukd55xF4u1X3soMHBR0eta9N+dZpiDFpMcqftkYsRKBLkOjuQB2D
        b0gqdWdcf1grEVSDIDohwdY=
X-Google-Smtp-Source: AFSGD/X/uvsrKhwEUJiEhvQOei3lAee9eUY3wlSvKoP68edsUrMgjuaJ6wBNmznioryJpk+/B/6jSQ==
X-Received: by 2002:a1c:6489:: with SMTP id y131mr18802348wmb.34.1545859321086;
        Wed, 26 Dec 2018 13:22:01 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y34sm81453070wrd.68.2018.12.26.13.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 13:21:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v12 04/26] ident: add the ability to provide a "fallback identity"
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
        <57a654887e652251ae966ec31b4604dc8222f9c6.1545331726.git.ungureanupaulsebastian@gmail.com>
Date:   Wed, 26 Dec 2018 13:21:59 -0800
In-Reply-To: <57a654887e652251ae966ec31b4604dc8222f9c6.1545331726.git.ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Thu, 20 Dec 2018 21:44:20
        +0200")
Message-ID: <xmqqpntoq8zs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> +static void set_env_if(const char *key, const char *value, int *given, int bit)
> +{
> +	if ((*given & bit) || getenv(key))
> +		return; /* nothing to do */
> +	setenv(key, value, 0);
> +	*given |= bit;
> +}

We call setenv(3) with overwrite=0 but we protect the call with a
check for existing value with getenv(3), which feels a bit like an
anti-pattern.  Wouldn't the following be simpler to follow, I wonder?

	if (!(*given & bit)) {
		setenv(key, value, 1);
		*given |= bit;
	}

The only case these two may behave differently is when '*given' does
not have the 'bit' set but the environment 'key' already exists.
The proposed patch will leave 'bit' in '*given' unset, so when a
later code says "let's see if author_ident is explicitly given, and
complain otherwise", such a check will trigger and cause complaint.

On the other hand, the simplified version does not allow the
"explicitly-given" bits to be left unset, so it won't cause
complaint.

Isn't it a BUG() if *given lacks 'bit' when the corresponding
environment variable 'key' is missing?  IOW, I would understand
an implementation that is more elaborate than the simplified one I
just gave above were something like

	if (!(*given & bit)) {
		if (getenv(key))
			BUG("why does %s exist and no %x bit set???", key, bit);
		setenv(key, value, 0);
		*given |= bit;
	}

but I do not quite understand the reasoning behind the "check either
the bit, or the environment variable" in the proposed patch.

> +void prepare_fallback_ident(const char *name, const char *email)
> +{
> +	set_env_if("GIT_AUTHOR_NAME", name,
> +		   &author_ident_explicitly_given, IDENT_NAME_GIVEN);
> +	set_env_if("GIT_AUTHOR_EMAIL", email,
> +		   &author_ident_explicitly_given, IDENT_MAIL_GIVEN);
> +	set_env_if("GIT_COMMITTER_NAME", name,
> +		   &committer_ident_explicitly_given, IDENT_NAME_GIVEN);
> +	set_env_if("GIT_COMMITTER_EMAIL", email,
> +		   &committer_ident_explicitly_given, IDENT_MAIL_GIVEN);
> +}

Introducing this function alone without a caller and without
function doc is a bit unfriendly to future callers, who must be
careful when to call it, I think.  For example, they must know that
it will be a disaster if they call this before they call
git_ident_config(), right?

> +
>  static int buf_cmp(const char *a_begin, const char *a_end,
>  		   const char *b_begin, const char *b_end)
>  {


