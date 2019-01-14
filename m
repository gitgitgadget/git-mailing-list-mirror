Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88DAE1F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 21:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfANVee (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 16:34:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44513 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfANVed (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 16:34:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so204959pgr.11
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 13:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jeKCT6f4AkgiCq+1QdvW8McauWWbHK4ty1GPR4+VGK4=;
        b=QXVP+cFiEcxz5xAqO/gFLwIVnuiSr3ym/Thmd/Lv3EBkEf3BihrL7GsC6h5xApnQny
         ZLDtil2nDFHgOTVxZEMzs8WGfDVdNxHKrkGftfVGfOVP2Cz6CfhaQgSqpnH8oYniXyWF
         y4lHwDFy3nfqg8CAHSKZTd1AV2Hfo1G3X1plX8/ftUxlKJtrHlLKn7H3Gv2GpuDy1FUN
         MzLnc9fj3lS4Ye6XXs19+WP7kriZ0RCSBDVsHXjwzCE6AZPWr9GZ5Awaw4DguNmNbdHn
         fn4NU+ll/Kk33GWpKUr7fRBUX4VKR0I9SeaAJLUOlmQ6y4aAnxKDGPQGVwCZ+/eiv7jG
         zSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jeKCT6f4AkgiCq+1QdvW8McauWWbHK4ty1GPR4+VGK4=;
        b=SbqKQ1zzD+kMkii4QKtMpxN8OCSNGSj6tEoCB7i6p5edONBKJy4i1T0wur0OFAUvij
         2KsGNlCn3uQCP9ng6sCizMk1uGZwXaG4UWiz4dJfozkxRRRHTkuGKEassryV0v5ForYB
         8CxsMGo4fEN7EY35l/9H/bAbxB1uLmTavQqURiveBXCMoOXIDKOWkJRt2lo5BkXxfNJN
         +cKUwGsOh1cb3YGY44dr4aAUHmk/5X2OTOPI8yAKYNzxDyo2caLM3afhFDXDGqCLyV6X
         xlO1djP5COBggokf8jQO0FHnPtFgQo+QryJAGYnnkfLWCR1j19MhFgGGdRC119sOnR1g
         3+2Q==
X-Gm-Message-State: AJcUukdaOgxuhKE+dgv5TBjPJTH8pk8PxL3HpfyGjLf5pSLRRP1LOxaE
        ijwimbd68U2YSWx5wl5+MOw=
X-Google-Smtp-Source: ALg8bN74JefM8ETzp/SD33V82Ybjmeo798PSQQG/MZVr4wdXHSeYQdUY4a3KQPss1sUVk1mTbOmrRg==
X-Received: by 2002:a62:7042:: with SMTP id l63mr540238pfc.89.1547501672649;
        Mon, 14 Jan 2019 13:34:32 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id r80sm1613917pfa.111.2019.01.14.13.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 13:34:32 -0800 (PST)
Date:   Mon, 14 Jan 2019 13:34:30 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] new-workdir: Never try to recurse into submodules on the
 initial checkout.
Message-ID: <20190114213430.GC162110@google.com>
References: <20190114172702.19959-1-marcnarc@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114172702.19959-1-marcnarc@xiplink.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Marc Branchaud wrote:

> The new workdir is empty before the checkout, so attempts to recurse into
> a non-existent submodule directory fail.
>
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---

Thanks for reporting.  Can you describe the error message when it fails
here?

> Until the worktree command supports submodules I've gone back to using the
> git-new-workdir script, but it fails if my config has
> submdodule.recurse=true.

Oh, dear.  In general, the project does a better job at supporting "git
worktree" than "git new-workdir", but I don't blame you about this.

Noting locally as another vote for getting submodules to play well with
worktrees soon.

[...]
>  contrib/workdir/git-new-workdir | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
> index 888c34a521..5de1dc3c58 100755
> --- a/contrib/workdir/git-new-workdir
> +++ b/contrib/workdir/git-new-workdir
> @@ -102,4 +102,4 @@ trap - $siglist
> 
>  # checkout the branch (either the same as HEAD from the original repository,
>  # or the one that was asked for)
> -git checkout -f $branch
> +git -c submodule.recurse=false checkout -f $branch

nit: can this use "git checkout --no-recurse-submodules" instead
of -c?

In general, we tend to recommend that kind of option instead of
--config in scripts.

Thanks,
Jonathan
