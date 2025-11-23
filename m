Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B701D61A3
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924364; cv=none; b=aIxcQPeOiH9aV2TtQOyLHhqXU8M8unE3a+GNslFzCj8+xLumSgd+vdeACC8xZGqRJINpdruARTYu0K5AGSGYcvvIpHk6PcdiDpjEzqGOSm4Cumg3PHJskZvkcsVUrOA2RShcE9vIfygEk3/x1DZxFEPMXpAwUH5A8s1VR1qQHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924364; c=relaxed/simple;
	bh=2br9tQOpiif/RaiSxSKzcIbW2NFrlPka9rlmTXZgl9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVA45Gyvp5vL6fJMJ0lMeO1aBUNphoDU15uOyedUyjFrgnkEtDLcUgMcnmzx59gnDwrbH59KhnxgbX/YbfOuJAXOrwWRCa+1yIEVudGMUVltXfx9yJUEuREiD1FomjCvWZDBTSylMHeIwzPCDV7F/gKD16HcUzTr/mUJ/zKCj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dk/RKGFq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1dT088Ei; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dk/RKGFq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1dT088Ei"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8519F7A0091;
	Sun, 23 Nov 2025 13:59:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 23 Nov 2025 13:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763924360; x=1764010760; bh=c1GElA1vdb
	QpWYb/X2v9BHD+q6CPQcTre0TfpUqG4kY=; b=dk/RKGFqNE6CaEUJw5TfV9B/JS
	tDbJjLq1ywfeXbtAKEdEsFWJBLJoamvEt59493TWvzmX6t4mIcyAHzwsN1fb9QEC
	g1fyFiBZ89fNPaSo6d3pk+N5fJXZyMOjS0MXy+CqNF/eEjVyU9HjhfPrqWsa11pd
	s1afK84JP/RyUUxxtaeadimmvkUVnQZSnsJ7+SKSuBiztgWaDzvIub6zmcDPa2y2
	wZP1zs+OrFb2Vscw7KJY6j1Bl7w0jIGSU4Lg/+RCe8zBBOrBvWOzBTcyp2qRrisD
	DgydlA3X6ge6CQ+K9GzKGzcCVHZiFZ+7JysMHmhQEPyL8eOoC7rSvioM9yyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763924360; x=1764010760; bh=c1GElA1vdbQpWYb/X2v9BHD+q6CPQcTre0T
	fpUqG4kY=; b=1dT088EisCDVwdl8O2cGAGjTf04hM08DyZgUx0L+K6HSFq1RTNz
	eyfRfu2InyIqPJ18ZMeUrUQ7AM3rRydRJnfhkEKTzb7hPPhNnvZM/VGupjFVX9ru
	1vhmIMGWUu5rsxXfAvUhv3TkFbQ4Eb92cCt8yglYEhsYB2yTo4o7vRaCjr9bJCiI
	BHlCt5zRa1a4dKdIVBcQbJrTxj3Lag0fMgfQYOskmTtkCDo/OtvzE5qAx3FtrPFV
	GoKhrmvC73FlIAhfdW21jx2vZZV69CN3TG0vcvr3Na6boD3f35Q0+vUAo5bEnGeW
	Af3XGACMDQV7GeVKhzuONwuGMOFMspSkcXg==
X-ME-Sender: <xms:iFkjaV16e9GSISfymacBQTDcDXdO-DKTfIE1jR9ntrpt6SLQvxUzhg>
    <xme:iFkjaTFobfh_gZ767t7HBWr-MRiB-qfBeLbOQbrbHfmC8Xvusqto7Ku9WLxl42jg-
    dSCu7oHYhRle_Djv3D5baVAl5LCbxzl7jNVpXF8QHTrjl-ZwEVtgw>
X-ME-Received: <xmr:iFkjaa5wRwvgEVbPkCqLY61CTNWz51Im-HxazK036lKs0WupdP21fPDFTCWkPyNgvFnCnAKDaXcKsTIXDJH6lXTmRJSUVdeGBsi7EI-i7yznng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iFkjaRtcL5rXn1FSfmke9HFH6wCH84d3ZCFHmENc-WuEQxIP7lreXA>
    <xmx:iFkjaT6vDzM0cobCrWhMqH3OfC9rgksBtf_OCf78cPDZH1TLO3rG1w>
    <xmx:iFkjaUWf3XQgjb_TbVcvlsrqS-fD_l7TinWPbtNTLndNk7gS1ZQNcQ>
    <xmx:iFkjad_h-xDfcTgVYLhIyqevUYykqi2GnKKTN_u-8AMuMo-eTB9OZg>
    <xmx:iFkjaaWZxZtehhZq6uV6nw83-sjHdg4APdTVr5WIe2oFV69ttxyKWiwe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 13:59:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f84ceee1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 18:59:17 +0000 (UTC)
Date: Sun, 23 Nov 2025 19:59:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 13/19] streaming: get rid of `the_repository`
Message-ID: <aSNZeyoVWDVTU4X_@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
 <20251121-b4-pks-odb-read-stream-v2-13-ca8534963150@pks.im>
 <xmqqh5un41fv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5un41fv.fsf@gitster.g>

On Fri, Nov 21, 2025 at 11:42:44AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/streaming.h b/streaming.h
> > index f5ff5d7ac9..1a3de6812e 100644
> > --- a/streaming.h
> > +++ b/streaming.h
> > @@ -7,6 +7,7 @@
> >  #include "object.h"
> >  
> >  /* opaque */
> > +struct object_database;
> >  struct odb_read_stream;
> >  struct stream_filter;
> 
> Extremely minor, but "opaque" used to refer to the fact that "struct
> git_istream" is opaque to the users of this API.  In a later step
> you'll remove the opaque comment (perhaps your change in that step
> will stop it being opaque?), but until then, you'd want to keep the
> comment next to "struct odb_read_stream", as it is my understanding
> that object_database is not opaque here.

Good point, will fix.

Patrick
