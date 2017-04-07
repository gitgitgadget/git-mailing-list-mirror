Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A23820966
	for <e@80x24.org>; Fri,  7 Apr 2017 22:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756398AbdDGW24 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 18:28:56 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35264 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbdDGW2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 18:28:55 -0400
Received: by mail-pg0-f43.google.com with SMTP id 81so78210833pgh.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 15:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CuBiM2sKgKQzTg3CMatVB795/zYFXUnaQnDSHHAK464=;
        b=RLHYprcxrgExlk8YQtSgenAgjIvhTOtmioTHFWg7yAeT4F3lD48lVMxC3p+htKWQ44
         q0rwGYn9bSCwYL33nMUpCaYR3hSdaZy6zjz6CXym8iu4dI8vJwh+HEjzemq2GU7ZNpQG
         vLj+bKAlTeuwA64IKyEqZX/F8ufYvUinlRQcJ+6HZoJFg5a46xM9loegQdxJVsbaWYmb
         u47Msct3nNzppzhTw3bJJmkar6nOagVHOHzxnSs8MtULUS85ZGQeOtxdubMKU7tkkXMl
         jGCB5qpU7+arsLUZJOvhLDtdjQB2AIOmspMHPjlgE7rXXfD2Nrn02Jx6RMC+s3ba/YTm
         nr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CuBiM2sKgKQzTg3CMatVB795/zYFXUnaQnDSHHAK464=;
        b=oFwG059cicv1wnUi49dDG+NoH4esGwjSbonpARLqZfNwv/pBiY1EmagtIKfu93851d
         fEnYtL6xuyJSFkpsKlaLh6EPouueGG1SrEzOge0Lk2pWaYsWnktTZsaECNXGKEx4oEJf
         huOF5B0pr+C70fHRpqf+sBW4gUjVVq3nTGMjjPNzcoXVL+RUdhcSPCH0YNt5jWxok9pF
         RD0U7RdTJzRnM1WrtPL3B2UodFn5gIPYkx79SF3HbUnuDgHF6V3Ede7zBGx1flCMrMUP
         YQ1mzZ7cCv5Ha6MBQnLXX2E5XxJE6sbI67LhQiUCTQfhDn4JkUZOrBHvv593649XVPkj
         lC6A==
X-Gm-Message-State: AFeK/H019MdqUAmJVgRIiTEVs+olHJVVZrM2D20/KUFN3qpnL1vJ2uIAtv8j2NVh5Mn/AgS/BcmAPqgDklgGK9xV
X-Received: by 10.84.232.131 with SMTP id i3mr52391365plk.172.1491604134074;
 Fri, 07 Apr 2017 15:28:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Fri, 7 Apr 2017 15:28:53 -0700 (PDT)
In-Reply-To: <20170407192357.948-3-kewillf@microsoft.com>
References: <20170407192357.948-1-kewillf@microsoft.com> <20170407192357.948-3-kewillf@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Apr 2017 15:28:53 -0700
Message-ID: <CAGZ79kb30KXzvy7evSKQmtb8Qeo0OLH3-nfPn9eRsoTjcjFR=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] apply.c: do not checkout file when skip-worktree bit set
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 7, 2017 at 12:23 PM, Kevin Willford <kcwillford@gmail.com> wrote:
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
>         struct checkout costate = CHECKOUT_INIT;
>
> +       /*
> +        * Do not checkout the entry if the skipworktree bit is set
> +        *
> +        * Both callers of this method (check_preimage and load_current)
> +        * check for the existance of the file before calling this
> +        * method so we know that the file doesn't exist at this point
> +        * and we don't need to perform that check again here.
> +        * We just need to check the skip-worktree and return.
> +        *
> +        * This is to prevent git from creating a file in the
> +        * working directory that has the skip-worktree bit on,
> +        * then updating the index from the patch and not keeping
> +        * the working directory version up to date with what it
> +        * changed the index version to be.
> +        */

I have the impression that this information is better in the
commit message rather than in the code itself, i.e. we can
drop this comment here?

Thanks,
Stefan

> +       if (ce_skip_worktree(ce))
> +               return 0;
> +
>         costate.refresh_cache = 1;
>         costate.istate = istate;
>         if (checkout_entry(ce, &costate, NULL) || lstat(ce->name, st))
> --
> 2.12.2.windows.2.1.g7df5db8d31
>
