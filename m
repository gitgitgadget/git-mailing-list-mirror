Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604ECC433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 12:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350904AbiFUMv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351066AbiFUMvM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 08:51:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374112A736
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 05:51:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a17so10463631pls.6
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6utbCtCxppjxtsf19syO7MniJkVsibYGGYx24PNSy4c=;
        b=Y+NwmQnVL67o2hSDnSfvaJGt71e13nZ+TN2yNF6DpnK5fasH59hEYswG6+AIFLcthg
         0VZ0I1Xw446iUXNIX8uexQ9QDYPIOfXBs8kmThhbGZj+gB+DA707+ktclSYkTLOOT08c
         HvIcOM2tUjQSw+iD1zJi9K6Js+EkWHfcBpthvkA3MY3YVER8k27myJhN0yUM31kKyoTo
         Dp0yCQXh/CG4epfwYOA0GF1fZ/MKXbqCyTH4WWVdzHTOgJJyR3WrQhxPdetU66xZ549U
         QjWkWFTbxh+61oMyFjq4USjELZy8vX2RYQHh3y0H5ZfGMwnf9e0RTUCh1joDex2yAUgo
         ftjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6utbCtCxppjxtsf19syO7MniJkVsibYGGYx24PNSy4c=;
        b=OBymAyErB71DQj8wpDcqYa7zZM+A5xoM5dmQF623Lhpnn+VVz5d/ZHTJYp3mtG+UUL
         SxAXbPCgOIVWaCcU9QSqx4DxSDWfsBeekAXngnXvQVRhnnbHPvL4AXs6lbCS8qJur8Zo
         imDj3bvuGuju6+cl4rdaV8Zru6nfCA061e5r61SfPgoWE2pFdZPJuPb9JuBfMi6YLp+G
         KtWAn2hQHukSUb4vje9gzHLCB8cbAJ1LqpB3L/T9i6S2UVYl4WNStih2FwqSu0lCIDVS
         k8R+Pufe11ZBDit5oM5/xzVuETwBdCxlYveRu9/6lgCt7/zOHzIUvN1iz1ibBdGuaPJA
         BI5Q==
X-Gm-Message-State: AJIora8NuwDlD9gX0Q2IaOnsuXdeGIqxurfpTLB4Cj164muQQDzfmNqG
        +8rjiljGgMDgzU63g0fndcY=
X-Google-Smtp-Source: AGRyM1vkxqemKGjklVE+lihdhkRXViOlMMxmgqDLDfqNSWYLmVm23ztwSOFO/U9yc04wMv42EYLPjw==
X-Received: by 2002:a17:903:2452:b0:16a:38f9:ade9 with SMTP id l18-20020a170903245200b0016a38f9ade9mr3035057pls.152.1655815865432;
        Tue, 21 Jun 2022 05:51:05 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.189])
        by smtp.gmail.com with ESMTPSA id ci2-20020a17090afc8200b001eca28b8581sm4216308pjb.7.2022.06.21.05.51.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jun 2022 05:51:04 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/6] pack-bitmap-write.c: write lookup table extension
Date:   Tue, 21 Jun 2022 18:20:54 +0530
Message-Id: <20220621125054.23035-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YrDxt1MkQKdNJL1F@nand.local>
References: <YrDxt1MkQKdNJL1F@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> I'm not sure if I remember why `table[i] - selected->xor_offset` is
> right and not `i - selected->xor_offset`.

Even I myself got confused! Before sending the patch to the mailing
list, I was clear about that. That's why I didn't catch the so called
mistake I have been notifying till now. Thanks Taylor for asking
the question!

I should add a comment before the line so that people can understand it.
Let us parse `table_inv[table[i] - selected->xor_offset]` -

Suppose bitmap entries be like - 

Bitmap 0 (for commit 0)
Bitmap 1 (for commit 1)
Bitmap 2 (for commit 2)
Bitmap 3 (for commit 3)
.
.
.
Bitmap 20 (for commit 20)

These bitmaps are ordered by the date of their corresponding commit.
`table` array maps commit's lexicographic order to its bitmap order.
`table_inv` stores the reverse (i.e. it maps bitmap order to lexicographic
order). Say for example, if commit 4 is lexicographically first among all the
Commits then `table[0]` is 4. Similarly `table[1]`=2, table[2]=1 etc.
`table_inv[4]` is 0, table_inv[2]=1 etc.

Now suppose commit 4's bitmap has xor-relation with commit 2's bitmap.
So, xor-offset for bitmap 4 is 2. And `table[0] - selected->xor_offset`
is equal to 4-2 = 2. It is pointing to the commit 2. Now, 2 is in bitmap
Order. We need to convert it into lexicographic order. So, table_inv[2]
gives us the lexicographic order position of commit 2 I.e. 1.

Long story short, there is no issue regarding xor_offset. This xor_offset
is not relative to the current commit. It is absolute.

Sorry for the initial claim :)
