Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040526E6F3
	for <git@vger.kernel.org>; Mon, 25 May 2026 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694289; cv=none; b=VkOo/mjNernXNJRC8H4hfHpEbQe+gX8E551PMeKOCJkBKgZbXPTC1HGomrFdDUxv4q9iTjjtBmEXkLq0a8gn9XU7516Rt1ieG6O7DDDhPmk/CVJSRbff+3bW760Bv2vwUCSpqjnUmnhUyB1RhfNkHrGS/3jYyLXSK0bOSXjcCHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694289; c=relaxed/simple;
	bh=sOkEOAWncYTHjPd6AnbFUhX2jrODjBxA1BpG8u3A1QE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fTchF0tZJ6OjBwRsqgFd1q3Ur6v2S+EReDYZ4zlnL39PCcMf9MFoB9Au070ehEvlJcFGP7IEy0qSoZUtpfLueLvdjyQ0sJ88vb6OnS00nkAzIAKfmRGdWeT/FOQsA5cyDIec/63SO7jySPb5DPcJOL8z/Y20tENjzngJpU3stPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PkO4ylF4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ePcTvD7x; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PkO4ylF4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ePcTvD7x"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 04280EC00B3;
	Mon, 25 May 2026 03:31:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 25 May 2026 03:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779694284; x=1779780684; bh=QciXOjmk/I
	wRNatYdTbicCcWJpurrgdF91CE99tVrRo=; b=PkO4ylF4mksdlM7r2oedNyXPtO
	PVC7pCYJEx6NLS0IsDnq6A8/rBtzGiBwFuYLUJgKg4aRq22n0z9IzWn71njfgwYy
	AmCncGhCL2SClunfFnIawMBacmwWNrerzkeeoJKvqD15/BRDVpLjKdJXPMaQQ3Aa
	5XbHKw7Tw60Z2B9rhrgovYr0rTdzreJdmrYqZx/PHMoh5PmlvpGaBP6XEr695tRL
	mQfOX1FTV2Geds5t+ouUPBh7826p+4veezug517jp5NWr9jkjqb7YL3VAlRwzxaP
	1KS+La/RA5osEPG8fKGR/k9A4UWkNHj8SYAyk0UUxTcsM1SK+C2/XKQE14BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779694284; x=1779780684; bh=QciXOjmk/IwRNatYdTbicCcWJpurrgdF91C
	E99tVrRo=; b=ePcTvD7xXH8iQaci0kD2ceW36fgHoCbtQNdp9Z+5dNzvQ6RyocE
	Z6cujzNJX8CwuO+52NAA4iphnMH4XCcXu94mKvidSVGohsGmmzxHAwIu3mpmIQao
	bpMUflU8mi5Ut/1mUNCNaa5zMCg/o89m0iHvaTFOgAlHoPVM+DJmdG5TUjVvUvov
	sw/yEldISz1UeR1+cMAB2ki61IxlZ1/WLW+o1A1kSAwlS7Fs9AkdS6ASNdcO3E1W
	YX3jiFO3BipwHO0jvRNB1mH+QDDTn3X5R2KWuPy/av2ou3kJwqnywgFH8/af/jjD
	7gmmxYlyWlQybpv9VMYpXKHc0hl8qQOw23w==
X-ME-Sender: <xms:zPoTapb9HNx-k2TUmMaAwqMFCS6Aezmk-PKXdIqKDsGIjVnON54q6A>
    <xme:zPoTahErJC0d2K_hStnzFz-te1DA_XRqqHIW76nGJAYlUYi3ujPCF2aGoC9x-J3gM
    5Ac5S9EzpMb-Z0_aqCHIJ96LvkGjJFWmkkmsEq2bof759tgMaIl>
X-ME-Received: <xmr:zPoTaqJweHBjfKkCCbM5C4hurZjn01ySSU5LLxwXl3juMH2dZOM_GZKidz9DTGBtxZ1mczpYhqPubf3O6N1nRbFn9nFNDpAtwzOj>
X-ME-Proxy-Cause: dmFkZTGZ7n6c0LgcTP4nREecbCooKwix3d+Fidu5St0w5/5TcxiL3gO1/IfUxefrYf9G+v
    IK6HFi/7F8bGf0lpP+nTPE8/PoT3SfX3L07BxpIk8m+uP3LKW2s271Q+uLDDJcN9TBNApv
    0Fku5qpwr3KpenOvVU39zBkLv6BDhuAoVUsuK+g5IRPJs7Ix5/YgIts9EnoRaNpW0I1vI2
    cLHH9/MnT35kZodvRRCP0tx+caM8778M61F43M4rjwbYf20qH625PPbzE/wj/BgebaGc4s
    0QfCGDU3sRcVnrAcGO/FylGXWJJ2hGL1p57l9LDGWf0YsKqzAOyTqGJzWSCRL08hOcM8G2
    e2L67pWw6BOzVfBl9pWPekc9U0QzM8zY/ZEzxysBbx0j2hMWOYD/GzK1GT+pcnPFO3iPDS
    a/TgI90gUW2K9COrkuyiB5rgp39bWPoqH4ry1nexpVnIDqoZrSBoCBO3P9mdyh784uz6vB
    tV0Yt8tHESRo7GgslA0+EkoNeLhd6tcf8xBpV7b2xD76JudH9Yqxy2YFY9jNZlfPNNjVyj
    voRrVC3tZ6mqVLRI2u6MzbLho15Ztwiy6X55vexM3Bk0w13dzH03LDPGfJ0lZxi0x/84J+
    agewiAUPFNQxb5jP6MhIlSeGMtBn714fnstz1F473TkeNZiIrWK1foA+mEBg
