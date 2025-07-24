Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD912EA16D
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370678; cv=none; b=RRUi1divWTP9XdWhSG31uIVUeE0UYpM+mMXFhEKIDC0aUfmPrJiIMv6ct/jHs6ZXNBqUtPALBjyn59eRHluytzNFmBeYtK0xd70rBGTBJI5UBVGKCvrgD15xXgCFo+FHWwiQPOsDEI1/xUQ0KMoT+EGLgN0GZQe+Qi8+A8kQx7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370678; c=relaxed/simple;
	bh=5lLbcFKzH6xgCEetwAuHQbWiX73Nc3naqdEGl8R0C7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXtGgTIFWtiaCrcsG8TxpOnf6eZeYH0O08FcZPXdsCsQMMtmU/MO8p4BpyuBgiEk65LC8QAp/s51scsc/siogYG22lXHP1i9uJNO2HwVhDV6Dslyl1LhGbzJ1rqg0y525v/xvjm7HL1UfjAzUdVqi+5XLg/YsKgx6+VgxvNkXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPVqGDel; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPVqGDel"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7600271f3e9so1085467b3a.0
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753370676; x=1753975476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZ6QuDfOmbhENw0C1/U5RSHS1A337KPn1fiSQCVgm7Y=;
        b=gPVqGDelztp3yuY5E3iqERyk6HtWtDIyPclZRxIbGiaD3MqINVNiJtUh4+otOl3hOD
         FHzBmfnGJ0BQZMlJtvp/ohkqGxKacrtztzuTDll7gdjhZu4qMl6nm/p3cbyvTjkijaFZ
         4sUcIFwxYmwla9oXc9zmQX8IP6EiPwlRff5hnPWPmqxqAybneU5Fdb9DgyorhexDRORr
         kQD52lhIbqO7ZJErgWLi2iE9iHVFuwAZk/stiyp0JfJeyrsoLQ6Gz0e/4wmKcheUyuf4
         fhGwB/ofFruGh4+g5pvhDExIR7cnSz2Qsels2vyi+/kgDEyemwgj/EctGsF0ax1NtHnY
         mj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753370676; x=1753975476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZ6QuDfOmbhENw0C1/U5RSHS1A337KPn1fiSQCVgm7Y=;
        b=OuRGkCG7x68fWrFsyKjTu8kX4EkSr9g3Fb4qcxmNCyoME1FaxinOc4RHMFnPa6aCaO
         1VDm7As9t49sLkS2BaiWMKp0ET9qS81J0dWovDAIcO13WHuM8uK9TH/rn6hFbit5XJCy
         goSAgf2Mhcxdva8faQtw9n6T+7U1V3ylCG+hb6/s5mH6TjqjkwriYGIUfuwO8g4KMCyJ
         PYcHzlTCD3iooGwM82zJQJ0hG3U6xK7WiuI+nHdvKinzbbZOMFPOnaKXjKRfhg2ovr3M
         dEWx0YUv/fJNjtZt81iYxU6WVcon8tANkrvu19W8xc7C+BPOwVHUT/lMh7jIPPcvCjSE
         /lPg==
X-Gm-Message-State: AOJu0YxynVlXhepyUV/WGmFfqPTsuW5X386tuTxhVXwKAk22avBvwmUj
	rSxIADJ+6WZBUkdqrqeHXz0ZAAaUANAmNEUpA9UBH36bAHms9c5/lWsBMmvFtA==
X-Gm-Gg: ASbGncslNdPJ0tbIb3JKzYGMMXT+zfFfQa6CLMS43eNicJX4hobwjNru5L8lIBJOnDH
	fqYG/F3W5jbmIdz2Q9QHiPLMKpvRbjkwKq+VI/KImFvf1DSszaF8WazsECCX+6DMpz9GbuoQ6I4
	19ZTRH8EYXeC83M0WB+qrNbxjybARgin6k/lWvToo6DzVWbzAXrp3FmioksDl1vIxRZyTEG3fo4
	SVQszY6oL8L1IN+pnSCmUWAOarUqg7tS0x8t3cV7LDMhdr4JEtZtnOrQaNIdhGiD7hDMqXhjDrA
	F14qgfOhUZkBFhEp5xjhuCZYyozlqSJdWjYeP7ocGrFGtcCe3g6VHNNb1kh5RomXt7DEyIAXtMm
	zDkm5VrsVKLDxRpC4tqnK0szMTxzybLcvxi8=
X-Google-Smtp-Source: AGHT+IEJc1oE5UEOXCY1Tzt5QKTiocQrTr6kvK6rFoUW1LAivDyku9Vniwvmtky3lwTvdzf8ZpH0qQ==
X-Received: by 2002:a05:6a00:21c5:b0:73d:fdd9:a55 with SMTP id d2e1a72fcca58-761ef90c89fmr3424114b3a.8.1753370676162;
        Thu, 24 Jul 2025 08:24:36 -0700 (PDT)
Received: from fedora ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761ae63df65sm1917849b3a.63.2025.07.24.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 08:24:35 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [PATCH 2/2] submodule: skip redundant active entries when pattern covers path
Date: Thu, 24 Jul 2025 20:54:18 +0530
Message-ID: <20250724152418.45226-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.50.GIT
In-Reply-To: <20250724152418.45226-1-jayatheerthkulkarni2005@gmail.com>
References: <20250724152418.45226-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

configure_added_submodule always writes an explicit
submodule.<name>.active entry, even when the new
path is already matched by submodule.active
patterns. This leads to unnecessary and cluttered configuration.

change the logic to centralize wildmatch-based pattern lookup,
in configure_added_submodule. Wrap the active-entry write in a conditional
that only fires when that helper reports no existing pattern covers the
submodule’s path.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c    | 25 +++++++++++++++++++------
 t/t7413-submodule-is-active.sh | 15 +++++++++++++++
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b4f5d6e26a..1fb49a2c4c 100644
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
@@ -3308,6 +3310,9 @@ static void configure_added_submodule(struct add_data *add_data)
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
 
+	const struct string_list *values;
+	size_t i;
+	int matched = 0;
 	key = xstrfmt("submodule.%s.url", add_data->sm_name);
 	git_config_set_gently(key, add_data->realrepo);
 	free(key);
@@ -3349,20 +3354,28 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get("submodule.active")) {
+	if (git_config_get("submodule.active") || /* key absent */
+	    git_config_get_string_multi("submodule.active", &values)) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
 		 */
-		if (!is_submodule_active(the_repository, add_data->sm_path)) {
+		key = xstrfmt("submodule.%s.active", add_data->sm_name);
+		git_config_set_gently(key, "true");
+		free(key);
+	} else {
+		for (i = 0; i < values->nr; i++) {
+			const char *pat = values->items[i].string;
+			if (!wildmatch(pat, add_data->sm_path, 0)) { /* match found */
+				matched = 1;
+				break;
+			}
+		}
+		if (!matched) { /* no pattern matched -> force-enable */
 			key = xstrfmt("submodule.%s.active", add_data->sm_name);
 			git_config_set_gently(key, "true");
 			free(key);
 		}
-	} else {
-		key = xstrfmt("submodule.%s.active", add_data->sm_name);
-		git_config_set_gently(key, "true");
-		free(key);
 	}
 }
 
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 9509dc18fd..6fd3b870de 100755
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
+		test_must_fail git config --get submodule.lib/foo.active
+	)
+'
+
 test_done
-- 
2.50.GIT

