Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0DE2AE68
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786451568; cv=none; b=uK1AvX6ttyRqVoFxN/g3Pf1HtlwbKhrxFoOauDqqNc4BniQonXNyfI8pC8E6Y8maarJ0iMpBUUQT3d2FwABFuClT+mAyZtfTmma7OWUnQejjGOuVRmEoLnVc+fckAEx79LdvX3yv+g5i+h7cCTK8fCQanSH8sW3FkflnZ+B3DMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786451568; c=relaxed/simple;
	bh=QUsHOh5YxXHQBZG45IuMH/U0ijEMYF3Bm6a/l7bl8Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBkguis1pxLpeVspEd2Jj3H/A8F96QXKzvxrzGSCq4yJJRrQaQsHQk+LfHGD0xBKXRGOY6EQf8jMkLnb0DUkxOetx3ySwekWdsaGQ2Wqjv4CBS2Gmhlv4BB6ATz8A/J/ENQkuI0PcYyMFhDTYs0WisWoE96A6E9FFEy5yTsPZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cmn2Sp35; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUEyIqWE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cmn2Sp35";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUEyIqWE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 63164EC01C5;
	Tue, 11 Aug 2026 08:32:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 08:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786451566;
	 x=1786537966; bh=51hEtbQZkP7/kgHsD7/7dBWLz3rre8FRSY2SH2f8GT8=; b=
	Cmn2Sp35ZVfosVILR1zAG+q6cnmSXX938BQkoqHrkoPj6YrvWh5e4Vp69dmKV78h
	1IYtJhbz9AtD2aIAsrwxEy3Rbn1lIFQnEXA4cFPP244AkI14ernjbfAQWvR9Uc4E
	QjtF/BPNOX3LtBA/8jrDIy0lam3y/Nkpi250quVAZH0IWD/TE1N0cuosvgIdaylb
	a+ajTeTDe5HFLd9uAxnmm+wSPxInXjzy6pQxuCQz51CTwz3IoQgEJh9eJS/yT5SX
	ffJUGso4w/iYRdyEU+gg5G8YL19Fg942Q0f3CuI8xUoI6lC03YxgbGxgT5Oci4XC
	H0zv+71ywflN2+V2RY4G+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786451566; x=
	1786537966; bh=51hEtbQZkP7/kgHsD7/7dBWLz3rre8FRSY2SH2f8GT8=; b=X
	UEyIqWE0zrYpHeBDGp3rqyfsu9Aktx8Ko9693zT2ZFY02DZvjsA8MAiUUmBrrxiA
	XnhpRO9TqHmRh5ftUC8gE2cRvu1+KAvDhq4IQJn8ZjO2/H95Z0J6TJfLluIkMRo5
	wh11BrJJR2wCRZxmNFODBnuoBx1bd4KZ2iERZGrJoloJSOU9v4KEuRo+dX7UT+sZ
	B75RVqAlM7vbg0N/bDZrUUfKGInQJhIWlacDT/XkeSinxoQen4srkIP/5o3UMSmS
	arbwfgFAfP5tL4/ogKNKSp8Y/z2aNBE61r/tw9nTQNFmEnkCLYjohL2KjRFNIzoA
	EXA6QKtC9HFMECXmk3bEA==
X-ME-Sender: <xms:bhZ7al1Lpjq1rVmYeoon7omA_aKcGBIomBXjdHRO2hOrtkqwsaZP8w>
    <xme:bhZ7ajicETLdYWDlX98hJUN0a5u0g8WbOSG_BY-8C4RXHla3T0gIAvIcM0R0GSZuS
    XaA48MdZs1_qGwL3Wr3DwSQ6yj6OZbDvmzGDrHpr_1bQbA3z8Wd1g>
