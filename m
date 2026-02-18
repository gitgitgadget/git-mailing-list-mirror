Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029232FE042
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418813; cv=none; b=mAuXugTfuLODAeaphD7Mm73pMkKhX5Ph80NPOI6kWoKEj6KjjnchHO7dkpu3y1CZCRIrUAifNmQtNjrAthyryXJUcOaJx1W+7QNdO+UuzRyzga46g9WAHdY85I2oMrmSAJ2M/Ici0OEHe9EyFsIHn8wcDHj1699Z+Poe+RaEXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418813; c=relaxed/simple;
	bh=g33Qb0+0ILzKpkAIQp3D+IxKa4xy1v5FQpjyCyN7KBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6nsEU8ArlnWbefeYKHTjFTTmKwZ88+iy7hu2QFw8kBgjlTrpVeL+DFRo1og+5Xi94zh2XFTF8NnSOjLMt3Bb8B/d3s1KyKoxXty+y/qDoOxIMkP7CSZ6wxUh8dcdlNCtEF2AKDSE7vPjqdirHPQaa2GSK099awu1ZudIyTctCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBBzMPPX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBBzMPPX"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c635d5d594dso712489a12.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771418811; x=1772023611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gyVZhRNJD7zgcbcEZ20DXndpbGVBsdtUA+qQDsWVs8=;
        b=OBBzMPPX3Oangbb++aDDqHFVCUNaOnaOoMvgPkzGDi4p82jRU1zZ0jRx641pI4U22m
         ClI3n3+iaBsUv0KV37sWyD559Ce2uo0dni45tfihBiIdnYc4w/cwAQP4v2Qq5m3abBXv
         QgMMIRkicoDA5OzKwtOJkfHrERx5xR/VZd4MRy55doxmqprmkNpq/4jDRVEV2u3HDeIj
         ntA0+xpn/FobpXTedjKLg/obi1wckQLhhXhsCl7vXy54E+f9zhMjy08Nb1yNpFt9up07
         gzcfmcYLrUOW4hCXCxyvzjYSnRdQOfoNj6p3JV9n+oFZUthpetPMnJZREAFQZLVaLNt5
         4nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771418811; x=1772023611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gyVZhRNJD7zgcbcEZ20DXndpbGVBsdtUA+qQDsWVs8=;
        b=pIIBVxPkRgT9/8glLILTs6XUgdgG97nioRUSbv5PgT8LsExMk+pLMl0YTxhHMFSfqw
         ncPcVl2y3qOIBRuPRb6PC3DyNQtVb84TqYJXiHEVfJ4gMJCO/7ddCgE4LyF66wYENa84
         xX9aPZ1vxtLvA2GPizyrOyE5RJwAvnDb+IOQzMDsacVhrhmvIgwrm4LJgNxR8icj31p8
         fFqyyI3AD1Fc9aW7FiJ2ZBELRr3wzP6i21uKeLyxBer4MySsXcvFSq4SeXdTfovzsgIx
         dUaitPO3RhU47bOhRrARdO9aWSuQPkz+fo/hJGEHJmk2HDpeBruP5hXGJme3VGYFDD6V
         Pq/g==
X-Gm-Message-State: AOJu0YyEaiBWMQXV32vtSAGKS6h5taBwZxYMTzg0jIrmlp2YXwuD6QKQ
	TWn9+/u/Hmxe6HWECU3xxgDxycsrEMBQfEVTtECDm9fW20H5uyHTpuUB
X-Gm-Gg: AZuq6aLUf7HUkeBrIjR70VPynOdXjr09B+uX0uc9ieoeggGyKVOMwLMgLeaP5WyYPOQ
	98FAs00p+uz5z2FLy7gJczRw6ZP7SgK23dAAQjYz2Yp3T90uDC7wp9eixQEgBQCRIEo2/s7PDuS
	Ll9aREFsF1R2tZgtyU+yfWWq7qy8GqEGGqYXYXLvRrtxQ2Wp0qvmZTfAWmBj3sZDPAh/1aFSCoj
	Ux19F26Vskd3Ri6ItvPWMAx/iDgkAUzxpu8U2nrLjjSroD4FpyIs9mOm6NaNjgFHAt9+z6ufF/q
	GVDxnwf6Jkc6b1r50DVh59XsB12fZrjbezzlcLfZe1KKfyrYBeiD+8RfmPK5788SjdEWpr6iwnf
	34GsQegNOIh18gVx7oh/NnaxXJKlj8PzuddXlk/2uVgDFADf10uxLlbiXmonGFcP/vg1lVrRijj
	7pbbUBhCr7FS9JmDzyskdwK/O0b8wfpzmu+c1Pw0k=
