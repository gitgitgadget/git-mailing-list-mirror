Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000E3D6F
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276325; cv=none; b=VnCP3BZuJzikhGpjrH3kwuRkPTnwkr0X2dEEFhFhlCuQNdBOiIz+8SsDGhi9dvbnikBZbNYJSynbigFbbmaKccqA5akYuQeYi+YQf/gNosFUp8AAA3hyqIGi3dvppZVbc8NnM6+fSTlN6OHJmL78hnbxbSD4zqlKjq3pCIWdK3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276325; c=relaxed/simple;
	bh=E2Ickp24+hXZvQamrM4hWiul5w0PFzMZkwp4mtDxU00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aO8xSxwlDlAbbXeSQmhivUC1is9ql2eAcPgSlcUmqfa8XoUyPyF74uAFNzrb0UC3xnZIHOvuFb37K6sgI1woIjzm8kurIrMLevkH5zM5PK7Q2jsLOpNx2HuDoAS1amD09jHlOj04qOInEw9j47PQe8KH9YcU4YOmlKWIgdlONks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y5f/CbC0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pkB63h4q; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y5f/CbC0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pkB63h4q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 80A871D0020A;
	Wed, 11 Mar 2026 20:45:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 11 Mar 2026 20:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773276323; x=1773362723; bh=7BSi7gn2hH
	H6lawociVYWNXLcQmKZB47GR2IiF47pSA=; b=Y5f/CbC0o6uMG0VepNg2Z8r7Pm
	PJ5MfuUvANKoNklpWJmN9He7+SmHGoMiQHX3H0Y/FJrFF+l9b7k2HRKH5m7R+VqJ
	+MY6Gvx3YxdiTyVq4V53f94mfUnTtwk8bjSZNr0wAKan49IdaDx8z/hcTyTedbw3
	h9w9T+6wpMyLFC/++09euNYoLMu3jpbHO1uI8RQJSbTlxEBqMhKZl7XXmKKVBLcS
	HbgsBswVhUo9PT6VdyIcAZOS+xM+uyBGj49Sf5DKw0Z6cTJRuXqdXjceerqRxj8H
	CbPQ6FXMX4y8Nx2wTmasNePKoi630hjuMMeW/ezGGNMZp5d9VNPphe2N2s+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773276323; x=1773362723; bh=7BSi7gn2hHH6lawociVYWNXLcQmKZB47GR2
	IiF47pSA=; b=pkB63h4qmK93TSlp2loGjmD4unhJVuxfwxV2Wp33NfidryziL7h
	Yv4EgneDXOX797gyivibRqXbEyMPJtIE/m2gbXdWVGbZs30cxh1PlDnPwukXFcEh
	ws/hGvzho3wE5W11VpeylLhB1+YVio3DwSNcvx6tLoXyHVLlJQRJ0r5ue4/cB1kW
	pajqZu4rW8G8HLNVuSmrlBCG+1e0e0jvfEGrpaPyK5R+EBYTZkxNm29E2xqVLGLD
	ayon4Pawyt9zluk9AXDiSIoTYvEQqS35Z3woJ/BMmJJ9WXWLOTiDSO4TopQ6ZVO3
	cd4gfP77nzlbe//XXK6K9sgFp+fKQfZmICg==
X-ME-Sender: <xms:owyyabRZ2drzLJlrf5eV8WOgyuWqFYtf7fvZL7eiCLalenOypV7BBA>
    <xme:owyyaTrQP1pgLgFGRrziIdnRjMZsoQ_Xja-s3IsURsEZc6rnW5bfWmiSO3BrQnLxu
    c7gSvXZVKOWinQv0zZ6tMt9-glD185kPSvpU7Ewkl_6x-tOL-iE>
X-ME-Received: <xmr:owyyaZJXyqbWD11pqtOf8RxgwLRktLC0k9IPuMirQn64aDHIvec92RppTPUeECkL4_MFnj7aD6uRAsm-xFnlBNvBu8Dnjbkemg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepshiivgguvghrrdgu
    vghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:owyyaWqfDavBecp1pvqqHMIPQWsvpOfjNog4581li4IF5gNOEMDgAg>
    <xmx:owyyaRzZ0ygy_mXr7Cx72m9o3IOS7OIKv01WFgVQOlHr1KwAV64VxQ>
    <xmx:owyyaaPyDinMkN6qmxOG-5R7v-PZHjkHaD3WEduXGm6WfNmGOPvatQ>
    <xmx:owyyaW4J2UflyKl10w_2kZq_N_8tGY7je0yStRFjoKa_7rUZ7yZQaw>
    <xmx:owyyaTCE3VHUTLm-BGC0BYhsCIzQ-iOCEEF94vVLQ8XmYEo9OIZ02jc4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 20:45:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com> ,  Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] t: allow use of "sed -E"
In-Reply-To: <xmqq5x72m4lu.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	11 Mar 2026 14:35:41 -0700")
References: <xmqq5x72m4lu.fsf@gitster.g>
Date: Wed, 11 Mar 2026 17:45:21 -0700
Message-ID: <xmqq3425lvtq.fsf@gitster.g>
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
smuggle in an unwanted option undetected by the test lint.  And at
the same time, loosen the pattern to allow "-E" the same way we
allow "-n" and friends.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/check-non-portable-shell.pl | 2 +-
 t/t6030-bisect-porcelain.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 6ee7700eb4..18d944b810 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -36,7 +36,7 @@ sub err {
 
 	$_ = $line;
 	/\bcp\s+-a/ and err 'cp -a is not portable';
-	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
+	/\bsed\s+-[^Eefn]\s+/ and err 'sed option not portable (use only -E, -n, -e, -f)';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index cdc0270640..1ba9ca219e 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -402,7 +402,7 @@ test_expect_success 'git bisect run: negative exit code' "
 	git bisect good $HASH1 &&
 	git bisect bad $HASH4 &&
 	! git bisect run ./fail.sh 2>err &&
-	sed -En 's/.*(bisect.*code) (-?[0-9]+) (from.*)/\1 -1 \3/p' err >actual &&
+	sed -E -n 's/.*(bisect.*code) (-?[0-9]+) (from.*)/\1 -1 \3/p' err >actual &&
 	test_cmp expect actual
 "
 

Range-diff:
1:  43a56fa521 ! 1:  be430f4eaa t: allow use of "sed -E"
    @@ Commit message
         complained against for the past 3 years.  We rewrite our first use
         of the "-E" option so that it is caught by the old rule, primarily
         because we do not want to teach our mischievous developers how to
    -    smuggle in an unwated option undetected by the test lint.  And at
    +    smuggle in an unwanted option undetected by the test lint.  And at
         the same time, loosen the pattern to allow "-E" the same way we
         allow "-n" and friends.
     
    @@ t/check-non-portable-shell.pl: sub err {
      	$_ = $line;
      	/\bcp\s+-a/ and err 'cp -a is not portable';
     -	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
    -+	/\bsed\s+-[^Eefn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
    ++	/\bsed\s+-[^Eefn]\s+/ and err 'sed option not portable (use only -E, -n, -e, -f)';
      	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
      	/^\s*declare\s+/ and err 'arrays/declare not portable';
      	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
-- 
2.53.0-698-g1cc7e6b802

