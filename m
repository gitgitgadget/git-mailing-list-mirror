Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A824C2D0A6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE81E206EF
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfRUPJja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIALAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgIAK6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:58:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82A3C061258
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:58:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b79so701334wmb.4
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/hV9SN8IDBmxdUCYEQZ8yHoyBTK4NFUOsNgfQYw5yus=;
        b=IfRUPJjaiXhRPOc43TX2u53odOET96rAz1mN0JZFmvzYo6yY98Qmjl3gATz89ygCAE
         IM1EiUnWY7SQthKHABdfWcwtDddlJ8i3tA9oLM/PqKX0aRtIgp137CZNLt34NQy8uy4S
         AcU6GXjd0RuinhYIHS62NtKhBptVX8tmUdyYbOD/efgwxAS2HOC3HyqcSNUUKICUXv3y
         ws7hhd0mdL7IjUuqnIbwam0voMR/3r6i2qH+QpJTV5DjlAqT/kzWAmmCGcEvYKKN5bW5
         Iown9o1NXMX4Le0gXDs033usJYrJPY+DQbo/pjx8g8+Gar8u92dJGXsvIzWzucOZHQ23
         vqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hV9SN8IDBmxdUCYEQZ8yHoyBTK4NFUOsNgfQYw5yus=;
        b=dT7CSxiyR+8WU7rJCXBP5ifHXavF1Y9Axa0uN+YGmxEoHAPvoZX3NuGqB3bbEkioyG
         HhRsFsXljXmtM078M+o0NvbyXp8zOT1+dwMrh0SPb5UBn79ym2pBhfDPYol5uO6guh+c
         2s3kEK+fDaiBNAwN8YrNaVCqgf+aFNjjanZtzR99bSUXT/WgtsV3R0l36CFqseRSOxdK
         H0ZETXYh7Fq1+9gHFWai+wG8Ez+xUeeuCk/+D8KoS0Tg7bVbDVmnQNASxbbcqkFdT5Re
         RmRQRYm9iOr391TH7/7cnn+lkVFqmT94wmnaAj1qe2f8D6SijH4uxLbqpzlA8740nk/2
         CHFA==
X-Gm-Message-State: AOAM532cdlO9O9+9x3Oxjxe32AFZI4iLIPd4BE4ObmZeHqXZbG+LVqI+
        mWRqKfVJz8SIf2Kuq6umNix6+if6z4Y=
X-Google-Smtp-Source: ABdhPJwCFjSYuZHQV7cjaL+i3danrpf812K6gRbYZK0WKSYChc9wKHWhNemOpkdNQRLa5DQXhoNaGg==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr1188889wmh.140.1598957899712;
        Tue, 01 Sep 2020 03:58:19 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.googlemail.com with ESMTPSA id x16sm1705875wrq.62.2020.09.01.03.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:58:19 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 09/11] merge: use the "octopus" strategy without forking
Date:   Tue,  1 Sep 2020 12:57:03 +0200
Message-Id: <20200901105705.6059-10-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901105705.6059-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200901105705.6059-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 541d9bed02..90e092ad02 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -744,6 +744,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	} else if (!strcmp(strategy, "resolve"))
 		return merge_strategies_resolve(the_repository, common,
 						head_arg, remoteheads);
+	else if (!strcmp(strategy, "octopus"))
+		return merge_strategies_octopus(the_repository, common,
+						head_arg, remoteheads);
 	else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
-- 
2.28.0.370.g2c2dc3cc62

