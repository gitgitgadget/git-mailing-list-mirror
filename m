Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD3C53E13
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674434; cv=none; b=Hwsui+UhBiGGFmXEkwlqm7MQiYaK1tDJoWwBCUu5ml89/jb3JIg4mRDvhWsWrO+9yqU5BEyeaHTil8HNeWZ7IunTtAaIGkeiKuuFCh2TaNeChh04cZ0tOryaom2MSyyS/L8d3W8Ms0SzOjj4slex8oifS3yQbToY41Ha6XApWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674434; c=relaxed/simple;
	bh=BX5x9sx5pZRWtjp0L38xZ/Jkmz3JEO6DYYr8suwZj1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3c82kENBvMZUe6ow/egoB5cMbznWwYYFVVbHI5mOt1BuxBAe9lkcLocr/005p5mD7iFIoQaHLpLNArPpaHtqREKUYDQJp/0vYCEho0JTuoy9bJRg2DnKsvaezLBMdKlCI99++FlVL2nf+jsQdj/97kW2yzR0AvEwRkZ0pURa1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikBNo9Nm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikBNo9Nm"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a539d205aso979111a12.3
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705674431; x=1706279231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A45/rUp3Q9sY0XBiQ4II+DhCohIPNRG9FdMcFBVL7UY=;
        b=ikBNo9NmyH741DdAEZm0HRKz7IIRTXu4ADt2zchkY3iMKUbZEdQBYoy9xlE2Jp7j5B
         BWmB2vIIGCAU2iJSfU3Q0TUc3a1juUhu3jx2VLZj4CiV0LsqtQ+KMlsWRZ7yWfsCNJVO
         4wwP/Lkt8/U+Lg+cOXDE1NrwOz8in3lVT2yNpk2MnNuo0IVIVGw9QfDebwtv/BCqZrBD
         s1C/RJhzy7niy0vWp4WtunX0fjrY/hfrsEAfp/RXo0qobOZ3H5GwAzqKjzuDAlgNcXJa
         S/VjgG3z5+T6KjGQhchbwmhO85T74jMouc7DGeKJVI4uSK//M5eq6UTBo6SzfqXNJ1LQ
         W1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705674431; x=1706279231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A45/rUp3Q9sY0XBiQ4II+DhCohIPNRG9FdMcFBVL7UY=;
        b=VIrwOo7zXWMh53Ps9ykc5wuhzfoWnFaqIMmi7HV7/bYrw1mfRuIN0TImn1cQICjKrX
         hbr8Fhone7mNAimn/lPh5Aqbr+5ALZwL5GEIG7PuEVxG+syEa8P2A+vH6BqKoG/R29Mo
         xyxZ7QpqcEqiAjkDnAfjINrgM1bLpybKHL6lCcg6Zej8vb9816yRZeBW9dWfUw9chWER
         vzERr5JE0J1eqY4V1XlyT7tywahqi58LIfMjdnfPvEHf4rpVltcI5PZ1TPnL+DF8tTT1
         JilcBwGXmfTHnxUtUiTLhCr4yWGo5hGTNwTuM3juedp7PvFHeQl+Z3HVuDljoP4yUcJ7
         kalw==
X-Gm-Message-State: AOJu0YyM/XOGucglbCEjQa3NuXwL8Unlao4OWKjHogdACPGsryk3bFcd
	u0CvMIT+1rT1cWD7wj8UMq6Y3nsAfnVtnTt6afDfw7Wvm79O/7cmq+tGUBPd
X-Google-Smtp-Source: AGHT+IHdtphesWx99mKgLTffnux1PQly44Vm97rEMdozJYAJa12sjEcpJ0JSBwBLL8j+uGXghxpqew==
X-Received: by 2002:a17:906:d78a:b0:a2c:4a17:1d66 with SMTP id pj10-20020a170906d78a00b00a2c4a171d66mr1675872ejb.47.1705674430420;
        Fri, 19 Jan 2024 06:27:10 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm3843494ejd.112.2024.01.19.06.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 06:27:09 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 3/5] refs: extract out `loose_fill_ref_dir_regular_file()`
Date: Fri, 19 Jan 2024 15:27:03 +0100
Message-ID: <20240119142705.139374-4-karthik.188@gmail.com>
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
index 6734f2a309..a4884f557d 100644
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

