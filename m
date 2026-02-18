Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18C1F30A4
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389528; cv=none; b=dyxErF0H6ep9+c6NeYJ1NVNnNTg6umcoufKdMV1ep9Sy/ptqEBcM60irpWc1SLCjZzaXybpJWXBiT2yeoBMouPJBsUe85TUkvZ3BY0e98umIX35bTzqkh/NfgJZ1bfdMnggEqICxGKaBIZbRVK4XNQYBdCd+q7/TPogkWQD6tQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389528; c=relaxed/simple;
	bh=9tBQLvjmZ30oI2zVEkEvv9XI0MqJYdHTQY0/iYdTO3M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=fZ77dTI7cwyiei3P4e5hzxwnsEmYAOUJMzzW/fGgdfQm4lXqQdKb7AI0AVsMMMK7kTQubls9/+T8QWajfH6UdgVsrpaj5WeY4M+NxlpPeKmku4TOglwQtlZ95FGv7dWc3QkgJQYX8h3oQ2b2CfJxJ8c78kTkXEo2waANE08l6X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZgQ7nDaE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3UbJDjd; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZgQ7nDaE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3UbJDjd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA7BF1400179;
	Tue, 17 Feb 2026 23:38:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Feb 2026 23:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771389526;
	 x=1771475926; bh=MjJv6FMOsDHjh2UoG4rwBzsf0dCHmCtA1xZA5mP1Bnc=; b=
	ZgQ7nDaEL5n94Ai6qBToYxuttwpx2vMN7noBAQmdID3BjSykWznwLnsE7wLpNcUf
	mLKSsdxiB+gfktsxLNccjZKRD4KbZaxAn5gPO9BNTj93zkn2WZsbW9TJ3z2+RqWK
	rZuBKBoLatonG3B/vJYLJyujxCXjppeorgMjRm1941oTfGoW1EwtRs6n0BC4drX8
	iuj6EeRmiRrOFKVk1Trx15KACHY3QtQMvd4bNWRXHobWslFc/MqJ5dYSN7G2nCZH
	gCEuCbcGYz8+FIFtGRB4qLpsTQgX+Cs/YWS1Fc9js7CLMfbVIvcnVYv0ZX9/w7Sz
	il17FNZH9NQ4wem5Bofa8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771389526; x=
	1771475926; bh=MjJv6FMOsDHjh2UoG4rwBzsf0dCHmCtA1xZA5mP1Bnc=; b=k
	3UbJDjdDA78hADJuMoRgPtee7dyPluiTzQmO5z9Tao/QlKovN8SOJRXT5/CeTwzq
	5o4cGwPJbFcqQwCIQsTIaScfbcXX6MrQhuVxbpA3GuVvc3+NXKgks2VU7wx2fkao
	VEcsB7ioT538Slaf76ws2fmE/2wGTReuZNbrPl3pFVx/esF03YidGTBattM2OmhO
	BgkLT0e1IEKgwxiKFDtv4DOvyQhm9UuwTpoeC4J6LahgWruGEN3sqwreOohEV1F4
	9yb6FwTCbDsfmz99hvJFS9FuWZzEgt8IewdVulHYMo26bX/fzvGq/EXCxxCKDoJC
	TCcPQi0PHNwAhGOBH3elA==
X-ME-Sender: <xms:VkKVab5VZPqLLoOer8PqsfOk57MNuOLh4yPJxG6XEYSoYf_Er6X6hA>
    <xme:VkKVaW7VfGnGnYt71dT176XKfBMD8_Vabv_VTtYuyvxKo2SbSS1XRMuhRUVmgDLSm
    wve9MWmTD2V4mQs_qxXihD-_w3E4VkQ2xQGkf9Bxsnlj_f48WqDHQ>
X-ME-Received: <xmr:VkKVaQGqmGuGJBV5uhhC1U9DjWj7PO5PXlcknmDteS4vRTd_cAK1nvUWo1okGXtiIpgy272KcgkZw9XmZop6g-tkaajSfekPZcyqZQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgjghfvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfffhffeiudffhfeufeetteelgffftddtke
    efvdehhfegkeeljeejhfelfeeiueeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdp
    hhhtthhpqdhfvghttghhqdguuhhmsgdrshhhpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthh
    hrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VkKVaXSRg7fXh-z2GKai7PVDiky9Pf4PGg3u-w-7pWUugakLCTjN0A>
    <xmx:VkKVaRukafB-ixh44Ey7jeH4qvQwA-163FADRYk8l_Kd2I-BMzmztA>
    <xmx:VkKVaewM55YmXKRfA_W1WAH_iKRpELL8fBzL_IFVoPlqzLzfGxWyKA>
    <xmx:VkKVaT47IUOqrlw2_6zT6427pVJ0ljSsfSospjJdDLTKgaYAR1pePw>
    <xmx:VkKVafQaffZ5Rmdsq9-0cNWBdrcPXyZHpaPjRpEEWjNklmcN2wntdbfo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 23:38:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f6112ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 04:38:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/5] Fix tests with missing iconv(1) executable
