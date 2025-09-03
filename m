Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7D2C15AB
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756874385; cv=none; b=XDDMMEbeNGNbRUxau+2Jr3FxE748CXqJ6rCwxZapkDgKiXnqHJ09OSoU23z0fqWtNSVL9DdhC7PwxHNjHXZ7e7OKwRpjZqMkKBkvX1+3+cWoFAmcL+tg7nguS8zA2zNObyyh8SfsJg3u9RVSRBDjROlSxpg6s4sdgM69O10U6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756874385; c=relaxed/simple;
	bh=J4Cz7e8qWabTXpJQ+5p3h1vrlr/M7WRGDW8xC9V32C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwulr7neN1mPODXFxvE9siQHqRXWuCKhbBexOor7VD78z9Ff7oFM7Njlt6HswB5Ad3DRKlrjrtfXmb5A1AdIUwjgkAcv40oCJDIDa8QFHBpVsyJCMuvAnZj7sWwspPdzQSvH/omHQrs5gr1qc6+T6bPvtnscm0RZKI9v1L+HjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kVOF8fbo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H5XurVig; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kVOF8fbo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H5XurVig"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C5A0BEC0338;
	Wed,  3 Sep 2025 00:39:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 00:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756874382; x=1756960782; bh=z5Yo+8myKn
	LVaevSCgRvBnl1pFzG3SSKwTp0vlu1Rls=; b=kVOF8fboXOAsS89Xqp+Db2heT6
	un2UiPNcB7EMvVkV7O/pJftXCRc8/K8moZDpfYac/hOK8b9PF2KtSdZoNJmvs2A9
	q6qtYPyOg+OikMaYClEsgVskA9RieheIMA1yOIP4crgR9Xq4UrfihtP3syNr3gfu
	4myWERU/Fdpck8s3Kh34GMARyOF+6ZvunNppCbG9/31wFpGPPhYxvBm9zqRbCwI0
	RCy3iwarl8SxOip489aCZEeAsCd93ZgUwONkVWA2UAVHPajgQGSRgKx9ObbcyI+D
	0yBv6Qk1XHSAnHEf8Gu9nAchjI6ma+FyGjyVgnTtbVyfIVyNzwsBuJodXpYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756874382; x=1756960782; bh=z5Yo+8myKnLVaevSCgRvBnl1pFzG3SSKwTp
	0vlu1Rls=; b=H5XurVig2+lXT3by6t6sXjpny2Xc7SYCT2mw38Yw6xWLesoHFE/
	VTCAamOHTCIbrWqhVx6NkUBR8PwHt2vWnNIp+BeCOCbFWksPnUkJroOY/cvRGfdp
	lZbej6mGsN0+mi1d5p1EMkHN/oOBrWRZVhHDUfyMYG6buMx3V6ea41WAEXmSUZra
	0OsdCP+RZck/LZGwjFHvQsKg6TT5FIi8/Ach6YI/CQcFa1bgrwS5gDX1rn19bBbl
	SlqsWX3cKphlaJT5ZZeNY+tL9jD5wh1TrxAVFbAzELMKqyygX+bT69w5T9iZZYdu
	GzO+diy/AnwlLrWOQYxWxxPfjfIJvSBt+ng==
X-ME-Sender: <xms:jsa3aA-vbovOS1VbqB1f-M3Ztv5PonbWXV2YGyvsqaDhtSiNp8cCmA>
    <xme:jsa3aI75hGcrdvUvWuPnSV69TYAOByl0AupaEzd5Aio9QXCO-u0KqJktePbyEMJO4
    I1v_7kF1B3xEHZbng>
X-ME-Received: <xmr:jsa3aH0elua4Sd-GqV-YC1IYP4kB8mOTEuHs6jRqXi1lt5aV4OYor7BgZWJnOc-GM0xijnk2TKBLo1W46WSwqQzTxNK6xTZ_a7IPFgM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgf
    eugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jsa3aPDGUXjxIfxBvYIBgpYmczet15cZk0-uKfMptP9oSmDQU4Oscw>
    <xmx:jsa3aJ0_ZdY1O_DpbOfCKRsIOFjXg4KclYQY7OYRgcDxNoZfOAXRFw>
    <xmx:jsa3aJvWk-Y0OqYeRX6Jg8aPIDX82_8q9IISgQfLwDtm2P1rleG-AA>
    <xmx:jsa3aJ6Zd_LRRAKGXNQbv6TJDElq0J5r2YNG_FnBFdBw43ObZv_lgQ>
    <xmx:jsa3aDheB90CoG_2WMrEg3QrR-ziEUQWwwLxLynZGJ4I8LSpuOKTIjG2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 00:39:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 93ef824f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 04:39:41 +0000 (UTC)
Date: Wed, 3 Sep 2025 06:39:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitlab-ci: disable realtime monitoring to unbreak
 Windows jobs
Message-ID: <aLfGiYisf22OQCvc@pks.im>
References: <20250902-b4-pks-gitlab-ci-windows-defender-v1-1-fcb1f19321aa@pks.im>
 <xmqq8qiwlsn6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qiwlsn6.fsf@gitster.g>

On Tue, Sep 02, 2025 at 09:35:09AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The GitLab CI runners using Windows machines have realtime monitoring
> > via Windows Defender enabled by default. This has just now started to
> > cause issues in our CI jobs using Microsoft Visual Studio:
> >
> >     Program 'meson.exe' failed to run: Operation did not complete successfully because the file contains a virus or
> >     potentially unwanted softwareAt line:356 char:1
> >     + meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcre ...
> >     + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~.
> >     At line:356 char:1
> >     + meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcre ...
> >     + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >         + CategoryInfo          : ResourceUnavailable: (:) [], ApplicationFailedException
> >         + FullyQualifiedErrorId : NativeCommandFailed
> >
> > The detected issue is more likely than not completely bogus, but it
> > breaks the jobs.
> >
> > Fix the issue by disabling realtime monitoring. Besides unbreaking CI,
> > it also improves our build times a bit:
> >
> >   - Building Git goes from 26 to 22 minutes.
> >
> >   - Executing tests goes from ~1h for one slice of tests to ~30 minutes.
> 
> Interesting observation.  I didn't realize that we are shipping
> virus or potentially unwanted software.
> 
> Does the same issue exist on other forges (like GitHub Actions), I
> wonder?

I would assume that other forges already know to disable realtime
monitoring by default. These are throwaway machines anyway, so there
isn't much of a point in having it enabled in the first place. And as
mentioned in the commit message, the Windows runners for GitLab CI are
not exactly well-polished.

Patrick
