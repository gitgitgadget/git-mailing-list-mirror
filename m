Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE51C84D9
	for <git@vger.kernel.org>; Sat, 24 May 2025 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748069339; cv=none; b=Ht55bIBSndTPjMjXmX70iwepZxjMVSSvP2tC8uKQsAHgy0E7VUesKVJbskGO8FRL1VIGyO4sLe44Y/8Oox3y9L3pAubygo/aH4E74qtDypXn0728Q/xetoK04UlM6ym4Bhdy8Oqqb1UzcMmw13km/StHbo3P4krMi7wYXhl6m6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748069339; c=relaxed/simple;
	bh=RIcm9wzSBH+VCdhhaobteW0T/mSiZTSTllqVZc7vqYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZgduJ6yKKnble4t8Z52Y/cdkZ3XGWOnOruWjidYWDPr1zyg6OaM2HmaqcUAqS2fB9sw3RsGuBmfGbpe+hmvpJAID2KCSLj8A3cc3x2Q3iZzDmqoKAAl0tdXr7wn7pyw7C+10jQfVdvSy3uhzkwGBtyZPx4wDzjWgnJXcqJC2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+2FHhto; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+2FHhto"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736c277331eso1224449b3a.1
        for <git@vger.kernel.org>; Fri, 23 May 2025 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748069337; x=1748674137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQbaj/RIzBOHmGGrqN6md9lnFUWIA21VM3Lkt+luIHs=;
        b=L+2FHhtoy/wQk2JYKswdE1+fwsQwxfyLxmwUW9VP+UB1y+75vuECxrSIQhf8XIn9qz
         eVa0BpUdqpdC4aQcbFnooU3NBvc7d8PI5aWz1n70GB9lgBVYRLGWJrX/v67xV2qX5E/F
         rvMnMYrdO4GB6rDdccHaazQu1qlqp/lzt/JeEahnDmfjXxmAX+giFmE27YSPglybZu+J
         XQuQuOhUpWbpYeBRHiWVa66lznRNZagUeHP/NaF0t6014HFQm2OJyKkpKdw16xAeIzhB
         Rpb03m7ZVeXLuDd7BOIH4z2oVYTcLKCUYnzQQ4VmoaUr2poG618R+DqCJbI9b1zYZ+6A
         v6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748069337; x=1748674137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQbaj/RIzBOHmGGrqN6md9lnFUWIA21VM3Lkt+luIHs=;
        b=vplusoIOvwrHw3CYXdLr2SR+bFqfZgcty5LGAxdXzfxEho7n5JobsSqxiN5q7EAlsF
         Lq/M1t/Dtlboq4PMzFscwVf+Lxv6+xxHUDX3RMJY/yh8W8n89IYlGrpGIGG6d3rYusau
         iuhzqRCJ5pPvnzFXY73bqnp3pm7oLtzmt0A0YyVqn4ilgxeqObjXJgRV6ZJwQ1q5gB4a
         czyUhaloxh8o8KIRRdibwWGqJs5/jkeOnce6nt5tMvIzRefv+1FQbZcCQvRupEbymkfn
         p0I1iZntYMpBcwYjnwl7GEHc+B/GOxjzHVM3w/qLd0hPXI+JJilj8ZuKk6nSpt0L/PPx
         dsNQ==
X-Gm-Message-State: AOJu0Yx3REBdnA/5UDynmFxguCTK9d+ILZDdrqX+Aw9BnhQSHVGpYAH3
	DPkBMjFEKdUrFVAlNAne9/RVzHYwrvbFhlTfE0yTAanqq9wYLOnyg/qz
X-Gm-Gg: ASbGncvivOpgn0tyuWAQwQOmAhWPJ8i8n9v6iIpPHtG/iBEaS1OH2etnUY2SzzpWvUa
	Sx4E0E3AN/m60URIhJmB0Zf9KMJgkj1Ht3Qcvw5Q9RSCAc8QMdHn21JHpReiv9Sq8Iz+d2/jPjO
	fVcPeA1NbkJEVFM895ajhluvbN9XmwhrFNPihTbhoWpfgLlgK3USiknMNDOpmE9m41z/zE/9fvg
	sFH3cWRFFx6ya3UNVRnq62CNShIukqr7soGI80b7jnNppetjolyHXvTLxwaa8Oo1aNfqBiqR5uj
	zw4SVA19LA4Xm93CfmqlMUY3iluMm36EsW8QyctBnC0N+oR6tePHn5YdJiV8NQ0JO3M=
