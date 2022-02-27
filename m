Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8F6C433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 20:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiB0UYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 15:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiB0UYM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 15:24:12 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25CB3F324
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 12:23:34 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vz16so21046234ejb.0
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 12:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R6eC50YJ1Hc3ad/loxVb+IuaIMAg7cUM9T0vD479Aw8=;
        b=DD3um+xcpd7hI6J4QTtmNy7KRBjpSibzslPmWfsl1nN//AIcIwVYBji8ViSwhmpWcq
         fW2Q3BJBUak0zUv7fWOpRO51XubLapHGtBMkbTGs2nI/cbGU/NEgHB7neLtcvcZcD2sy
         jdRtO8HzsroBw0DHEbdewx5mcuuV+P/HcoofNNKT8IZXfGJQm2K/qFhS5GZ57Or0NB3c
         PZnB1NaDZlbWLOzB28Ho9LSZ+Z/5DWGEpTcFXUxs4IcBgpxIRRSIGl2WYL2AAKoYDL6i
         eYZf9N7EwKMa5ECpJ9riKIMkN54o2GYEykZcdNWkhr92eygmzGVPnCSAAM0nDqcwEg5T
         fSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R6eC50YJ1Hc3ad/loxVb+IuaIMAg7cUM9T0vD479Aw8=;
        b=D1aiZtPlCb21mirT7G6xYKO/e9bphFjDqIL6eaaZUjPdDADkj72G68tN8ro/h9JQjG
         z4R+1j5EbfsUKBOmlcFCWQc32LQ4/Al77lpmCB6Qf6jIPt410Wm3J1Vibhb/DOi6x21I
         SV/p5Fa/Wlrwgj9q18/dMiv3N2r4g7l0F9jvhoZgHJHw6ajTIyzXUGzZmk/slvwxa4wv
         SsKcvjgI4hYWSL/uOG1vlw+IkHOH8Vbkmo7PUJF9fQXv9MKxsEPUCRliygFlM4J0/rUU
         tm4SKUECEteGXhS4OpyLp80283WqUPowymcCV0yRM4jv2C4nI/6rc7UvjuBsSzUBtyE5
         3+0A==
X-Gm-Message-State: AOAM531FuQfy//75lJC3nkOTU8WmikNYvd0nz8XsYCiOkR5kb+PQFfLe
        onimBj+JTYn1/iizMfRwOTA=
X-Google-Smtp-Source: ABdhPJzCJzmy6lALii3PDL1aCTThbDP4yinwh8Ghrq5Er+VDwbC2jQmvdfhxzpmJ0tskHkXImJWe6g==
X-Received: by 2002:a17:906:8457:b0:6cf:741b:dfaa with SMTP id e23-20020a170906845700b006cf741bdfaamr12972298ejy.700.1645993413336;
        Sun, 27 Feb 2022 12:23:33 -0800 (PST)
Received: from gmail.com (91.141.32.73.wireless.dyn.drei.com. [91.141.32.73])
        by smtp.gmail.com with ESMTPSA id pj4-20020a170906d78400b006ce88d5ce8dsm3734523ejb.108.2022.02.27.12.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 12:23:32 -0800 (PST)
Date:   Sun, 27 Feb 2022 21:23:28 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Re* [PATCH] rerere-train: modernise a bit
Message-ID: <20220227202328.7afrpuaujgwsnmcy@gmail.com>
References: <xmqqsfsjuw8m.fsf@gitster.g>
 <20220227180203.pakrqimsxbjx47tu@gmail.com>
 <xmqqy21w3z78.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy21w3z78.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 27, 2022 at 11:07:55AM -0800, Junio C Hamano wrote:
> Johannes Altmanninger <aclopte@gmail.com> writes:
> 
> > Yep, tformat is more correct semantically, but it's worth noting that there
> > is no behavior change here. These commands behave the same
> >
> > 	git show -s --pretty=tformat:"Learning" HEAD
> > 	git show -s --pretty=format:"Learning" HEAD
> 
> Your observation is not quite right.
> 
> The difference between tformat and format does matter in practice,
> unless your pager is hiding the difference.

Right, I forgot about the pager.
Both patches LGTM then.
The --no-pager fix would have prevented my confusion, which is an argument
for placing it first.

> 
>     $ export GIT_PAGER=cat; # disable the pager
>     $ git show -s --pretty=format:"%s" HEAD; echo Q
>     The eighth batchQ
>     $ exit
> 
> This episode also exposes another bug in the rerere-train script,
> caused by the fact that it lets GIT_PAGER to interfere.
> 
> --- >8 ---
> Subject: rerere-train: prevent GIT_PAGER from pausing 'git show -s'
> 
> The script uses "git show -s --format" to display the title of the
> merge commit being studied, without explicitly disabling the pager,
> which is not a safe thing to do in a script.
> 
> For example, when the pager is set to "less" with "-SF" options (-S
> tells the pager not to fold lines but allow horizontal scrolling to
> show the overly long lines, -F tells the pager not to wait if the
> output in its entirety is shown on a single page), and the title of
> the merge commit is longer than the width of the terminal, the pager
> will wait until the end-user tells it to quit after showing the
> single line.
> 
> Explicitly disable the pager for this "git show" invocation to avoid
> this.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/rerere-train.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git c/contrib/rerere-train.sh w/contrib/rerere-train.sh
> index 499b07e4a6..2b9df7b6f2 100755
> --- c/contrib/rerere-train.sh
> +++ w/contrib/rerere-train.sh
> @@ -81,7 +81,7 @@ do
>  	fi
>  	if test -s "$GIT_DIR/MERGE_RR"
>  	then
> -		git show -s --format="Learning from %h %s" "$commit"
> +		git --no-pager show -s --format="Learning from %h %s" "$commit"
>  		git rerere
>  		git checkout -q $commit -- .
>  		git rerere