X-ME-Received: <xmr:bhZ7ajTc9-v3u0FIczTlU_QhciSlx1MPqlXHIC844TmAqksnjgkZu-yYeQ5rCdKLULRHRLQTft3f2FS01zXipiKERfc1CprwbfJrDxHa_A>
X-ME-Proxy-Cause: dmFkZTGOQqpdjSskk+2a4rf0EVdYNhJgcUtbvtyp1mtlw94RyU27oct5NmzcNoOgC2/lHf
    iViDkwi7ZnE+3jpHEp6pZOMhQnPU3AsTKBqcxNzpgPmqbyv+ALQawGqW2+zCQCpNWvwqmR
    kVYDAFZ7OfMlev5SWv2T4HXBZD1MZu57Gx/+4yvbDXKroFW4NHygnWuiPlIJHN24HPigZe
    jiK5z5DPXpbajbvoL8QlqXtXQBorPLTO+JEWTqukexazNQyif4k8Dc5v4aYXc/+u4icUlm
    BRKqUnurrH8BWn/EK+5GgU0DXjtyifLsLvhQYN6FAR0GJHOF1BrWfOzQOe8lCLqXPINZj8
    +tvIvLa6rdEGOqB+DlEfPvU8tPWags0biCrPwkQ4glUYJftjohb7TJV4XpxFnxjbShdxpa
    S7WMziJGt8y/g5vsLjdM/WZ2QHxQjqfXfeyCreq10cS7VmWkw82WCS/6LFotFpHd2PriBV
    T9ZxzjD4K2AjAoqByyyO+IEZvI39RnaTmclMqN6Ff8xp4cUhlKCEyukqfbOm2JcC4ofrsd
    7R+lakdbKj9Lkh+F8cNMWVooBrilPkXcmSuWlMDWD0iMgFvPm233JvcxefsxWDx6cUWXZ0
    42Z8zn4HeRiClfCYmcC9RIjYrysRjSow67p4dcTENOenNypKKzxuxcHzjm0w
X-ME-Proxy: <xmx:bhZ7asj9GSk4wNS_B2ohQUFAZty10htE60B8audckN9DWvZ88Wq46A>
    <xmx:bhZ7ar451KidDAkuXyXpwXTauBpoMcS-hW36CTo8E6gYZq5HdFXRhA>
    <xmx:bhZ7ahDL9pds0DOEs82fyLyg78-Kz99tgbhMxqOfTybsYzNPEMJveQ>
    <xmx:bhZ7aqbfF-8fMVFDOwxAQiKb6Z-P5jj-1pgeg4WxXsNlUeJ8i9txfg>
    <xmx:bhZ7ajqGJw8sEhe8Iv4VWVJdaFe5h3WdAOBWKoZa2EQCcWgZCsGSERf4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 08:32:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e799a9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 12:32:43 +0000 (UTC)
Date: Tue, 11 Aug 2026 14:32:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH resend] doc: format-rev: use [synopsis] on code block
Message-ID: <ansWZxZ6lB0tYIJD@pks.im>
References: <synopsis_block.af9@msgid.xyz>
 <synopsis_block.b37@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <synopsis_block.b37@msgid.xyz>

On Mon, Aug 10, 2026 at 06:58:05PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> This code block uses the placeholder `<subject>`. Let’s highlight this
> placeholder properly by using the `synopsis` block definition which was
> introduced in a34d1d53 (doc: convert git-show to synopsis style,
> 2026-02-06).

I'm not particularly knowledgeable in AsciiDoc, I only picked it up
because nobody else did. So please consider me even more clueless than I
typically am :)

> diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
> index 505a52feccd..836ba4b0c24 100644
> --- a/Documentation/git-format-rev.adoc
> +++ b/Documentation/git-format-rev.adoc
> @@ -96,6 +96,7 @@ The mode `--stdin-mode=text` replaces each object name with the
>  formatted commit, i.e. the format `%s` would transform some commit
>  object name to `<subject>` without any termination. Like this:
>  
> +[synopsis]
>  ----
>  Did we not fix this in "<subject>"?
>  ----

Hm. I was always under the impression that `[synopsis]` is used as
exactly that, so it surprises me a bit that you want to use it for a
random block that doesn't look like one at all. But going through our
docs (like for example git-blame(1)) I see that we also do this for
other non-synopsis-like blocks, so maybe this is fine?

There's probably a good reason for this, but can't we instead just use
backticks to make `<subject>` render the exact same as four lines above?

Thanks!

Patrick
