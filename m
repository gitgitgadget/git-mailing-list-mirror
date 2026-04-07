Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D473B19B4
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562794; cv=none; b=dCBLthibxAenXQFD1GxbA3lzwmukXOnpbnAx8B7ZHNTshTJmt0ukShAi4oFcol89ywuF4TuO5PdgXWWHWPGJ2RQI2pKHzBImU5hOkyX80ZMzpUw57b5p60mLuFCOLNLEn7rH4rVRRbfDFf8onpbKhVSc6HG7/d9XbWBPEB5TOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562794; c=relaxed/simple;
	bh=dOigalPHK2ApNohpPZuA+ExzRxlodpPXl4UBKxKxPhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emZBsZ+hdOmh/1ZD5byq2sG8CMqGFs08gaTqXVWVCzTFHHdxqicX0O8rsqCAG0TveJ9rKRlhTgCDNggAoH71zfJ3ys7TtE/YnbqK0cpMR6kxFrrFnKFCXGnMYjVg6ni6ROgVqFCgXrn6Wg20NXy4c5cpEzXoGadPYWD/RFZwI2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaEBlp3+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaEBlp3+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfb723793so3165608f8f.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775562791; x=1776167591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xe4lSOYELERgN23eZjWiZSc7rhKz40RKxr4uOyh3YgE=;
        b=QaEBlp3+1kLbWcEv60xj8tSIsAOtQnbONrlYOx1Zy+E3INmAjeaIkfG4hKiLsg5JKf
         bzenarwq4NU2fWcwcLQ6ujU9DB/RG5IFEIpr0ItrNHf8GEpVyGl2ylEYkuMz3CY21BXk
         gIWTQ67WV0VwyjljLQazRKw7OD8vdPfUW1/EtRIS8zuzqnJv30rkU3uMfeOGpmYODB0p
         wxDdLhzbY+mxcv/dbUQmdPQl/LEnFwCjsBePt7HCRrzo+6vg2oDVohLEpDR79WqRdzvt
         sqPnGjn1wSFKOJwWUxpm7kWZjBrhXuurNpwFaWLsj2yhEfFpI1Vfa6djhqY6f74FUI0r
         DuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562791; x=1776167591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xe4lSOYELERgN23eZjWiZSc7rhKz40RKxr4uOyh3YgE=;
        b=S6LwSs05x9NxHcJvGx41qH4wixIpyiM3nZmLhFWDA6epAQ6zSisYX4n+DGPU51068y
         4MGYJ/mqi2ffq+qW2Iq3UnICO7vO42xLgeIhx/ViGa+7vHSag8PEGM/wjcd9mE3D5jAb
         WN6Kb5rL3dhP0e3GYWEL9Ow0JWowtwMh/eqsQVWPO/VQ+htGCnk1BOzK03A4tCnCpuQp
         fjtSwqaxUFfA9yR6hKJXLs9gEiTYuJvANJIRa7k27f2PhbiZtqDHzJ8odCPBzrSFWVnl
         MItwz8KXeLws5CWn1z3N1j8gCxctybDPLSHGv29Straek6IF0dfm/gXx0TC2f/77AY6/
         ZCiw==
X-Gm-Message-State: AOJu0Yzg83ydKrt4i1KjFKuQ8qT97Qa8pT7UIQXYdostLU9mcW3tiUYS
	jvo1hC0eRY3Vu/9gZB2zZ+pRuiflYFtvWvkuVu98BCvk2mHWwZki6Ei3fc3l4A==
X-Gm-Gg: AeBDievdXn4S5ZzqqNhqNOWkbJ4mfgigS6G/bU68bsqa+Sz3Agr5yhjmicgtkripoAp
	JV3hDWMvq5u0VNqoXlEsI9i1+YJ1fX1IBXPMANwpOo3p6XPyfIT6OK4yylWipWOGCtPgHwgLXMx
	5mHk/UqRfiyGQ6q1zVu+cTVaO05ZZ99+FdP+tNoa1zbm9fZqcDPVyPQTEU2H4fQWDVSLFIhkr7L
	zUxNF4vZpMWh1sFhglEgFJDilRKn/oYBp+gelvTQsnuGvpuLtAVTHH0qDwU90L4vVb3sev8K9vF
	CSu8GzLmcPYyacjKKUfCWzWUMYA6mq4kOVhRiG2o1UJCQDqiy53L3k+u3yv6vfO8O2hTWopf4kX
	poVZzQeSYASpJElbdOhQW4DiEJ1mM8xKqRMtbsqhyZkte+dylancYBeF85BLZPONXZSmwN2VpqC
	qa+yhyBN2YWx2g9SZWSXy/pGO8YL9cdrkBgq2gCc2Rgrkvo4j6+rAOPBt5Rd+0OP4MhfoRi4nKo
	+e3RKFNtD44ZHGQCURfd786MsAD69T6lrz0QAE=