Date: Wed, 18 Feb 2026 05:38:37 +0100
Message-Id: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1ClWkC/43NPQ7CMAwF4KtUmTGKk9CmTNwDMdDEpRbqjxIUg
 arenbQLTIjx2c+fZxEpMEVxLGYRKHHkcchB7wrhuutwI2Cfs1BSlVLJGhoD0z2CY+hjcsBuHBK
 0/KQIqD0ZK7E0uhUZmAJti3x/vuTccXyM4bX9SrhO/2ITggQkjWXlvLXKnnJzz71YzaS+HKx+O
 io76mBqbJz1TftxlmV5AyJ0R0cJAQAA
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

Changes in v3:
  - Split out the changes for the ICONV prerequisite into a standalone
    commit.
  - Link to v2: https://lore.kernel.org/r/20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im

Changes in v2:
  - Extend the ICONV prerequisite to cover the new semantics and add a
    NEEDSWORK comment.
  - Mention the upstream issue in Git for Windows.
  - Link to v1: https://lore.kernel.org/r/20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      t: don't set ICONV prereq when iconv(1) is missing
      t40xx: don't use iconv(1) without ICONV prereq
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

Range-diff versus v2:

-:  ---------- > 1:  74b9ab2ca1 t: don't set ICONV prereq when iconv(1) is missing
1:  50bcd30389 ! 2:  f0461ca7cb t4xxx: don't use iconv(1) without ICONV prereq
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    t4xxx: don't use iconv(1) without ICONV prereq
    +    t40xx: don't use iconv(1) without ICONV prereq
     
    -    We've got a couple of tests that all use the iconv(1) executable to
    -    convert the encoding of a commit message. All of these tests are
    -    prepared to handle a missing ICONV prereq, in which case they will
    -    simply use UTF-8 encoding.
    +    We've got a couple of tests related to diffs in t40xx that use the
    +    iconv(1) executable to convert the encoding of a commit message. All of
    +    these tests are prepared to handle a missing ICONV prereq, in which case
    +    they will simply use UTF-8 encoding.
     
         But even if the ICONV prerequisite has failed we try to use the iconv(1)
    -    executable. But it's not a safe to assume that the executable exists in
    -    that case. And besides that, it's also unnecessary to use iconv(1) in
    -    the first place, as we would only use it to convert from UTF-8 to UTF-8,
    -    which should be equivalent to a no-op.
    -
    -    In fact, Git for Windows has recently (unintentionally) shipped a change
    -    where the iconv(1) binary is not getting installed anymore [1]. And as
    -    we use Git for Windows directly in MSVC+Meson jobs in GitLab CI this has
    -    exposed the issue. The missing iconv(1) binary is considered a bug that
    -    will be fixed in Git for Windows, but regardless of that it makes sense
    -    to not assume the binary to always exist.
    +    executable, even though it's not safe to assume that the executable
    +    exists in that case. And besides that, it's also unnecessary to use
    +    iconv(1) in the first place, as we would only use it to convert from
    +    UTF-8 to UTF-8, which should be equivalent to a no-op.
     
         Fix the issue and skip the call to iconv(1) in case the prerequisite is
         not set. This makes tests work on systems that don't have iconv at all.
    -    Extend the ICONV prerequisite to cover these new semantics so that we
    -    know to skip tests in case the iconv(1) binary doesn't exist.
    -
    -    [1]: https://github.com/git-for-windows/git/issues/6083
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ t/t4060-diff-submodule-option-diff-format.sh: add_file () {
      		done >/dev/null &&
      		git rev-parse --short --verify HEAD
      	)
    -
    - ## t/test-lib.sh ##
    -@@ t/test-lib.sh: esac
    - ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
    - test -z "$NO_CURL" && test_set_prereq LIBCURL
    - test -z "$NO_GITWEB" && test_set_prereq GITWEB
    --test -z "$NO_ICONV" && test_set_prereq ICONV
    - test -z "$NO_PERL" && test_set_prereq PERL
    - test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
    - test -z "$NO_PYTHON" && test_set_prereq PYTHON
    -@@ t/test-lib.sh: test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
    - test -n "$GIT_VALGRIND_ENABLED" && test_set_prereq VALGRIND
    - test -n "$PERL_PATH" && test_set_prereq PERL_TEST_HELPERS
    - 
    -+test_lazy_prereq ICONV '
    -+	# We require Git to be built with iconv support, and we require the
    -+	# iconv binary to exist.
    -+	#
    -+	# NEEDSWORK: We might eventually want to split this up into two
    -+	# prerequisites: one for NO_ICONV, and one for the iconv(1) binary, as
    -+	# some tests only depend on either of these.
    -+	test -z "$NO_ICONV" &&
    -+	iconv -f utf8 -t utf8 </dev/null
    -+'
    -+
    - if test -z "$GIT_TEST_CHECK_CACHE_TREE"
    - then
    - 	GIT_TEST_CHECK_CACHE_TREE=true
2:  5b4e3270bc = 3:  cdbc1ca807 t4205: improve handling of ICONV prerequisite
3:  60dfbaaf17 = 4:  3c66466ba4 t5550: add ICONV prereq to tests that use "$HTTPD_URL/error"
4:  b29618e071 = 5:  0306f9d1f8 t6006: don't use iconv(1) without ICONV prereq

---
base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
change-id: 20260209-b4-pks-ci-msvc-iconv-fixes-13de4801643f

