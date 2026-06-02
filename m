Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED3273D8D
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412212; cv=none; b=JFlUWX5k/zbhNbQrAMkpxWBWHXZsk2jhfEkMgHCAtlIzl7RhlFIPaNQNdeH0IK3XAonMOk+ivr5u2RN0nsPOAbjcKw+z/N6WF4KEbEWqcbaAbosE+qgGkqf0ilwWAK6mdCn6NtEYrkas1YyQXL70dvw+2A9riHE8b2BZAfuskWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412212; c=relaxed/simple;
	bh=IUkIWOSyh1jtKAQHlmJCNYw9x1FTLGLWDu2blNrBrCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urLDmKCa4nFxPDS5Lrshavynf0viwrleMNATjUCtmGZLFzUtNMz6LywrYRmaJNk5G0IVJMMl9g4zEcIa6KvhSy42s9MJISOCeIhwCZinNRxEwWtO1i4N1MT01bx2Sccd1VpM4Vabm2KkwwKRUwXCMp6iDZizzGG/m+/29kMtLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ekAPXXjm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FdsmK0pc; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ekAPXXjm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FdsmK0pc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E1B21D0013F;
	Tue,  2 Jun 2026 10:56:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 10:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780412207; x=1780498607; bh=W1y+OhDYCT
	RTCTsUI6XLVQqm+GuAg0c8ohg6eMixR0Q=; b=ekAPXXjmyN9LRmQabFBbbptWFw
	KR367gthfUbrGbb962AR8tNPi3IIxeo51uDIKI2gXZ3dzSP4CI8FANPTRQSuUuJv
	Es9IclCNzXkdIISdlrgbv61xvV5yTQtw8JYiR/QfQ6lI9i7PyGA5o2/5v1HMLu0t
	Y/GtM2PssKNqU9RCTidJIVZ3ghUVNRY2tBvulQMluHpf1UngEyU9bNk4fxZf+/M4
	38uij2yL9pb+BIjaxnj+5Apx8u6xOCFcaH2sjAEwe5qB6kxELMQ7ZZevy4DlX1wE
	e6lYF78/HQFxti2h1Fjv2lVWZBQISIA/w/UO5MhmKEKE/AEie/bnxR6krs1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780412207; x=1780498607; bh=W1y+OhDYCTRTCTsUI6XLVQqm+GuAg0c8ohg
	6eMixR0Q=; b=FdsmK0pcgV8Rad+mg1FLmTTjn1ibP4n3pe/VZpqTcL3dtZMDFuZ
	38iUB7RaqXeZqpnfNPPao1PhR+UFAg7uyyhYZWmvBpCjk/Y9VCZRKs/pJrs3LLkf
	Pcuc4qfckLEnLuEnOWpxiEw8W8ldZGxCpURvQ0fW0L922RIESSt+sWetqR0dUriF
	apLJ0IXUfiO1iCr83JHNIeuI1wurwB7y93df5tPdTICsc61cJ5pYycZ0t+FoLRbh
	cDi3su0x8GYLCqV7sKjN+nW4M8GwqSnFAMjv2KCCKcpQ3e85W1LwCKSFI5O+3V4J
	Caz3djI71r+YPhOqzbF1ICYha55EHs/F3qQ==
X-ME-Sender: <xms:L-8eatIR4Ydsd4SFgtfLNkI7WzCnnJ4uKftpdwLfkWWYXiI9iqoymQ>
    <xme:L-8eavLhAnMw2slhigjrpqahxzDdhSBfya6DMVEjDkVeG08_yv-9voj0QL7g5y_jE
    A8-H9JIoqWRvFMm1nf5Ji_M2yxvVfYNEbMP6pWfWXyk7fjjYzELcA>
