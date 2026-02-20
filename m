Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B132E6CCB
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575968; cv=none; b=VXInBJcsuoZWX5/kbMw/LjtEgdb6iSgTTNSc3jRpEoUztiafbv+FnIdtGPdXMcCbzANvVGDX1KqAEOsS50dg6squXehrqN5QtIIkJncY4rC1NLraZJoEAkA6i6KB+9cYQ6ZpTsVr2wB8eGpvcdklvW+BG3yDEWjZMhVxi0X5Shw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575968; c=relaxed/simple;
	bh=EKWn7aF5HJtt6YuTfTxb7hzDyvYKfpprmNVqYZdWFHE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=StNs6CCNYA5nMFEzB00+S7roEtg82C3KNJclnwdYqOONr/sETkCf0r+UldYfBFaJ0+IcJ+PUwuvlqVv0II4b9+BNACvpKQz672LtXkOkuVEXEH/Q2YllXxBaXQYx5m3V4rhrtynsura95TAQZ77g+oKy4L5TXkdwTjN4IVJRvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K7uTM1FY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nsowz1+e; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K7uTM1FY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nsowz1+e"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E025B1D00011;
	Fri, 20 Feb 2026 03:26:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 03:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575965;
	 x=1771662365; bh=u035ZO+UjpFLc7e7WmiyFgSJ1AwJzbSJRVnj3kSoBhY=; b=
	K7uTM1FYWtrHA/qibbXV9lgq0mxv+XmlUTMig73l3B+IPfZun0zpNB/4YzGLuvj+
	2vE8YRflS7xD+A+BppoxzmMZuUZn8HPFInONx16TcWgw9bSp2Nt0wYuy9EDFMHU5
	sizUDMGULJk4NzW9zV+fKgDcrdCl0zkHo7bvpa36nX5G7pCznOVhVhdZl9Y3YqoT
	MhD5AayU7j1NL+Nq7tkR8mLbu4/LYjyDV3aZwcHQsc2bSo2g50tc/Ez86XFtP6R2
	MKgq3n2dGNb+jNs3JKlgTFu09wcs4xETBsiVWqYXfBQ/Y85Z5T+DfF7TrVxuqXpc
	hwu9sJSZbxzNUVBhZEMnXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575965; x=
	1771662365; bh=u035ZO+UjpFLc7e7WmiyFgSJ1AwJzbSJRVnj3kSoBhY=; b=n
	sowz1+ep9vMdDnX/RDZu4hCS+rGVfHTR4x51bEqHtCwrQ3FwpAql6k2FlNvqOZXu
	MVLnqyW/NKoNel76JD5YyLU4AB4Umn9FnKKyLna/Xo7ZBAdmxih5iX6Y8a54FziV
	+r7JDl4xK2prDHBlwgYgAOxPnQGHhbxKHB7+z1pUy9Tso+l1DX6LHns7b6XE5JM3
	N75tXzfcz0WS+tXmQJMtEcuUEi79v0UcepvDJwRS8o8eCGiWtLb7+Mfh/xW7nPoh
	UYMJAzGOPsT1IYU1S1DUDhi9m2cmSolhlozm6iZwWrs4E/9WBb6F7zSsQH2R4mY0
	QbHuvjLhpbEpZz+9YTxpQ==
X-ME-Sender: <xms:nRqYaaVh8wKsjaPj5nkXoWuP2gnycueAghhrDGiLEzozPM1b7P6eTw>
    <xme:nRqYadmRpWjy8zwC8Dr5DlURI0YUqEF6UDbUXx1O92VCahNOH74A1IXPmkhKgc7zT
    RW1Rv66VSdlJiNY0rtoi6FnGFKLBoFA8n8ZIiorvWeNCUg-ouTdU88>
X-ME-Received: <xmr:nRqYaTYdfl9rQ7dLZj0e2llszgCLcaqEnK1GY8jstVd970XbulccAo_6wbFfSnHmEq_TuokF3jThj15BGhERevsUcNf_ZwuMCRbBE1zoHvtS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgjefhudduffeuvddtieefkeegtdffgfehgfevveffueetudehfedvvefhvddvhfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhhthhtphdqfhgvthgthhdqughumhgsrd
    hshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrgh
