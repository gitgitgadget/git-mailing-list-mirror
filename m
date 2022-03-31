Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1A2C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 15:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiCaPWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238175AbiCaPW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 11:22:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703A119C83D
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 08:20:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dr20so37865ejc.6
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=FmNi3O1GBko5LsPzFLUTzHLJVqHHdvnMy3roPg6wt70=;
        b=L6xhrCiYc0PfoUQx8WwvlX9opPXtS0rqqw5cyfHAB3JPbUYBHswZBESfygO0t5ynom
         UQAc295OQ6d0AoMOttiIynhCbS7sXTHLWiS2u5aLfEJ/EJ6guVRWCIsyUBPi808x00Hh
         +OA5qJNxUE91V74JkwSu9izSZ2Hmdzt4IJHCr0rzWK3CCzrc8UcFunZgotZbAmPQ3OhK
         apoKxB7nmSGNDNu0468rqWJJuu6NnkDcfKaEqgzrVNIOlGw2frTqePDua8KA0jKlb8hZ
         qwMmd4wamrCvrEXy5/H4/jcw4wEH+WQSDMhu7UpnSHla6EMkjrLkcFncoo9oPpaFCHhm
         hh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=FmNi3O1GBko5LsPzFLUTzHLJVqHHdvnMy3roPg6wt70=;
        b=HvVJsBZnu+HOwbYF5k4RGsxBtOV3xkCR2Ng5Gp7+r9GdaEy4bn20UsmejH/UTokhy7
         e9S6S3YZkWBOMMOys9zwGzSEnP2owM1g2gzlS9u6bqtoXctpvYp1giD1psO2d9LHfmEz
         b3Zn8zeH01ulpl6K36zsnPVJeRx7rjtn9uZRuzHDmRh88eSVBDpch6z9bcNQFl6DOAyw
         vuD4DRkCS/iDbHiSzn4UciehgdmeULyM9UMf8WAnZbWqkr2njaq7VDXnns4I7I2qvsp5
         Sl6uSA4X9hyYiY0CeOTFhYMkIPrAl1uj+ztIaC5XGzagcEneHlwTjkVQ4U/Bl5h3GGq2
         JCvg==
X-Gm-Message-State: AOAM530zaVkumy82hT1P7EeUKNayXsMtpUKau7fkBVlscLguFyE+qUuz
        s0hF53eDpVQyStejHPxQwSIRQd+mf+g4Ww==
X-Google-Smtp-Source: ABdhPJyyU/gXrOsPohKEYF56AGKHgVM9C7Vp+HhAW9F9fpq1ZMAtwoHT8MDL3r90K2xPqSvaQbL4UQ==
X-Received: by 2002:a17:907:2daa:b0:6da:924e:955 with SMTP id gt42-20020a1709072daa00b006da924e0955mr5456557ejc.1.1648740040658;
        Thu, 31 Mar 2022 08:20:40 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709064e8100b006e07d033572sm9066746eju.33.2022.03.31.08.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:20:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZwbH-000VmZ-Cx;
        Thu, 31 Mar 2022 17:20:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v4 4/7] fetch: add --refetch option
Date:   Thu, 31 Mar 2022 17:18:36 +0200
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
 <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
 <78501bbf28105ef252976266abb437a278585609.1648476132.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <78501bbf28105ef252976266abb437a278585609.1648476132.git.gitgitgadget@gmail.com>
Message-ID: <220331.86k0cap2rc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 28 2022, Robert Coup via GitGitGadget wrote:

> From: Robert Coup <robert@coup.net.nz>
>
> Teach fetch and transports the --refetch option to force a full fetch
> without negotiating common commits with the remote. Use when applying a
> new partial clone filter to refetch all matching objects.
>
> [...]
> +ifndef::git-pull[]
> +--refetch::
> +	Instead of negotiating with the server to avoid transferring commits and
> +	associated objects that are already present locally, this option fetches
> +	all objects as a fresh clone would. Use this to reapply a partial clone
> +	filter from configuration or using `--filter=` when the filter
> +	definition has changed.
> +endif::git-pull[]

Re my comment on negotiation specifics in 2/7, this documentation is
really over-promising depending on what the answer to that is:
https://lore.kernel.org/git/220331.86o81mp2w1.gmgdl@evledraar.gmail.com/

I.e. instead of saying that we WILL fetch all objects "just like a
clone" shouldn't we have less focus on implementation details here, and
assure the user that we'll make their object store "complete" as though
--filter hadn't been used, without going into the specifics of what'll
happen over the wire?
>  		return -1;
>  
> +	/*
> +	 * Similarly, if we need to refetch, we always want to perform a full
> +	 * fetch ignoring existing objects.
> +	 */
> +	if (refetch)
> +		return -1;
> +
> +

One too many \n here.
