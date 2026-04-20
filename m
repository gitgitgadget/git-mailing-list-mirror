Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EE11C84A2
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670049; cv=none; b=TJhwMdiUAQMXuBoomR7Ic8J48eQ7AoAaPnF4cwyKC3hhZ/Nruz0tbNHJiLY0SyDowI2iADdvrXgrGOTp7txqle2nPcqPcMul46ToSI/qTjIdb/gi12QgzqKjDfd8wi+9cGfks5xrHJ6AocddbYhdk1Vs8iNcwVRLDfY4ejUFJbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670049; c=relaxed/simple;
	bh=JI0aO7uNK7v88L/HFLUEu/tERVY1K7z7QxYfZuQyUKM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Oh1ioSbs7oMHCT7Livj79UWKIYPIDjpnAwQfmF8xgoZDff0QAE3pSmFXaASTeVZdtTEGyUP5m9k19c6aax6DgUwIdPBQSdPmy6m/lZTwnWVsoqtnwE39i0mUTAoKTsPboGrRRNOnuADg0JH5+6WQ2XJFXmiDEUDxojXo0jvZytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f3g5BFd2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=faovQrJl; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f3g5BFd2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="faovQrJl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 685A4140007E;
	Mon, 20 Apr 2026 03:27:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 20 Apr 2026 03:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670047;
	 x=1776756447; bh=FbXZET1CRvDTlIes211hicXZ0WyfRmbSibeoYPMejd4=; b=
	f3g5BFd2P7mXrMicDRUWFblm8rxKOYJSJkvTe0duHl1lUprqXzaQIx/uGFN75thb
	6zNKciiMmSm2IhnNkjg8JXPo0w5MK/fUFyzVl6H7MLVZKZ90ZgLODOf9YSkyn4wi
	7r+Zfa1QQJ0C5lSOnuNm/8Q1CCq0NA3K5CpTZilCIGt6GdpBgpCHevY0enS7cuZ6
	NOp7dmwJv0NXMdquvVDeIrRUzLpv7ZDvr+HpJT+y4rj+HhDQoCVCx893AV8PoMP/
	HJ+o9TcgiGdIQqkaCHbCItL06Jp6KUKpBrgyxpXO/dipuALpwHI0gO1JDvpNIKaD
	m14dNXfviYR9MJqYQX05WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670047; x=
	1776756447; bh=FbXZET1CRvDTlIes211hicXZ0WyfRmbSibeoYPMejd4=; b=f
	aovQrJloWLHIwZWuY33pfHvxS08cWH1TcxMA+O9QYdQISieCbJ92BOFtOkDJCM9w
	YjtAxBW86mewWMv76klWbm5kuEjJIL0ektUSrWbZakvU3A01TN+L67B8F2+N0DPv
	84r6MQzKD71/VihG6Xyuvam7ujwK7BXY22D2fZt6hkWrYmtL+5HUjiT6ZGrRaZlZ
	tCX9cUb73KwZpMcHTffoIjymKgh/wLEzToE5xKR7gZqdA6AZvLpRDlRmjR/CvTyO
	DgXmN3jsRV9oC3VZDemT4x4+ZvocyxwAgeZATKfADxzYNa+OUyKlaLRKDG7BIPUt
	qfLS0L3YpbYuF+YU+uuRQ==
X-ME-Sender: <xms:X9XlaSTLjAH8A5S23iBUbAGyniaG3b6h3bflKGYYyg00IbDxfrKvhw>
    <xme:X9XlaeyW0web-hhhZDSwVJ6bHRvnQxV1kyx8oOmlZKfgvrXXAPBH2OHdj0uJ-X6dt
    cg_d4dtudzvfpW-YYIYpNtt1_t616FLof3SpJ8hZRLnNmJWrRFECg>
