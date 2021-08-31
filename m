Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A384C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3AE60FE8
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbhHaIcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbhHaIcg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 04:32:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F51C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:31:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v10so26368967wrd.4
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8RWn5YKZzRY9+d6tmnM99XTiD0AUcecqqmsLWpQaZuo=;
        b=dmYWZeVHRdCkud471i3umftzztCBx1cZc7DHqbimqQYJLf+j0TMzD2RbK5SjT0nhvg
         dqn1OpdDf+GyWOC2qxrKfQ08kw9UijaS6avsE7KoMejtq6bIiSYWJ8EWySAizWm5TN7o
         rB+yAGGkuN4R6ix3QB1v96Rj7ZAm2HFDrm1CsBF3wv0/wtf4xHdRySKIxVFmYTGRYI2R
         iEWY6lj+F8ignWJpyBByywhy35BAQXrDaBgG1Rng0Ort/I4Itim0cyMYoUJrXe2t4tYb
         qn+EvJ4WWL3exSfybPP0g9S3LkghEgd+JpxTH5H372t/MMUhflCq56mS28h++2HDBd6+
         1SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8RWn5YKZzRY9+d6tmnM99XTiD0AUcecqqmsLWpQaZuo=;
        b=uNrCQusmq1EaX9+JTZgNvv6b4hPpYj9ZUd9+V1RlZwlxJUyS0l8xyD6xaY0x+l/APS
         swONG3ILvT2QlTg2rsf313Qy7vahv1ZiDDwMRis5lQnFrdfIIaBCJfDnuKy4IFYnuTsI
         tLCYL+EK1AQGSgyc17LiNRuPbR9RIEuJtvF0qfHCfSHYA3HJRq0bqRIVMJ9B+k1nRa+6
         tPLH1orw06+iDF1sgPsWDyeMSaemXDfYUKpIzZuHscf+lTUfTy/vk2tDYe4XWY+orrOs
         aju7CyiwK1P1lSzonCv/Cr8e3gShDvg1WJV7EfOTXitjrl2IdhM9AuCCO5VGNqznhM7b
         kWMA==
X-Gm-Message-State: AOAM532ekMls5M5r2mHSRvJ1ywaaUcMyAk3gD5GEV+IKPqeOBV940gDZ
        8M3x8u90Dsws+bhitWZJZ9epbOEYu4uFMQ==
X-Google-Smtp-Source: ABdhPJyw3ZYVRq1pDMGLBREM9oTEDKJrbzaYUSHyo73wdushIO/LdiT2i1vjuUbczWEp5QOjAN4SvQ==
X-Received: by 2002:adf:9783:: with SMTP id s3mr30583061wrb.349.1630398699605;
        Tue, 31 Aug 2021 01:31:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m5sm1789323wmi.1.2021.08.31.01.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 01:31:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/15] scalar: allow reconfiguring an existing enlistment
Date:   Tue, 31 Aug 2021 10:29:44 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <13056f02018542f8143e4933fbe180a0a9f77004.1630359290.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <13056f02018542f8143e4933fbe180a0a9f77004.1630359290.git.gitgitgadget@gmail.com>
Message-ID: <874kb6xbf9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 30 2021, Johannes Schindelin via GitGitGadget wrote:

> This comes in handy during Scalar upgrades, or when config settings were
> messed up by mistake.

> [...]
>  		const char *key;
>  		const char *value;
> +		int overwrite_on_reconfigure;

If you make this a "keep_on_reconfigure", then ...

>  	} config[] = {
> -		{ "am.keepCR", "true" },
> -		{ "core.FSCache", "true" },
> -		{ "core.multiPackIndex", "true" },
> -		{ "core.preloadIndex", "true" },
> +		/* Required */
> +		{ "am.keepCR", "true", 1 },
> +		{ "core.FSCache", "true", 1 },
> +		{ "core.multiPackIndex", "true", 1 },
> +		{ "core.preloadIndex", "true", 1 },

You won't need the churn/boilerplate of adding "1" to everything here,
but can just change the initial patch to use designated initializers.

That along with a throwaway macro like:

#define SCALAR_CFG_TRUE(k) (.key = k, .value = "true")
#define SCALAR_CFG_FALSE(k) (.key = k, .value = "false")

Might (or might not) make this even easier to eyeball...
