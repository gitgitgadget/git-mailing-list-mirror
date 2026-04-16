Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351F3914E5
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338369; cv=none; b=O/dL/2vrekpUV+UXGW8PVbwkHTJOfLlhA27/ZdWsYa5IHbed7LMpmoydQmARuvuh2ahek9qCWz7S6jqMINenNbR27Vb7L4d7MosrxRj+Y0vrTL1DnLptSd55bIrvgmCvgp7wiJYgrJDa7HJ84Y5nkHWroMLlnbo81bd7UWE0nDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338369; c=relaxed/simple;
	bh=QTkK1Bau4SIYVu6mZih7XICvq7Fv2eGxOA6tw0AEBaU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=X62s6aggtzk89I0X3qCcrhofkkOer6+Hm7RgK4nRPL8IYU0s4ZEuKzTWAk9H/6kdDlpWgO3dmQQHJx/fC1CvhElmlKRxri3gSu8SmxiX272wp2vQoi2WlAVCabEqGXghL8SinjFUHVVnr1MuMPyuZeDOtBy8w/hqRopMu8oMRC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zZ37/y+j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=auXMVQIa; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zZ37/y+j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="auXMVQIa"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DE5891D00226;
	Thu, 16 Apr 2026 07:19:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 07:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338366;
	 x=1776424766; bh=kLcsSsavH+Ub36IYyeXnUNI1PU26f4v0FoFJtZhEE2Q=; b=
	zZ37/y+jtPaDAfQFWDpAvsirTyAuhj576cj90amWKevVGt+AqWIqjwB/1v+KvEfU
	+IqvJty1JRW90mNm7fLiYNfdZx6G4JXpp1Y4TuCGmmbH8figuioydxGeUT/LsPk7
	L+RhLfEY9icCzKUPwG2Yt7PRmpWJsMWqJLWv1V0zRueFaSb1TnAG3kCsVmDps9gk
	JyiJb5r2/esPwj6Bt4/V4oA4tg9ixIGVViAdQBtykBDThfHiY+rIukIjAkhKIg+p
	EZgAVxWO5XKUxvRFJ5jukTUUvDAmYIF4GHrB8dzLItMCXyCACdjEcNTaq1pNi7fU
	2uoVa6oJBDrff7S/a/N1mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338366; x=
	1776424766; bh=kLcsSsavH+Ub36IYyeXnUNI1PU26f4v0FoFJtZhEE2Q=; b=a
	uXMVQIaw6x5YBEfDER0h+XdX5WlKnZqSbo/WH77ciVv0tUs8TYLKCAp+NDQ7JbxY
	52B06qFJCQivJjjIt2A4AyTDv4tIFsjN411RscHzsokUm57bc874LbCLe3yycPyo
	N8gB/brycP7XDumxvkhqQ5OuJyx621gqdniMNxIldX+gDSCMY7sVQmbrgfcBI+km
	1AFSoYyjddaJYseAAcVsbXSU5Iq2tZiwyyh4klpq1Vy9hPV7xOD8oUrW8R3o/WZm
	/+A9e1i4BNaXSpLsEyV3IjwWYEudz5KdJ5qkHpnjuGWAFKthgo55BSLgUWpr2eIE
	IbUIXsCJlN4wETLxSrQDA==
X-ME-Sender: <xms:vsXgaanwnoSbvyxKf1e1gHj562wfTf5cTVpG5UiPNmnBAj_pwmdMQg>
    <xme:vsXgaZRFgl9K9FKMWYQ_gV9vKtgZ1ZJi5wUs07yGoy7dUD-33DAiZ-ertkJAtdB0W
    xQza1ea53IE1G6BCqAUDE6L3_J5DnZWK956QagGbWCqIgILVRHzyQ>
