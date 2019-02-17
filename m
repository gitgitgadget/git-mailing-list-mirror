Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E72E71F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfBQKKI (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:10:08 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:35580 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKKI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:10:08 -0500
Received: by mail-pf1-f176.google.com with SMTP id j5so2574268pfa.2
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJHNSWD+hZes9h3goPojJ2P3XDQYdq90Qj+wu5hUo1w=;
        b=oTJxXuuWhRQoV5lObo4p8TcX7t/SB7XoxKNR6zb4O7ESYEdkiB+0MR54Xz8kQPxv/+
         vnQF5n6qWwMOc+KNLrkOeex4/LR/KOYlhf+9koHk92lXpCsg5D9HNQNnbreigoigqHzN
         ay1mKD/CIXKVURaezlWMJLBJ9qf+RYQ50dYnRxSyA+t8+S14Pz/OjjSfCVGpi/zXoRZp
         GyUKeyffM8ErBX8Q2r7Jr69IMDBq6p4wYIbNq5Yz8D6qRm2FTqArqdt8W7Af9GGAul9V
         qcYIZcYYvf2ipFF+ScCLWpJpDybnxHIVMHu60RbTfZKxZZQHZSdY8tk5NEh9QPcYYYRF
         bbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJHNSWD+hZes9h3goPojJ2P3XDQYdq90Qj+wu5hUo1w=;
        b=dyjIQQ0NevN5hq/ImrVNwFt9dv6Wl9KpJ6Bhw8SNMKzankPcY2cA7mxCLiSWCk4mnt
         KlD4OXb2t5YdXLJzAaBwfHFkhT9vSCNgisN4u6OVQeiWGY3ewbd0iJXE9urur7hdTqIZ
         +TW8aWJ75U/Kf8p6526cgNrwe1R7TPC2P46dUUDPN52zwyLGMuLKtZ6Yq264b1p5Q+mH
         MIsTcuEZ/oX+1t/qxWjhIe5pyeKSP2gHJmLA10To85Et4ag/n5L8SbwqE/zLFdWdS3/g
         2LIdp6bNNnCnNHpNyKh8FeiOf+XsCQVGLtrGconKWV0YP6ElW2mRKTcW01IKGhWYP7fy
         FdVQ==
X-Gm-Message-State: AHQUAub3FlT1evcGoHWhlY+yFOj7lhErsRSnGgCzj9QD7XUJvFsyilPe
        VD9+9kwOl2tHxvIyOcevSZwPhWlo
X-Google-Smtp-Source: AHgI3IaLOdrn2rnCvfjpWVo1O+JAPmrBMOVS1SDTF4gdrR7nZrpQJnpX2Ug4bl03bTZC723bzt58fQ==
X-Received: by 2002:a62:e515:: with SMTP id n21mr18808067pff.159.1550398207594;
        Sun, 17 Feb 2019 02:10:07 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d13sm16808180pfd.58.2019.02.17.02.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:10:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:10:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/31] sha1-name.c: remove the_repo from find_abbrev_len_packed()
Date:   Sun, 17 Feb 2019 17:08:53 +0700
Message-Id: <20190217100913.4127-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 7558ce51a3..b9381aaba6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -514,6 +514,7 @@ struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
 	char *hex;
+	struct repository *repo;
 	const struct object_id *oid;
 };
 
@@ -619,9 +620,9 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 	struct multi_pack_index *m;
 	struct packed_git *p;
 
-	for (m = get_multi_pack_index(the_repository); m; m = m->next)
+	for (m = get_multi_pack_index(mad->repo); m; m = m->next)
 		find_abbrev_len_for_midx(m, mad);
-	for (p = get_packed_git(the_repository); p; p = p->next)
+	for (p = get_packed_git(mad->repo); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
@@ -658,6 +659,7 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	if (len == hexsz || !len)
 		return hexsz;
 
+	mad.repo = the_repository;
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
-- 
2.21.0.rc0.328.g0e39304f8d

