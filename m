Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFF189BB6
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928744; cv=none; b=oW7abJW5DZOZOIL0VEDuMSZ+LSbCAJY6k2ttkgzRKkj1tHfVSSAjqCHMX8Cs/TFZyCpZofwI3TUwEls5xPbsb02b4oyJMvyTNJ1KcbyYOGIr+Rq9kxb1MVG99/XCIh7+64+8KawxmgEZr/vWVh0oZLiU3k1VjTifblYjyo8WrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928744; c=relaxed/simple;
	bh=aIYIB3ZTA9CHALGGCS+VRoOyfYUtYZDXwu5KjgEaTC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAVpQHDUAajlrDRHYvpATqZ0WhdGIkEoDjEnJMpZjkHL8pdvn7Ow4Q4yukLqnW8ijW4MXDE6zAQWRRXggUGg/xog73UppOsfTmlDwMNlPOJr4ZD2ABwLoHhyxoErxzigyIepZ1u0tWxfwzRUureoHFmWm7mjtHA2CBTGmKMO7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a1uaDAd5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eZRDriZ1; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a1uaDAd5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZRDriZ1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8698514001C9;
	Mon, 15 Sep 2025 05:32:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 15 Sep 2025 05:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757928741;
	 x=1758015141; bh=u8yX2RFmaVSCOFc8NTw6xFpSvpT0v6GSTgRdPrh2kYw=; b=
	a1uaDAd5uRC5d+kY68Ty2OZRu1d47qBP597mB5/MtttSDK3pAc/31uLuL7dAz0U8
	fv8ivsN+aO09GU48OB9D5e0X80pqwKadWJYz0KCPIsuRWvktKthK4ecFeqfyJNUV
	68OVzo3rlzR8h2lzpqzqb8KNgc1QT+Oteq9MEysVKtbwzXcM7uzUoNLbNjgr4nka
	e5qGqsmd4lR/z+EmEfGKYfDL4Gb/ycjwbQKTgU3A2dQCxkYXIs12MtAENB1c92lL
	NqNPS6IMaUI0OnKvzHIU/OQpRyhWaJTIMo9zY8u2gq6iZhtCQrKINnEOMZC39QTP
	raYub7VERbdd/oMp467tDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757928741; x=
	1758015141; bh=u8yX2RFmaVSCOFc8NTw6xFpSvpT0v6GSTgRdPrh2kYw=; b=e
	ZRDriZ1PubStS7LDCbJfsFF9++dMyRgrvh82b/LYI21Kb5DwpFVFy/8Yo+oeAwZP
	oQwFo19j/MpEyc9DuHlcue5G9r/IUjGMY/L0XEAKnm21lQ/PtuIU99R/fHNKxGs8
	nri+T3TX0FvBkLfzWklK/knnDwqmacPk8w5cqyHdiSLzlxKkzMy7jkgYwm+WQld0
	rTzOmdfaFNqg6/cPDdE4P2SFWMa9Y+rs6gHsKDs/xAk2L2KTp/dJXKIZ0ZI5OUQY
	bvcJ3Um5TvPWlLeolWsslSuxh4De7AO6D8BeuT3uhYfQIa+8PoCPW0PwvC1NbE5X
	SDIqB32FzRb0y8BM5Gi7g==
X-ME-Sender: <xms:Jd3HaHEX_YVbHZVnO_iWxWM7ZO1i8lVG772f7tG2TSOqRsq5Hr_AeQ>
    <xme:Jd3HaB5dQvWZGNsS0-SIixEzaogwy7p26Q94uLNRGK-PfK6CPyKm1A8M8Qz0cJL4j
    vYoj0Jc1ZAiUGiHoA>
X-ME-Received: <xmr:Jd3HaPkHQncdPR5_IC1abeM0ot2dUJ6qhbOdyEUDyKGs5GJr41DFcQvPkitZQ38tLe8rXU4Xm7XnWZ4-PYh_oAbma2wAGC6Ong54ta_vAVm_lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmrghrthhinhhvoh
    hniiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
X-ME-Proxy: <xmx:Jd3HaGrvh6kLPuCrojeV-YEmO61MShxqertHcQSnaaS3CYfIEztUpQ>
    <xmx:Jd3HaOuL_0OgCDzeNPNNxZPjj4u-6KW-T3V5a3Hc_BmCShdzXh18EA>
    <xmx:Jd3HaLEQAsY9ICqtQv4Q2SxlG-HTfP8do3BeioXikF4z0k_K9sfyMw>
    <xmx:Jd3HaHYcdZlte8DDAV0gIQoEqGHhfCUN1JYp6z1pb9hhmd5Iufb-FA>
    <xmx:Jd3HaPyWrGCVawb9cyQFmCUV-pX_s1_1xRcCOsIrNIUoUHaqi0bohdDH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 05:32:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39ea78f5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 09:32:18 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:32:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v2 15/16] builtin/history: implement "split"
 subcommand
Message-ID: <aMfdGTQWT1ES1jbm@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-15-964ac12f65bd@pks.im>
 <CALnO6CBRv-Jvm1FsUAkDSyaNNRXtMukReKzefvCw5-vj=-pnCA@mail.gmail.com>
 <aLgygyUuQCmR25qU@pks.im>
 <CALnO6CAjv0=99AcBLU=z71hGrk0fXp9pWm7wiBF-a1Xd_efrdA@mail.gmail.com>
 <aLmMycWf-SMBw2bX@pks.im>
 <CALnO6CCG=8JeRxgVfM9ayaQ6oY1iZQe3277sh=FG2YRkbbUj=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CCG=8JeRxgVfM9ayaQ6oY1iZQe3277sh=FG2YRkbbUj=g@mail.gmail.com>

On Fri, Sep 12, 2025 at 02:26:04PM -0400, D. Ben Knoble wrote:
> Hm. I've pulled down v3, built it, and pushed to the same branch. The
> tip is e91e23546b (builtin/history: implement "reword" subcommand,
> 2025-09-04).
> 
> Now, a heavier-handed recipe:
> 
>     GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null bin-wrappers/git
> -c commit.verbose=true history split @~5
>     <input y,q> # once I even used "e" and added new diffs to the patch
> 
> I see the usual instructions:
> 
> # Please enter the commit message for the split-out changes. Lines starting
> # with '#' will be kept; you may remove them yourself if you want to.
> # Modifications qui seront validées :
> # modifié :         add-patch.c
> #
> 
> And finally I might know what happened, ha… if the "modified files" is
> the status information, then it has been there all along! Meanwhile, I
> was expecting a _diff_.
> 
> I'm actually _still_ expecting a diff with v3 and commit.verbose set,
> but I apologize if I've led you down a wild goose chase for the rest
> :)

Oh! I didn't even know this was a thing Git supports, I've never seen it
before. For the sake of simplicity I'd propose to keep this as-is for
now, but to amend that mode once the initial couple of patches have
landed.

Would that be fine with you?

Patrick
