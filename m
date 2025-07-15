Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A2022CBEC
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575574; cv=none; b=mhOIjQ8cgJCLV5iuKcy/t70aUJbR37l2em/Ecr4VeI//2F6fIPhWpy0MPzIs3WUcaAJUsSps8hLabm5S7Qgw0uDW+pIalz6t+dGgEi2wAFaE5J54H19VqgEr0trXKj3+Tugrox5ueqki2pObC76yyx7idO8WVuh9PtfSK64YTtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575574; c=relaxed/simple;
	bh=aOtX8V0sYbMUUIRW3KSYiY8lOJJdzwtjXsTY0hwxNp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AROIGc6h6YdSn3b9f1lN45e5rctALOF8174mC90GRSqxhtOihRjtcPjl2h1jxyj33dz5Yl65uTAP4L/I/CoIiaD15lDvzluBxqCkdrhnJtXRRRTRIN52hPhEd+xTBk1NEeM7ewB2hDH9Md7IBMkxLTcmmpiiu6cwLDj8tRZqWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hq/80En7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MYGJQ/uH; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hq/80En7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MYGJQ/uH"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB527140020B;
	Tue, 15 Jul 2025 06:32:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 15 Jul 2025 06:32:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752575570;
	 x=1752661970; bh=phRRrlQNCJTLWb2gZA+vlH3kcf8H8M5hbbv4+/dtbLs=; b=
	Hq/80En72Z9oAVYF1Xjt0LSLsKcUoWxbAXnjVkLoeIQ9cLNmyY6W69eXMd7ywE+8
	kP8Jc47HeiM8lYhq0l82igeRHay0bGeUaLKcr/nMVE4DiJShEE1d9TG8CA6NzT2x
	mH/NG0c9qfhlFbOiLPs3uqRS4hJi2HccEoBCn/av563l8UHQ1mkYCe9SU6IP+S9t
	+yd+xcXg+mzBjCvkkVKCHNvrARkb9REq57DPJ5RAofb1FYFvA9f664pN16D1J2KN
	LO7Oh3rZAxZxFPtQds4Oro750KzEKl3SjpUmJ0/ET7xhK/00eCfBy/irBWnEKeiN
	yjMRWk1W4HH0E4r0q7XLNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752575570; x=
	1752661970; bh=phRRrlQNCJTLWb2gZA+vlH3kcf8H8M5hbbv4+/dtbLs=; b=M
	YGJQ/uH1aItF/csXUDv0e/+rj3rSVrzkp6qA2p5Z9ieRJI9ddsOEA6mksGWwDN0W
	FI3dQzBmaUTBjBSlM1kTYYLI+cu1CyQZnpIIt1+aqEourdRf/UHt8Cm+dwQvsa1d
	aTj6jojCGWvGAeqPPCcCELwObma3U+FJBjnyU9ieCOW3h8if30XZuN9P1vviocPw
	svNojwtAQ1M7iKBLB4fL5Z7KX4cFzHi3HG/zRLE6RnCmlaayqVIGu8nLmXfSP7P0
	uS33+4B4wvnWxBpiaIbAjDIJmWk60lawunN4RPqC0cQCioPbYN1AsglIIRnqp+gh
	uglLc0bKVptb4dbDdnNng==
X-ME-Sender: <xms:Ui52aDC5Dkm6sGo3h0qfp6_6CLm2rNEBWJrSnTkA89OqwDQHZLIupA>
    <xme:Ui52aFCM-FAopA-5mgYAZewOm9PTqep27gdPbZOybVkkUb_bvwgRafR_6JmnE9FT4
    kJ9i80uXRLgoR5kUw>
X-ME-Received: <xmr:Ui52aFDIRAcr8rEmdERlC874rMPoHXVM_VlfgEX0syfjNbjeg6EpVeD8xj3kR2KqwATggWARUyGw5q4_c2ly2yYsiKnNdV46v1z1W9RTysHkKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ui52aArnFiMheCZxFPkQ_rQAgPXZrhNHFG4P-BUrQKQ66l6CL0fhvQ>
    <xmx:Ui52aPm0hzHS44-Oy_U9AZyJLN1dROoatV4Xye3ZaFBVHh4JbdmQIw>
    <xmx:Ui52aAwMJR2Yy5udLI5u-hK_QgFY3WoBzhBLbno2CBRUhHWlOBMtBQ>
    <xmx:Ui52aH8qGiw31rM4hMan2QyFGBJTFWUktragV41Wfhm49XGUm84MPg>
    <xmx:Ui52aL_b5x2NjphfbsoKwyaWfQMCb-jpOUdBqbSnnb2Vf2t45PwR9erf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 06:32:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e468cc5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 10:32:47 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:32:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Carlo Arenas <carenas@gmail.com>
Cc: Eli Schwartz <eschwartz@gentoo.org>, git@vger.kernel.org,
	gitster@pobox.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
Message-ID: <aHYuS0OgW_mPE34d@pks.im>
References: <20250713122341.17976-1-carenas@gmail.com>
 <20250713174807.32444-1-carenas@gmail.com>
 <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org>
 <aHYVdMii_rP5-ywa@pks.im>
 <CAPUEspi2VJ5OYTFvsdZSn9_+rqN=x_o=Uwchw1fJeipvDF3LSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUEspi2VJ5OYTFvsdZSn9_+rqN=x_o=Uwchw1fJeipvDF3LSw@mail.gmail.com>

On Tue, Jul 15, 2025 at 01:56:44AM -0700, Carlo Arenas wrote:
> On Tue, Jul 15, 2025 at 1:46 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Jul 14, 2025 at 09:55:27PM -0400, Eli Schwartz wrote:
> > > On 7/13/25 1:48 PM, Carlo Marcelo Arenas B
> > > > diff --git a/meson_options.txt b/meson_options.txt
> > > > index e7f768df24..f63ff32556 100644
> > > > --- a/meson_options.txt
> > > > +++ b/meson_options.txt
> > > > @@ -45,7 +45,7 @@ option('gitweb', type: 'feature', value: 'auto',
> > > >    description: 'Build Git web interface. Requires Perl.')
> > > >  option('iconv', type: 'feature', value: 'auto',
> > > >    description: 'Support reencoding strings with different encodings.')
> > > > -option('pcre2', type: 'feature', value: 'enabled',
> > > > +option('pcre2', type: 'feature', value: 'auto',
> > >
> > > This part is fine. We shouldn't default-fail if it isn't found, when we
> > > can't expect it to be universally available.
> >
> > Agreed. I guess tha only reason why I picked "enabled" here is because
> > we also got a wrapper in "subprojects/". But with this new workaround in
> > place I agree that it is sensible to switch to "auto".
> 
> AFAIK the "wrapper" fallback still kicks in when the feature is "auto"

It does, yes. But with 'auto' as default it means that we're free to
disable PCRE2 if we have detected a broken PCRE2 dependency.

Patrick
