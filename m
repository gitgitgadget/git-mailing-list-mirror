Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8101235BE2
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717041; cv=none; b=e6v8EBmlzIaXD1/X7GdTY44nAwA3zqGwuojcy05OhF34o2upn1Ys8tL5QH72qSuYZb8ff4fMLtG9aiHoue12ztZDU95fL400UglbBD/PP0/tQT00tm0Uz+wge7qmkL+fZNrTSQZCoMmTc6mxITWRfSEKe9A88ZMqjJBsqNxNBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717041; c=relaxed/simple;
	bh=Kz1f9N6glN9IKcjEiDWBqHX8Kg5z2eJL1jySRnw8Zfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA5jYbFqF9BjvO9pansPLsrIWpFCvtzdYKTWFMmbA7IqD/ElErJwWBUQgOWN1nKkwGwyZ08jRcP3P4pXWm8b9nGKB58QU1Hqv0nfMMkFUopiAMW2LMDb46pya/2IVgxv82dWWCTpOr5gdq78QQpRMVIlWSckWNR1DvfpImjZYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jZgJD4KA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvRhrUfp; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jZgJD4KA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvRhrUfp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B2F41D0027B;
	Thu,  5 Mar 2026 08:24:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 05 Mar 2026 08:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772717039; x=1772803439; bh=gozRSbhBVx
	8zKrSRHmRxVbSuuZdDl3vUPlDMlwNUhxI=; b=jZgJD4KAde5tE8vA7rgjLfHsK0
	kbu47BholxZO5hux7o0iF6FPq8skKPYFlo8Xf3j63OiLP5M/lO7ttjFVgDe6gygm
	Zoo1p5o+vJlrmcpxICPY58agGLqrjQl6cwLIFUXNzXoGAcE9gAge6Uyp4uU9bfIu
	sFHT4mk41MqSHyX4hfmOsDSYTkTfWCFg6EA+ZlaLA3rjN7grRWzVI57A9HM8iX/m
	hlIStsaE5M/76IBAedAVA2iSCEy9lEya3vITNoHv2yGN0MdQc2zwgTt9liZ+8f7e
	97XSzRj3UCdBBUA4D0OM4LN9zsnbObZld2q5j4r4eS3u46CrbK6b6VnPIi8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772717039; x=1772803439; bh=gozRSbhBVx8zKrSRHmRxVbSuuZdDl3vUPlD
	MlwNUhxI=; b=bvRhrUfpyk34ctzuajd5OaZGPMwtmPNisrhNnYBj7oTDwfWX2/v
	zxnc7PQVisyylYuko8H5dQQvEXJm83csKMK4qlS1my2XE/rM9Bldp/WJ44jveoy4
	5qepY5o8tHkxZ34e1eNdYK0XvfmA5qPxvLtQtxWDpPcIYt0TeP8huHGjuexK1VKx
	V4TqeQ1hsMuNYFrEZ5CgtCwh2lA+lFWrX17M5646EkSV+JoWTrKkION3PxGtike+
	wCfCrn1zZ5/KiRg3Hk0W90lGq6fvbkOqw58zlPeqqnQKMrpojWaO4EgqmWd5nrpA
	iJUzQRx0H5Wvs5hIh8hkk4xmQOwZuBr1OgA==
X-ME-Sender: <xms:74OpaSpPPHVzLzRwOBRBJjhtBkcxkC1dc9s735F1KIMm21j9wiRMFw>
    <xme:74OpaWoQGVkmorsnsFMiwEumGtFIDSx8cUIYdSjqpg8-EgkZ_PeCNXQIBzdR2fcvS
    f3N9ZA7QKZV00PawPKxWi04MYvW3fSsv_UasBeGrrGuTnRsCeKEAG4>
X-ME-Received: <xmr:74OpaU0vbLZJsO3C6jnM4uWs8xhkkVmX8b7j0TBHxGITnGLddsqmp9VxXraCdTF-kyB_IM8jut_ISyDXbE_UZM_TKaW3dFWGghj141TNP6_P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:74OpadCaZWffSi-XFl4S3-P-Tc31aFfw5fBQM1YYZoCRLoILOYV91Q>
    <xmx:74OpaUdI4FCHmaVOYYp2H3TZkVvevmctJhcQmPSynhleVkjbMRwpag>
    <xmx:74Opaah7esEjdKT7Wp5FF4GsrfOVwikyKjJJDlx5hzf8OuJALC8ahA>
    <xmx:74OpaUpJtPbBybIaO36n3jC7xyfgW78NoOMoW-gOGdy1rlxWHUj8cg>
    <xmx:74Opacasnh0lNzqdxT4qNdBxzepO-shRBum8iPLiL2KhK_Zaw-N5ULNQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:23:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce8f43aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:23:58 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:23:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/17] odb/source: make `read_alternates()` function
 pluggable
Message-ID: <aamD7Iu_Ul9qUQM5@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-15-253bac1db598@pks.im>
 <aain4BYJubg4PRyZ@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aain4BYJubg4PRyZ@denethor>

On Wed, Mar 04, 2026 at 03:49:01PM -0600, Justin Tobler wrote:
> On 26/02/23 05:18PM, Patrick Steinhardt wrote:
> > diff --git a/odb/source.h b/odb/source.h
> > index ddce43eb20..14f5d56f68 100644
> > --- a/odb/source.h
> > +++ b/odb/source.h
> > @@ -229,6 +230,20 @@ struct odb_source {
> >  	int (*write_object_stream)(struct odb_source *source,
> >  				   struct odb_write_stream *stream, size_t len,
> >  				   struct object_id *oid);
> > +
> > +	/*
> > +	 * This callback is expected to read the list of alternate object
> > +	 * database sources connected to it and write them into the `strvec`.
> > +	 *
> > +	 * The format is expected to follow the "objectStorage" extension
> > +	 * format with `(backend://)?payload` syntax. If the payload contains
> > +	 * paths, these paths must be resolved to absolute paths.
> 
> This seems sensible, but also sounds like a change that might be worth
> explaining in the commit message. Does this mean we should expect an
> alternates file containing list prefixed with "files://" to start
> working? If so, this doesn't appear to be implemented yet.

Fair, none of this is implemented yet. Let me adapt the comment.

Patrick
