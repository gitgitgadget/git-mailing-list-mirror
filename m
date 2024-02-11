Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B641E4BE
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707676772; cv=none; b=mV6cz2luVNc95sZpjSfDNzj4d9WBpSHLfBTXflFFOSjFsSgdpd51sRCXdHtnwiaIbYV2mdoroq7m7oMsDVzTgOXJjDl2hjEa/rahyTmhlLEOvrXynXvdVmQ4uvcdplFLnSPfxi/XhvC6lwu9CHAnRU69KS15FcWouxiIq+ZQXPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707676772; c=relaxed/simple;
	bh=VfltkTB10ZIBhlAE6ooGiSF5wKaiCn9vjFBaF9tYY0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GV2luOOvX86qc2b5pIV8RSb/W67/Ms7ZjHDnxadAvNjaZlzQ+LO9veDkbnyzguwcG1D8u9ocmBjR+xihyQQQ7rbiLLu1+GkxJ6C2pwOH4/cHkB/NMhAZO0EobyCbCk595x2ktabZxK+MigXcSos9zIo+Jh/PUQwqj+HtbwmOVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfkVGgqd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfkVGgqd"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so320324466b.1
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 10:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707676768; x=1708281568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+imelKk34ScyPqozaBb4Uj6heZ6F/trGf/qMfVX4OiQ=;
        b=bfkVGgqdIbWRFnlSmxD/c0XuD/Bb+tg+xVeuQerD4QQ782ZHOP6ajiCi8rZsQt2ZG1
         rKccYSlNwTZaH0z1GBb0BtcCqeF/fJw67NtTjpiWhW0ZjXFEDQ+yTZNw023viVVMNJf+
         WRKEb+s7KDicKYkrv2YDwxA8y7ZWNBNpHqLRv+1V2KO7OzNwV0TgswgIkBKggYQbsTpN
         rAUyR4vFQ+/f+OMz2sksVxEXnEidEICaxyJxKAMeB+anlU9UpTu9icmV8dbN86knkl/8
         zNSe9QX3fLit/YjF/k2BNz0hHsWcJ5aqHEGwTTCJ7TlI6zT1WElT70/i+Z60Pft0c80/
         GDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707676768; x=1708281568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+imelKk34ScyPqozaBb4Uj6heZ6F/trGf/qMfVX4OiQ=;
        b=P3QGG7ZbNCEuE/i27DWs+5AHFd0uvZ3+bJCYxZcIA6wnB1z5Sk1KV9eVfxkDWs8W7n
         Zc+0hbCT9/A8S09wDmL8VPfw74Xtp1dbhXf3S/+R36odXIicwunnHULWVJbNHQQyzDNd
         hy9u+mOs5uNJoW24uWxzbrdo42AodnJ/+sPrC4XsnBpYtBBvTJUmZwv88C0WQd0us81J
         PxKD4BF/4BBSTRkoikyebV+RMWYCw3KlEymiLqGb9qPba3uOrrNLyVCqwAQSOejqE+Uq
         cZ1/7x+2+CR/NpiPdKezoX5jKHgk/w0WM2OHPUR6KsIN3+Xi/Gzgl/Dzcol5XV9+f3UA
         u8yQ==
X-Gm-Message-State: AOJu0YyxFTseMoBkH6ByZ7Tfjlag3SZJCbrJjQu6DoB9GIO5Gn20n3Q2
	6AZHQ8J5UMyfeoHX3dMB9ovyJ667ARiRHc8v4HYmpVASle0cj6WsUuSUB04L
X-Google-Smtp-Source: AGHT+IH1ByVVIVDnUjhbHzr9NfSk74mNUusKFRDM/4Dwxsiu+aSg06I1OpIhuifMGXBhNis0U3fTgg==
X-Received: by 2002:a17:906:560e:b0:a3c:2f9a:71d1 with SMTP id f14-20020a170906560e00b00a3c2f9a71d1mr2664995ejq.10.1707676768155;
        Sun, 11 Feb 2024 10:39:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXujO/mfxcOixX8Q/Q1UyX4QVLdY62uU93Bho6WRxrYfGhf8/zDM88vEQVDzQgRx3diV0u7DJKFzqFrab9woe5KZx/klIZJnapDXdkkA+YCiA1gRSYXMklM+IkIVlrau8cFMWdm8Ax/1eXc5Q==
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id w12-20020a170906130c00b00a3716299b40sm3069808ejb.155.2024.02.11.10.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 10:39:27 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 2/5] refs: extract out `loose_fill_ref_dir_regular_file()`
Date: Sun, 11 Feb 2024 19:39:20 +0100
Message-ID: <20240211183923.131278-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211183923.131278-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com>
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
index 75dcc21ecb..65128821a8 100644
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

