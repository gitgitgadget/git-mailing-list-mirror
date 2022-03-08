Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDF9C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbiCHOfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbiCHOfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:35:42 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0824B86F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:34:46 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id j83so8332942oih.6
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bI5YM/wwadSdSipwqaNVdT3OzaBIVC+Y4dgJhYymxdk=;
        b=gJ8oxKdWghYxAukxLEPkpdLfu42y3sGD8qOwPrbLSgj55laxs/fvKcqcNvxBBeaKG2
         2XV8VRRc1Sa6AXYAD3mxx/o9uUJ/oOr3TN45iMa89yENBtgsrMyO2OJjfGbuPyOnDYQO
         pi8IZldECSOoWK1YvsTdoseOMpjaFWvnapYR26XNWp/N1S62gc/qJFEs0kcHldlyyZy6
         dBNCT9WvTopud5vVnXUTHsnfL3nICccuuPVsQsiY3nHzMoho8q/U3jAkr3oE7DJcAXvR
         Yuyu+vm2a6s4fSg4YcYciY81mYLGZPFPnOvPybpTi/W3zXMANHTvOzc35YJCwTMb2cJl
         +ElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bI5YM/wwadSdSipwqaNVdT3OzaBIVC+Y4dgJhYymxdk=;
        b=wbfLniO2xP/mMgKhXD+xv2SJfkPqc4AFhCox7n/QAbNxrskeVe2x5UPudqePcSnpAw
         fPlqgaz9PL9PJortZE+qyTK+zsK3naxr2riTXDlF/FK8SJz1+4qFvlB8uzAK2p3KzZ60
         wK6oosWhIGBdita513ZL/17rKOtXpkyOFIjqeFd0X9X61/bmL0eHg5WZBUKlsPa/7W62
         DiPOiFDZtV2VE7pKrAnPPqmdHVz4w+TDxIjWm95q62ifCQBnuNCIF7gYM4X289ns4QGn
         hPqvaGG8k/dmak1OGUmQK4nJwsXN9K/eD4wiHUPrqooTwNLVWq62RqX7dK+TPzqCJyKq
         LVlg==
X-Gm-Message-State: AOAM533+wQJVR0mp7YyeAwdwc6GiS97sMJVBDmqeJEMQJHTDVV1HvZWl
        ZyBVS5B1ZRevhSqQd3UAGdCB
X-Google-Smtp-Source: ABdhPJx2Rq62iECb5OtGJ1iydYkCL9fuk1Bl4fWYbOgHruBDss7UQw6BxHjw2xiYDsGYnT/S1NGCyA==
X-Received: by 2002:aca:1a04:0:b0:2d4:f855:aad1 with SMTP id a4-20020aca1a04000000b002d4f855aad1mr2717460oia.63.1646750085645;
        Tue, 08 Mar 2022 06:34:45 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bc12-20020a056820168c00b0032130d4afe4sm352196oob.29.2022.03.08.06.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:34:45 -0800 (PST)
Message-ID: <be0752cb-1802-04ad-7a71-ffea4f74d5f0@github.com>
Date:   Tue, 8 Mar 2022 09:34:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/9] sparse-checkout: make cone mode the default
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2022 2:39 AM, Elijah Newren via GitGitGadget wrote:
> == Maintainer Note ==
> 
> Depends on a merge of en/present-despite-skipped into master.
> 
> == Overview ==
> 
> This patch changes the default mode for sparse-checkout from non-cone mode
> to cone-mode, and marks non-cone mode as deprecated. There is no plan to
> remove non-cone mode, we are merely recommending against its use.
> 
> The code change is pretty small, and most of this series is about
> documentation updates -- to focus on directories rather than patterns, to
> explain the new default, to explain why we are deprecating non-cone mode
> (the final patch), and to make other related cleanups to simplify the
> manual.

I made a couple comments with potential ways to improve the series, but
in general this series is high quality without any changes. I'm happy
with it as-is.

I'm particularly happy with the additional examples of how to use the
sparse-checkout builtin. That should really improve discoverability.

> == Alternative ==
> 
> There is one primary alternative to this series: make sparse-checkout error
> when neither --cone nor --no-cone are specified (so that there is no
> default), and wait until a future date to make --cone the default.

I appreciate considering this alternative, and I'd be open to it, if
needed. My gut feeling is that we don't need it.

Thanks,
-Stolee

