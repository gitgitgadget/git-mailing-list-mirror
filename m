Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6376C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 10:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJRK7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJRK7O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 06:59:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E530580BD3
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bv10so22861378wrb.4
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 03:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08yJomRBoQ6Yjeqi9A3chzlIQeCCUPVSzEQwULp2Unw=;
        b=l9sAOUdfcf5kehSQ46vDvY633TE1c4LjNtjCww2ccCbWFu7WXXS9F0DDxmjk07JP+S
         9KSjI4xlcPB6B9p50t0PELFLwkLcjuZw/NgU3IOVWglGABlV5M8cZYYLcniCaLFnqx8d
         aUZmVwZK199myZN+G1MGHZtXHXOOmGv68PFL76j/3GbhSHNm4NIRv+MSOKVjXkIf4/Cm
         XI5Q7ljdzcDbbSUdvrsaUj3Xwu5jyZN67+Di9AU3GWiQGQMa1eZgpYNP855sdGqYogAZ
         0ZU17MdaJza3Q27u5h1bmJPV7j4zdsEM+evhV3euYJrLFRWhROnwhiUpWzDasVStjdMC
         nASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08yJomRBoQ6Yjeqi9A3chzlIQeCCUPVSzEQwULp2Unw=;
        b=KWRiSwmmNYfBsMO1G/yFet1fdpp1uE1wUNhN3w2SRxE8Y1rcpN24ihOG3yPq2UUxfr
         FL1bR1g1OUcEXoN5OYK65I9ctcWav2E+1T1NSKh0jsh0ZTR7ReztsMNP8S1+v+2Td+PZ
         TQqjPbm1JyTj0zzCA04a8M6Jjd5Cvrn/AkTh1KR63UsnT+hrnx9DhWLjDyqzvtdtYyl1
         HQfTVVZ0l09ml2QitQn37FGfstkKcdQWlI42hPJL3dSLOZO81T61DPzh3nhH6alPPI+B
         OmbGltipq9kd9/14JonChdh9FZU6lOeWoB9iQImZrVwnImzN93f0SKs52jZrVUWyLQ6v
         oDrQ==
X-Gm-Message-State: ACrzQf2WhrN5WoEa0+0Q17S7BKMtImhaS3WDfTxvnFaPk+/WKPDv5UL9
        NTPb9joR98W6Jq+Aml6HazFAqBmX1Lg=
X-Google-Smtp-Source: AMsMyM4SybDLdpTdYtixc0OcjaKRcjydrT8+kdriDSKgGQzzGkyYwvIv5Ibkq7aEVtpjdRgqonEXNA==
X-Received: by 2002:a5d:4950:0:b0:230:cc5a:f6b0 with SMTP id r16-20020a5d4950000000b00230cc5af6b0mr1498501wrs.656.1666090751292;
        Tue, 18 Oct 2022 03:59:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c481400b003a6125562e1sm12426081wmo.46.2022.10.18.03.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:59:10 -0700 (PDT)
Message-Id: <41a8021a4bd09e1470d04ec11d392777d4f5824f.1666090745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
References: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
        <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Oct 2022 10:59:03 +0000
Subject: [PATCH v3 3/5] add -p: avoid ambiguous signed/unsigned comparison
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the interactive `add` operation, users can choose to jump to specific
hunks, and Git will present the hunk list in that case. To avoid showing
too many lines at once, only a maximum of 21 hunks are shown, skipping
the "mode change" pseudo hunk.

The comparison performed to skip the "mode change" pseudo hunk (if any)
compares a signed integer `i` to the unsigned value `mode_change` (which
can be 0 or 1 because it is a 1-bit type).

According to section 6.3.1.8 of the C99 standard (see e.g.
https://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf), what should
happen is an automatic conversion of the "lesser" type to the "greater"
type, but since the types differ in signedness, it is ill-defined what
is the correct "usual arithmetic conversion".

Which means that Visual C's behavior can (and does) differ from GCC's:
When compiling Git using the latter, `add -p`'s `goto` command shows no
hunks by default because it casts a negative start offset to a pretty
large unsigned value, breaking the "goto hunk" test case in
`t3701-add-interactive.sh`.

Let's avoid that by converting the unsigned bit explicitly to a signed
integer.

Note: This is a long-standing bug in the Visual C build of Git, but it
has never been caught because t3701 is skipped when `NO_PERL` is set,
which is the case in the `vs-test` jobs of Git's CI runs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 509ca04456b..3524555e2b0 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1547,7 +1547,7 @@ soft_increment:
 			strbuf_remove(&s->answer, 0, 1);
 			strbuf_trim(&s->answer);
 			i = hunk_index - DISPLAY_HUNKS_LINES / 2;
-			if (i < file_diff->mode_change)
+			if (i < (int)file_diff->mode_change)
 				i = file_diff->mode_change;
 			while (s->answer.len == 0) {
 				i = display_hunks(s, file_diff, i);
-- 
gitgitgadget

