Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1323D1E1A3F
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508863; cv=none; b=lflKA2lm+GdEYVgyXEMEVlYr+n3UOR8WYeU42KkrGECatxBSem56Rk274x5D0mm+pLNVufttm0DHukV1MpzveOrO/gKymfK0mZakQSa0i+1S1Z/iFkT9pGhDjMxvpoveTAVZ1WzJe38P0JKjHhYXTTQ1R+4dV4/n0uIRrza1Wsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508863; c=relaxed/simple;
	bh=ZaEuxVumJd0y6g289jUtVFr1pQ86D1NAHn6WoaiqJFc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jjoxuWV9WL2yHWlKdEJ8JxmLaQRTPNwulaHL3mF9Ii5X3mHv1Z4Rh5C/jEFE7GEzPsB/Kt4elT6+YmUaT35OO0qn8/fIdqHR8fZRGJlG92QU7EvQXmNNhyTTXNNQSPLgntwLa1+SQCsOX3Adks5EhaNHZVeIyD29HOZTruDTIPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NPxFL1VX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WyrDUusV; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NPxFL1VX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WyrDUusV"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 23F581380532;
	Mon, 21 Oct 2024 07:07:40 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 07:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729508860;
	 x=1729595260; bh=aELOSRyZTeo3Sbphj9CKQipcQ6W78nVg0DPYYUICNDc=; b=
	NPxFL1VXqA4mfi51etPiYBRlk94shKul+Nc8EGB3Fg5wcdT4l+LQJczfmigcQtQU
	Qx2WzAHRwWIMejuYnya/xLU3ZO22wvp8d9xFgrTdQCg72NXdgTY7ZqM6LX3t5cM5
	6A/RHrrgcyqZI1OBo0yHOTBSzpatI1RxHY5uAK9ynB7IXx+V+38Tq+H7Hmh0rt5F
	eS2yv3r/UzgLot1Hywrre8bUeo9Q6zxdHmfr0Tt6ainHrnf/ugR6/v15jcElRJnE
	dE8lxXdR5SEOLCx4Qtv7VNBd+q1QDZ5OFF6PezhQWwPOVIXbyOkmvrbYe82tZuaY
	sRBDA0Lz+wDXvnn1oIcksA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729508860; x=
	1729595260; bh=aELOSRyZTeo3Sbphj9CKQipcQ6W78nVg0DPYYUICNDc=; b=W
	yrDUusVhnK+hfufVgMmpP1+Ewa+1lVg6OgqFnGsF85hj/pk7YFihSNAtYe0Ig38L
	8Su0RjX99Xa8/9Je0tLY7SxFRr23J50XvetkIh7O/UBsTEwPg+66jGlTdNbRpSXN
	jpjvkKjMjYdeWQzV9ni6gm7awfprGdpkKtsEJhrjL/4tBDo5t/AXu75wzIArQxy9
	9qD71ix/zeAUmeGSur8UGpqDC3/QZUbyEhTtJ8bmXmHyea3PP9bxcBPEd3b3VRsC
	sHlj90iC7FKv9k4i2lTvhD+2E2tMYkhHYA+wT/d/iLGimld7A0P4kprrO9tqO6MF
	F3Vgr/k/OXSNM7I8UP2AA==
X-ME-Sender: <xms:-zUWZ7IkvcbAmU76vt0rohmXL8GVnmv1wNkvxyeG_9GAXzmH10fNhvI>
    <xme:-zUWZ_KnjgX4FENlie3wLUSvSAZ5xt7wpAB8R5E55txEQm8yEa1C4t8K6m-FB63Hr
    ZmOxWMPaN6doOxAEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhephedugfevgfefgfffvdfhffdvveevgeehhedutedvgfeuffejveejudegve
    efvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopegsrghgrghsughothhmvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopegvughrvggvlhesghhmrghilhdrtghomhdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegsohhn
    vghtsehgrhgvnhhosghlvgdrtghnrhhsrdhfrhdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopegrshgvuggvnhhosehmihhtrdgvughupdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:-zUWZztGGS-RIik85K1gmMx4JxDaACK2XN_cStVxYvQSdqnEUH-_lw>
    <xmx:-zUWZ0ZVI_AYQXim0ZZs3YP8bgj4eDBLz-2fQlTvev1ylTpzPH_iwQ>
    <xmx:-zUWZyb3c4rA3u0OiCPguTtFXwgsXOIpFM0vPaubD6G5eDCQe2wx3w>
    <xmx:-zUWZ4D7Wm_V0hHhTTkMyIfgF261X0aB4urJx4edu1eVDspYFZ8zGQ>
    <xmx:_DUWZ_Se_twUjmjJez6S6VZDd6jYKOAQd_ueMt4XYMP_NPu6lFYO6icn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB220780068; Mon, 21 Oct 2024 07:07:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 13:07:17 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
 "Toon Claes" <toon@iotcl.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Ed Reel" <edreel@gmail.com>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Bagas Sanjaya" <bagasdotme@gmail.com>,
 "Edgar Bonet" <bonet@grenoble.cnrs.fr>, "Jeff King" <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <e3bf73c3-2f4a-4b49-9016-a455163616ca@app.fastmail.com>
In-Reply-To: 
 <17d77f36d41fb2928565a4922eab3a67426d2da6.1729506329.git.ps@pks.im>
References: 
 <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
 <17d77f36d41fb2928565a4922eab3a67426d2da6.1729506329.git.ps@pks.im>
Subject: Re: [PATCH v2 2/5] Makefile: adjust sed command for generating "clar-decls.h"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024, at 12:56, Patrick Steinhardt wrote:
> From: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
>
> This moves the end-of-line marker out of the captured group, matching
> the start-of-line marker and for some reason fixing generation of
> "clar-decls.h" on some older, more esoteric platforms.
>
> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Alejandro used two signoffs in his original:[1]

    Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
    Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@google.com>

I don=E2=80=99t know if this matters?

See also https://lore.kernel.org/git/xmqqilc571hf.fsf@gitster.g/

=F0=9F=94=97 1: https://lore.kernel.org/git/20241012144027.2573690-1-ase=
deno@mit.edu/
