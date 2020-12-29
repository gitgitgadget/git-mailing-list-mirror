Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170F4C433E6
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 18:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4DAB22225
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 18:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgL2SKj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 13:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2SKj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 13:10:39 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CB9C061793
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 10:09:59 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q205so15358622oig.13
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SqALjuSyjP7Gim43Em32hQI0OnBtvac8mbpxMT5gc6w=;
        b=g15skxxf88LjyiuZriBKCq5UdmDVcik5/w8TzBhuvoVI0MCUVLp4njFXX17l1akoo/
         +slMy1JH6Y/TSkYIWmd7QmfX9putHQWG4yKB0e5ZKpfK5xmfqaMTV7T+vjebKfK6tHYa
         3uH8LfFDIdV7GoDm4yoY94/WcfAUra7gyEov2YhkygbtBlQ9wgFrB0sCsSfNylpT682D
         eJTRX+t/lFM+BkWNAkfIoUnKBwqwyunMHuziZQv8WT0m2F8mAUyx/EmJlc7dk3di3kpP
         TL46k6glDitbIDicCyjIsc9m1do3a75Rjckk9eMOmACk/fZwPosUSmdPCFECvy8kGVaQ
         utzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SqALjuSyjP7Gim43Em32hQI0OnBtvac8mbpxMT5gc6w=;
        b=JRrt+Lpz9QdCKHiK99SrOW0aq967RntgUSRSAZ92nzTgb3Tyqx7wD1PjAqnYTKfA4/
         6kUeRSM8r6oYmAEREncmemUu0bl3d9qcI5OINxtqgtYd6RBhlT1n2VKg/8jtgGuSjsO5
         z7fHX3A24s/l5IzWZ8m+/NmERt3jMcrv+5UuYhfmROieCyb5NoA3RnH2GAbTSkGSYxFb
         M14b65zT/3XoR3manTB6EBFRUHndG1Z16Bfja4lY7UpIdFOcxoFJk+XUjGLK8oIp2L7j
         6HPOhiI96alc0wjlJ5zcTIB53k5Z5cZiCf/Jp7qoQ6104fvdDLM9paewaF12N5vIRsb9
         wfGg==
X-Gm-Message-State: AOAM531BK3aLltvTXCm163Z198kEIdKfsxn89l41INHHEdxgl4dUJCml
        DlM2FFwoNATHtDZ1EmXPd6WuZke5ab7L4fLMsUY=
X-Google-Smtp-Source: ABdhPJzxgaVGYuICrpOgRKg/Y7S1eDI20HWldfs+jWQp2psPuHSrfJhcMF8SYX0oYlXBZqwqQpeRripsOGPF77qJd9I=
X-Received: by 2002:aca:3151:: with SMTP id x78mr3049391oix.39.1609265398572;
 Tue, 29 Dec 2020 10:09:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <pull.929.v2.git.git.1607677728.gitgitgadget@gmail.com> <af256b1c534e3fe103bb01bd673ac3a2ec467de4.1607677728.git.gitgitgadget@gmail.com>
 <CAP8UFD0r1RvbtOcHTbREcC4v33S-m_gS4e=fSq0OFEHr82K9nQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0r1RvbtOcHTbREcC4v33S-m_gS4e=fSq0OFEHr82K9nQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 29 Dec 2020 10:09:47 -0800
Message-ID: <CABPp-BH4cShLMa_dOShmZxbJt4Y57ZsG6+uvqPkGCa_toYOZ8g@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] diffcore-rename: remove unneccessary duplicate
 entry checks
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 29, 2020 at 12:31 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> About the subject:
>
> s/unneccessary/unnecessary/

Thanks, I'll remove the unnecessary double c.
