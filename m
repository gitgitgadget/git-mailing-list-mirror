Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507161EABAD
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506995; cv=none; b=CVjory2SY0mvNzfngv435lxLeizk+eyw5uxKO04GsyYIeO7tW59F2NaPscDthsv1iqpFhXE2xcQSVuuObX6zB1xP/KKm2/six6CtQnNYbzMep5vi4ZSO71kXEBzbI9J9AMZYsrTfLljxtqQqlO4f9k1B9ahr3DCOdTfUPM+fRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506995; c=relaxed/simple;
	bh=u0Th3RqnkqfdR0Uc09uenp9ONdDBxgvzxjxPvoueaMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNJTxU5+cyyhmZJ4cAx5pJ7mmZVN2vKr43GKTwwQxcqdtJ+MElLBt/dJc4g4z2S4Z4/ppoOyastV70a8tPsk6ME3QEYwDt1yuAOC3lqv2nK/nqvhj9phCy4DT6lxMTXW6DuE8yafX7ZvJdFaJJbPGqNXPWC6qgJ4zX374sKRJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XB/I5R4f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lavG4K6B; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XB/I5R4f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lavG4K6B"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 51E2613805DA;
	Mon, 21 Oct 2024 06:36:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 21 Oct 2024 06:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729506992;
	 x=1729593392; bh=R+4fJp+ZvzhlyLNebfU03nJM67dearAb/aUQg22AjEw=; b=
	XB/I5R4fl9bIyHio5TZQRxIgrOnGoE/B8sABn/4qdur0ncq+UZoBTE8ZM20KumCj
	zEaX8dzfXRPKiH5P9gLK5vZQBW9weLdl9drgNDFO/icukGfKlsRtGJ3sc+xw4lMs
	qmca+9J2bfHpPPq0DvArHygISudst+bBMnnRVBfZPjdFqf46xQdstlwEdEsuEINn
	05pDpZNQlaVnBuGKd1isSX9YwTC4TmSPWwwdxcXpIw5dYwwJbHFKphje/tH87q9p
	DG6hb7fNyu8/Wyhd3YKU4ewuRxTXT7Vu4BIIS9aZTx44zOjHrVq9PL+pm121pgtB
	jdQjbQXBdL94bnMXt71FTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729506992; x=
	1729593392; bh=R+4fJp+ZvzhlyLNebfU03nJM67dearAb/aUQg22AjEw=; b=l
	avG4K6B8IbS6xkjbCiYGglQLRqDMNQpQw6p532JYkam9RZ7xtm506OHSdJG9tah0
	hacwemgsfQyrQK0tnpcDrkjH7P4/vJIZ2IJOcUG3ujIGivO1CPBnr5yR2j2ui+yv
	Vh77gpP9gOIKj2ZXh2AzmECHUsnoGpHjCisXkX1vMD62w/Z6uEKqm0hNf9MZATaX
	rD2yohM7Yu81smRg2l09VZ0SqfEW7ZJLy4PA6dEhrrWWgg4w0jZawZsqBVMPK/7k
	DjXo2HQBZuQ0FtgSSmLk/VZA+zmkoug9WM4eI+6D4WVFcIJ4rD9aon+SMKFLJIyU
	Je/gDUTYA25pOzR8+uJ5Q==
X-ME-Sender: <xms:ry4WZzuom6mEPCINXOBW9PVtGsThFb-XaYsvEXtuQvlpyAkbkm43KQ>
    <xme:ry4WZ0e_xZhln92qMaZBJpu-rOpHu5TMNtoAf0dgQUce3moGWVGXWc3a_9ljtU4iA
    0hxGARqo6rfqbA7uA>
X-ME-Received: <xmr:ry4WZ2yT4JQzHhqGVgM3NtE5igmT5JO_sDqcyo4xVLEENSE2h7YN-viXl-Pn9lA5QyFHrM72723reRANL813lAa9iNhhukGNebAQDTO_CELa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:ry4WZyM5hfz-zw2lpM4RUF582ut7mUWXo7v64URJexZnOxZmGERPkQ>
    <xmx:ry4WZz-Klnj394lwF86chmV0HQfio7rVAqgpXW3JKaVbQFXlSUIepA>
    <xmx:ry4WZyUTSC3Yf0w26qeiVUtzwWyRz31xzEfxxIvD3aRRdaU0ilSRfQ>
    <xmx:ry4WZ0f2nDc-pYTCABxtNyAyJBAKZjK99PhSJOhVHakIRcMF0jve8Q>
    <xmx:sC4WZ_ZmZq7xJx63-7ZBWeRJup_tGa1ZUd-eQmwQ1mmMUZFlaUlUQnjF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 06:36:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fed3a9fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 10:35:00 +0000 (UTC)
Date: Mon, 21 Oct 2024 12:36:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.9)
Message-ID: <ZxYuo2ISSGRI8_J5@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <c1d3d038-4d5d-4904-b2c1-47b98d20a2df@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1d3d038-4d5d-4904-b2c1-47b98d20a2df@app.fastmail.com>

On Mon, Oct 21, 2024 at 11:54:52AM +0200, Kristoffer Haugsbakk wrote:
> On Mon, Oct 21, 2024, at 11:27, Patrick Steinhardt wrote:
> > Hi,
> >
> > this is the second version of my 9th series of memory leak fixes.
> 
> I can’t even imagine the amount of effort it takes to plug all these
> leaks in parallel with the stuff that everyone else is doing in the
> code.  Nice work.  :)
> 
> Of course all the comments that I left just now are nitpicks.

Thanks! I've queued all fixes locally, but will wait a bit before
sending them out so that other reviewers have a chance to chime in
first.

Patrick
