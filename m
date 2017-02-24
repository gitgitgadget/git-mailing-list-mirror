Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E31E201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdBXU1B (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:27:01 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36063 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXU1A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:27:00 -0500
Received: by mail-pg0-f66.google.com with SMTP id z128so4240860pgb.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 12:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oG4Wgr6/qnvs8N4YLbJVm8gLbfr5Rh9iXOMCIqFC0II=;
        b=tRKMTMWiFr63ngP92tgQcqUsE6nNZsmIDzFtIfMemHyqXDIJc7n4rOWAPecQIH0HCw
         j9VPGlON65B/3XJzzbgTY2h1WtKMYfeXMoFzV/6Na/mYpZ0u09yyW/nFAagkNn8JklhH
         XiFs/0XkZRj03VEYaY+Loo8AP9fcyHxtepDKiQMY8NVe2PfLSzIPR/wE7GNlaWXZ34sV
         BRenSCDsm6qvr9TctNgGnobVjPjlHMQqDInHahW5BDnkxFdX1cenUy8L9OjGl5HqYf+l
         KU4lruX8lXSrLzUiXxpqfpOuSWz1Xcs6rN4GyVikWgfmqEvpB001gso2OYgWR84TA/8I
         FuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oG4Wgr6/qnvs8N4YLbJVm8gLbfr5Rh9iXOMCIqFC0II=;
        b=TGvVaMyy5q5T4RyVH+fukbbftVLa7httx+8uZrvmt7eKzZgbYsNaiAffh84AATaXXp
         d9tQXGdjY2JIqt5N8KHoZfZSzeIYje3agvKhu1xWyAfRyBf+cU2QYJu34zCzopvhEdED
         u0o2du54txlsi0MYQ+Hpui8fE5jaWnvKK952RV1nBo5b8h26pwSvD6CRD8R4JptPhEN2
         +wz84lm8Rh+wEgBYR7VQsimMOoI4qbAGtGdjeEWO2oRte197cqC1SGs+EGNYXfgKIqQ/
         +L6rKl/faRRfgQ9mV19i4RzFHbcN3fMcHiU9s1K7qs9gcVpdjs1CBpZBOPaeO64rC/Mw
         3DZw==
X-Gm-Message-State: AMke39l+jkqeAti2g5nMa5DmX2j9WT2bbZENSTkSmcpzSjWkBS19mot+1CKuom0ruLxt+A==
X-Received: by 10.99.163.81 with SMTP id v17mr5616401pgn.39.1487967599058;
        Fri, 24 Feb 2017 12:19:59 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id z4sm16652177pge.49.2017.02.24.12.19.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 12:19:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     j6t@kdbg.org, git@vger.kernel.org, philipoakley@iee.org,
        sop@google.com
Subject: Re: [PATCH] submodule init: warn about falling back to a local path
References: <ae377bda-0776-f98b-5b6f-afa198647400@kdbg.org>
        <20170224182237.3696-1-sbeller@google.com>
Date:   Fri, 24 Feb 2017 12:19:57 -0800
In-Reply-To: <20170224182237.3696-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 24 Feb 2017 10:22:37 -0800")
Message-ID: <xmqqlgsv1guq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When a submodule is initialized, the config variable 'submodule.<name>.url'
> is set depending on the value of the same variable in the .gitmodules
> file. When the URL indicates to be relative, then the url is computed
> relative to its default remote. The default remote cannot be determined
> accurately in all cases, such that it falls back to 'origin'.
>
> The 'origin' remote may not exist, though. In that case we give up looking
> for a suitable remote and we'll just assume it to be a local relative path.

IOW we keep the .url to be relative, the same as the original one we
took from .gitmodules?  That sounds like a sensible thing to do and
I agree it makes sense to warn when it happens.

>  <repository> is the URL of the new submodule's origin repository.
>  This may be either an absolute URL, or (if it begins with ./
> -or ../), the location relative to the superproject's origin
> +or ../), the location relative to the superproject's default remote
>  repository (Please note that to specify a repository 'foo.git'
>  which is located right next to a superproject 'bar.git', you'll
>  have to use '../foo.git' instead of './foo.git' - as one might expect
>  when following the rules for relative URLs - because the evaluation
>  of relative URLs in Git is identical to that of relative directories).
> -If the superproject doesn't have an origin configured
> ++
> +The default remote is the remote of the remote tracking branch
> +of the current branch. If no such remote tracking branch exists or
> +the HEAD is detached, "origin" is assumed to be the default remote.
> +If the superproject doesn't have a default remote configured

OK.

> @@ -118,18 +122,22 @@ too (and can also report changes to a submodule's work tree).
>  
>  init [--] [<path>...]::
>  	Initialize the submodules recorded in the index (which were
> -	added and committed elsewhere) by copying submodule
> -	names and urls from .gitmodules to .git/config.
> -	Optional <path> arguments limit which submodules will be initialized.
> -	It will also copy the value of `submodule.$name.update` into
> -	.git/config.
> -	The key used in .git/config is `submodule.$name.url`.
> -	This command does not alter existing information in .git/config.
> -	You can then customize the submodule clone URLs in .git/config
> -	for your local setup and proceed to `git submodule update`;
> -	you can also just use `git submodule update --init` without
> -	the explicit 'init' step if you do not intend to customize
> -	any submodule locations.
> +	added and committed elsewhere) by copying `submodule.$name.url`
> +	from .gitmodules to .git/config, resolving relative urls to be
> +	relative to the default remote.

I read this as "copying..., resolving relative to the default remote
(if exists)."  A reader would wonder what happens if the default
remote does not exist---don't we want to describe what happens in
that case, like, "recording . (the current repository) as the
upstream" or something?

> ++
> +Optional <path> arguments limit which submodules will be initialized.
> +If no path is specified all submodules are initialized.

Perhaps s/ all submodules/,&/?

>  deinit [-f|--force] (--all|[--] <path>...)::
>  	Unregister the given submodules, i.e. remove the whole
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 899dc334e3..15a5430c00 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -356,12 +356,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  			strbuf_addf(&remotesb, "remote.%s.url", remote);
>  			free(remote);
>  
> -			if (git_config_get_string(remotesb.buf, &remoteurl))
> -				/*
> -				 * The repository is its own
> -				 * authoritative upstream
> -				 */
> +			if (git_config_get_string(remotesb.buf, &remoteurl)) {
> +				warning(_("could not lookup configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);

Sounds sensible (it might be a bit too long but it should be OK).

>  				remoteurl = xgetcwd();
> +			}
>  			relurl = relative_url(remoteurl, url, NULL);
>  			strbuf_release(&remotesb);
>  			free(remoteurl);

Thanks.
