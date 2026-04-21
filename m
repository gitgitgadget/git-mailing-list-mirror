Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444335979
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756863; cv=none; b=Nkf3hp/82YaJoI7bzvJG5sIAIvMsY0qCUrY+uDoy1JICb3q+/bw7okqhheJsaETgLoR8NYDJ/dP7ECMjFl9a/Pp5Hc8gt0KrEusQiRii2yWNGFAF3PmdVoN+AjAf5n+8FaOysqphnU1HhyWX8ROnwK7cHqzualPUI89rAAPqc44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756863; c=relaxed/simple;
	bh=ab6ZVBILIw0OQ3clEQOmwg/Wat1rRHVh6jx6+MLNsAE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=pgC91JeHWMw2nYArrY2o9Z1etpBkOYtgtfV9ANtRUzds3hhAM8uZyXe1a450i51ljELvTOJ8Eq4MQQWpN1hON5Fuj31WfMlLDmUBEjOgIrGZaFYpd9yh5sa/0jbQ7Ru/FlQo7IYXTfvf8nkoUezK993usHiqgfNQm7BtuCwcXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A2aN2WaG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2fyDYnL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A2aN2WaG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2fyDYnL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA17A140006E;
	Tue, 21 Apr 2026 03:34:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Apr 2026 03:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756860;
	 x=1776843260; bh=lqWT9V3VwaFSD7wT6FWKkJUAa+SX2wyFI1zE0puTfNc=; b=
	A2aN2WaG4rXd8b+eypIt4dHd8Q5wUYNW2ZwffoHJxTVDAsBDJPvVqdovl0/IdNhZ
	uCQFEfsBwMYw5+g2IFWLl3lECUJ2Bta6KmQVXGkenth2e8CUfdQGNgFx037CVBI4
	CZhbkIspaPpjG/bli6FQIzeSIC+KeERmQSZjtA95xdAO8Cwf+Vygjf43oQgJFAha
	CraHfAs2aa2Mmk+ZKvmANSipIzIq3IUiT170RA23X8C++yKeWF+gjHDdfauJkK7Z
	20YvGawkVkmUTaM8x9O2i4BuGk1E0HNnKa64hqqpq08si09iBzUAPUBTSJeSJgHa
	5CJXXKryBNu0IF+Ui76LiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756860; x=
	1776843260; bh=lqWT9V3VwaFSD7wT6FWKkJUAa+SX2wyFI1zE0puTfNc=; b=a
	2fyDYnLjjwB3b5PXLnyOE5R8czgAxDttsbK1jExf8P1ETl81THdBXs3pSnY9QcvW
	2nm37Ag+RKiWJmX0yCWncdZhrW+lLI1ZpyLXLDXRDWWb65FcprQKMvA37+E582xa
	X58f5hvJKulcnmfdeP452SjYYWhVUTDUHsbd7xi1ZODggh9aX1WWpghuh0kYfteW
	mz/WksxHK/4Yaat3smtg9Bp7KmMiIhREsiXBeJuHesL7Z+2U8/ophnbB5CiPVLlW
	Acjswa5lnjp2qwQrt9GF3wrDvfljnrexzNNVW139aIz+LZA4OOxETtcY0ZRtgNpo
	8CEOs46amzFZ7aQ//hf4g==
X-ME-Sender: <xms:fCjnaW6q1eDfdLmOOWSl68Ca43zmpgbcmfRauFupAR35OEoYBO9FyA>
    <xme:fCjnaW4lr5bhaomg-ux6LvD8aR7sZ2E7j_QUUIZNg-tov8hLzYEXqQa4GIHlk_UtH
    LG98diUu2j0rNeThK3EJg_iXpoKGTH4K8wDSPxTdMbLp6E--PS2KQ>
