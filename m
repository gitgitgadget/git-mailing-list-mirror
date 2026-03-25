Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB373233ED
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466845; cv=none; b=WvAbdhNSjcy7onHSfIUDPmk0Ey/mW86ASta7sW3sZguV2U/C6ZCVNSO6KNy1pTmWvtZW4n/2iPBRbIhPG19j2QqLFM7m03Zqn8A3C1KBBGlgWN3HnKjUsh89chsJ3f1O7Yj03FUYtoetTieaBMiA+Gby2ooXBukhCLYdQ7vj3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466845; c=relaxed/simple;
	bh=3sx634dGJ27SfQBba6PrWq3INLDv3cK83liWuNVYsv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WAwEx18A6lFC8Db5hmM6HNVhatljUKSblNibrjWrZyh2H2L7bZXwnb2MaqsYj3GS5ZId56w1RwIpEWxbNe8SPPCzdiAmlZyneg+G4wgvwJrIoRZxonG8aGL9xPQXHK3sJl7VnxNNDxSqU9YUGXHVYawY/cwvQFik8mkMRDlLptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EvdXE0by; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0are6MHU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EvdXE0by";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0are6MHU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFF2614001A4;
	Wed, 25 Mar 2026 15:27:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 25 Mar 2026 15:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774466842;
	 x=1774553242; bh=bMiKaQXPQH4Sppc2ZnYOcbyteOTm6Bkl/TUgopOAIWk=; b=
	EvdXE0byu0alv2uV6M0f8yFSx2DH2NdJNvKBk1tThpVzMPDD+vGTGOQaX8PisIPW
	3uTCMoFkavrLsTqtph658T6Y/s5L/YUDm0++NhWiQI5A9svIjh1qmEqBxrhP08Y+
	UmMjDMT1Yt74mohRvBvM/Y1YXIbOVGbkvpgprHlUJCrYNIauzENhcIV0BoACwRj8
	WdvQyonqKnp3BuQ0FnzTpPIdZond0mH3AqTHiTa0Rj1D7QFXichkr5kEvZXhVTEd
	XY2MBhZM+PU0JI0/EvqljwoKLBp44z2WG60bN5QKB5clwsMPTPBJg4g1J4g6QM5S
	V6OEEl+c0apewcjEielS4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774466842; x=
	1774553242; bh=bMiKaQXPQH4Sppc2ZnYOcbyteOTm6Bkl/TUgopOAIWk=; b=0
	are6MHUOBw7Ro357bDC4HpoaMuS1gvPjosniyC2EcApjUhf63CyD7JvOb4fuUANt
	Fv9vaC7J8ar7lzZJS03VB2cJB/9gX/Da5XZplbdNMSgoWOh1Wya+m6SdEc+OWx0l
	BU1GrZgF656Ua6c/CrqDATjcz+sdMJQEC0GdNEAebEpEmrZ4Rsea29zRzNcDynfa
	nXajOSlpoqM0mzCvgjGLotHKVj93nuIi8ZoCTovm89AKAsJRGRtGWmEmpinQ9V1x
	OXOKRQLXucyPZcmvsQ4zDEbmFfKZzxv35Gzg+8QgrzNQ+n0BtZh39mF7Dm59RuLv
	6ArYnBzpXy4DszAYtuBpw==
X-ME-Sender: <xms:GjfEaTjivLM9DIcQ8sKV4ON8v_JtsMfssh9eHlZSBVxhatd7dF7ADA>
    <xme:GjfEaXBiebnwGGBjFx7FdZ-jSbnWNz1EK1pgOcednTe3xI5k_dn_pwWOcNFDNNYiv
    x0sf_JKtHdVLKTY9dgbkcaqpTXdkcusxZpXkzPAMEAoL_s8Kywu1g>
