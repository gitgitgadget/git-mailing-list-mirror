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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D818C2D0A8
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02576207EA
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 11:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOgmH0Ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIALAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgIAK6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:58:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D52C06125E
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:58:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e17so700491wme.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UP0BDiHyOIXjIhcXINm+wriN40jQBqFkCxfYopWe1MQ=;
        b=WOgmH0Ip3bOynHjHg4HN1bsQpit1U9Jc05sVWM3uyS5qqvBBkzAOop6wskhH3WRemb
         tfYPEVN6a2p5GT7svCwXBjCp51MRgTNNg/Mumn7u9pxwYa0oeH+MZP0e3lrxldR2zN3j
         6Y6oKlXJcwjCuQL61wLuXFN57xvNU3TpeLoYv0QuIcvHFduSH/mJDnUt/nUQEUtExn8o
         s/7QyobOWosbte78fJTRUp5+GgbBF4rhflI1Zd/DNTo4gnpWOxJOGaUgCYkGMG4lMoJp
         HHN2JzhMr5wj/6BppYRbqzWhTbafGaqqTuCkXX4OdKMA9EpC9u+nAIEB2PJFPa+Qs+CL
         AdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UP0BDiHyOIXjIhcXINm+wriN40jQBqFkCxfYopWe1MQ=;
        b=aR60BzuCVQfSrYGRUSCYzoL9PjGAHESoGCj8Do87wUb1ssv5q9zu1GttoZuTONPuxf
         iziV3NFq2IZrR7xXRJNJ3kIr4jjOahKQrNq4bGcRlGQujdeR3PYcBIjchdyIbhhVq28z
         UQTtH2nt1VpS+j2NZN5fJ3H/Tai7Dnz8GxTCyT2D8UJBIJbBiOhLhk/ik+Jy2sh2/Lx4
         57lr47wUM///aM8itZ1syP8zrHLrkbZ1IBZgyqN4C6N8TVD5JGlyQqeD2xmGXO4SW1Fl
         oxcw+gm8bjUQSnensH5Sht0/XWB1teCKP8Pks6VF8RPBTzDuObYJKI5rb7fXTxGzb4Y1
         gRUQ==
X-Gm-Message-State: AOAM532ELh8LXNPlQB9Tyl5JpBi0tWqAVkrG0InMs2QkeJN1y5jyQOi0
        ljWw3rdtB83+0knVhOznwgJdwitBCC8=
X-Google-Smtp-Source: ABdhPJzKsN/T7CRXUavm7kkj3fiPLQuBCHcDfwbq85pQCJF9ZUN2wyhvar2wu3dk/VfiZ8DsWHxHSw==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr1162241wmk.47.1598957902024;
        Tue, 01 Sep 2020 03:58:22 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.googlemail.com with ESMTPSA id x16sm1705875wrq.62.2020.09.01.03.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:58:21 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 11/11] sequencer: use the "octopus" merge strategy without forking
Date:   Tue,  1 Sep 2020 12:57:05 +0200
Message-Id: <20200901105705.6059-12-alban.gruin@gmail.com>
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

This teaches the sequencer to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index c4c7b28d24..34853b8970 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1927,6 +1927,9 @@ static int do_pick_commit(struct repository *r,
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
2.28.0.370.g2c2dc3cc62

