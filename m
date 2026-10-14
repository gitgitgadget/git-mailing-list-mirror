Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF2490BE4
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966644; cv=none; b=onsWHFMwK+tXyCwgfnXWQ6e4LCe/a/UDFk1dkVcB5ZtXJbYw8yAX+p5kOCuLV7uDmo8onBwTcDUNDyxpCoyWsPt1m3RKx8BjRu+2kt6EpIjrSb5RwfmpJNnPyFBd6cDza4itNt16lZv5L4r608HerA9Gi8TaDgJPg4RuDK4S+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966644; c=relaxed/simple;
	bh=159Xw7tQjHRqEKRj/0WxkKcu9H2yRyzfLThzKH25tUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=QT4OzDyIo9IMAZQyjD3m041XYM43BREBRUdDaax7/LAxg7YC2+AyDr16zcxSe2w7PkAxZRBG/RarHzOhBsEWJdbRQGKfhEfJlJoGSVQR2XMLWIHtun2ud/tu13vHNqHzH/KB+fIrjkq1jnI+BmaXB/6BFhjbTKKfjE9ks2qjZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KQkfdRil; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JQ7SxKU4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KQkfdRil";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQ7SxKU4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D46FEC02A8
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:30:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Oct 2026 04:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791966639;
	 x=1792053039; bh=q99UrCmGt49BREa0sdG1tG7VvQdI4oCOK9ZGmXfb+MM=; b=
	KQkfdRilTB/KDNSmqB3o8DbFQbluG+FQYQsYKRRQ7PZsv7+cEd7lkoM/FiKJz9em
	k0VcNLPj7dhgxpWGOjMogaOgOYkKyWYQgbe/f4fPmPiqwCjd9woc5sNZMuEPw9aY
	wPRcWq55acNzePvNcWcf+Oy7yYHfm7A+/M6TIa7KeV9kX4YjrHxuY+PIeW1fqik9
	FlmA1hqrdzUkisf4CUW3mebc2qkXm7Q/e7IIHWRT/0yrYf16OZKsT5/R0hHmzLON
	dwPOGeixH4LJvpzq+qbtUV6VusG00OSQ4+PTm2D14ZfaJhRAI0+ukHlCByuNtpMa
	SYy3qJK/7+/FtD6W22twQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791966639; x=
	1792053039; bh=q99UrCmGt49BREa0sdG1tG7VvQdI4oCOK9ZGmXfb+MM=; b=J
	Q7SxKU4MlITuleLQSX5TgKBl9YktE1m8191fyGPZxWANeUt7lwGBQwu8XyUwxRBh
	yh9SBxV2CQ8mkoqeCYp+mkJewQ9wk7oOJ87cDg0AmT5CYIKpA4fHxhiLJxzu3yRl
	OSBavm45GRPDpO4bAh57Xhjlf9xfK0VhCM+1tNfZioXVvviTC1mqI1v5EOFJDTcZ
	8Uh4BwprdZucZ45l8zijiISU/N++sWIuP9FyRPq//HpNye2K2lqU0oWURmEtFE2D
	u06ce5/0txjgiLyQjp2nP44ztjZ25Yq0gZ4oo9EkZxlAP4P292i6OfwVWARN0WlB
	dUn2zMBkz5rC57rlRr43w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791966639; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IHZbVIn7iXU3bq8MBQqKl3ek1Zu+r/t/TTadst4wjiWYFIZ
	7xIyh9mbFfB2GYex6WuaxldSvxeQqt0rKwqkuAJOIvhN8srvTlTMtrb0GBhlG5rO
	mH2SzRCcqnLhl9JwNBLQmo6Wua4rqmCDjDNnNKTHkdkiH21WqDwO0etia9dCf90t
	DmYT8/8eMmzmSP3KuumLAvspYpLrKb+vMfwIhjyZEo0dJ4V/QZyc4T6T/Uh3JSOn
	d4gW8cXONR5XZUjbw04dpUqy9smMA6juVo0gY0c5EBowmmjfjZ38r+1OWYoUYJXt
	Avek5dBZ3ObxVN5fQQuwxp9oxggHsUzk50UFILg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:7CA8c7wcs8ZtQgrIUHhtJBxm3JTxcqlJdHaxH/finyU=:159Xw7tQjHRqEKRj/0WxkKcu9H2yRyzfLThzKH25tUc=;
X-ME-Sender: <xms:rz3PaufbWkfYqGi9q_IL7Xpi1XZ_yeViTsBGzzXMavV09Diw-7bgzw>
    <xme:rz3PavERYim6AZReuc2tHE7yqps1A79TvDonErg_zYRICVmGudXc0eMM4etnzjW5K
    bc_0P0UYZ07MZV7e49oOrYlaPBVo7VKlCYBfz-OuQx6LWsOQ_Uivg>
