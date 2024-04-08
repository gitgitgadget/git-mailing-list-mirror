Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6B14262C
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593027; cv=none; b=aoqTGxQ+hklGfprJISs8ozUTPAjKd7Ro/keGbP0oX08JvAA42zA5GTtQox825wwDL1CA6R+skp3Fxmz2ePm2ZWJS3UOQFNNIs9XCgNwzVQSpRi3zKaWn42hWVyavNc5X4imEDDQwXoiccKVB95RUps+NARKZ9Xkxc/4pJgEg+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593027; c=relaxed/simple;
	bh=vbNBvkdrGKCcNnJiGvMHmIEcN79GtkKwXJqd9PWudK4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WWTA5QjVzGvJzTlOQDHD1godQLTwxm685JKvzdX7Nt1Jruo9mWSwiHfzzW2A9JBuW7kLt8FvdEv98MUo0rnK58UqwLqd+6SnaxLrWC3voEkRhbBhq3uvJ2ysc5vl7dJGP93iwlsSk54PtbRLgVG0+bcAdGE1CE6JvDzZAtC1W/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBQEHfXw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBQEHfXw"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343d1003106so2782394f8f.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712593019; x=1713197819; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbBSaV2toufpZjzIivSjI10z+Fp2kgqi4DhTCaAdHt0=;
        b=UBQEHfXwR9pb+6Qeoou13gzqV+n5hF64IxkUlN4KFBod08Zcb419ZEkBpDakTRNI4V
         ksSZkSoZki4nmjzLNrLaYcUsoX6umBNpTDMZpjF6F7uS7u/f3ZJXK9DrmFei7bOfovDY
         oQW0FoDwA642smbTY4a+F4BRPpGxTN4iiwDOaT8FjsKG8Dkh/aFZ++6swLVff/Ed05eU
         l9mA4K9TXeTYujf11isY3ry1NP9B5dssFF+Qp+5dqaIc4ETbn2ZmMcxKLrzcQt8jaUPs
         TNND1BxvDgwna20s2tlZuBw7E0TpGzmQV8R8G40Nf/4n7ncSYPqCGX0DIrQ7o4YMHra9
         Jtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712593019; x=1713197819;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbBSaV2toufpZjzIivSjI10z+Fp2kgqi4DhTCaAdHt0=;
        b=Abl7HxyE7kwXSJmuCxouADeIp3luT+kmyuoOeM0a3OXreGRNq1UokHrSHMLk7YXWfv
         GZ4QsU6y2d2cFe4kMzvyd5eKe0LESbkATZvaHky/XM2DSEqhl2Nh8MDANe7kx9wyWBrU
         9eXIWm/xH0DS+Ltd4sKwDcPzMwuIhyBCEJTY3GgPfv8divP0f4clOCEYNtTXfbrmYXrg
         jWGuAtrQOF7EP5VemG/mgI0EnzvzirciKyzn42unLERYKpP6MRJ+cSGdZMtbeEQh8mPe
         XTMFMf7YezuufpJx3Cr+RyKj8d+p9sAM2fuaYsPDESuUqjDa67Q5p1CUPqaW1g50wre4
         U1dw==
X-Gm-Message-State: AOJu0YwahhYCAxUfxy3KjPj+zwbVH9KtxhGKW9InGEvCRYVyrugG8uF4
	L7msW9PqIb1psBZV0EouvuvWZKqliKn8W/pB25gUa5k7Xb+QrG5H1++pxGIn
X-Google-Smtp-Source: AGHT+IEepHH5XkYp33v/lyl6EGqkm35/0tm05O+3fU212cwhSSIMuREtg+ICfQkkMGrjm0Q58Rfupg==
X-Received: by 2002:a05:6000:e49:b0:343:41ef:ab30 with SMTP id dy9-20020a0560000e4900b0034341efab30mr6936207wrb.47.1712593019169;
        Mon, 08 Apr 2024 09:16:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j31-20020a5d6e5f000000b0033fc06f2d84sm9314881wrz.109.2024.04.08.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 09:16:58 -0700 (PDT)
Message-Id: <c7bc734654009a5275ac0bf5297782a846f6ad01.1712593016.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>
References: <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
	<pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 16:16:54 +0000
Subject: [PATCH v6 2/3] reftable/stack: add env to disable autocompaction
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Han-Wen Nienhuys <hanwenn@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

In future tests it will be neccesary to create repositories with a set
number of tables. To make this easier, introduce the
`GIT_TEST_REFTABLE_AUTOCOMPACTION` environment variable that, when set
to false, disables autocompaction of reftables.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 refs/reftable-backend.c    |  3 +++
 t/t0610-reftable-basics.sh | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 0bed6d2ab48..1cda48c5046 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -18,6 +18,7 @@
 #include "../reftable/reftable-merged.h"
 #include "../setup.h"
 #include "../strmap.h"
+#include "parse.h"
 #include "refs-internal.h"
 
 /*
@@ -247,6 +248,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	refs->write_options.block_size = 4096;
 	refs->write_options.hash_id = repo->hash_algo->format_id;
 	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
+	refs->write_options.disable_auto_compact =
+		!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
 
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 931d888bbbc..c9e10b34684 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -299,6 +299,27 @@ test_expect_success 'ref transaction: writes cause auto-compaction' '
 	test_line_count = 1 repo/.git/reftable/tables.list
 '
 
+test_expect_success 'ref transaction: env var disables compaction' '
+	test_when_finished "rm -rf repo" &&
+
+	git init repo &&
+	test_commit -C repo A &&
+
+	start=$(wc -l <repo/.git/reftable/tables.list) &&
+	iterations=5 &&
+	expected=$((start + iterations)) &&
+
+	for i in $(test_seq $iterations)
+	do
+		GIT_TEST_REFTABLE_AUTOCOMPACTION=false \
+		git -C repo update-ref branch-$i HEAD || return 1
+	done &&
+	test_line_count = $expected repo/.git/reftable/tables.list &&
+
+	git -C repo update-ref foo HEAD &&
+	test_line_count -lt $expected repo/.git/reftable/tables.list
+'
+
 check_fsync_events () {
 	local trace="$1" &&
 	shift &&
-- 
gitgitgadget