X-ME-Proxy: <xmx:zPoTasPgHrydt9TOUE4hAVlnEMEm0lAzUOa6gq9dL5ka_fALulofLw>
    <xmx:zPoTaqlAs5hQWG0byEircBJEqEUX6PuzgiDvhDF2AiFePrAfd453Tw>
    <xmx:zPoTag5Zn8h8mLMBnl6AssS7DurdBAb1qQR7ZPIW5YnkbHClRdGL5w>
    <xmx:zPoTau08UGZlzKDzlzAeU1U5vk3NcBNL3x896b6ydj0v_iJptHoogw>
    <xmx:zPoTajNUZaVnSYtOJsUQ-f04CTQO6zfEi52dVvVwYkq2E-mdf_j_T78R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 03:31:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,  Chen
 Linxuan <me@black-desk.cn>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 0/2] includeIf: add "worktree" condition for matching
 working tree path
In-Reply-To: <20260525-includeif-worktree-v5-0-1efe525d025a@black-desk.cn>
	(Chen Linxuan via's message of "Mon, 25 May 2026 11:20:07 +0800")
References: <20260525-includeif-worktree-v5-0-1efe525d025a@black-desk.cn>
Date: Mon, 25 May 2026 16:31:22 +0900
Message-ID: <xmqqjysseyid.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
writes:

> Changes in v5:
> - Fix Windows CI failure: use `**` glob pattern instead of `/` in the
>   "worktree without repository" tests, since `/` as a path pattern is
>   Unix-specific and does not match Windows paths.

Would it have worked if you used something like "[/\\].path",
instead of "/.path", to cover directory delimiters for both systems?

I am not asking to make further changes.  I am trying to understand
what the extent of the problem was.

There are tons of [includeIf] that spells path patterns with the
assumption that '/' can be used as the directory separator, like
these lines taken from <master:t/t1305-config-include.sh>:

    echo "[includeIf \"gitdir:foo/\"]path=bar" >>.git/config &&
    echo "[includeIf \"gitdir:~/foo/\"]path=bar2" >>.git/config &&
    echo "[includeIf \"gitdir:**/foo/**\"]path=bar3" >>.git/config &&
    echo "[includeIf \"gitdir:./foo/.git\"]path=bar4" >>.gitconfig &&
    echo "[includeIf \"gitdir/i:FOO/\"]path=bar5" >>.git/config &&
    echo "[includeIf \"gitdir:foo/\"]path=bar6" >>.git/config &&
    [includeIf "gitdir:**/foo/**/bar/**"]
    echo "[includeIf \"gitdir:~/foo/\"]path=bar2" >>.git/config &&
    echo "[includeIf \"gitdir:./foo/.git\"]path=bar4" >home/.gitconfig &&
    echo "[includeIf \"gitdir:bar/\"]path=bar7" >>.git/config &&
    echo "[includeIf \"gitdir/i:BAR/\"]path=bar8" >>.git/config &&
    echo "[includeIf \"onbranch:foo-branch\"]path=bar9" >>.git/config &&
    echo "[includeIf \"onbranch:?oo-*/**\"]path=bar10" >>.git/config &&
    echo "[includeIf \"onbranch:foo-dir/\"]path=bar11" >>.git/config &&

and there is none, as far as I can tell, that uses a backslash as
directory separator.

Shoudln't the new worktree location code normalize the pathname
before doing a pattern matching so that it would allow '/'-separated
path pattern to match?

FWIW, here is the diff between v4 and v5.

 t/t1305-config-include.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git c/t/t1305-config-include.sh w/t/t1305-config-include.sh
index 07b6fb649c..25f484eec5 100755
--- c/t/t1305-config-include.sh
+++ w/t/t1305-config-include.sh
@@ -462,6 +462,19 @@ test_expect_success SYMLINKS 'conditional include, worktree resolves symlinks' '
 	)
 '
 
+test_expect_success !CASE_INSENSITIVE_FS 'conditional include, worktree, case sensitive' '
+	git init wt-case &&
+	(
+		cd wt-case &&
+		test_commit initial &&
+		wt_path="$(pwd)" &&
+		wt_upper=$(echo "$wt_path" | tr a-z A-Z) &&
+		echo "[includeIf \"worktree:$wt_upper\"]path=case-inc" >>.git/config &&
+		echo "[test]wtcase=1" >.git/case-inc &&
+		test_must_fail git config test.wtcase
+	)
+'
+
 test_expect_success 'conditional include, worktree, icase' '
 	git init wt-icase &&
 	(
@@ -495,7 +508,7 @@ test_expect_success 'conditional include, worktree does not match in early confi
 
 test_expect_success 'conditional include, worktree without repository' '
 	test_when_finished "rm -f .gitconfig config.inc" &&
-	git config set -f .gitconfig "includeIf.worktree:/.path" config.inc &&
+	git config set -f .gitconfig "includeIf.worktree:**.path" config.inc &&
 	git config set -f config.inc foo.bar baz &&
 	git config get foo.bar &&
 	test_must_fail nongit git config get foo.bar
@@ -503,7 +516,7 @@ test_expect_success 'conditional include, worktree without repository' '
 
 test_expect_success 'conditional include, worktree without repository but explicit nonexistent Git directory' '
 	test_when_finished "rm -f .gitconfig config.inc" &&
-	git config set -f .gitconfig "includeIf.worktree:/.path" config.inc &&
+	git config set -f .gitconfig "includeIf.worktree:**.path" config.inc &&
 	git config set -f config.inc foo.bar baz &&
 	git config get foo.bar &&
 	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
