Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDFF503BD6
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677532; cv=none; b=WGARMx359QZDmf3t2fU4dhYS3JutqiETaimMFqBe9iER61xkqwYmAstU7pnx2LWra0w4z9k7G9PnLlNZCqmvaGlqcn0L/9w1bygBnPlh6TD4kBreLIrPCPCee1kzO+G/3kGLjTifL5+FaIj6n3gD1Lrt8bNhYgJ8voKh2j3HR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677532; c=relaxed/simple;
	bh=hoOlx9A3b2d4XcaYLb9tY+asMsiEH1ZgBnxD3LwuzTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRgvAWlHXftiqa0zC4jHp3BWIjCwVkJFFrVuooVy+DWgNjNkpYC0eIkXZqJdP/HwCYZmINnDCC1JlM8i4jtptu10VbGqZcWNukxvoE6HxB1gsL8TRZ0OAm9s9l0zYydahLuAYaCCHLPty+USDWCD8AnloL3JQ4XdwNzRo5MCR5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O75NaR9j; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O75NaR9j"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-142dd046b87so2872095c88.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790677519; x=1791282319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUsDSxFk43VhGuhyWtfHyen3mUCbU5LOOKt+bLNtJd0=;
        b=O75NaR9jFdWB9HbjP2PvCqIJ9YxpCfiHOX4OwauNO3MJym4MNppd+c+1pBXyj2JO4+
         eIlSCl1HCPdy2e/gHsae3d17Fb6JecKtmXHTIQ12s0gSX7VKfRzOvym+NTfobvbBXTmj
         Fp9Xp3lszu2MmpEK3Bjx9TyymlveouzDDVl8fmR7MyBH/Kj5ABMZxCcBFV4CKqAn2U6M
         +kMxxNABnVwqnPyE4QjGOuNYGJKmDl2YjaEMfCWZkOQ2+7RyQLLu6vBznK/3JVK4F5gC
         4hkXNnhFZDEDKcfSL9yr2XyRBMzE8K/go56DejDgLfOkNH0/A5jF1wRLy0ta0/KX6YZk
         +WqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790677519; x=1791282319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUsDSxFk43VhGuhyWtfHyen3mUCbU5LOOKt+bLNtJd0=;
        b=nV/TJF9MhjUD6uIt7wu/W4hVOe+JCPYlMTOUV+ooaAMo5Za+UpIc7i7EsIsZTOfRA5
         xR/hVp4KQfghK0eUMe2eJ7GDVAQ+SmLF+Yx296A28zNwgE8eSyEhnoM7pA2rFfHR4J5N
         UsXKPvJLCZEbT1I12FWC8G4+ZZHPS8lahHCauhZS7qarftBG1HeDt9iAOJ0ax6XmAEen
         VE0MocC0DXiNh02V7O9hlVh5pO3XZt1dEBMf1YibeR/ApuoFMgTY7RqNJq7p2TfXc5EI
         HNDhaN5057/21NdlYZU3cnVFZKwgNbUcBJbDpBHeHkRNt/LOFXkbCIeV+FfDBbDAsvsu
         3UrA==
X-Gm-Message-State: AFuF++lIGlwK4SGqiZmBDVyaiBcwmykeWcFeeiy1JmCapYOWK8ScNHXr
	dCXyAtoS9G1EZgdOzXkuk4a4lKLxxsYHdTAdS2Kucl1r2N8CoFQJv98yGg4vQg==
