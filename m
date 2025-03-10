Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6914F6C
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624194; cv=none; b=VRZnua5NReZETJ3X3radZefzdrMEqhTF/31lo9SZFtTSUdYiGwPlyWOYEwDCtAY5KNbrlfQq4r92BEHYYJWyqdkP2Y5IoXYBxQ97ldPUpieDycwWiXp7iyMQbWQSkIYDBRAQYfrCFk2SxzW9eBuBe97s06jXlkRLEYuoMFV0u+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624194; c=relaxed/simple;
	bh=7X1CzS3jV1uBcDeerZqH0EAEUs7hfrbcAnlxefyVgQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AjJjhAeGYMYeSJsvWVc/wiXWDkzv8zfhoRcsAA6DwasiVVmA2YYbLL0GsinyTCZlbHMtTO4+lGjl8isCBQoNjl3dBTrRojMHYsu7ky9Yx8/uBTHY0wL7CMKA23JxOCsAUDbC+heJKXEm1d4zZVub7PAhN97vduF5B70qNaylFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iFY3J4Mw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gjWjgftQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iFY3J4Mw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gjWjgftQ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2622625401E2;
	Mon, 10 Mar 2025 12:29:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 10 Mar 2025 12:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741624191; x=1741710591; bh=i02ELSM6VV
	sjdjX4rGQmKu4L4OJ3yIF2zMUOU4mwdqg=; b=iFY3J4MwXTdjoXrwGmxZk8KOE5
	KBvzQT9Csp5sGB52y2eZSqObfo6KW5XihRP8KByVtq+z00cBboI7v3SU6C9bsLLh
	ijGTkRsvXzXumu4JC+3W41lUV+294MH7FzQcvQXIWDyjYmFBUT35p0n5hQPml8XN
	kLcdLsAl6vLdfcbk4GViSbBW7AtjoCTlwKaJ7oqEKBO1GnuHGAWth5nPBsRR7vq5
	+NT9JROtG4Hj+vWSlyRL/XkJDsh5c/jDhU1SWXgPHi/mcLnC7aLbDyeeyIObHjw0
	WHonMVO5G2oe0/lDEsK21YgHZ6KCpyDiinyRZO9zDmFUBsesFEtn8MyT56jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741624191; x=1741710591; bh=i02ELSM6VVsjdjX4rGQmKu4L4OJ3yIF2zMU
	OU4mwdqg=; b=gjWjgftQ24w4075VxcFhwg0Gpn08iTY8Gc5nzwMvK0eYaJ67Nzd
	/pxBqVndAHBFXNGAZNwoO4uBgO5viV5xUwrWUfMBqknMRdH0jE+hbClqr1N4Dok2
	Hq6B7bAdMuZA/Rda4zPWAQnomqG/LIYRVvtz70oTI73INsXJ8s04RvsZctFSGtfR
	9N2Eupl79zInfSjcwqu5uwrVuH9dKtbZ03vCzkMowvu2mUn41Pu2Pk87usU8YF9j
	ikm07liSZSYHGT1+HOwsnpai2VH5XoeUaRrYw1yCz6yea6GRpPCU4G/ZDMNGNzkj
	CX+rHJYC5uYJ2HQUf7nnk/y4ZSqEHa7thLA==
X-ME-Sender: <xms:fhPPZ2y9uYovt_zASpWllCNjNN_bsYHrrVO8UKUFxK4xFKUXK1rphg>
    <xme:fhPPZyTLyoDakCkQ6NFcviOEk6dOvh3SEGvaCeWOtpTD3Qg-okUvN-HL5WCNZs79J
    rCW2eZ34fRagr1Eiw>
X-ME-Received: <xmr:fhPPZ4Uua33UcOfQGNw_bRL34nEjLOy4-Twspoltox3eX08WySWl6scz4tTix7A6M_KvRhnuFJ7JVj1x9IIF35P68ef2t_O8VSgN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghr
    ihgughgvrdgtohhm
X-ME-Proxy: <xmx:fhPPZ8i47S9RWS4XSCNJLT-VoTu2GFHogAGnnS76l3e_luBoCsznZQ>
    <xmx:fhPPZ4Ah3wAeI5Ne8MIE4vs1Kstugw1xNW9izxyzK5PnrKD8kipsWQ>
    <xmx:fhPPZ9LfADoWUVC8SOLzVsk-ebRF6R93xZ6H-W0domgym3RdSKR7vA>
    <xmx:fhPPZ_CJq18bft79wup93eZDCP6H0ws9J2cth0NidGgtcVO4-GxkOg>
    <xmx:fhPPZxKLtiWkEPDCKCboJgmJtRLdEa_zDE9MrVO7PaIutK41pnYqOlzd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 12:29:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Karthik
 Nayak <karthik.188@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] promisor-remote: fix segfault when remote URL is missing
In-Reply-To: <20250310074053.1886097-1-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 10 Mar 2025 08:40:53 +0100")
References: <20250310074053.1886097-1-christian.couder@gmail.com>
Date: Mon, 10 Mar 2025 09:29:48 -0700
Message-ID: <xmqqo6y897cz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Pushing NULL into a 'strvec' results in a segfault, as 'strvec' is a
> kind of NULL terminated array that is designed to be compatible with
> 'argv' variables used on the command line.

It is good that you corrected a caller that tries to make a strvec
into such a state, but shouldn't strvec_push() protect itself with a
BUG or something, I have to wonder.

> So when an URL is missing from the config, let's push an empty string
> instead of NULL into the 'strvec' that stores URLs.

How will these strings in the "names" strvec used?  When URLs are
present, I'm sure we are going to use it as URL, but when they are
missing, what happens?  The second hunk of this patch seems to
ignore such a broken entry with an empty URL, but that smells like
sweeping a problem under the rug.  Shouldn't such a promisor be
either diagnosed as an error, or skipped when you accumulate URLs to
be used into the strvec, so that the later code (i.e. the second
hunk) does not even have to worry about it?

> @@ -356,7 +360,7 @@ char *promisor_remote_info(struct repository *repo)
>  			strbuf_addch(&sb, ';');
>  		strbuf_addstr(&sb, "name=");
>  		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
> -		if (urls.v[i]) {
> +		if (urls.v[i] && *urls.v[i]) {

Why does urls.v[i] need to be checked?  Didn't you just make sure
that the strvec would not have NULL in it?
