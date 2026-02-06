Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E42DBF47
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397088; cv=none; b=oMOC0z/dP7RkrbbaWn5gJNfx7kpWhNWR8YwsYIrReTIsRmSbPCa3hmz8nylm5JYkrrk9EOFtPYkR7dhQoEJiTRWT5KMryEymplbVEPqvHzvZgklXgoSKl4V9haBSzZnthPAGuMZeEaWf8d2q7bwH0AseuwJjgBvL3nljnsEFZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397088; c=relaxed/simple;
	bh=i7irasBd3+5Sv9aO9gXIfouDJVCvhIRKpbtPyb+xcEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkTqjdItvZ2iQqhrqLbtiOIKdt1tQMiKMqU5oeiDTo29ofdBRMpiC9xbx8JeeTM6Nvl6GKEKhO2y3uUCi8NBGrm8jQxkrwjIRzjOT5mWj0CrdU4lUnjIJorJUJAjQHM5TGU6dmotlT0eBYiEwNbUkJJGcWNiROBc5Z7dDBzcwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GSa88vFQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jSU6kjtX; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GSa88vFQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jSU6kjtX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B1F811D00044;
	Fri,  6 Feb 2026 11:58:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Feb 2026 11:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770397087; x=1770483487; bh=08cTip073n
	6rNGNhuc4/kZ/2Vii9rM3pqRkgPQhiOI4=; b=GSa88vFQ8knu1lHPa41CRKrKYP
	xrhZR14j778ZAJN1691AAXzcWQZW66WkTisUwELJb7WQ6LKNCpmVy50WOQm5nFIb
	IqnNKLvpyQcisiwN1BQ25aaL3I/yb7aEwqzVcWDa3PY0byYlyVKWLKEx/eUr85w3
	G3dRj+NEUbVCYg/iv8VyxBValYnA6anr4GzHyLyAc0LVrJItnKCKP7wfTuPlwDE7
	8nLgf5oOcgQmzWCwdUSBHOqTIBNKgZ/sO8ev410PCN0lELJF6zhvak0JOeryIkrO
	UBfVVDeov8Es7EStQW0Ga1KEDgNYmbVyH0hO+f5iLbFUrH+mrJH35ZWLSmgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770397087; x=1770483487; bh=08cTip073n6rNGNhuc4/kZ/2Vii9rM3pqRk
	gPQhiOI4=; b=jSU6kjtXQBYKjJ5Xm8lnynnN5jjxNQvYo8CCk4eOlEe8yiiXc93
	+gGJgkC4nKtu8lgOfaZWxvdSXvrFulKXMZHPV8fLYlu2fub6HodR/agcrV/aYpO/
	2vSMVPs0DLt6hRUI8VHVBo10WgbQJrta2AnrxwSJrEpIyzpqjPeeWbbBYHwJHzOI
	FptLFgxpEHwKUZV31bOejPFAoAc2E/OTcj2eLsDnsjafbGOEYiJBlRZECw3PTlyA
	dumWA3iszix6TJgYt1X5xc3nlf3gHwRg4eOduM2u/tkA24PhsHM57+wkq0tJE+Tt
	llT3NJIBcuvnqnth7p4eEzFS3J3F627c6vA==
X-ME-Sender: <xms:nx2GaXDjyz9WpcGsSJ5s_LxqIGdJ8AJAY7xTYbSyjWt5wuS6h8iLDQ>
    <xme:nx2GaTgW-vuL9qZqcQEDj-A49_3A0bGjKB63XC-yg23gckfO51B0l8jcdMzUsV084
    vJA422OHiJZSUB_Xlv4Rfq6XnLERyVyh29HhSRm-qZFQc2DUzpPoQ>
X-ME-Received: <xmr:nx2GaQO8WjnLXH7WSs_3fTA4wrDto36oxKrSx_F26Qf7ee-uXLh-yCoTgWC1fsDG8p3b5-I71KIhu10gL86-7aV-8cOT3HaUOwz5_aTjYss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nx2GaU4IKwUFjKS2YGHs4ykuNiFuQm2Ph76Zp0xAOwKM4wgkHK7y9Q>
    <xmx:nx2Gae0adxKvpGd7UzSSpxJKMQu4UzFDSovvGgMiKEKcBrK1JxJkYA>
    <xmx:nx2GaVZQ-9TkXNG_nut71Tbt4ec_Vwp3DJh4I7COLl1kYtIJVLymoA>
    <xmx:nx2GaWArC_g3Wc-0Xz6IN3kvjWhtYPLKRSWYnzB5e0i77aPWclrGDw>
    <xmx:nx2GaaZph6gPpCUI8-xYCqblFjpwGKHSvHq9pBmOXEH71BHV1cV3BUkh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 11:58:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84c55bab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 16:58:04 +0000 (UTC)
Date: Fri, 6 Feb 2026 17:58:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] whitespace: symbolic links usually lack LF at the end
Message-ID: <aYYdmUd4uqgK2Z1_@pks.im>
References: <xmqqecn0nqyt.fsf@gitster.g>
 <aYSLP1LqBiMwur3O@pks.im>
 <xmqqms1nmbog.fsf@gitster.g>
 <aYWKyOIMPLiDxqnj@pks.im>
 <xmqqv7g9hm9l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7g9hm9l.fsf@gitster.g>

On Fri, Feb 06, 2026 at 08:25:42AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Thu, Feb 05, 2026 at 07:50:55AM -0800, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >> 
> >> > I'd suggest that we only disable this check in case either:
> >> >
> >> >   - One side doesn't exist, the other is a symbolic link.
> >> >
> >> >   - Both sides are a symbolic link.
> >> 
> >> Hmm.  That is indeed a thoguht.  But we do not want to complain in
> >> text-to-symlink transition that postimage lacks the terminating LF,
> >> so the above rules may be a good start but will need further
> >> tweaking, I am afraid.
> >
> > Ah, right. Only the other way around, when converting from LF to text.
> 
> I've decided to use the "disable only when the side that appears
> postimage (taking --reverse option into account) is a symbolic link"
> rule.
> 
> Strictly speaking, "diff" (but not "apply") has wsErrorHighlight
> feature where it can be configured to complain about whitespace
> glitches in both pre- and postimage, so it is technically not
> sufficient, but it is not worth supporting diff.wsErrorHighlight
> that is set to anything but "new" (or "default" which is its
> synonym).

Sounds sensible.

> > Eh, I didn't mean symrefs here, but symbolic links :) Tools like ln(1)
> > seem to strip trailing newlines, but if you try hard enough you'll
> > probably be able to create symlinks that have a target with trailing
> > newline.
> 
> Yes, as you can create a file whose name contains a newline, a name
> that ends in a newline is a valid filename that "ln -s" may want to
> support.  I am reasonably sure that we do not want to flag such a
> symbolic link as whitespace damaged.

Yeah, we certainly don't want that. The remark was rather about a reader
not being able to discern those two cases (does or does not end in a
newline) anymore. Or would they?

Patrick
