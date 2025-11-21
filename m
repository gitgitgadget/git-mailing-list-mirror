Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DAC19DF4D
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740910; cv=none; b=faD93kluxR0OEo2bIDjccdCuO44sQGwJpx210aqKvtkbxEBRo3jqjm3ZhvxLrxCCcVDSoDHqJvmyA5Z3O8kpaKHFMvaU8Sv14NzOY7pB+pHJNMFoFG9pkztTYLYtbEQh2jTEyk5e0It8gqVAF+z1XQVw+3eBKQWTmUFHRs+MPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740910; c=relaxed/simple;
	bh=3moqTn48BkhfzSbzliqOKgWEHq9spB6209mXVcLpjK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=htDi5nu0zrdJCqtSIhgGrR5O7SxFmDkddhkesO8FgwF+LBENcmjgBHWgbOLwuEHpuBGQ5ZBVC4WOfvXv+6XikupzqGisMo/xgUVcgRFI5rvIgWy+bXMalfJbyW1VZH3lgbSCXimUeq+HZxyhWIJowr7V5EcQAaU3S1bT6xm31Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EQjZYjPJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dp5CSZmD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EQjZYjPJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dp5CSZmD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C0EBB14000D1;
	Fri, 21 Nov 2025 11:01:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 11:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763740907; x=1763827307; bh=ujOJxEbP9c
	69hCPjiTqaLTqqLxA9KDN8CKqhK0oNzlk=; b=EQjZYjPJqIwt/hC6NXIvTuybGt
	WAp5PQ1H+xry3BW9pxGt+JOnxCX6AyM12yLJDVmYu60J5X+/J379YtLmx81uGk70
	aep6YdKgURT0GJ3vfP7eqidJLFQqst/sGExLabeSaHCU7RoP0fTqt4lYGySh6wc+
	bBE1G/fvfOHc/6TJz4JukZrzJ3mpL/8oJ2KNeShKqKg7h0SVaEYEZJAjjAFo0zlF
	BJQ1MapPivKt+ZAv9pCodwpcdB6VBFP1LNGdeCZMLDFngg1BUfWiQxbkjBMtDSsI
	0CXtwMGoVnM3Ung/4ZoB2jEm53LtbABlSN4C09W757EVKn+DJGJMI1dThlFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763740907; x=1763827307; bh=ujOJxEbP9c69hCPjiTqaLTqqLxA9KDN8CKq
	hK0oNzlk=; b=dp5CSZmDGEyX2O+wLWcmENuyMjWcALozTz7rlrchpQ6o1WlZeiB
	g6dAYBvVaqsD22pxfIZlBcX+Lke51w6lrELX3Ev/z0oKC2AKVONC0H+6fCt9RUeI
	siyt1p3UVnI3RNdAEEFjOjN7IuDlzKZsWhuGm/MsES2gssxWXbFNkm9VPBSE7EEC
	zMomooDQTEUvCn/QcZABP3m7HRX2SyG4KcLybYQJW7eeTgbl4hPwNEnd3aUhuQZq
	2keHUBaxFpqP8NzzgufRcMwoGy2j9ZQvSW6EpLs89x33ZUDuzYBPeBXwrLPenBIn
	aGeFk1x0hvteXWJ5YORvTyRBtMA35tdKWtw==
X-ME-Sender: <xms:64wgaSdhtpqPhlCnuQ4r_0NfKk0-sUpnacb64roDmVxbdr7Yb4imsg>
    <xme:64wgaUZ4Vt8QNSII-x7oHT6FLSiQZ-qczGir2pubx2axMt2rSAcogpVSizJZ8S_nW
    XILJz9755JaQKBBYj4f6EPp0yPzH38fpbwDPAFzjY_RDG7LgKpB>
X-ME-Received: <xmr:64wgafHb4uWJM74PJU2OSE9ShpEl-AkRA_pL_uu-jaFOZ6GqeT22wSRPqIOJN0kpm2oi659H39rxjJTvtEJcoypKCAtHs2QKb8nT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvh
    hilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:64wgaamx1tUI9ouSWjNJy3Q_lglssAGV2ZOL7CwciL0SwchMMYo0jw>
    <xmx:64wgaae-IT2zjzbpRhLM6i2Yml4mVzaXAPNjC-eIYBRpVrLxNEcEyA>
    <xmx:64wgaQEKgeN1uJczDE31jfjyl1SR0n7C6GQmIKJ2FcOQ70lflEC9Vw>
    <xmx:64wgaYhDpbP8CxcTxfrQayIfclOdpDKUm0yJWJ6Tt5lB2mmXdUivEQ>
    <xmx:64wgaXFOvcJ5nC1-kwNdVtPPY3viLuwYJKadmWwhrrhhyHpEeOz3-N7K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 11:01:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
In-Reply-To: <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com> (Phillip Wood's
	message of "Fri, 21 Nov 2025 14:31:38 +0000")
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
	<CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
	<xmqqbjkw78jj.fsf@gitster.g>
	<CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
	<xmqq7bvk77lr.fsf@gitster.g>
	<CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
	<3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com>
Date: Fri, 21 Nov 2025 08:01:45 -0800
Message-ID: <xmqq7bvj5q8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Granted, I think good progress is being made and perhaps the changes
>> needed for the rest aren't that huge (and maybe there's more pieces
>> I'm not quite understanding yet similar to the
>> two-split-patches-always-summing-to-the-original), I was just a little
>> surprised that my comments are summarized by "expecting a small and
>> final reroll".  :-)

It was because I didn't think (and I still do not think) your
comments are something for the immediate future, for a tool that
wants to present its minimum-serviceable experimental version to
users so that the users can experiment, extend it more and fix its
behaviour incrementally.  I may have been probably wrong, but I was
getting an impression from the reviews that it is getting to there,
not the feature-perfect version that needs only maintenance from now
on, but a minimum-serviceable one.

We could instead of collect all the I want moon and I want cheeze
comments and iterate until the tool has all of them before it hits
'next', but I do not think it is often what we do to a new feature.

> Yes I'm not expecting any new functionality but I am expecting a bit 
> more than tiny cleanup.

OK.  Then we'd need a non-trivial amount of work before we get
there.

Thanks.
