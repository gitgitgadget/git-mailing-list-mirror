Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A76DC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2959622E03
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbhAGG6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbhAGG6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 01:58:16 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A366AC0612F4
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 22:57:35 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id d203so6421705oia.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 22:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HpsnZEmViXsdkn3ZJZ0zmDTOtF4G/jeIT9gcHJ0uctY=;
        b=InStHzz3zjyHaRya8K0KKmt0V9kfAMteKZctT7HdNWlx4lRcDwqJydJWpw9WKStIl1
         BPNJIWS5m74Vv11MLmXwuqYVh/sbwnOIgjHwNfyn3ANCdhx313boyepywaVZvYmxp3lD
         15l/1gvATE3PHIaBsk9BvQ77hU2/WENFSdZU/+ZcsvE0atn4V7i26x7piZuBrTDPcKbv
         QOVhjRe6Cpv5jVlKzdjXwNpYmfVJtoczRt2N8+LuBpGTjmHBviPikA1FHiQbEh41F7JH
         kPTeOIrD+yO2zUtvl1M6Oj2TD6CmLgosIxIWPHmywKLc7GBbe7Q2gf3Q5zikO6hHQTOe
         7Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HpsnZEmViXsdkn3ZJZ0zmDTOtF4G/jeIT9gcHJ0uctY=;
        b=AUjqDI3qGVdZMJykwbZVfxXoK/E07aT04LCVaT6r3wjgTZ31oMAsWRitCH8+tmJn+1
         4qGF4GfEhW6NFQyfLStZFprHMGtwm6KMeW3hNbz1tQh07tzaGwLKE+Te2HJQZCBuaFlu
         G77yjzE73613Qo1nr/4Hw2QreBYDcb192ummTQQRd7ZVtk1P9kB1hO33GLGALbWADx8+
         TAQLBbgr/JK/2ymU1hkOJaw4Sxm10XI/W3kQymyFqOgwRwJZ40gJRsw/K9pH8U9/zOPx
         oYAZ1XHwt1ZoVO8CK2ShZfM9DSQG6N9GultFLksI7JNVLbpP9RR/YQX149095145YQu4
         4V4g==
X-Gm-Message-State: AOAM533CpTOKXwGUCK/Geafk9TxLA8mKGE9Gq81NMQHpQHUXtieHQKtH
        brRwPMfaM77Ab2hbay82w9pbu6ttBNJOp6r/ncY=
X-Google-Smtp-Source: ABdhPJwG45LoApoVVDMcugHj7JI8xxnY5IKvG9fwFy4HvM0DYq1/9UhMuGICgqjevochOCGkY8nuGiQ+l1mNaZBziVM=
X-Received: by 2002:a05:6808:25a:: with SMTP id m26mr517687oie.179.1610002654914;
 Wed, 06 Jan 2021 22:57:34 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Thu, 7 Jan 2021 14:58:52 +0800
Message-ID: <CAOLTT8Q8MEHpVqKcuvS1cZa6t3y=_Ym-1uCzd-B9ob-pNJe1yg@mail.gmail.com>
Subject: Re: [PATCH] builtin/ls-files.c:add git ls-file --dedup option
To:     sunshine@sunshineco.com
Cc:     adlternative@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh my god! Thank you for your correction! :-)
I didn't learn to write git project format specifications before, I
will pay attention.

I will learn to write test scripts later.
