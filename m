Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA716C86A
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847311; cv=none; b=a932XRQ/GR6VbPSFY797bdHMhctrMvCCpOuGz2Tw0NT1M8SjfiB9Zq1bnLwxlAyhFNwrfHYjdyFcGp+vlXPGvSxlnY0H1e3B9njx+o4UZf8Gmpj/VJOznSlU/vZOV5UTU/ymcdnE4ZXPLj7c2gCjicvw1d+40Wtj7ruyLYucS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847311; c=relaxed/simple;
	bh=mj88k9N0NQkleeLlacpl6N5NZ8Gjp45b0pVjdau+Vlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUm7ZKne7i0dtagvoSL0gkSA/kCR3GQFbjJ5EE4W2IW6+SsC/No+Y8xtYAYfj7lPYBmXdLCtLyxfbCvU42vRxQWp5yDfcPPIpPnlKd/tUlgp3SdNV9SM/eEJlufRDBxKkf2x25lWiEbwMXgSKjbH5rI9/1sYIKuKR1dG0uowI+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn2vha91; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn2vha91"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fab03d2f23so22472635ad.0
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719847309; x=1720452109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBTR/RgY/U4kT2X1MYEXOGnYJS09sheHjAc9ipwJTJU=;
        b=Jn2vha91dj7clxZ1L/QeIc61E6CDwc+tZS1DipovlDmrNgPKUcMPLDKiJ/WMim3xfb
         ioA6nolXwk659k0l8Ciycz4c1FyPLWkKoN9qc/209exEu9cTrcQgeV9KJT+L6IBlNyd8
         BEKqQTEqMB0XIWKr1S1RTZiceuVukTca6IDwT1+z34DV1Tg4S7SrLlpMKPJbhaJzpBml
         zdLZCK+Nbb9hycLvsvTrjkXz42tyU+DzFxdWp7jjON36IyVnUbaYQBU7HaWuWre+TV6d
         +q/3QImoGwMVS0X6179rGz58h6oe5xRH6rxRF4/6XKoTOJxhRYmW6Ac/LqkjtX1qBKII
         fd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847309; x=1720452109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBTR/RgY/U4kT2X1MYEXOGnYJS09sheHjAc9ipwJTJU=;
        b=cm6aE8pM69ljV0KZLcq/BSwOGDPDyiphBCnIUlo1v/oXkDJcsBTzg5ssO7gocBjqdr
         +VyaWjvJhBA2/oS5j33o/vOvBvZUmxRh7soDkD/CIFf18OIeUQschAvx8dVBuKYNmOVg
         45KgzjLOohkzvbuK23VSmBtC/xu61dFuvQZfkYKWLoGzNZTcjXbosvc45t952IZuGY4w
         2+ygTpIo608qSMsZEyMYJX7kAh2c67da/aCMwCXI545y1VUcr8WtCl3kjMUeP1W3Qlx7
         13RJl1oNyUV5lXB2Fo85YCsje71dqoneaf+k3XK9F5SMkeNvkf1Cpo+aYgIT4PaNjq+l
         c0iA==
X-Gm-Message-State: AOJu0YyY0IwWd6s3nbva/J/e+eN6Cpm9thnBIvD/yWE51k8J1fbARy9t
	eiypFOESFfMkKbHo45AJqrw48EvrUUwEeOsCe5PYImiExocdGK+IUllCVA==
X-Google-Smtp-Source: AGHT+IFAwPqWbeEOiNROaa/PNzQxid0rrI8VpjQSvXE7yopC2wXULDzUcIEAkuO2BaZZFIbFYZlyVg==
X-Received: by 2002:a17:902:784c:b0:1f7:2091:978 with SMTP id d9443c01a7336-1fadbcaaf4dmr21524235ad.37.1719847308442;
        Mon, 01 Jul 2024 08:21:48 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1facec847a6sm58440575ad.291.2024.07.01.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:21:47 -0700 (PDT)
Date: Mon, 1 Jul 2024 23:21:45 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v6 10/11] fsck: add ref name check for files backend
Message-ID: <ZoLJiWPK58YDRrQf@ArchLinux>
References: <ZoLHtmOKTfxMSxvw@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoLHtmOKTfxMSxvw@ArchLinux>

The git-fsck(1) only implicitly checks the reference, it does not fully
check refs with bad format name such as standalone "@" and name ending
with ".lock".

In order to provide such checks, add a new fsck message id "badRefName"
with default ERROR type. Use existing "check_refname_format" to explicit
check the ref name. And add a new unit test to verify the functionality.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   3 +
 fsck.h                        |   1 +
 refs/files-backend.c          |  20 +++++++
 t/t0602-reffiles-fsck.sh      | 101 ++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+)
 create mode 100755 t/t0602-reffiles-fsck.sh

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index f643585a34..dab4012246 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,6 +19,9 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefName`::
+	(ERROR) A ref has a bad name.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index 887fe2969f..fb035d5457 100644
--- a/fsck.h
+++ b/fsck.h
@@ -31,6 +31,7 @@ enum fsck_msg_type {
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_REF_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 744ee5c5db..3badec62ce 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3417,6 +3417,25 @@ typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_name(struct fsck_options *o,
+				const char *gitdir UNUSED,
+				const char *refs_check_dir,
+				struct dir_iterator *iter)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
+		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
+		ret = fsck_refs_report(o, NULL, sb.buf,
+				       FSCK_MSG_BAD_REF_NAME,
+				       "invalid refname format");
+	}
+
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
@@ -3468,6 +3487,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 {
 	int ret;
 	files_fsck_refs_fn fsck_refs_fns[]= {
+		files_fsck_refs_name,
 		NULL
 	};
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
new file mode 100755
index 0000000000..b2db58d2c6
--- /dev/null
+++ b/t/t0602-reffiles-fsck.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='Test reffiles backend consistency check'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=files
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+. ./test-lib.sh
+
+test_expect_success 'ref name should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1 &&
+		git commit --allow-empty -m second &&
+		git checkout -b branch-2 &&
+		git tag tag-2 &&
+		git tag multi_hierarchy/tag-2
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/.branch-1: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/.branch-1 &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/tag-1.lock: badRefName: invalid refname format
+		EOF
+		rm $tag_dir_prefix/tag-1.lock &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/@: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/@ &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
+		EOF
+		rm $tag_dir_prefix/multi_hierarchy/@ &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'ref name check should be adapted into fsck messages' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1 &&
+		git commit --allow-empty -m second &&
+		git checkout -b branch-2 &&
+		git tag tag-2
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		git -c fsck.badRefName=warn fsck 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/.branch-1: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/.branch-1 &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+		git -c fsck.badRefName=ignore fsck 2>err &&
+		test_must_be_empty err
+	)
+'
+
+test_done
-- 
2.45.2

