Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CF2E1C6B
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579017; cv=none; b=TnsXrpEGrVUc05Ohxv9XRsKKNoqRZxB1MPwsnU4O8uZsB47tKLmRMB9jVpVFhj9H+8DNY5MxkDCnTcPZ3cVwixmgUlsdBjnSPHN9cJ6ijHiTB9joIkFIOaPiWdpopsl46GdcRx7NA+Dmf06cGOG77djjFBHPfYqxZNJ/l8fdRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579017; c=relaxed/simple;
	bh=kUM7j88GZc8eDErqeAMMPig3vyVqLSSYAN+F2oOycMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgZg/Q3/whfMlRTXfjnMYUWy8uqh1LkMrg90Qfe7fsbVqmI73pgff0gQ/7qJiwzBWfL4c4FjlxRJGJJtM0rTIIB7ciIhi2PvU+fGlI9MhNR6YF/yv7BWJP2hU9T3yex4FT0zL/+sFOuDp3m8svvTQkigXErgQpNFOry3wscYVsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuxrZhcZ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuxrZhcZ"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e89d226c3aso1117586fac.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765579014; x=1766183814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yyPCWKv5Kudmi/ozfafcKivz/TSrZdYajtCuwOaGiM=;
        b=XuxrZhcZEEJWmpW2mUW+eMVRqoACfyTqzLGJOZp6Zcql0mE1BSVEPv23NMteQ7ivLN
         hRepETJNRm8RXYvftNo8ejCRuEAbbliklPisLKkrvntla1gKBFvY6UElff41S7vebcaF
         ee7EC0FCJKmBBg3w5RyMWcqmVcAZSPPTr/I9U1gAAnHy86kBAxA+r8jGAmyZBlRJ7tOl
         fAKESPsNn4PrhSUKDTwzsMxmDGKiSb3q2KPImj7Kyd7TZS+y/zpewVAxm4yJTkXxRi9T
         EK5Og9soluf5RZzUVi/f0fcOECtCElzoDt6hRFCh83pS0anvZGyBOXmC+Prv5vlB4qiw
         Gvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765579014; x=1766183814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4yyPCWKv5Kudmi/ozfafcKivz/TSrZdYajtCuwOaGiM=;
        b=Tur1JtilMlj9Kw40P/Xa4OjyxmBxbIOPTGvDPVwv6wxR4E6sPBLuADrWGV1ZZnH6L9
         GFmRL/greu8RHyToD3n0ySAUSa69wnxKBks4axwB+y0H+CxPD3AexiYQ9h9lBXtAwhrF
         326wLMVWBPwsaWZB9FUlOtwJg1/Rij2oQSeeFR0SVqJiRbbJTI+f5J17xEf3HwtakRcD
         kQ3cekH/8Ax43Li7+u9BWpGc42Baj6So9ERdizYDR50TkoXZRjUV+KzLxdJqKtQTl0dv
         1zXL51TKxp6EVCRHMygjAAm5nrLcsd+C+wCRniBb7wUaWaTI1Y2dFSAaCS8GMkMKMWSM
         RgEw==
X-Gm-Message-State: AOJu0YxyMTjdfEziOKhoU0J8WCWbRaZ8kTADqARKFsQ3unRMjFPnPIYJ
	QMsz2c2hGlREMx4TBm2/2i7KYlffeCDWCTWLX5aVNV08XScuiX2XRvrA8GbwVQ==
X-Gm-Gg: AY/fxX7nH62QfQH+R7SI3sZ7TCRK7jfoEpfpOmO5Gjut+uCt4I448dx0g33v4rkkMIF
	r14LIucRk3s87yTFpi7GUDdriDxOdLUSAMU8ECdoGpS+ZHquX8AyxSg5Yi4JtaA/GyS38lhPIWB
	rAVl5uE6pia1ReAktlDHGOd/6GoTog+anvY82ZLTyABKCmtPx3Ru8ko0sz+cSF17BabSNEX7p9l
	Njg+AAiVQG6UdMY/bOUiswbtYm1rFUujaEg1wwOnlJVWI+FE1Fh48UGdD4r6SnDK8JuxKCKGtgS
	nbcB1UhSsYSV8Z4xQERcEabZaNjcJwBTXbNUc3TVzS9xZiS0W8VNNZX1MeBpq6wT6Fc8ZkfmnPZ
	Po9lyUo7ISF73gu0P3Bs9ljKFWmJtsfe6S4WOs8PXUEpTxoW4HLhuCw/VmFbHCwj+6oMZ1uj9yS
	1T46cCoK38H+6zk2biFTs=
