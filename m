Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0D269D18
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218415; cv=none; b=TmHumPJQ80W0m2DU5tK0MkJ3C0ozechrtXbI/zZ9jtLK7/hQQEmGDdZCEVWH3sZUWdG9hBNFpgXWktp+zodGln9mypet8VdxQvBa2Q/tmLsBTP0Y9fcVSbZOvdNNOT5Fgfhne/HMB04ElYFe3WNSXxB8tOFA0XDCYIgEBQthJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218415; c=relaxed/simple;
	bh=xxwgYZrRhNhy97lY5wNHsI8hPR8PuTBTDAoQhuF42zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuwsnqe7RIJnn+5eQM4LsKU9PbDM5pozlUbi8bb+txFvYl9j6sWNvqzKXO0QvJOW8fvAxBZAX052NLtwPlvQdRDXsrB22AvHC6NCxfnxONNHNgdTpmpkXJvbf0Jf/alQy5uUnpU1Zz1en4LZ5Kac3mcMDlNaU/987VQ3ohnaZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AFp4ocHn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vq9+ge5M; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AFp4ocHn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vq9+ge5M"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFE951400080;
	Mon,  8 Dec 2025 13:26:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 13:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765218412; x=1765304812; bh=k9fZYmCyiy
	W1UrUkMetnKuH0EhbPVsZnmat/dL5rfVI=; b=AFp4ocHnqs7sm+tf4E7ISXXm5J
	eeRDcrrN3Ol87sNUaf1ZuOevINzMya71TJ9k7zykJH7p3lJHpxin1v/KfQlC0wHR
	W23bdT7HaAICPe2Ib4iBfw2Fl2l1rKRs/FxuWE4xdgDHgA/lUNLAKesv97fdVa6b
	uub869d+1FH4vNxCNX6iWpobAro+WFI5Ln6Lx63usQWgV3P5TYSMbktfqBsOtdMP
	kn4rb0Q6481cKFY3RpKyy6sWWPriz+FQSbI0ukfDxoGJXwwgk9e5C1BOartFmINV
	UvIDGAc2WHTCwxggIHhGF1fRzKbHbbbsurTei3ua1K7C2K4BtIEzRejXPl9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765218412; x=1765304812; bh=k9fZYmCyiyW1UrUkMetnKuH0EhbPVsZnmat
	/dL5rfVI=; b=Vq9+ge5MEWqgr9dtlUdUk2Smgs4ksqt5cwGxlfVVvdqTUtRSobB
	ZEzBSd2x4gEl8HNLWXxbTWg+kmC0dGa+VnYNMMTgdrV8pdUJr18vNOp50K3J5b2d
	5tSWAjythLg26qZvpkGnZ5Al6qS+/5I6ZsOmUNfw5h+UdZprJLsQ8B9zDV+rvHEa
	Kep3/+ezDh18qF8EJNZaK4mwRot3pPw4FYEgf/SPvH4WXeEygQowE7mDK9QE1vZV
	AOLosdKaPAYljHIGv9Rh1uv1DhXdwVFMLy7+cvicJCBr6++wfqPrBa28NOOWE1Ck
	YSRqqeHgCsh1rnBOf/J8A675GX4sWj4RP6w==
X-ME-Sender: <xms:bBg3aQdE4GSK-CeIIXgu8nDGmRe_fneqgXbD8bA3Uzrjd1sM0dUZ3A>
    <xme:bBg3advTIdzUAhwAFeofdG6QnDeF0uUAazJVjtLHICtmBPnXdJYXXGxx56x8co62J
    Ss5ukUUci224dH3zBVjrCM1R7pQJczffRi3CfGTAQpiXoaUlpvSKQ>
X-ME-Received: <xmr:bBg3aX8gQ9yPX1QDD0drDiqA-vN99W34VqMNHoJuU-fui7zoGs3v5OVxkPyR58w7uT1FIu6_uvfp3zkrJYrDUZdUUwzLlJ0R20CHc2smCf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bBg3aQ2t8GN4gwlw15iX6F2FAxO0B81Iwuhc5rhCnbv4kCf9FcJL_Q>
    <xmx:bBg3aUC265rY5jgFbix47AsEa4mL2KOD5hEPo9UR7SLcZrLmborQww>
    <xmx:bBg3aUdhU5Vil_3F9Jf4v98pJWaos3VNQH7-umE0A15Kp_mco12qAw>
    <xmx:bBg3aZ52y7QOwqOX7evsXPFjELaB1T7Mfhs-TcetFlV5lD4-aCIgNw>
    <xmx:bBg3aUAZ_KZ3OAFF8yF_Gw-NKklRUUD3aNTcr0Ov_oBcKIGDCuPyFc2o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 13:26:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff97143d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 18:26:50 +0000 (UTC)
Date: Mon, 8 Dec 2025 19:26:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/17] midx: mark `get_midx_checksum()` arguments as const
Message-ID: <aTcXKE9ZW2Um92n3@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <8cd8f6e8420a52030f92166d5a20387183cdbb6b.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd8f6e8420a52030f92166d5a20387183cdbb6b.1765053054.git.me@ttaylorr.com>

On Sat, Dec 06, 2025 at 03:31:01PM -0500, Taylor Blau wrote:
> To make clear that the fucntion `get_midx_checksum()` does not do

Nit: s/fucntion/functino

> anything to modify its argument, mark the MIDX pointer as const.
> 
> The following commit will rename this function altogether to make clear
> that it returns the raw bytes of the checksum, not a hex-encoded copy of
> it.

Patrick
