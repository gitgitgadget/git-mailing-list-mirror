Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD4EC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 21:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350033AbiFOVYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349580AbiFOVYI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 17:24:08 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1D4554B9
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 14:24:07 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id d128so9728937qkg.8
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NYwg2ftmsyfYezivwKEL+pVfOV/BOOIgKlzW/Tp/T08=;
        b=IAtuDn18dC1qTuYMqCEH7QFo6Ly+rqa5Ki2VLA6npmrgvfG9Yyo5h41pMKOOfjip4g
         ooR/mz6XKokCCTE8fGS1r5eFqsDeh7YcKUqOzMTe2dCcp1ZdY6nTG1S4b+zHQihPl3p4
         0vohTZWuEeUv+7RyjLMz24d64v5mvgC28tW6iUkAZ5sMCg9luzIRTicqK28GOiYkKimz
         TsUecKWuNRv+LWYWJVSJY6ICydJa57hcy/b6x1JpNjlcMDF5Pl99oZn8+chwa2Cno2nL
         IEGNV74TrcS9+CUJXuTkkFsbp7k6QKz9YpQ18OcMqAjl5KX16NdNC5JpkXatH5kMBVy6
         Zhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NYwg2ftmsyfYezivwKEL+pVfOV/BOOIgKlzW/Tp/T08=;
        b=QVTcbxA9ZmJTOZt0PbpvuEn3b8UJ1qdWh1sZSjEC2EAu4jfJ9fLxgScC4I3VOWiaCr
         J1/edIQe4WvG1B87gmvnwD6sE/Oh5Z9MK3X8QBduENL4p7LXrYaWR+WFazZ4eLrJSUc3
         P/BCCmz5Bp+DtDGhvQaJU0XxAlR19lWlVhn+Ms+xs+5LrC7bEE0n3PQykR+sqfl+MoG4
         WYJkBhszFDkeWOH07rGQ6FJyDaHsjnGTGmciGPP9RaNyBHGBUuMScij5Vjv46U94EoTS
         cTIx1h+XGAOVPGJxT6R0wA7SXw94pEvJ1vldids/WjHSh/yfZJZTLWcSOHYgzzaAFhjO
         OCyg==
X-Gm-Message-State: AJIora8NLkgMH6yl1VRObMpZ0cAGrutD5MpY5ZmhwCtOYGBkzHmywfdr
        rOJknMkmcE5HA1YEr21WhpIC9Q==
X-Google-Smtp-Source: AGRyM1tFXfTUH6HKJb55sW34pLOFsBa4ns+fTKq7aq5kaEv0maSZmb6zd60XN1ljx9tS0ty5GMs+gQ==
X-Received: by 2002:a05:620a:2544:b0:6a7:97b7:5400 with SMTP id s4-20020a05620a254400b006a797b75400mr1374181qko.628.1655328246499;
        Wed, 15 Jun 2022 14:24:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h9-20020a05620a244900b006a75e8d920bsm14493992qkn.88.2022.06.15.14.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:24:06 -0700 (PDT)
Date:   Wed, 15 Jun 2022 17:24:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Kyle Zhao <kylezhao@tencent.com>
Subject: Re: [PATCH] send-pack.c: add config push.useBitmaps
Message-ID: <YqpN9FnBmdfLQFF2@nand.local>
References: <pull.1263.git.1655291320433.gitgitgadget@gmail.com>
 <57a7393d-add0-468a-a276-5241c2c84065@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57a7393d-add0-468a-a276-5241c2c84065@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 09:09:35AM -0400, Derrick Stolee wrote:
> I just want to be sure that using pack.useBitmaps=false would not
> be sufficient for your situation (and probably most situations).

I think the only other affected scenario on the client side would be
repacking. And in theory most clients are repacking in the background
anyways, so any speed-ups from using bitmaps wouldn't be noticeable
anyway.

I think just relying on the existing pack.useBitmaps config should be
sufficient here.

Thanks,
Taylor
