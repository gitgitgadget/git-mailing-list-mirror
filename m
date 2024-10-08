Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566861C69D
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352774; cv=none; b=r5dW8VPDLzNiLbLjW4vVerM38XkN/3zyq5agqiWCOoCoPw6n9ORybD9o+IacCWGxwpgcosT9tIUuGtW3qSfTU74Kw+jYzfH7d3k0+R8nsNZWhTYHUYG7P9ZTK5vNXrLq9lxTndUw02caU2HbqYZ8+LFURDBE2dsL8TS8rPpJJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352774; c=relaxed/simple;
	bh=j0QW1uq9kKqXG7e8rGbpBjanq/56r8WQZNqHkb4gYyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFuokNkok+6v4KxrI7Z6eupdgzVKvF2IVrhheS0JCvjBWfz6FOvr05v0B1whhnHM/kGb54g+D4QHvM3LxI+ellBlPHR6GCyMNiYYtUGJReBbtQQhGBOFyp8PHItt1UQwKrrT3CtFa623khe+stBN8RodFvyVi0i4i+did/QWhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mariadb.org; spf=pass smtp.mailfrom=mariadb.org; dkim=pass (2048-bit key) header.d=mariadb.org header.i=@mariadb.org header.b=KNc/yHCa; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mariadb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mariadb.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mariadb.org header.i=@mariadb.org header.b="KNc/yHCa"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so4141877a12.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 18:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google; t=1728352770; x=1728957570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnAxnxam5/Up8Xl63a2a3fTJIkhbeWBgepeB+jb1yq0=;
        b=KNc/yHCaB7MegQuvCu2FboTxrCFZZR/PI4ubjLurcdPKdwci9207BTGrel1P39sEhg
         zQ1KNYLYbfI6aRHv57RWy14XWaPnTzJusXYiHQNcFbDlyLO508Dzk/jxZpQzGHbit3RN
         cy6lEG/q7QbY7SNjkFPNguboUPXZ/ilM9VdrYcltD9tt60BNttudL9Qc41SWtWg39RZS
         g0C2R6M/exlrwOtvbjUaG+VFu9IoPTuMm3r9MwBdBiEdcSYd3zDmCrsytVf5kToHCGkU
         OAooNyFh9DbM91IPY9/+P0WudTgdqUrU+Mn8JwKREmJSk6d+toc0BP+8z25/yCU1GcKz
         L2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728352770; x=1728957570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnAxnxam5/Up8Xl63a2a3fTJIkhbeWBgepeB+jb1yq0=;
        b=pNd3KOGV0ydp/WnSWCfcbqVc5rgBbpUx32Avf19Y76pEl9FRfgmfGNR+qQD08uXK4r
         4Y6j8Bp77xX2eh43etBn51arAHqrpEyogum/h0s2ep/7a8ZbxEN3bqAEiBYM1CGbjY24
         sP2OsononAkx9SnJmJ7NtO58+fDYKBVcdYEcBFkh5dLilcy72lvrpxtaBqSTKIzj+G07
         LN5BXJAvBPuMEDx7GuOrGL7/SZyxwVihUc8ELokVvdHMawRE5YhlHJa9UfqMI994j8pN
         cS/daEzOHh5Mul4ULG9fj/CtcFrjwkpln79ycArvJZ1Si2SM4vFXwph+7wZMwEvQEWDh
         i7yw==
X-Gm-Message-State: AOJu0Ywrjp4U98hBGmBUwiVK9O2C2MfMsK3r0qMeLFY1k/FaeZqWNALN
	sXdIJL2EzGhlRY774IahJUDOoer0LOC0prbhXlIfOZIEJDWoTZEWzuN7G/QVagPu/fp/vTBBqDy
	Lw3A=
X-Google-Smtp-Source: AGHT+IFBIWLZosfb+CwA+8vIa6X9MpVH9h0fpFPN4Uh2B1gj/sM7gSCTZbKTZFniOkvdsUbOt18gSw==
X-Received: by 2002:a05:6a21:a4c1:b0:1d5:2d6d:1614 with SMTP id adf61e73a8af0-1d6dfa427ccmr22076281637.23.1728352770547;
        Mon, 07 Oct 2024 18:59:30 -0700 (PDT)
Received: from bark.fritz.box ([206.148.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d695cdsm5112789b3a.183.2024.10.07.18.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 18:59:30 -0700 (PDT)
From: Daniel Black <daniel@mariadb.org>
To: git@vger.kernel.org
Cc: Daniel Black <daniel@mariadb.org>
Subject: [RFC PATCH v2] submodule: correct remote name with fetch
Date: Tue,  8 Oct 2024 12:49:54 +1100
Message-ID: <20241008015835.41678-2-daniel@mariadb.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008015835.41678-1-daniel@mariadb.org>
References: <xmqq7carzpzi.fsf@gitster.g>
 <20241008015835.41678-1-daniel@mariadb.org>
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
 builtin/submodule--helper.c |  9 ++++-
 t/t5568-fetch-submodule.sh  | 65 +++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100755 t/t5568-fetch-submodule.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a1ada86952..567d21d330 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2322,7 +2322,14 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
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
diff --git a/t/t5568-fetch-submodule.sh b/t/t5568-fetch-submodule.sh
new file mode 100755
index 0000000000..56978bcfd7
--- /dev/null
+++ b/t/t5568-fetch-submodule.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+test_description='fetch can handle submodules origin names'
+
+GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
+export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+SUPER="$HTTPD_DOCUMENT_ROOT_PATH/super"
+SUB="$HTTPD_DOCUMENT_ROOT_PATH/sub"
+SUPER_URI="$HTTPD_URL/smart/super"
+SUB_URI="$HTTPD_URL/smart/sub"
+
+setup() {
+	SERVER="$1"
+	git init "$SERVER" &&
+	test_when_finished 'rm -rf "$SERVER"' &&
+	test_config -C "$SERVER" http.receivepack true
+}
+
+test_expect_success 'fetch submodule remote of different name from superproject' '
+	setup "$SUPER" &&
+	test_create_repo super &&
+	test_commit -C super bar &&
+	git -C super remote add upstream "$SUPER_URI" &&
+	test_config -C super push.default upstream &&
+	git -C super push --set-upstream upstream master:main &&
+
+	setup "$SUB" &&
+	test_create_repo sub &&
+	test_commit -C sub foo &&
+	git -C sub branch newmain &&
+	test_commit -C sub morefoo &&
+	test_commit -C sub moremorefoo &&
+	git -C sub remote add upstream "$SUB_URI" &&
+	test_config -C sub push.default upstream &&
+	git -C sub push --set-upstream upstream master:main &&
+
+	git -C super submodule add --branch main -- "$SUB_URI" sub &&
+	git -C super commit -am "add submodule" &&
+	git -C super push &&
+
+	# Needs to create unreachable commit from current master branch.
+	git -C sub checkout newmain &&
+	test_commit -C sub echo &&
+	test_commit -C sub moreecho &&
+	git -C sub push  --set-upstream upstream newmain:newmain &&
+
+	git clone --origin o1 --branch main -- "$SUPER_URI" superproject &&
+	git -C superproject submodule update --init &&
+
+	git -C super/sub fetch &&
+	git -C super/sub checkout origin/newmain &&
+	git -C super commit -m "update submodule" sub &&
+	git -C super push && 
+
+	git -C superproject pull --no-recurse-submodules &&
+	git -C superproject submodule update
+'
+
+test_done
-- 
2.46.2