X-ME-Received: <xmr:fCjnaafRhdd_zwbEzIrw1mJqqA606kBvqXJ8DtL2vLjYNGEjw2l2SXY518yv-H9uWoMlDKrDufCGBpWr5IDPXixrsCD4zn9Scc0QyrDatg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvleetjeeggfdvfeeutdejfeejhfehteeuje
    dvkeffiefgleffgfeijeeiteekleenucffohhmrghinhepmhhsghhiugdrlhhinhhkpdhg
    ihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmpdhhthhtphgurdhshhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    thdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fCjnaSBcau8BpZqHIdVbLga2mZUwLIj_KHuHIjp3axU0Yj2vRF6wpg>
    <xmx:fCjnaV8vz9kPpwlV9vne7WOYOt80REed8aF9bcd3W8Ug5uazVXGEiw>
    <xmx:fCjnaVLT8D1gQxpBmq-4ExTN-PPCNRP1utuCJo8FzK9OL__6iI9saw>
    <xmx:fCjnaWi56DBMJBql84BCfpJ2L1hYqCCHH0omEI5AnnmthRz17NXALA>
    <xmx:fCjnaYb1xbq_ryxs3imhLxabdR5KZ_IL97x-0G5pNfd8C1M2VORro1Yz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 01846b1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 00/12] t: detect errors outside of test cases
Date: Tue, 21 Apr 2026 09:34:13 +0200
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHUo52kC/3XQzU7EIBQF4FeZsBbDz4UWV77HxAWUi0XjzKQwq
 Jn03YUxmnbB8iSH79xwIwmXiIk8HW5kwRJTPJ9q0A8HMs329Io0+pqJYEIz4Iw6oJf3RDOmnOh
 nzDNNmClSaREG4wQ4xUl9fVkwxK+7fHz5zenq3nDKjWuNOaZ8Xr7v04W33t+K7K4UThlVbpSDl
 pbhCM+19hg/SJsoYouoPiIqAgiGgTU6cLVD5BbRfURWZLCGofLTZL3fIbBFhj4C7RLwIDF4Gxz
 fIWqDiP7PF9Uu8dLrURgRtPtH1nX9AXjHYz/hAQAA
X-Change-ID: 20260410-b4-pks-tests-with-set-e-3ae479b24b51
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this is a follow-up to the recent discussion we had around `set -e` to
make our tests more robust and basically supersedes Junio's [1].

I've tested the patches with both Bash and Dash, and all tests are
passing on my machine with both of them. CI seems to be happy, as
well. But I would expect that this change probably has some fallout,
even though I hope that it's generally going to be small and contained.

This series is based on 8c9303b1ff (Merge branch
'jc/no-writev-does-not-work', 2026-04-10).

I've created an MR with GitLab [2] and a PR with GitHub [3] to verify
that these changes work on both platforms.

Changes in v6:
  - Drop the change in t1410, which is only required for broken shells.
  - Link to v5: https://patch.msgid.link/20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im

Changes in v5:
  - Allow opting in via `GIT_TEST_USE_SET_E=yes` and enable this option
    for Linux CI jobs.
  - Another fix for a potentially-failing command.
  - Link to v4: https://patch.msgid.link/20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im

Changes in v4:
  - Simplify how we read a multi-line variable value.
  - Link to v3: https://patch.msgid.link/20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im

Changes in v3:
  - Adapt `linux-TEST-vars` job to use Bash instead of Dash. Ubuntu
    packet mirrors seem to be having problems, so I wasn't able to get
    past installing dependencies in any jobs. All to say that I couldn't
    verify that this works as expected :/
  - Link to v2: https://patch.msgid.link/20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im

Changes in v2:
  - Use `ret=0; $command || ret=$?` pattern.
  - Restore `echo 0` in SIGPIPE tests.
  - Fix "lib-git-svn.sh" to gracefully handle the case where SVN Perl
    modules aren't installed.
  - Use `|| :` consistently instead of `|| true`.
  - Fix up a couple of tests that fail on FreeBSD 15. The test suite is
    now passing on this system, too.
  - Only enable `set -e` on Bash 5 and newer.
  - Link to v1: https://patch.msgid.link/20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im

Thanks!

Patrick

[1]: <20260325062114.2067946-1-gitster@pobox.com>
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/541
[3]: https://github.com/git/git/pull/2270

