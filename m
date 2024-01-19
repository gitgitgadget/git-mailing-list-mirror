Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C453818
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674434; cv=none; b=aZ1KPQ0uQ+yKAUhL/3L1YomIYknquRIK1UMiMwsYcjJw6s8MosK7u6elZnbVv+U8BIgunFZsatRxY7b7ZjLVua9LLki7PqhnRX93qo9iqKtEOat8u2f7hC/TjoAPPCzFfJeNsJ4dJlX91em5RB2a3OP+o+6TIuJMthE9fnVMGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674434; c=relaxed/simple;
	bh=VBuUIZj4MXSaR6BJrvBC8JFRnGuB2YlgjIo9azYdXXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzkagyZRpAK+9W4AICsPVEK068qulJ7AdAhhC31z6uKac7JpfkHJUk4wSblrrQ7vb/xBNMraKI9iGOEX7t0RuCqa7g01xKmliH1G+zKCyV4MMNMNrnbpeckFCRk56nSrS9bFzypeWEkBx5gofANM82sfNQ2+emX4FSIetTeNwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOqTQlga; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOqTQlga"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a38fb45c1so968327a12.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705674430; x=1706279230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFRFr0UHXnxVbfHpXYLEn59tpdZE0hdmL6wUKuGLr/U=;
        b=BOqTQlgaVq0cBWDHB/3YdD5H89Y2MMMG+gBsYJtEQ1f05HeMSTIGzzID2zTbmG+tfx
         xi4H3aziuEKXgcRIZjyNY8yUk24wRtlxc7DLnVITF74o3tY/+i2h+hEgG1IXxzP6QZig
         Mv6xuA2xtkbRDnTtMJwItJzU+iZv2yPd5Hmpurns0ioHx3vc3ddcfiRzfnIIh9Owd8r+
         8cIgaJr2er1fWdO0ZlUk5wSZBvJDa0c5KupEYQuuXwZMIHODkQwJXI9p0HmQJ4N9GIeX
         Fx+p9BSdpSIp/uR0HKRizhrKU2LDdQ/W8VvhP2x1qNGcdgU9qYU4IUb30xJk+en8JA/2
         dI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705674430; x=1706279230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFRFr0UHXnxVbfHpXYLEn59tpdZE0hdmL6wUKuGLr/U=;
        b=neFQZkZ7yMalbeqh955xQCxOB2jLRBzFV+bhGgFV0AdtCnJbJfDSDa4T0Y8e4qjXr8
         mWBEeKDwWACD06zVrKtz184QRGnpFLlLmrXuzFrU6RdgWygwVEL2nBKMf5pQSEo+DqWH
         yTHNGsrSqVz9UvDFsrD/vtyEBuDhGcsIca4AhWoSP4b3UvKQkTGkdzVMH0j+ao5+VuJV
         5yXObNxX7vUatesAzHBssyezupwDloCLDEflP/eZ1KFUmv2IrEsSMca7yjgrI//Z6upN
         fKqtoIl8RPELaL6xLpPOSQ0lGASAK6Jtqldgqg/GFnGbTf3jdpnUp1+TBpXtFWNgXSJ/
         pKkA==
X-Gm-Message-State: AOJu0YznMQbsQSc6wlLIXzQuHbov5EqG8R6rjofkSFPBOSBUPS9+JaGY
	Vkd8quuZDEgmh3Rm3FYsfcqhWntf1ayvKqf09f1pg6wBJjOhjio6Hdkj10qy
X-Google-Smtp-Source: AGHT+IFYOpaEfJ28uQlnnfP7UHsJ28LWUYdtlcrb2nbHTJl3lsX8IxazuC35InyZOLJgdlEXihhxZA==
X-Received: by 2002:a17:907:a606:b0:a28:c5dc:4802 with SMTP id vt6-20020a170907a60600b00a28c5dc4802mr1571173ejc.31.1705674429578;
        Fri, 19 Jan 2024 06:27:09 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm3843494ejd.112.2024.01.19.06.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 06:27:09 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/5] refs: make `is_pseudoref_syntax()` stricter
