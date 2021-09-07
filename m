Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11BAC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B1660F6D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbhIGLAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbhIGK7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DA9C0612A5
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k5-20020a05600c1c8500b002f76c42214bso1462490wms.3
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+Fg1O4GBlWOOuoTj+YWVJcfh8FfRPMY1UToyXwX/vY=;
        b=nnEuUyVZ4pek3VXCj1r2ydHq0A5Q7yGMH5pqMo2KkPoh6BdCC8ZcMlqpxFIpG76w5u
         YcqpC8ij3SheQF8gDbsWHCbskERIS23fmsi2cby/vm1QJglyoBDmWayNfUSdD0KFdMlN
         TbA6gz/MEP8VOlwWDBddTHvFuDT7Oh+KuouQcm+/1Gn2yeeChOm4R8OQbh1DM+TiQ8bb
         rDsLr0NoR8L5YbJ4eZDhy5elb/garVipG+i3PxhMyMCiXK65HAPfyoBAq/JhloycwZHw
         M0hTFtwnh2MGzsJtcThpfD+nK0CVnN/xpMoEnJ7Ht9m9404HxHBSbeYyMt8AzFHTgZ2A
         gZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+Fg1O4GBlWOOuoTj+YWVJcfh8FfRPMY1UToyXwX/vY=;
        b=NYiyWo54jBXClK3yZ/NwO4HHfAEQXrg/IRq1Qm5EADBVtae6a4SjFfzVJTsGfzVCyc
         /5TjloS0bg8Rnjx48EElbv9CHnbJn6ZWsHz1sDCef/X93O8IRJ+HSfXUWfdWjdlpaloB
         7LM8aF29ddw9GUHIMxfdXDpNAFAGEyG/nZiKwfvbw83RJe3Zl7azBQpqGkXLbWup/D+z
         0MpmJS2T1lYxYSQpgxUjFxt4ysvYJxC4Ce4M4jJg3iE4I4+ylvYU6sVSkZVmwstkvgIl
         y79zN2M8mnjjhWJ39Py7i9E9A3eTQzj2QjxeoP4Gh3QS1kur1Wb1bkfuNS9JTeaLokDX
         jTRA==
X-Gm-Message-State: AOAM530hpsQMBHOGhRz32qCVd8hpQyXIuMPFHBFauRDPipW9FVjYjI2S
        +nUD0cBcJoz8KhKJlJJECte193tjBtY99Q==
X-Google-Smtp-Source: ABdhPJzimwIXTrxVjE8YuHAbhLxgL/rBPb2njGSar7NswPYKtYa8/dOls42EUlcOQjbsQzbx1pTkrA==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr3348571wmb.59.1631012318182;
        Tue, 07 Sep 2021 03:58:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 15/22] object-file.c: guard against future bugs in loose_object_info()
Date:   Tue,  7 Sep 2021 12:58:10 +0200
Message-Id: <patch-v6-15.22-3fb660ff944-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An earlier version of the preceding commit had a subtle bug where our
"type_scratch" (later assigned to "oi->typep") would be uninitialized
and used in the "!allow_unknown" case, at which point it would contain
a nonsensical value if we'd failed to call parse_loose_header().

The preceding commit introduced "parsed_header" variable to check for
this case, but I think we can do better, let's carry a "oi_header"
variable initially set to NULL, and only set it to "oi" once we're
past parse_loose_header().

This is functionally the same thing, but hopefully makes it even more
obvious in the future that we must not access the "typep" and
"sizep" (or "type_name") unless parse_loose_header() succeeds, but
that accessing other fields set earlier (such as the "disk_sizep" set
earlier) is OK.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index d656960422d..ae6a37ab5fb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1416,7 +1416,7 @@ static int loose_object_info(struct repository *r,
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
 	enum object_type type_scratch;
-	int parsed_header = 0;
+	struct object_info *oi_header = NULL;
 	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (oi->delta_base_oid)
@@ -1464,18 +1464,20 @@ static int loose_object_info(struct repository *r,
 		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
 			/*
 			 * oi->{sizep,typep} are meaningless unless
-			 * parse_loose_header() returns >= 0.
+			 * parse_loose_header() returns >= 0. Let's
+			 * access them as "oi_header" (just an alias
+			 * for "oi") below to make that intent clear.
 			 */
-			parsed_header = 1;
+			oi_header = oi;
 		else
 			status = error(_("unable to parse %s header"), oid_to_hex(oid));
 	}
-	if (!allow_unknown && parsed_header && *oi->typep < 0)
+	if (!allow_unknown && oi_header && *oi_header->typep < 0)
 		die(_("invalid object type"));
 
-	if (parsed_header && oi->contentp) {
+	if (oi_header && oi->contentp) {
 		*oi->contentp = unpack_loose_rest(&stream, hdr,
-						  *oi->sizep, oid);
+						  *oi_header->sizep, oid);
 		if (!*oi->contentp) {
 			git_inflate_end(&stream);
 			status = -1;
-- 
2.33.0.815.g21c7aaf6073

