Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B8179BC
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949490; cv=none; b=rtQHAPiw1VqDsKNingNc7faTwSCq7Kq0UZCILix+17Tm2F2ii9o3fIfzfGZqZ1oDfCDZdl/RDG18zhSzNXfqxRQocb/JojK9NhxMcRFbFGlOUgK+h3tiTKGEGTCZt+BgRGonZR6w+qOlgbl9Tv+DN+7XxA7r/lJ1gjxk5fnERSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949490; c=relaxed/simple;
	bh=yE71Ny8WHuL2HOWtf4ovc8X+smqBQ+DpfmtdxvIneyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsccRVRw4OKrxky+tX9PpOlhx7mHUB7ZmAXai+qrmUGTPGgrg3hGUip8LlGzQaBy50+/ORnKNu6QNg/+sBKJ0rUdo3H05z9Ht/RkTcFBX9rJnf376ypRdtJj9jci09HteQaequ3cCoAD4lZmqyMJfvPKnSPrqh8iG5gWUjpTIBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DiBro8Ct; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GzKEJcr7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DiBro8Ct";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GzKEJcr7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B156138098C;
	Wed, 19 Feb 2025 02:18:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 02:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739949487; x=1740035887; bh=PLMkT6EXIJ
	L8UwaoGv6+H61VX3L1/Yq1JHox17Bo2AI=; b=DiBro8CtsRviMnT49+oKRj4Tvy
	e50ujMSCsI2zAe/n23rlchVBZnF7y+PargmNoie3SK0cuUNhnQ9VT/WnEAhlPy/w
	wG5OuIjiC9ejh8hbVF1bB+khhqtLxNQwSQsM7URhjUGO7wDQkXeX7xsD6grnhC5S
	/IRDp+LLqHTd+6xLS4nJ57FHov+/RaDlbCInM4CzOTxxU12cR8GoesNbCq9Fs4xf
	H2ZQYQIODqfIItVxsAFWvyVTpU+7kfk3JnjsROIqvuFNWC9yuOkymQL+gvDFmyle
	F5/stWdCPtBVbJaFdUP/hC7rJWhexwiBRHmrvHqXA9aJ6C1Jn3iuKvOqPrOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739949487; x=1740035887; bh=PLMkT6EXIJL8UwaoGv6+H61VX3L1/Yq1JHo
	x17Bo2AI=; b=GzKEJcr7J1403nJDnULDFCDP8QGIpp6/zK5L3BXQffoAdwcC+ud
	rYr/9osbopL0NMOfB+P3+u+CO+mCsJXHvBucuQiuEK71NagTu/EASOlVWoyVbwyx
	YdQYLwo+MSzOT45/KijCyXGZT3J2HAdg8tcjaxIw4QCvL+z7Xci+BhDzbDmd2qjq
	y0mr6v/ul6Cr9yBefHwv10EepSwxRuj6ZjWVgZgF97qg3PHdgOi16O92BbWRp1lW
	F4aDwTEE872Poquuby0UmFrIQNFO9wLrebXvX64fPAncLCtYcNxrei5018fI0QnO
	1/LcZlSORVLciXSj3G+OYggr9bRtqxvVhYg==
X-ME-Sender: <xms:roW1Z6vReig5yfSw3ptKjrLSMwncAwZWSY8Ow1QkjE4KU1fLdpT3RA>
    <xme:roW1Z_cDRXBarj1c93pc71riei2A1btISdApyWE8m7FrODpiaWax0N3qTwuhWzglG
    PKBM8Of1Jaot5jYKg>
X-ME-Received: <xmr:roW1Z1zyBqA7G9w1C4-FlgOXnYU-cfVdJ7GcQxNQstuHwQsFCPUZxdbADQCMb_c1F6lcEY9J-05EUMLoPZnUH3QQOzDEfKFBWOea-YJXylQLGN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeifeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithesmhgrvhhithdrohhrghdruhhkpdhrtghpthhtohepphdrugdr
    ohhlihhvvghrsehmrghvihhtrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:roW1Z1NFZ9rzO8hg1kWhtT_gllJVAvuHppKxH8_8NvwCOo9B7GwmOw>
    <xmx:roW1Z6_aCOWO4KOnxQMjrjBD89j_Ohha9KClXm-RZYKfn6ah8IFyMw>
    <xmx:roW1Z9XyeFVALItdOIVfKBVxS0sdbLirUEXhIu4uxDYMJ5KzkaiIOQ>
    <xmx:roW1ZzdUpBMTcA7SuKln0XB4yRhk4D4_pvfKJdEd01v_wo-Y_SFk6g>
    <xmx:r4W1Z-aSYUKUd8k7YcEo3TozfXsGG-Ehi9bO5DAZO54zQcTA_Z_U7dYY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 02:18:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5b8c99e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 07:18:02 +0000 (UTC)
Date: Wed, 19 Feb 2025 08:17:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Peter Oliver <p.d.oliver@mavit.org.uk>, git@vger.kernel.org,
	Peter Oliver <git@mavit.org.uk>
Subject: Re: [PATCH v3 0/2] Fix Meson Perl version check
Message-ID: <Z7WFpu6QEBJXwAIH@pks.im>
References: <Z5c4OzzHWOo30Hu6@pks.im>
 <20250218153043.63535-1-git@mavit.org.uk>
 <xmqq8qq3kqyk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qq3kqyk.fsf@gitster.g>

On Tue, Feb 18, 2025 at 11:12:03AM -0800, Junio C Hamano wrote:
> Peter Oliver <p.d.oliver@mavit.org.uk> writes:
> 
> > Suggested comments added.
> >
> > Peter Oliver (2):
> >   meson: bump minimum required Perl version to 5.26.0
> >   meson: fix Perl version check for Meson versions before 1.7.0
> >
> >  meson.build | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> I wasn't involved in the review of the previous rounds (so it was a
> bit of surprise for me to be listed on the To: line), but it seems
> that Patrick and you polished these two together, so I'll see if I
> can add Patrick's acked-by/reviewed-by while queuing by waiting for
> the earth to turn one rotation.

Yup, this version looks good to me, thanks Peter. So please feel free to
add either my Acked-by or Reviewed-by, I'd be fine with either.

Patrick
