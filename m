Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934E2C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 01:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6720B206E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 01:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKnHiP4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438265AbgE2BGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 21:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438286AbgE2BGM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 21:06:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1358DC08C5C8
        for <git@vger.kernel.org>; Thu, 28 May 2020 18:06:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu7so388989pjb.0
        for <git@vger.kernel.org>; Thu, 28 May 2020 18:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fI9gp2/oKgJSDV6VeX+UwmTkchhsaIcX/1D/636q6Ag=;
        b=QKnHiP4IKI43m4k16fDFUUYJkEUIB3L7z+Ab8qhoCn32cKAYciJDeiv7SNobnyeShc
         vm++aONfAkgNplbUM8hwBlEDBk9kPX8hAU80elPy6a7shIaKoLjWjv/j+1Z/7w7MET9w
         PWkL+oxOCLOX5pFfoCbS1rLyj/mFspRS/YWnXjyZ5z16cv9OYhXMESPrE1ZvgvalvPgf
         lj3sfZrbtHmAfZ58Hpio12YBCu53QMSRgLLuOpKJvB8LvvXEtgJlVOYaz8lreRJdT7Yi
         LDoeBJWk9x0B8Q6cfd9kHUe1nRdqfNIIF4eym+eA9QjLm1ZsDsJaRtuwsnaVaT1oMU5E
         oYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fI9gp2/oKgJSDV6VeX+UwmTkchhsaIcX/1D/636q6Ag=;
        b=BAO1XqbKlx0wHucs/P6iUzfTUzI4J8XUUlNR/TiMLBt5JofGyS/wot4oS+SUNnQm5G
         ktdZIk+z+TGjgLG00WME7ytuGZFVzI0Naaooz1Qi77KjqOugbtRNPuMjI6I7De4tw4wF
         6v1yhy79UaHtY55JvkEZAf7WEbFgahpF1w5qSTvXhSa/3h7KwnCAkj7GrPSZiHRfzetn
         Z9EkUbcIZ7KUL6QFggSR/k0iQaPSJXLNvXCpTBijdagb5qWMAT+TlfgoihlAQXsKFRpP
         3S1xLcwLsXRSWBhVIHnx5CSOyw+K1kvaAKr2wTpT3WO45g7rQy6PUwKEU3cZvF4IQRIn
         Vyvg==
X-Gm-Message-State: AOAM5302t7v5OjWX1UsWtviKNCGRBseZcsI2bJWTc9LsKNHhJHMrO8EG
        x4Tr5MkfDfLN9WhH6H1zU6A=
X-Google-Smtp-Source: ABdhPJx840SJfGR2PpcizVPqt6Dmg0PHQBgYVesfwkyINueZsGa4+EHhqhjucj5LmIizrP1KDncg7A==
X-Received: by 2002:a17:902:d68e:: with SMTP id v14mr6244509ply.262.1590714371446;
        Thu, 28 May 2020 18:06:11 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id e12sm5496793pgk.9.2020.05.28.18.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 18:06:10 -0700 (PDT)
Date:   Thu, 28 May 2020 18:06:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] docs: mention MyFirstContribution in more places
Message-ID: <20200529010608.GF114915@google.com>
References: <20200528234939.145396-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528234939.145396-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> While the MyFirstContribution guide exists and has received some use and
> positive reviews, it is still not as discoverable as it could be. Add a
> reference to it from the GitHub pull request template, where many
> brand-new contributors may look. Also add a reference to it in
> SubmittingPatches, which is the central source of guidance for patch
> contribution.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  .github/CONTRIBUTING.md         | 3 +++
>  Documentation/SubmittingPatches | 5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)

Yay!

> --- a/.github/CONTRIBUTING.md
> +++ b/.github/CONTRIBUTING.md
> @@ -16,4 +16,7 @@ If you prefer video, then [this talk](https://www.youtube.com/watch?v=Q7i_qQW__q
>  might be useful to you as the presenter walks you through the contribution
>  process by example.
>  
> +Or, you can follow the ["My First Contribution"](https://git-scm.com/docs/MyFirstContribution)
> +tutorial for another example of the contribution process.
> +
>  Your friendly Git community!

Looks good.

> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -3,8 +3,9 @@ Submitting Patches
>  
>  == Guidelines
>  
> -Here are some guidelines for people who want to contribute their code
> -to this software.
> +Here are some guidelines for people who want to contribute their code to this
> +software. There is also an link:MyFirstContribution.html[interactive tutorial]
> +available which covers many of these same guidelines.

nit: when I see "an interactive tutorial" I imagine a "git tutor"
command that interacts with me to guide me through my first
contribution (like "vimtutor").  I think this means to just say
"a tutorial".

With that tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