X-Google-Smtp-Source: AGHT+IG8xYIWmHZTSDC8ukyfHQVlAAcxqqdtTM8jwOUk9cjndtmky7VPVtc3TRVGTQcP89PU3YP5YA==
X-Received: by 2002:a05:6a21:9004:b0:218:2b6e:711f with SMTP id adf61e73a8af0-21877b03f89mr9419682637.14.1748069336767;
        Fri, 23 May 2025 23:48:56 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8e05fsm11862401a12.39.2025.05.23.23.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 23:48:56 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	mlell08@gmail.com
Subject: [PATCH v6 1/2] submodule: prevent overwriting .gitmodules entry on path reuse
Date: Sat, 24 May 2025 12:18:46 +0530
Message-ID: <20250524064847.51900-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250524064847.51900-1-jayatheerthkulkarni2005@gmail.com>
References: <xmqqsekzjo7g.fsf@gitster.g>
 <20250524064847.51900-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding a submodule at a path that previously hosted another submodule
(e.g., 'child') reuses the submodule name derived from the path. If the
original submodule was only moved (e.g., to 'child_old') and not renamed,
this silently overwrites its configuration in .gitmodules.

This behavior loses user configuration and causes confusion when the
original submodule is expected to remain intact. It assumes that the
path-derived name is always safe to reuse, even though the name might
still be in use elsewhere in the repository.

Teach `module_add()` to check if the computed submodule name already
exists in the repository's submodule config, and if so, refuse the
operation unless the user explicitly renames or uses force to auto increment.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/submodule--helper.c | 28 ++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh  | 23 +++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53da2116dd..9f6df833f0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3444,6 +3444,10 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	struct add_data add_data = ADD_DATA_INIT;
 	const char *ref_storage_format = NULL;
 	char *to_free = NULL;
+	const struct submodule *existing;
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+	char *sm_name_to_free = NULL;
 	struct option options[] = {
 		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
 			   N_("branch of repository to add as submodule")),
@@ -3546,6 +3550,29 @@ static int module_add(int argc, const char **argv, const char *prefix,
 	if(!add_data.sm_name)
 		add_data.sm_name = add_data.sm_path;
 
+	existing = submodule_from_name(the_repository,
+					null_oid(the_hash_algo),
+					add_data.sm_name);
+
+	if (existing && strcmp(existing->path, add_data.sm_path)) {
+		if (!force) {
+			die(_("submodule name '%s' already used for path '%s'"),
+			add_data.sm_name, existing->path);
+		}
+
+		/* --force: build <name><n> until unique */
+		for (i = 1; ; i++) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
+			if (!submodule_from_name(the_repository,
+						null_oid(the_hash_algo),
+						buf.buf)) {
+				break;
+			}
+		}
+
+		add_data.sm_name = sm_name_to_free = strbuf_detach(&buf, NULL);
+	}
 	if (check_submodule_name(add_data.sm_name))
 		die(_("'%s' is not a valid submodule name"), add_data.sm_name);
 
@@ -3561,6 +3588,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
 
 	ret = 0;
 cleanup:
+	free(sm_name_to_free);
 	free(add_data.sm_path);
 	free(to_free);
 	strbuf_release(&sb);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d6a501d453..07951f0c6d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1482,4 +1482,27 @@ test_expect_success '`submodule init` and `init.templateDir`' '
 	)
 '
 
+test_expect_success 'submodule add fails when name is reused' '
+  git init test-submodule &&
+  (
+    cd test-submodule &&
+    git commit --allow-empty -m init &&
+
+    git init ../child-origin &&
+    git -C ../child-origin commit --allow-empty -m init &&
+
+    git submodule add ../child-origin child &&
+    git commit -m "Add submodule child" &&
+
+    git mv child child_old &&
+    git commit -m "Move child to child_old" &&
+
+    # Now adding a *new* repo at the old name must fail
+    git init ../child2-origin &&
+    git -C ../child2-origin commit --allow-empty -m init &&
+    test_must_fail git submodule add ../child2-origin child
+  )
+'
+
+
 test_done
-- 
2.49.GIT