X-Gm-Gg: AYBFou13SP9YT8uITGntXmrI4QvC1zCIN97qYuwRc8TpEYRJJ1ZDQZM1MQqu73BB9In
	RXyaWWg/Js1kUoYqJ65ZFNMHnE5wpWXOV0ytj9sM26G2xDMTFPYO0a1AjIzqPbN07l1rfaRCtkf
	vtPb04+YV0C6RqNA0XFMNpr9dxdi+18z4k16dA+FLO3PXROvHgr+xrwatVz9msGirkM+Xzo/bD6
	+tSvCklLkZrb7IBghljQebLAiR6upL54cj6NDmHH0kqmvLnBJj+7l6KEphKvf18hQbq7lZgurvW
	A2tnusA4bLr1fpLPrYvUVLOO6AV7NqOzIdHc5OHacnFj5IoTrhMndmknXlRRe9AWstHgZjku3MG
	CkgJu405/Cq5NeuAVL3LnVkkS8VXB30jauv8ksViGygV1vGzlJmNpsHMBln9Rra/z3GBpx+EugH
	iSTKqR/M5E/iPrSu1s+ihtDKoX0ekBVMl8+IQGOM8EVxmSadKk5ukd4Su5S0fvc5+dBrmDBNf7j
	aV8nJjVvFwuwWQRYuney9RE3rCTZB47Xcuay3Lo
X-Received: by 2002:a05:7022:ea8e:b0:14a:8df8:56c5 with SMTP id a92af1059eb24-14a8df85d22mr3745232c88.26.1790677519216;
        Tue, 29 Sep 2026 03:25:19 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2401:4900:884c:d167:a737:cb55:b3cc:523e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc45f03sm30417589c88.7.2026.09.29.03.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:25:18 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 0/4] Improve error reporting to mention "why" a directory is not a repository
Date: Tue, 29 Sep 2026 15:55:06 +0530
Message-ID: <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.12.g2c9c8d64bb
In-Reply-To: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment, there are a few scenarios where the error message for an
invalid Git repository is a bit blunt. For instance, when we point
GIT_OBJECT_DIRECTORY at a directory that does not exist, we get this:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
  fatal: not a git repository: 'repo.git'

Even though repo.git itself is a valid repository, we get this rather
puzzling error saying that it is not. The actual problem is the invalid
value given to GIT_OBJECT_DIRECTORY, and the user is left on their
to figure that out. This series aims to make such issues easier to
diagnose by saying why the specified repository was not considered
valid.

With this series, the same command outputs:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
  fatal: not a git repository: 'repo.git'
  reason: cannot access object directory '/does/not/exist' set via $GIT_OBJECT_DIRECTORY

The following scenarios are covered when --git-dir is given explicitly:

  - HEAD is missing, or its path is not traversable
  - HEAD is a symlink that cannot be read
  - HEAD is a symlink whose target lives outside refs/
  - HEAD cannot be opened, or cannot be read
  - HEAD contains neither a ref under refs/ nor an object ID
  - $GIT_OBJECT_DIRECTORY is set to something we cannot access
  - the object directory in the common directory is inaccessible
  - the refs directory in the common directory is inaccessible

This series does not yet report a reason in the following cases.

The discovery walk, where we iterate up to the ceiling or the mount
point looking for a repository:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git rev-parse --is-bare-repository
  fatal: not a git repository (or any parent up to mount point /)
  Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)

The gitfile case, for instance when run from inside a submodule /
worktree:

  $ GIT_OBJECT_DIRECTORY=/does/not/exist git rev-parse --is-bare-repository
  fatal: gitfile does not point to a valid repository: /path/to/super/sub/.git

GIT_ALTERNATE_OBJECT_DIRECTORIES is also left alone. Its diagnostic
are misleading in their own way, but they are emitted much later, from
the object database rather than from setup, so they need a separate
treatment.

I would be very interested in hearing what others think about this
direction. If it looks reasonable, I'm happy to cover the remaining
cases too, either in this series or separately.

CI:

One symlink related test appears to be failing in Windows. I'll check the same.
All others pass.

See here: https://github.com/sivaraam/git/actions/runs/36548531586

Changes since v2:

- Included 1/4 which fixes a style nit
- Dropped the sub-shell from the test that was unnecessary
- Fixed some style issue and tried to improve the code intentation corresponding
  to the strbuf construction code
