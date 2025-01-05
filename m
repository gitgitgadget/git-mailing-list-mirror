Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DF29422
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736085052; cv=none; b=aNQcMyEdZYf7TJu1mHOi4OoAtdCo38GN/tmSETzZ/Ih3ZUXZ1YexX4gYTkAdn6RRnMeQ7dE7ZwdRoX+HRNAzDVX+aGK7s6O6h/ixuQ0fgHUSz9NYuV5+gccxKRcAwwMgzTfoI3GAov9cyfaf2hqbKlAWetH6F+6bTX2P/kBU+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736085052; c=relaxed/simple;
	bh=F4LG85nl+6wBH+9dohPyZffmT0eVuQMfe9EWhPZgz6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQ1Vs3WVFdDzaaT8zXmJ+d7VzqYC3jrZAPsV1cl/qo7krl71NuUDrPSEFDUJmszZWRCaKJeujCTSBy3HfLRXfKYnkZtGvKMswCb0zhZuYXJRa3qSQ00gi8pUif59tEVddg73D17BMy67A+okkAJgUchdoWyvnPca3c1gFtjfBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY1piaEE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY1piaEE"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso16484727a91.1
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736085049; x=1736689849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5GMzWkDL0xz4uI9h9Baucv8NbKSiIrB9AezjA30CVM=;
        b=gY1piaEEm1EJNaAnFLhWunuurbovpVlklNwPUeah6VtWsf3JOBVmaQEGAVFnwqcOcU
         dDiKIsXxwdoX7Oys/qis9HtFZEWCHRo2bn0D3BdTypta2/ZPepDDvlgF2+2WDqgc82xt
         GL5MXE+ZF9Rn0q5kFnInBV5ZHYuFM13y32pxK8NUlxOoBijFSP8egskkgPeT0haSrP7k
         a/Tm6Us9omE0exloOcE7eKhjd8a1c5q2ELa8VafcyLaTDomnkBN3AzHlm0tlA0i5FDTB
         tji1BsZKX7zRUvQ4fPN6OTNDqNGg1ZR11GIIj4bv5j17ejTsGo3n2RFr4sXm337ncmhk
         ndlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736085049; x=1736689849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5GMzWkDL0xz4uI9h9Baucv8NbKSiIrB9AezjA30CVM=;
        b=h8gVbn/gz2QoFpVhmHmlBzNecbLr2xDMO52j6CmQDCWcKFdVgTs4fEtOdfT+hhsYYr
         v6EkeuwB0H6jM2OU3htSFb55nSRvrn00UmR1fE5bL8hH6lQ6AlB3z7j6tAvLqe2KHoRC
         PGCyrDuBe5ZXopJmaiV5oJWWQus85lAGUw5MeciEsJwdKyFyb4BzsY08gTOZ2MwETpYz
         zhK28cZjYMLRI508tZEzDV4jtsHzmvUWC9McOW5CubXeOMWownu/b65zgrK+A/6LoME3
         ttEHJW4pxl7YHjwgeT3Z22XmJcbuUIf2t2W2744CrdFCt19TnV5xoUEtoAY8iV0Zyf3h
         qTkg==
X-Gm-Message-State: AOJu0YzR8Zh5ACBVmOEfPWcysXZg/YDHif0qu8uAzuKU59rXVnzG+BuZ
	ahoAaT31Oc/6RIu5ZaHYmQHwv0E+VoEhPJ/Y6A9fXsImLsrZAqlknA3gjg==
X-Gm-Gg: ASbGnctDO+sh3mXaERamzkFCDDobgbCyTe5iI/U39+HP1xRmifMLyCPauy65ZA7+czM
	02daYZ07uKB3WEI6GviJlRft699MF0xfA1wex5Q4o/Ga06tfsfJ/d5lcZevibK0XlTL6A4MgFyv
	QEhV80zUKgS5QOaspv7oy5xIJPk/LyyBLBg7qq5Q0POlQ+Akj46bnSucQmNgAtubXhqEhi562ZQ
	n6UM+Va+8ZMMcrCJPYDgBujar26GuOn+Oo=
X-Google-Smtp-Source: AGHT+IH3crBNkwc9aMnDgSqEM6FElcb56eACZGkoY9Ivd7L8XTbioqVIeXEnV7dPu6i8L0QU+hwMww==
X-Received: by 2002:a17:90b:54d0:b0:2f1:2e10:8160 with SMTP id 98e67ed59e1d1-2f4536d193bmr81501211a91.11.1736085049008;
        Sun, 05 Jan 2025 05:50:49 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f454f58087sm33227281a91.11.2025.01.05.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 05:50:48 -0800 (PST)
Date: Sun, 5 Jan 2025 21:50:43 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/10] builtin/fsck: add `git refs verify` child process
Message-ID: <Z3qOM5M1ioZ0Px4T@ArchLinux>
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

At now, we have already implemented the ref consistency checks for both
"files-backend" and "packed-backend". Although we would check some
redundant things, it won't cause trouble. So, let's integrate it into
the "git-fsck(1)" command to get feedback from the users. And also by
calling "git refs verify" in "git-fsck(1)", we make sure that the new
added checks don't break.

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git refs verify" command. In order to provide
the user interface create a progress which makes the total task be 1.
It's hard to know how many loose refs we will check now. We might
improve this later.

And we run this function in the first execution sequence of
"git-fsck(1)" because we don't want the existing code of "git-fsck(1)"
which implicitly checks the consistency of refs to die the program.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0196c54eb6..a10e52b601 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -902,6 +902,32 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	return res;
 }
 
+static void fsck_refs(void)
+{
+	struct child_process refs_verify = CHILD_PROCESS_INIT;
+	struct progress *progress = NULL;
+
+	if (show_progress)
+		progress = start_progress(_("Checking ref database"), 1);
+
+	if (verbose)
+		fprintf_ln(stderr, _("Checking ref database"));
+
+	child_process_init(&refs_verify);
+	refs_verify.git_cmd = 1;
+	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
+	if (verbose)
+		strvec_push(&refs_verify.args, "--verbose");
+	if (check_strict)
+		strvec_push(&refs_verify.args, "--strict");
+
+	if (run_command(&refs_verify))
+		errors_found |= ERROR_REFS;
+
+	display_progress(progress, 1);
+	stop_progress(&progress);
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
@@ -967,6 +993,8 @@ int cmd_fsck(int argc,
 	git_config(git_fsck_config, &fsck_obj_options);
 	prepare_repo_settings(the_repository);
 
+	fsck_refs();
+
 	if (connectivity_only) {
 		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
 		for_each_packed_object(the_repository,
-- 
2.47.1

