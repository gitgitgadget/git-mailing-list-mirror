Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F5E27A129
	for <git@vger.kernel.org>; Wed, 28 May 2025 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435230; cv=none; b=ZINU2QdnkwCvA1NvnNmseCdVidQuUgEupwevXC8yBJ9tnH6kRxaS2Sydcu9RqCUNib+R7rYd2owlokLz/GKp/wcBRdc5ceqy/k1Mhybqm2Slj6BKHzLKsMY6WqB/dmE5L21kv2QKPH+mbsLqwvAispp36dhRUb0uPL+qYvYs+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435230; c=relaxed/simple;
	bh=nBybW3Sq8qKgl5aWTv9YQwDqiztxrN7y8KQsCuTHixQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0AVPI68WGlP2MReDDMD1J5KvkNvGze3B8S7sQ1AUvbW3sFbEChKk5UbknFZ8PRAAoTJI7GpJ+/aBoud3jmrZx23aH/MORJixvMSfLDJQEC3c66DyR+t/bV5AaHTSyO29SBitPscBXdT9gif96Whbfsi+DE8z1W5T8q5PXmkX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bNnncrdr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H79FB/Fo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bNnncrdr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H79FB/Fo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E9EE51383AD8;
	Wed, 28 May 2025 08:27:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 28 May 2025 08:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748435227; x=1748521627; bh=5mS44BPbnZ
	H1a514SwWHtrXe6HTHvr9eYUcieR+kWfs=; b=bNnncrdrn4ecgQQmhr0Tx0HT4j
	wN/GC9i7k1a/yJdroOKzb7MBm7aKqRlT5yuuUMlzWPpFIJzYPeTRJIAgJaGUbJkY
	Rlwm+jdXAk99VSpcIgN5NrW2upXe/FuIhM6YiuroEnJIWVo9jw599Pb2GYxtSLcV
	m0BO7TVjeYJKVOA0fOkLHeFaCERbh6+7nujlC8X0E57ngGujuQbu6yQb2zrNZ8Sm
	z7KEzxTxGv7yiBMc0qV7X56W6wJBGzVsPKOGsnYfpdsqMlpiFN3kKLg1YCqQ0P48
	wcZoIYVB8gTI3SbRYVxcudMQicba1pXXl+UhceNwJG9P3o/hjOxytoN33iXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748435227; x=1748521627; bh=5mS44BPbnZH1a514SwWHtrXe6HTHvr9eYUc
	ieR+kWfs=; b=H79FB/FowesuVnSsXZdaTtj0W5BE1RCrKdTcHTJFHSWL7HErIRh
	sF4vL/g4m4jg8ZuDW7ynSibf0OnZlVcOvc1Utb5iOPQqfgRGDh0PiIyMVZSYJYo1
	q/xWUCbgsNEow7vnvOivWGzP2ahbBmDSJrQqebaZIXEhcveGB3PHGopUp5xJ12i9
	eIjrmJ0yv1vjX9JUHEUpC1aofrRMLnaL9q3K3MuBBjFoI+gNIUDOjQIk3JATie2S
	9WouQn7Z1G9xJdD1/so6MRG7WdTq3M8+5gsXhwcT1/CakR5xyyXyrHnX1ufI/jQ+
	Iti8pxZsNzp1aZAG5bH+y3EjuRhn/CZqLcg==
X-ME-Sender: <xms:GwE3aEtpuV5SOPN1mvah7KTzIyNTS7KcvUqEnRChljW0WpQ8zWkJ_w>
    <xme:GwE3aBdTpUwkNywPtvOOwZF_ob20VfIUJnSs2sELK8yLdcMUI-BlxURiv56DAwmIT
    RgHfOYn4OJlZUjU8g>
