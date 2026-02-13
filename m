Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65F199E89
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770953875; cv=none; b=Ge31LYLzmj6spE4Q2R3i1xcJxiD4Bc2ujeb2w+dtfiDbfVf9zxjPgr8cTOyhBmAuYHTOUggLBnNrSojqrJTdhMj+tpRfhXgOUQLviLunr9MiXqI3j4rRpuVkkAofZRrTT6gNsDsghg97mNzBtaVdC4ZoqUzzsG2gxjDyroMoDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770953875; c=relaxed/simple;
	bh=AA+S7VPC34aL7B1DDo8F5X7d8G1yFFcLSuzU4BuYeqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/OroMBDdeNWfvABlEUbQnKFL8uftlJNztWSzhJ4aco1y9/XloZ4z06TgRGcvCsikuvu7j6p+zHrSy2jkolJQAr1knPswZRG7Z1Zon6VqKA3xrxa/C984y+6h++pDYJjfqO3QqmDv71ETyd5heFLD7vSawNXXDcFPSufTp3cMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwfeTacD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwfeTacD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso3450005e9.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 19:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770953872; x=1771558672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJJQ0Lnn5XnWrz7E7iVPrMUrpuEXDCS3E1Zp1Yu1lvk=;
        b=TwfeTacD4vBr1HvncNyw8o1uMHwTtSBTiVDYijlY8+GknrJEdG3u5qeqaQ9ro+RlYo
         HuuA5t+iLr1kr0Lt0zlKuf0GbCYp74XKSEaW7IL+XmF74EM+8nKzq222DfFE+yevVhPM
         KoF7c/k5Gt5OArjKSPHGucmmWooL8d7bAKnzBoCOC8Ew1AW5nr2s0Kt9K4YfWbnDyhxg
         5Bmn99jfn31OtOEfJqflbbSVDosv3a9oyPJ3ptgOW5IVCrj0Kq1ypigZbJDDxNeIilRV
         08OeMZAgCScMnrchcTLm6X2vDgoKfEUFdkZrVKG7SkjxI/CDsc3aUaqwHefvXnkBn+2q
         CG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770953872; x=1771558672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJJQ0Lnn5XnWrz7E7iVPrMUrpuEXDCS3E1Zp1Yu1lvk=;
        b=SaeAufiJOc31/r/9WotbNnPShw/QLdD6g9YmInhGk8x6KDFZiFn4VlChZlEEUbeKz0
         mbquNB1iCm23JVuAaTmvmPUA89kf+4JPLbWAgoG0E5ELIApbnSaMmoNFT0vaD71DlSbe
         nHy1PApwLuP29mZbw0OGgjypz87cxSr+RaOG1NYIcrNw08jjXJaaz+uqYm3kIjeOqdLB
         h/7Ol8S5GYxsCMnAf8Exi6HVFV5aKvQ5xceXyXQ/48oyp5aX6tMgb7M8Lm7Nn/IJMzsl
         5cMwefH5jCy7jY9QrjNckyJmeCyttG4NurDukE623p0ivj2RfE+iMAF8avXCUwthHMuP
         FmbQ==
X-Gm-Message-State: AOJu0YxOi5MtYaeuZastDPIHjswsjDYPtPHd+pdr5G9FTAkV0Ad2wf+6
	9ITHnaSiIwXTXWJYIu1YbtHEI+luqLQr9AmT5dlMkJvq2wTONLRt9Zc1eExuiw==
X-Gm-Gg: AZuq6aIV+RnbWMhxcNhH177CxnAGaAUfxbIb5PQONaUI9ueXU/JZQR7LM9wKEoiy8ss
	TDFt+lemt/lxyNOTvydnmMD5bLv308Dxh1daKtEM3CFS8FLt9i7Z7h6r+KnJ+5cQX5xzt14t8IF
	B2tffTSebqaxsHUUAWKEDftsw2x1vnDwtZCp0I06lRjEYuhQMWkn4vCnhHX8uxjBOoSJyL2zwAh
	xadRIzMZdkSEM2W0tEhlHTXGlsFnSjYnHtUBdkVs9eopgvDnmS42PBTyWZEMewERTZjiEjVF8be
	XzAL5Ac7lLlhnE2o9c46azLL6/FOAXbRJXvPbJPA/WmnX1rdi/34pWi3uEuogtBN/giaj6vyfAL
	vvH/4zs/DU4+SAbWXS3Kf4ifWItdse3QBzRNL3NGN5fyM6CIxZRr697BZG1/fnRyPU4bXz85OOZ
	F1OxnDwuRgrImvilbAsNTzKq5BWja5OUaYC1oBL81UMk3CN3zKc4yh5wW3NZ+BxC5A+uqDw1pF7
	EqqXD0=
X-Received: by 2002:a05:600c:870b:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-48373a5d456mr5251215e9.24.1770953872087;
        Thu, 12 Feb 2026 19:37:52 -0800 (PST)
