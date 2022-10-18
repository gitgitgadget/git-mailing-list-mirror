Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BC8C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 08:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiJRII5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 04:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiJRIIs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 04:08:48 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0D98983A
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 01:08:47 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1322d768ba7so15985755fac.5
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPfu/moU6WRjWyx2xW4lMR3by+u6JtJZEbm6KHUpsKI=;
        b=dlFZl9nR9PgQDmNKLVpjJX0+ySXXb4g7llDpVFNTqHiGXG7/Q2QKjMmAXD+8foDmaP
         8qW9ofpBX3IKvGdkxE9xZ0/0M/KHpK8LDlpVG2G1en5IhXYpLv+iBBjELnyR4/RKqnmg
         xJ8eWTHt8NH4SEOUl/F8Qmces7DPdPrCVjeASk+xKeenJ7WJGiucYXdAqzj8jbWQ/1by
         HlbWND0qzr6a49zZyoJxhb3k9pgz9UWEbRHJb23+X/O+o2Xrs8m4gpjssyVzFOy2GMn0
         IRFFUeNWhF6Ve9O05ZGA7BjnGGY1csdHiE21e4Zap/jOBI7xpSaK5NLkn7cRH63BCsc3
         yEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPfu/moU6WRjWyx2xW4lMR3by+u6JtJZEbm6KHUpsKI=;
        b=TxV+A3rlDG8cinfUPNWR73a3LNLBJdAyaUG5c56gpPSRpLSwPJ6dAcmSaZSvjPVQs3
         wtnZfouMJhtzefcird3y222W9PjKv4R6zpjyDUiHYGw3KHLmsbfaBx+iNmBMgM8PTuY/
         cF92db0kdu5hqMM3619p24QSuxZJi3e/nXxeHcpVARG11voRpBNuLiaT7WaZsf1kQ+9y
         FG4ofkAuod1qCvmui+kFvoFCNFSrFIAFQKpW+54HkCezGXMo0v8t8R6kUIEpbgw4gmjY
         UW0K828lR2KMhvxjXeNC23nisZ4V0mFrVn/F7EVHYuBRZLI9S38kS2G3LGEGG1biQLHb
         U8ug==
X-Gm-Message-State: ACrzQf1XQvtsGbshY7lPIoy1HnPEW80FhByXpp7nJ3aowPjy0+tRwUqv
        xKF1bs45SBn0doNEEVMVRgrIqqOwNFBEMw==
X-Google-Smtp-Source: AMsMyM6ov2tDEDyFZ6ebD5BrFSxKiGg/FYahZxapAi8rUlYqunvRboQZzq05wsSW/QDGyS4YPHpqYw==
X-Received: by 2002:a17:90b:1b05:b0:20d:3b10:3800 with SMTP id nu5-20020a17090b1b0500b0020d3b103800mr38047164pjb.91.1666080516663;
        Tue, 18 Oct 2022 01:08:36 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.59])
        by smtp.gmail.com with ESMTPSA id j5-20020a625505000000b00562019b961asm8562014pfb.188.2022.10.18.01.08.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Oct 2022 01:08:36 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     phillip.wood123@gmail.com
Cc:     --cc=avarab@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 2/2] notes.c: fixed tip when target and append note are both empty
Date:   Tue, 18 Oct 2022 16:08:27 +0800
Message-Id: <20221018080827.69517-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.0.rc0.2.gb5964654d96
In-Reply-To: <c0211f35-bb26-7ca8-6f9d-a62507e55e8a@gmail.com>
References: <c0211f35-bb26-7ca8-6f9d-a62507e55e8a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I don't think its written to if we take the 'else if' branch added by
> this patch so we need to initialize it for the free() at the end.

Actually, I didn't get it totally (maybe because my English, sorry for that),
but indeed the 'else if' expose this problem out, so I think to initialize it
is needed.

Thanks.

> We only seem to be using cp.buf.len so we can test check if the original
> note was empty so I think it would be better just to add
>
> 	int note_was_empty;
>
> `	...
>
> 	note_was_empty = !d.buf.len
>
> instead.

Yes, it actually does as you describe above, your suggestion makes it look
better, will apply.

Thank you very much for your detailed review.