---
Patrick Steinhardt (12):
      t: prepare `test_match_signal ()` calls for `set -e`
      t: prepare `test_must_fail ()` for `set -e`
      t: prepare `stop_git_daemon ()` for `set -e`
      t: prepare `git config --unset` calls for `set -e`
      t: prepare conditional test execution for `set -e`
      t: prepare execution of potentially failing commands for `set -e`
      t: prepare `test_when_finished ()`/`test_atexit()` for `set -e`
      t0008: silence error in subshell when using `grep -v`
      t1301: don't fail in case setfacl(1) doesn't exist or fails
      t6002: fix use of `expr` with `set -e`
      t9902: fix use of `read` with `set -e`
      t: detect errors outside of test cases

 ci/run-build-and-tests.sh          |  6 ++++++
 t/lib-git-daemon.sh                |  8 +++++---
 t/lib-git-svn.sh                   |  7 +++----
 t/lib-httpd.sh                     |  3 +--
 t/t0005-signals.sh                 |  4 ++--
 t/t0008-ignores.sh                 |  4 ++--
 t/t1301-shared-repo.sh             |  2 +-
 t/t3600-rm.sh                      |  2 +-
 t/t3901-i18n-patch.sh              |  3 ++-
 t/t4032-diff-inter-hunk-context.sh | 14 ++++++++------
 t/t5000-tar-tree.sh                |  4 ++--
 t/t6002-rev-list-bisect.sh         | 17 ++++++++++-------
 t/t7422-submodule-output.sh        |  2 +-
 t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
 t/t7508-status.sh                  |  4 ++--
 t/t9138-git-svn-authors-prog.sh    |  4 ++--
 t/t9200-git-cvsexportcommit.sh     |  3 +--
 t/t9400-git-cvsserver-server.sh    |  5 +++--
 t/t9401-git-cvsserver-crlf.sh      |  4 ++--
 t/t9402-git-cvsserver-refs.sh      |  4 ++--
 t/t9902-completion.sh              |  6 ++----
 t/test-lib-functions.sh            | 12 ++++++------
 t/test-lib.sh                      | 35 +++++++++++++++++++++++++++++++----
 23 files changed, 108 insertions(+), 69 deletions(-)

Range-diff versus v5:

 1:  a7fd95c0f8 =  1:  e619a6f565 t: prepare `test_match_signal ()` calls for `set -e`
 2:  1edfada458 =  2:  9002a8e77e t: prepare `test_must_fail ()` for `set -e`
 3:  9c703ea3ec =  3:  b375926fc4 t: prepare `stop_git_daemon ()` for `set -e`
 4:  855707f648 =  4:  0d46e4212e t: prepare `git config --unset` calls for `set -e`
 5:  e24c272d06 =  5:  5bdb1ad025 t: prepare conditional test execution for `set -e`
 6:  dd89a14595 !  6:  7654824960 t: prepare execution of potentially failing commands for `set -e`
    @@ t/lib-httpd.sh: start_httpd() {
      		cat "$HTTPD_ROOT_PATH"/error.log >&4 2>/dev/null
      		test_skip_or_die GIT_TEST_HTTPD "web server setup failed"
     
    - ## t/t1410-reflog.sh ##
    -@@ t/t1410-reflog.sh: check_have () {
    - }
    - 
    - check_fsck () {
    --	git fsck --full >fsck.output
    -+	git fsck --full >fsck.output || true
    - 	case "$1" in
    - 	'')
    - 		test_must_be_empty fsck.output ;;
    -
      ## t/t3901-i18n-patch.sh ##
     @@ t/t3901-i18n-patch.sh: check_encoding () {
      		8859)
 7:  dfcbb1ed20 =  7:  8f5ee3234a t: prepare `test_when_finished ()`/`test_atexit()` for `set -e`
 8:  cef0ff3bf9 =  8:  46b4ddf1fc t0008: silence error in subshell when using `grep -v`
 9:  f0e43f0f54 =  9:  6e21a1af73 t1301: don't fail in case setfacl(1) doesn't exist or fails
10:  b61761cfdb = 10:  c1c907187f t6002: fix use of `expr` with `set -e`
11:  591e53ab47 = 11:  b6df934d90 t9902: fix use of `read` with `set -e`
12:  dd7a68c141 = 12:  60681e8ebe t: detect errors outside of test cases

---
base-commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
change-id: 20260410-b4-pks-tests-with-set-e-3ae479b24b51

