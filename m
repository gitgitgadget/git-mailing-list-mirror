Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2622928507B
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264945; cv=none; b=ggPQbpVxbJ3Vy04T7DVI36jmdMBfi9EgpfQKe2S+KGdjl4e/8uOIF8eNXU8Kkl0Kdvv/xtJqUSwlGy/dCG+2URorchRsbNfYEiYsKOpsyRpKyEcRX0mUWS4JcsEPLC/lbKfloPk1uWeYRaqcyoiWdLl7Z3cjxflVOCAnKvhBwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264945; c=relaxed/simple;
	bh=jOq0K4pBbDotm3Fc4e/GXZxR+C8yCuqrNSIxSWy+Nr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fA9cLtc1Ac71V/y1aXm3IhJsWzf+BTT+X4YC5BsSTmf0k/mKvatgG1SiuB8ebK1l6RlFLyA6Bw3mQ4sVqRr2SyKA/Xqy1szP4ljStkh5Cp9emc8xe+cHB9dxkU51SqmFQYdBRqkEuAgUFchlcPlpBx7D5aHggAkaryKJDyxncT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hy6sp1Bx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3MWsSjAC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hy6sp1Bx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3MWsSjAC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A26E7A019B;
	Wed, 11 Mar 2026 17:35:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 17:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1773264943; x=1773351343; bh=1V13OF2Svg4UJ2L0+TyC5eKdjVWXeOiB
	25GBEk1hIRw=; b=hy6sp1BxB+w3yadujeZfQiQMFeiJvBI99EpDv/3Pd/Dd9YU8
	szOfVY8RJyndLCaBh19iM4qu13azQyYD7ikB0RvDoCc8axfnDA8UUbjTCGWcI5n2
	Flmz4xknhUVAA6VC/nTKtbURxAJ77oO+VMPnBlfdNFwE9bEOeQyOQg9+ZP6BXROT
	trseJEFqyqsdvpWD7k6+CUMziVUQNvAgykghsQDX2F90q/9lSxx4N9Fi1ThYhn9C
	T28cnXMLx6l3Zn3jy0WmboDx/3snhGkfJTvqOJ+VTRuKltw+M6yhF7QRKKSdRYRI
	vrQK7Umsekons2K2N1dDdiPEMFCIJMl8oOFs3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773264943; x=
	1773351343; bh=1V13OF2Svg4UJ2L0+TyC5eKdjVWXeOiB25GBEk1hIRw=; b=3
	MWsSjACcNCbaDGU3fDOIXFRQFenWTmn/xWFQoIsI6wl9b2N4HDj8wm9CmKb6XDiY
	pUkJ3RiQZgvxjH8ecHmi/aDZlgZ2kZCG42TxgniONWw4F7Hcbod3LZyHxR1TtyWA
	ZmBNjgdiX/UDZlefKdN8On7AVxH0vGL9WHEAXIXG5YvfSgpB2SthvaFTXMAr986K
	fxJmsb5++UM+HwDZDtRn1I9EHXVsx9Ftv6dh64wIetdeI5Xo4K+W+Db+9uK2wR56
	CQqBGRuXUK5Jo1ZaTj8cQrAqyV9jXa8NLCAmx5fnEAgax2lAVYbYZjgvffZ+6ZEx
	luVHxxKTTEPeZw0kkhImw==
X-ME-Sender: <xms:LuCxaaypabVcz98NJLir_Uz-Mbmwg-oN-DsKluhWj1v7RWPCJXYvuQ>
    <xme:LuCxadKsKtpq_s1Wfup6YiB-CIbw4lPXfW7kv485ENcyqI1s0xPaO7gkLPUAtTmP2
    T_8R7eZFf86rr4GBENM3nJ-lEYZFGbVwcfguEvmyods2kH5r4wrMQ>
