Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126A14D456
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736084975; cv=none; b=hX2XBkPsK24vQEdvO/E9JEQpnNbsMknvq8K35IklQNgJMyR9cnKaqvb/a4FlFIBNfN6REO27UFT1TE0I2Bfm3czFxcf3brAItov4FB++tLwYRPG4H6oh8SI7FbdgKFd1aT+AsUBPbyh8asR/eowoM1yd6nk7tzfZvcCpYayxVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736084975; c=relaxed/simple;
	bh=gDS12VvN2487cMUDFjbmhcqNvLF2y1VJb9gKEygp1J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+QG/2kROhbWXSlUPuSzCAjiNxHhzvXWbj28/9ggUn8NanUL2N8RxRQv3/ZDWYi2U1IQkLi3mpAEXOXxxFFblRTnaeYYVAsLf3WSeiWy9lPAoNOElozQBtxWGdN2j2LiGc28FxF4BlYcXoYBTC65bF1wh5A2o06vxaJvwtXxqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG2OzHH+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG2OzHH+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so19483010a91.1
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 05:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736084972; x=1736689772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnFAsS4DH7o78Lcy8qKUYeCwUDDeg88O9RhW1h+7zzo=;
        b=SG2OzHH+FiOs0uW/smQ5FjPUfWUafgyEAfanvAYb8LzxtZkk6H5l9clO7ycPhVPDr1
         yY8ZEzLdcuu1bf4NoaJ4kHg15ipCvdC1Kqr7Vwx7ouwtOUMQlJFWGy/ad2I3SpelM+OK
         szHjYaOnvpvPxG5P0ejr3Bs5b+C1HV9BUrxhFsMc006TX22ZeWp0CBArO5doJrGEURLi
         I2MNJkEzhyFrIG5QirS0dB5N4KRx+Jn9LjqWQl7jzf0CtgRS9KpuHRJPuDrqd8D2vQ7P
         dTLiEK8rvs/42HkneiIsUB2ncRPK160fnhzKLtW2rjag31Jb3nlfnOFUXztmAerf8R7a
         cIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736084972; x=1736689772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnFAsS4DH7o78Lcy8qKUYeCwUDDeg88O9RhW1h+7zzo=;
        b=FTduIhFP0VRiuUezN0t3PiIo5liZOls5XTb7frEg+8D2XgwhJTX/wTQeikBx+SJOB6
         9GWjFW7N8ndeJen36WFUPd36ZIQiwwJOioP0J5xojNIK7KNZDtIW7UbnIGO9VyVn3HnE
         713+LZ9zNzWeD3DKJfBcVJP8msIFSBw3aN24H9H2cKxfj3zKCPAi4j03G7NNkIhmd6X7
         bizRngP5Ajci8p1iG5SkoJTDHLiW4nCVCPQqPWPGTAQOwLdUxaUufbmJYP72PwtCbrwV
         i8r0TlsZf6wki9oUS8o7uEjpuRQYzFa79TUJuOCi8kxeTRI+qzqZz1eo+9xCC8TzgHsD
         pJ8Q==
X-Gm-Message-State: AOJu0YwReI2ZqZkcR3qbg6B/FJc2ycP7hekbohk64sytjsDoVnv9U1Z0
	4y/X/mAXoQLvafvNWofCNJcgMJffO8r0URAqQITDVtGyJcYJmE+1Fwt+/g==
X-Gm-Gg: ASbGncv2HFjMaAUXM6qgonWO+TbVc3i8OP/v4X6Ypks2cru0EIaeTPAan80Xf9UHmdO
	vO8lqyF3Q1e0C/m47rklNMhNxCr4T0SYwglNqWLNUqUTtXjmqQxsU4quvOu3YRGI5c7sPLTGghw
	51rSOsYH9yvL+SmYiN1z6tjYbfsvMWhZu5u6qKGTXzy7cUqaecy7yP1ytVBCsFq6YOaMFg+M4hV
	91szOs0ayU35z6ps3AEssv8Rg/zluGyQm0=
X-Google-Smtp-Source: AGHT+IHbiG5/TwelSCLzYlaGAr0O0ALFrStClSIGkb6Mmc9fH2tZl7qa1G8VsfzaPgBgfJvC0UCOxA==
X-Received: by 2002:a17:90b:544f:b0:2ee:d433:7c54 with SMTP id 98e67ed59e1d1-2f452e372e2mr84008054a91.19.1736084972351;
        Sun, 05 Jan 2025 05:49:32 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f51a0sm273954625ad.187.2025.01.05.05.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 05:49:31 -0800 (PST)
Date: Sun, 5 Jan 2025 21:49:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/10] packed-backend: check whether the "packed-refs" is
 regular
Message-ID: <Z3qN6C2IpQTdVn_S@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qNUizvHJLgMx1y@ArchLinux>

Although "git-fsck(1)" and "packed-backend.c" will check some
consistency and correctness of "packed-refs" file, they never check the
filetype of the "packed-refs". The user should always use "git
packed-refs" command to create the raw regular "packed-refs" file, so we
need to explicitly check this in "git refs verify".

Use "lstat" to check the file mode. If we cannot check the file status,
this is OK because there is a chance that there is no "packed-refs" in
the repo.

Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
the user if "packed-refs" is not a regular file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c    | 33 +++++++++++++++++++++++++++++----
 t/t0602-reffiles-fsck.sh | 20 ++++++++++++++++++++
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3406f1e71d..d9eb2f8b71 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -4,6 +4,7 @@
 #include "../config.h"
 #include "../dir.h"
 #include "../gettext.h"
+#include "../fsck.h"
 #include "../hash.h"
 #include "../hex.h"
 #include "../refs.h"
@@ -1747,15 +1748,39 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
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
 
 	if (!is_main_worktree(wt))
-		return 0;
+		goto cleanup;
 
-	return 0;
+	/*
+	 * If the packed-refs file doesn't exist, there's nothing to
+	 * check.
+	 */
+	if (lstat(refs->path, &st) < 0)
+		goto cleanup;
+
+	if (o->verbose)
+		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
+
+	if (!S_ISREG(st.st_mode)) {
+		struct fsck_ref_report report = { 0 };
+		report.path = "packed-refs";
+
+		ret = fsck_report_ref(o, &report, FSCK_MSG_BAD_REF_FILETYPE,
+				      "not a regular file");
+		goto cleanup;
+	}
+
+cleanup:
+	return ret;
 }
 
 struct ref_storage_be refs_be_packed = {
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 75f234a94a..307f94a3ca 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -626,4 +626,24 @@ test_expect_success 'ref content checks should work with worktrees' '
 	test_cmp expect err
 '
 
+test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	test_commit default &&
+	git branch branch-1 &&
+	git branch branch-2 &&
+	git branch branch-3 &&
+	git pack-refs --all &&
+
+	mv .git/packed-refs .git/packed-refs-back &&
+	ln -sf packed-refs-bak .git/packed-refs &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: packed-refs: badRefFiletype: not a regular file
+	EOF
+	rm .git/packed-refs &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.47.1

