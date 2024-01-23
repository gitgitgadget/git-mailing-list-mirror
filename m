Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FF23A1B4
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 21:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044089; cv=none; b=UL/DRm/QTEqkyy+BU4a9x78OQRsLVj9+6yDkzlvDrdAtEOJl6pKkyHsE+GmYikI2Lnkja/tWZfm5vFh2Ug+1bF/aapi8xISar2OUUwFOKX4mTlvP+OGhy8nImmX+UThHFSnhwIvW1u0YLoIVnU9qVAVY8MLVtftRqcJeFf5S71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044089; c=relaxed/simple;
	bh=OqkVEBRVxiHayEhhJCwoRY9ex+FrNfNjsPPQUiCge60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WcE4f9c5C+MTeIBXxNUuRKq9onR8YxadcKvizq2jA+JuIhxvQKleUI3vkJnShKKc9/ZzUQN0lwsehIh0jgCcraIouRdqccxwsxjuR4ohMcv4STCql82pWgfxmo1WUTSpHDZI4ft8b1M1WRlqVUaM6e5UOkN3HOT4NE1a1Mx/T6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ti6NfapD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ti6NfapD"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d74045c463so18656555ad.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 13:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706044087; x=1706648887; darn=vger.kernel.org;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lldujR1gGNwZ65+nqN6JhS2be2X/YZLbCL+JmBNB8I=;
        b=Ti6NfapDhSYtUHyXOHKsxjq2tn6y+rx5GZp+oTUhD9B9akf/WdUOU+2UH3s/bC3ZdO
         J18wtUwo3S7DxLJreq5MGAxXgNNDRMibyuVtqwC1bGQtEL+kiae0Hl1ZygXySMcIZgNA
         3yXQdiebwCgUawqJd+tPFAg5rIQG3h8XNXAbMdMPriMbKk7mIpe6c4xj1aPWFhRieSEC
         2ToLZ6egISztIozGJt0YIH+0uMPoup0XyLiIgBb3Ze3XtZ7baTkRYdIOSxvz+qGHZBSn
         HyXWVyOU+xrvXkDCMw2gwco1ZHYhk8vNMPsIhthfRpu38u2pHwfL8wgWL7lcIuZv+OEj
         FsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706044087; x=1706648887;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lldujR1gGNwZ65+nqN6JhS2be2X/YZLbCL+JmBNB8I=;
        b=H7AIuOhPrHcSWxU1A/SEGlX5jW9TdnJu7+G/F2aIXOIm69Taa7nUSLx30sLJ/Kb671
         8I53xFLztCU7gkHLfGwP5eZe5rOkl3zBZRanY+l6pQiD8ZcrGlxshFWSGi+G1aRQwEWt
         ijShhszp9dUkvl4uiiIAqKaN1BjkNRLzlZQtc+kuyzkqcKIwTkDFpkTQLsGFvZD5wSFl
         l95v1mETQC0hmbbNU996zlAVpSFtfZgkwmQsUvd2kkTOgSw7ZE8CnJfMtHuEClKgiiII
         xzz+T7HA9D0D6DnbhEjYDh+QDTH+O1+4GUyPBm0dbdSEDa1k+h4IUCXbjbq4DrSAcVv0
         pY3Q==
X-Gm-Message-State: AOJu0YyHs9TsGyNhSjRKWhBgj8UF2i0I/rRgTAF0xiqmUPmd9tvaWh6B
	GrLH4qhnNgOaa0tFl+CBCf2fURgnSmzJwglIl58sZ7kKJIXmom6tGQoFDH/A4FpNnOA2KEIeRT7
	Ngg==
X-Google-Smtp-Source: AGHT+IETW9SpY9nfE7W23IUawqahQa+Gm9UYsBv3cdkYCDZuMypuFergAhqquXAae/151wiM60RYXA==
X-Received: by 2002:a17:902:ea0d:b0:1d7:4dfa:cbbe with SMTP id s13-20020a170902ea0d00b001d74dfacbbemr3658943plg.44.1706044086774;
        Tue, 23 Jan 2024 13:08:06 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:6543:4fcf:4afc:fb2e])
        by smtp.gmail.com with ESMTPSA id o7-20020a1709026b0700b001d494f3d9d4sm9199847plk.220.2024.01.23.13.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:08:06 -0800 (PST)