X-ME-Received: <xmr:LuCxaUrUGkzW1tzk15Lvnc2cbr6ckrkGG91TFVPby1nfm3CcEtYasl66WbTWTMQTPflYAdLnFdtkKIM65DyBgQdK18fHPv_rsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepjefhgfefvdekfedthfejgeffieevieeifeegueeihfejleeufeffjeetkeffffej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepshiivgguvghrrdguvghv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvg
    gtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LuCxacIJAOh59dfymNbuPr9I480p-1VLchu0degYy7BJhYAqwtDraw>
    <xmx:LuCxaZQwtkBXs2C0Lc2IETMtoS1waSeLUp1TPfleqIdr8BKj_SBniQ>
    <xmx:LuCxabsApGHMIJ05yus3SG3ExOTTQNDKDDJcOr_3mqIVfuMUaBLIyg>
    <xmx:LuCxaaaZGRgEFKIZ9NOdf04Ul-BLiHt0qIgIB6Z5k4bfTmW00Ejv-Q>
    <xmx:L-CxaUhWr8lByYW0VwYaVxrBLVbsu3OAkptWNtfDzQaZG8pUeYWZc6Fw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 17:35:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com> ,
    Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC] t: allow use of "sed -E"
Date: Wed, 11 Mar 2026 14:35:41 -0700
Message-ID: <xmqq5x72m4lu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Since early 2019 with e62e225f (test-lint: only use only sed [-n]
[-e command] [-f command_file], 2019-01-20), we have been trying to
limit the options of "sed" we use in our tests to "-e <pattern>",
"-n", and "-f <file>".

Before the commit, we were trying to reject only "-i" (which is one
of the really-not-portable options), but the commit explicitly
wanted to reject use of "-E" (use ERE instead of BRE).  The commit
cites the then-current POSIX.1 (Issue 7, 2018 edition) to show that
"even recent POSIX does not have it!", but the latest edition (Issue
8) documents "-E" as an option to use ERE.

But that was 7 years ago, and that is a long time for many things to
happen.

Besides, we have been using "sed -E" without the check in question
triggering in one of the scripts since 2022, with 461fec41 (bisect
run: keep some of the post-v2.30.0 output, 2022-11-10).  It was
hidden because the 'E' was squished with another single letter
option.

t/t6030-bisect-porcelain.sh:	sed -En 's/.*(bisect...

This escaped the rather simple pattern used in the checker

    /\bsed\s+-[^efn]\s+/ and err 'sed option not portable...';

because -E did not appear as a singleton.

Let's change the rule to allow the "-E" option, which nobody has
complained against for the past 3 years.  We rewrite our first use
of the "-E" option so that it is caught by the old rule, primarily
because we do not want to teach our mischievous developers how to
smuggle in an unwated option undetected by the test lint.  And at
the same time, loosen the pattern to allow "-E" the same way we
allow "-n" and friends.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 t/check-non-portable-shell.pl | 2 +-
 t/t6030-bisect-porcelain.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git c/t/check-non-portable-shell.pl w/t/check-non-portable-shell.pl
index 6ee7700eb4..dd8af6d08f 100755
--- c/t/check-non-portable-shell.pl
+++ w/t/check-non-portable-shell.pl
@@ -36,7 +36,7 @@ sub err {
 
 	$_ = $line;
 	/\bcp\s+-a/ and err 'cp -a is not portable';
-	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
+	/\bsed\s+-[^Eefn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
diff --git c/t/t6030-bisect-porcelain.sh w/t/t6030-bisect-porcelain.sh
index cdc0270640..1ba9ca219e 100755
--- c/t/t6030-bisect-porcelain.sh
+++ w/t/t6030-bisect-porcelain.sh
@@ -402,7 +402,7 @@ test_expect_success 'git bisect run: negative exit code' "
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	! git bisect run ./fail.sh 2>err &&
-	sed -En 's/.*(bisect.*code) (-?[0-9]+) (from.*)/\1 -1 \3/p' err >actual &&
+	sed -E -n 's/.*(bisect.*code) (-?[0-9]+) (from.*)/\1 -1 \3/p' err >actual &&
 	test_cmp expect actual
 "
 


