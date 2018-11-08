Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C111F453
	for <e@80x24.org>; Thu,  8 Nov 2018 01:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeKHKoE (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 05:44:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34184 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeKHKoD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 05:44:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id f1-v6so408560wmg.1
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 17:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vfmZx8nt8TnW+mhACL3JX6d+fW/fRjj17YFW1OC4bJA=;
        b=pK4njKh6XyXADQdszAEcAvqiaMzee0g5Z0wDYDn4r7cgZyvHxVSCox6wkhF6cpa1Pf
         KTdWdpdN0TcgX24tb14qFc9m492aUTxdss9H/nIEzZ3tPwaj3UsrwVjT88ElSyVu4uQp
         9zdAl2u0a4fvCor6CVk5MglQvVWthCcdZUTtRRSfIs7ipjlWjoDLWmqsroqn+KtNeB9d
         Cma4hy4Nu2XR4KTmTzhSdB1y9oFsVAWTGAb/7IUv851El4yNLWqLLPkKuIYiKRw4ZCEq
         DJ5YSoGka1tKB4ACtvT1P9T3E66JAztRNgb4j3egZdPZnE5M0u0DU82tJmLIZWP4ch+q
         VxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vfmZx8nt8TnW+mhACL3JX6d+fW/fRjj17YFW1OC4bJA=;
        b=cU5FoKRy2TaAv4Fonf4PKLLoRUMTy4FOuNKZhA3uiXlNfxirKFXB/dn1NxhOYXpkYI
         xMIKChq+gPvZkEHwtDrGLq9USupnUoh2HPD4RDF3mkqEEqhZDqZYDdqYgNs27+Pl0a22
         N9RR9bpX1D/K0WWuNuhoq4BTUjyI8NddgkJp2jAcbyc08WXMmRdJ4CjW4EuhymASK9lT
         VYBLecatwXXi7fssHcAGAxLteIRAMSg8gMdIyhqvd0ErxxopXBmIgc/ptVCjHgAuACrz
         0olmUsB5OLOqIgyimyx3Rqm5x0kDVV0jvp9s4w7m0EIWpisTdUFHdNT0I542z/1XWJBu
         X73A==
X-Gm-Message-State: AGRZ1gLG5O5/uAOZ+8J+Ln+Rb0uQvoKZIAI9GQMMpoa5ByhjB+npmFti
        X/3nXZRXrETY7IKBnJQKPB7AhkV/oMk=
X-Google-Smtp-Source: AJdET5edSACRnPlgrFsHdQeBte2B7Cab2/UDzVFWEG5w3oHXis++GaGncUpfQLXS3tVk6oRVmA3ZTQ==
X-Received: by 2002:a1c:e714:: with SMTP id e20-v6mr1830342wmh.83.1541639465034;
        Wed, 07 Nov 2018 17:11:05 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k3-v6sm4336628wro.9.2018.11.07.17.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 17:11:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     daniels@umanovskis.se, git@vger.kernel.org
Subject: Re: [PATCH] branch: make --show-current use already resolved HEAD
References: <20181025190421.15022-1-daniels@umanovskis.se>
        <20181107225619.6683-1-rafa.almas@gmail.com>
Date:   Thu, 08 Nov 2018 10:11:02 +0900
In-Reply-To: <20181107225619.6683-1-rafa.almas@gmail.com> ("Rafael
 =?utf-8?Q?Ascens=C3=A3o=22's?=
        message of "Wed, 7 Nov 2018 22:56:18 +0000")
Message-ID: <xmqqa7mk9xw9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascensão <rafa.almas@gmail.com> writes:

> print_current_branch_name() tries to resolve HEAD and die() when it
> doesn't resolve it successfully. But the conditions being tested are
> always unreachable because early in branch:cmd_branch() the same logic
> is performed.
>
> Eliminate the duplicate and unreachable code, and update the current
> logic to the more reliable check for the detached head.

Nice.

> I still think the mention about scripting should be removed from the
> original commit message, leaving it open to being taught other tricks
> like --verbose that aren't necessarily script-friendly.

I'd prefer to see scriptors avoid using "git branch", too.

Unlike end-user facing documentation where we promise "we do X and
will continue to do so because of Y" to the readers, the log message
is primarily for recording the original motivation of the change, so
that we can later learn "we did X back then because we thought Y".
When we want to revise X, we revisit if the reason Y is still valid.

So in that sense, the door to "break" the scriptability is still
open.

> But the main goal of this patch is to just bring some attention to this,
> as I mentioned it in a previous thread but it got lost.

This idea of yours seems to lead to a better implementation, and
indeed "got lost" is a good way to describe what happened---I do not
recall seeing it, for example.  Thanks for bringing it back.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 46f91dc06d..1c51d0a8ca 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -38,6 +38,7 @@ static const char * const builtin_branch_usage[] = {
>  
>  static const char *head;
>  static struct object_id head_oid;
> +static int head_flags = 0;

You've eliminated the "now unnecessary" helper and do everything
inside cmd_branch(), so perhaps this can be made function local, no?

> @@ -668,10 +654,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  
>  	track = git_branch_track;
>  
> -	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
> +	head = resolve_refdup("HEAD", 0, &head_oid, &head_flags);
>  	if (!head)
>  		die(_("Failed to resolve HEAD as a valid ref."));
> -	if (!strcmp(head, "HEAD"))
> +	if (!(head_flags & REF_ISSYMREF))
>  		filter.detached = 1;

Nice to see we can reuse the resolve_refdup() we already have.

>  	else if (!skip_prefix(head, "refs/heads/", &head))
>  		die(_("HEAD not found below refs/heads!"));
> @@ -716,7 +702,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  			die(_("branch name required"));
>  		return delete_branches(argc, argv, delete > 1, filter.kind, quiet);
>  	} else if (show_current) {
> -		print_current_branch_name();
> +		if (!filter.detached)
> +			puts(head);

Ah, I wondered why we do not have to skip-prefix, but it is already
done for us when we validated that an attached HEAD points at a
local branch.  Good.

>  		return 0;
>  	} else if (list) {
>  		/*  git branch --local also shows HEAD when it is detached */