X-ME-Received: <xmr:X9XlaU1YKabzT3A2pi-1OYxOSU4v6C99AZIcbZ4dc5-ywGWNre9IQ8AuRTWKJf6Vk9GR1KzgKlz1zviLOon-q9oMKWYhIKXed91hjphk1Sgt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvleetjeeggfdvfeeutdejfeejhfehteeuje
    dvkeffiefgleffgfeijeeiteekleenucffohhmrghinhepmhhsghhiugdrlhhinhhkpdhg
    ihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmpdhhthhtphgurdhshhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X9Xlac7UC-vivF5SoNy6xAHwRpNLEcUW-360M9BfPRw5pnrHdoAjjA>
    <xmx:X9XlaXXlYzTYW3MVz7cMCG3hSZw-OVOrYZMofiIwwlKFSzS0Oe7Snw>
    <xmx:X9XlabAeIlvBJlklb8QD5Vk9JUnwZkpP4yVwcdQDH-EF6H2Uxp6TNA>
    <xmx:X9XlaW5EROcRFh8KrNNtolRGJVV2dPLeLKz6-jafKYNYbb1hztwLHg>
    <xmx:X9XlabC_sBj2U35stH0m4bOFqxH7EjgTZnbHmAd33tTylEn6dn-Y78Ya>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3696130 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/12] t: detect errors outside of test cases
Date: Mon, 20 Apr 2026 09:27:19 +0200
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFfV5WkC/3XOy27CMBAF0F9BXjOVH+OEsOI/EAs7njRuxUMZE
 0Ao/16bqlVYZHmlO+fOUzANkVhsV08x0Bg5nk852PVKtL07fRLEkLPQUlcSlQSPcPlmSMSJ4RZ
 TD0wJCIwjrBuv0Vsl8vVloC7eX/L+8Jv56r+oTYUrjT5yOg+P1/SoSu9vxSyujAokWL8xdWWcp
 A3ucu0jHkWZGPUcscuIzggSNhJdU3XKviFmjlTLiMlI7RpJNrStC+ENwTlSLyNYPsGAhrrgOq/
 +kWmafgB5IcMwnAEAAA==
X-Change-ID: 20260410-b4-pks-tests-with-set-e-3ae479b24b51
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

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
 t/t1410-reflog.sh                  |  2 +-
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
 24 files changed, 109 insertions(+), 70 deletions(-)

Range-diff versus v4:

 1:  c6503a6ecc =  1:  9f5238f960 t: prepare `test_match_signal ()` calls for `set -e`
 2:  792e674fe2 =  2:  7c1beb70dc t: prepare `test_must_fail ()` for `set -e`
 3:  106cf12fa0 =  3:  f209a2ecbb t: prepare `stop_git_daemon ()` for `set -e`
 4:  1a5ac9b5d8 =  4:  7b6f7091f8 t: prepare `git config --unset` calls for `set -e`
 5:  ecb6f07131 =  5:  e265d86fa0 t: prepare conditional test execution for `set -e`
 6:  4468b5ef08 !  6:  04978dda41 t: prepare execution of potentially failing commands for `set -e`
    @@ t/lib-httpd.sh: start_httpd() {
      		cat "$HTTPD_ROOT_PATH"/error.log >&4 2>/dev/null
      		test_skip_or_die GIT_TEST_HTTPD "web server setup failed"
     
    + ## t/t1410-reflog.sh ##
    +@@ t/t1410-reflog.sh: check_have () {
    + }
    + 
    + check_fsck () {
    +-	git fsck --full >fsck.output
    ++	git fsck --full >fsck.output || true
    + 	case "$1" in
    + 	'')
    + 		test_must_be_empty fsck.output ;;
    +
      ## t/t3901-i18n-patch.sh ##
     @@ t/t3901-i18n-patch.sh: check_encoding () {
      		8859)
 7:  a188ac9564 =  7:  3c07c82032 t: prepare `test_when_finished ()`/`test_atexit()` for `set -e`
 8:  963b9f4a82 =  8:  43d67af0e5 t0008: silence error in subshell when using `grep -v`
 9:  510d235080 =  9:  822857fd35 t1301: don't fail in case setfacl(1) doesn't exist or fails
10:  550d9042bc = 10:  ad24432195 t6002: fix use of `expr` with `set -e`
11:  9b23e69584 = 11:  88c8b888e1 t9902: fix use of `read` with `set -e`
12:  55fc58c1ec <  -:  ---------- t: detect errors outside of test cases
 -:  ---------- > 12:  0de0c56caa t: detect errors outside of test cases

---
base-commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
change-id: 20260410-b4-pks-tests-with-set-e-3ae479b24b51

