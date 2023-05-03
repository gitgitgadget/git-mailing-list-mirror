Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45441C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjECScu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjECScp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:32:45 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08E7DA3
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:32:39 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1924ec320c5so3336403fac.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683138758; x=1685730758;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQDENZADNOWY2oTpi4dkpjHVNrIhpmtVHINaQkye7Vk=;
        b=s1w4KxwFbHwhUHP5awdKFSd+WMHx1ASe8ryJArv/4Uievvxuw/PDGQGXFeK/1w60bi
         G3CMVZsii6F+ydwMb5HWJ3yjaD2tr3M/ZbZ1rnVreAiG7R7che24gu3NaJhJBb6uyP7o
         27CV+xL/+9hNiJ1+6u/6avVNuUiKAimMx4+CcAut2kQ7k90jTO1D5u+WtScTrmGV+FyK
         NR+0U02wwuWrp4GSPiMNt2bYYylkWAujM7D4xtLBv9DF6OLCPvKP/zVVH1+Hl60zZXzO
         9sHA4P69AmkUMWhNhonRaupppYROIfSOsEwvS5gOvGkOBgWs4f7A8Pglv+YtD5+4ysvx
         Sepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138758; x=1685730758;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QQDENZADNOWY2oTpi4dkpjHVNrIhpmtVHINaQkye7Vk=;
        b=M4AChpUmzyOPjqga1pODtSLQs6xa4rKQEhrQpPBvM4QxWidLGtgTmjBZnzo0bxqKzb
         SBnqmt9xA34h660UpeKIq1Y8dwhA9gsWMUkJoThRGLkHQKoE5YQNnGdyipi3XwYZIdO6
         HXi1tv/PEMWx5Q/q1FPAE/KsnVoZ1uZA7EOzBdzSqWfPqjRqqLq4o7SmpSWsEdp/d9m3
         OFq9ffchqGtuFo5QUSJEx/M9MK7W1jRS+/sr5oK5uyEBY6KUM2ZynyhCtm8WIuQYYf+X
         HYYxPQJRr3TOZ04R3i4wuMIYWQqodMt6i8+EBeTC1nf8nbIEzkZx2oTMPlu52VxF/hoQ
         xA/A==
X-Gm-Message-State: AC+VfDy1OHiR6J0vUTY2qi95FxdKiwtW5sRUiFblGriIuf7j6ggriapS
        Yj2qifJZBFCChq/PeiSHY6s=
X-Google-Smtp-Source: ACHHUZ7/ao89pp7eaodLf6E5JT+NoNsLDciZBwKeYIxJY+imZxlJ/ciyIBmxF2nL+xrmbmNQmo1DzA==
X-Received: by 2002:a05:6870:5255:b0:177:cbb6:ba2 with SMTP id o21-20020a056870525500b00177cbb60ba2mr10854910oai.53.1683138758376;
        Wed, 03 May 2023 11:32:38 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q1-20020a056870e88100b0018b12e3a392sm855844oan.42.2023.05.03.11.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:32:37 -0700 (PDT)
Date:   Wed, 03 May 2023 12:32:36 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <6452a8c4ea448_682294ed@chronos.notmuch>
In-Reply-To: <xmqqmt2lqofb.fsf@gitster.g>
References: <20230503134118.73504-1-sorganov@gmail.com>
 <xmqqsfcdtkt0.fsf@gitster.g>
 <874jote2zl.fsf@osv.gnss.ru>
 <xmqqmt2lqofb.fsf@gitster.g>
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> I am trying to see if pushing back at first would serve as a good way
> to encourage these known failure to be fixed, without accumulating too
> many expect_failure in our test suite, which will waste cycles at CI
> runs

> (which do not need to be reminded something is known to be broken)

We don't?

There's plenty of things that are broken in git that people have
forgotten.

If wasting cycles on CI runs is your concern, I would gladly write a
patch to skipp all the test_expect_failure tests.

I would rather have documented all the things are known to be broken
today than not, because in a month that might not be the case.

-- 
Felipe Contreras
