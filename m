Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230D32F757
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706780; cv=none; b=i1EhNWmUh6ehP+Z47AahZWxMi6P1+35vCzLeHpKgkMzsWbEBpxDO60fTHJjqvs7WlJETBc90camWrGyKH4NTInBbq5adR6IbQ/9qkJuy9ymPzUzdxMsWYJjYZdzTYSxtTVweEbx1qVH5z3d0PZlrN2PPDytSJ52ErmQdMseVd0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706780; c=relaxed/simple;
	bh=PM3WEARvgTMuaEYvRpdOfbOc9nzXr7Hk8MQoNHNrJmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewxcqFGPZrVhCA5u34wDO+RrwsSrBvchbCq0dqnZb+jF2+lBkXfOUosG9bxGCDf8oOa9fuUHT7f1t2LXIc0iI86O/W367g9xyZZxBsyN2O8U3EH/nKHk+GSkarUDD4gE8fWg9uivqWMI5zr0CWZ0igOIw34mr89YBwRykIuAFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AKMqtXo0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YC7dzQHj; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AKMqtXo0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YC7dzQHj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D50687A01D3;
	Fri, 21 Nov 2025 01:32:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 21 Nov 2025 01:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763706777; x=1763793177; bh=2ElI4jNEPE
	BntPPyrq6Z9GsCXS2x6lVxSE5y+S61RHA=; b=AKMqtXo0c0zL3vmHOQm+LqA5rz
	uWXQ2uvj/EWi0SUAGx6G1GO/Fnf05DSi3Vz4rm8QsI0cEhl7KRN2Wp2fN5db3u33
	67jVDLYOFvcJqByMaEMWFFqcmZ6NzTQAh1yFk9hTdm2+gX+Ypd953FKf1o2Vr4hT
	FlULqr1IsC5F/g0FWP8NoDqW59WVFbewuoSo968A4tXXyU69aEmujeBTtE1v2Nsw
	/0rAfIzlW5o6q0E7yjHJ3LhZ94MxS1nzzTUhH3RCf4S5d9x6SJ6KrFlGlsscUJdh
	dRI5WnXPwwH1yxB14TUCZm3Y89iJ9KIXO13p6ycbMoM5fLIlc0aJqPl3WGJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763706777; x=1763793177; bh=2ElI4jNEPEBntPPyrq6Z9GsCXS2x6lVxSE5
	y+S61RHA=; b=YC7dzQHjmjeL+eZqIf+JU33TO5HtMQned7AQF8nguRzpHAH+tiB
	2dVyIEmi+FsQt2s3KqsnUKtOGUgDFa3Eu24UiS+UZs+hZUoTwjMS4l/LgySlT68I
	sca5eOA6mk1Hifv5XYXKWOqrcfy5fACJJF0EBSYADMaPAedDBHnl/F1BzVhGSewR
	Iq5vvOsZPbWrQ1YAcEe4y2MSBUPFOX6bpou46ueZj+RdxhZy1/x7sH5uhr9B0s9z
	1V9ooELVU9nxSKbOy6FeK5avB71nGOWf+S7U7Uj3CAihcqKe3yvZYL17D+FoFJtd
	dpmk/rLP49W6RxpfhY6ylga/pa85KHQiW3w==
X-ME-Sender: <xms:mQcgaYNUjXHBPEXCPkVfr3uRDQQHa_R4Rn0J3NryjZY_U7vMQ_68ow>
    <xme:mQcgaU9Ncq5LJlRM1VzzRTl0TWiVeRy6WElkz4a9nN2w0JO-kMOa6fa-pkyX5dbss
    dHSegPAjdj0JH1Apa5yl67CYsmHrXOz6osoh5KIGwTwslYiWevrcQ>
X-ME-Received: <xmr:mQcgac7aPPPxFn7LTtMMVQgnB2FbF-cyUzLs5hVI0hpLHsyS4yjGw21W7WH5Fu5tGtTLI1im3zzU1Ra76eOnc3WDk07hHxOTIp6r26BxnsGy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mQcgab2GQL-TXjdG7H5nnICiDkmAcv4MLbhU_KvcPRt-jNrejH5IPg>
    <xmx:mQcgaTCqiW05o66o_4WQJvoZbaf9SjiCYCfpeDvjsrwE3uHwwNj9Mw>
    <xmx:mQcgad2BXHRVLcDfbu7mwP65GTS0wTgYDwEJ0wS38NSvS3VA8bOX6g>
    <xmx:mQcgaduLYOG4CNgz2he8qc19zyGA91ubVENKjlyVZh_Qu0lSjN0D1Q>
    <xmx:mQcgaa-fHlAEZghYYDQNoyfmONqseiqTkEZriXHh68_8_Eg6genjap27>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 01:32:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 280195b3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 06:32:56 +0000 (UTC)
Date: Fri, 21 Nov 2025 07:32:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/18] streaming: create structure for in-core object
 streams
Message-ID: <aSAHlQtQuupprYw9@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
 <20251119-b4-pks-odb-read-stream-v1-6-adacf03c2ccf@pks.im>
 <CAOLa=ZRwk2DPCG-kWs-g7qtjBbXc9QuZgumxA3y54JsJjGpM=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRwk2DPCG-kWs-g7qtjBbXc9QuZgumxA3y54JsJjGpM=g@mail.gmail.com>

On Wed, Nov 19, 2025 at 10:14:28AM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > @@ -426,22 +429,24 @@ static int open_istream_incore(struct odb_read_stream **out,
> >  			       const struct object_id *oid)
> >  {
> >  	struct object_info oi = OBJECT_INFO_INIT;
> > -	struct odb_read_stream stream = {
> > -		.close = close_istream_incore,
> > -		.read = read_istream_incore,
> > -	};
> > +	struct odb_incore_read_stream stream = {
> > +		.base.close = close_istream_incore,
> > +		.base.read = read_istream_incore,
> > +	}, *st;
> 
> Nit: Almost missed this `*st`. I wonder if its more readable as a
> separate line:
> 
>   struct odb_incore_read_stream *st;
> 
> All good otherwise.

Fair, will adapt.

Patrick
