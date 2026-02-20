Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD1334C13
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574426; cv=none; b=sEAZvof6f+kiBQtVYEre14YKiq7WDK+Jw9S7PECbFnzKHOl4jNlikwRwehfP9HwuhCGJZxOdQfuebBrP0pwnFYgzW2PRWiiugYXcBLHFHgjaSx2dE/w+lU7LP1fwUZjMS+GDmAQoM4OUTBMXfBDP5SJXZ6dTc2XsVyGLRX0QTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574426; c=relaxed/simple;
	bh=wuErlDw+lplG0DZbbmditznMRdGJI99D02r/VRt+Mzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USThC2H3w04ZAkbblWdPDNi9pTYLl1A3V6UVMduQbnmwoWJDXpeGEKJtgpX3mVqi1FIZKGo2WcELetQ3eWBgscGTL95hxDdoJKIK5oVjq3rAaYt9CN3od7nBgVgJgecG4A2o71j5MojwPvN1QlOmr++swGARJpFuLV3SLTmdjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pEvze+RE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nhx8vB83; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pEvze+RE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nhx8vB83"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 20B741D00091;
	Fri, 20 Feb 2026 03:00:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 03:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771574422;
	 x=1771660822; bh=/MyH1HDAy1iTp0g+/VsOtdgVD0zzOwh5FHoibhR7dHc=; b=
	pEvze+REzYLSVtSNxtr990iD9B7P6R1cA7gIjFphUk/E3X7kALudAmzzR/c7PEj+
	C43abmfm63e/FFLDvTJPOW70cbQmzrm2cfsYm3wLTrPL+2jNrWiBP3qZBpMCCLAB
	eoh3q3hjwLuoh/KzmsobeZxQs1CAzD3l0u6L/I7oMps94nKaYnT7Lo7HZqLLNbeT
	BPPYZxMY3IGveAENNSApK+toELW6+wHnxi2RwLYBwVpw4QOoX4PpXAV9/b4qS4c7
	+MMlVjZD5MAxcclo4BD9HAcbSlRv/DaLC0wNk+iChX+4Y9GHYqPvybD5wgJq1rrY
	ny21E3wLwLMjukuFBMo+uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771574422; x=
	1771660822; bh=/MyH1HDAy1iTp0g+/VsOtdgVD0zzOwh5FHoibhR7dHc=; b=N
	hx8vB83D/N2cjmLo9A2mcx8i9ZoBCInLfYMZYSbNsJR0VjHAsFFm2mJjtcXwy0zE
	TtXeGjvj6AXEfAYFD8tNtBJu5+xuylThM56L7ON/sFH79Xn3aC/DwT86pTCVf32c
	7fX6QtbeY4nB4DC4u0Kb3S1y1R5bqdBYsvVCeyTU5HnFzAbh1pHY482XLPiNcJqW
	dJQyiuilNzxkueuMSSfTsGUxUueSQ+m5jrV3AlqOdyn+590HpDt1p+IhIeAuDq6Z
	kVyRM69RoKAqZjzsE8v7V6l/0nNvn1RZnITG6gamxQTxjEfXl+0yrVjAulf/KpBQ
	fN1X2ujH0/AjwOEV9otoA==
X-ME-Sender: <xms:lhSYaXY0TZwoHU-SDuH1vCE2DjMwRy0_wRKYahK4f4rKlrsPMnJ1xQ>
    <xme:lhSYad1Rm0xw-kjJab-h15jMwa6V6BF9ij2GgQjDEFWv__Qr-W-RWIS8zJzaqsxTe
    -pLaFwlC-dfoaDRy5WBJcSEjcUYx1PjBUjRVe_wnvbLGtAPATqdKlY>
X-ME-Received: <xmr:lhSYaXVx6HsuR9zWACvQFTaJZ5rw3AfqbwPjPUFzKohP0jDa3f5RQU1D0ROBj1zJ1IiEsgzk5qqBKZ69UCfZ2MZbVP_z7qV9L8IHzhCu2Lp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeegiefhuefhkeetueeijeehheejveetveefvdfhleelhfeigeejtdfgtefhieeiteen
    ucffohhmrghinhephhhtthhpqdhfvghttghhqdguuhhmsgdrshhhnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegthhhrihhstghoohhl
    sehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:lhSYaXXwjY4V7Gq4pFs2aBSYL5LSxn8A23ox5tNZ10kpGmT7aR8qJg>
    <xmx:lhSYaWf7tcSshAvpKu3j2sCLZ1iRNRdxQ9vvg1LHDcGkZZmt4WOi9Q>
    <xmx:lhSYaQUW4GBZ-1cFTahHY7ZxfOGzBJrFeMMWfJglAXK0czKfFzlSiA>
    <xmx:lhSYaffnoKNRWzg9oxwAfS6oIaCIRHzqP_K8QD98UMr9JvdWPjmgnA>
    <xmx:lhSYaUIpZMNN3CDXLbj3ul9OeLwuH8G2E12Vqe0seUrUslGbhOQbdHYi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:00:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 909bf005 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:00:18 +0000 (UTC)
Date: Fri, 20 Feb 2026 09:00:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 4/5] t5550: add ICONV prereq to tests that use
 "$HTTPD_URL/error"
Message-ID: <aZgUj9BBQUcAwHmS@pks.im>
References: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
 <20260218-b4-pks-ci-msvc-iconv-fixes-v3-4-08c1ff3ffc9a@pks.im>
 <CAPig+cTk_j3qiib1E5McMUPTVY5f36Pq=_8giR_2SKfthY10+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTk_j3qiib1E5McMUPTVY5f36Pq=_8giR_2SKfthY10+g@mail.gmail.com>

On Thu, Feb 19, 2026 at 06:49:14PM -0500, Eric Sunshine wrote:
> On Wed, Feb 18, 2026 at 4:17 AM Patrick Steinhardt <ps@pks.im> wrote:
> > We've got a bunch of tests in t5550 that connect to "$HTTPD_URL/error"
> > to ensure that error messages are proprely forwarded. This URL executes
> 
> s/proprely/properly/
> 
> > the "t/lib-httpd/error.sh" script, which in turn depends on the iconv(1)
> > executable to reencode the message.
> >
> > This executable may not exist on platforms, which will make the tests
> > fail. Guard them with the ICONV prereq to fix such failures.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> > @@ -339,32 +339,32 @@ test_expect_success 'fetch can handle previously-fetched .idx files' '
> >  test_expect_success 'did not use upload-pack service' '
> > -       ! grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
> > +       ! test_grep "/git-upload-pack" "$HTTPD_ROOT_PATH/access.log"
> >  '
> 
> You want to be using `test_grep !` here rather than `! test_grep`, don't you?
> 
> Same comment applies to several other tests touched by this patch.

Oh, yeah, you're right of course. Will send another version to improve
this. Thanks!

Patrick