Date: Fri, 19 Jan 2024 15:27:02 +0100
Message-ID: <20240119142705.139374-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119142705.139374-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `is_pseudoref_syntax()` function is used to determine if a
particular refname follows the pseudoref syntax. The pseudoref syntax is
loosely defined at this instance as all refs which are in caps and use
underscores. Most of the pseudorefs also have the "HEAD" suffix.

Using this information we make the `is_pseudoref_syntax()` function
stricter, by adding the check for "HEAD" suffix and for refs which don't
end with the HEAD suffix, matching them with a predetermined list.

This requires fixing up t1407 to use the "HEAD" suffix for creation of
pseudorefs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                        | 21 ++++++++++++++++++---
 t/t1407-worktree-ref-store.sh | 12 ++++++------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 5999605230..b84e173762 100644
--- a/refs.c
+++ b/refs.c
@@ -829,6 +829,14 @@ int is_per_worktree_ref(const char *refname)
 
 int is_pseudoref_syntax(const char *refname)
 {
+	/* TODO: move these pseudorefs to have _HEAD suffix */
+	static const char *const irregular_pseudorefs[] = {
+		"BISECT_EXPECTED_REV",
+		"NOTES_MERGE_PARTIAL",
+		"NOTES_MERGE_REF",
+		"AUTO_MERGE"
+	};
+	size_t i;
 	const char *c;
 
 	for (c = refname; *c; c++) {
@@ -837,10 +845,17 @@ int is_pseudoref_syntax(const char *refname)
 	}
 
 	/*
-	 * HEAD is not a pseudoref, but it certainly uses the
-	 * pseudoref syntax.
+	 * Most pseudorefs end with _HEAD. HEAD itself is not a
+	 * pseudoref, but it certainly uses the pseudoref syntax.
 	 */
-	return 1;
+	if (ends_with(refname, "HEAD"))
+		return 1;
+
+	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
+		if (!strcmp(refname, irregular_pseudorefs[i]))
+			return 1;
+
+	return 0;
 }
 
 static int is_current_worktree_ref(const char *ref) {
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 05b1881c59..53592c95f3 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -61,18 +61,18 @@ test_expect_success 'create_symref(FOO, refs/heads/main)' '
 # PSEUDO-WT and refs/bisect/random do not create reflogs by default, so it is
 # not testing a realistic scenario.
 test_expect_success REFFILES 'for_each_reflog()' '
-	echo $ZERO_OID > .git/logs/PSEUDO-MAIN &&
+	echo $ZERO_OID >.git/logs/PSEUDO_MAIN_HEAD &&
 	mkdir -p     .git/logs/refs/bisect &&
-	echo $ZERO_OID > .git/logs/refs/bisect/random &&
+	echo $ZERO_OID >.git/logs/refs/bisect/random &&
 
-	echo $ZERO_OID > .git/worktrees/wt/logs/PSEUDO-WT &&
+	echo $ZERO_OID >.git/worktrees/wt/logs/PSEUDO_WT_HEAD &&
 	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
-	echo $ZERO_OID > .git/worktrees/wt/logs/refs/bisect/wt-random &&
+	echo $ZERO_OID >.git/worktrees/wt/logs/refs/bisect/wt-random &&
 
 	$RWT for-each-reflog | cut -d" " -f 2- | sort >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
-	PSEUDO-WT 0x0
+	PSEUDO_WT_HEAD 0x0
 	refs/bisect/wt-random 0x0
 	refs/heads/main 0x0
 	refs/heads/wt-main 0x0
@@ -82,7 +82,7 @@ test_expect_success REFFILES 'for_each_reflog()' '
 	$RMAIN for-each-reflog | cut -d" " -f 2- | sort >actual &&
 	cat >expected <<-\EOF &&
 	HEAD 0x1
-	PSEUDO-MAIN 0x0
+	PSEUDO_MAIN_HEAD 0x0
 	refs/bisect/random 0x0
 	refs/heads/main 0x0
 	refs/heads/wt-main 0x0
-- 
2.43.GIT

