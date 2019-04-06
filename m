Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF19D20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDFLgZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:36:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35703 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:36:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so4502664pgf.2
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Sww8ndWyCxak9+iI+JOYHneVIA0yT5/XJ9VtPjuYpA=;
        b=f4Q0HY+bg97liuVWKm11VNnhybB/AwGGTF7IYl4kb9OcUnn3BQ9yd536FKDz5Uex+L
         fFYchRQlAeG3x0wiuIjuz62+8jXRiAeCCtPaVH/l3GcGLOgrAiFYimjdnLdY2OaHnvpG
         lwFnYYT1UPIoe2fwvbPHH5NrHLy/k8m1uOdxZJFHU4P7SeDF3SWVaxo5bm5TwgYZvT/O
         xOxifl4rsLTSHyvtNK8Qt7m7lgU9eE/aT4zDUY29veMZK6pTnihP4xECSenqqzbBbNlx
         bRND98uH9D7aYkHPoJ5W9Z1SoFe+TSREYdRoQL9rRTACFqkwhPGeFKuUMN1a1lQeyTUY
         mnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Sww8ndWyCxak9+iI+JOYHneVIA0yT5/XJ9VtPjuYpA=;
        b=MuZFP7qbvpic+O9KmIybmYKNYXUkxxbb3PP3A/Jo34bh1JOZK6o2hBTxCdtatLKcXV
         gj8kGfzHJVOCuWLVxFQ1kcC3mKhJsEMAym7FGTrFtAoV8UoS49dJ4u9r6wn1RVfXSV6i
         CYULdhryqbdsEdcTuG+lf7whubKVwoUm/yN6iNO7Jh2iJfH2yQArhcuy6PXa36ANuo55
         zKdDmrL2JzI/Lvyulj5jzcPSdSXQyJEUESnBJQXzVxKQO0VfZiq2SKVSScjjFYzBnqT0
         BiFuKfBWjs7BbAccqPjZUyU+rekHikiBddf3kEFaVtR4JtW7JHkrH0rff59q0bKwXu9j
         ORfA==
X-Gm-Message-State: APjAAAUuyNUlr1y4sDx+9fT9JpmnwxTn62/VVIBy2xNHH0R+Tegm3eKV
        dxDNbxOA6tTV1XDlD+94d4xRnGUy
X-Google-Smtp-Source: APXvYqz8DiXnxMpubGfILz6QJIM8rK5+HLBgntKPspAW7b9YvkeWakrfuxROxWmsu4xXz41jDVzk7w==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr18470672pfe.163.1554550584709;
        Sat, 06 Apr 2019 04:36:24 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id q74sm16096692pfc.111.2019.04.06.04.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:36:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:36:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 13/33] sha1-name.c: remove the_repo from find_abbrev_len_packed()
Date:   Sat,  6 Apr 2019 18:34:33 +0700
Message-Id: <20190406113453.5149-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
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
2.21.0.479.g47ac719cd3