X-ME-Received: <xmr:L-8eajWWmurL9qdau-UI0BqAWWoQlbqq7x38p_Ic02KHYibyaRgdtMbd9PtTuSjLK2T5Z6R5AjTMwDvFGf4AGberhpCAp7e0lbn-KyySxQ>
X-ME-Proxy-Cause: dmFkZTEla9foJiIxJ5cCR7SKYW+AOg4XV35ahKMfLHdL0icgFoZdGKui4E/W75Lr0YGyeg
    tYS0syxnLU7STVzgEtS0cI3P1hNiBGFxs+fl/tZlgjgIRkRlVMcuOIqjBS9LlBqIzZ7GLe
    F9qNgEEFw93VKSWNooN+k0yMRPGpbG0qrt20l/c51dG7x+xWJ3CXH13G93XghFR+XEwkqC
    ZXKK2xRtlVFUvhQIQIYY+F3MmPfFml6b+ipyfslYoyjx/WYnNlKXWP6gE7N4s2Y2g8F+gu
    O70yKz2WyYhS1q9tqI/CKKHxoqp4TfsVRmo78RW9yOoNF4kdHJV50KWOXb7wg4haGVkSah
    fWeJ3+OJnbLaWc6yunfvSeTko9qnSuV+cSkvFOsfJct5+dJOTtDzy87irVZBjSCg0R8+gB
    Gd2VXAWm1tyhE0nXN/fiDN/G+DIyaFrUpTzrYtJM97bVsYfkFL1JAvwQME84+O38ecfPAU
    x5CfSXQqY4LTQZNuj42Pp6Kd42jU+X2E8LXYL9TaztJ59KdMdx+8cm2xNtsLM+/r1emB+q
    oF+DPcM+sDQw4fLMA3VHYhYVGZf02T9Q7VDDwx3a97wSUv5Mg+8+weCdMOxQNyb/C8fWNw
    xOmHTJ8cZ0wtibLbf8e7EHLh8fPqXm9JyjF8a9VvdGaNEJTLklDkk05MS8Ng
X-ME-Proxy: <xmx:L-8eapjbe12ln0i4DQVHqsCYzy-45xJRFO1XR3lctxYctfwCxXf7dw>
    <xmx:L-8eam-N7T6XCe1e1dvuZA6s46GrOe94iEFa9PpxDl4WipsweaVC2A>
    <xmx:L-8earDdInoA-Nwkf62W2ovaGtart_bxU0v8fCYaJgCQoI81a9INlw>
    <xmx:L-8earI22S28lnWJTIPg3YcaczgEpCvsqbsqrnSQ_FbiDxcjeboHmg>
    <xmx:L-8eaghxjed-aczSnyWLxAR-mTJSvQ3jsIUTwebmJGZP-ma8wBsClmKe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 10:56:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c7ff575e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 14:56:43 +0000 (UTC)
Date: Tue, 2 Jun 2026 16:56:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <ah7vKc8XTKdpcHuH@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
 <xmqqldcxvziw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldcxvziw.fsf@gitster.g>

On Tue, Jun 02, 2026 at 10:32:23PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We're about to extend our documentation to recommend b4 for sending
> > patch series ot the mailing list. Prepare for this by introducing a b4
> > configuration so that the tool knows to honor our preferences. For now,
> > this configuration does two things:
> >
> >   - It configures "send-same-thread = shallow", which tells b4 to always
> >     send subsequent versions of the same patch series as a reply to the
> >     cover letter of the first version.
> >
> >   - It configures "prep-cover-template", which tells b4 to use a custom
> >     template for the cover letter. The most important change compared to
> >     the default template is that our custom template also includes a
> >     range-diff.
> >
> > There's potentially more things that we may want to configure going
> > forward, like for example auto-configuration of folks to Cc on certain
> > patches. But these two tweaks feel like a good place to start.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  .b4-config         |  3 +++
> >  .b4-cover-template | 11 +++++++++++
> >  2 files changed, 14 insertions(+)
> 
> Shipping a sample like ".b4-config.sample" that users who opt-in can
> copy-and-edit into the final name ".b4-config" is OK, but I'd rather
> not to ship the configuration files that the users would want to edit
> (hence making the tree dirty).

I think shipping this as-is makes sense though, as it allows us to make
b4 behave the way we want it to without the user having to do anything.
If users actually want to reconfigure those values they can by saying
`git config set b4.<foobar>`, as the repository-local configuration will
override whatever `.b4-config` has.

Patrick
