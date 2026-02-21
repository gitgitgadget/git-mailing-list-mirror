Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9781DF72C
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694441; cv=none; b=LjxncZOCaDG9lGtL5YUp71OMYw9Iz0q/AVd2Gb6k+PcSwP17J9DQvP5MKcdQnxfpAulr6ARMttAnuttmxnTOEwQIGLOMG7EwFTgQkJXEBK3DxUyRd8cjZadU7c0ktqJ6VrMOM+sEu/SWZXVZO+vlXyG6p0A7E0KeaucGbDJ8h7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694441; c=relaxed/simple;
	bh=bH2bZ2X5b4LpM3XXKqTxw7DAcMT4Pwr/BS+7v1sHy14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nqi91ow7oLdm+eCMwUYxHuIVCk8OciwjcCcQaAmwEypkAO/nfTfk5bXa9W0kDdMWrnC107S9b+bA5y6fFKQQ3XfavLpWNLPwTW55pE4BjiXFBZlIcEsyZ3hpnIR4+87A7sUIBn+uPUltHFAEFosEzeAJfwWKmGXqqh/YCt5yV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oWWNOlui; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WWTnmyHb; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oWWNOlui";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WWTnmyHb"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D5657A0130;
	Sat, 21 Feb 2026 12:20:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 21 Feb 2026 12:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771694440; x=1771780840; bh=3HpgB2K6hl
	Nhps4Dm8dZw9XPZuve8BZMsQzVsBJ7+fs=; b=oWWNOluiiNKZ7jZLdzWgwM9LYz
	FSYMYDqIBjx9MLmsM1dFK1FzD4Dmj7L3KahPDB9t65pot5X7VJyVWJrDobVbZqHy
	UV1h204B8vRQYPSN+rw+mSNG2c/s0AMedd9ZtbkZBZbducHOuNJLbRdDpvjDQdmH
	UjYxz9wFs2LUgah010lxMQsZcQN6GHGVpRtSgM214yAgBPbblLnBGCkygAPvdPhD
	6j3p8E/BFbGIcdC4kmCQdfML06jqiYlGmmORxkPGDDCqG0OjzunWbgHhxEWeTDsP
	AB4WDQPVXgtE6/f4CrA9iKQLVJzoiBlTBYjzwOY+NcLal7ynAEwH9bbfyfew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771694440; x=1771780840; bh=3HpgB2K6hlNhps4Dm8dZw9XPZuve8BZMsQz
	VsBJ7+fs=; b=WWTnmyHbgnGRAPMKddUaoDpEh1f4FFE8W6StrcOFL5TxT15LF+E
	j6TIauMI3+uFWpne0WfvQLdyhAd51YXcYZ4UmphllpAIPwwj/QHSsD5CWBHep5eJ
	khbK+d1Uxcf63CASG4F+/QAqa83J+XRUooYP1aa7puYTM5dB6TmI3mBnw8gg5XFN
	NlbQr9g8jOLpJL7Ng2IplsMxvQ32tqkQGRYzujrKMiaWTdgEb624B7MPNDGhEHDk
	ntl3oLxKwLP0yXFjGXzUaWUaLYfw/sejx+p7RbDJdgbj3hKwk0k8PCXOZAihCxa7
	w5kvK+EkrmocrhU8kXS8p5gfDHnrEeCDI+A==
X-ME-Sender: <xms:aOmZaf0Jbct5qz4fluqLanK3LUR2twq5QSz21Rd4iscYUkfBrldK1g>
    <xme:aOmZaVFP0ZIvn5enk_suxfCE-2xuKCf-a_J4qT5h7DW7FMKgsQkEiQdRMcai9a-av
    vnkQ_fQ2-ZuD-fvNxQVjuIOdVBfn-3KP7y4eXfzvEkCmWmI3mwk>
X-ME-Received: <xmr:aOmZaU6Z91rFZEZBdS0xU4unC6Fps2auijYGBgFQz5MZQ-6xLZBkc-oU33BavPSzj63L4lxPcKM1zsnFU8AxPbvYhB0aiYuVOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeduleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aOmZaTtoMAB4JUpKUXJM6kUX6M0rSgNp31k2cq8oB_IXnKsFe5ohww>
    <xmx:aOmZad6Y5n_2bRn5ohRyuM_ukNkZF3zXXBtXdFPoBBQZtuoX3TVlyA>
    <xmx:aOmZaWXYxGFSETSGzPaMEJCTKMmlZuwikujU5_iDU9zZB7eGwGzdgA>
    <xmx:aOmZaX_0QRbnvZbo3XDhMpGmrE9N81bCq4aHubQC1NG5T71C13qQTQ>
    <xmx:aOmZaQYtjPfuy6PABel_iPkEfe6pIEP882WbtVRb3TyEit1jRZFoRaGz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 12:20:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH v8] setup: allow cwd/.git to be a symlink to a directory
In-Reply-To: <60e4cbcd-6dfe-4e1a-9c63-be905c815bed@gmail.com> (Tian Yuchen's
	message of "Sat, 21 Feb 2026 16:10:49 +0800")
References: <20260218124638.176936-1-a3205153416@gmail.com>
	<20260220164512.216901-1-a3205153416@gmail.com>
	<xmqqfr6vxpkn.fsf@gitster.g>
	<60e4cbcd-6dfe-4e1a-9c63-be905c815bed@gmail.com>
Date: Sat, 21 Feb 2026 09:20:38 -0800
Message-ID: <xmqqqzqerp21.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

>> This design decision may be debatable, but not tightening everything
>> at once may be a prudent thing to do to avoid accidental regression.
>> 
>> Having said that.
>>
>> If you have a directory ".git/" somewhere in your working tree, and
>> the directory is somehow corrupt that is_git_directory() says "nope,
>> that is not a valid Git directory", wouldn't you rather want to know
>> about it as a potential problem?
>
> Great point. A corrupt '.git' dir is definitely a red flag. However, 
> silently ignoring it and moving on has been the historical behavior, 
> hasn't it?

Exactly.  That is where my reference to "not tightening everything
at once" comes from.

> Still, if we decide to tighten this in the future, it will be very 
> simple change within this new 'switch' structure. Nothing much to worry 
> about IMO.

Yup.  Perhaps it would deserve a new "/* NEEDSWORK: should we catch a
directory .git that is not a git directory here? */" comment there.

> Will send v9 soon, with commit message rewritten.

Thanks.
