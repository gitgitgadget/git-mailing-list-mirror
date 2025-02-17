Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A2225388
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805931; cv=none; b=qozuzDyeMEWF6JfuADm2nYNj5VqGXcj98Ami3/x7cODftDqZqbqQIdKQWbphwYq2tqPjCRGMg3A3rxGyyTiiOY9aqWnCPfnxxoF0jk6YQs3YR0Akkp+2b0UZ/beVGMTe5+Wy0kDQSpOjywG9EGTQHM1Bof4M6q+mWd/5BslvQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805931; c=relaxed/simple;
	bh=1hiuoJ0G6KP+1egPZkxIXCnY+e/6eYrzb2Wu5vNtzBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgjDzXDCPJ4j42n5P53wf1i2nbIrTdCjl7sjtvk7ycQJovmpvzy7DLJT3Jjc9bMbJHIy2UIcuMvR/6kcILZOOzJ3/5gOEJM4Yh20hK3VzkmDez+MGaYbmQnAckHqtKFycQYllz9KImESQaetxD5CjsdX7/JKnUJAEPZtfq3T3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e96Me8mR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e96Me8mR"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fc292b3570so5171117a91.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 07:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739805928; x=1740410728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h06QOZUkjxhY16ldgVdL0zpnVvlqFInXp+35e1g8dHc=;
        b=e96Me8mR8iyhl6IQ4UeyPV8z5ERo1p5lxcs7k00/i/jLS9e9KwBGv52BtQrUH1ixos
         0jtHdH2C3Z/YD9nGAHQGE69cVEq9V9gtanckEHGAatI3GEk437EZTMXaVGvhWGHOHQZB
         kVa4CQib4SHHIXGlU9FgefLLyEZHWXqiUY5VjrsWRhz/M1YOiHZvmkx1O+VyZpEBJEKc
         UfReceP94S4rsBJaw4LHYu62bazRw5AT/q96ZquKcAz6SS6gRk8/AlI7CEKNkOwYMZDz
         TnJ1bsaC5cG/sWAVjpSVQ1AlOUY4n9opmKXRsHRVd7EXHE+KvMigDMEhMXRMg1nXXqfd
         U7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739805928; x=1740410728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h06QOZUkjxhY16ldgVdL0zpnVvlqFInXp+35e1g8dHc=;
        b=GSqLqhQQ8ID/1eLhE7qBFBz9RdEBAaZ2iBzFXOCweu6Y9vwQiupGIhDWD5eowJJugI
         XBsgcRIm+AP1IeygT3mql5Zgy2Xup1DOmPH7V+pNMGhvwER6dLJ7d6zSro0bG6EO88tG
         ZI8ANJ08gb1ugXbKlHAO9M3RaicvB2YMabvTvXzdyAgssVhVDYyQcH22WQdvcvPlKrs4
         1gfiZM2cG19mpTH25y4Y8/xdGPveTJuDtBiMIT1fmlfj+3R2NmO1KtApAGQkJjvKu++l
         Oy7SqU4aqgbUGoKdXuHva2cUuCRfmsJvF4WbcmMcB6pAvrhR3fUivOj1ol+Qhtm45V1k
         2CdQ==
X-Gm-Message-State: AOJu0Yxqa2Wu93jWwQQ3RE1BbtEXaCRDcg3V0c5EajAAVye67quie10A
	1UYpsLmJ8vK3bLDr/wi4eCI9/Rftd7mgZUqKQnsDuY8kYuNJTMV7aOs7pQ==
X-Gm-Gg: ASbGncsZGvREAortxLWIWwE8pOxCRoBkp2Z1XDZtUTlboTCbWoYzxEfcW7+Hx7nM8OL
	pG2aZ8w3L5T4fLJJ2Y3Mzs7PaTu3SrfmskM4wbuh98gySJJJBRz1z9omwl/QzagUm6nHpylDB/D
	W40DzhEEzq4zgQFh/fvX0cYweaw7GvYjittDz2BZrljqOdx1f+qtKCAG+rJdov4mrTdd4JD67Bd
	WWViYNlsFS3nAIyU2Ar7THkbayeK5OHyVHaz+Wjij9mbnYron/IWxAxTiXyjIBTKHmmofgGvXI1
	+Jq1VtVTBfc=
