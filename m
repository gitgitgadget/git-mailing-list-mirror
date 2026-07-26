Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAE4377555
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785062676; cv=none; b=AwBvH6tY+7J98FCFplb5JYDOCtFhZbwvjq3+mLOV/0RyHwAL8vfI9dEXpBeuz9bG0YTYG6/KcY1oe2c+D5lApBQ9mLVYQ42MPBOuZlL34RCcY3SdTjl4i8DLkx3W7qxa7Y2jtpUuDRrfpEH+uU/dYMg95XqGIOIuQO5VeVjO4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785062676; c=relaxed/simple;
	bh=j4zNpmO1QDXNGw7TL2eNX6cQrntdZces94x7fD6d/lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVRwg0E4YtomY2O/kXhP47gGWD9EzqRk7BqOA9qusyns4UQw33sYn+vpZmsvylOsA0KzlfctvUnjSd6kWSVAyVhPqFpJR5xpkUYcJFyrc3ichMIMG9KDUupWvZCsZvDzmUbcUXDkumzznCx2Xm16l59hfRcTKdfHLEzfT0YhENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf2e7deI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf2e7deI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1816423a91.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785062674; x=1785667474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t2WIw7kS71uYhg13QsjmMqLzqsRyTD04UCYMnEbn1pI=;
        b=Wf2e7deIHZoKtWGdU0ljLvohsH0ylRc0cwKdekXi9v3IJQD528Upnd/rOgXiqTcYqo
         CB2t3BGBFINiS6IjZ8+cFf7YmPzTNsI3wmJOtSuuQTj76MNb1Tw14phYOa/T27GGicP1
         U+ypUnNid2a9vssHOw2J+QkBhIcC/HbuD722Tkgnnw002hwI5uZqCkvLO9yzhHrnNB64
         bUB0eWdLtaWETDKrxLHzHrL+eDqWa7Nub8LAR221LgjXGH6Ce4BQIsoefVdqkpwp5V+U
         mRKl2r2L9q8gia3313qkR1wP3GIDEotv9tHoQEr0FiFOIQQL4hH7yXHRpljjbUm0/lBE
         /2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785062674; x=1785667474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t2WIw7kS71uYhg13QsjmMqLzqsRyTD04UCYMnEbn1pI=;
        b=SNhN0z8SLZ9KeKXLL2wRKLbkaAl+a2KmRnhm16G2nMjScpiTf1q2E+td0C49zcQ0GM
         iWzv7MfMNZ1mqkgyxTQYO7gs+/mszcIaw5BhpEke3NFlSvtIPsCO9KxoqpvPcQUMHDjI
         DCs5eE0cZfZXdkx+90XsQ+Sc7XqqGheZbW6luTv1/MZbdJMDMAMsN+Gk4PQ0lT7+HbG5
         f2HhaWVKlW34v8Y/IfjgfKRdF3LIF8nSKi19KrnGZcfOeHcAkPAeHFNlaUG6DpeuMz/E
         nVQRx6zpOHKRA7ULYfMqYoAsEchT+m1a78gPk1s0ynh3ghAd/j1wfDvu0/Uusinc4YH1
         o32g==
X-Gm-Message-State: AOJu0YwWZsIn48MZpKPMDvp2yBoAyGGIqUYSz9if8MmvKMv3jGZjs/yY
	L5xV+TQJXyJN9S6ZTC38N8fN8UCE2LbjzcfmtYy5tmhwDh8FyG++yIUzM1KtDg==
X-Gm-Gg: AR+sD13cpNRXh78djztXGeRQFIYhopv0MhfPkA8GgZyQYjmVzBHMrHlW8M2kXSpXoQW
	Bc4kXRelBuu+zvN+agem6E/DtR33bTW6nzwlfhPVTPRoqSBzLAFcY0vOzjUOuoLripHAXsnTEKf
	gPOH5Np3xn+uIANCQGIZ0zidg5Ix3E2N5Kj0Ct8XxqeBZS5ABEgPFwklkBChIxXRgx6MffqW4Br
	EAueMTodq8i2+VoLtDoRtrRyKmPvMi5Fkt2/t7Pw9/cx2ckpfn6NJTgA4I/nKETOQKgGe/FYsru
	iX/F9/ML6WJtk+OJcFBXc5wlrQVSYWvLELaWgSY5x9jdyexST/ej3h9unbtB0zKCqUMhj00oQpK
	iTmcl820/ozC7mZ3BGt+zEO12zCt85qLsfzGPwWhI4+xY/97PhQMQDJrr7odCYixWcb9Eg+9xbG
	RRJBl48UJHoqna2Yea02m6VXskHDjDjSldXU0uqFzw2i0Qs4z2/QSYKHp6zCiZu2p5u3z4xtC3N
	9Rr9Kd4kGqq
X-Received: by 2002:a17:90a:d00d:b0:381:cef1:11b0 with SMTP id 98e67ed59e1d1-38f2965eb33mr3950498a91.33.1785062674078;
        Sun, 26 Jul 2026 03:44:34 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1255sm30371438eec.4.2026.07.26.03.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 03:44:33 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v3 0/7] repo: add more path keys to git repo info