X-Received: by 2002:a05:6a20:3d06:b0:35e:11ff:45bd with SMTP id adf61e73a8af0-394672a3693mr11853636637.5.1771418811284;
        Wed, 18 Feb 2026 04:46:51 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69ee6sm16639485b3a.32.2026.02.18.04.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 04:46:50 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	karthik.188@gmail.com
Subject: [PATCH v6 1/2] setup: distinguish ENOENT from other stat errors
Date: Wed, 18 Feb 2026 20:46:37 +0800
Message-ID: <20260218124638.176936-2-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218124638.176936-1-a3205153416@gmail.com>
References: <20260218124638.176936-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, 'read_gitfile_gently()' treats all 'stat()' failures as
generic errors. This prevents distinguishing between a missing file and
real errors like permission denied (fatal).

Split 'READ_GITFILE_ERR_STAT_FAILED' into two:
 - 'READ_GITFILE_ERR_STAT_ENOENT': The file simply does not exist;
 - 'READ_GITFILE_ERR_STAT_FAILED': Real I/O or permission errors.

Introduce 'READ_GITFILE_ERR_IS_A_DIR':
 - Used when the path exists but is a directory.

Update 'read_gitfile_error_die()' to handle these cases:
 - Happy path ('ENOENT', 'IS_A_DIR'): Return without dying;
 - Fatal path ('STAT_FAILED', 'NOA_A_FILE'): Die immediately.

This prepares for error handling in the next commit.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 setup.c | 17 +++++++++++++----
 setup.h |  2 ++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index c8336eb20e..d48b6a3a3d 100644
--- a/setup.c
+++ b/setup.c
@@ -897,10 +897,13 @@ int verify_repository_format(const struct repository_format *format,
 void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 {
 	switch (error_code) {
+	case READ_GITFILE_ERR_STAT_ENOENT:
+	case READ_GITFILE_ERR_IS_A_DIR:
+		break;
 	case READ_GITFILE_ERR_STAT_FAILED:
+		die(_("error reading %s"), path);
 	case READ_GITFILE_ERR_NOT_A_FILE:
-		/* non-fatal; follow return path */
-		break;
+		die(_("not a regular file: %s"), path);
 	case READ_GITFILE_ERR_OPEN_FAILED:
 		die_errno(_("error opening '%s'"), path);
 	case READ_GITFILE_ERR_TOO_LARGE:
@@ -941,8 +944,14 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	static struct strbuf realpath = STRBUF_INIT;
 
 	if (stat(path, &st)) {
-		/* NEEDSWORK: discern between ENOENT vs other errors */
-		error_code = READ_GITFILE_ERR_STAT_FAILED;
+		if (errno == ENOENT)
+			error_code = READ_GITFILE_ERR_STAT_ENOENT;
+		else
+			error_code = READ_GITFILE_ERR_STAT_FAILED;
+		goto cleanup_return;
+	}
+	if (S_ISDIR(st.st_mode)) {
+		error_code = READ_GITFILE_ERR_IS_A_DIR;
 		goto cleanup_return;
 	}
 	if (!S_ISREG(st.st_mode)) {
diff --git a/setup.h b/setup.h
index 0738dec244..ed4b13f061 100644
--- a/setup.h
+++ b/setup.h
@@ -36,6 +36,8 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_NO_PATH 6
 #define READ_GITFILE_ERR_NOT_A_REPO 7
 #define READ_GITFILE_ERR_TOO_LARGE 8
+#define READ_GITFILE_ERR_STAT_ENOENT 9
+#define READ_GITFILE_ERR_IS_A_DIR 10
 void read_gitfile_error_die(int error_code, const char *path, const char *dir);
 const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
-- 
2.43.0

