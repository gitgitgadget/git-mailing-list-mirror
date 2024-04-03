Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD28195
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103643; cv=none; b=Gu7v58oGOeIdBBNmlWJHsmRjI4rhITVU5zoeZKA7OcbIK9quXRAkdceflH5w2AwBSCF0sboNP9ZfCEDFatJvDqaGsFtGcDoiYAU/Q5Ee6PCvS0pAXhZVv/vDT6hGUcBJF/kolWiArcQBvjiOSxMQHhfGL9kfbgQqxvswT0l/56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103643; c=relaxed/simple;
	bh=we2vTm34A1KuvdzBKVwuVLX7xvVnacs1tI+eO1hSoU4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=anuxqBBg3exhrfOg9SYTDFYGYvRCau0pErerfSHx8gfIXQUFgzLub/JGJO59+4552pARIkhBujFyp8R/ZXbqCxSAilGj1RbUJwN7OfbL2BDY0xhIT4MYzSZPtr1+qcwfx3Uk63bKfWIIESEIujEEXsBpHwuRfXs3VUqPXUukkNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWHmT+ak; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWHmT+ak"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343954d4dfeso19862f8f.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 17:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712103639; x=1712708439; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYcD5t6JzVWk1j7Xg0hQHRSGM1vQ14MZemxLsGLLycI=;
        b=eWHmT+akLDhwv+dG05xhAVVjXNnyUZx+R17DSRJAqkthckHbPzedvGRuhplWbDTG0K
         tbGEvVX7qRdAt07DT5m71yxagtyjsJZ3yo1YLFmTCPH/oUvf8c+fJwtEmZGA+tNvr4pr
         nqVdMGhQGjyANQ65JkT8yav5nTWrvV0ETn+YGNsBxLdTRd16ZUOIZi8OKOlEwmxnPWOd
         9rP6z6NgUBcLw/s8S/S2IiRgTZTuuXUfY3d/B5I5Nr37yLNG0YzT1IrLZzybKfToEQ6x
         Yb25ANQZ/mdFCE+GVsGo/7/CBYDCfO2PZXOF4Bri/RbfmwpxbDVNGWhF3ovI+J06Jh91
         lreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712103639; x=1712708439;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYcD5t6JzVWk1j7Xg0hQHRSGM1vQ14MZemxLsGLLycI=;
        b=kuL3IstNbJDYV2dNK035GM2rolRiPhpysAxypbxUjSyNoC1WpGxspuXDVtzh0oCqOQ
         CvY9fzkxdgzm43v/XPGGuGUUlb7hL38X8fvu+8dc44FGoXxv8U7GHYAHVCxwOPdEUGRb
         lWAihKfQJ4NteiHpb6mjZ6BBVMtizQ05agnBW9s5sqfMa3P01Dba4VwdnfFeUahHDJjW
         DtOZ4PjNAHjkvPlWCTcA+dqENJ5E1QSY5I0VqAWejWrOCfry6Yr+/30T0fbgiMY9Ur/W
         p0jqjAhGKvghb4KqU+C8apzMhA2EPhDInOt2MnlMK9gj9VI6vgtEmsm+aZEbovJnsnQe
         s2yw==
X-Gm-Message-State: AOJu0Yw/WlzGtkfLGl+wxsDljp8Wmpz6FmBrQKnIkber88MFk4L+Natw
	ZwyVJUmEO+HQHPMJqExVKnZhq03j9v3wvK/N+0Zw2d4cLJEDTXDgdcujc+SU
X-Google-Smtp-Source: AGHT+IEUPXHe0V1nJJIgU4UqDN07aU6r8JSFhBhefLcgMDe33q7CiFInE17nq1+S7flK6LODF2irqw==
X-Received: by 2002:a5d:60c2:0:b0:341:b4f7:982 with SMTP id x2-20020a5d60c2000000b00341b4f70982mr8928252wrt.13.1712103639138;
        Tue, 02 Apr 2024 17:20:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8-20020adfee48000000b0033e95bf4796sm15497631wro.27.2024.04.02.17.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 17:20:38 -0700 (PDT)
Message-Id: <2a0421e5f20b7d43619be20e8f500fedd55f2829.1712103636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
References: <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
	<pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Apr 2024 00:20:35 +0000
Subject: [PATCH v4 1/2] reftable/stack: add env to disable autocompaction
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
    Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

In future tests it will be neccesary to create repositories with a set
number of tables. To make this easier, introduce the
`GIT_TEST_REFTABLE_AUTOCOMPACTION` environment variable that, when set
to false, disables autocompaction of reftables.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 reftable/stack.c           |  3 ++-
 reftable/system.h          |  1 +
 t/t0610-reftable-basics.sh | 21 +++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1ecf1b9751c..4c373fb0ee2 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -681,7 +681,8 @@ int reftable_addition_commit(struct reftable_addition *add)
 	if (err)
 		goto done;
 
-	if (!add->stack->disable_auto_compact)
+	if (!add->stack->disable_auto_compact &&
+	    git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
 		err = reftable_stack_auto_compact(add->stack);
 
 done:
diff --git a/reftable/system.h b/reftable/system.h
index 5d8b6dede50..05b7c8554af 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -17,6 +17,7 @@ license that can be found in the LICENSE file or at
 #include "tempfile.h"
 #include "hash-ll.h" /* hash ID, sizes.*/
 #include "dir.h" /* remove_dir_recursively, for tests.*/
+#include "parse.h"
 
 int hash_size(uint32_t id);
 
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 686781192eb..444f7497907 100755
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

