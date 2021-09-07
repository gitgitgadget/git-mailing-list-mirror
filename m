Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B0C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820BC6103E
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbhIGMgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343935AbhIGMgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:36:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04ACC061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:35:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i21so19386781ejd.2
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=DBes79dpVRurVT5l9FAUqxTRek3WxFCapyfCSQSABd0=;
        b=kf9GklDhsMN+WordsuZ/Gbdrusz+ofggzuTf95nvVIUg2j3HVcuO7I4fyCMP4pJQ4I
         yrG4LaEMaWlzNkWJ6Yox1Z6PNdK8JQAOWsxHpmyIWNcUa5KBsDA73qDeTcmZ04CpVX53
         5VBGuiTl14D+w0SdOuzCoMgaDmO4yFQb6UmaFrd12IkJdN1XELehB8Sm+QHaTv1RRsrU
         O9ADsk6Ip2JzybkMx0cbs/JEGhp9qYp1XnTgvObrXKxctHQVBr5O3PYKpbqzepUEsSSG
         P0W+OUcD++LqRlP9LPf34VjtTYaR7UzsxXqCM2pAXYP9QnG6HZujV/c6/ISEc7T+pZ8c
         HsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=DBes79dpVRurVT5l9FAUqxTRek3WxFCapyfCSQSABd0=;
        b=kLW+aR1UVByVl7RwMbsfCxln3TJSfbB+UnV7lvOvC8HyT1dmeQJ4608ehS1hhYF4dP
         yfSCbYS6ETOBKqUljCAEbbgmYIhRqTdUnxdedc+KuU3j2CcqhXg3yOjlBYVQp1SHAHM0
         CL2xF/XP+Fs0LgOmZ+mOGTYvREcAveca7d5lQQLtH63l60rzvQag2wY23wZxLK0Pi1Kq
         o4qLoRinbtmhsLtOInCBb2p1s83rr53S8klBa/cKCWJfhtpMdDq50rVtUYMZ/YpDW7OD
         sU3WgkfwRTuK8EvJsGiZYegwZSofAyelcAM6z4wRkz7woroXWyIQDhFbNcUY/c9P60Ov
         /5lA==
X-Gm-Message-State: AOAM5321fBdJhIfxpHzmhe920OzNas7In2jtUYlx0R8arEahsACxp3rM
        8Rg0bpbq7ftkGXqwfhKAbR1qfdsoIqyCtQ==
X-Google-Smtp-Source: ABdhPJwbYYiMuVeqejEQI/jysPuFKtu43hxGCkfp2Jtp9wXNfhgfPc4eZFqAOgm2xFboDTSzrdGhbA==
X-Received: by 2002:a17:906:b14d:: with SMTP id bt13mr18372758ejb.39.1631018118022;
        Tue, 07 Sep 2021 05:35:18 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b13sm6004802ede.97.2021.09.07.05.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:35:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        emilyshaffer@google.com, gitster@pobox.com, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH 00/13] submodule: convert the rest of 'update' to C
Date:   Tue, 07 Sep 2021 14:34:51 +0200
References: <20210907115932.36068-1-raykar.ath@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210907115932.36068-1-raykar.ath@gmail.com>
Message-ID: <875yvcmum2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Atharva Raykar wrote:

> NOTE: This series uses ar/submodule-run-update-procedure [1]
>
> This series builds upon the previous conversion work on 'submodule update' and
> moves out all of that shell logic in 'git-submodule.sh' into
> 'builtin/submodule--helper.c'. Even though this patch series looks long, a lot
> of it is preparatory patches and cleanup of unused functions that result from
> this conversion. The real action happens at [6/8].

It looks like the 6/x part of that still applies, but not the "/8",
i.e. this is now a 13-part series. Is this summary otherwise still
current with what's being submitted here?
