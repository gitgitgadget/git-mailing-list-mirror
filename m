Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD6A3EBF11
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917288; cv=none; b=Kbcmcq9nm0oPRohEauWFx/J65rEO96y3XtaHm3Cz0Pd7DNjQfdOXCSSQNuTwCFMxDP6z16aPl56pKTVE23phIPAEh6cxKYfnLsmNktaOzHWCstgbhdj/+rcpcaCIA0jsfC2A9VVapv6UTEYj1bYHJ1j9tm4HHiz9CAK099PQ2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917288; c=relaxed/simple;
	bh=BrK14Aro7ypSKhnxfllfiEjx22rQCS5oDsnQbaFccZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbHc76yrX7MRHtfrSDL1n+o/IGUYGyqREO9I4iTjuxi2fFTHrJWqtL9Bs1ZI9RxHwpnRSz5A2y9VGtf6sRPpsMXtgwB9MKUqr+yqzyjYPEiRmoFzRk0vGxYkQOqb71gjxBd+Q1GevctT9O2yHOSHxuQViWS19++Di/OvKx0lAjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XNQdLi+d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JktST1Z7; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XNQdLi+d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JktST1Z7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B1DD14000B6;
	Wed,  5 Aug 2026 04:07:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 04:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785917274;
	 x=1786003674; bh=uVW6Go2qQ2EHUPVM+cvEXoerOcOFPYuQreVM6nYGeE0=; b=
	XNQdLi+dX3Tnn7NGIMD6SMSVUx3byhNt1Ii+U16a1BSH+EM+wNW44Cn3zXx8AlML
	r1JNw9eUONwKhD8/g2Ix3rj+GRpTIv7rfIx6qebzKxyFa2SilRao6+6vRhdritMD
	KjyzfDrLpPNIJh0vyFWDAeDyzFR7FUScxqcGtF+XejPGjW1O5pY8cTCXETqx6nH0
	I2KRjLzxLblqULZntsDwD3zGtDJwMBvBbmXCWpDE0O8DomIQXgel8H0VP9AM45YJ
	Ekp1TdCSsekzJukIRjCiRqE1k28Zl0GJF0A6HlzpNUdKtr/um7UOQ3bd9mzpYcDU
	wzFmuB9w9npfXUbZfVeTbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785917274; x=
	1786003674; bh=uVW6Go2qQ2EHUPVM+cvEXoerOcOFPYuQreVM6nYGeE0=; b=J
	ktST1Z7+0E2joioOpgnM41Oq2KSVlEPd5R+IBUja8bA5Pgp3KU8HvjdSNVyGKfX+
	N460AaNp7EXqXgi29NAMg1vqkDgyJa15IhD8KXmGA6z9VQUys7cmrBLdk8RssQ3A
	mFcPTgqQumdvxg0uSPpw175uXshebUamAo5V+YoZ6oBTbfQLkeQ/59hLJIG+0X+E
	WOhFiajqYjcBfO90OjJaV/i/iZXsLlPR933TV4daeqjRy9HULcA28gtgAPmz+te1
	s08rA2jT5wrJl7YA5iStZUxHUCq61Pli6JU/JuF0xm1mmWRCNW7IF63q0JTDfMpU
	Mlk6tawAUCZyHflk+ZGLQ==
X-ME-Sender: <xms:Wu9yahPAs2R9K-VOfF2SSkDiT_k7yQNoVHwRMxj5IhSNe6ryLtlzgA>
    <xme:Wu9yaq-azE1WPM692fJJvDAhMa1YwMvB-wrRb5Zj0I4z0qGuU-6oTKY_zT8kw3Ow0
    AP1V7rHFLB7Eake1-mkjhjPTYRDW5AT-Dm1EqlvyLi3Zb8N8xOxNA>