- Replaced sentence lego with a single string even though that means
  additional work for translators. On the plus side, avoiding sentence
  lego provides them more context about the message.

Range-diff between v1 and v2

-:  ---------- > 1:  17b72331d0 setup: normalize an if-else to follow our convention
1:  b4d7a4efa2 ! 2:  962418c9f3 t0009: add tests to cover more error reporting scenarios
    @@ t/t0009-git-dir-validation.sh: test_expect_success 'setup: .git as an empty dire
     +test_expect_success 'setup: custom git directory with missing HEAD is rejected' '
     +	test_when_finished "rm -rf parent/empty-dir" &&
     +	mkdir -p parent/empty-dir &&
    -+	(
    -+		test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
    -+		test_grep "not a git repository" stderr
    -+	)
    ++	test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
    ++	test_grep "not a git repository" stderr
     +'
     +
     +test_expect_success 'setup: custom git directory with HEAD as a symlink outside refs/ is rejected' '
2:  8591dc4162 ! 3:  4a1503a6dc setup: introduce new helper 'is_git_directory_verbose'
    @@ setup.c: static int validate_headref(const char *path)
     -	if (lstat(path, &st) < 0)
     +	if (lstat(path, &st) < 0) {
     +		if (err)
    -+			strbuf_addf(
    -+				err, _("could not stat HEAD at '%s'"), path
    -+			);
    ++			strbuf_addf(err, _("could not stat HEAD at '%s'"), path);
      		return -1;
     +	}
      
    @@ setup.c: static int validate_headref(const char *path)
      		if (len >= 5 && !memcmp("refs/", buffer, 5))
      			return 0;
     +		if (len == -1 && err)
    -+			strbuf_addf(
    -+				err,
    -+				_("could not read the symlink HEAD at '%s'"),
    -+				path
    -+			);
    ++			strbuf_addf(err, _("could not read the symlink HEAD at '%s'"),
    ++				    path);
     +		else if (err)
    -+			strbuf_addf(
    -+				err,
    -+				_("HEAD is a symlink ('%s') but target"
    -+				  " lives outside refs/"),
    -+				path
    -+			);
    ++			strbuf_addf(err, _("HEAD is a symlink ('%s') but target lives"
    ++					   " outside refs/"), path);
      		return -1;
      	}
      
    @@ setup.c: static int validate_headref(const char *path)
     -	if (fd < 0)
     +	if (fd < 0) {
     +		if (err)
    -+			strbuf_addf(
    -+				err, _("could not open HEAD at '%s'"), path
    -+			);
    ++			strbuf_addf(err, _("could not open HEAD at '%s'"), path);
      		return -1;
     +	}
      	len = read_in_full(fd, buffer, sizeof(buffer)-1);
    @@ setup.c: static int validate_headref(const char *path)
     -	if (len < 0)
     +	if (len < 0) {
     +		if (err)
    -+			strbuf_addf(
    -+				err, _("could not read HEAD at '%s'"), path
    -+			);
    ++			strbuf_addf(err, _("could not read HEAD at '%s'"), path);
      		return -1;
     +	}
      	buffer[len] = '\0';
    @@ setup.c: static int validate_headref(const char *path)
      		return 0;
      
     +	if (err)
    -+		strbuf_addf(
    -+			err,
    -+			_("HEAD at '%s' does not point to a valid"
    -+			  " symbolic link or an object ID"),
    -+			path
    -+		);
    ++		strbuf_addf(err, _("HEAD at '%s' does not point to a valid symbolic"
    ++				   " link or an object ID"), path);
     +
      	return -1;
      }
    @@ setup.c: static int validate_headref(const char *path)
     +	if (objdir) {
     +		if (access(objdir, X_OK)) {
     +			if (err)
    -+				strbuf_addf(
    -+					err,
    -+					_("cannot access object directory '%s'"
    -+					  " set via $%s\n"),
    -+				objdir,
    -+				DB_ENVIRONMENT
    -+			);
    ++				strbuf_addf(err, _("cannot access object directory '%s'"
    ++						   "set via $%s\n"), objdir, DB_ENVIRONMENT);
     +			goto done;
     +		}
    -+	}
    -+	else {
    ++	} else {
     +		strbuf_setlen(&path, len);
     +		strbuf_addstr(&path, "/objects");
     +		if (access(path.buf, X_OK)) {
     +			if (err)
    -+				strbuf_addf(
    -+					err,
    -+					_("cannot access object directory '%s'"),
    -+					path.buf
    -+				);
    ++				strbuf_addf(err, _("cannot access object directory '%s'"),
    ++					    path.buf);
     +			goto done;
     +		}
     +	}
    @@ setup.c: static int validate_headref(const char *path)
     +	strbuf_addstr(&path, "/refs");
     +	if (access(path.buf, X_OK)) {
     +		if (err)
    -+			strbuf_addf(
    -+				err,
    -+				_("cannot access refs directory '%s'"),
    -+				path.buf
    -+			);
    ++			strbuf_addf(err, _("cannot access refs directory '%s'"), path.buf);
     +		goto done;
     +	}
     +