X-Google-Smtp-Source: AGHT+IGMAeNI7vvdulWlT3833qROFM3FCmUmbwN0LXx6QZZ29DsrND9P3yyo3M4y7Ee4MoQ7jezcjg==
X-Received: by 2002:a17:90b:3812:b0:2f9:d9fe:e72e with SMTP id 98e67ed59e1d1-2fc40f22d28mr17778626a91.16.1739805928000;
        Mon, 17 Feb 2025 07:25:28 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf98cfd03sm10371346a91.15.2025.02.17.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:25:27 -0800 (PST)
Date: Mon, 17 Feb 2025 23:25:25 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 0/8] add more ref consistency checks
Message-ID: <Z7NU5fZfc8vfSvZ0@ArchLinux>
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

Hi All:

This changes enhances the following things:

1. [PATCH v5 2/8]: enhance the comment suggested by Karthik.
2. [PATCH v5 3/8]: use lstat to check whether the filetype of
   "packed-ref" is a regular file instead of using `open_nofollow`
   to check. And also enhance the commit message suggested by Karthik.
3. [PATCH v5 4/8]: move "open_nofollow" in original [PATCH v4 3/8] to
   this.

Also, I rebase due to the conflict that all *.txt files have been
renamed to *.adoc. However, I don't know whether this is a real
conflict. But I decide to rebase to make the life of Junio easy.

Thanks,
Jialuo

---

This series mainly does the following things:

1. Fix subshell issues
2. Add ref checks for packed-backend.
   1. Check whether the filetype of "packed-refs" is correct.
   2. Check whether the syntax of "packed-refs" is correct by using the
      rules from "packed-backend.c::create_snapshot" and
      "packed-backend.c::next_record".
   3. Check whether the pointed object exists and whether the
      "packed-refs" file is sorted.
3. Call "git refs verify" for "git-fsck(1)".

shejialuo (8):
  t0602: use subshell to ensure working directory unchanged
  builtin/refs: get worktrees without reading head information
  packed-backend: check whether the "packed-refs" is regular file
  packed-backend: add "packed-refs" header consistency check
  packed-backend: check whether the refname contains NUL characters
  packed-backend: add "packed-refs" entry consistency check
  packed-backend: check whether the "packed-refs" is sorted
  builtin/fsck: add `git refs verify` child process

 Documentation/fsck-msgids.adoc |   14 +
 Documentation/git-fsck.adoc    |    7 +-
 builtin/fsck.c                 |   33 +-
 builtin/refs.c                 |    2 +-
 fsck.h                         |    4 +
 refs/packed-backend.c          |  369 +++++++++-
 t/t0602-reffiles-fsck.sh       | 1205 +++++++++++++++++++-------------
 worktree.c                     |    5 +
 worktree.h                     |    7 +
 9 files changed, 1161 insertions(+), 485 deletions(-)