X-ME-Received: <xmr:Wu9yalQkVbw9uMK8AWbB-2iSnMT6GpaRjgyKfdRMJCgTRBsQzt4hdSgDWeHRjUrE5auYmOeZbA9qrAi-ND0Fuvcz8OV2Gx9Z45_7KN_hRQ>
X-ME-Proxy-Cause: dmFkZTEE4jA+P9rwwKWOs4BJLHxTJWHjUU8giztZ7+Bm6GynehUOcwoHrixKI9OHWKI8tX
    BimHSDC41m6Jd9rj4quxeWjSRWJQM+0s9HidhqIF3pOxG+nX39PRr23quoiIKdSUYRnQj3
    4OrArCGj7M4/QHw8C2rSGsQgayNDEOVzSygw264SZmxr9d+45xnxEOEVOur5xOUKHmIFk1
    kjnWGtW0TtAXQoa2aIfAQuWGap8xgdmn5jYrocPfx0V7dNBKQ2vp+1zG2WL4XTbunHPXYu
    xCyDknS+8tEt7/883AV0RXxxvKI3ptPT+U4A0GdgtEGw83iSEol3sCZROdYTgDB4D2eNYW
    qi2oRgakopmOCnRGj6+Zk7zq20wUHlwoLgbPiY9CNDlIT5mAEZpHJmZ3sv2/TCMMRjlL2W
    a4EGxVcmhWbKm0mV3wL/lfEGy6US1O2YkDv+EfqzeJm174OU3WVfndFRD+k03ZFSjHG2GZ
    we39pbQEvQKfnNMFwsMnGYvtyNCASR251ow+UiDF2OD+SqTuJCx91SiuR9fElyJ/PXK9wm
    C3PvlDbnbG0+JkjFpotgt/i9NxPR5fSQ/dl5peXWFFYHJfsP8D6TBnKiyzHh7A/d9/xke7
    bXxKYpe0MhqUKhb+kEi4DCl4tU01n044BZpTbNz2hWGkoPUo1vh/kkAII2ng
X-ME-Proxy: <xmx:Wu9yasn9c91m19ZYHvpBKWrHwCR3-AZup9lTeWHyZoOHxs4KENzDXQ>
    <xmx:Wu9yalTa8nC-Ziu6gZv4w2QQQNyUQMV4byZ3Rywf7znxkMvyvoVwHA>
    <xmx:Wu9yaqO7lLPyIGfeVzQzyfuk0oRV_2NHomb-1EYDX2jsw-KfhohtAg>
    <xmx:Wu9yauVpF_MtYH9paS7Q7oiaSCcxBDh2K1wwECjUigCtt35cAsRatA>
    <xmx:Wu9yaox7XebcEYSQ0ZAtyQqqra2otiQnGhA8TaBWU_JvRWMM2geIHG3l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 04:07:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6b3b3e2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 08:07:51 +0000 (UTC)
Date: Wed, 5 Aug 2026 10:07:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/2] doc: refs: put ref migration warning under the
 command
Message-ID: <anLvVAyckm7S9Vo0@pks.im>
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
 <ref_migration_warning.b0a@msgid.xyz>
 <anH3k9PvWHMpWLT_@pks.im>
 <7f34d9b6-de00-44c5-a59c-11f154e7a64a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f34d9b6-de00-44c5-a59c-11f154e7a64a@app.fastmail.com>

On Tue, Aug 04, 2026 at 09:09:25PM +0200, Kristoffer Haugsbakk wrote:
> On Tue, Aug 4, 2026, at 16:30, Patrick Steinhardt wrote:
[snip]
> This is just an informational note and not an argument for using this
> particular construct.

Thanks for the explanation!

> By the way, I think I looked at the AsciiDoc admonition reference[1] and
> saw `CAUTION` and `WARNING`, but now I don’t recall why I chose Caution
> over Warning.
> 
> 🔗 1: https://docs.asciidoctor.org/asciidoc/latest/blocks/admonitions/

Hm, interesting. According to the docs, WARNING is to instruct the user
of any lingering danger, whereas CAUTION asks them to act carefully. And
while the first bullet point is merely a limitation (we cannot migrate
worktrees), the second bullet point is indeed a warning that concurrent
writers may cause harm. So going by that I think that a WARNING would
indeed be a better fit.

Patrick