3:  2c9c8d64bb ! 4:  27a9f668ab setup: communicate why a directory is not a valid git directory
    @@ setup.c: static void repo_discover_explicit_gitdir(struct repo_discovery *discov
      		}
     -		die(_("not a git repository: '%s'"), gitdirenv);
     +
    -+		strbuf_addf(&die_msg, _("not a git repository: '%s'"), gitdirenv);
    -+		strbuf_addch(&die_msg, '\n');
    -+		strbuf_addf(&die_msg, _("reason: %s"), invalid_gitdir_reason.buf);
    ++		strbuf_addf(&die_msg, _("not a git repository: '%s'\nreason: %s"),
    ++			    gitdirenv, invalid_gitdir_reason.buf);
     +		die("%s", die_msg.buf);
    -+
    -+		strbuf_release(&die_msg);
      	}
      
      	if (read_and_verify_repository_format(&discovery->format, gitdirenv, nongit_ok))
    @@ setup.c: static void repo_discover_explicit_gitdir(struct repo_discovery *discov
     
      ## t/t0009-git-dir-validation.sh ##
     @@ t/t0009-git-dir-validation.sh: test_expect_success 'setup: custom git directory with missing HEAD is rejected'
    + 	test_when_finished "rm -rf parent/empty-dir" &&
      	mkdir -p parent/empty-dir &&
    - 	(
    - 		test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
    --		test_grep "not a git repository" stderr
    -+		test_grep "not a git repository" stderr &&
    -+		test_grep "reason: could not stat HEAD at" stderr
    - 	)
    + 	test_must_fail git --git-dir parent/empty-dir rev-parse --is-bare-repository 2>stderr &&
    +-	test_grep "not a git repository" stderr
    ++	test_grep "not a git repository" stderr &&
    ++	test_grep "reason: could not stat HEAD at" stderr
      '
      
    + test_expect_success 'setup: custom git directory with HEAD as a symlink outside refs/ is rejected' '
     @@ t/t0009-git-dir-validation.sh: test_expect_success 'setup: custom git directory with HEAD as a symlink outside
      		rm real-repo/HEAD &&
      		ln -s ../garbage real-repo/HEAD &&

Kaartic Sivaraam (4):
  setup: normalize an if-else to follow our convention
  t0009: add tests to cover more error reporting scenarios
  setup: introduce new helper 'is_git_directory_verbose'
  setup: communicate why a directory is not a valid git directory

 setup.c                       | 135 +++++++++++++++++++++++-----------
 t/t0009-git-dir-validation.sh |  36 +++++++++
 2 files changed, 127 insertions(+), 44 deletions(-)

-- 
2.56.0.rc1.12.g2c9c8d64bb

