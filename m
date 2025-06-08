Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016C5323E
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749353273; cv=none; b=P51WNpm3EsaxAUtyp7VLINkT6ZuKZQ7Ao7ZlNjhe81f0dZMNKMvyQ3RJfQ4+J/8Fny73frll9xFtvxN3U0YfWMvYOfmfDYTxudNcnPvcq8uPHqmLkKJq7v+cltH6frxHL/G6SKX7Mhz4Dj2bqgXiRY65//pGb/qDLnGCmZhJ5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749353273; c=relaxed/simple;
	bh=hlNNYUOLy+zg5GRSEkrodTYldD19uiMBd6l9wk+LHl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juNxNb6Ft9+9lNs1raMrLELvTWhlJ0ohv8RXRsUgMB+JE5cPpyh4bzixjXn/a47fSvFnkxs8hn6qo80huXA2Ouq7nR5aoRBs+L9Q0+6qmUQYGK6vOxxJR1nmyW+8Rnjw2PM1XZEpjavyP3H4FxKxvw2L5jxzsEJ1oK5PW3sJy7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDFM16Nl; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDFM16Nl"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-879d2e419b9so2695354a12.2
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 20:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749353271; x=1749958071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW+O6UwxWKF1DNfv4O5Y+CmeMPtlar49QLO8jMBN+3Q=;
        b=VDFM16NlnlOrj1rSyeOozNsQNnxsQMlcbXk4avSaLSSs3fQNj/ME6qRqOb3Yz5+30Y
         EgMhyJySRZ5oQAwJW2KeMbCiKOv1pAgIlsKBJOJ8aceH5dZA+kBV98l2uxkhnBYW2b2J
         YLh154pOiLW3eA7RrIxsHFtoDdVpv9mN24KhwbTCMktsKqGzlm+H3B1bAOvvKfUe+GNk
         KwEB/dlcExSarm78CzVdtaueURq5LksATuNPgXHxGxlJxAr6XlFyxoVe82nblVqDTNJd
         XacjRqPC/6wdCJWBmjgHXrn07d1EbqjxubXUUrDGkoUWZ/GlPATTOFuDpiD+yqKPNrdk
         vAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749353271; x=1749958071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XW+O6UwxWKF1DNfv4O5Y+CmeMPtlar49QLO8jMBN+3Q=;
        b=qRNiGRldX8fY3crH/1fU4PhFRbaHlUsTURQn9uhqpKylVX69kfAlL1jAT3mIwVMrTd
         /CZzf9k7jqCQnl+8MrH+gPqpe5bIZzC3ETrzsBEA4MlChnGe9MCZFpCajwTS/VZjYN+n
         n4jHuFRMH+2WromloTadNZEjSj0QNOv4XejQRD0BS3A1RL7PlyhK10oOqZgc+CiUzAI4
         D7dmtT15iEBMtPiUTse7vl6WYCJX7DW6S989OeghZ6xopRVaUXgYIDOplxzvytmJLXtu
         Um7V6gJiek9K+wOdmPIs9osKP8SvpZainT6ezFJCfSR5KF9N5vxDyUXcdnFTOzhmQQI7
         FbhA==
X-Gm-Message-State: AOJu0YyzkYfJzpDSjjidwiFWISRSYiWQ4R4FkWm+Feca2MGiGA3YWFdM
	nqLnbkJe5CIh4taO6yPhihfIbNigdjFlL5dcaqHgQTMKcMQC0QlBYk331ilsreS3
X-Gm-Gg: ASbGncuR0mfxfJ1bpKTWKEYDg2etyJItIADdp6O+PlX5NZhiDPeDuZwxl7Kq//H4MMN
	238xMqxfe4kMEKKe/g+rLKukCcCS/1rFmFizMs1QFxD+SryV05/jQGf7gYPsjYgb9o94EzUYF7J
	hT7eA+XRdIPGr6ABQrEpsMpH1Hs1l9D+bM4cssmjkU19eef4oPzmE2uLkOPGtBf1ji2A2y0YuzY
	KI4TjNc299gR8b4Cs/Hb3YjtVnGn3RNW4LOHFfgeWS7npXLOM57gYfTfnOdlWtvNNelkBmjhfdP
	RAnfZCofu63I5y39pbuYsaaQrNTUGyi8TjAqvAxV+uV81xP9C4w/RQElEdG9NwXkXe1YB9qQ1IY
	ixA==
