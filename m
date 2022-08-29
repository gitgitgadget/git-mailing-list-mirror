Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F103ECAAA2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 02:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiH2CsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 22:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH2CsM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 22:48:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EFE33A24
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 19:48:12 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 76so6910637pfy.3
        for <git@vger.kernel.org>; Sun, 28 Aug 2022 19:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5UpLxzOFQ7wudio7mfSh08tWPvB/lmHmd8w4NxP7Zx0=;
        b=fDUlh46oJEBDbugeYewy+86LrOJWgJdUMF7KG8e3e3s7uPwpEm1alhgsB2KnF4VFJx
         LSBEN108YN5/dzOqpoHzJ8NnMHskeSJuSb0lDZlzGUneCva8SgZJn8JoSZvi+aX2vLWg
         9W6ouhNbYf0BazTNO5VslUHojBuWItmmds49eNUSD/ioJf8v4JnsCPBNui2RfqzVlema
         69MQfdoSlBKPCoX4Kp0kFVSP5IiuI5egK+T1vsg7xfhIpaVQ3uqsQf5ovfKfIhWXbsHa
         V7LM7W8msZZH/WJIch6ddhBaNJMqUbWRlQ/1odaF9Z92vjX5Ik7EHbaQhL9g+QIzqjb4
         Gp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5UpLxzOFQ7wudio7mfSh08tWPvB/lmHmd8w4NxP7Zx0=;
        b=TjmuOavXP/os9FQ3HDD7VxyaWwMbrdcXupgBNn8eo8jcxFHBDNVZ+2Akt5hR8IJgAb
         ieytkX8twrSJrRk9Po/w6EhmapypVPtyb7SLKPYhCZRzpY4jJGyN11JYEelndyF4auKb
         x1aUOtH0KmRKmi0E9UBnK7spgaicDjT6C3uHvvmtxhgeH8CQvVSBgZsObJ3nopHqTQsi
         +e5olalc1qPcdkHB/BJAS8AxmRDFcY7/+KDBaXHuck1IZEYbt1fYwfLH3/v7rHg9wviN
         rU5tvsjJS/gnLCk08XJ4OrrpbQE3XtJJod5c6IoHskCfCt8Udhyy8lCPRS2AcmJQbKRa
         4eaQ==
X-Gm-Message-State: ACgBeo0Tag/FINx7OVadKcK8ZUedOsbP4VznUGgAJ5thG0NlaHlhCMXJ
        tWm3EPQgDj6iOZQnn3+vADU=
X-Google-Smtp-Source: AA6agR4fL0k/veRJz3hfBlsx8y0E6+kDoZ+FWvtw+mYlqno/criml195HIhMWocKG27aPniv9UyPiw==
X-Received: by 2002:a63:f709:0:b0:42b:399:f197 with SMTP id x9-20020a63f709000000b0042b0399f197mr11879660pgh.382.1661741291678;
        Sun, 28 Aug 2022 19:48:11 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b0016d1bee1519sm6127835plf.102.2022.08.28.19.48.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2022 19:48:10 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Mon, 29 Aug 2022 10:48:03 +0800
Message-Id: <20220829024803.47496-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.210.g6a6f1a04889.dirty
In-Reply-To: <xmqqtu5zyndk.fsf@gitster.g>
References: <xmqqtu5zyndk.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Doesn't it make it harder to diagnose where the extra bitmap file
> you do not need exists (so that you can check if you can/want
> to/need to remove it)?

Yes, if we want that warnings for diagnosing we shouldn't remove the related
path but I think it should build on the security concerns. I don't mean that
to warning the packfile name in a absolute path is a danger, but when serving
a git server maybe we don't want to expose the real path information on server
to client users.

> If the "ignoring extra" is a totally expected situation (e.g. it is
> not suprising if we always ignore the bitmapfile in the alternate
> when we have our own), perhaps we should squelch the warning in such
> expected cases altogether (while warning other cases where we see
> more bitmap files than we expect to see, which may be an anomaly
> worth warning about), and that may be an improvement worth spending
> development cycles on, but I am not sure about this one.

That's exactly good suggestion. In my opinion, I think to avoid the sensitive
warning and the same time we keep some information to let the users know "Oh,
there are some extra existing bitmaps we just ignored then maybe can do some
optimization works", but I think just remove the total warning here is
reasonable also, i'm good with it.

Thanks.
