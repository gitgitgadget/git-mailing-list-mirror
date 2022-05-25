Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81408C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 21:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiEYVJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiEYVJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 17:09:42 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271EBA57E
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:09:41 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id p63so4371183qkf.0
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p3nC5SkfkqVrOnGaZ9F09bbGgo472QYOVAPNeXD1C04=;
        b=btqdFciuGIeJlEhOQVv1lSY3MjduBMzFy8kxLpUpE5P7dKpHdKriVVmWroLgXBPxY3
         vQXwFiBzF1Wxk0vPlPhLGxtzWL+q5Ccu1PEzVOCKu4/OPPjsaVH7iaxKqq2GaHN17gnu
         61NH3P0AIDMSJiTWKBlfwJS5AUcSLd2SCHnaMO/ffsdnrQ1AbXy1ANn7hRdFm4oDqINe
         bS6mgR32K6T5jOC5Zm1NKGg/5mVzMgFbZTK6tH62ncL3YyQ2qlx5wbbATmZ0Qyp/jOAo
         sz3bPfQPYluW10IM3/OasTLwefzILM/hm0aL5SbCjq9tlBzQaD/XgPMi3noAYiIiqtBo
         3JGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p3nC5SkfkqVrOnGaZ9F09bbGgo472QYOVAPNeXD1C04=;
        b=tJyu5ED0pHzMe32YIgms0Nfw8NUswQWFVBD35SFTBLi0m7Qg5Aj62tLohjdK08kswQ
         +ksogI8NZV9lSTXIXYS8bHJFB4h755zqqZYn/1ESH2DMMyV58JAlUGunDLR4roiPZuoy
         l8CKi56VoW+ceqhSGrhne8+GvZjHDtGCJOcNbAuHsuudSE7tDFV1arb6dfzJv1OxJaB+
         Gzr1NelL1DninmTbSQb1VSaQe1uLlUtCE5ohEcqAOFxWLQPaNWXfGop4NldSIMht1cA0
         u9B6GiZfP0Xb1vNFbO/yh/gXCLlmLDwqnMILrDFw3FVRA9gEo25mU8UQjz+UEZo0/H4+
         XWsw==
X-Gm-Message-State: AOAM532/RLDTVcae1HI79oNVPPICwuw5inKfKkJkQd4FdClqjI+luDIA
        WhyU7AbFGjycmxMoZrsK1RTPdw==
X-Google-Smtp-Source: ABdhPJzP4t5X+boWCqlrSHaZbDL4N21mXU0pC0xUm9REIzXyA2Rql9eXrvx7WlH2QkRbZyc6qsJXEg==
X-Received: by 2002:a05:620a:448e:b0:6a5:786e:f02d with SMTP id x14-20020a05620a448e00b006a5786ef02dmr6933383qkp.241.1653512980146;
        Wed, 25 May 2022 14:09:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bl20-20020a05620a1a9400b006a03cbb1323sm5346qkb.65.2022.05.25.14.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 14:09:39 -0700 (PDT)
Date:   Wed, 25 May 2022 17:09:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        tytso@mit.edu
Subject: Re: [PATCH v5 00/17] cruft packs
Message-ID: <Yo6bDC8uivC3gM2o@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <220521.868rqv15tj.gmgdl@evledraar.gmail.com>
 <Yo00X0NEu8N0MnZV@google.com>
 <Yo1TIQqvlxhvLZ58@nand.local>
 <220525.86sfoytwjn.gmgdl@evledraar.gmail.com>
 <Yo1YZM2dI6t+RsWv@nand.local>
 <Yo3gl5Wv82mTZQb2@google.com>
 <7f5a6a6a-c554-c659-72a8-404bc39e08c7@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f5a6a6a-c554-c659-72a8-404bc39e08c7@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2022 at 03:59:24PM -0400, Derrick Stolee wrote:
> I'd much rather have a consistent and proven way of specifying the
> hash value (using the oid_version() helper) than to try and make a
> new mechanism.

To be clear, I absolutely don't think any of us should have the attitude
of repeating past bad decisions for the sake of consistency.

As best I can tell, our (Jonathan and I's) disagreement is on whether
using "1" and "2" to identify which hash function is used by the .mtimes
file is OK or not. I happen to think that it is acceptable, so the
choice to continue to adopt this pattern was motivated by being
consistent with a pattern that is good and works.

Thanks,
Taylor