X-ME-Received: <xmr:rz3Pan28HuYrYlyxW030fzN_eq5ynavfF3sz5VVE6Hdf52OXqUAewA>
X-ME-Proxy-Cause: dmFkZTGhQSlAKGlUdXjRQULgW7hSh9I6EXrAZW2QrdbSyWd5oE4Lg/5qnc4McetNjkS1Yb
    mXWet31A2c2UQTLz/WLfAK2T03dQwc9EksvHC5xl/vo6vhsu11hPo7+E81g+d1OcK0eG96
    SJx0CLmBU4aiwX65AMz2aK5nkE8xNWgBzGaapM3qrTmNdT6iobrqC7vKC73ZRvI44OnmZF
    fhIi9Om3cM5glakq7rUCTXuiMc8A6BXpmZStj1gTCvqIfu1xRNL8FnIvvjP4EBqGsHAV0k
    eaNS6YYwZGrrvG5tOzRsLmSpJRkJdIQS/D/FQSgadvHpUvjZotJ65liaowV9XOqF7uu7YP
    /kHASFfFZuze9E0qWQc43Jdk3QJMdEuqdFxnkHfdm9ABwVdXMRBNDjj4WI4Ddk0sObnLVc
    M+j5cJZq8VBNJha8T8VBNmGXlMpeB1dvh0x7XT8sYeX1KeFnn3tYHyKWp5KCqklpxUApeJ
    0NSm/bPOpU841BD4n+Ou12q90j5WULAekhM70pyrQTJ1NGtjZB+0k1gGoSf7cSmxEdndVV
    XVdqbwfr8Gdv66qRT1c5HEiz/0RAPYMW9r7wca2F3uGpzrjae7dyXmm/ktA/gpBou3TY7h
    kzwRXliP/TU/4AXX6XrfzopnIsBm/wTZF211UUYFWdDUahWkA4fDk3pOMLjQ
X-ME-Proxy: <xmx:rz3Panm5S0fmkz3R-kLxPNGNUq5Ep6WsFXTEAv3Z6WwrfHh-OadgJA>
    <xmx:rz3Pan9rgoKQuRtjXbCLok1bS1BAmr9cRdaVoEpTR9sqMzMtsfvTZQ>
    <xmx:rz3Paso4LP04lHAud_BC2gx5dWW3dcbrLKofGTjT6xZ-6-HKkmIQuQ>
    <xmx:rz3PagnySmMAwSOWEzcvKOaKdF8l_LjbSNDM056mYlQjCvkfD8rzjw>
    <xmx:rz3PauFi16efDFZ46gUXCnVy-6Cv3fsH5Ccf-jQjso4s72-R-pumMbeA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:30:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bdb79bdc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:30:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/8] ci: some housekeeping and modernizations
Date: Wed, 14 Oct 2026 10:30:26 +0200
Message-Id: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBQE0KuQrq1pi9TiynsYF1B+4UsspIVGQ
 7i7LSbGhXE5ycybhXhwCJ6csoU4COhxsDHku4zorrItUGxiJoIJyRlTdOw91Ui7YfbQA4xoW3r
 Q5mgqndesMSQuRwcGH5t6ub6zn+sb6ClRqdGhnwb33G4DT73/D4FTRuvKMF7oQpWanWNrj3eS+
 CC+gfI3ICIglcybQoGRJf8A67q+APKMyaUGAQAA
X-Change-ID: 20261008-pks-ci-housekeeping-4cf7fac3b0df
In-Reply-To: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series is a result from the discussions in [1]. It fixes a
couple of smaller issues in our CI and bumps jobs that use EOL Docker
images to instead use supported ones.

Passing test runs can be found at [2] and [3] for GitLab and GitHub,
respectively.

Note that I've also merged the Meson changes (ps/meson-improvements at
ce4a600322 (gitlab-ci: fix hanging MSVC jobs, 2026-09-24)) in there so
that GitLab passes, but those are not strictly required as a dependency.

Changes in v2:
  - Improve commit messages.
  - Rework the "linux-reftable" job to be more useful instead of
    dropping it.
  - Rename "linux-exotic" to "linux-feature-testbed".
  - Link to v1: https://patch.msgid.link/20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im

Thanks!

Patrick

[1]: <20260906151137.GA328152@coredump.intra.peff.net>
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/687
[3]: https://github.com/git/git/pull/2445

---
Patrick Steinhardt (8):
      t5004: skip SHA-1-only test in SHA-256 repository
      ci: fix "fedora-breaking-changes-meson" job
      ci: drop unused "linux-clang" logic
      ci: switch away from unsupported i386/ubuntu image
      ci: rename linux-TEST-vars job
      ci: switch away from EOL'd Ubuntu version in linux-feature-testbed
      ci: drop now-dead Python 2 coverage
      ci: improve reftable test coverage

 .github/workflows/main.yml      | 11 ++++-------
 .gitlab-ci.yml                  | 11 ++++-------
 ci/install-dependencies.sh      |  8 ++------
 ci/lib.sh                       | 13 ++-----------
 ci/run-build-and-tests.sh       | 14 +++++++-------
 t/t5004-archive-corner-cases.sh |  2 +-
 6 files changed, 20 insertions(+), 39 deletions(-)

