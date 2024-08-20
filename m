Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A4319005E
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158783; cv=none; b=QCvi7+PgEovzE15NvLN9pK4YVhtdWk+DTyZVwygr1UWR584KshAv9MwYjgpgKUTI4tKu05+u50HoAfkW3Ts3AoaNmFOSlqmd09AH7coRZ12i60PtG/1G5eDj5ohossUuaNuM/Du4C+ph7SwYWDBGbDVcAuYxfr5JVWAteYITMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158783; c=relaxed/simple;
	bh=x2cKQTmTYgDfp2cRzAjRTZj4YZvvH2p+JEFtyD/LMHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzYHkrbLmB9oTWyJDzLMsClszSn7XuN1ntur4AQamH+lblMhxkNe+q6QMW1lRJsjtxOm8fDEwV4flxfFy4t2WfvyM4xhwXBhgdVnnjZARMW0HiFBaYX4FFVmequEOwumg421EtI8tee/A37SfbFFY9+57hVqlr3sn3H4GlhkLHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A5gA9QNi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hOzorRYX; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A5gA9QNi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hOzorRYX"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id C6E5A138FF57;
	Tue, 20 Aug 2024 08:59:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 Aug 2024 08:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724158780; x=1724245180; bh=lp+4xPdO9L
	Pzo0mULxe0RaqECoUABKKvrxBNhzHlIN4=; b=A5gA9QNif89k1gS2v5vpYTk9wy
	Kdjxc5R5WjkFfJmNrXYIGr8N/r0++8ZY+mPCIWyokjnjNYZ5rZnGTRVAcRls3Tof
	J3IcXxGz5RDtmi6tiIfr54RigkeZnP+pL+SL6NfwOqOVEjGk6BMZSIGDHfBioqh/
	5jYFQVm7a1vP3GsnVDGr6l0xg7ZkkBh+oyvARni62Qv2kxpl9+3pnUF+uSFjYyKU
	DWAdPDqJtmlRMlyEkO/4bhnhubXnJFq7T0pWZOo4lSJxdTciVj9d0NiKcxkWfbha
	Q616rKGxxcwmMjcZU5rkIYG7tBPe5JYaviB9Q7CjOI2ryoeBvSwdaY7TCgNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724158780; x=1724245180; bh=lp+4xPdO9LPzo0mULxe0RaqECoUA
	BKKvrxBNhzHlIN4=; b=hOzorRYX1HrdaLpYBMibT7cim3P7AL3p8+kUo4yA/QYL
	EfwzCJAkbrMAkhyDm7cfomQmfChyHKed8UYO9UDjabGnB/typ1BqA5IUMX7Qj94I
	Q2eVpccR1BiK+InuQRuLEcqO+fGCj4TujazU+MOizlNPd6tf3qfOgT5VM5amNjAa
	sZdyS9i+p5wKW96qt+SU4FA/fwkVJvEu7PcIZTdDu/UN6ttjrCC6wdNmG122G72t
	0c0QlVjoPD7JHbaJFgql5G3+0DQLmGHUyLmepNQ4I/QK37sO8J9K0P8uQcFKlDxp
	IEqMleYWkuVUqWbF65bU0IP6uxrpURCuHf3NQ/B+7w==
X-ME-Sender: <xms:PJPEZl-hKpBodCkfTCx7LvxJyVGIOyM-fg7mHDBeg8ou9C13CPyu4g>
    <xme:PJPEZpsrrBzu9YVeMpM5FXthTVoLGcFRQYCeBK10c0FBcZKkgD7chlGg6o6H7gNTs
    d2JEt517spEpCpxjw>
X-ME-Received: <xmr:PJPEZjArwHjb8bbgbY4NCJWht8KCB-Cegplj7ejNs1Y1-vkIcg0tG7S3LXF2EQ11jKHwr2b8itrDMF-UiRN15JcTE2qGMtwaBXgK1m_IJsaBOAqN-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggvpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheprhhs
    sggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:PJPEZpfvwsUceqT2HoUCQqzH7eU_2x4Oz4mwn9KxPwLE2619xOrDhA>
    <xmx:PJPEZqNxuWSiExVblrWBSimc6uWXCImh7BgcVvj_EGwoS1Z7iDQvjA>
    <xmx:PJPEZrlwOBwIp-tg2evnOHFi7kBDXIrrUc6Xk_U-zJvrDRcF4j1N3Q>
    <xmx:PJPEZkvGd4QkYSloFZ1JtovQeV3sQTQBpQ0164P9MKRDeobwi5vQYA>
    <xmx:PJPEZrg_kPJpBeOzxiofg1L-m2oTlAhwhyHOPMOi-949svMaNTvn_EWu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 08:59:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5410ae8e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 12:59:08 +0000 (UTC)
