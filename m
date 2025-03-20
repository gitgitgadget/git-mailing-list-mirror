Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2199A21B9F5
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466713; cv=none; b=Piy5ivFYQvlsX8yB/tsXn9WVL0GGKYSNRVF2Dl84CttkwfPaGuZ3ugltxEEkPI78l/tchljFNwGFbCbnPsrr/ZDRQ3xYdMOBgXSEJMWRKprb2ihI7drtm3EAOzKbo2oF9ytyKhx/sCcLhIiT8XupZzKqLtuFr5c4yutsj8mZ87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466713; c=relaxed/simple;
	bh=b9Apomq+Aj4oiZj9bPNuX/8nynLeHfax+vzrkDlPjZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kDFrX4HGlVzbQQlrSqIcLxWGaSKReTrBbWWKsk0lHfApOIOLWG6T+aIOr9ln/W81d7MjaC6cSOKDF6+CC8ME49t/S2rnQiV3Al6JD2laC7CrETD7anrwBLnXoyOVIp+GrUzsWTWpXHoIdfi7fCyPce1m4DcxwOPKlJp9pWLXhFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y3KUPI8n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eN7ugYcx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y3KUPI8n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eN7ugYcx"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03558254015C;
	Thu, 20 Mar 2025 06:31:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 06:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1742466709; x=1742553109; bh=k33nsassBkBfjXF1hirsGHhClShZ2bC6
	pfFkmCv04iA=; b=Y3KUPI8nE7JMOOR/KHDljFIUZzEZk0ExTi7xQXi9TQO2QBRg
	X7IKjpv9OA1N5VbleuMpJVLDtAAebjtZNLfU2oaNsMl3ApaCamU6CdmCp27g2XRn
	kMJK6wBfUiNyF99XUcIY3eTobc0eJEr08x1RW/FXhv9GQlUcijV+bbU26hQJVUTX
	7aAp4YzfS+10EYWLd3+I7A80Sj9/ddlcBcA8aOhBQ7GNefOjoGClZQbfJjOkC7gQ
	inVTwA9EecvVAISu7S30rDdWkuWMaavlUB2oaf3HqUQnoMs53RSlG45zVO3fqfJ5
	ZRGLjzcXzJA2TkTNOU4ObFKlE4WcNMMDz5zzew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742466709; x=
	1742553109; bh=k33nsassBkBfjXF1hirsGHhClShZ2bC6pfFkmCv04iA=; b=e
	N7ugYcxIgPnGMasOjeK6SqrNuipVhMBj187tLH8EI/e8cXKVVoaRJ9bSqXq+gUgZ
	5zirHOYP8ijyFd5XrDEEIvPohu5YkLHzYn5nciu91GNZtUqJAbnQMz+W0uzDLU/C
	g2oxgbJFsHScP3dg0AKX8EW+8Ly3P3wnWmukBalOOQejiz/f9b3xbYKXU8ULChly
	90OPNUg+PuRqooD2rWLBwhKFAINRONPzqYwECIkBNKmbacstTw5nrogp6406uoPo
	QgvX+wvAWOpvkU//Y6r+QHYAG1Xz4RnGGFhd71x9zFgEEdSj+ZB86gpSsosPhHxs
	TIO1hWtUosRwwzzXwGg4w==
X-ME-Sender: <xms:le7bZ9XrcjFx1LgjFM1bnE6D5eDiSk6Na7WEFwwcuHrmZ-OMMm_YxA>
    <xme:le7bZ9njIbSJvpIPqE1k9Fred-E-_hpKqrB9F-IRdIdnZIPgaz9XYvJfycOO5bry9
    xNGvk77QkCh50Jh2w>
X-ME-Received: <xmr:le7bZ5ZRj1ZU5SZBaKM7EgwYsDDH_d7Jg_j6m8L59NdrLtYcmyP-KIc1q6cIkbSMMza6M0hz56g-rwD0fUHVUh3KhynEUY_er4mO8l4up-LEjhI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiuedvhfette
    elgffhhedtvdehlefhtdffhffhgfeljeefvdetfeevledtueeivdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:le7bZwXtfS2OoRFH-avzvyOp3fSOqZJdq7OrgtozLHZ0mggucVZQwA>
    <xmx:le7bZ3ktcJQ5sC0V3M61SqLn-b0Xk6BNjmklS1RKDiZNa_FVxJgRhw>
    <xmx:le7bZ9euEFfjcAjFojgDKoFUFjghS217SfeGlPC6nGwYqMuBxctdhA>
    <xmx:le7bZxEtASJ-6YP_RkUzeFSwaDfU60N6ODbaA_HBmJUSbUSGmp0jgg>
    <xmx:le7bZ8wQ_ESC6jZHQAgx_SI9YwdwGDNYLuc7l2R-YeKnavoFjiTCSV-Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 06:31:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ded2f95c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 10:31:46 +0000 (UTC)
Date: Thu, 20 Mar 2025 11:31:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: Possible venues for Git Merge 2025
Message-ID: <Z9vuiCnKcMRRXHOR@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

given that this year is the 20th anniversary of the Git project it would
be great to host another Git Merge so that the wider community can come
together and celebrate. Taylor and I have been chatting about this
opportunity a bit to figure out what we're going to do this year.

We have been discussing two different options:

  - Hosting in the US in San Francisco at the GitHub HQ.

  - Hosting in the EU in Amsterdam colocated with the Open Source
    Summit Europe.

Typically, the location is alternating on a yearly basis between the US
and the EU. So given that last year it was hosted in Berlin it would be
the US' turn. But given the recent political climate in the US I'm
afraid that many people would not feel comfortable traveling there right
now. So in the spirit of being inclusive I think we should at least
consider whether we may want to break the typical alternating cycle and
host in the EU again.

I have been reaching out to the Linux Foundation, and initial feedback
has been positive that colocating would be possible. I do not yet have
any details though, so we'd know for sure in the first half of April
whether this is an option in the first place.

Until then I wanted to get a bit of feedback from the community so that
we can assess better whether my fear is unfounded or not, and what the
majority's preference would be.

Patrick