X-Google-Smtp-Source: AGHT+IEq1V4URsbzH/ORUBJ7/xaAJiYjUoXveKGofRuE5J3b8+68Rxq2PgMcw8coMOpmHupNzrbaQA==
X-Received: by 2002:a17:90b:3c06:b0:313:28e7:af12 with SMTP id 98e67ed59e1d1-3134707973amr12304960a91.35.1749353271259;
        Sat, 07 Jun 2025 20:27:51 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405189sm33442095ad.148.2025.06.07.20.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 20:27:50 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v8 2/2] submodule: skip redundant active entries when pattern covers path
Date: Sun,  8 Jun 2025 08:57:05 +0530
Message-ID: <20250608032705.11990-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>
References: <CA+rGoLdTT3kdELUyHdZLWyy8e6AbfRU7kDFcVUdCmVtDi11hMw@mail.gmail.com>
 <20250608032705.11990-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

configure_added_submodule always writes an explicit submodule.<name>.active
entry, even when the new path is already matched by submodule.active
patterns. This leads to unnecessary and cluttered configuration.

change the logic to centralize wildmatch-based pattern lookup,
in configure_added_submodule. Wrap the active-entry write in a conditional
that only fires when that helper reports no existing pattern covers the
submodule’s path.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c    | 32 +++++++++++++++++++++-----------
 t/t7413-submodule-is-active.sh | 15 +++++++++++++++
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9f6df833f0..514abe480e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -32,6 +32,8 @@
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
+#include "wildmatch.h"
+#include "strbuf.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -3328,6 +3330,9 @@ static void configure_added_submodule(struct add_data *add_data)
 	char *key;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
+	const struct string_list *values;
+	size_t i;
+	int matched = 0;
 
 	key = xstrfmt("submodule.%s.url", add_data->sm_name);
 	git_config_set_gently(key, add_data->realrepo);
@@ -3370,20 +3375,25 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get("submodule.active")) {
-		/*
-		 * If the submodule being added isn't already covered by the
-		 * current configured pathspec, set the submodule's active flag
-		 */
-		if (!is_submodule_active(the_repository, add_data->sm_path)) {
-			key = xstrfmt("submodule.%s.active", add_data->sm_name);
-			git_config_set_gently(key, "true");
-			free(key);
-		}
-	} else {
+	if (git_config_get("submodule.active") || /* key absent */
+	    git_config_get_string_multi("submodule.active", &values)) {
+		/* submodule.active is missing -> force-enable */
 		key = xstrfmt("submodule.%s.active", add_data->sm_name);
 		git_config_set_gently(key, "true");
 		free(key);
+	} else {
+		for (i = 0; i < values->nr; i++) {
+			const char *pat = values->items[i].string;
+			if (!wildmatch(pat, add_data->sm_path, 0)) { /* match found */
+				matched = 1;
+				break;
+			}
+		}
+		if (!matched) { /* no pattern matched -> force-enable */
+ 			key = xstrfmt("submodule.%s.active", add_data->sm_name);
+ 			git_config_set_gently(key, "true");
+ 			free(key);
+ 		}
 	}
 }
 
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 9509dc18fd..a42060cac9 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -124,4 +124,19 @@ test_expect_success 'is-active, submodule.active and submodule add' '
 	git -C super2 config --get submodule.mod.active
 '
 
+test_expect_success 'submodule add skips redundant active entry' '
+	git init repo &&
+	(
+		cd repo &&
+		git config submodule.active "lib/*" &&
+		git commit --allow-empty -m init &&
+
+		git init ../lib-origin &&
+		git -C ../lib-origin commit --allow-empty -m init &&
+
+		git submodule add ../lib-origin lib/foo &&
+		! git config --get submodule.lib/foo.active
+	)
+'
+
 test_done
-- 
2.49.GIT

