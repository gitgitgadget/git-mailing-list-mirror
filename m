Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE92D879E
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144378; cv=none; b=rTg6oSV/21k2qvvPdebIuB8gqdeyiSajBzETNJgbDujyvXQNs7KT/NOZJm70Rkng+epB1eOvvbhcUGpb5RUDNN7C7DYsO+SNOOVOKbJXnYWvlwIlCZMNm9ow+kxub9szGrLLNepULOfLQgxQAJAlYfVkSwdNadSifNox+7I9ijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144378; c=relaxed/simple;
	bh=ktQowqkqVngmKTv2hV8rWD3nGkrwpR2W2UefBH4z3aA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gLGMnuQbGTZCFgcsqkj9o+LUmS5iae2pqCwGHniqYa36nqmlw40LxBBJ6SIpsnkfCof5iTgaYv2odbMUT1XdcX+P3lGvKYSZ5hvCz6S3xu6qaRhoisyeJwO7v3sLMZUBxEuaIp47SP9fvkgQ5Xs7VQ6lEfQGn6m1mwN3TaPnsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tKlndojG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QNOS2hBf; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tKlndojG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QNOS2hBf"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA3C87A00FB;
	Thu, 26 Feb 2026 17:19:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 26 Feb 2026 17:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772144375; x=1772230775; bh=BiO0AfLNGA
	Rl66h3BZ7EeCrMf8u+OdPxJQmjNONbwj8=; b=tKlndojGLYUEN3keFS9h5ubcLu
	rmjtotZLcGlZErP7LqUd7ZgLgf16IrgI/PE+2KmeoufwxgjKOnViLVtZObOJsmWt
	noplwrFcBDVMeDmhIEVe2ytbwyOHv0J/b2zIoq7LiYpARRSLunZPITU7c3GvBSz0
	aJ5N3zce12wVk/WYgLekR2y/N7nk8OdaKtYfEB5Pbp1JAWpZd53seQ4IOv/JiGIh
	NxiglKWxcWMD31klCVmjT/aNXhjpBEAh9o5DE7Zw9RnuX7pTWTp3/zcKd50hndQ0
	Zxi500uoGIBSbksYIgV2mt+1gNMlOcXwqQvMYksd+VHXgAybJWa0bR632g2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772144375; x=1772230775; bh=BiO0AfLNGARl66h3BZ7EeCrMf8u+OdPxJQm
	jNONbwj8=; b=QNOS2hBf9XzS+uUmD9EwzfVAgXWy6kTW0XWTLYdyofWytnAdW9l
	s9uQBp1bsIo32QmUVDlmq4tiZI+x/PPO23zzrhgV7iUWMHYXxS0nfBtmUj7rMl/s
	qUv5kXGVlOGMqbWyaA1/hFIGWHAtQbfgnygz/TEcepmqbM+sMw2NGWlC7c2PMxhU
	D10HpthYrYOIMJrgnpi/cks6ZDGeH7EAXfD9uQRtF5D8Il6T3P/vTwX81trX3St2
	qH6Yjmwe+RUp3sbTzaWWCa5PgVrrtVEiTqC7RjuGFFDc4Yd1cLMzSA/VwK9AdZsw
	GjzN3vm7d81jAhVdYjomUXCV/bTaT6vFKWQ==
X-ME-Sender: <xms:98agaX_o3kM-lqmJLiSjmPT-ZAoyd8UapC5b4n7tzIh1PxU5iZ2FSA>
    <xme:98agaavYDQUekcLCW7prpPloyqZrkWJk6NhgRbJLToRu4s_BJVPkwLpsewycXUY6b
    UuO6XhJoSDGvdnL9NqgP-7v_LFyyxoYJ1wJjWDh4xCceGdsvIAKU5c>
X-ME-Received: <xmr:98agaaDwHA24WiVlDJl927CXhzsrQWv0PStTde4aLli1wpi9d-EiNd0WZNz-XSI8nUmUiekKzAaQ3mvll3bIWrTHPljdWHHZLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:98agaSVCIgKtMo584siRghn58SfT5Ia7F3ZmIvINxsyEJOgK5dGOJw>
    <xmx:98agaYCdYG0pI9MxZawAZpSUMCWOHN0wqIStZZLCpQH2mwhXe-zUeQ>
    <xmx:98agaV9dOuABLd82bUDnOZIh9ybhzIbFSkQb_iHOkbnWHSDX1z2PNA>
    <xmx:98agafEuPOYY-74ynjfjSuc9dLGelvV94L7nSNtvGagu3vck2BHTuQ>
    <xmx:98agaRCLjIKqDjcMpQrXY7Oge2hVRFfztIiC4wHeArG41qWZkULc8Zd9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 17:19:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] format-patch: add commitListFormat config
In-Reply-To: <aaC81Hk3tO5N2Rl0@exploit> (Mirko Faina's message of "Thu, 26 Feb
	2026 22:40:09 +0100")
References: <20260224040400.751247-1-mroik@delayed.space>
	<cover.1771925291.git.mroik@delayed.space>
	<6a0c7aecfd6dc1ee873d5e81110b723fa2d225fb.1771925291.git.mroik@delayed.space>
	<xmqqqzqaggln.fsf@gitster.g> <aZ46xqCusF1av-va@exploit>
	<aaC81Hk3tO5N2Rl0@exploit>
Date: Thu, 26 Feb 2026 14:19:34 -0800
Message-ID: <xmqqv7fjuozt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Wed, Feb 25, 2026 at 01:14:13AM +0100, Mirko Faina wrote:
>> > > +		strbuf_release(&tmp);
>> > > +		return 0;
>> > > +	}
>> > >  	if (!strcmp(var, "format.outputdirectory")) {
>> > >  		FREE_AND_NULL(cfg->config_output_directory);
>> > >  		return git_config_string(&cfg->config_output_directory, var, value);
>> > > @@ -2318,6 +2333,13 @@ int cmd_format_patch(int argc,
>> > >  		goto done;
>> > >  	total = list.nr;
>> > >  
>> > > +	if (cover_letter_fmt && (strcmp(cover_letter_fmt, "shortlog") && strncmp(cover_letter_fmt, "log:", 4))) {
>> > 
>> > Overly long line.
>> 
>> Will fix.
>> 
>> > Stepping back a bit, even if we do not validate the format *here*,
>> > shouldn't the code that does use cover_letter_fmt later in the
>> > control flow *already* be checking the validity of the format and
>> > complaining?  If that happens early enough, perhaps we do not want
>> > to have an extra "early check and die" here.
>> 
>> That is true, and initially I did not introduce a check here, but
>> make_cover_letter() is called after the cover letter file has already
>> been created. Failing before format-patch could create a file or print
>> anything on screeen seemed more clean to me, that's the only reason
>> there's a check there.
>
> May I have a confirmation on this. Is it ok to leave the extra check
> here or would you like me to remove it and just let make_cover_letter()
> handle it?

An extra check here would be warranted if that let us avoid
end-users spend extra time and effort before we make a call to
make_cover_letter() and bad arguments cause it to die.  Otherwise,
not.  As the underlying helper function, make_cover_letter() should
be doing its own sanity check on its input anyway, so it is
preferrable not to duplicate the check elsewhere if we do not have
to.
