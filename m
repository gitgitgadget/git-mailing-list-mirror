Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BDA18A6DE
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508757; cv=none; b=jSeAZzwgg0e/tup0ItMEThDU+uEI9bgGCqL26+fmpQCkpnuBY/PRbicJQKjM2O92d9sDPIXG+GFfO3/1MRUQoArfETGdq+y62oGIDNic6jHcvLJdIbfLcJ2jr8MIdcJZnEf0euqUy1hUfbdSfJt7mNozg1Y4/jm3nv18zu5lZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508757; c=relaxed/simple;
	bh=hvB8RSAeuHpGr5D4Vm3uLHj1yMDuoW9Kh8KYzt6v5wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxuiKx2Ouls8q9Ip9jfJCM4Q+bnHD0p/1uXV/OpohLI+St7BN6ltSd5YqvogH7HUQYCIwg3zvVDc/ISC7foP21+hU80e90/Tm9TMC/X97QA8UlQd6SqvGEatHhEtEzPPhSOWncQ8EdNtZN6rrc3SbFd3p3+lOY3JZnPj/u4kbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2998zJc; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2998zJc"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so1239959276.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739508754; x=1740113554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QScxn0YiELptPi/YqbglTfJ8vukbjirrSQIaMxw/KoY=;
        b=M2998zJco0I6lLFE8uASbL33dgBPhrbZjV5poVV7jOYURTE3TAXRCTIEKkGlsRdSAz
         tn/YVAMA41+LLCgbzUbCP2mPJ9ahoVdFxAl3bFnGOPYTr+XpzVDDsqQ3WFnHmiGG97lz
         Adv0nGzjG89ARaDXaWzo+KbG7h0iWawfePmyp+sOzaVOZ5433wYlbG/HRZgSDAq17nYz
         w27/Q3WsetiQeZiGpBoSSptna+HAZdXFP5UoOew1h4rNWklBE4fdfk2MfhVsptNVoDuY
         Pb5QbSAnaMJLXLBBwnE7TZBgvWjrrZOvIP2XPxXRmun+hFEKiKn4UTOev/iR9J9MmNiX
         dZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508754; x=1740113554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QScxn0YiELptPi/YqbglTfJ8vukbjirrSQIaMxw/KoY=;
        b=cZ2GXyb5fmo1SECH4YSYyeM8izdQ0nTbPIih0pkylmNfZvU87UQKrkUM6UGnQsPU7H
         xidkvN5C84kx6dbV+fGfPyrco0KiqBteGQt1hEDkV2UQf4PiDywbDq6Qw9KBBk2m2TL7
         2IJJdTeqCzmiQPZUNetC7syscTYGGzEz0obct4eR7L3Luinnh8KcAQ3OMVwAAXFpIA9u
         NizHO1neWIlaDULq9gYQAk4tVNn4UkBoUF2UHBdF6k137b9LCoZC2pL2swvynsYUU1/p
         QDDcCB62LGja4sxgcnYOx9RmhgGpH3t1CCpChA9hvip+Q1VWx6OxLiMdVVm22sEVYOnh
         b7TQ==
X-Gm-Message-State: AOJu0YzpkNT6/PbQKbR5iL8uOmhhB4Hmop1Iw6IAmEKd0UdbAJHGS34Y
	m99cg9T/Poc0u9uYMzoL0yEgANIZz4JfybNc/BcdiHvhESRxmQhPk6HH5lwP
X-Gm-Gg: ASbGnctq+7czfya9UlUAtFwe+LzZLtTKysBgoMmzgYCHwLaI5HBJ8UKP3vnPMe+fDK8
	iTk30eufvr0spIejGRw5mF4DoQCQs1uSvnsspYwO/vbT/rnDaV3ietGghN6bzxEIBsCiMbB6Pjb
	yLk7Z+MwehGsacQpEBW0XAsY1CGcwYXeLHRuxo+vPFz8DnVaO+LI5TIVdFHyvIYE2n38FX6pP/a
	Jmji2tq+u8mc6M6Hh92MnJrLb09ZFl7yJGQeIIfXZERmI5jKIxgFt9ilmVGTBDbY7DtoQ==
X-Google-Smtp-Source: AGHT+IFB/ysADCQmA27OIrYmaEbTK/xctMjpq60QINYJSAQGG1WAI64j8ofbMBFNx9TgB9vv8J4Ehg==
X-Received: by 2002:a05:6902:1704:b0:e5d:b88a:5536 with SMTP id 3f1490d57ef6-e5db88a57a4mr3578410276.44.1739508754202;
        Thu, 13 Feb 2025 20:52:34 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e5dae0db1b8sm781423276.38.2025.02.13.20.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:52:33 -0800 (PST)
Date: Fri, 14 Feb 2025 12:52:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 3/8] packed-backend: check whether the "packed-refs" is
 regular file
Message-ID: <Z67MDPtjoXQB2sGB@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z67LkxAFIAeaYr0U@ArchLinux>

Although "git-fsck(1)" and "packed-backend.c" will check some
consistency and correctness of "packed-refs" file, they never check the
filetype of the "packed-refs". The user should always use "git
pack-refs" command to create the raw regular "packed-refs" file, so we
need to explicitly check this in "git refs verify".

We could use "open_nofollow" wrapper to open the raw "packed-refs" file.
If the returned "fd" value is less than 0, we could check whether the
"errno" is "ELOOP" to report an error to the user.

Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
the user if "packed-refs" is not a regular file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c    | 39 +++++++++++++++++++++++++++++++++++----
 t/t0602-reffiles-fsck.sh | 22 ++++++++++++++++++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a7b6f74b6e..6401cecd5f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -4,6 +4,7 @@
 #include "../git-compat-util.h"
 #include "../config.h"
 #include "../dir.h"
+#include "../fsck.h"
 #include "../gettext.h"
 #include "../hash.h"
 #include "../hex.h"
@@ -1748,15 +1749,45 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
-static int packed_fsck(struct ref_store *ref_store UNUSED,
-		       struct fsck_options *o UNUSED,
+static int packed_fsck(struct ref_store *ref_store,
+		       struct fsck_options *o,
 		       struct worktree *wt)
 {
+	struct packed_ref_store *refs = packed_downcast(ref_store,
+							REF_STORE_READ, "fsck");
+	int ret = 0;
+	int fd;
 
 	if (!is_main_worktree(wt))
-		return 0;
+		goto cleanup;
 
-	return 0;
+	if (o->verbose)
+		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
+
+	fd = open_nofollow(refs->path, O_RDONLY);
+	if (fd < 0) {
+		/*
+		 * If the packed-refs file doesn't exist, there's nothing
+		 * to check.
+		 */
+		if (errno == ENOENT)
+			goto cleanup;
+
+		if (errno == ELOOP) {
+			struct fsck_ref_report report = { 0 };
+			report.path = "packed-refs";
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_BAD_REF_FILETYPE,
+					      "not a regular file");
+			goto cleanup;
+		}
+
+		ret = error_errno(_("unable to open %s"), refs->path);
+		goto cleanup;
+	}
+
+cleanup:
+	return ret;
 }
 
 struct ref_storage_be refs_be_packed = {
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index cf7a202d0d..42c8d4ca1e 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -617,4 +617,26 @@ test_expect_success 'ref content checks should work with worktrees' '
 	)
 '
 
+test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git branch branch-3 &&
+		git pack-refs --all &&
+
+		mv .git/packed-refs .git/packed-refs-back &&
+		ln -sf packed-refs-bak .git/packed-refs &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs: badRefFiletype: not a regular file
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err
+	)
+'
+
 test_done
-- 
2.48.1

