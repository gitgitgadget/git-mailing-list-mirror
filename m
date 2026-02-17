Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10315339868
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336716; cv=none; b=bsEHY7VN+FSHbbSWS+o84aS6SNb9ISpXAoO42ubLfUcmb4vCbBfPj3oKhQPhOWIy7Mb+uByqPOcbZtkBTh3Cf9H9Ipp/XxOM9mycG3AMVZdXrRlRn18BE9OB+EhxRH1oJvBink8cgFhleaa+tJNuKqRlWIOAsevgmdyW0byqE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336716; c=relaxed/simple;
	bh=1KEjRSXG9AMQeEoqMxIdECNjG+10jfLiwriuwKzRTEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Te4QQroRq+RfAt1A8fAc+aHFuhF5/z4LX5y9iw14WD6Z6LtSPTMbyVSX43kz0e/s1NCRXIRWg6IyqF3b7U/BvlyrYl3FPqF3DbmP5c3VZf6IeDIy8rPp9BLXOEgM7ixsGRihh2MYGcOjVveOPueuTlgBzuqlaBl+wu08n1vjDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G4x5Ql9D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=quB2sYtQ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G4x5Ql9D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="quB2sYtQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 39EC9EC05A3;
	Tue, 17 Feb 2026 08:58:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 08:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771336714;
	 x=1771423114; bh=JgwlRCZyaO4KiGxZcQR+/e8mFAnCHN+jvdhILhKVp0k=; b=
	G4x5Ql9Dxtdr8oor1tySa2ZJd6TgeZsQ0fHovVmeLx7TOjam6yM8Ic3NgjmYFqlG
	K06OBdzuomZpzYf2X+OTnh4yy4+Hxn2w0NQzOl5QkONCO9j58Y1JiC4suuZlDdHD
	rSqh9pU3TuH96jlSdM1WhvFtjrK1EimRy9AX1qh9+QFXMbwL/R8Orr3XtjmTcutt
	GTV/LYsXCuNZ/L+EBAY8FIgd6Tm9boqduanlQ5CJBrc8vQ+csoEGbZEtultlKC+d
	YgGwkxsttvKI366lTCJL/T4ocesiqU48gYWe1m1T/u7DO0Ao0bAZbjYJA3e0lLTs
	FneFLZK99Y+gV/z5sO8YpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771336714; x=
	1771423114; bh=JgwlRCZyaO4KiGxZcQR+/e8mFAnCHN+jvdhILhKVp0k=; b=q
	uB2sYtQsEHk9LY8/aDyLyTxKkfrQA+bqCTe75h0qNxbfYfsHuXBkeFc242xh+11n
	IvBtBHH4wFcfZ78xTTuX5sN9QIUqdIvCIeKqAlyzlh7Vp4LnVhRsHmArN/kAfiS4
	tGCjTH6v3mIEXxEUATXgc+lYN3thMssKvPjJ0u1TVAfLCqK//sCRP1fcoKLYgqBB
	FiHVvzxeCVM4FrP2zrKQOllsKKDO3jCW5MvZh4XTFrIYMrn9pX0GlqY6g/pWthLy
	JTfVV9SsA8QRCgdsbLp7V46h/DBzJLORjj6eF+gfiPJNx1WLQSuM2krFddCHNylq
	dUM0aFQ8HBWFNduOHWWMA==
X-ME-Sender: <xms:CXSUaRXZXVNuhiAMsGDvzmXPP0MW0Ehc5op_zAeV3hN3UBq3scbLfw>
    <xme:CXSUaXnr7f1m82icMm0v4YSp16EZm2wHpbIbPK-bW_nHrxzDpJMUhvp6H6xQpyo54
    Og4L1WCuB0YLBK6Ln2zBzfbPa8Mb8fyUlTCEl3k7hnhrH6Tyr3qjBc>
X-ME-Received: <xmr:CXSUabDusBUaAzIILSZKiiYb9tt3QCbeNdbsx9OGPSOODGAgC_1ehbJRnKr3K1lrVMQOZqmMsstscBLxzyOzHl82x9K9_GV6WwWQheYMKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgjghfvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfffhffeiudffhfeufeetteelgffftddtke
    efvdehhfegkeeljeejhfelfeeiueeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdp
    hhhtthhpqdhfvghttghhqdguuhhmsgdrshhhpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhes
    thhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:CXSUafcJ4gQqynhoqO8JZGYPE61sFLdiXQXYnnqvtblaXgmooT_ynQ>
    <xmx:CXSUaeKlrHRLsT5N69Iufak_qJCeyizId5uxX1GAAW5XhBcKZqzlaQ>
    <xmx:CXSUaaeYe1BmbMUeEcIZdZ6nNffZ6pSeZzXILOtzpuBqGvMkEMFn8Q>
    <xmx:CXSUad27TreUQ0IHjafLE-ltZe3sC2tE6sCwZcEnRNokJVrB0VPvuw>
    <xmx:CnSUacsVBoi3X4haoSBkijam9yLi_5NI7xAvfOcKAvBmEutAx3q6F0-r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 08:58:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a8ee6f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 13:58:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] Fix tests with missing iconv(1) executable
Date: Tue, 17 Feb 2026 14:58:26 +0100
Message-Id: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJ0lGkC/42NSw6CMBCGr0Jm7Zg+SK2uuIdhoe0gE0MhHdNoC
 He3cgKX3/9cQSgzCVyaFTIVFp5TBXNoIIy39CDkWBmMMk4ZdcZ7i8tTMDBOUgJymFPBgd8kqG2
 k1ivtWjtAHVgy7UbtX/vKI8trzp/9q+if+tds0ahQk9XuFKL3xnc1eeQJ+m3bvvA98H3BAAAA
