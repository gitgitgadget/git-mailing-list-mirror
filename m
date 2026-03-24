Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C732F749
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372394; cv=none; b=uakRcKgRSlRl/DQbSOKxFbeE6QHzhJcYu5HXySCqDIOefFZFR4fsLihrlnDUzyzoPkHzZOBZ/iZwmNQJrowcerqOpkPDX3k37zZkxIpD2jJ7K7RTD6Ly2e/pCcmie6aY8BGfF+7F3Iw7Av1gB/NVrTUrWDIg8tiKOTXV3vA2yJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372394; c=relaxed/simple;
	bh=1H70o9O3a9vt9eAbAb9KJJGmhI8xvZce+dPF0hSiQSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bu9R8mVcbcexnS58VAafvH5sOcz/84HTxaZal6Sg14Q4M/UGEYG0QWTeIJIS8fnJ8KF3smcV9wub5R43hBrmErhAGh+I3ugNUgR7JXS0kKVwEXcc0Z571Oz7EJPu08DrXu02Q8gZCVSNKJA5Y4NlkbedzLxYfMoX5gvie/v8Tlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DO0H+gaA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xcYAK4kt; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DO0H+gaA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xcYAK4kt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A2D61400053;
	Tue, 24 Mar 2026 13:13:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 24 Mar 2026 13:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774372392; x=1774458792; bh=sh1+2rp0Cq
	Oxa7aDU3ubedhbKTqGnw8JDzAbPhlYItc=; b=DO0H+gaAfXIjvR1ceAppVczZiz
	tliqbCwAubdERrH+r4//tjeCasrzv0buGQcdCIXcVI5N1eYWCYsUQ/kEIvz0FfUp
	oC9JOkmUPehh7jzPUqIuqxWTJLjqIogHxBjKjdi1EOQgHiFXRlLhR7qJCewEA+un
	uGqr24I5wihw7px0ZbByTya9ESoVEdRKBHPfFe4vlBCDKHwvOsXkvkr3OPe3nEU0
	SFVSdVeibJ8LFhvnhHUEEtzn37bUBtE3RvdgWltVL9jA/2hnPrqSPcaoUOl4Obne
	A67GLUWB5zQPHTxVF7sh/ARaMY7HYG7p9oskii0/ynP4WXRwLgZCa92T7gCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774372392; x=1774458792; bh=sh1+2rp0CqOxa7aDU3ubedhbKTqGnw8JDzA
	bPhlYItc=; b=xcYAK4ktYE5RoQSJiwUfmsfGT18XZxKoS+VobBeW5s4Os/Av80/
	rAWYAyVUySbr+yiLeeKaMUHxE4e2B8OqTLiIiNWR3ePXlGxtXjiKndV1VKgl8kQE
	apXMwynTzxDrxBeQF9F95ogrQfGZt3VRZzVipAVs6PAio7tZxLV3r8bFObNqffeH
	LQBxNxmliqaguo7nG7lnwtc70W3SsTid141ZGbvJ0DoiStz3IOyTCzkT15VzRyUq
	JnTVWpVt+t7GohZ8Zd2IWbTEH9ridbL5MBND8FWGLyDqAwDcJfIuEl+4FrLmTG0D
	+PrpIDTAdASJXd0rpeaLfg4L5TaeiOvsWhg==
X-ME-Sender: <xms:KMbCaSaS8b_ntFZwEXqtCgSmyX06CZda7-pgfEHWLFgC_q9GcSBjVw>
    <xme:KMbCacYeYNUNpwSjjrmOmZ1GmFYhgAZVTb8d9RW1yyj2lyhlLlfjWwf0XP6iWZxmZ
    hMfqsKBiU-jiElLTizjqNfRYHEvS_8ZLunDCZ8GNKZumRfk882Tyg>
X-ME-Received: <xmr:KMbCaR8MBbYfMDhqpkAEOrtcbWY1TwWQj6c2lUA0fNFLuONiBugi60wjldBYegjwWmPSsAs1Pt67M5GeLqXnfdT9gq3pg4gnFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhhrohhikhesuggvlhgrhigv
    ugdrshhprggtvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KMbCaTgRvvCKdXZ5a8ZpfGqYrYb08WcyENNGRPU_yPKILB24HO0RYw>
    <xmx:KMbCaZfaRmHGYfrjPk5nQwqpIvdW3fV09yc7yVh53Ikt8GRtmrLzfQ>
    <xmx:KMbCaSoKWdcveD4BzolPKPYk0Pagypb7w6B08LFzfnwPjHcrzEgm4Q>
    <xmx:KMbCaWAjrgJ-SHc2sIexnak8OVOPlolOgMVtPNmA_CRe_nJ1rKP07w>
    <xmx:KMbCaajs0rUvt3H4i1krYgTEkbAxFDo2tI5VSIqKl8to2FJXpRJ3ViHj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 13:13:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Mirko Faina <mroik@delayed.space>
