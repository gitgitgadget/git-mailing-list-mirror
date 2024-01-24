Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8695384
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110057; cv=none; b=JXA3gykNPSz2wBePDlP2He9KkaDclcRddGC7kxtigb0BbOZWaYUDPTu6JLbcFzIqIAN6spX++65/fHGP4A4GbqlqBaFgn2FUAk0z+RiWS2YcIGtOec/XDtsxuB2lMlVyBz8Rb+DvdX0x1Q0USXw8p/eAYB6rn4lctTSaQHDI6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110057; c=relaxed/simple;
	bh=HVrGRwlhKtHb+eMYjfeEB+V3IjJZypVoGABR0ohVoQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Smfv0BOAiNNx9V5swCGNy8jHz/s24ioVdyKknL/IYRa2uZ0ktc9ecKmRQGfURi7u/miQaXjcsCF3ojlvpNH7ha09nW68SkGjoYwnyD6rpXlVD8PEE5gBUZx3EoPJ4UE0Oj2a4FR0cfXjxT7GYLFBb2BfjtCc4naZg+tG1Hjx1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvPo7dxD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvPo7dxD"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a356f8440so6777797a12.2
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 07:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706110053; x=1706714853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FxnNBtkEIr9Vr7LOwdU5jTdmDcPZNIOUxI8CHhGmXU=;
        b=ZvPo7dxD88UGlxxhO8uixGV5YYKoHTjmkefXG3IwRg2jlm0KozK4GZggunQw618uGR
         JT9EOi2u9wUdvmPUBBZqkeNNmiJpwl5NFCttO97rCcNgi0gj8w2j0gvYN+dMGJPejx5L
         JERCnnfxh8o2rw6ndPenN8fPa3YKuoKl8ADjzLTPz/APDZz5pbnvnYEu0ZgtDmubXWaJ
         7didDwkEjEbGo+KjidfgRjHvAktGTAIPUYvRwJ/s0ugOpBwa6vezvVqA75ZBnGOFoXjo
         dk2Tf88vaGttk7mipfn0tuUzMXSMGykbPc6R32Bj4Bk+i0H57AfsW794oYJsj9hucPea
         Hy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110053; x=1706714853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FxnNBtkEIr9Vr7LOwdU5jTdmDcPZNIOUxI8CHhGmXU=;
        b=FLn/zDdac1H4iie3oeKOKixCibb6jR7PIbd/paWjtceNJnLY0Lwe8DqfzhUvxb2iYa
         m/mkS788EOttUcnqVj2Wo+cSqbNf+MUPXvlIoyi3BSCi2Cs9Q9VZRJUXUPHOq4vYSZyE
         rsU1nHir9xURQOGtFpmk9B8cR3BdvBM59YdmLttt6+kdfVJipwtY0e3ETdTXF7eLz1+S
         tOLSUiLj+B6C90VeFcnLooR8xyyXwgpnvUNMnrWC2cbbHbllrn//A9J2K3DjJjQ9kj0h
         kg1zGr8DobG8czDgF30att8ptdQo0BS1gUZkCeuwzWrmq7i7VeNgoqAGZN93fOEeHYjJ
         EE/g==
X-Gm-Message-State: AOJu0Yxq6+P/NRsKZAKOIpmqUqisg+FU7J/+GV2a9Dn1wXQGrkCek+km
	DWowZOpSYaMsleZQ7IrSXZEQ7zh6YwG5G4bOSe3F3yxcOEU0z1+bhFrnKE3U
X-Google-Smtp-Source: AGHT+IFrFokLWzXiSgbbSkgfS4lm8+TiX3+O0OWE4P6WPCjEK9KR2pDt5kT+QP+VnI1RRRY66TNJ9w==
X-Received: by 2002:a17:907:619d:b0:a31:1313:fcf5 with SMTP id mt29-20020a170907619d00b00a311313fcf5mr688498ejc.121.1706110053223;
        Wed, 24 Jan 2024 07:27:33 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id vh12-20020a170907d38c00b00a2eb648cdc5sm8765225ejc.156.2024.01.24.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:27:32 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 2/4] refs: extract out `loose_fill_ref_dir_regular_file()`
Date: Wed, 24 Jan 2024 16:27:24 +0100
Message-ID: <20240124152726.124873-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124152726.124873-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240124152726.124873-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract out the code for adding a single file to the loose ref dir as
`loose_fill_ref_dir_regular_file()` from `loose_fill_ref_dir()` in
`refs/files-backend.c`.

This allows us to use this function independently in the following
commits where we add code to also add pseudorefs to the ref dir.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 62 +++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b288fc97db..22495a4807 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -229,6 +229,38 @@ static void add_per_worktree_entries_to_dir(struct ref_dir *dir, const char *dir
 	}
 }
 
+static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
+					    const char *refname,
+					    struct ref_dir *dir)
+{
+	struct object_id oid;
+	int flag;
+
+	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
+				     &oid, &flag)) {
+		oidclr(&oid);
+		flag |= REF_ISBROKEN;
+	} else if (is_null_oid(&oid)) {
+		/*
+		 * It is so astronomically unlikely
+		 * that null_oid is the OID of an
+		 * actual object that we consider its
+		 * appearance in a loose reference
+		 * file to be repo corruption
+		 * (probably due to a software bug).
+		 */
+		flag |= REF_ISBROKEN;
+	}
+
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (!refname_is_safe(refname))
+			die("loose refname is dangerous: %s", refname);
+		oidclr(&oid);
+		flag |= REF_BAD_NAME | REF_ISBROKEN;
+	}
+	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
+}
+
 /*
  * Read the loose references from the namespace dirname into dir
  * (without recursing).  dirname must end with '/'.  dir must be the
@@ -257,8 +289,6 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	strbuf_add(&refname, dirname, dirnamelen);
 
 	while ((de = readdir(d)) != NULL) {
-		struct object_id oid;
-		int flag;
 		unsigned char dtype;
 
 		if (de->d_name[0] == '.')
@@ -274,33 +304,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 					 create_dir_entry(dir->cache, refname.buf,
 							  refname.len));
 		} else if (dtype == DT_REG) {
-			if (!refs_resolve_ref_unsafe(&refs->base,
-						     refname.buf,
-						     RESOLVE_REF_READING,
-						     &oid, &flag)) {
-				oidclr(&oid);
-				flag |= REF_ISBROKEN;
-			} else if (is_null_oid(&oid)) {
-				/*
-				 * It is so astronomically unlikely
-				 * that null_oid is the OID of an
-				 * actual object that we consider its
-				 * appearance in a loose reference
-				 * file to be repo corruption
-				 * (probably due to a software bug).
-				 */
-				flag |= REF_ISBROKEN;
-			}
-
-			if (check_refname_format(refname.buf,
-						 REFNAME_ALLOW_ONELEVEL)) {
-				if (!refname_is_safe(refname.buf))
-					die("loose refname is dangerous: %s", refname.buf);
-				oidclr(&oid);
-				flag |= REF_BAD_NAME | REF_ISBROKEN;
-			}
-			add_entry_to_dir(dir,
-					 create_ref_entry(refname.buf, &oid, flag));
+			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
 		}
 		strbuf_setlen(&refname, dirnamelen);
 	}
-- 
2.43.GIT