X-ME-Received: <xmr:GwE3aPxin63Yy_9VAtk9wWlapApTNn7p442qXtGHZXnZzSp2ji7z25ntHnxjNR1GctyfOtMk3Cwfrl4yTUw3ym1uu-gmHFViK94zdY5J0Y4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfedvieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefh
    lefgleehgfefveeuteffudfgheetgfevlefhueeuveeuvdenucffohhmrghinhepghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrghmshgrhi
    esrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GwE3aHP5_iyiVeUB_KC2GHDgdKIEybDVcE1txp6OUoKicoaNejHlAA>
    <xmx:GwE3aE9M9Sh1nUhI3cISPVhdiBQFZv21fUioeGZFGzALMK6CIDXVtw>
    <xmx:GwE3aPUTuy5WcrmaFJEQp7HM8WwIPsHr5LW4xLij9XgokWP5zw4IDw>
    <xmx:GwE3aNcuD0i7zP2D-vnyR-ETkRGPHfdVIL6XeMdJ3sfOwpCVJWFwgA>
    <xmx:GwE3aBGOByDDwoYSjU0krFtUgZIiO_9WlBvpAC0L5wxL44GUpsMHBeKm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 08:27:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1535e3d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 28 May 2025 12:27:05 +0000 (UTC)
Date: Wed, 28 May 2025 14:27:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
Message-ID: <aDcBGIW2dxWxZ2l4@pks.im>
References: <xmqqfrgx8xkw.fsf@gitster.g>
 <aDBH7G-oKKxAXWBp@pks.im>
 <aDCNqRAoGygwnAbq@pks.im>
 <xmqqo6vjz5cn.fsf@gitster.g>
 <57de5690-f683-4e8c-a05d-a91198b352ca@ramsayjones.plus.com>
 <xmqqwma7w29o.fsf@gitster.g>
 <aDRiLdUCEVQHq26z@pks.im>
 <4c06724e-f6dd-46b2-9955-57501f8a4e0c@gentoo.org>
 <aDRzy37ZbH9_Qo5B@pks.im>
 <xmqq34cqqbtk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34cqqbtk.fsf@gitster.g>

On Tue, May 27, 2025 at 09:04:55AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> > I don't think it's inherently a bad thing to fail on unexpected passes.
> >> > After all, it shows that our assumption that the test fails is broken,
> >> > and that we should have a look why that is. But I can see arguments both
> >> > ways.
> >> 
> >> As Phillip noted, treating them as ordinary passes undermines the reason
> >> for having them.
> >
> > Yup, and I tend to agree.
> 
> OK.  So perhaps Make-driven CI jobs also follow suit?  In the same
> run that osx-meson job failed, osx-gcc job notices a passed TODO and
> happily declares "All tests successful.".
> 
> https://github.com/git/git/actions/runs/15221271947/job/42817168362#step:4:1933

prove itself doesn't treat unexpected passes as errors, and I couldn't
find an option to adapt it. We can do something like the below patch,
which makes us fail in case there are any fixed tests. The only downside
is that prove will report test failures like this:

    t1400-update-ref.sh ................................ Dubious, test returned 1 (wstat 256, 0x100)
    All 299 subtests passed
        (1 TODO test unexpectedly succeeded)

It's not great because prove reports it as dubious. But it isn't all
that bad either because we directly mention the unexpected success for
one of the tests.

Patrick

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 16b785f3b91..2b63e1c86ca 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -130,7 +130,7 @@ test_expect_success 'subtest: a failing TODO test' '
 '
 
 test_expect_success 'subtest: a passing TODO test' '
-	write_and_run_sub_test_lib_test passing-todo <<-\EOF &&
+	write_and_run_sub_test_lib_test_err passing-todo <<-\EOF &&
 	test_expect_failure "pretend we have fixed a known breakage" "true"
 	test_done
 	EOF
@@ -142,7 +142,7 @@ test_expect_success 'subtest: a passing TODO test' '
 '
 
 test_expect_success 'subtest: 2 TODO tests, one passin' '
-	write_and_run_sub_test_lib_test partially-passing-todos <<-\EOF &&
+	write_and_run_sub_test_lib_test_err partially-passing-todos <<-\EOF &&
 	test_expect_failure "pretend we have a known breakage" "false"
 	test_expect_success "pretend we have a passing test" "true"
 	test_expect_failure "pretend we have fixed another known breakage" "true"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0a124ffad38..5352209d3e4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1272,7 +1272,14 @@ test_done () {
 
 		check_test_results_san_file_ "$test_failure"
 
-		if test -z "$skip_all" && test -n "$invert_exit_code"
+		if test "$test_fixed" != 0
+		then
+			if test -z "$invert_exit_code"
+			then
+				GIT_EXIT_OK=t
+				exit 1
+			fi
+		elif test -z "$skip_all" && test -n "$invert_exit_code"
 		then
 			say_color warn "# faking up non-zero exit with --invert-exit-code"
 			GIT_EXIT_OK=t