Date: Tue, 23 Jan 2024 13:08:01 -0800
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: bcmills@google.com, peff@peff.net
Subject: `git fetch` with protocol.version=1 misses tags that point to the
 fetched history
Message-ID: <ZbAqsf-2DWaXbN7K@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	bcmills@google.com, peff@peff.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

At $DAYJOB, we got a bug report that Git 2.21.0 breaks Go's CI due to
not fetching all tags in the history. The bug reporter (Bryan, CCed) was
kind enough to bisect this failure down to 61c7711cfe (sha1-file: use
loose object cache for quick existence check, 2018-11-12). This was only
recently discovered because Go's CI was using Git v2.17.6.

More details can be found in the original bug report [1] and Go's issue
for the CI breakage [2].

[1] https://git.g-issues.gerritcodereview.com/issues/320678525
[2] https://github.com/golang/go/issues/56881

A log of the failing Go test follows:


  vcs-test.golang.org rerouted to http://127.0.0.1:36865
  https://vcs-test.golang.org rerouted to https://127.0.0.1:43597
  === RUN   TestStat
  === PAUSE TestStat
  === CONT  TestStat
  === RUN   TestStat/gitrepo1/v1.2.4-annotated
  === PAUSE TestStat/gitrepo1/v1.2.4-annotated
  === CONT  TestStat/gitrepo1/v1.2.4-annotated
      git_test.go:166: mkdir -p /tmp/gitrepo-test-767558581/modcache/cache/vcs # git3 http://127.0.0.1:36865/git/gitrepo1
      git_test.go:166: # lock /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0.lock
      git_test.go:166: mkdir -p /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0 # git3 http://127.0.0.1:36865/git/gitrepo1
      git_test.go:166: cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git init --bare
      git_test.go:166: 0.011s # cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git init --bare
      git_test.go:166: cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git remote add origin -- http://127.0.0.1:36865/git/gitrepo1
      git_test.go:166: 0.008s # cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git remote add origin -- http://127.0.0.1:36865/git/gitrepo1
      git_test.go:166: cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git tag -l
      git_test.go:166: 0.008s # cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git tag -l
      git_test.go:166: cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git ls-remote -q origin
  2024/01/17 14:11:49 serving /git/gitrepo1/info/refs?service=git-upload-pack
  2024/01/17 14:11:49 gitrepo1.txt:
  > handle git
  > env GIT_AUTHOR_NAME='Russ Cox'
  > env GIT_AUTHOR_EMAIL='rsc@golang.org'
  > env GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
  > env GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
  > git init
  [stdout]
  Initialized empty Git repository in /tmp/vcstest1128851619/git/gitrepo1/.git/
  > at 2018-04-17T15:43:22-04:00
  > unquote ''
  > cp stdout README
  > git add README
  > git commit -a -m 'empty README'
  [stdout]
  [main (root-commit) ede458d] empty README
   1 file changed, 0 insertions(+), 0 deletions(-)
   create mode 100644 README
  > git branch -m master
  > git tag v1.2.3
  > at 2018-04-17T15:45:48-04:00
  > git branch v2
  > git checkout v2
  [stderr]
  Switched to branch 'v2'
  > echo 'v2'
  [stdout]
  v2
  > cp stdout v2
  > git add v2
  > git commit -a -m 'v2'
  [stdout]
  [v2 76a00fb] v2
   1 file changed, 1 insertion(+)
   create mode 100644 v2
  > git tag v2.3
  > git tag v2.0.1
  > git branch v2.3.4
  > at 2018-04-17T16:00:19-04:00
  > echo 'intermediate'
  [stdout]
  intermediate
  > cp stdout foo.txt
  > git add foo.txt
  > git commit -a -m 'intermediate'
  [stdout]
  [v2 97f6aa5] intermediate
   1 file changed, 1 insertion(+)
   create mode 100644 foo.txt
  > at 2018-04-17T16:00:32-04:00
  > echo 'another'
  [stdout]
  another
  > cp stdout another.txt
  > git add another.txt
  > git commit -a -m 'another'
  [stdout]
  [v2 9d02800] another
   1 file changed, 1 insertion(+)
   create mode 100644 another.txt
  > git tag v2.0.2
  > at 2018-04-17T16:16:52-04:00
  > git checkout master
  [stderr]
  Switched to branch 'master'
  > git branch v3
  > git checkout v3
  [stderr]
  Switched to branch 'v3'
  > mkdir v3/sub/dir
  > echo 'v3/sub/dir/file'
  [stdout]
  v3/sub/dir/file
  > cp stdout v3/sub/dir/file.txt
  > git add v3
  > git commit -a -m 'add v3/sub/dir/file.txt'
  [stdout]
  [v3 a8205f8] add v3/sub/dir/file.txt
   1 file changed, 1 insertion(+)
   create mode 100644 v3/sub/dir/file.txt
  > at 2018-04-17T22:23:00-04:00
  > git checkout master
  [stderr]
  Switched to branch 'master'
  > git tag -a v1.2.4-annotated -m 'v1.2.4-annotated'
  > git show-ref --tags --heads
  [stdout]
  ede458df7cd0fdca520df19a33158086a8a68e81 refs/heads/master
  9d02800338b8a55be062c838d1f02e0c5780b9eb refs/heads/v2
  76a00fb249b7f93091bc2c89a789dab1fc1bc26f refs/heads/v2.3.4
  a8205f853c297ad2c3c502ba9a355b35b7dd3ca5 refs/heads/v3
  ede458df7cd0fdca520df19a33158086a8a68e81 refs/tags/v1.2.3
  b004e48a345a86ed7a2fb7debfa7e0b2f9b0dd91 refs/tags/v1.2.4-annotated
  76a00fb249b7f93091bc2c89a789dab1fc1bc26f refs/tags/v2.0.1
  9d02800338b8a55be062c838d1f02e0c5780b9eb refs/tags/v2.0.2
  76a00fb249b7f93091bc2c89a789dab1fc1bc26f refs/tags/v2.3
  > cmp stdout .git-refs

      git_test.go:166: 0.194s # cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git ls-remote -q origin
      git_test.go:166: cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git -c log.showsignature=false log --no-decorate -n1 '--format=format:%H %ct %D' ede458df7cd0fdca520df19a33158086a8a68e81 --
      git_test.go:166: 0.006s # cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git -c log.showsignature=false log --no-decorate -n1 '--format=format:%H %ct %D' ede458df7cd0fdca520df19a33158086a8a68e81 --
      git_test.go:166: cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git fetch -f --depth=1 origin refs/tags/v1.2.4-annotated:refs/tags/v1.2.4-annotated
  2024/01/17 14:11:49 serving /git/gitrepo1/info/refs?service=git-upload-pack
  2024/01/17 14:11:49 serving /git/gitrepo1/git-upload-pack
  2024/01/17 14:11:49 serving /git/gitrepo1/git-upload-pack
      git_test.go:166: 0.113s # cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git fetch -f --depth=1 origin refs/tags/v1.2.4-annotated:refs/tags/v1.2.4-annotated
      git_test.go:166: cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git -c log.showsignature=false log --no-decorate -n1 '--format=format:%H %ct %D' refs/tags/v1.2.4-annotated --
      git_test.go:166: 0.007s # cd /tmp/gitrepo-test-767558581/modcache/cache/vcs/72d702b2b3eb7cb41c516773b2d675c9ee1480e2be1059cbf3bd15f9cfac2bf0; git -c log.showsignature=false log --no-decorate -n1 '--format=format:%H %ct %D' refs/tags/v1.2.4-annotated --
      git_test.go:661: Stat: incorrect info
          have {Origin:<nil> Name:ede458df7cd0fdca520df19a33158086a8a68e81 Short:ede458df7cd0 Version:v1.2.4-annotated Time:2018-04-17 19:43:22 +0000 UTC Tags:[v1.2.4-annotated]}
          want {Origin:<nil> Name:ede458df7cd0fdca520df19a33158086a8a68e81 Short:ede458df7cd0 Version:v1.2.4-annotated Time:2018-04-17 19:43:22 +0000 UTC Tags:[v1.2.3 v1.2.4-annotated]}
  --- FAIL: TestStat (0.00s)
      --- FAIL: TestStat/gitrepo1/v1.2.4-annotated (0.35s)
  FAIL
  FAIL	cmd/go/internal/modfetch/codehost	0.398s
  FAIL
