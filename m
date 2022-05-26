Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB50BC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 00:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348061AbiEZAJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 20:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348011AbiEZAI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 20:08:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5B5A3389
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:08:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id wh22so131685ejb.7
        for <git@vger.kernel.org>; Wed, 25 May 2022 17:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+KFcoEoarRDbAW0jISjUt6n7FeovnAsEi9sHoIXbv/A=;
        b=klL6LVn/4QsSItKOIxS3nAZmVKuITI7KiRzR25yp2LvTQAmvSji+AmvJM/pHSsqfho
         BUiibkp+JN/IhzzAwvV842QOGN0safD1hin9exFvfhiyw2o3QV0dI3eiLnaS/67JJGMo
         TDtP1gx8CX9I9quM8wxIkbe3VFNCGGQ8RXkcHjIVY/fgBFrDOxNMYma8M9YEy25jeJDI
         q+ufc0VHhsXGDiwiJKfp1s2Q69e4RTUvHDhG1fiqWmkrTWua10u1HQUGpSM1g3GKVw6G
         F/ip4HMqL9SrfN+7C5AyiumH7Eoswh9izeygD4Ng5dMBUv3yBnaPhC5O5Pwm6GWjJnYW
         T0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+KFcoEoarRDbAW0jISjUt6n7FeovnAsEi9sHoIXbv/A=;
        b=NXRYHGr9i9TeqrP0HGBUqzPEJmq3kg5JOhxguzAbZQmaVAZN4f+aNghk7fBfrSOK4i
         7LcPXiO1dfXAvWINfAPF1ddudTDCV/hsy0sE6JCSWaV+GgkUldPh+8zX45/2ol00q25I
         eR44scViR9i5agig3N1pN8dm9cS6x71Ynl5LagSjjzwHDY20la89D5H2nOxPw+AEd7aZ
         jiZ9mLK09b9RoxhmPKGFUuIKIzFmo84zEVoYmIaILwB/nhbsUyYzp9CBOZma4mThTT+z
         3Tie4y/Jiek9INUaEWZor8XTiL38A6Umhy5LwFlWSUJwAYzfIeBWFgbqpyxRtO1ZcQ4X
         U1hg==
X-Gm-Message-State: AOAM531SphE1ikCOC6h/bfEs8QIPCG+D1vIGVrIQosEvq0guZWHSgmdl
        bi6znRQcjwKrmTFh5nrTxqzFZIm4O1bUcw==
X-Google-Smtp-Source: ABdhPJwX9cHE8oJOM3WMxF/YHYJKd3zgm+r6WF/HUnMsPpoXujT+s2SV8A2K/DSZlbmoMhNLX3df0g==
X-Received: by 2002:a17:907:2cc3:b0:6fa:55f:8805 with SMTP id hg3-20020a1709072cc300b006fa055f8805mr31808008ejc.46.1653523733190;
        Wed, 25 May 2022 17:08:53 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id s16-20020a056402521000b0042bd6630a14sm14331edd.87.2022.05.25.17.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 17:08:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nu13b-00076q-VP;
        Thu, 26 May 2022 02:08:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 00/17] cruft packs
Date:   Thu, 26 May 2022 02:06:09 +0200
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1653088640.git.me@ttaylorr.com>
        <220521.868rqv15tj.gmgdl@evledraar.gmail.com>
        <Yo00X0NEu8N0MnZV@google.com> <Yo1TIQqvlxhvLZ58@nand.local>
        <220525.86sfoytwjn.gmgdl@evledraar.gmail.com>
        <Yo1YZM2dI6t+RsWv@nand.local> <Yo3gl5Wv82mTZQb2@google.com>
        <7f5a6a6a-c554-c659-72a8-404bc39e08c7@github.com>
        <Yo6bDC8uivC3gM2o@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yo6bDC8uivC3gM2o@nand.local>
Message-ID: <220526.86o7zl6tpo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 25 2022, Taylor Blau wrote:

> On Wed, May 25, 2022 at 03:59:24PM -0400, Derrick Stolee wrote:
>> I'd much rather have a consistent and proven way of specifying the
>> hash value (using the oid_version() helper) than to try and make a
>> new mechanism.
>
> To be clear, I absolutely don't think any of us should have the attitude
> of repeating past bad decisions for the sake of consistency.
>
> As best I can tell, our (Jonathan and I's) disagreement is on whether
> using "1" and "2" to identify which hash function is used by the .mtimes
> file is OK or not. I happen to think that it is acceptable, so the
> choice to continue to adopt this pattern was motivated by being
> consistent with a pattern that is good and works.

I don't have a strong opinion on whether we "bless" that or not, and say
that we should just use 1, 2 etc. going forward or not.

But I do think that us doing so initially wasn't intentional, and has
been in opposition to a strongly worded claim in a comment in hash.h
(which I modified in my earlier related RFC series).

So maybe not part of this series, but it seems prudent if you feel
strongly about using this for new formats over what hash.h is currently
recommending that we have some patch sooner than later to update it
accordingly.
