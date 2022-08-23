Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C14BC32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 09:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbiHWJN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349206AbiHWJLW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 05:11:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A0686C25
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso7310244wmb.2
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=08yJomRBoQ6Yjeqi9A3chzlIQeCCUPVSzEQwULp2Unw=;
        b=bAvRWwPin9Ie5I4MRaoCWzHn914onkB4Gz3bQDjc4dlzuvtf4fiIPeQvz/aJuNj8zd
         /NNjONkdSt6joe+sJyzWyrE1MyCV8HwGzi3H1osBYuPWvUUcmsPkjmFQyJ3hGZK+uWud
         Vfz4wvLZiZRfhvIlXpWOVSQxyspLbceQ7BlgT6Ydhpt4NhHmGCQRBxf26RgzJewvbBTI
         lRkD0CPH6DvZE+I9c6IT2pD+vcskBn9FhLGgHA+obs53cKRtQ+6pC+sTqc5/zA8YqKIV
         OJimLUPK8/MJ6RmBgMnD11ChJGbbQERwHzno5LPQZIDxpcEmFKdhrRjbtfIPMgfOcmi/
         s9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=08yJomRBoQ6Yjeqi9A3chzlIQeCCUPVSzEQwULp2Unw=;
        b=LoM7sXPTVWgeg8uk5xY+0CYlcjP/2u0/urN7AAc8ISjHnPNvb+xV7uXfdVQLHIovoZ
         sDHeiazU3yu/fDV09zmWHkE54eiWDKaMCllGqAgQT7fniUJi9xNU7qH0psP1RqQyq525
         GJMhljkzn8X2yydgdpxlLhyt5feq1r+GQp66gix8ka+6aQ1oOsA3cnYIxpN/EwHdX6yN
         Z8mgOkg6iNoFpKnd9jyKBlOJqzu6hEgae1EA2h3YnVTbWEAnTE0fPd9GPMzb2RedmS1o
         HG/vibKBY7frMzJSOPvOMWfMFL+fuPwXOenEkQJRmHf3RaL+PM/vIdNasJzG3ky5nCnO
         Ngcw==
X-Gm-Message-State: ACgBeo3cU1kHmjC9Z98Hz9/t+zKljUVtTW4506ArUFvu5E/r7V+u6kBY
        h4oBMDuo4MjoGKC+FdX2ye8kHLLqx08=
X-Google-Smtp-Source: AA6agR4T+sGq6gMN1HV/2sNRu8EdOV+8ALFy46AeFDc7RZrDBXIuQSz+wyBzN5iztDwzZYn/KUiZlw==
X-Received: by 2002:a1c:3b04:0:b0:3a5:487c:6240 with SMTP id i4-20020a1c3b04000000b003a5487c6240mr1414800wma.152.1661243468889;
        Tue, 23 Aug 2022 01:31:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4-20020a1cf204000000b003a5f812635asm16365781wmc.39.2022.08.23.01.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:31:08 -0700 (PDT)
Message-Id: <f96d5ab484c4971fce65f832185237ede0d37659.1661243463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
        <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 08:31:01 +0000
Subject: [PATCH v2 3/5] add -p: avoid ambiguous signed/unsigned comparison
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
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

