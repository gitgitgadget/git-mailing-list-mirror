Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8B2C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3A722C9F
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 11:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAFLGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 06:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAFLGe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 06:06:34 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBEDC06134C
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 03:05:53 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s75so3066494oih.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 03:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=k9eLBZhNynrbroiLVhFxXPLeJxTCwEdr5X8186vq+Ck=;
        b=VoNDfAA/BbAUXhO1nikz9TX0I1qKb1LlWV1f5GmGF714L7DPGqjxoVEObwQkRGgFh+
         ASzMCWt0jRXMKdd2KqRApaVmu/JkbXLyfOat7e3PN4jOD/0cGvUvY5az5ORXklaVjxzF
         Ef28mb5XQtjo8uf6+sMrH1pV/She1nRutE4omn3dODqGoBH/Ot30rOqhX/+1PmDMkPGB
         XYpkkIIX4xsdKfjfaYGSDfVi1hOBI3Y7oXszi91ae9fbh+jYVRlVr7ibd0UOUVZuT0lZ
         ItNZZ6Wv6NhpF6xyyUm2iN2QrSC11Q5MJNNTUvsx3xDS11Uwgk3ei2F5LVNRtgvgwHvK
         pbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=k9eLBZhNynrbroiLVhFxXPLeJxTCwEdr5X8186vq+Ck=;
        b=i/XeAUtWQCTmmj2GGrvspJEjBdwpPptl6m5Q6TvBv1wVVdQD/APiJbnSIUcmcyIpz5
         M6/H71PvFDECTHoWv5Q3rMPM0TS4K69FEcdd6ulcMkOLiiasJ7eM7hOZBkN3abQGKzUy
         TUkG6+msawZdpZbZ8vdyytlwp+DL5MO/Bm5zIhjYd830YOg0SlpdCs39aBK97zV1VawA
         KRhfIQ3rrcRks8O3OA7s93neBmJAsJesmHz24Xtr/jXFzcyo+ZFF+BpE3mtvaXsSx442
         /IY4tKW8RMhiJxs2VGeRubK+ZTiBiskQeIQFrfhxcHkIN3OlHQQ8zQj65+P/l+pLiT2V
         X2Tg==
X-Gm-Message-State: AOAM530IMAgAzjNSO3OMkI/XMsiOYTBe5Z8ePICSARXrlK+BOevJWk0e
        fY9Hm1z7MlKLrpRLQwgdH/8F30ZyRfx7DRt8vnk=
X-Google-Smtp-Source: ABdhPJzJZOP09AFeeehXFhAla7ciImI3NBBJ8wK2dvEja/v/7Q0/nEzMYN+JgeM6ZygQvNQ5rHTGjR9De6BUMPKWuOY=
X-Received: by 2002:aca:cf0f:: with SMTP id f15mr2837609oig.44.1609931152565;
 Wed, 06 Jan 2021 03:05:52 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Wed, 6 Jan 2021 19:07:09 +0800
Message-ID: <CAOLTT8ToMq9_E+-bUiTG7PnM=rQZZ2rTPS=4Y5rO9QsUJUZhOg@mail.gmail.com>
Subject: Re: Re* [PATCH] builtin/*: update usage format
To:     gitster@pobox.com
Cc:     adlternative@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In fact, this patch is to complete the problem described in this issue:
https://github.com/gitgitgadget/git/issues/636
I don't notice I should write it to commit message before ,My wrong !

Thank you for the patch, Junio.

Your help is great for our novices. :-)
