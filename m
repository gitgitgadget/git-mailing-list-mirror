Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614118EA8
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056810; cv=none; b=JzygqemcXdk36X9LG5OfQ2EqPKcr0DkmVQBX3U7ITq8cjuKmN/7S7m6ptBLn8S2R602S08n92TM18StoHDQS9Eggr3fzNj9WXzNBVYfJNRh/eSOB5gZVQ8XA5tRe9kInKwbi3DUZOEMb/PzBlnS2dPltc347ahTYNa+hxOSMyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056810; c=relaxed/simple;
	bh=+yo/WKV8R7yCEc/KZUoZeS+lwjYjwG/soy1yais0n5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k7GvLQV7JTDkm02efPxA1RnNEnRAblKyxJWfpZhgfYLCLKnSPDLcr9mFrpafAcsDGFdDmgjhRfiRh2b3Wewihrxrl+Lp8K5PwPGWpoDc6v2BXELRX10waYvGEuc9TTsjwNfm+Qo1Y3whfaECzw2tlKKTQVQrwPHuyBmdg5oZC08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RH7XGhQ/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RH7XGhQ/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D6167218AD;
	Mon, 15 Jul 2024 11:20:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+yo/WKV8R7yCEc/KZUoZeS+lwjYjwG/soy1yai
	s0n5A=; b=RH7XGhQ/ubvpcZMFh/ZLDl8IzVcJNOM4Q7ybFdzRO/8jjTNylni6EC
	cBrk0WkM1IeG+BNJIeVGHn9sCc5iy8uLn5Hn+4oLmE1SaRDeu9e2MGtIdfh1k0GW
	oGF1QqoQpHozMUAcoTQT6FgfdXbhhsQs3IRj1xV1HIqMHn6T2zj3c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C5F4F218AC;
	Mon, 15 Jul 2024 11:20:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 24D7E218A6;
	Mon, 15 Jul 2024 11:20:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: rsbecker@nexbridge.com,  git@vger.kernel.org
Subject: Re: [Test Breakage 2.46.0-rc0] Test t0021.35 fails on NonStop
In-Reply-To: <ZpRKu8Xsz70xNHFp@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 14 Jul 2024 22:01:31 +0000")
References: <024101dad543$221b4ab0$6651e010$@nexbridge.com>
	<xmqq8qy4adl4.fsf@gitster.g>
	<001f01dad5f1$e518e6e0$af4ab4a0$@nexbridge.com>
	<xmqqttgr9aeb.fsf@gitster.g>
	<ZpQVwyVQT8Wf5AeX@tapette.crustytoothpaste.net>
	<004501dad61b$b35b7f30$1a127d90$@nexbridge.com>
	<ZpRKu8Xsz70xNHFp@tapette.crustytoothpaste.net>
Date: Mon, 15 Jul 2024 08:20:03 -0700
Message-ID: <xmqqv8167kd8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B69B21AA-42BD-11EF-83B4-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think we had discussed that you were using AT&T ksh on NonStop, which
> would explain the situation.  That's the most common version of ksh on
> proprietary Unix systems, and you can usually detect it with something
> like this:

What is sad is that we have this as literally the very first thing
in our test suite, as t0000.1, but ...

        try_local_xy () {
                local x="local" y="alsolocal" &&
                echo "$x $y"
        }

        # Check whether the shell supports the "local" keyword. "local" is not
        # POSIX-standard, but it is very widely supported by POSIX-compliant
        # shells, and we rely on it within Git's test framework.
        #
        # If your shell fails this test, the results of other tests may be
        # unreliable. You may wish to report the problem to the Git mailing
        # list <git@vger.kernel.org>, as it could cause us to reconsider
        # relying on "local".
        test_expect_success 'verify that the running shell supports "local"' '
                x="notlocal" &&
                y="alsonotlocal" &&
                echo "local alsolocal" >expected1 &&
                try_local_xy >actual1 &&
                test_cmp expected1 actual1 &&
                echo "notlocal alsonotlocal" >expected2 &&
                echo "$x $y" >actual2 &&
                test_cmp expected2 actual2
        '

... apparently it is just like any other test failure, so unless the
tester is running

	$ shell t0000-basic.sh -i

reading the output, *AND* goes to the test script to read that
comment, the helpful comment can easily be missed.

I am wondering if it is worth doing something like this.


 t/t0000-basic.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git c/t/t0000-basic.sh w/t/t0000-basic.sh
index 98b81e4d63..3cb8243cb4 100755
--- c/t/t0000-basic.sh
+++ w/t/t0000-basic.sh
@@ -34,7 +34,7 @@ try_local_xy () {
 # unreliable. You may wish to report the problem to the Git mailing
 # list <git@vger.kernel.org>, as it could cause us to reconsider
 # relying on "local".
-test_expect_success 'verify that the running shell supports "local"' '
+test_lazy_prereeq WORKING_LOCAL '
 	x="notlocal" &&
 	y="alsonotlocal" &&
 	echo "local alsolocal" >expected1 &&
@@ -45,6 +45,17 @@ test_expect_success 'verify that the running shell supports "local"' '
 	test_cmp expected2 actual2
 '
 
+if ! test_have_prereq WORKING_LOCAL
+then
+	skip_all='
+		Your shell has no working "local", no tests will work.
+		You may wish to report the problem to the Git mailing
+		list <git@vger.kernel.org>, unless it is AT&T ksh,
+		which we know lacks "local".  In the meantime, use
+		shells that support "local", like dash, bash, pdksh...'
+	test_done
+fi
+
 ################################################################
 # git init has been done in an empty repository.
 # make sure it is empty.