X-Change-ID: 20260209-b4-pks-ci-msvc-iconv-fixes-13de4801643f
In-Reply-To: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

Hi,

I recently noticed that the MSVC-based tests in GitLab CI started to
fail. The root cause is that the iconv(1) executable cannot be found on
this platform anymore. This isn't entirely surprising: we depend on the
Git for Windows environment to provide necessary shell tools, and that
environment of course is not a fully fledged MSYS2 installation.

In any case, this patch series fixes those issues by building on top of
the ICONV prerequisite. If the prereq isn't found, then we also don't
assume that the iconv(1) executable exists.

An alternative strategy would be to introduce a new ICONV_EXECUTABLE
prereq. But given that Git doesn't perform any kind of reencoding itself
in case the ICONV support isn't built into it I found it to not be worth
the additional hassle.

In any case, this patch series causes the MSVC jobs to pass again on
GitLab CI.

Changes in v2:
  - Extend the ICONV prerequisite to cover the new semantics and add a
    NEEDSWORK comment.
  - Mention the upstream issue in Git for Windows.
  - Link to v1: https://lore.kernel.org/r/20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (4):
      t4xxx: don't use iconv(1) without ICONV prereq
      t4205: improve handling of ICONV prerequisite
      t5550: add ICONV prereq to tests that use "$HTTPD_URL/error"
      t6006: don't use iconv(1) without ICONV prereq

 t/t4041-diff-submodule-option.sh             |  8 +++--
 t/t4059-diff-submodule-not-initialized.sh    |  8 +++--
 t/t4060-diff-submodule-option-diff-format.sh |  8 +++--
 t/t4205-log-pretty-formats.sh                | 50 ++++++++++++++++------------
 t/t5550-http-fetch-dumb.sh                   | 20 +++++------
 t/t6006-rev-list-format.sh                   | 29 +++++++++++-----
 t/test-lib.sh                                | 12 ++++++-
 7 files changed, 88 insertions(+), 47 deletions(-)

Range-diff versus v1:

1:  66ae888b34 ! 1:  0e26fa0f07 t4xxx: don't use iconv(1) without ICONV prereq
    @@ Commit message
         the first place, as we would only use it to convert from UTF-8 to UTF-8,
         which should be equivalent to a no-op.
     
    +    In fact, Git for Windows has recently (unintentionally) shipped a change
    +    where the iconv(1) binary is not getting installed anymore [1]. And as
    +    we use Git for Windows directly in MSVC+Meson jobs in GitLab CI this has
    +    exposed the issue. The missing iconv(1) binary is considered a bug that
    +    will be fixed in Git for Windows, but regardless of that it makes sense
    +    to not assume the binary to always exist.
    +
         Fix the issue and skip the call to iconv(1) in case the prerequisite is
         not set. This makes tests work on systems that don't have iconv at all.
    +    Extend the ICONV prerequisite to cover these new semantics so that we
    +    know to skip tests in case the iconv(1) binary doesn't exist.
     
    -    Note that arguably, it's even unsafe to assume that the iconv(1)
    -    executable exists only because Git has been built with support for it.
    -    A more wholistic approach would thus be to split up the ICONV prereq
    -    into two prereqs: one that tells us whether Git has been built with
    -    ICONV support, and one that tells us whether the iconv(1) executable
    -    exists. But that would lead to a bunch of changes throughout our tests,
    -    and for arguably negligible benefit.
    +    [1]: https://github.com/git-for-windows/git/issues/6083
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ t/t4060-diff-submodule-option-diff-format.sh: add_file () {
      		done >/dev/null &&
      		git rev-parse --short --verify HEAD
      	)
    +
    + ## t/test-lib.sh ##
    +@@ t/test-lib.sh: esac
    + ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
    + test -z "$NO_CURL" && test_set_prereq LIBCURL
    + test -z "$NO_GITWEB" && test_set_prereq GITWEB
    +-test -z "$NO_ICONV" && test_set_prereq ICONV
    + test -z "$NO_PERL" && test_set_prereq PERL
    + test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
    + test -z "$NO_PYTHON" && test_set_prereq PYTHON
    +@@ t/test-lib.sh: test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
    + test -n "$GIT_VALGRIND_ENABLED" && test_set_prereq VALGRIND
    + test -n "$PERL_PATH" && test_set_prereq PERL_TEST_HELPERS
    + 
    ++test_lazy_prereq ICONV '
    ++	# We require Git to be built with iconv support, and we require the
    ++	# iconv binary to exist.
    ++	#
    ++	# NEEDSWORK: We might eventually want to split this up into two
    ++	# prerequisites: one for NO_ICONV, and one for the iconv(1) binary, as
    ++	# some tests only depend on either of these.
    ++	test -z "$NO_ICONV" &&
    ++	iconv -f utf8 -t utf8 </dev/null
    ++'
    ++
    + if test -z "$GIT_TEST_CHECK_CACHE_TREE"
    + then
    + 	GIT_TEST_CHECK_CACHE_TREE=true
2:  d5831c230e = 2:  ae4d582c53 t4205: improve handling of ICONV prerequisite
3:  a55d3b7ed4 = 3:  3c28d86b25 t5550: add ICONV prereq to tests that use "$HTTPD_URL/error"
4:  28306e7c1e = 4:  b1f05d7725 t6006: don't use iconv(1) without ICONV prereq

---
base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
change-id: 20260209-b4-pks-ci-msvc-iconv-fixes-13de4801643f