Received: from localhost.localdomain ([115.98.235.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7e50casm226933515e9.8.2026.02.12.19.37.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Feb 2026 19:37:51 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	peff@peff.net,
	avarab@gmail.com,
	amishhhaaaa@gmail.com,
	Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
Subject: [PATCH v2 2/2] help: cleanup the contruction of keys_uniq
Date: Fri, 13 Feb 2026 09:07:29 +0530
Message-ID: <20260213033729.50208-2-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213033729.50208-1-amishhhaaaa@gmail.com>
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
 <20260213033729.50208-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>

uniqueness property of keys_uniq depends on the sort operation executed
for keys, sorted property of keys does not gurantee sorted property of
keys_uniq due to processing keys, this might also introduce regressions
in future when the logic of forming keys_uniq from keys is changed.

add string_list_sort_u operation for keys_uniq and refactor the
processing code to simplify it, add test that demonstrates that sorted
property of keys does not gurantee sorted property of keys_uniq.

Signed-off-by: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
---
 builtin/help.c  | 71 +++++++++++++++++++++++++------------------------
 t/t0012-help.sh | 18 +++++++++++++
 2 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index c09cbc8912..c278d7ffcb 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -156,47 +156,48 @@ static void list_config_help(enum show_config_type type)
 			BUG("slot_expansion %s.%s is not used",
 			    e->prefix, e->placeholder);
 
-	string_list_sort(&keys);
-	for (size_t i = 0; i < keys.nr; i++) {
-		const char *var = keys.items[i].string;
-		const char *wildcard, *tag, *cut;
-		const char *dot = NULL;
-		struct strbuf sb = STRBUF_INIT;
-
-		switch (type) {
-		case SHOW_CONFIG_HUMAN:
+	if (type == SHOW_CONFIG_HUMAN) {
+		string_list_sort(&keys);
+		for (size_t i = 0; i < keys.nr; i++) {
+			const char *var = keys.items[i].string;
 			puts(var);
-			continue;
-		case SHOW_CONFIG_SECTIONS:
-			dot = strchr(var, '.');
-			break;
-		case SHOW_CONFIG_VARS:
-			break;
-		}
-		wildcard = strchr(var, '*');
-		tag = strchr(var, '<');
-
-		if (!dot && !wildcard && !tag) {
-			string_list_append(&keys_uniq, var);
-			continue;
 		}
+	}
+	else{
+		for (size_t i = 0; i < keys.nr; i++) {
+			const char *var = keys.items[i].string;
+			const char *wildcard, *tag, *cut;
+			const char *dot = NULL;
+			struct strbuf sb = STRBUF_INIT;
+
+			if (type == SHOW_CONFIG_SECTIONS) {
+				dot = strchr(var, '.');
+			}
+			wildcard = strchr(var, '*');
+			tag = strchr(var, '<');
 
-		if (dot)
-			cut = dot;
-		else if (wildcard && !tag)
-			cut = wildcard;
-		else if (!wildcard && tag)
-			cut = tag;
-		else
-			cut = wildcard < tag ? wildcard : tag;
-
-		strbuf_add(&sb, var, cut - var);
-		string_list_append(&keys_uniq, sb.buf);
-		strbuf_release(&sb);
+			if (!dot && !wildcard && !tag) {
+				string_list_append(&keys_uniq, var);
+				continue;
+			}
 
+			if (dot)
+				cut = dot;
+			else if (wildcard && !tag)
+				cut = wildcard;
+			else if (!wildcard && tag)
+				cut = tag;
+			else
+				cut = wildcard < tag ? wildcard : tag;
+
+			strbuf_add(&sb, var, cut - var);
+			string_list_append(&keys_uniq, sb.buf);
+			strbuf_release(&sb);
+		}
 	}
+
 	string_list_clear(&keys, 0);
-	string_list_remove_duplicates(&keys_uniq, 0);
+	string_list_sort_u(&keys_uniq, 0);
 	for_each_string_list_item(item, &keys_uniq)
 		puts(item->string);
 	string_list_clear(&keys_uniq, 0);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index d3a0967e9d..0dbe6dd46f 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -160,6 +160,24 @@ test_expect_success 'git help --config-for-completion' '
 	test_cmp human.munged vars
 '
 
+test_expect_success 'git help --config-for-completion' '
+	file="$GIT_SOURCE_DIR/Documentation/config/add.adoc" &&
+	test_when_finished "git -C \"$GIT_SOURCE_DIR\" checkout -- Documentation/config/add.adoc" &&
+	cat <<-\EOF >>"$file" &&
+	aa*.b::
+	aa.b::
+	EOF
+	git help -c >human &&
+	grep -E \
+	     -e "^[^.]+\.[^.]+$" \
+	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
+	     sed -e "s/\*.*//" -e "s/<.*//" |
+	     sort -u >human.munged &&
+
+	git help --config-for-completion >vars &&
+	test_cmp human.munged vars
+'
+
 test_expect_success 'git help --config-sections-for-completion' '
 	git help -c >human &&
 	grep -E \
-- 
2.52.0

