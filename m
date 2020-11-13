Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A792C56202
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150962224C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTaKp0NC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKMMLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgKMMLE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:11:04 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD11AC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:11:03 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r17so9634936wrw.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9YVjZ1L8kzbu2itpBCJA99lobPJTsxMd/HON2LJPvg=;
        b=nTaKp0NCkq6Np5oBpIY3JsTtV+r/B6wnSrgW2RzhZYJbdk43NU+hoEObHAj7XXTH+p
         UtvgdLrMlt6YHl2P4W7vCGTgGIZWrLRVIcOCW27i4iNhgxmen9EtbOzy/kHToH6FehfQ
         z0YfbxnzPFWZ5zkwQAde0EhYI3C6CMStLmVAHlKEbo86YcrNiGYnCpKo1spxaq4a0IVh
         zNMP/0lK65P/LHiy1/WIb1CVFwNJjuCiTddmyK8MksLnFP74BtzaKt3iVrDOiUcdaHFS
         pORj5h9hVcRuFem3jYBiXNr3EOu2oNIXkAXjWIduaMuoRAnd98c+STIlyo2NdCW+KUpn
         h8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9YVjZ1L8kzbu2itpBCJA99lobPJTsxMd/HON2LJPvg=;
        b=DkJP1C6QsH6gqw+D6yxmeplQ86yU4Snhy2AswVRkIQHR5PUSYZXUhtGOEV1LhiWOGY
         i6o1wsuIYppxMd5GshzC9aA625LNW7SY/jTcWmJdJk5HPyEPQApogccJESTSU5bWgMSr
         rHo7vEecCU6mwryOzA7/acbE/ch/S9aspcAWExJqrV+zC9yVhD5wqrwksWJe9z2Xv6Sg
         3B5B5mGbDYWciGY9UtSDzGo82gfXoV6XuNe8yCq2XOHmF5m4zFu/zNA2LYZEKvZK0byx
         mu5nFkdNxC6ZV0dO+X5N6n4+jlee+gCv8hE20JFqE17GkKG9OIdf/3pIoM5Ng7HECs20
         +89w==
X-Gm-Message-State: AOAM532Mjs/1cikRsJwVsxjn1baSa6J3e2R+MAEj6TOciGz1rBIpuB6y
        YLIjStMhVA5Iqqh7Xvj8KwVR/SXfFY4=
X-Google-Smtp-Source: ABdhPJylmlLU1NdphYDMvKroaGh44auuQlPDOUgJ+CqgFyqlaNdZQ87T73qdzlpwe0zWDTVvREMk6w==
X-Received: by 2002:adf:f349:: with SMTP id e9mr3084719wrp.110.1605269462267;
        Fri, 13 Nov 2020 04:11:02 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id g138sm10083697wme.39.2020.11.13.04.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:11:01 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 12/12] sequencer: use the "octopus" merge strategy without forking
Date:   Fri, 13 Nov 2020 12:04:28 +0100
Message-Id: <20201113110428.21265-13-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113110428.21265-1-alban.gruin@gmail.com>
References: <20201005122646.27994-1-alban.gruin@gmail.com>
 <20201113110428.21265-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index ff411d54af..746afad930 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2005,6 +2005,9 @@ static int do_pick_commit(struct repository *r,
 		if (!strcmp(opts->strategy, "resolve")) {
 			repo_read_index(r);
 			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else if (!strcmp(opts->strategy, "octopus")) {
+			repo_read_index(r);
+			res |= merge_strategies_octopus(r, common, oid_to_hex(&head), remotes);
 		} else
 			res |= try_merge_command(r, opts->strategy,
 						 opts->xopts_nr, (const char **)opts->xopts,
-- 
2.20.1

