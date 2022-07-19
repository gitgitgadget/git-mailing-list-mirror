Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BC5C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 07:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiGSHlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 03:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbiGSHlB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 03:41:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09C419C30
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 00:41:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id o12so12789524pfp.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 00:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6peL4qBm1J8ZWpHRZNz8zhL/ASSUFUeN8qy2gdoyPEM=;
        b=IhzpAVZdXOdu6uMR4NZ5b+qts7UlTfUc5lUx4GgEwBFn+j6mgFaQPIPu1cn8tqNudP
         ArNBHGJZaBYozg4VEx7lQK4uHDuOm9HjMhE5ZkTM0tYaa/wY1ffx1ZzWTXjd/CDXNozg
         dwM9e3BXPImmILGRUrXLfSLbeIHhFrzhSvgdK1dI8xkttFCJ0Z9zfjDgtm3vPkv2chU4
         LSGEZfzxchzd395wgGH5UEcqoOThn78zcRRP0aMkgcY65DKaC18PMjXSTB59TcjyrMzF
         1FVlB3EqSOyrL9EpPPYk8XYFRuX78Nnz91bmbK4rVXtjsv+26ggfbvi0D5OMAXUTUeTk
         d8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6peL4qBm1J8ZWpHRZNz8zhL/ASSUFUeN8qy2gdoyPEM=;
        b=vcc74ksZw3JIUV2+aQ1C4tgGEu2+AHUebvgu6H1mMY7HHIU4YLoop1r0cdO6z8ykTt
         ixnlTPSb9a/CH0H/63ZY4A66aE7Kr0A2ar9/6G9iC2JL1FkZj6Y5JtA2DNQGyoaFZcG6
         36bK1OZXdgCGszrsMAucesUOEFVTFXBVHQu93atZ9B4Zo/kAOFWHdDzWBcMCnf3aDyqu
         WDFIV4h4qp3thOTv2HOXv0rI8+hi6aM1ixbGTpozN5xW597FBnkfx9MBtvy9iinYVoUW
         uXlqN7I5fjRD9jYQm+fwZ04dkinl98h94rTHC/gj8xIXjZtoAt0UQRbbEMnFfaynIlzT
         prbA==
X-Gm-Message-State: AJIora/zar2NrJAiJLtpRRgY/WHqIcMeQI8fnsz+y26xEnPUrtXz4E9t
        4DOX3ahX12H1DNVMaT8Hl84=
X-Google-Smtp-Source: AGRyM1svkpgrQwX5rnhRxbJwH/J8mDTindUBeKkxweQLbpkwAQhbehlHrerf4V1EHo67H/XHpHRLRg==
X-Received: by 2002:a05:6a00:e8f:b0:528:a1c7:3d00 with SMTP id bo15-20020a056a000e8f00b00528a1c73d00mr31361364pfb.25.1658216460334;
        Tue, 19 Jul 2022 00:41:00 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902bb8700b0016191b843e2sm10780009pls.235.2022.07.19.00.40.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:40:59 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@tenglongtldeMacBook-Pro.local>
To:     git@jeffhostetler.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 7/7] tr2: dump names if config exist in multiple scopes
Date:   Tue, 19 Jul 2022 15:40:53 +0800
Message-Id: <20220719074053.37282-1-tenglong.tl@tenglongtldeMacBook-Pro.local>
X-Mailer: git-send-email 2.35.0.rc0.679.gc613175da2
In-Reply-To: <d66f6bc7-4cd0-f585-83e9-9f7e2ee94d68@jeffhostetler.com>
References: <d66f6bc7-4cd0-f585-83e9-9f7e2ee94d68@jeffhostetler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> shouldn't this example in the docs have the scope value in the
> next to last column as you noted in the cover letter ?

oops, sorry for that. I will send a quick fix today.

Thanks.