X-ME-Received: <xmr:GjfEaYGXSVRn5qKwAe55zzrmBlNE8nVQgv6Oxoblg6HSg-U1aSB7Hc55rfwI7ytNwoobdrvQNvCFUPTLNrpCfHV7yJ2v7SqhwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrgihvghshhgurghgrgelleesghhmrghilhdrtg
    homhdprhgtphhtthhopegrfedvtdehudehfeegudeisehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GjfEafJ1f2MEEXRSpvBfd3N0KJTw03QmGZWxqLvLegCn4-GBHV9IUg>
    <xmx:GjfEacnZlSXstWfqOoIcdmhQBxujHOZm1pWPSb7tFgdsYraM1Io_cg>
    <xmx:GjfEaXSeWgQTe-E2b3W56PkGCu64N1NmKvdl4065N7iKb0zt0IbfsQ>
    <xmx:GjfEaeLCzHdbN4gqPq00V1-XIpR2EDjWJKdKqRP6VA1DUQWqq242Zw>
    <xmx:GjfEafnI46e5N-jjsRmVFThYGmhIlq5iD9Jm6ZnYSiloXIzgFkfw7qKF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 15:27:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jayesh Daga <jayeshdaga99@gmail.com>
Cc: a3205153416@gmail.com,  git@vger.kernel.org
Subject: Re: [PATCH v5] tests: use test_path_is_missing instead of '! test -f'
In-Reply-To: <20260325174431.73101-4-jayeshdaga99@gmail.com> (Jayesh Daga's
	message of "Wed, 25 Mar 2026 17:44:33 +0000")
References: <8dcc9e74-80a9-4963-aa9b-56f28e5edf45@gmail.com>
	<20260325174431.73101-4-jayeshdaga99@gmail.com>
Date: Wed, 25 Mar 2026 12:27:21 -0700
Message-ID: <xmqqecl7u2ue.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jayesh Daga <jayeshdaga99@gmail.com> writes:

> Replace a raw '! test -f' check with test_path_is_missing.

Did you already say that on the commit title?

> The test_path_is_missing helper integrates with Git’s test
> framework and produces clearer failure output.
>
> In contrast,
> a plain shell '! test -f' check only reports a generic failure
> status, which makes it harder to understand whether the file
> unexpectedly exists or if another issue caused the test to fail.

"clearer" probably is not clear enough, but don't add more words on
it.

The problem with using "test", whether negated or not, is that they
*silently* succeed or fail.  Take a typical test that does a bunch
of things like this ...

	do something &&
	do something else &&
	test -f this_must_be_a_file &&
	test ! -e this_must_not_exist &&
	do yet another thing &&
	! test -d this_should_not_be_a_directory

... and expects all of them to succeed.  If it fails in one of the
steps, it is impossible to see from the test output, even when you
are running with the "-v" option , e.g., "sh t/0601-*.sh -v", where
in the sequence it failed.  Maybe "do something" and "do something
else" shows different messages so you can tell these two steps
succeeded, but did the test fail because this_must_be_a_file did not
exist, or was it because a filesystem entity this_must_not_exist
existed?

Our test helpers improve by being loud when the expectation is not
met.  When "test ! -e this_must_not_exist" is rewritten with
"test_path_is_missing this_must_not_exist", and when that thing is
missing from the filesystem, test_path_is_missing will succeed
silently.  But whe it exists, it loudly reports "We did not want to
see it, but it exists!", when it fails.

    Using plain "test" commands in a series of tests concatenated
    with && makes it hard to tell from the failure output which one
    of the steps failed, since "test" silently succeeds and fails.

    In this partciular instance, we expect that ".git/refs/heads/f"
    should no longer exist in the filesystem.  test_path_is_missing
    helper function silently succeeds, as does "! test -f", when it
    finds that the file is not there, but it will loudly report when
    the file exists, contrary to our expectation, which makes it
    easier to debug a test failure.

or something like that.

> It also avoids relying on negated shell conditions, making the
> test easier to read and understand.

It is not a single test being "hard to understand".  As a developer,
you are expected to know what "! test -f .git/refs/heads/f" expects
(i.e., it does not want to see a file there).


> Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
> ---
> v5:
> - Clarify rationale for using test helper
> - Explain diagnostic improvement and negation issues
> - Address review comments on vague wording
>
> v4:
> - Correct commit message to match actual change
> - Improve rationale (diagnostics, consistency)
> - Move version notes below '---'
> - Fix author name to match sign-off
>
> v3:
> - Fix commit message wording
> ---
>  t/pack-refs-tests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
> index 2fdaccb6c7..4a85d96c6b 100644
> --- a/t/pack-refs-tests.sh
> +++ b/t/pack-refs-tests.sh
> @@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
>  test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
>  	git branch f &&
>  	git ${pack_refs} --all --prune &&
> -	! test -f .git/refs/heads/f
> +	test_path_is_missing .git/refs/heads/f
>  '
>  
>  test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
