Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD58C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 14:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0905D60E54
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 14:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbhIWOGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbhIWOGE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 10:06:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8446DC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 07:04:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v10so19459120edj.10
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Eo5Vbu67N8t7CpDYqNryDkiiDafDjNROUgGEvsasFfM=;
        b=KMMoppiuIkf/SbT+7m3fPCs3q2E8HnIQA/2MdwBx84rT+lPI0O9HaiLuD2U6IHhptY
         0J96pIesFN/zdn18PINEk2brlJ59SE/Icb1rtOteqo4+yUI28P19VxV5HakXgvzyhicm
         79PQFmWTck13EcSUyW4XshEHN+IWVqQiLK3IZFjT5pdZsxrCLn+F/G0rm3hudS/+tjWq
         +3kMW+GWDKkYHFcUICDn1DKPUbBmrAbG2W6KRSx/gMM6Ncc1Jjd/N8VuKC2Rxe7fENPh
         XKyMPBbr41RBV0vC3lWcE6j9j/qVwjSt3eNVW6Nqc+a+ZFgBftFXZePozAhHP5+hCUVR
         ivhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Eo5Vbu67N8t7CpDYqNryDkiiDafDjNROUgGEvsasFfM=;
        b=jre4zICsbStTh3eUXMBvCgeJy2eblBMpPUhsLUVUCbPx1Hdt656u7PtfXq+a0haYgs
         NOBxym4lncofTpaXpR3PP/78WfX5oRhSEJu8yQoBMfO61WEctjU69e1zy3cOLbbiqLvs
         adPnJELx+ai6oPktlQzx88brXADWijim6GvovV8wCHorv0q5heHnYE7S9z6OXqko1I0k
         iu0uBlK1N/GVFMenmv4dIAYUHG06wxsyIxcZbS094DZTSjvJFRUzf2HXz5Ib+y9HY/DP
         kceeHOYYVLpNQcs6JLCJoy2cs5wYUYYDPWR3Ld/P6QaQucvxgY0xa3dAnLwIjD42MN74
         Zw6Q==
X-Gm-Message-State: AOAM530c6zC7fJVq2cw06X34fNYgeyFu8pfECNBw5aWkxStdCGX5hO6k
        q6iCNxCJndJuT7495k6FTvzzo4vYumNuTg==
X-Google-Smtp-Source: ABdhPJze7WYvXw2Ozel8u4zzUzg3xs06cVLlTFn0g4nHZgx5E3un6odRc4CcKDX84mb13SIuGbN/Kg==
X-Received: by 2002:a05:6402:21d2:: with SMTP id bi18mr5625293edb.21.1632405871017;
        Thu, 23 Sep 2021 07:04:31 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m12sm3293933edr.24.2021.09.23.07.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 07:04:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thiago Perrotta <tbperrotta@gmail.com>
Cc:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] send-email: shell completion improvements
Date:   Thu, 23 Sep 2021 16:02:50 +0200
References: <CAPUEsphn15H9HbHKHRk+GFMvjq5O=8NL0Vo4L8NoUwiRrQUJJA@mail.gmail.com>
 <20210921155152.4215-1-tbperrotta@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210921155152.4215-1-tbperrotta@gmail.com>
Message-ID: <87zgs34ccx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 21 2021, Thiago Perrotta wrote:

Note: using --in-reply-to to the previous version in "git format-patch"
helps keep track of the context.

> Carlo suggests to generate the flags programatically from the perl
> script. I am looking into this and already have a proof-of-concept
> working and plan to submit it as a separate patch series. I would like
> to get this series checked in first though.

Isn't this just:

my @params = <getopts list>;
GetOptions(@params);

And then doing some light parsing/slicinng of the @params list to get
the keys you've duplicated here?

I for one would much prefer to see that go in right away than the churn
of first hardcoding these, then removing the hardcoding etc.
