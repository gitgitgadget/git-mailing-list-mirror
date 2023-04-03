Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FC2C76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 18:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjDCSMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 14:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjDCSMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 14:12:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0575D2704
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 11:12:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k199-20020a2524d0000000b00b7f3a027e50so14460267ybk.4
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680545538;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NJ44xQA6Cg2dKrfy0G1wv/7sNssrlcDPoWJmMSXPbMo=;
        b=d6vrq8MYGJFlHMzaGUo5Uradi2gag1SQoZ+6XgozYYAcgVtPg0KsSdDokGBZx51/cq
         42X3wkb0E/Xt31pKeM7AeRDn9F4g3rXAZazKx488MzRW1uZI5zKF/9SiO8LY0ZQeXEeE
         j53nn3ls5BpGMtmo3M/g8RrNtRih1czj+ThzoRtD1G1vZt2+QXFro+ymMFKOaPXMgYsV
         /qBvNIuFamaCUGHeZUxUNSJoirXOfsVm39+z9bfVobLNbeTTdkOKiKjxk68gWn0jJgVa
         8uR75quI2USExQLFpvk39JNOdBWihTpCsUkQOavNNaPIMO4z3b5oLjARXbmP9Xkswfjx
         9lrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680545538;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ44xQA6Cg2dKrfy0G1wv/7sNssrlcDPoWJmMSXPbMo=;
        b=XrmN6om+PfVsjDB7eYPkBYRDqGnHmIDaNNkd3Ep6DEXxK3aPTu8eJ/JSAD55MpVH+L
         0JeU1yUqnx7d7M9/W4QWX+2mwUOCQiLlCmBda8MZ43xgnAo0go8y1m5hkT/ajbqjAQNR
         b60yZnbFYjdUt3eV7d9CZlDqys5BrM9+FOHLwnQjXqVCmgJIEBJMTjm3cAd4k6+KdaLF
         gAzlbfdfEMIpacgadoNwHOZKKoT717xBAf0u/zKkplCjq4FeiLBt3CTFhZJxzLwdQu6a
         S9y8uW5r/N9PLFh3d/I4+rFyzqqEa/8snMvyeDPAKGs0HFe+ybPLVDUhwrhO9o2bCX/i
         1DzQ==
X-Gm-Message-State: AAQBX9cacdMq+Bed4QlbpkpsHhgSGDHB3rDk4L8JfVupVDcy3glC7r25
        aZ1gUVcBdnquXuMDRumIivXYHF3GVysnEStYKTPn
X-Google-Smtp-Source: AKy350bre21LHJRu18PL1isJJ4SujVZ3/kG3hjGKuSFiOCmf4HPOhMsdDStzWTBUbaT50cTf1Rxh8GSTMRrE5QVDSNtz
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:700d:9843:4673:c77e])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b645:0:b0:545:6e22:ea34 with
 SMTP id h5-20020a81b645000000b005456e22ea34mr17743170ywk.1.1680545538273;
 Mon, 03 Apr 2023 11:12:18 -0700 (PDT)
Date:   Mon,  3 Apr 2023 11:12:15 -0700
In-Reply-To: <xmqqv8ij5g83.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403181215.3703626-1-jonathantanmy@google.com>
Subject: ps/fetch-ref-update-reporting (Was: Re: What's cooking in git.git
 (Mar 2023, #06; Wed, 29))
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> * ps/fetch-ref-update-reporting (2023-03-20) 6 commits
>  - fetch: centralize printing of reference updates
>  - fetch: centralize logic to print remote URL
>  - fetch: centralize handling of per-reference format
>  - fetch: pass the full local reference name to `format_display`
>  - fetch: move output format into `display_state`
>  - fetch: move reference width calculation into `display_state`
> 
>  Clean-up of the code path that reports what "git fetch" did to each
>  ref.
> 
>  Will merge to 'next'?
>  source: <cover.1679315383.git.ps@pks.im>

Not sure if you think this needs further review, but I'm happy with
merging the first 5 patches and have no objections to merging the 6th
[1], and you mentioned that you were inclined to also take the 6th.

[1] https://lore.kernel.org/git/20230320225702.1471172-1-jonathantanmy@google.com/
[2] https://lore.kernel.org/git/xmqqlejf9z2c.fsf@gitster.g/