Range-diff versus v2:

1:  6bf6c0285e = 1:  f000630dda t5004: skip SHA-1-only test in SHA-256 repository
2:  ad57a87914 = 2:  93fce3a349 ci: fix "fedora-breaking-changes-meson" job
3:  7f80b65aed = 3:  a79409be82 ci: drop unused "linux-clang" logic
4:  1e2dfbc1b1 = 4:  7566046967 ci: switch away from unsupported i386/ubuntu image
5:  e2e71b0760 ! 5:  b6117e4ed7 ci: rename linux-TEST-vars job
    @@ Commit message
         to the weird upper-casing and because it doesn't really tell you what it
         even intends to do.
     
    -    Rename the job to "linux-exotic" instead.
    +    Rename the job to "linux-feature-testbed" instead.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## .github/workflows/main.yml ##
    @@ .github/workflows/main.yml: jobs:
                image: ubuntu:rolling
                cc: clang
     -        - jobname: linux-TEST-vars
    -+        - jobname: linux-exotic
    ++        - jobname: linux-feature-testbed
                image: ubuntu:20.04
                cc: gcc
                cc_package: gcc-8
    @@ .gitlab-ci.yml: test:linux:
              image: ubuntu:rolling
              CC: clang
     -      - jobname: linux-TEST-vars
    -+      - jobname: linux-exotic
    ++      - jobname: linux-feature-testbed
              image: ubuntu:20.04
              CC: gcc
              CC_PACKAGE: gcc-8
    @@ ci/run-build-and-tests.sh: fedora-breaking-changes-meson|linux-breaking-changes)
      	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
      	;;
     -linux-TEST-vars)
    -+linux-exotic)
    ++linux-feature-testbed)
      	export OPENSSL_SHA1_UNSAFE=YesPlease
      	export GIT_TEST_SPLIT_INDEX=yes
      	export GIT_TEST_FULL_IN_PACK_ARRAY=true
6:  0a83a736af ! 6:  e434629907 ci: switch away from EOL'd Ubuntu version in linux-exotic
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    ci: switch away from EOL'd Ubuntu version in linux-exotic
    +    ci: switch away from EOL'd Ubuntu version in linux-feature-testbed
     
    -    The "linux-exotic" job still uses Ubuntu 20.04, which is end of life
    -    nowadays and starting to show some cracks. Switch it over to use the
    -    "latest" tag instead so that we don't have to constantly update it
    +    The "linux-feature-testbed" job still uses Ubuntu 20.04, which is end of
    +    life nowadays and starting to show some cracks. Switch it over to use
    +    the "latest" tag instead so that we don't have to constantly update it
         anymore.
     
         Now arguably, this reduces test coverage for old versions of Ubuntu.
    @@ .github/workflows/main.yml
     @@ .github/workflows/main.yml: jobs:
                image: ubuntu:rolling
                cc: clang
    -         - jobname: linux-exotic
    +         - jobname: linux-feature-testbed
     -          image: ubuntu:20.04
     -          cc: gcc
     -          cc_package: gcc-8
    @@ .gitlab-ci.yml
     @@ .gitlab-ci.yml: test:linux:
              image: ubuntu:rolling
              CC: clang
    -       - jobname: linux-exotic
    +       - jobname: linux-feature-testbed
     -        image: ubuntu:20.04
     -        CC: gcc
     -        CC_PACKAGE: gcc-8
7:  9f7b154520 = 7:  72736847d4 ci: drop now-dead Python 2 coverage
8:  d97f36f5f9 ! 8:  fc15ae0fcc ci: improve reftable test coverage
    @@ .github/workflows/main.yml: jobs:
     +        - jobname: linux-reftable-sha256
                image: ubuntu:rolling
                cc: clang
    -         - jobname: linux-exotic
    +         - jobname: linux-feature-testbed
     
      ## .gitlab-ci.yml ##
     @@ .gitlab-ci.yml: test:linux:
    @@ .gitlab-ci.yml: test:linux:
     +      - jobname: linux-reftable-sha256
              image: ubuntu:rolling
              CC: clang
    -       - jobname: linux-exotic
    +       - jobname: linux-feature-testbed
     
      ## ci/run-build-and-tests.sh ##
    -@@ ci/run-build-and-tests.sh: linux-exotic)
    +@@ ci/run-build-and-tests.sh: linux-feature-testbed)
      linux-sha256)
      	export GIT_TEST_DEFAULT_HASH=sha256
      	;;

---
base-commit: 8e383dedc6bbc4fd7bbb203512fbf2eafc151e04
change-id: 20261008-pks-ci-housekeeping-4cf7fac3b0df