X-Google-Smtp-Source: AGHT+IHVYgTeCck1+yuGAB+cg+2coO5J7KyuN5qsl2JSQDRtCRw6v1GZEIXEL2wStX+O5CMeaYrJXA==
X-Received: by 2002:a05:6870:e086:b0:3f5:b16e:82c6 with SMTP id 586e51a60fabf-3f5f8d20403mr1835471fac.52.1765579014457;
        Fri, 12 Dec 2025 14:36:54 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm173998fac.10.2025.12.12.14.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 14:36:54 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 7/7] builtin/repo: add object disk size info to structure table
Date: Fri, 12 Dec 2025 16:36:44 -0600
Message-ID: <20251212223644.3090879-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251212223644.3090879-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to a prior commit, update the table output format for the
git-repo(1) structure command to display the total object disk usage by
object type.

Since disk size may vary between platforms, tests do not validate actual
values and only check that size info is printed in an empty repository.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            | 13 +++++++++++++
 t/t1901-repo-structure.sh | 19 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 252a53f452..c294fa11d2 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -331,6 +331,7 @@ static void stats_table_setup_structure(struct stats_table *table,
 	struct ref_stats *refs = &stats->refs;
 	size_t inflated_object_total;
 	size_t object_count_total;
+	size_t disk_object_total;
 	size_t ref_total;
 
 	ref_total = get_total_reference_count(refs);
@@ -365,6 +366,18 @@ static void stats_table_setup_structure(struct stats_table *table,
 			      "    * %s", _("Blobs"));
 	stats_table_size_addf(table, objects->inflated_sizes.tags,
 			      "    * %s", _("Tags"));
+
+	disk_object_total = get_total_object_values(&objects->disk_sizes);
+	stats_table_size_addf(table, disk_object_total,
+			      "  * %s", _("Disk size"));
+	stats_table_size_addf(table, objects->disk_sizes.commits,
+			      "    * %s", _("Commits"));
+	stats_table_size_addf(table, objects->disk_sizes.trees,
+			      "    * %s", _("Trees"));
+	stats_table_size_addf(table, objects->disk_sizes.blobs,
+			      "    * %s", _("Blobs"));
+	stats_table_size_addf(table, objects->disk_sizes.tags,
+			      "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 1553f3cd32..6a992222df 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -9,6 +9,15 @@ object_type_disk_usage() {
 		--filter=object:type=$1 | awk '{ sum += $1 } END { print sum }'
 }
 
+strip_object_disk_usage() {
+	awk '
+		/^\|   \* Disk size/ { skip=1; next }
+		skip && /^\|     \* / { next }
+		skip && !/^\|     \* / { skip=0 }
+		{ print }
+	' $1
+}
+
 test_expect_success 'empty repository' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -35,6 +44,11 @@ test_expect_success 'empty repository' '
 		|     * Trees          |    0 B |
 		|     * Blobs          |    0 B |
 		|     * Tags           |    0 B |
+		|   * Disk size        |    0 B |
+		|     * Commits        |    0 B |
+		|     * Trees          |    0 B |
+		|     * Blobs          |    0 B |
+		|     * Tags           |    0 B |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -81,7 +95,10 @@ test_expect_success SHA1 'repository with references and objects' '
 		|     * Tags           |    132 B   |
 		EOF
 
-		git repo structure >out 2>err &&
+		git repo structure >out.raw 2>err &&
+
+		# Skip object disk sizes due to platform variance.
+		strip_object_disk_usage out.raw >out &&
 
 		test_cmp expect out &&
 		test_line_count = 0 err
-- 
2.52.0.209.ge85ae279b0

