Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D75C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 08:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiCVIkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 04:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiCVIkD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 04:40:03 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7336B52B
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 01:38:31 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id q3-20020a05683031a300b005cd8cd111c7so3514728ots.12
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNbLIrckG/WTEThGLrnvxxmSt100VRSdU60dD5jdJwU=;
        b=RDVMxwdei6CCsLMGzPlcD8aqHYiPS+2hfJ85qP2DGJ+GJ5FbyDCohS55x5iSoDYhCo
         eCDKFQBE5JxuwiHMEooaS9XoiXE60rUewJbsLHBjNO0Tt2FLMvXybwKIPXe2EvvMMaKV
         M4ZpUcUkViDhmUYyqPUZ8Ovr2XziZOFELL5e8Vwg+UUPI/xpDfI5cuKC5PYXyNsyTo/0
         SJz3DVZQpMQ6cyjQJOUfsNq9BL+oUn3E3LWRi1lPiDz+AEVtQVCdohV0z6/PyibT7xke
         MWgTpCHn8rFzolo/NvPDnZv0yU3kHMFiI8jB4zTvj0X6Cwqn+WG4aYkopnLOhLOJDrQL
         TkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNbLIrckG/WTEThGLrnvxxmSt100VRSdU60dD5jdJwU=;
        b=xA5b5AggMvElZV3XtSvTH8/Ggmf7Ho2HghK6cziCFesNnxp4ujL8s7LlVAK5XBVZrN
         n14DDQq9jWzkbEsTIdA26FkNms4KmtSjmtOoGcjvK74t09M1l65+SQp/iLWuQD+beZ/s
         fWDqbdH/NHsEKwqWTZorTDGDX8Ubf8k9kNKNhVb1guZd4q9vP3/dOEb2g4yzTxtyw3nz
         EOehxd+1NhRIAlyGA+A4v+cI+83+NeYqm/8nC9I7FuY3MqNfKzoeB65p7oo9W8WmN4Mw
         1EPfa95kKMqo1Os3ig2mUAbCOTfitf6lj12S9Es/J3E5aZ19icJSWcWB3GGTPCxtB7NU
         9l9g==
X-Gm-Message-State: AOAM532cvPIgCSHySO3r+iDqr6/e59+cHfeE0m0Gw1RFjtbOHXVebRhq
        Ii+UfgVHYfdkhjvjxEZybRdPwjQudPFOIXtOLl8dBcYZ
X-Google-Smtp-Source: ABdhPJz5M5lktw26yhXg57rS9CmPAw2JsNB3sjlrpSRuyzSBe/IL278mNcBoxGkFX5p9NCdJean1JDgWIHouBdJh8i0=
X-Received: by 2002:a9d:162:0:b0:5b2:1c30:a1e6 with SMTP id
 89-20020a9d0162000000b005b21c30a1e6mr8979734otu.26.1647938310852; Tue, 22 Mar
 2022 01:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com> <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
 <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com>
 <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com> <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
 <97a665fe-07c9-c4f6-4ab6-b6c0e1397c31@github.com> <xmqqo824cbxl.fsf@gitster.g>
 <e127dadb-7b44-55f8-16ea-9fcf94905db8@github.com> <xmqq8rt3xgmb.fsf@gitster.g>
 <b64c1805-dff9-3fd3-1e5e-84bd68d4b058@github.com>
In-Reply-To: <b64c1805-dff9-3fd3-1e5e-84bd68d4b058@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Tue, 22 Mar 2022 16:38:18 +0800
Message-ID: <CAJyCBORkauHAdDiHjQ2Agj3bNhLNPtKk-VW5=bNmBfNuQtv7hA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Tue, Mar 22, 2022 at 3:45 AM Derrick Stolee <derrickstolee@github.com> wrote:
> I'm particularly surprised in how much 'git mv' doesn't work very
> well in the sparse-checkout environment already, which makes things
> more difficult than "just" doing the normal sparse index things.
>
> It's good that we are discovering them and working to fix them.
>
> Thanks,
> -Stolee

Really appreciate the mentoring and tips here, I'm trying to make some progress
now. The problems facing here certainly push me to explore more and know
better about the codebase. Appreciate all the help :-)

-- 
Thanks & Regards,
Shaoxuan
