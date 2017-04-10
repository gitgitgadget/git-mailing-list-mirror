Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827EE20970
	for <e@80x24.org>; Mon, 10 Apr 2017 10:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbdDJKLa (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 06:11:30 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33489 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbdDJKL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 06:11:29 -0400
Received: by mail-pg0-f67.google.com with SMTP id 79so25204427pgf.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 03:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PKqDV7gtUHFbLLUBUI8wqLKgI4HS1gI1mhqnWWYThQs=;
        b=C27sTvuES9i/7oHdjGetnRLAZGJXJdxBAGaGYZtA6gAbmsi95BmNWARs5WV/oJ8iDe
         jgxObx2qsbG0foVewLI5YBc1ocZ1G+lgUHrB2j9MLLO5/2MCtVnn0H9EDbacV/SHt6hl
         FXPOHD/Llk0tMgXRz+1a1/jMqdwTskdILblMY7D2WwP1FCqf2H5Ukz5dx8uSQbcS2jRU
         zzbB3pwkCOiCyq0qm7VSFa2BE9R+DLdYlQYbISG7cGW3WpsrBiGk9q64/Pb22Ws2/Xad
         WyClkcEAzQiUbatbv/+I39j+nXGAil1/uZepuZNpOpksASjH81pdQFVGJ89fX5Pa62kV
         3OLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PKqDV7gtUHFbLLUBUI8wqLKgI4HS1gI1mhqnWWYThQs=;
        b=QIfVBc/NDRq8UKuSFyySARw0XqwPcUGpIRZk6YaiBlBO/lv6WLrKKFkR+DjgBNmg15
         HjuMwZNmTfqo2pAr8zLz+zKMjAY8M/WGMGJlS7ZBFDbiKUc51GiawT47/2A7llsJYHJt
         zvLxi5/jGcbXP9/IDihHNyXJIU8haCOQi5ny/h2CBwiZU8uH6Vm8TaURZDgTem7mjHHo
         s29qe3AC1TORE3PgiXqooR2UDw9DdLoBztC5UpMUt9khx9CoNEbarqVmWvsyY89MX52v
         QGE+mPlLotTtXcK4b2+wG+J5m3cgPmeDfhQ0/SVfwjZ9b6b+c5jevOjMdCT0IzAmf0UH
         cqjg==
X-Gm-Message-State: AFeK/H3kytVG8RcOEgxrXImlJXqpbYxkFvDcoWjyw/L74f7rZWd5AeYa7z7VjkQxyC4YMg==
X-Received: by 10.98.111.129 with SMTP id k123mr54369096pfc.18.1491819088977;
        Mon, 10 Apr 2017 03:11:28 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 79sm23779425pge.14.2017.04.10.03.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Apr 2017 03:11:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 10 Apr 2017 17:11:23 +0700
Date:   Mon, 10 Apr 2017 17:11:23 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 2/3] apply.c: do not checkout file when skip-worktree bit
 set
Message-ID: <20170410101123.GA19325@ash>
References: <20170407192357.948-1-kewillf@microsoft.com>
 <20170407192357.948-3-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170407192357.948-3-kewillf@microsoft.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 12:23:56PM -0700, Kevin Willford wrote:
> When using the sparse-checkout feature git should not write to
> the working directory for files with the skip-worktree bit on.
> With the skip-worktree bit on the file may or may not be in
> the working directory and if it is not we don't want or need to
> create it by calling checkout_entry.
> 
> There are two callers of checkout_target.  Both of which check
> that the file does not exist before calling checkout_target.
> load_current which make a call to lstat right before calling checkout_target
> and check_preimage which will only run checkout_taret it stat_ret
> is less than zero.  It sets stat_ret to zero and only if
> !stat->cached will it lstat the file and set stat_ret to
> something other than zero.
> 
> This patch checks if skip-worktree bit is on in checkout_target
> and just returns so that the entry doesn't not end up in the
> working directory.  This is so that apply will not create a file
> in the working directory, then update the index but not keep the
> working directory up to date with the changes that happened in the index.

No. I think we should check the skip-worktree at the call sites
instead of just exit early here. What if the caller expects the file
to exist if checkout_target returns zero? We just don't have enough
information to decide what is the right thing to do in this function.

There are two call sites.

In load_current() we could skip the lstat() call before
checkout_target() too if skip-worktree is set. We also need to skip
the verify_index_match(). I'm not exactly sure if that code expects
the target file on disk afterwarsd though (apply.c is not really my
thing).

In check_preimage() it looks easier because we could follow the
state->cached code for skip-worktree, I think.

> 
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---
>  apply.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/apply.c b/apply.c
> index 0e2caeab9c..0da5d0b7c9 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3327,6 +3327,24 @@ static int checkout_target(struct index_state *istate,
>  {
>  	struct checkout costate = CHECKOUT_INIT;
>  
> +	/*
> +	 * Do not checkout the entry if the skipworktree bit is set
> +	 *
> +	 * Both callers of this method (check_preimage and load_current)
> +	 * check for the existance of the file before calling this
> +	 * method so we know that the file doesn't exist at this point
> +	 * and we don't need to perform that check again here.
> +	 * We just need to check the skip-worktree and return.
> +	 *
> +	 * This is to prevent git from creating a file in the
> +	 * working directory that has the skip-worktree bit on,
> +	 * then updating the index from the patch and not keeping
> +	 * the working directory version up to date with what it
> +	 * changed the index version to be.
> +	 */
> +	if (ce_skip_worktree(ce))
> +		return 0;
> +
>  	costate.refresh_cache = 1;
>  	costate.istate = istate;
>  	if (checkout_entry(ce, &costate, NULL) || lstat(ce->name, st))
> -- 
> 2.12.2.windows.2.1.g7df5db8d31
> 