X-ME-Received: <xmr:vsXgaWCg6GWGK0p6dJBScj3b6ZDnBRJ-gaIhGPKrFP9RJkVkI9FBsw5MkGbRmd5BHqkUgDhCQQ8CcsKo3G6Cz4ttssPi4a2w1a3WPTxhRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvleetjeeggfdvfeeutdejfeejhfehteeuje
    dvkeffiefgleffgfeijeeiteekleenucffohhmrghinhepmhhsghhiugdrlhhinhhkpdhg
    ihhtlhgrsgdrtghomhdpghhithhhuhgsrdgtohhmpdhhthhtphgurdhshhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vsXgaYQMbWUrXGOPWFOhBP17SU361ODKK-ZBlV318JmIp4Z4o9EJqQ>
    <xmx:vsXgacpnvpQtns09sxyUuv6hnxWfr3M__mwN8x93Box7YuL7oJRDpA>
    <xmx:vsXgaSwuG0sAjIWwQrkJFLyZuGeUU3ysbPunJrmr9Zh2bR2lrJxATg>
    <xmx:vsXgaZI6cYxfo5OEhdrrcrxlwTIM6X6VaWDYmfUkkdYVPrY4TV_krg>
    <xmx:vsXgaWA-pCo5s_6zXJrrP9-41pm6biK3h3rK5uhBuvY3EhlxN26Uu_ms>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:19:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6bc9194 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:19:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/12] t: detect errors outside of test cases
Date: Thu, 16 Apr 2026 13:19:17 +0200
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALXF4GkC/3WNyw6CMBBFf4V07Zg+ebjyP4wLioNUIxCmoobw7
 7YYjRuWNzn3nIkRDg6J7ZKJDTg6cl0bhtokrGrK9ozgTmEzyWXKteBgNfRXAo/kCR7ON0DoAUG
 VqLPCSm2NYOHdD1i752I+HD+b7vaClY+6SDSOfDe8lvQoIvetqNXKKICDsbnKUlVyzPU+YFt3Y
 zExyn+JWZfIINGoC67LIq2F+UnmeX4DEcgCtxIBAAA=
X-Change-ID: 20260410-b4-pks-tests-with-set-e-3ae479b24b51
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
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

 ci/run-build-and-tests.sh          |  5 +++++
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
 t/t9902-completion.sh              |  2 +-
 t/test-lib-functions.sh            | 12 ++++++------
 t/test-lib.sh                      | 19 +++++++++++++++----
 23 files changed, 90 insertions(+), 66 deletions(-)

Range-diff versus v2:

 1:  5685131f51 =  1:  97c51d03f7 t: prepare `test_match_signal ()` calls for `set -e`
 2:  7459f569ee =  2:  e1e2f83d1d t: prepare `test_must_fail ()` for `set -e`
 3:  4077ee4b7f =  3:  441444895e t: prepare `stop_git_daemon ()` for `set -e`
 4:  095c9b5b38 =  4:  5084b4627a t: prepare `git config --unset` calls for `set -e`
 5:  0cdf15d405 =  5:  4608aef6ee t: prepare conditional test execution for `set -e`
 6:  12f85b2c18 =  6:  9f10b21410 t: prepare execution of potentially failing commands for `set -e`
 7:  50dc57081d =  7:  c9584e9b56 t: prepare `test_when_finished ()`/`test_atexit()` for `set -e`
 8:  e223383e82 =  8:  778a555bb2 t0008: silence error in subshell when using `grep -v`
 9:  ad084a9d37 =  9:  ba4b513722 t1301: don't fail in case setfacl(1) doesn't exist or fails
10:  39a01a5e06 = 10:  5f5db73fdb t6002: fix use of `expr` with `set -e`
11:  060d094d3f = 11:  03d0e9c089 t9902: fix use of `read` with `set -e`
12:  73a21590b1 ! 12:  bd300ab2f8 t: detect errors outside of test cases
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## ci/run-build-and-tests.sh ##
    +@@ ci/run-build-and-tests.sh: fedora-breaking-changes-musl|linux-breaking-changes)
    + 	MESONFLAGS="$MESONFLAGS -Drust=enabled"
    + 	;;
    + linux-TEST-vars)
    ++	# Ubuntu uses Dash by default, but we only enable use of `set -e`
    ++	# when using Bash 5+. Ensure that we have at least one CI job that uses
    ++	# it.
    ++	export TEST_SHELL_PATH=/usr/bin/bash
    ++
    + 	export OPENSSL_SHA1_UNSAFE=YesPlease
    + 	export GIT_TEST_SPLIT_INDEX=yes
    + 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
    +
      ## t/test-lib.sh ##
     @@
      # You should have received a copy of the GNU General Public License

---
base-commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
change-id: 20260410-b4-pks-tests-with-set-e-3ae479b24b51

