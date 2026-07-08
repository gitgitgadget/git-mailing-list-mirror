Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB4A38757D
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555173; cv=none; b=mvNLmnzDJhVQWBeyeBACu4uQHCVVvga8i7fhSEP+7gqWd03EeHBK6FQx0hE9WiqjgYlnli2qFkPHKvMsLx6CxDSxO9Diz5SGAxbmg4twzXtrrF8Gfdnygv5a0OdVRnTTnKahAm0FZCSi9Qmb2xh55JqF2PYsci+41C7j7B+Zi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555173; c=relaxed/simple;
	bh=8EjyxZ7R3wxYZKWUr4XcwOViANwBOkKJEeP7h2eJABI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUInK2FRTYgiEU6lOCKF6tAv27vbawRrLtLi8JC8GuqkOyNZpRdKu4pxQrQh5v184Vr43+AqM8puCk/swyLWcZ3vUcXlU1WyfOlC7k0iTLFTXdhagMZ2W2PlsCyLmGCaQI8PpayFrMbrzwV23ddP/tdCi/8d28FLFOOQ7qz7X7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfSekmHX; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfSekmHX"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44cd990a94dso693278fac.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555171; x=1784159971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wTUul4OlZPU+wicQ0fgLcdLhxoAhcQrggcNylvLaSaA=;
        b=gfSekmHX7O0yOyOPe/sDKJUZCUnZiTij8n0Z/FbL6hnTb11y7j2LAlB3zG3G2iUy/0
         pJPxTmP6xHjOG1lrkNj+NUImzBxc8BBUh19P71+c8gDLp4BI1X7enHkWLTiq7YMy54+u
         kvg/kuZhq3bapZypYVeubB2NuJNkDv1IpqUzb5S3h8jrfjJpEZ4v5+LPbghgdQt5yIhe
         6LDuNMdXdqJrI1nSKi0wk0GNPk943pXE+jccZyHyyKn5jTRio3SuoWxIe6U6orm1nO+Q
         18+BjRJn435uGTY2v/c0reQH4YfuRbD2wPYJ1ky+GsTzc2WJY6oG4RlJTPrtNqd7MNME
         SW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555171; x=1784159971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wTUul4OlZPU+wicQ0fgLcdLhxoAhcQrggcNylvLaSaA=;
        b=ZLsRBS1EUlIpufvrC51MymxOMxddUCervAYLafCDaeLh9yLkJevsQbJLd85upkxjoC
         +svvBg81aWwx3UyiIwzue95ATXlcsB3Fj7PTL0ktruGOjQ+hoOSoqcpIToKi8SkHvqkH
         8iVGQhm3nzwNLATHvDfC9gt32Gl7KgiOGzkSU4kKxmHlKrTL50y+HI4hAO1aTTUkIFY3
         OWdr7RQmgWux2wtvuhJcsJucvAgQW3kEj0eQcZOEtTGsZ/0claHF1Xo6PY7Bir/opfwP
         t6L0qW5obl7k4q11ajd9hmbZ5cKN0OT6eZx7BijicoTcPCRL1aoSFNRL8djszcSg7hAr
         C/dQ==
X-Gm-Message-State: AOJu0YyM5yaKAetzYxdJWOdRUupRAALUVOn8Qs27nO/y3aXcnAQJdVHg
	delENQPSZ4aHadPM1Vos/gH8ZFApxMYPg27+pGXSRl6I+k20sVdGk4wEcE0r+A==
X-Gm-Gg: AfdE7ckJ1jJDmThRozT21aeXEUvhm9GiaBxLRyLeYFqSBkT+OBiYgsh4Zaburh1gtiU
	Nd8bxd9V6iHlC00OxoKwPG/S9asMzBXmDtHtYw4w7T/JCjF5OdamKntf9+CrctqqtFOswdv6ihh
	ycxc5OqQuprKBwZAo5Qkp37sfFMe8y7S7S4/dtRI9eqAWW8siWOopqJiwimVCqs0B+myVVJ5hkb
	01jPGoTw3syZHZQ39wEAoj/ylE7H5P3PtRa5K13d6KAgPGkx6Dl7hcM99vjw7GviN1/CN+E6/y3
	fYLMJLEuY2k/G8n9XD4caI2j48YvXelOB9dbYFohILFKftJIDAm9JQLb7wt+ziNmk1FcL7defnh
	/gCr8ztbftOZEJEbbG+D+oJIzNW9XF6Hr8P+qjzdXRyiUwlJiIoR5UXX041pSLH+vEKOrci0OjH
	+BOjhMiNCs49GsJToo8XHs
X-Received: by 2002:a05:6870:d1c5:b0:448:6ba8:be6f with SMTP id 586e51a60fabf-45163907a46mr2990878fac.19.1783555171547;
        Wed, 08 Jul 2026 16:59:31 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:31 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 01/11] object-file: rename files transaction prepare function
Date: Wed,  8 Jul 2026 18:59:15 -0500
Message-ID: <20260708235925.3992097-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708235925.3992097-1-jltobler@gmail.com>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "files" ODB transaction backend lazily creates a temporary object
directory when the first loose object is written to the transaction via
`prepare_loose_object_transaction()`. In a subsequent commit, the
temporary directory is used to also write packfiles to.

Rename the function to `odb_transaction_files_prepare()` accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index e3d92bbda2..a3eb8d71dd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -499,7 +499,7 @@ struct odb_transaction_files {
 	struct transaction_packfile packfile;
 };
 
-static void prepare_loose_object_transaction(struct odb_transaction *base)
+static void odb_transaction_files_prepare(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
 		container_of_or_null(base, struct odb_transaction_files, base);
@@ -761,7 +761,7 @@ int write_loose_object(struct odb_source_loose *loose,
 	static struct strbuf filename = STRBUF_INIT;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_transaction(loose->base.odb->transaction);
+		odb_transaction_files_prepare(loose->base.odb->transaction);
 
 	odb_loose_path(loose, &filename, oid);
 
@@ -825,7 +825,7 @@ int odb_source_loose_write_stream(struct odb_source_loose *loose,
 	int hdrlen;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
-		prepare_loose_object_transaction(loose->base.odb->transaction);
+		odb_transaction_files_prepare(loose->base.odb->transaction);
 
 	/* Since oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", loose->base.path);
-- 
2.55.0.122.gf85a7e6620

