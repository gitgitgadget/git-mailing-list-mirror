Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F1222424C
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341546; cv=none; b=t45KLMgV1xqve4Rjhp/VnFKOw43z+QHSMqP/7knQeirM4luL/M16Hg2niuUsTqnYbpY7cGmn7i9SSnmbEpjZ9irSBw/gyfj/nkziewyiXEKaE5V8NO1lEfAu8r1m4CtdmCRUOlJi/90is5Cerfn8qXwEBJTFT8bGAtIYP+G7Xc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341546; c=relaxed/simple;
	bh=oCOkIZe4yEP/BpxRkElE6STMkoyJz3s3K387MnEBdo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4J/uQ9kSdVyYnobint/JKIQtI2IRur1dJb9EMZ2UZOSDTQSvrqiIn0Zd5ryA314mzybPHbvZyKOwRSVrwA5otmG4y821XB5LSD5W/kdvfwa99KB6uX/qSZzE6SEBjIC1AZN2TKkRayrcpPHlW/Ee0gKKYqsnlFDWioSad0Dvjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K3TEKXos; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbOezDFZ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K3TEKXos";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbOezDFZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B87B6EC059C;
	Tue, 17 Feb 2026 10:19:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 10:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771341543;
	 x=1771427943; bh=ovYFcx9DyYPC5kyzeH2NUL8Bv5Ax6UCmIMjaSq2VTB4=; b=
	K3TEKXosabpPuDoPPkgYJ7nIY+hnENIgvDwHtVMJ9Fk90wD8MJViZkvsZ9lZupZC
	68L0pRETAnSjtpS0RktSmGw71rtSwl5lUmCDuwIhFlPddhHMM3QL4Vzw5NV7w3GZ
	mcpt0VfkynzW6rHE7T+y79qZN/woODZRVTDWJ6ynak+tCWpDrXdHcLHO6bSKbszJ
	N4u+0aILCFTauvG+Xt/XxPLLabLkEizHRtB1fbmboa4KhPBEV/ob1Tx7VWI+IXMQ
	v4JzgIy86kzqZ3hbgJ0lNudJSTLMouOMILYsCdsG30ZEIKf5nSK4XcnP7SW8oDIm
	oY8GpjiAmu27ccxasqTC9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771341543; x=
	1771427943; bh=ovYFcx9DyYPC5kyzeH2NUL8Bv5Ax6UCmIMjaSq2VTB4=; b=T
	bOezDFZtXvCk4FIwQZ6R/kK1+QxnvsPgOKhP8GTW6fTWSKcCt/rF12pq+1r8SL5b
	GfrOFPnoQ9zt1eQx8j5HRA8h3iWTu/y1pXlcpc6M5dKpNRyPI77EKOvthREpJslD
	53P44jsBaYcYmOvbGqnZguJCH1bGPEnc/kgXDx8NggZ38Tp0ONeIpn8ItXY9QFzt
	bT14jNoxwCHoiybzxrL7DZRchKUyPQaFflcug+lziW8xvbpNawy4GpD+q8BS+pTH
	QHBUjhqI4LSYBnN45GluA9/W4H8CHsECXkDkv+9F+ERMRdo96B3PmnSq2JSjgmVK
	PWicVzOHoAMMl6PJG2CUQ==
X-ME-Sender: <xms:54aUaQ4IjqWt7ZEB_RVLqsO7fwzudBugIOQYjMoEfROr7E4rYYCYiQ>
    <xme:54aUaZX5b1spSKxKlxPzwZujeQRfr_UuuotuI0WqeFpZQbYJEq4liMPcGHfH8zEcL
    _nsuaubuXKidkqx-idRLRnXQk-UXJQAIVRppDtsp1YTBHCEcC-bgA>
X-ME-Received: <xmr:54aUac0qwwhTW3vsHRJW3j-HZ_YRb76Qn7dLM3CH-d4wU2lXC-f459htYBl9Wfy9lo8p_QeIkEk_bRYhoOjDQVZBodUWbOR7sQLfA_g9mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:54aUae3qUzeH-d41x_pE8Z5r7XIbzH6-mt0R_Y0NmCIHpet8OLQe8A>
    <xmx:54aUaX9wqXZYtnPvN4L3kb_rKeoiEHmKhJ4PnOzBdVj7QDZ5r4VGwQ>
    <xmx:54aUaT2B3KJbilTaNJ0teF4_nHKUi3UNH0hfv5AOpEQDWr_XqH_7Jg>
    <xmx:54aUac_eDuxhovgS_TpowffGnDH7Y6GbjpdmIlIz-5QucNqHt8wweA>
    <xmx:54aUaRWQCNvH4vVMj2cl_UikH9Sj9E9Y9g6Xoq93B2QrJ7p6pJqjKePs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 10:19:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 11ec5df6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 15:19:00 +0000 (UTC)
Date: Tue, 17 Feb 2026 16:18:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/4] t4xxx: don't use iconv(1) without ICONV prereq
Message-ID: <aZSG31TB_Pprcq2a@pks.im>
References: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>
 <20260217-b4-pks-ci-msvc-iconv-fixes-v2-1-25491bc8dbf8@pks.im>
 <CAP8UFD23MdTF3qVFhDFBDcnqh4dqiehvFz_3c-keMhSOa92Dpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD23MdTF3qVFhDFBDcnqh4dqiehvFz_3c-keMhSOa92Dpw@mail.gmail.com>

On Tue, Feb 17, 2026 at 03:48:19PM +0100, Christian Couder wrote:
> On Tue, Feb 17, 2026 at 2:58 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > We've got a couple of tests that all use the iconv(1) executable to
> > convert the encoding of a commit message. All of these tests are
> > prepared to handle a missing ICONV prereq, in which case they will
> > simply use UTF-8 encoding.
> >
> > But even if the ICONV prerequisite has failed we try to use the iconv(1)
> > executable. But it's not a safe to assume that the executable exists in
> 
> s/not a safe/not safe/
> 
> > that case. And besides that, it's also unnecessary to use iconv(1) in
> > the first place, as we would only use it to convert from UTF-8 to UTF-8,
> > which should be equivalent to a no-op.
> >
> > In fact, Git for Windows has recently (unintentionally) shipped a change
> > where the iconv(1) binary is not getting installed anymore [1]. And as
> > we use Git for Windows directly in MSVC+Meson jobs in GitLab CI this has
> > exposed the issue. The missing iconv(1) binary is considered a bug that
> > will be fixed in Git for Windows, but regardless of that it makes sense
> > to not assume the binary to always exist.
> >
> > Fix the issue and skip the call to iconv(1) in case the prerequisite is
> > not set. This makes tests work on systems that don't have iconv at all.
> 
> Nit: when reading this, it's not clear if this commit is enough to fix
> all the MSVC+Meson jobs in GitLab CI or only those related to the
> t4xxx tests.

Yeah, fair. I think this is an artifact of me lumping these two changes
together into a single commit. I'll split it up in v3 of this patch
series.

Thanks!

Patrick