X-ME-Proxy: <xmx:nRqYaQMC2ZGIWJJqUybFSAK6evrNFiw6G8t7bRxhocLBcJn_qIel7A>
    <xmx:nRqYaQbDOTNjf5L5VYAPsT4YsgxL2Sk3Q7ctJN8Hfqo9HBbvmsHZKg>
    <xmx:nRqYaW277QAq_mrdJrPKqImrwqFMD4IJZ12_m-MJzbNqT52bbUKWqA>
    <xmx:nRqYaefOA9KzqC2xnhe6alK1pbNYW8PIsLguxd8gQpgoMjAvk_q9tA>
    <xmx:nRqYaUqN4f328_E8vtFYdLwHGNQu60WL8ZQes_uvnPM-hcdDkqgA_4_Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:26:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6b44775 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:26:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/5] Fix tests with missing iconv(1) executable
Date: Fri, 20 Feb 2026 09:25:58 +0100
Message-Id: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJYamGkC/43NTQ6CMBAF4KuQrh3TaSsUV97DuIDSysTwk9Y0G
 sLdLSwMbojLN/Pmm4kF68kGds4m5m2kQEOfgjpkzLRVf7dATcpMcJFzwUuoFYyPAIagC9EAmaG
 P4OhlA6BsrNIccyUdS8Do7bpI99dbyi2F5+Df66+Iy/QvNiJwQCsxL0yjtdCX1DxSxxYzio2Dx
 a4jkiNOqsTa6KZ2v47cOnrXkcnh2qBz0jlTVl9nnucPOrtxUVEBAAA=
X-Change-ID: 20260209-b4-pks-ci-msvc-iconv-fixes-13de4801643f
In-Reply-To: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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

Changes in v4:
  - Use `test_grep !` instead of `! test_grep`.
  - Another commit message typo fix.
  - Link to v3: https://lore.kernel.org/r/20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im

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

Range-diff versus v3:

1:  3cfc78f873 = 1:  ac36dae86b t: don't set ICONV prereq when iconv(1) is missing
2:  768d0c8de1 = 2:  4b461caa9b t40xx: don't use iconv(1) without ICONV prereq
3:  b552d77cf4 = 3:  ad9278cab4 t4205: improve handling of ICONV prerequisite
4:  7f35641968 ! 4:  863488c534 t5550: add ICONV prereq to tests that use "$HTTPD_URL/error"
    @@ Commit message
         t5550: add ICONV prereq to tests that use "$HTTPD_URL/error"
     
         We've got a bunch of tests in t5550 that connect to "$HTTPD_URL/error"
    -    to ensure that error messages are proprely forwarded. This URL executes
    +    to ensure that error messages are properly forwarded. This URL executes
         the "t/lib-httpd/error.sh" script, which in turn depends on the iconv(1)
         executable to reencode the message.
     
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'fetch can handle previously-fet
      
      test_expect_success 'did not use upload-pack service' '
     -	! grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
    -+	! test_grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
    ++	test_grep ! "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
      '
      
     -test_expect_success 'git client shows text/plain errors' '
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'fetch can handle previously-fet
     +test_expect_success ICONV 'git client does not show html errors' '
      	test_must_fail git clone "$HTTPD_URL/error/html" 2>stderr &&
     -	! grep "this is the error message" stderr
    -+	! test_grep "this is the error message" stderr
    ++	test_grep ! "this is the error message" stderr
      '
      
     -test_expect_success 'git client shows text/plain with a charset' '
    @@ t/t5550-http-fetch-dumb.sh: ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.9
      test_expect_success 'git client send an empty Accept-Language' '
      	GIT_TRACE_CURL=true LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git" 2>stderr &&
     -	! grep "^=> Send header: Accept-Language:" stderr
    -+	! test_grep "^=> Send header: Accept-Language:" stderr
    ++	test_grep ! "^=> Send header: Accept-Language:" stderr
      '
      
      test_expect_success 'remote-http complains cleanly about malformed urls' '
5:  c8e69ff135 = 5:  58533d4b58 t6006: don't use iconv(1) without ICONV prereq

---
base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc
change-id: 20260209-b4-pks-ci-msvc-iconv-fixes-13de4801643f

