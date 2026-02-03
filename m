Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF90342144
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770153966; cv=none; b=pFkD6LcKqGTmUtouF7+eGQRzntvrk2YpTDEihjsGS/Bce3LMVYKtPqbR74BHVGqlyhK79h6f0+I2fiFnZGKR5JCs16pVX+hjs49yLNK5UXXKfzt0WIj3tSGKItEwbmte0G3u1jADZFy5GgcT4RvKlzW6E+UfvygNGxqfYplnFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770153966; c=relaxed/simple;
	bh=6ontD1G4omP8z9xp5RUG+ZCQDlNBYbClH5CHOJ6tZ4k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qfFekW82PcIX7Ae2KBStPjF8qJifBrvfJw8PvRNavx7bhO5X4FT4w+9FOUYXCOV+ob1SHLCPCZoj+r2ADm9lMnzXIY7tSQVSkiKm2P+K46p5EMih3464U3B9jY3CiYbJry6ZYJy2CvJolmojUSLnnSu0IvrJE/XDSk/TGLHWZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S+9cMLKH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OGBmVrEN; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S+9cMLKH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OGBmVrEN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 365641D0007D;
	Tue,  3 Feb 2026 16:26:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Feb 2026 16:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770153963; x=1770240363; bh=QKvMy3ErEm
	kF/x74tlPrPqJQQUJOatjK5TMAN3TjGTU=; b=S+9cMLKHn9jkoKEedXaJPd6KsH
	3QOBzqd/9v7c8AUCfE8Lmky9SwOATmn2nbj8nyh4HE0tCI4aIEb10mGgj3FOILcf
	ccghGOoqEYbhTPtIUYoMEp7RyGhsK8z44ZMqY6ud1SEfuQKnqf2pCxbTLDFOyqb/
	S4iFCafvARw31UuRjxiQBXbagsUMqR1GIqFAPZkT1fjriu6l2uOBML5BxhmEClxQ
	YIXKICW8xr9UPoPYxs8YNEqQzjFzUjWIhYVDHfCprt4jZw2gIn5Mds8FaCwiYWYh
	ciXb+e6yaBZpdHoA8eG2yvZRsjtGwov8VZu5yw3XzuC2T4ZOWLOLnXZxIkNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770153963; x=1770240363; bh=QKvMy3ErEmkF/x74tlPrPqJQQUJOatjK5TM
	AN3TjGTU=; b=OGBmVrENEfZ/BSn9V7tH/pUC+Ey5w8+IAIgU/6MCflQhs4z/P7N
	UrwfkYR+gIpxabcCyb1sqsTGzp/5Xqvgc0qsh1CT/Ov0lVQ/cAYO2R4+sJWoNyDt
	+NyBA2W5zlyZ9nKBu/VnMZd9PDAh1xmmxoc0S8Ok1Qwuf8fVAG6E3scJESdouu76
	8NEkgZy7USYx4jFwRJtxGg3nNjAcBoICQGvOTU3CpXSuimpIVx0LZAmDEFxBMI0P
	oZ0qRjCF4lcVJK5ckDPa1Wl6Q8R9Xdb2Hu4GDcrdueV7cHFy2dHBKZdZCAyObDai
	Ype/jv1CZdV2lveOJAs0VmbV1TvxhejoePw==
X-ME-Sender: <xms:6meCaYC6jJbLvFEAP7SxgfUwaz5yInh8F5hvfuayP1Ljbro_h2xuxw>
    <xme:6meCaR9gTClA9LFvQNZwUrvValDem1R54Ll739JghvdsccUldeX_o6USrjMjqbEyg
    26AavXMHvNtZt_FBzs4MCQUIEH2-XXJsew6chBQ9BmklR3JusUqpg>
X-ME-Received: <xmr:6meCaY_P8uYUhxnMcIDtHqVzJsyfG_WO-PCivkX4GR_ypEPd9POXARIv8TOHrnFMoiwDz4UPiIQhB6rAJD4biyuIC9ElGJX62g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffie
    ejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:62eCaYdde743u4Co5-ukR_SN-yxiQbVSu9Bv8vu1-GkcOB3JBqazuw>
    <xmx:62eCaRGYY6UklkC218P0-xBPFviw-kwKtQZipnTUIlP9I5blJhnR9A>
    <xmx:62eCaWeGRN6MUTWDWHvC2OJwYyiClKIH295R3LUhlO4dpJLqoghv8g>
    <xmx:62eCabHNtNpezFGt3C8p2u_cPyesY4fb4ySbPXIhjFHr0o0owTKz2w>
    <xmx:62eCacvQRsbEDTf4zB07i2QMvyVr874Q_k3l8k-rKuZB1LesVXWxKfcj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 16:26:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: Re: [RFH] adding test coverage for contrib/ in CI jobs
In-Reply-To: <xmqqsebhu9nn.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Tue, 03 Feb 2026 07:30:36 -0800")
References: <xmqqh5smdejc.fsf@gitster.g>
	<20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
	<7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
	<xmqqjywuyhu9.fsf@gitster.g> <xmqqsebhu9nn.fsf_-_@gitster.g>
Date: Tue, 03 Feb 2026 13:26:00 -0800
Message-ID: <xmqq7bstsemv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
> Unfortunately, this seems to reveal existing other problems with
> subtree tests (t7900), in addition to diff-highlight tests (t9400)
> in various configurations.
>
>   https://github.com/git/git/actions/runs/21617099884
>
> This CI run is near the tip of 'seen', so there may be breakages
> attributable to new topics in flight, but I suspect that many of
> them are already in 'master', noticed by nobody because nobody ran
> these tests in these configurations (like "breaking changes",
> "sha256", "leaks", "reftable", "asan").

Test that comes with diff-highlight fails WITH_BREAKING_CHANGES CI
job, which has multiple ways to work around.  The easiest one is to
force the branch name that is documented in the comment part of the
test file that illustrates the topology of the history, which is
what I picked.

----- >8 -----
Subject: diff-highlight: allow testing with Git 3.0 breaking changes

The diff-highlight (in contrib/) comes with its own test script,
which relies on the initial branch name being 'master'.  This is not
just encoded in the test logic, but in the illustration in the file
that shows the topology of the history.

Force the initial branch name to 'master' to allow it pass.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git c/contrib/diff-highlight/t/t9400-diff-highlight.sh w/contrib/diff-highlight/t/t9400-diff-highlight.sh
index f6f5195d00..dee296739c 100755
--- c/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ w/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -10,6 +10,8 @@ DIFF_HIGHLIGHT="$CURR_DIR"/../diff-highlight
 CW="$(printf "\033[7m")"	# white
 CR="$(printf "\033[27m")"	# reset
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PERL