Subject: Re* [PATCH] t4014: fix call to `test_expect_success ()`
In-Reply-To: <xmqqo6kd18sr.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	24 Mar 2026 09:39:16 -0700")
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
	<acKqvI0EhaORjoD7@exploit> <xmqq5x6l2q5y.fsf@gitster.g>
	<acKx6yBi-BWUVJcv@exploit> <xmqqo6kd18sr.fsf@gitster.g>
Date: Tue, 24 Mar 2026 10:13:09 -0700
Message-ID: <xmqqcy0t178a.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I was wondering if we can make the test framework better so that a
> misspelt test_expect_success would cause a louder failure than what
> we have now, which is something like:
>
> 	...
>         ok 5 - check hash-object
>
>         t0002-gitfile.sh: line 46: test_expect_successo: command not found
>         expecting success of 0002.6 'check update-index':
>                 test_path_is_missing "$REAL/index" &&
>         ...
>         ok 13 - enter_repo strict mode
>
>         # passed all 13 test(s)
>         1..13
>
> when I corrupt the 6th test of a random script.
>
>         diff --git i/t/t0002-gitfile.sh w/t/t0002-gitfile.sh
>         index dfbcdddbcc..d65f664914 100755
>         --- i/t/t0002-gitfile.sh
>         +++ w/t/t0002-gitfile.sh
>         @@ -43,7 +43,7 @@ test_expect_success 'check hash-object' '
>                 test_path_is_file "$REAL/objects/$(objpath $SHA)"
>          '
>
>         -test_expect_success 'check cat-file' '
>         +test_expect_successo 'check cat-file' '
>                 git cat-file blob $SHA >actual &&
>                 test_cmp bar actual
>          '
>
> There is no indication of something bad happened, other than
> "command not found" and 13 tests passed instead of 14 the script
> has, which nobody knows.
>
> So, no, it hardly is your fault.
>
> I wonder if the test framework is safe to run with "set -e".

It turns out that the test framework itself is not so clean.  If I
add "set -e" near the beginning of <t/test-lib.sh>, the first
roadblock we hit is this one:

        # It appears that people try to run tests without building...
        GIT_BINARY="${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"
        "$GIT_BINARY" >/dev/null
        if test $? != 1
        then
		... complain that you haven't built and ...
		exit 1
	fi

With "set -e", "$GIT_BINARY" we expect to exit with status 1 (i.e.,
"git<RETURN>" that spits out the list of common commands) as a sign
that we have an instance of Git that we want to test is not even
allowed to do so.  

I did this single liner at the end of <t/test-lib.sh>

         t/test-lib.sh | 2 ++
         1 file changed, 2 insertions(+)

        diff --git c/t/test-lib.sh w/t/test-lib.sh
        index 70fd3e9baf..4a80933487 100644
        --- c/t/test-lib.sh
        +++ w/t/test-lib.sh
        @@ -1971,3 +1971,5 @@ test_lazy_prereq FSMONITOR_DAEMON '
                git version --build-options >output &&
                grep "feature: fsmonitor--daemon" output
         '
        +
        +set -e

and started running "make test".  I see some failures I haven't yet
looked into, but it seems promising.

Fixing all may involve finding and fixing little things like the
attached patch.  I am not sure if this would be a good microproject
canidate for the next year.  There are a handful of them that
multiple students can work on independently, but some of them
require familiarity with the test framework and shell scripting.

I'll stop at marking this #leftoverbits but it probably is not for
microproject.


---- >8 ----
Subject: [PATCH] t4032: make test "set -e" clean

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

A few shell construct used in this test were not ready.  Make them
so.

 * "git config --unset VAR" can fail when VAR is not defined.

 * The author of "test -f X && run test that uses X" written here
   really wanted to say "if file X is there, then run the test", not
   "file X must exist and the test using it must succeed".  The
   proper way to express it is to say "test ! -f X || use X".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4032-diff-inter-hunk-context.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/t/t4032-diff-inter-hunk-context.sh w/t/t4032-diff-inter-hunk-context.sh
index bada0cbd32..efcd863126 100755
--- c/t/t4032-diff-inter-hunk-context.sh
+++ w/t/t4032-diff-inter-hunk-context.sh
@@ -17,7 +17,7 @@ f() {
 
 t() {
 	use_config=
-	git config --unset diff.interHunkContext
+	git config --unset diff.interHunkContext || :
 
 	case $# in
 	4) hunks=$4; cmd="diff -U$3";;
@@ -40,7 +40,7 @@ t() {
 		test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
 	"
 
-	test -f $expected &&
+	test ! -f $expected ||
 	test_expect_success "$label: check output" "
 		git $cmd $file | grep -v '^index ' >actual &&
 		test_cmp $expected actual
