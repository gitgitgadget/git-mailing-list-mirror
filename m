Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80728CF7C
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436368; cv=none; b=C9swu8hk1ZrhHsuUr1Obqkmw+VXpuwzUAL7t9lmzypm0p6r2THgN61R+bBuJPPRucjdoYTwc+UvLII36brtlK24KtXL9NaBMSee4egRHFuFeG5opD2swyWve8aB6F+cRW+u+Q3eB8vNwuYfaFDxZ1uAbUhMcbuqYt6QS0b+B8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436368; c=relaxed/simple;
	bh=yWhr01ykw1b4tno/zkPBR07uV38s/dLmf/exEYF+T4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P3mEO/0n7OHiySxGKP8r4pIROIR7BA4xjaj1zI/6VqNg5WvboEpDbnkDM/AxnjBOx3gxYigktZRpo8udfxE5lj0sEuJc+IF9u+cQkhJDShPqDdLQigR4lMf7/ZDRqNfJ+OQksXSJFS1YspO+jfZceu3k3af28pPGpHStYzBTzpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=njhP1QI7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rJQ/5VJH; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="njhP1QI7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rJQ/5VJH"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CDA2E13801B8;
	Wed, 23 Apr 2025 15:26:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 23 Apr 2025 15:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745436364; x=1745522764; bh=sLyuTDBWY6
	73osTNN1oj5M8uSlvolFA87K6K84HXENI=; b=njhP1QI76tf9rQXnc+K4LJoPCp
	yDFyl/Wf2YZmUkpVoigATQMULtToxv3LDgGCojDwRU9dvjiG+wtjHjniwFgXfbSR
	KhARJf/jxqlZyGQAK18AnwOhk7MJTjR6UAPePay5zgEj1urtWo1fGod3TzARai8A
	L+BR5liUIEnIbr0kxDe3SwAMM0Q6RcN4YEeStDONJjRvlg8gDscyVLhRT1l4AMjp
	ZyZRXBV0FhssHiysxtfmPkq7PKWsFDIzUN7sv66SzH3E/eVBlJBpFptj/iA9T8ZR
	5Ve4ghZF2Qlmqjt6GOWfiCFt/4940GmoYZRrxDkn29MtQgFjb1GR9JCZDvDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745436364; x=1745522764; bh=sLyuTDBWY673osTNN1oj5M8uSlvolFA87K6
	K84HXENI=; b=rJQ/5VJHYgoZ+NgN7to2FOdtTKHLOu9myGQn7hACO6nxwxCd21t
	5jQKj8YvNBNLd446bpRPsiYlE0X+sl7YLGWcLsf2o9AFplfpsYVlvuAqz0lMslHX
	sA0aNQPPbTFiTT5jgKmWWuNG7LuURJ4Px/W37E3tVNyBS6ViNIho9hXzWTZAVcVn
	VQdySZrSVgSRfnDc2ITzZHAsv0AAJpmRmGaRDU1xAmv7HO2/jTnWQiMyonj80d+N
	6Jeele7mSdXYtkLssF8h6ohCUbJP1itCNNPTDcBYRzu+ZYu4ukonhrTKzNKkZPYb
	djT3BajfUJedqIYmdyBjMOMNm4JAz0tCAWQ==
X-ME-Sender: <xms:zD4JaHxohOdVSC_FHPmLX-7JU7VTRfkzABNjHdcvwehigDY_cBOH2w>
    <xme:zD4JaPQAhqs44vV5E7FF2oVs-aQ3Si1DjPO4iOne8OLq6t6PDNlp7U6wz7DZ1EuTy
    g-JqEzuhRtgeSEahg>
X-ME-Received: <xmr:zD4JaBX4Od1kTq8Idc5ih4ZV8MKskg1uzHWzbRy1qHt52SSfEjXMK1NKMNn3cDkp_fbkpfXc6MTbABS9JV0-vv0hECxIWmRjMEBm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:zD4JaBjr0HSA7etrPmJcRP1_2O6nq3kk0gh3l_7NSw9HmNab5iEVeA>
    <xmx:zD4JaJBtjzbWVRhhqfylbk2YvsZmZ-7LfcEml8X51usu1qDXD12-kg>
    <xmx:zD4JaKKiJ3lNYLI0LIVZyJ37V_bD1qvhbJVHXTJjJZEflmVenwPeJA>
    <xmx:zD4JaIBc8w1UYuaQdne8J_IJpyISzvBsoa9EcANULfTh8rODf9mXuw>
    <xmx:zD4JaJfSLRNjWRg2GyhoWrKOmQTUgT5tFRCv3xsXgAnZhCN-dzOdbLKw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 15:26:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
In-Reply-To: <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 23 Apr 2025
	17:40:02 +0000")
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
	<5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 12:26:02 -0700
Message-ID: <xmqqmsc6y911.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> When trying to demonstrate certain behavior in tests, it can be helpful
> to create packfiles that have specific delta structures. 'git
> pack-objects' uses various algorithms to select deltas based on their
> compression rates, but that does not always demonstrate all possible
> packfile shapes. This becomes especially important when wanting to test
> 'git index-pack' and its ability to parse certain pack shapes.
>
> We have prior art in t/lib-pack.sh, where certain delta structures are
> produced by manually writing certain opaque pack contents. However,
> producing these script updates is cumbersome and difficult to do as a
> contributor.
>
> Instead, create a new test-tool, 'test-tool pack-deltas', that reads a
> list of instructions for which objects to include in a packfile and how
> those objects should be written in delta form.
>
> At the moment, this only supports REF_DELTAs as those are the kinds of
> deltas needed to exercise a bug in 'git index-pack'.

Wonderful writing.  I agree with the destination where this effort
wants to go, including the decision that starting with ref-delta
only is a good enough first step.

As to the implementation, I was a tiny little bit bummed to see
that, even though it does share the code with the real pack-objects
code paths to compute delta data by calling diff_delta(), and to
write per-object header by calling encode_in_pack_object_header(),
it has its own compression loop that does not even do an error
checking after calling into zlib deflate machinery.

Perhaps that is unavoidable due to the code structure of the
production code.

> +static const char usage_str[] = "test-tool pack-deltas <n>";
> ...
> +int cmd__pack_deltas(int argc, const char **argv)
> +{
> +	int N;
> +	struct hashfile *f;
> +	struct strbuf line = STRBUF_INIT;
> +
> +	if (argc != 2) {
> +		usage(usage_str);
> +		return -1;
> +	}
> +
> +	N = atoi(argv[1]);

It somewhat looks strange to see an uppercase N used as a variable
name.  Together with the usage string, how about renaming "N" and
"n" after "number of objects", e.g.

	test-tool pack-deltas <num-objects>
	int num_objects;

or something?

Other than that, looking very good.