Date: Tue, 20 Aug 2024 14:59:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v5 0/9] Introduce clar testing framework
Message-ID: <ZsSTOczuGhT5zwoV@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723791831.git.ps@pks.im>
 <b87700d2-0c9a-4d0c-9ee4-e6a91278d596@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b87700d2-0c9a-4d0c-9ee4-e6a91278d596@gmail.com>

On Fri, Aug 16, 2024 at 02:37:34PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 16/08/2024 08:04, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this is the fifth version of my patch series that introduces the clar
> > testing framework for our unit tests.
> 
> Thanks for working on this, I'm broadly in favor of this change. I
> like the way it keeps each test as a function and adds automatic test
> registration with support for setup and teardown functions. I am keen
> though to keep an emphasis on good diagnostic messages when tests
> fail. Looking at the conversions in this series all of the test_msg()
> lines that provide useful debugging context are removed. I'm not sure
> using yaml to report errors rather than human readable messages is an
> improvement either.
> 
> I wonder if we want to either improve the assertions offered by clar
> or write our own. I find the names of the cl_assert_equal_?()
> functions are a bit cumbersome. The aim of the check_* names was to
> try and be both concise and descriptive. Adding our own check_* macros
> on top of clar would also make it easier to port our existing tests.
> 
> Here are some thought having read through the assertion and error
> reporting code:
> 
>  - As I think you've pointed out elsewhere there are no equivalents
>    for check_int(a, <|<=|>|>=, b) so we're forced to use cl_assert()
>    and forego the better diagnostic messages that come from a
>    dedicated comparison macro. We should fix this as a priority.

Agreed, this one also feels rather limiting to me. Are you okay with me
doing this as a follow-up in case this series lands?

>  - cl_assert_equal_i() casts its arguments to int whereas check_int()
>    and check_uint() are careful to avoid truncation and keep the
>    original signedness (if that's a word). I think that's unlikely to
>    be a problem with our current test but could trip us up in the
>    future.

Yeah. If it ever becomes a problem we can likely just introduce
something like `cl_assert_equal_u()` to achieve the same for unsigned.
Both should probably end up casting to `intmax_t` and `uintmax_t`,
respectively.

>  - cl_assert_equal_s() prints each argument as-is. This means
>    that it passes NULL arguments through to snprintf() which is
>    undefined according to the C standard. Compare this to check_str()
>    that is NULL safe and is careful to escape control characters and
>    add delimiters to the beginning and end of the string to make it
>    obvious when a string contains leading or trailing whitespace.

Good point indeed, and something I'm happy to fix upstream.

>  - The cl_assert_equal_?() macros lack type safety for the arguments
>    being compared as they are wrappers around a variadic function.
>    That could be fixed by having each macros wrap a dedicated
>    function that wraps clar__fail().

Some of them do indeed, others generate issues. I don't think we have to
have dedicated functions, but could do something about this with
`__attribute__((format (printf, ...)))`.

>  - There is no equivalent of test_todo() to mark assertions that are
>    expected to fail. We're not using that yet in our tests but our
>    experience with the integration tests suggests that we are likely
>    to want this in the future.

Heh, funny that you mention this. I had this discussion some 6 years ago
I think, where I also mentioned that this should exist as a feature. In
any case, I agree.

>  - To me the "sandbox" feature is mis-named as it does not provide any
>    confinement. It is instead a useful mechanism for running a test in
>    a temporary directory created from a template.

I guess we'll either just have to not use it or ignore that it's named a
bit awkwardly. Changing this in clar probably wouldn't work well because
other projects may depend on it.

>  - There are no checks for failing memory allocations - the return
>    value of calloc() and strdup() are used without checking for NULL.

I'll commit to fixing this upstream if this lands.

>  - The use of longjmp is a bit of a double edged sword as it makes it
>    easy to leak resources on test failures.

I have to say that this is one of the best features of the clar to me.
The current test framework we use doesn't, which in theory requires you
to always `return` whenever there was an error. But that results in code
that is both awful to read and write, so for most of the tests simply
don't bother at all. And consequently, the tests are quite likely to
cause segfaults once one of the checks fails because we didn't abort
running the testcase, but things are broken.

In practice, I'd claim that you don't typically care all that much about
memory leaks once your basic assertions start to fail.

So, things that need addressing and that I'm happy to do as follow ups:

  - Introduce functions that compare integers.

  - Improve type safety of the `cl_assert_equal_?()` macros.

  - Adapt `cl_assert_equal_s()` to handle NULL pointers.

  - Introduce checks for failing memory allocations.

Nice to have would be support for known-failing tests.

Patrick