Range-diff against v4:
1:  20889b7b18 = 1:  b3952d80a2 t0602: use subshell to ensure working directory unchanged
2:  9d7780e953 ! 2:  3695586f58 builtin/refs: get worktrees without reading head information
    @@ worktree.h: struct worktree {
      struct worktree **get_worktrees(void);
      
     +/*
    -+ * Like `get_worktrees`, but does not read HEAD. This is useful when checking
    -+ * the consistency, as reading HEAD may not be necessary.
    ++ * Like `get_worktrees`, but does not read HEAD. Skip reading HEAD allows to
    ++ * get the worktree without worrying about failures pertaining to parsing
    ++ * the HEAD ref. This is useful when we want to check the ref db consistency.
     + */
     +struct worktree **get_worktrees_without_reading_head(void);
     +
3:  44d26f6440 ! 3:  cbaae00e8b packed-backend: check whether the "packed-refs" is regular file
    @@ Commit message
     
         Although "git-fsck(1)" and "packed-backend.c" will check some
         consistency and correctness of "packed-refs" file, they never check the
    -    filetype of the "packed-refs". The user should always use "git
    -    pack-refs" command to create the raw regular "packed-refs" file, so we
    -    need to explicitly check this in "git refs verify".
    +    filetype of the "packed-refs". Let's verify that the "packed-refs" has
    +    the expected filetype, confirming it is created by "git pack-refs"
    +    command.
     
    -    We could use "open_nofollow" wrapper to open the raw "packed-refs" file.
    -    If the returned "fd" value is less than 0, we could check whether the
    -    "errno" is "ELOOP" to report an error to the user.
    +    Use "lstat" to check the file mode. If we cannot check the file status
    +    due to there is no such file this is OK because there is a possibility
    +    that there is no "packed-refs" in the repo.
     
         Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
         the user if "packed-refs" is not a regular file.
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
      {
     +	struct packed_ref_store *refs = packed_downcast(ref_store,
     +							REF_STORE_READ, "fsck");
    ++	struct stat st;
     +	int ret = 0;
    -+	int fd;
      
      	if (!is_main_worktree(wt))
     -		return 0;
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
     +	if (o->verbose)
     +		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
     +
    -+	fd = open_nofollow(refs->path, O_RDONLY);
    -+	if (fd < 0) {
    ++	if (lstat(refs->path, &st) < 0) {
     +		/*
     +		 * If the packed-refs file doesn't exist, there's nothing
     +		 * to check.
     +		 */
     +		if (errno == ENOENT)
     +			goto cleanup;
    ++		ret = error_errno(_("unable to stat %s"), refs->path);
    ++		goto cleanup;
    ++	}
     +
    -+		if (errno == ELOOP) {
    -+			struct fsck_ref_report report = { 0 };
    -+			report.path = "packed-refs";
    -+			ret = fsck_report_ref(o, &report,
    -+					      FSCK_MSG_BAD_REF_FILETYPE,
    -+					      "not a regular file");
    -+			goto cleanup;
    -+		}
    -+
    -+		ret = error_errno(_("unable to open %s"), refs->path);
    ++	if (!S_ISREG(st.st_mode)) {
    ++		struct fsck_ref_report report = { 0 };
    ++		report.path = "packed-refs";
    ++		ret = fsck_report_ref(o, &report,
    ++				      FSCK_MSG_BAD_REF_FILETYPE,
    ++				      "not a regular file");
     +		goto cleanup;
     +	}
     +
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref content checks should work wi
     +		git pack-refs --all &&
     +
     +		mv .git/packed-refs .git/packed-refs-back &&
    -+		ln -sf packed-refs-bak .git/packed-refs &&
    ++		ln -sf packed-refs-back .git/packed-refs &&
     +		test_must_fail git refs verify 2>err &&
     +		cat >expect <<-EOF &&
     +		error: packed-refs: badRefFiletype: not a regular file
4:  976c5baba0 ! 4:  b9ce8734ac packed-backend: add "packed-refs" header consistency check
    @@ Commit message
            create a new fsck message "badPackedRefHeader(ERROR)" for this.
         3. If the header content is not the same as the constant string
            "PACKED_REFS_HEADER". This is expected because we make it extensible
    -       intentionally. So, there is no need to report.
    +       intentionally and runtime "create_snapshot" won't complain about
    +       unknown traits. In order to align with the runtime behavior. There is
    +       no need to report.
     
         As we have analyzed, we only need to check the case 2 in the above. In
    -    order to do this, read the "packed-refs" file via "strbuf_read". Like
    +    order to do this, use "open_nofollow" function to get the file
    +    descriptor and then read the "packed-refs" file via "strbuf_read". Like
         what "create_snapshot" and other functions do, we could split the line
         by finding the next newline in the buffer. When we cannot find a
         newline, we could report an error.
    @@ Commit message
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
    - ## Documentation/fsck-msgids.txt ##
    + ## Documentation/fsck-msgids.adoc ##
     @@
      `badObjectSha1`::
      	(ERROR) An object has a bad sha1.
    @@ refs/packed-backend.c: static struct ref_iterator *packed_reflog_iterator_begin(
      	struct packed_ref_store *refs = packed_downcast(ref_store,
      							REF_STORE_READ, "fsck");
     +	struct strbuf packed_ref_content = STRBUF_INIT;
    + 	struct stat st;
    ++	int fd;
      	int ret = 0;
    - 	int fd;
      
    + 	if (!is_main_worktree(wt))
     @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      		goto cleanup;
      	}
      
    ++	/*
    ++	 * There is a chance that "packed-refs" file is removed or converted to
    ++	 * a symlink after filetype check and before open. So we need to avoid
    ++	 * this race condition by opening the file.
    ++	 */
    ++	fd = open_nofollow(refs->path, O_RDONLY);
    ++	if (fd < 0) {
    ++		if (errno == ENOENT)
    ++			goto cleanup;
    ++
    ++		if (errno == ELOOP) {
    ++			struct fsck_ref_report report = { 0 };
    ++			report.path = "packed-refs";
    ++			ret = fsck_report_ref(o, &report,
    ++					      FSCK_MSG_BAD_REF_FILETYPE,
    ++					      "not a regular file");
    ++			goto cleanup;
    ++		}
    ++	}
    ++
     +	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
     +		ret = error_errno(_("unable to read %s"), refs->path);
     +		goto cleanup;
5:  b66f142d7f = 5:  9f638b3adf packed-backend: check whether the refname contains NUL characters
6:  f68028e171 ! 6:  2c5395bdd0 packed-backend: add "packed-refs" entry consistency check
    @@ Commit message
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
    - ## Documentation/fsck-msgids.txt ##
    + ## Documentation/fsck-msgids.adoc ##
     @@
      `badObjectSha1`::
      	(ERROR) An object has a bad sha1.
    @@ refs/packed-backend.c: static int packed_fsck_ref_header(struct fsck_options *o,
     +				      (int)(eol - p), p);
     +		goto cleanup;
     +	}
    ++
     +cleanup:
     +	strbuf_release(&packed_entry);
     +	return ret;
7:  4a7adf293f ! 7:  648404c60d packed-backend: check whether the "packed-refs" is sorted
    @@ Commit message
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
    - ## Documentation/fsck-msgids.txt ##
    + ## Documentation/fsck-msgids.adoc ##
     @@
      	(ERROR) The "packed-refs" file contains an entry that is
      	not terminated by a newline.
    @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      							REF_STORE_READ, "fsck");
      	struct strbuf packed_ref_content = STRBUF_INIT;
     +	unsigned int sorted = 0;
    + 	struct stat st;
    +-	int fd;
      	int ret = 0;
    - 	int fd;
    ++	int fd;
      
    + 	if (!is_main_worktree(wt))
    + 		goto cleanup;
     @@ refs/packed-backend.c: static int packed_fsck(struct ref_store *ref_store,
      		goto cleanup;
      	}
8:  2dd3437478 ! 8:  4dbbacf44b builtin/fsck: add `git refs verify` child process
    @@ Commit message
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
    - ## Documentation/git-fsck.txt ##
    -@@ Documentation/git-fsck.txt: SYNOPSIS
    + ## Documentation/git-fsck.adoc ##
    +@@ Documentation/git-fsck.adoc: SYNOPSIS
      'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
      	 [--[no-]full] [--strict] [--verbose] [--lost-found]
      	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
    @@ Documentation/git-fsck.txt: SYNOPSIS
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-fsck.txt: care about this output and want to speed it up further.
    +@@ Documentation/git-fsck.adoc: care about this output and want to speed it up further.
      	progress status even if the standard error stream is not
      	directed to a terminal.
      
-- 
2.48.1

