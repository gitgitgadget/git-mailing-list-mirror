Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ED221A457
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577787; cv=none; b=QmgmvdDiTOagy4F3kx7O85Aj0KkmIJ/VWQN+c4AjSgIgiNCtdjACAAztn+Q1V+Sn9nCJqbx1EbyPiB+5uvctzL7lWYUVBhdaSRgsoue+UEfhvFANs0a1sCshbG5ZY/VNERDz4Lsxy2OmUkJPoydVWXuSXKNYEHQTY6gmIXY/1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577787; c=relaxed/simple;
	bh=IZV0J37PkKofX6QMa/x2sR6IZ1lLNiXZzPzAI2+OL3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4vV4G8jIXU0Rmk9CDa46LH7FnbSpFZeVi/8tZh8T2XAfzxbV2v8KBksf1IlC3tanpnHoH0iT69uCb6QSBllnP/GeJBtSh+xtRbPjeC5nQhH/wcbrDNsI2GCdrjMISXqrPSw2FyR0dhtYRa16yJRRU4hI0h7Fli12F+OKc9FqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gpo4dQ5/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpo4dQ5/"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc4418c0e1so1474296a91.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 05:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740577785; x=1741182585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+mgNGpP6ABinu1LeaSa1E+jezbzNNGy/bMIQGIBRb2Y=;
        b=Gpo4dQ5/I+b7xwfkw5j5zNFOBMQfzycbIT03pyYnROxvhjgLQHvSRyDF87yh3xPyye
         ZGR6QYEDhWEifLfgoZaN5tOrNVjEk+xQypoGqEoYr0iPSqvXPQDmXvN0HiXBgU5VT8it
         u95pm+WMRKcjZR+gKmZZy/wUS5mYX27uIyic2uwTVl+U5Vs6OSxzQ8EGWBcryOP7GluA
         3o1y8+6TpiqwXwymf6EChchmrdWwusJTT7w/9Tcr0vY068LOI2DBLEa2pDD6ko/VhaTt
         d3b04a7CHNrkxHEmdiZDHef8dybziXwMN/+iP+L1TU2XVE3s61rX1Ao/Sny7ks2KC8Qv
         Sy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577785; x=1741182585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mgNGpP6ABinu1LeaSa1E+jezbzNNGy/bMIQGIBRb2Y=;
        b=dx+06KIAAys9aJDM8lYPvrhM+QUPoKp6GnilZg/79uuM5XfD7cNOHg+drRJk9+3Agf
         g+oYzgATWb3pTE1idYwCFBWJ0OoHdnLYN8tWCBAf+GdJKThPsyQyIkuIQiYQ/o2IeDS0
         0dJVGgog5HSAcMIgFeJlpv/Fv5PMV/vEoDtA10FeKLXoH6QnSUB0b0eZqEPcLobDeKrI
         fRbXULr0nHrkJbUq52L/CnJB4G4V1TC2XvOAxLf+7ulUCmiVH6keciFZxi7GiF/mzNFN
         /MKRkox7C5ymV21QphEDoh+mTVxU8lAOzsFN5bna05YuhGHKbd3+xZ1IKJDoD32ImdNe
         ibIw==
X-Gm-Message-State: AOJu0Yx1SGjAHd4H/Pbc+K9RPGQTQFifKzNAolxLtga44qhQ9kdJQlOn
	ZWSYv3agKtlgW8EqOG9SkVqi+4pa1kKWQAnkt4JWprkhxpaJFNoN3YZU+Q==
X-Gm-Gg: ASbGnctsYOEFNxCU8mDJlt4Wbe1DvsEtLHV9sRWCtZxY8/f/TlC11ewIWX71GqV9bU1
	nQ1FIJuB9fWm2l/uLIOJmRRxTREAGN3PvDPffxFim0JlJ1uHXKCyzYX4PLmeiJQDh8lHwaNH8+f
	wvNoJfKMFiGHmYq2vlmN6bYtZf2WLAIKhXpWEYIRQ+quphyiHMcWHcNDsrP+XlFmZzfRT2xBaJP
	XXm8h7q/U2o5xn4BIytQTh8QFDTfGcCzS8QztJk7oYeboB7NSrPlY1geJ9ZIfZ5/co82ZQeNy/l
	xyiX8UkYL+uaXoZaBxM46g==
X-Google-Smtp-Source: AGHT+IGezl4s/cgUtO/IjS4W+m5bNbDJLSjRFb9+M5eFyK+NnHalPZL+5pZI/EARKA5HBJOkeZzq9A==
X-Received: by 2002:a05:6a00:991:b0:732:6276:b46c with SMTP id d2e1a72fcca58-73425a1fab8mr36113516b3a.0.1740577785106;
        Wed, 26 Feb 2025 05:49:45 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a72f4c7sm3415876b3a.79.2025.02.26.05.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:49:44 -0800 (PST)
Date: Wed, 26 Feb 2025 21:49:53 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 3/9] packed-backend: check whether the "packed-refs" is
 regular file
Message-ID: <Z78cAU69IUSDgpuD@ArchLinux>
References: <Z78bmBSrDR20GY6g@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78bmBSrDR20GY6g@ArchLinux>

Although "git-fsck(1)" and "packed-backend.c" will check some
consistency and correctness of "packed-refs" file, they never check the
filetype of the "packed-refs". Let's verify that the "packed-refs" has
the expected filetype, confirming it is created by "git pack-refs"
command.

We could use "open_nofollow" wrapper to open the raw "packed-refs" file.
If the returned "fd" value is less than 0, we could check whether the
"errno" is "ELOOP" to report an error to the user. And then we use
"fstat" to check whether the "packed-refs" file is a regular file.

Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
the user if "packed-refs" is not a regular file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c    | 50 +++++++++++++++++++++++++++++++++++++---
 t/t0602-reffiles-fsck.sh | 30 ++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a7b6f74b6e..f69a0598c7 100644
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
@@ -1748,15 +1749,58 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
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
+	struct stat st;
+	int ret = 0;
+	int fd;
 
 	if (!is_main_worktree(wt))
 		return 0;
 
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
+					      "not a regular file but a symlink");
+			goto cleanup;
+		}
+
+		ret = error_errno(_("unable to open '%s'"), refs->path);
+		goto cleanup;
+	} else if (fstat(fd, &st) < 0) {
+		ret = error_errno(_("unable to stat '%s'"), refs->path);
+		goto cleanup;
+	} else if (!S_ISREG(st.st_mode)) {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs";
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_FILETYPE,
+				      "not a regular file");
+		goto cleanup;
+	}
+
+cleanup:
+	if (fd >= 0)
+		close(fd);
+	return ret;
 }
 
 struct ref_storage_be refs_be_packed = {
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index cf7a202d0d..68b7d4999e 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -617,4 +617,34 @@ test_expect_success 'ref content checks should work with worktrees' '
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
+		ln -sf packed-refs-back .git/packed-refs &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs: badRefFiletype: not a regular file but a symlink
+		EOF
+		rm .git/packed-refs &&
+		test_cmp expect err &&
+
+		mkdir .git/packed-refs &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: packed-refs: badRefFiletype: not a regular file
+		EOF
+		rm -r .git/packed-refs &&
+		test_cmp expect err
+	)
+'
+
 test_done
-- 
2.48.1

