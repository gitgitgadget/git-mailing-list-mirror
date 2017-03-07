Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF4E21FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 23:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756524AbdCGXna (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 18:43:30 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35364 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756589AbdCGXna (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 18:43:30 -0500
Received: by mail-pg0-f50.google.com with SMTP id b129so6000146pgc.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 15:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JjQsXUajEwIi6x9oh/RlX/6vPZCFKoDshYyo2FMTvu8=;
        b=KkNucuYrfq3XaLGLgf0Ak+zJpdaEBT1qNvqsChlferKsgFSYAGW3r1X4kTfF+vtsZH
         Q6YPUCBaVSvpOud85J/JYQT1FJmpSh8vdTDBpB+xGmrd9off0oDzuLza9VW5q0zp0u/d
         LnSba3rwk14BJo6IRl+Fj9ocHUV2eCasjxk9j4tP5sIv0mCcqluDICinBAIuG4TvM2XQ
         /fJ7yDglvvX0BnEEWv6tIXi4WkqCI9QC0aLS6BLnmaK4iJgIQ+GaBhFV8mMXyHE41HPy
         tgwsIFTGWq4VAIUaXSG0T3E+pIK8QQqiXacLC8TLmO2zNjSTBfQZmoNKbNdpmkqs/Vs6
         sWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JjQsXUajEwIi6x9oh/RlX/6vPZCFKoDshYyo2FMTvu8=;
        b=LwIA0M5F/e6cPv+znRoKYEz05oIoGnB3tHGeZNYfCDiU8C6R94847Ha36fhaD+xUND
         KiR/8x8gSZNmiCeaDS04Jbg310KQpj03p8l/Z+HsiSmuKax9/X7zLRoH+sJ/lndTfMLC
         mIwN6oz2/3BwlwneMoVJpSNbkOB2UpVGkvRa6ktbBbDyW2NKWwKs/0mhJUpCfkGc5CgO
         Lgiksm0YnjrVssSLkuUZ0pc8S7pmiTL5FthApWSI0STRFubem95jTR5qark9x2KnkbHu
         T4HYSmv9BhpOoJ0b08yGU/x2N4hcWGnf33fozCnE02PRyBur7xh1rspaPrA9O2PocpRh
         8aTw==
X-Gm-Message-State: AMke39nXyiblD6IXY/sAQODgTTEpgAMJ0c6lHVluu21ZQNkUUM+wonOIhovu+jzK+zHrusgd
X-Received: by 10.98.63.24 with SMTP id m24mr3331285pfa.143.1488929751605;
        Tue, 07 Mar 2017 15:35:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:2547:c8c9:5d3e:d641])
        by smtp.gmail.com with ESMTPSA id q64sm1870335pga.0.2017.03.07.15.35.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Mar 2017 15:35:50 -0800 (PST)
Date:   Tue, 7 Mar 2017 15:35:49 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 04/10] setup_git_directory_1(): avoid changing global
 state
Message-ID: <20170307233549.GA128647@google.com>
References: <cover.1488562287.git.johannes.schindelin@gmx.de>
 <cover.1488897111.git.johannes.schindelin@gmx.de>
 <2c8ab22700fb40c9e4e9b46f4981b45db7f2dcf2.1488897111.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8ab22700fb40c9e4e9b46f4981b45db7f2dcf2.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/07, Johannes Schindelin wrote:
>  const char *setup_git_directory_gently(int *nongit_ok)
>  {
> +	struct strbuf cwd = STRBUF_INIT, dir = STRBUF_INIT, gitdir = STRBUF_INIT;

I couldn't see any strbuf_release() calls for these strbufs so there may
be some memory leaking here.

>  	const char *prefix;
>  
> -	prefix = setup_git_directory_gently_1(nongit_ok);
> +	/*
> +	 * We may have read an incomplete configuration before
> +	 * setting-up the git directory. If so, clear the cache so
> +	 * that the next queries to the configuration reload complete
> +	 * configuration (including the per-repo config file that we
> +	 * ignored previously).
> +	 */
> +	git_config_clear();
> +
> +	/*
> +	 * Let's assume that we are in a git repository.
> +	 * If it turns out later that we are somewhere else, the value will be
> +	 * updated accordingly.
> +	 */
> +	if (nongit_ok)
> +		*nongit_ok = 0;
> +
> +	if (strbuf_getcwd(&cwd))
> +		die_errno(_("Unable to read current working directory"));
> +	strbuf_addbuf(&dir, &cwd);
> +
> +	switch (setup_git_directory_gently_1(&dir, &gitdir)) {
> +	case GIT_DIR_NONE:
> +		prefix = NULL;
> +		break;
> +	case GIT_DIR_EXPLICIT:
> +		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, nongit_ok);
> +		break;
> +	case GIT_DIR_DISCOVERED:
> +		if (dir.len < cwd.len && chdir(dir.buf))
> +			die(_("Cannot change to '%s'"), dir.buf);
> +		prefix = setup_discovered_git_dir(gitdir.buf, &cwd, dir.len,
> +						  nongit_ok);
> +		break;
> +	case GIT_DIR_BARE:
> +		if (dir.len < cwd.len && chdir(dir.buf))
> +			die(_("Cannot change to '%s'"), dir.buf);
> +		prefix = setup_bare_git_dir(&cwd, dir.len, nongit_ok);
> +		break;
> +	case GIT_DIR_HIT_CEILING:
> +		prefix = setup_nongit(cwd.buf, nongit_ok);
> +		break;
> +	case GIT_DIR_HIT_MOUNT_POINT:
> +		if (nongit_ok) {
> +			*nongit_ok = 1;
> +			return NULL;
> +		}
> +		die(_("Not a git repository (or any parent up to mount point %s)\n"
> +		      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
> +		    dir.buf);
> +	default:
> +		die("BUG: unhandled setup_git_directory_1() result");
> +	}
> +
>  	if (prefix)
>  		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
>  	else
> -- 
> 2.12.0.windows.1.7.g94dafc3b124
> 
> 

-- 
Brandon Williams
