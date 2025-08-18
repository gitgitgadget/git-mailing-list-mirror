Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD872222B6
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755551987; cv=none; b=nPkjlY5KKsAQf6VLx8pOODwojmrnfHETyUYpdz3VJZhjt4OerXJWAx4JAlW2boU7O9e5S6nss2sQYJeADfFE18PAtMvSdfHDzW/G2/u9Eq9cIMJo4F7IcWHOuZiDCzzYKPO4CmKiZQHevMml6lNx6xHtpgDPqMGaWBBrIshz2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755551987; c=relaxed/simple;
	bh=BbAZIJcBQl7GIiWRUxoMgu2kff0hx5nhYPCrJ3GBrRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L1XWClt5qKzQtikzn3T4mQMeTi8ZKgEW0HwnO/jwlnlXJUTnQUMaPB39PffjbpiYgkPkQd9jI63z6o8FAaRZK8XUmmWgWSk5XIIFUSsE4vqsb34TlmCmuVV6IxZdW9BKVpq82fPp3CnBM1UH8KekF2ehX4ZhewVDanky7XysINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aKcwj92E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MH9W/DNj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aKcwj92E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MH9W/DNj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CDFEA7A01A0;
	Mon, 18 Aug 2025 17:19:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 18 Aug 2025 17:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755551984; x=1755638384; bh=Efthlc6cUE
	F3C4CHy+2EnUxYy7jKE0FcDHJFlrdNXfI=; b=aKcwj92EYMXlCSnFr75PmKp4UC
	awoBl/fsp2kO8PJaBM0KC/NiV2jhTf7u9b7lzl3QXl1EHt25VktapN5E6rwHg6oX
	V5F/zLE7WxU9nrdfA0YueDNxnq0wuYs1mx/QQsCJdJhTqwZZ6eAgAqryzsqsnDnf
	yn8qfWmoCwfRthFGe/LmpEwHVR9C7dndJdwOEGOXvG0ymb1rKhNpKHZPR8tMcw3T
	RmMZMwI3GiXOMSohpOcN8ZtUfHu7iAkIjyKbhmEWKMsfc09N/nMM1Pv55/1utyop
	TqNPAOx41cpr2LfEKM/aXRjhzXi7q/QJP1bwpmYAAf65wOjlRVb24/29+V6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755551984; x=1755638384; bh=Efthlc6cUEF3C4CHy+2EnUxYy7jKE0FcDHJ
	FlrdNXfI=; b=MH9W/DNjruGzzsYAwyFROymMyXSHjiS72Zgm0W07a0iuJB3TIx3
	5g8tzuXUkq+B1kczHNMxmlZeMaQsNZEjIEVRdAmn6hSQPJJhoQW3n6v0Krz4EaPR
	fJaBYkGMY/uDqN/KlmXFUW6btWP9NVRMqEIdgYd9BDwm2Xx8WLS7n8fDbk18c+jR
	z2itIe+/ee/xuggA8KzqrFNsO43FFiEh+i3Cdkuf0jg3P2Hx1t17z/LkcZXkx/TZ
	qGmAijx2vzbkVSBHbXAj1ttDDTQEunemt51QLoBmxD9a5utTqb7aB5dKClCKWxw8
	CrE30Ts7p7dgZmmHE4JoamuEl/ZbqjGUyOA==
X-ME-Sender: <xms:75ijaAqEk2s1nI0a3KJif7b-8UVtgY-WKXDGMWbHbTvP2jT_h7AWmg>
    <xme:75ijaEMQ7KYkNyyPeO4lFY_Uk9_dNbgWAOYJFtdwYs40SHzmRVqHD7Evpun5ZkwwI
    RK5hmh-g0iU_A1X1w>
X-ME-Received: <xmr:75ijaLqMks94y2aRQBseE7k4wcvHlfSc7Oy7j2dGnhTFzrrTUg8onF7KSQhzNnVtDiCPgdnfgkB-aZA7PHudU4OUeCB3slFuhmlMtLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheefieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohep
    phhrohhphhgvtghhvghnghesshhtuhdrphhkuhdrvgguuhdrtghnpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:75ijaJfbAVviYogUh5wOy7GN53AGadKoL15rMFuUQOAk9pmJWhBiqw>
    <xmx:75ijaBSJlR5Hc5tD8g5SMhH0UoOXnJoLR1ixQGz2kEAqXhE5yFBHyg>
    <xmx:75ijaCaxHYlK19mPP_1yd6MiBdKXu2QYhCvMy48nMB-b1C-dhqmdtQ>
    <xmx:75ijaEeMPeC6WtJVL3pQg9p2Oc4yPES_yHZL27PaPrWC-gP5EM0vnQ>
    <xmx:8JijaAvbEG2OnuJZRWYUzbA0Ql-kTBy5_9R8PSlGZh4ky-oas9TLERHy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 17:19:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  phillip.wood@dunelm.org.uk,  Cheng
 <prophecheng@stu.pku.edu.cn>,  git@vger.kernel.org
Subject: Re: [PATCH 3/5] describe: catch unborn branch in describe_blob()
In-Reply-To: <20250818210154.GC1024556@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 18 Aug 2025 17:01:54 -0400")
References: <20250818205812.GA1018043@coredump.intra.peff.net>
	<20250818210154.GC1024556@coredump.intra.peff.net>
Date: Mon, 18 Aug 2025 14:19:42 -0700
Message-ID: <xmqqy0rggwep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -518,10 +518,16 @@ static void describe_blob(const struct object_id *oid, struct strbuf *dst)
>  {
>  	struct rev_info revs;
>  	struct strvec args = STRVEC_INIT;
> +	struct object_id head_oid;
>  	struct process_commit_data pcd = { *null_oid(the_hash_algo), oid, dst, &revs};

An unrelated tangent, but it seems that we are copying the object
name for the first member of this struct, even though 1/5 changed
the second one.

> +	if (repo_get_oid(the_repository, "HEAD", &head_oid))
> +		die(_("cannot search for blob '%s' on an unborn branch"),
> +		    oid_to_hex(oid));

Makes sense.  I briefly wondered if there is really a point in doing
the traversal only from HEAD, but this topic is not about enhancing
and making the "describe <blob>" more useful, but it is a strict
improvement.  When you first mentioned "resolve HEAD ourselves", I
somehow expected you to ask the ref subsystem to resolve HEAD, but
this should do fine, thanks to ref_rev_parse_rules[].

> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 470631d17d..feec57bcbc 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -415,6 +415,14 @@ test_expect_success 'describe an unreachable blob' '
>  	test_grep "blob .$blob. not reachable from HEAD" actual
>  '
>  
> +test_expect_success 'describe blob on an unborn branch' '
> +	oldbranch=$(git symbolic-ref HEAD) &&
> +	test_when_finished "git symbolic-ref HEAD $oldbranch" &&
> +	git symbolic-ref HEAD refs/heads/does-not-exist &&
> +	test_must_fail git describe test-blob 2>actual &&
> +	test_grep "cannot search .* on an unborn branch" actual
> +'
> +
>  test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
>  	i=1 &&
>  	while test $i -lt 8000
