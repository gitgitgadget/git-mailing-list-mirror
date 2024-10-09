Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435E27466
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728444790; cv=none; b=lRxHpzYZrXBGUMDWyx14+LlQGu/LDz0ZpNqjb28CkJ8RGPKV/GBvvhQ4a+e8H59hmnnARNGxa6T2lVFq0S5sJuxvqlmyXEWhnuzIlng474VFQ8UpIhkyx5F2q1+iqjuMAA7fFjJQXo6c+D2G7cztGT6jBqiKuqElVtB6pQWVbE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728444790; c=relaxed/simple;
	bh=d6ZCOCIsnoMU4q6gRt3Zz0L+EKD8yKF5hJIDKyhOpvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BroyCDY/q3L85cPfXDL6v663bW1032o8+NmLW8Zei/mbu1czKOU8h5lP2+LEJkWMQ0dgvznq5mhfneI5dApDRo2RTjPF1HR/d2t00l+QG8sEfFCOjuQCaKmuhZ7Duqwjd03/hdzF8LyZgNoPgfflsww17p/R9vApVv2y6X2NO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mariadb.org; spf=pass smtp.mailfrom=mariadb.org; dkim=pass (2048-bit key) header.d=mariadb.org header.i=@mariadb.org header.b=CgdP7/tP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mariadb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariadb.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mariadb.org header.i=@mariadb.org header.b="CgdP7/tP"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b64584fd4so61796495ad.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 20:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google; t=1728444788; x=1729049588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGZByCJkHv1vrUzPZXbAbcikN0z1dG6f+McVFJUA4yQ=;
        b=CgdP7/tPhF09JiP0cCSbrFo2I+OX7Mc7V0AdB7xoQcP9yK9xkh1hJPdOhT+bf7k4+d
         HSMeQ+eICsljI9De2QvMzU/0I3yMkK/8FMB7AGzvLYqd5Jxxq3VCMJlGxsTMk4qsc5Vz
         srnJggyr1LZ/RoagUOR1+CXgEyAPl46WyeCeG+bgu4azL1C1mLkvIcLI/t/apNQHC9+K
         wCi+/NCmo2UwFrjLupyfG4ojpdwGU6UO1WsQrbikKI2gGpsZrh7m31ktDPCAxx8cfuW5
         MYcwpSVfQH9ep+ZuZH2uWnqhslerQMENXBR3NCwX6tpxGuWFVk6w5PsLF58HY5cHuIX7
         u4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728444788; x=1729049588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGZByCJkHv1vrUzPZXbAbcikN0z1dG6f+McVFJUA4yQ=;
        b=f8jpxIB/+Prg6lf2fhYZSNqT8JpBIAbFWnAQh8L8OPdrVlAG7PYtelUp6stU8+6rJZ
         T/y+xQUzKOYLtf5dFXfYpwo3idVIrU1YIjPJ6uIytc/NmMjU2S4cLMMHWh4dYeobKmsU
         spSykLjY7lJWKz6u6uKfl7CeFPrvERcoE7UhZ+lLoXGwkHmgWYVgEZlEgbFweO9qSZ65
         GnbHPiCA7fEgIIPBtPaUJeOwa1wF2ScucA7cp0J6LhK69TTczVQv5KfbxqK21ijHc5BV
         L1CaYza8tL7Va4H0BzKiduWy1G+eKAzi9D9LY58U3iDCjRcINDqQ5cw/5pZU/x7a8Ifz
         uPEw==
X-Gm-Message-State: AOJu0Yzl46nEpwpLz/1QBVtJtT8zEZvwknlnBkUsY3wAJ4lXzqSH4dPs
	vUVwPlI97GaZP1H3ush5AC/T9/jfANS2liiEeN2tWTk+HLlKy86roiMGNE6qSgcT7q9tVMVlk65
	6HTM=
X-Google-Smtp-Source: AGHT+IG8w2LMEJTMy05G0L8x/Q0bdNJ2hLH1hhixaeZcrEi9JZSW5rTVV5JKt1UBG895Fj9WVPQfxQ==
X-Received: by 2002:a17:903:22c6:b0:20b:849d:48fa with SMTP id d9443c01a7336-20c637726cbmr18063595ad.27.1728444788107;
        Tue, 08 Oct 2024 20:33:08 -0700 (PDT)
Received: from bark.fritz.box ([206.148.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13939c3bsm62174185ad.151.2024.10.08.20.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 20:33:07 -0700 (PDT)
From: Daniel Black <daniel@mariadb.org>
To: git@vger.kernel.org
Cc: Daniel Black <daniel@mariadb.org>
Subject: [PATCH v3] submodule: correct remote name with fetch
Date: Wed,  9 Oct 2024 14:32:54 +1100
Message-ID: <20241009033257.1316690-1-daniel@mariadb.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <xmqqzfnez9dv.fsf@gitster.g>
References: <xmqqzfnez9dv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code fetches the submodules remote based on the superproject remote name
instead of the submodule remote name[1].

Instead of grabbing the default remote of the superproject repository, ask
the default remote of the submodule we are going to run 'git fetch' in.

1. https://lore.kernel.org/git/ZJR5SPDj4Wt_gmRO@pweza/

Signed-off-by: Daniel Black <daniel@mariadb.org>
---
 builtin/submodule--helper.c |  9 ++++++++-
 t/t5572-pull-submodule.sh   | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index dc89488a7d..b6b5f1ebde 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2333,7 +2333,14 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 		strvec_pushf(&cp.args, "--depth=%d", depth);
 	if (oid) {
 		char *hex = oid_to_hex(oid);
-		char *remote = get_default_remote();
+		char *remote;
+		int code;
+
+		code = get_default_remote_submodule(module_path, &remote);
+		if (code) {
+			child_process_clear(&cp);
+			return code;
+		}
 
 		strvec_pushl(&cp.args, remote, hex, NULL);
 		free(remote);
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 916e58c166..9b6cf8d88b 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -230,6 +230,7 @@ test_expect_success 'branch has no merge base with remote-tracking counterpart'
 
 	test_create_repo a-submodule &&
 	test_commit -C a-submodule foo &&
+	test_commit -C a-submodule bar &&
 
 	test_create_repo parent &&
 	git -C parent submodule add "$(pwd)/a-submodule" &&
@@ -246,4 +247,23 @@ test_expect_success 'branch has no merge base with remote-tracking counterpart'
 	git -C child pull --recurse-submodules --rebase
 '
 
+test_expect_success 'fetch submodule remote of different name from superproject' '
+	git -C child remote rename origin o1 &&
+	git -C child submodule update --init &&
+
+	# Needs to create unreachable commit from current master branch.
+	git -C a-submodule checkout -b newmain HEAD^ &&
+	test_commit -C a-submodule echo &&
+	test_commit -C a-submodule moreecho &&
+	subc=$(git -C a-submodule rev-parse --short HEAD) &&
+
+	git -C parent/a-submodule fetch &&
+	git -C parent/a-submodule checkout "$subc" &&
+	git -C parent commit -m "update submodule" a-submodule &&
+	git -C a-submodule reset --hard HEAD^^ &&
+
+	git -C child pull --no-recurse-submodules &&
+	git -C child submodule update
+'
+
 test_done
-- 
2.46.2

