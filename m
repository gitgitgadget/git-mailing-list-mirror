Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCAC5BAD2
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528137; cv=none; b=BWzzZw9FgzMpWlmynihEgynlubX4nEo/UzMB5wCUVtXDeUY50DH1gOohzi5clBhDq1z0T1FcizB0LLgSbLnisUU482NofC8p9ho7DtQXfrfyhvFfJGpdwgCH155CmnsCu40Ps0n+m3+Ef6Y0JTQo+e7nqpCUpYFcUupPMLottIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528137; c=relaxed/simple;
	bh=HVrGRwlhKtHb+eMYjfeEB+V3IjJZypVoGABR0ohVoQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZKoeVL2dgsff7gAk2p3FVmHbof0IqeCDoTmKY5j9fu6t+X7LIXYKLSOPdlUnY6DpfyzgPdPISh1Ixn6M0bnkB7l4HhSizw5JXvdHZp1YdURPu+z2wtN1m3Joih+ouOBLdfv6rAooyHu+xy5mdk26wzJ3OiLpCeAVAWUCO1mc1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKNYPeU5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKNYPeU5"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a353f5407f1so200359066b.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 03:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706528134; x=1707132934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FxnNBtkEIr9Vr7LOwdU5jTdmDcPZNIOUxI8CHhGmXU=;
        b=EKNYPeU5txtKG4crUSnXVZMirECr4l2NTcm+TT2ESpfQGg0FtjGjxvZwbOPdq3YvWN
         ezu6Wtlc7IQ9+5pa7dy/STlrSleuh2+eKCCAq7E4NkfrkIkQHWH4wN2lgiyH9Xw7TrdZ
         z5guuosEbQMnJ9670sMVjfgaU/CdXFkzs/a/pCxXQfHnlI++kWXwQX/XuLQCrDd92nI1
         BB5P+xkRoLd+iKqHj5FIqyAtA8/rglf9eWsB94zkxNgBB27M3c5P2E7HnYep3+kKz7bF
         CBRBO2dM5w7vEU3hZ0x9gDsvQpnJhakVgQ2M0PM20QaKRSjInadCnLmBLPL162f3OtJS
         xcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706528134; x=1707132934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FxnNBtkEIr9Vr7LOwdU5jTdmDcPZNIOUxI8CHhGmXU=;
        b=leXY3MLv6RoPSrdLBxTQyUtU8hzG3KHZk6AmrZKD3q9HX4NmLb16giSAcKFhntUdIh
         UfSBWnpioAZo9mnhCAYyAEZD1cyaQ/uVlP355OyFtD5RP+p5sMH9XkT+S++adivt/O38
         8lcV4ZiMZ9JwVGw2aXgfJfM2rNCG/69ypJ6r8kLZ7vnGM/vvUhRUajvgcbm3QWtn58yN
         j/hmaecAGXu2//3itLCBwrxw6jTBNZFfEXk5I1uTYC7phs+Lo7VJXyVEWuFcIc31GauR
         eSa/O/QRAcG6kuMHKLXq16gcA3yAm0Z075Y3+VJPUeDSUV3KkJRxAyfXvTtE0Z+byrew
         mruw==
X-Gm-Message-State: AOJu0YxK8Io6/uK1a/Ezovi8606Pjp4uKM/wmVA7t8/fszGERbvBinoa
	i82o2Odf2+gGtcxl7h2tFc0uLGRcKlzLBXkyM7JozTLzWCNbmcJfI+ZFUmSs
X-Google-Smtp-Source: AGHT+IHYCKPyJEovQgx4hC9uTe9bBS5mwHP9JwMwfBNtgZZxvUMWn6U1vNtgq0N+vMCC72aRUa2tbw==
X-Received: by 2002:a17:906:2b47:b0:a35:7b14:dc50 with SMTP id b7-20020a1709062b4700b00a357b14dc50mr2763256ejg.17.1706528133506;
        Mon, 29 Jan 2024 03:35:33 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:74c1:f49b:306a:744b])
        by smtp.gmail.com with ESMTPSA id y9-20020a170906070900b00a35a3e2b90asm1370325ejb.149.2024.01.29.03.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:35:32 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 2/4] refs: extract out `loose_fill_ref_dir_regular_file()`
Date: Mon, 29 Jan 2024 12:35:25 +0100
Message-ID: <20240129113527.607022-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129113527.607022-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com>
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