Date: Sun, 26 Jul 2026 16:13:36 +0530
Message-ID: <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series adds keys to git repo info.
Keys output paths of repository components:
* path.toplevel: repository tree.
* path.superproject-working-tree: superproject tree from submodules.
* path.objects: repository objects.
* path.hooks: repository hooks.
* path.index: repository index.
* path.grafts: repository grafts.
* path.git-prefix: prefix offset.

Keys support suffixes for format.
Commits contain documentation and tests.

Changes since v2:
* path.index: no functional change; documented that the returned path
  reflects the default/configured index location even in a bare
  repository or when the file doesn't exist yet, and added a test
  covering path.index inside a bare repository.
* path.grafts: no functional change; documented that the path is
  returned even if the grafts file doesn't currently exist on disk.
* path.git-prefix: no change since v2 (already addressed the stray
  include and misleading "validation" in the subject).

K Jayatheerth (7):
  repo: add path.toplevel with absolute and relative suffix formatting
  repo: add path.superproject-working-tree with absolute and relative
    suffixes
  repo: add path.objects with absolute and relative suffix formatting
  repo: add path.hooks with absolute and relative suffix formatting
  repo: add path.index with absolute and relative suffix formatting
  repo: add path.grafts with absolute and relative suffix formatting
  repo: add path.git-prefix path key

 Documentation/git-repo.adoc |  64 ++++++++++++++
 builtin/repo.c              | 166 ++++++++++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 125 +++++++++++++++++++++++++++
 3 files changed, 355 insertions(+)

Range-diff against v2:
1:  297d625ea1 = 1:  297d625ea1 repo: add path.toplevel with absolute and relative suffix formatting
2:  8a84aaa2a1 = 2:  8a84aaa2a1 repo: add path.superproject-working-tree with absolute and relative suffixes
3:  159166ce85 = 3:  159166ce85 repo: add path.objects with absolute and relative suffix formatting
4:  ff5e382043 = 4:  ff5e382043 repo: add path.hooks with absolute and relative suffix formatting
5:  d906735e3d ! 5:  917d3a5076 repo: add path.index with absolute and relative suffix formatting
    @@ Documentation/git-repo.adoc: values that they return:
      
     +`path.index.absolute`::
     +	The canonical absolute path to the repository's current index file.
    -+	Respects the `GIT_INDEX_FILE` environment override.
    ++	Respects the `GIT_INDEX_FILE` environment override. The returned path
    ++	reflects the configured/default index location regardless of whether the
    ++	repository is bare or whether the file currently exists.
     +
     +`path.index.relative`::
     +	The path to the repository's current index file relative to the current
     +	working directory. Respects the `GIT_INDEX_FILE` environment override.
    ++	The returned path reflects the configured/default index location regardless
    ++	of whether the repository is bare or whether the file currently exists.
     +
      `path.objects.absolute`::
      	The canonical absolute path to the repository's object database directory.
    @@ t/t1900-repo-info.sh: test_repo_info_path 'hooks with core.hooksPath override' '
     +test_repo_info_path 'index with GIT_INDEX_FILE override' 'index' \
     +	'custom-index-file' \
     +	'GIT_INDEX_FILE="$ROOT/custom-index-file" && export GIT_INDEX_FILE'
    ++
    ++test_expect_success 'path.index in a bare repository returns default index location' '
    ++	test_when_finished "rm -rf bare.git" &&
    ++	git init --bare bare.git &&
    ++	(
    ++		cd bare.git &&
    ++		ROOT="$(test-tool path-utils real_path .)" &&
    ++
    ++		echo "path.index.absolute=$ROOT/index" >expect.abs &&
    ++		git repo info path.index.absolute >actual.abs &&
    ++		test_cmp expect.abs actual.abs &&
    ++
    ++		echo "path.index.relative=index" >expect.rel &&
    ++		git repo info path.index.relative >actual.rel &&
    ++		test_cmp expect.rel actual.rel
    ++	)
    ++'
     +
      test_repo_info_path 'objects standard' 'objects' '.git/objects'
      
6:  2d21f9536c ! 6:  d47a5701d5 repo: add path.grafts with absolute and relative suffix formatting
    @@ Documentation/git-repo.adoc: values that they return:
      
     +`path.grafts.absolute`::
     +	The canonical absolute path to the repository grafts file.
    -+	Respects the `GIT_GRAFT_FILE` environment override.
    ++	Respects the `GIT_GRAFT_FILE` environment override. The path is returned
    ++	regardless of whether the file currently exists on disk.
     +
     +`path.grafts.relative`::
     +	The path to the repository grafts file relative to the current working
    -+	directory. Respects the `GIT_GRAFT_FILE` environment override.
    ++	directory. Respects the `GIT_GRAFT_FILE` environment override. The path
    ++	is returned regardless of whether the file currently exists on disk.
     +
      `path.hooks.absolute`::
      	The canonical absolute path to the repository's hooks directory.
7:  1dbe191176 = 7:  fd90b0b3b5 repo: add path.git-prefix path key
-- 
2.55.GIT

