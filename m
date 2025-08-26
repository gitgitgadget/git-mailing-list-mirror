Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0102F548C
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190492; cv=none; b=Iqphhu8KBzvQAtPyAyDZBry16nzd1O89XGDwbK9wnvDEb7Le4k4SchUR4cqQviG6b4o1exxAck617VJnLoOcZ1i9Gv6CgmO+lWQbM1OVhk4b5LwBQ1bdqK+6lV2zPJI7/gxn92zLcjoa9bJclBRbTcj7/PSnaa7nigpLRGbLM3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190492; c=relaxed/simple;
	bh=gA3YdjCoZE25sve9pWOqq+OoKiAdX49sQb3EatPlwCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RDCqs9o8gcEbOX1zo62lm6ADNLBluatye6o4A/10IxYr2XNT63vqm+kP+Nem0orH54k8yaRS8rG2lU/0bcy4gCGubqI4CTNNP6Pq0qM9GdVCxfPnPicq89yJ/PH7rWQg36h8kq4TKrh0wREUPuWqI/PnuxDMlVEx4hD5j43ql3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QieyJopT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QieyJopT"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so898357a12.0
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 23:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756190487; x=1756795287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvJIqPfmN2n3datLErbuAj8dzCtr24eFn5GeT+k3MgI=;
        b=QieyJopTRns3nfr7SCrdV24LZRxnacTbKhWQge2meKn/u8XBBGNufaYaKqWHke+qkh
         hmgND3I6FnLmkBcQx16DrVRUS+U9RxXNlTHfgYehqxvI7Pek/pOPk5Ulfbl666Uqqyp+
         /kwQNL5/ie9Gd6AWDxIexwhUOXownXsKCZ+R9DcsmoLqrv+5oXNeJRJWVJlsg5fEPnM6
         +XU3Z/uH5IWOAPH1yUQc8kAYE03TmBwuyU0lACF0KGtBkacQXz3C2ItFuzwc+RpY8UdS
         /lQbff7HL1n2xerSdagqAkkKDT1sAB5fWSkf8PrHJ+0CBbIJbvfF7KC9C7izErKuPd7b
         5hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190487; x=1756795287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvJIqPfmN2n3datLErbuAj8dzCtr24eFn5GeT+k3MgI=;
        b=QKw/UUj0HEMko7mGy57WiC2pMtR+voB9dijoktKS4y7ZcYW3aU7gC+CJzXU/lKEW6v
         s5tJaedSuukkx/zQVf4jpamTol8d07zZtQ/QP5P6Afy1S3FvZbBZPO1PWjol/jKyJebX
         qBnzMPzKlUJ/V2pM9MNFCXnD75uXW0uzuLe7E3O2UvA/+mbMcBY0uQwo07qdIzTfNL3Q
         7ZFdck6C44CIWOAMvsigc3aAvbwp5ucB6cgZk5qE1HRUBSbvAq1V8i1XkZ16fnPMb/Nb
         hl16QcKYCURBcsSvvlQNlV17KbMbxayMssvY19e6SP0tEhsdpwqZG8DM3xO61Eq+76M1
         CUjg==
X-Gm-Message-State: AOJu0YwEk6KhkZFB9lAQGFy7C66NgwUfrAhJBcATFOgJUm/UhTIouFrr
	thnKmkZYlz8zY+Rt71kZhGmw2SiQH1TuCE/cpzsmHrlsDHFbtd5XsltKIpEXhg==
X-Gm-Gg: ASbGnctNLqZlGbba5My+DmcSZn8y90wu3OQhlDQK2CrIMhk0Wdr2aG1i6Lv6lnjw/AX
	a4Okv5cDJvQpkFm2Rawa7ROHoCfHHVNPV1jDTycVW8Z0huRiXFfB5TSp+AmhPlPKSbpcwCStgbT
	gxqkR4HiMgZn5iuWYfbizmQGeXiJunOYxg25joYgPGWDedgkkrTAO8GlklxzGdcg9cML9gHPUF2
	VYuTqDwpMFxDNd11dOojRCeRvPWlEI3ZpfG/qTBwkd4biahByZJ+2nvvtINavEkyEK6w4wpDTcl
	e+NuqZw3jEBJHhkrTVPOsSjKau41mQDnsLvOsTaeCQ84OAFOYV+Sko9w4TrO2UoTey75dgYD75X
	yFdZegfWGgpVbFuznAkE2SUNokEn4uw==
X-Google-Smtp-Source: AGHT+IHXyaotEKP33VNOPDOyCA5c5sbm/Im5xlsMxpheL4TNPPcQ8x3O0okMdBHxdf/hcXQSROZiUg==
X-Received: by 2002:a17:903:11c7:b0:246:d5b3:6303 with SMTP id d9443c01a7336-248753a2961mr5716985ad.5.1756190486595;
        Mon, 25 Aug 2025 23:41:26 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889ddc6sm86442025ad.159.2025.08.25.23.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:41:26 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 4/4] t: add test for git refs exists subcommand
Date: Tue, 26 Aug 2025 12:11:10 +0530
Message-Id: <20250826064110.10540-5-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826064110.10540-1-meetsoni3017@gmail.com>
References: <20250823060012.540433-1-meetsoni3017@gmail.com>
 <20250826064110.10540-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test script, `t/t1462-refs-exists.sh`, for the `git refs exists`
command.

This script acts as a simple driver, leveraging the shared test library
created in the preceding commit. It works by overriding the
`$git_show_ref_exists` variable to "git refs exists" and then sourcing the
shared library (`t/show-ref-exists-tests.sh`).

This approach ensures that `git refs exists` is tested against the
entire comprehensive test suite of `git show-ref --exists`, verifying
that it acts as a compatible drop-in replacement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build          |  1 +
 t/t1462-refs-exists.sh | 10 ++++++++++
 2 files changed, 11 insertions(+)
 create mode 100755 t/t1462-refs-exists.sh

diff --git a/t/meson.build b/t/meson.build
index 4d6bc3d38e..93e9773ec8 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -211,6 +211,7 @@ integration_tests = [
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
   't1461-refs-list.sh',
+  't1462-refs-exists.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1462-refs-exists.sh b/t/t1462-refs-exists.sh
new file mode 100755
index 0000000000..349453c4ca
--- /dev/null
+++ b/t/t1462-refs-exists.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+test_description='refs exists'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+git_show_ref_exists='git refs exists'
+. "$TEST_DIRECTORY"/show-ref-exists-tests.sh
-- 
2.34.1

