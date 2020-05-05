Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B3C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5809720658
	for <git@archiver.kernel.org>; Tue,  5 May 2020 10:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqCY3lBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgEEKxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEKxd (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 06:53:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342FEC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 03:53:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so2175072wra.7
        for <git@vger.kernel.org>; Tue, 05 May 2020 03:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VMak9HU9yaUDZPpEf5F3+82C/SCraCowaObu4kwKV4=;
        b=JqCY3lBQnCxk3px+urHzVmnVdLhLJGe8eDH3HX7TI1oGFMmCdX7+XaFAyYA8ou6kgL
         Yf5fLV1Xp+Gb4N5TbAhffSDUt1u+RvTzjBr1Iz6irWqKd8M7Sn/EM2b8C//zueG/IkNJ
         hcyfUbSjvDY8P7XLcfivcIkcVkLVPHC5Ufg6Voj5wEuSs4MIrMSpQJNNOqJcguV2Is+b
         OdKriT5iPfjM95J2rf4Aehz+VklGtbxlvSeqYS10aAgwysO2HXWJ3mgXkdSt4i0795OU
         /Iulr9c5IOBrl++z2zKV6roNOeItPXmqVVZJtQGbzaKeqqgeYsXwMkbX8mj/65OAMd+L
         vdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VMak9HU9yaUDZPpEf5F3+82C/SCraCowaObu4kwKV4=;
        b=K6M0l3mgxQEpL+J3XqjCTgqoRMpV6M+DJaOHEczll1+6Ve/7nbtgzRnwQqnQCWfWsp
         R62o+c+XwpUmx482rv0HFCU9FRnkBpa2hTo2jbsCOlVKG41lPIDeaNVLH2srvQnDvhZU
         ilYBDY/YhwDi1aB9rase9Y+lxgimrd35iAfDjuMyuCelfyTpG/R7afs060e83rGmsqMo
         1Vx8QZ+GPyDm9WXl3/Ogp4mx5qakMthvUewqHRSBtOWjZoghSTmHq3YYwAeBnkU3HMW+
         78oHccl88wT8HXTGlnCpxwBAu+Pz7vc3BeOcrWFulvJqYuD0La+yaqAHkGBaJCVHTWfU
         rcbQ==
X-Gm-Message-State: AGi0PubFYhJibhGhuuI0hlb5wtOUHlWF4g+SZD0d1FVnELiFCxFfeFeb
        8aYvEX/cMYD3tPjBLu+4CfvUYg52
X-Google-Smtp-Source: APiQypKvQxqpihUrDRhm08zQSrAHkre/UNS1MVPK0JdK1a5hRjFhko8ChdDCoieLHmzwL9vfxp0B7g==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr2986551wrr.162.1588676010730;
        Tue, 05 May 2020 03:53:30 -0700 (PDT)
Received: from localhost.localdomain (atoulouse-654-1-289-61.w86-199.abo.wanadoo.fr. [86.199.72.61])
        by smtp.googlemail.com with ESMTPSA id b85sm3170326wmb.21.2020.05.05.03.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 03:53:30 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 1/6] stash: mark `i_tree' in reset_tree() const
Date:   Tue,  5 May 2020 12:48:44 +0200
Message-Id: <20200505104849.13602-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505104849.13602-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reset_tree() does not change the value pointed by `i_tree', and that
it will be provided with `the_hash_algo->empty_tree' which is a
constant, it is changed to be a pointer to a constant.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 0c52a3b849..9baa8b379e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -228,7 +228,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
 	return do_clear_stash();
 }
 
-static int reset_tree(struct object_id *i_tree, int update, int reset)
+static int reset_tree(const struct object_id *i_tree, int update, int reset)
 {
 	int nr_trees = 1;
 	struct unpack_trees_options opts;
-- 
2.26.2

