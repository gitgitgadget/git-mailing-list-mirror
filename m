Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176F41AAC
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855895; cv=none; b=WsPQuX0tvaqjNF2o1ayB5v82s6uHaDEbDY1anMhODNgdxlCXldUBHdcP9o/7XZtl7HH8wgabaUsVa9+J1UjFZkAznaSN0mBVMQlVDRifG+tQMcv3fmuObpcvN9N9cGiqX1R2dZP7uPWZTvYpKtK58Tk6EMRJtK8XaHjBPPTWx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855895; c=relaxed/simple;
	bh=z+DILCxX1Y4ir1ZSd1DZ48j2pRTffD6FK/FI54B7b7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YvEJYjiqm00kQ90fvEq9UMwfffG7BmlNKtzSBeHaSVTicfvLdT+nS9HCVsqUS/LOBZn2LHpbxcN93FBEI8pu81jlATu6cGUz9lTfWwUN1dFnza7QC9SI1Ipv8OKNMvSBvDK+haTmEGP41p/F3/5wabUAJwBkszdYZ2rA1SnLTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TaKhwBdi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y2m5+lNI; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TaKhwBdi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y2m5+lNI"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E85E52540150;
	Tue,  5 Nov 2024 20:18:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 05 Nov 2024 20:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730855891; x=1730942291; bh=NoF72r5DT4
	DMctjagHUNUej+Op+D6LamswYUVdTaVWE=; b=TaKhwBdi8jdcfGQTty9Bfq8ths
	2iNUJCH0TN6LRUImZYREVKHt9h52oaBnTJ09NhBvBP6ezQeElQN1b/XnpXWgUtMS
	Tlb+BHul6jyh1apM2xdkt1c91Ix6Svz86+Yl5Maqi22fCX9Y/JqR2XJrwIMYc9N5
	dK8FVISxtrmMAxi3ew+drhnBHPW3BWzb1WQheUQDkG5O+QLqMQ1c0wo6oAtja9GY
	qkt4hsjDgpmzEx0JEtKYMqtsmth5YEANsujcow6DnuC49UDgq1/USdKh8/wrEpvq
	rvp30N63GR15bHrA0dQbQJ3KaqOmH9igVJmbGblHFBXqVfq+U8xtIwZLk6OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730855891; x=1730942291; bh=NoF72r5DT4DMctjagHUNUej+Op+D6LamswY
	UVdTaVWE=; b=Y2m5+lNIn/bVJmHftPR9RcAZdHdsOR0Io5aSEwMdz1ZtFOBWlKx
	7ubGx8wTAL912HkxvGVxHsKI7p0EkB2OmeFdAEsaq/Tndhjx3IVsPiWil8/rh+lL
	TqmI/QASxyW2dRLtjswzJm4MEs+hZpwJUQHJPAsT3o1QVtd6CY5S7X5Sh12kz6h8
	WezFHDclh0G6PucLpxtSbbIJpSK5XTqwLbHYTyfVp4uvXcxjOWFtLjuDavOBD4/Q
	jVAJ5KxicplIxWyszQu/Aby/sCOHVJFI+z1/b+O2WHV7JOIgIAZYWqkGbqVSXDuo
	54y5sDIyqN8vOehsnNC/X9p1B/c6I4xQDGA==
X-ME-Sender: <xms:08MqZxxcjqxKRlfNTP0AZwKi979qa6bpiMWAKr8CsWddyiXmlC24Sw>
    <xme:08MqZxR8JNmpE2UYsEifsjU84QoBxC_D_hFCIQG4sD-jMesdxdDhHVzlvwRnnMw7b
    wxEBWu4-4njVnk56Q>
X-ME-Received: <xmr:08MqZ7Uk0-1UltsTw2c2dTC9XSB4CGxVpxJuoRDkP6-2CiO0ae1gz1vFnWuEvgXEW156sMrwgjZuR0RVNLk7hWjxQ_dlFZEBxueT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfihhvvgdvfedutddtfe
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:08MqZziroAd4HHfoqyBzEIa1hKhCw5WmN1-btNSi7mOy_YNq1HGfCQ>
    <xmx:08MqZzD7ID1F1rYP_WqgsIaNfspr-Et-M3Tc1O1yYkHVixv__Dz9Qg>
    <xmx:08MqZ8Kv3lnHsYiSPy3Cp2sK5Rl0L4n-JxUDrenwF509c8I3-OFMYg>
    <xmx:08MqZyCzLguJUr_lT0TSqffGR4_2PEJqZLgZrtv5sEc0hbQfrlxS3Q>
    <xmx:08MqZ--F14qKcS-e6pHR0XAY4mGIrKQ5LQ8Tc_wsMK8kggz9dBS3aPoK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 20:18:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
In-Reply-To: <20241105190235.13502-1-five231003@gmail.com> (Kousik
	Sanagavarapu's message of "Wed, 6 Nov 2024 00:11:34 +0530")
References: <20241105190235.13502-1-five231003@gmail.com>
Date: Tue, 05 Nov 2024 17:18:10 -0800
Message-ID: <xmqqikt1qhwt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Document that values containing ')' in formats are not parsed correctly
> in ref-filter.

The problem is probably lack of a way to quote such a closing
parenthesis.

> However formats having a '(' instead in "value" will parse correctly
> because in a general format string we also mark start of the format by
> making note of '%(' instead of just '('.

So if you wanted to have a two-char sequence '%(' in value, you'd
see a similar problem?  If so, it is not quite a "bug" or "not
parsed correctly"---it is "because there is no way to include
closing ')' in the value (e.g., by quoting), you cannot write such a
string in the value part".

> This raises the question of what can be done to parse ')' in values of
> the format correctly.  It seems to me like a clean solution would
> involve a huge refactoring involving a large portion of ref-filter but I
> maybe wrong.

Yes, so I wouldn't even call the current behaviour "bug".  The
language is merely "limited" and the user cannot express certain
values with it at all.


Having said that, I just tried this

    $ git for-each-ref --format='%28%(refname)%29' refs/heads/master
    (refs/heads/master)

So, if there is anything that needs "fixing", wouldn't it be
documentation?

If I knew (or easily find out from "git for-each-ref --help") that
hex escapes %XX can be used, I wouldn't have written any of what I
said before "Having said that" in this response.