X-Received: by 2002:a05:6000:208a:b0:43d:292:18a5 with SMTP id ffacd0b85a97d-43d2929d6f9mr21907969f8f.18.1775562790745;
        Tue, 07 Apr 2026 04:53:10 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm45050794f8f.7.2026.04.07.04.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:53:10 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 08/10] promisor-remote: keep accepted promisor_info structs alive
Date: Tue,  7 Apr 2026 13:52:41 +0200
Message-ID: <20260407115243.358642-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.rc0.114.g05d466edb8
In-Reply-To: <20260407115243.358642-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260407115243.358642-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In filter_promisor_remote(), the instances of `struct promisor_info`
for accepted remotes are dismantled into separate parallel data
structures (the 'accepted' strvec for server names, and
'accepted_filters' for filter strings) and then immediately freed.

Instead, let's keep these instances on an 'accepted_remotes' list.

This way the post-loop phase can iterate a single list to build the
protocol reply, apply advertised filters, and mark remotes as
accepted, rather than iterating three separate structures.

This refactoring also prepares for a future commit that will add a
'local_name' member to 'struct promisor_info'. Since struct instances
stay alive, downstream code will be able to simply read both names
from them rather than needing yet another parallel strvec.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 8d80ef6040..74e65e9dd0 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -890,10 +890,10 @@ static void filter_promisor_remote(struct repository *repo,
 {
 	struct string_list config_info = STRING_LIST_INIT_NODUP;
 	struct string_list remote_info = STRING_LIST_INIT_DUP;
+	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
 	struct store_info *store_info = NULL;
 	struct string_list_item *item;
 	bool reload_config = false;
-	struct string_list accepted_filters = STRING_LIST_INIT_DUP;
 	enum accept_promisor accept = accept_from_server(repo);
 
 	if (accept == ACCEPT_NONE)
@@ -922,17 +922,10 @@ static void filter_promisor_remote(struct repository *repo,
 			if (promisor_store_advertised_fields(advertised, store_info))
 				reload_config = true;
 
-			strvec_push(accepted, advertised->name);
-
-			/* Capture advertised filters for accepted remotes */
-			if (advertised->filter) {
-				struct string_list_item *i;
-				i = string_list_append(&accepted_filters, advertised->name);
-				i->util = xstrdup(advertised->filter);
-			}
+			string_list_append(&accepted_remotes, advertised->name)->util = advertised;
+		} else {
+			promisor_info_free(advertised);
 		}
-
-		promisor_info_free(advertised);
 	}
 
 	promisor_info_list_clear(&config_info);
@@ -942,24 +935,23 @@ static void filter_promisor_remote(struct repository *repo,
 	if (reload_config)
 		repo_promisor_remote_reinit(repo);
 
-	/* Apply accepted remote filters to the stable repo state */
-	for_each_string_list_item(item, &accepted_filters) {
-		struct promisor_remote *r = repo_promisor_remote_find(repo, item->string);
-		if (r) {
-			free(r->advertised_filter);
-			r->advertised_filter = item->util;
-			item->util = NULL;
-		}
-	}
+	/* Apply accepted remotes to the stable repo state */
+	for_each_string_list_item(item, &accepted_remotes) {
+		struct promisor_info *info = item->util;
+		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
 
-	string_list_clear(&accepted_filters, 1);
+		strvec_push(accepted, info->name);
 
-	/* Mark the remotes as accepted in the repository state */
-	for (size_t i = 0; i < accepted->nr; i++) {
-		struct promisor_remote *r = repo_promisor_remote_find(repo, accepted->v[i]);
-		if (r)
+		if (r) {
 			r->accepted = 1;
+			if (info->filter) {
+				free(r->advertised_filter);
+				r->advertised_filter = xstrdup(info->filter);
+			}
+		}
 	}
+
+	promisor_info_list_clear(&accepted_remotes);
 }
 
 void promisor_remote_reply(const char *info, char **accepted_out)
-- 
2.54.0.rc0.114.g05d466edb8

