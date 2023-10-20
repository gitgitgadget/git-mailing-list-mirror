Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CAF1DA4F
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="rfz3Az0Z"
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B48CD63
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27d3ede72f6so989392a91.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697827195; x=1698431995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfp2jpXzcwpQzfwsObm+2FqmG2xIpjyIXGdvyhBV93c=;
        b=rfz3Az0ZbmHZIvFTFBI+l5UKRX05N9U7gn4AUIWpyJZrrQuZalmdR0NqpO9nU8yxhS
         tdIk1khDXC+oyQWeHyGqCJ2zV2xtr8pmcCGXwViZGjw9zG+oPcuN3lm/xUtqaY+Rlh7D
         kS6YOAv128spsw08v9TU3ldD1cKRd0iklpojQ3rEvCx6QhLP+JUfZG8Yb6uhMqmEn+A9
         nU3pHVbVUTUWRtaYCXDSEnL3h+c8kQoKTjJTgNPFI/PyHejsx55M2Nbh+Y16EEeSfRtQ
         rG1LWOyZhmU/Aq7jlr78Lo00DZO59PPevBn2AjmEtNnsz06IkcUQw4RaeknTOG1ZSDAJ
         MHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827195; x=1698431995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfp2jpXzcwpQzfwsObm+2FqmG2xIpjyIXGdvyhBV93c=;
        b=uCqWAq2TEV1ss1fjCscEOTary2aZWe10Zpsquvo3fr56uGIIiuWD6klFsuifcuHvbD
         rXI7t56tDul6FH9yUOK/lfuDXsIF7M0XodBsgf1sEQTsSvwiPnX4CNSGAH1JQ6PKcqRj
         1Z8TllduKIQUCKoS72ywGv9GHKlOw/csngFlWJ8TV7NRm3H6oj1XQJkofEYXetzPL9/T
         wwtYlt+E3Np7nrXr+penfk+7Bur++txsgOCL8y+y9rpns3WZfgsBfENPitPZ5NPkJ/yo
         7POAWdGpe61wuhdwGPZpqdD4maJairqKcFDftOEXDZqAmIAtK0DgC+Bm7sgTfwL2FsWS
         +91A==
X-Gm-Message-State: AOJu0YxWTjrM8V2c44cB5P8s/nGaLniycY6ZxVdMxpqy3obdElpjbkPd
	11/7//tVSrvjAIDkDWxuW3kvg87E3Ya2/Qax1FRarENjZ2M=
X-Google-Smtp-Source: AGHT+IGbi6JCj0I/W1pDZgZpWdGdoIzTyViSgjdtEFHwcIZnvQQ7zPV6Yctcb6FZelqVHSNhSm/KFg==
X-Received: by 2002:a17:90a:d181:b0:27d:46c5:5e20 with SMTP id fu1-20020a17090ad18100b0027d46c55e20mr2593427pjb.39.1697827195609;
        Fri, 20 Oct 2023 11:39:55 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-46-176.mycingular.net. [166.170.46.176])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a5d0f00b0027e022bd62fsm2994353pji.5.2023.10.20.11.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:39:55 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH 3/5] status: add advice arg for -t, --table flag
Date: Fri, 20 Oct 2023 11:39:45 -0700
Message-ID: <20231020183947.463882-4-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.402.gbe8243af7b.dirty
In-Reply-To: <20231020183947.463882-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 table.c     | 19 +++++++++++++++++--
 table.h     |  2 +-
 wt-status.c |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/table.c b/table.c
index 87b6df8c66..73751339da 100644
--- a/table.c
+++ b/table.c
@@ -76,7 +76,7 @@ static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, stru
 	printf(_("|\n"));
 }
 
-void build_and_draw_status_table(struct wt_status *s)
+void build_and_draw_status_table(struct wt_status *s, int add_advice)
 {
 	struct winsize w;
 	int cols;
@@ -95,14 +95,29 @@ void build_and_draw_status_table(struct wt_status *s)
 		cols -= 1;
 	}
 
+	/* Draw table header */
 	build_table_border(&table_border, cols);
 	build_table_entry(&table_col_entry_1, "Untracked files", cols);
 	build_table_entry(&table_col_entry_2, "Changes not staged for commit", cols);
 	build_table_entry(&table_col_entry_3, "Changes to be committed", cols);
 
-	/* Draw table header */
 	printf(_("%s\n"), table_border.buf);
 	printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
+
+	if (add_advice) {
+		build_table_entry(&table_col_entry_1, "(stage: git add <file>)", cols);
+		build_table_entry(&table_col_entry_2, "(stage: git add <file>)", cols);
+		build_table_entry(&table_col_entry_3, "(unstage: git restore --staged <file>)", cols);
+
+		printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
+
+		build_table_entry(&table_col_entry_1, "", cols);
+		build_table_entry(&table_col_entry_2, "(discard: git restore --staged <file>)", cols);
+		build_table_entry(&table_col_entry_3, "", cols);
+
+		printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
+	}
+
 	printf(_("%s\n"), table_border.buf);
 
 	/* Draw table body */
diff --git a/table.h b/table.h
index 30e0d5509b..6017923bf9 100644
--- a/table.h
+++ b/table.h
@@ -1,6 +1,6 @@
 #ifndef TABLE_H
 #define TABLE_H
 
-void build_and_draw_status_table(struct wt_status *s);
+void build_and_draw_status_table(struct wt_status *s, int i);
 
 #endif /* TABLE_H */
diff --git a/wt-status.c b/wt-status.c
index 24b56ea559..62731859fe 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2149,7 +2149,7 @@ static void wt_tablestatus_print(struct wt_status *s)
 		wt_longstatus_print_tracking(s);
 	}
 
-	build_and_draw_status_table(s);
+	build_and_draw_status_table(s, 0);
 }
 
 static void wt_porcelain_print(struct wt_status *s)
-- 
2.42.0.402.gbe8243af7b.dirty

