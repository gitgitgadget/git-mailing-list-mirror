Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848DE22096
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041234; cv=none; b=eJmA8SwXmNrntMfghWDp8BKjyii+xQ4V0ak2A2r16kXvhaFl2tYMoAcFGo8bg6hYyIxkHdo38dCo8kMiO1V/p4N+UzYsGQ1RV2tEhlUszIB/yq2OpPG0Yz96VPCIDJS8AUpGk3mVYnzfkwrgLM2UqCCI2eIYzjgoVOYYSMjsokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041234; c=relaxed/simple;
	bh=bI5ZpoJ83PJg5dkpzjmX1MWna/KUnW5rWuR4zu5lRaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eivN9w6puf4YiI9HWabBYCDevKvpN53EaSG0+KRKLZfWKzplCaQW6gkUYIARLDFzXeZ/fHZE1Jo196GOSscqGDbFtKjRaoBZ6mSa66ER/aAasw/keukf+pX5cqxdXX1Ue6EjS+B4IzWpbKMnx7qT6KXaVJ1qltvyOWPiSLDN4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T9oOEbDj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vfserxmj; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T9oOEbDj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vfserxmj"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4817618000CC;
	Tue,  2 Apr 2024 03:00:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 Apr 2024 03:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712041230; x=1712127630; bh=bI5ZpoJ83P
	Jg5dkpzjmX1MWna/KUnW5rWuR4zu5lRaQ=; b=T9oOEbDjUZGa7Vcn9443Zk+ZLZ
	wShKX3E8IdwBbg9cBGwR6weaty/IGaXXEXLJvvICAbdwAuEAgJnhcKw2NomHv0E0
	WB/3cP1AA5zXBwALe/za09PVfmYvCp1JUTA+PrittND+tPtKuaKW6zR1Oa4sfR+Z
	7wLxCMjTebq07y+1nwQYvHSpOSxWnqV5zhEb1D7icZJHO76KnS0m2vmWFjrSvyD+
	WXmMJet/u9kUZtOt+ZVfpSbfwwVr2MLxYKbzoW3VXRIzVqa4enW5CM6NdT0b/gw2
	InZ8KvoXdLQpcaCGKLXpQbKqnD/bPSjkx5d7PfjyiA5+mldy3Ttyk8IGt7Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712041230; x=1712127630; bh=bI5ZpoJ83PJg5dkpzjmX1MWna/KU
	nW5rWuR4zu5lRaQ=; b=vfserxmj1lmQWGvxKwgCdADD8n/lkL1RpxyDA+rPauMA
	vrqi9rAkUU1XREhhZTTatKY2l8/gU8CLyWKcy0/NsIsxDUITOBhotCX5bbxcibua
	Ch9yIlGsVG4TIok+wRjiuUrh5pG6Q6NBg3JSJrzNRzFJ94Vs+h2cOVGht9ZsM70+
	HjabDHViBTCKL8fGqxL592qxwUbUZeC8C4mFRaZ+3+JHKva4t1JZk01XtMcck8BW
	lbCQMWeWSLXA00Ag3+KtsVYVKRmid8h7SbX1SyY/r8Jghy1jEUXF2DHgytLsLYbs
	S/TtwSvEX0VY9y7eUvUtO43BzYWmhNje0QsTSuQFaw==
X-ME-Sender: <xms:Dq0LZpFux3PK5TINn2pguxlAiv9mykP2HgMwULCi-82TGdmHX4V7gQ>
    <xme:Dq0LZuV14mwah55d6SKY5SQD4NXjki_P89RGUjmGTEcldqXyJCvg_hENnBzrNhdV2
    PAM9UHmkGyfOJe0Lg>
X-ME-Received: <xmr:Dq0LZrJI1A4-gLluLG6SDjtO3tq9m8OeXlKwDOK2UiE2RSzqz5-_qA2-smTE_mlCZd38UEdo4L5CYIRaI8xihb6Bb5m--AuuTQ8jHG6rsVP6PFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Dq0LZvFLrq6Mr_FtUJ-VrsKJXa3K2AYJNEvKtDj-_M6KRQFb2Yjszg>
    <xmx:Dq0LZvWf4DQ3FToV3sy5ed4c5hOU2JGO9ieQzgV4HzW5h193Fr-rhQ>
    <xmx:Dq0LZqPVHMDxJCMy5mQPP0gck5YLanpIgY4_CkOibWP1_a3MnIZbyQ>
    <xmx:Dq0LZu35GHMn2yQZf-DTy-ZLmfKOb7VYlTYuD7HA4WOxUFi2OT85Lg>
    <xmx:Dq0LZlfKX1ujbKzG3fhTj7QanoxpKhUTe62z0NLzC5VJWl-axHbGLooj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 03:00:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 275419e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 07:00:21 +0000 (UTC)
Date: Tue, 2 Apr 2024 09:00:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver <linusa@google.com>,
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] RFC: add MAINTAINERS file
Message-ID: <ZgutC_ddW_Psmlcl@tanuki>
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
 <xmqqsf0gvjrg.fsf@gitster.g>
 <owly7cho1eh4.fsf@fine.c.googlers.com>
 <xmqq4jcr6bx2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AzdPhtNhXLq8jou4"
Content-Disposition: inline
In-Reply-To: <xmqq4jcr6bx2.fsf@gitster.g>


--AzdPhtNhXLq8jou4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2024 at 06:29:13AM -0700, Junio C Hamano wrote:
> The development community has been fairly loosely organized so far,
> but I'd like to see responsibility and authority spread a bit more
> widely yet still not too thinly to compromise the project integrity.

I guess the main motivation of this statement is to reduce your load in
particular, right? If so, do you have any particular pain points that
can be spread across the community that would help you? Or is it really
only spreading the review load by relying more on subsystem-maintainers?

Patrick

--AzdPhtNhXLq8jou4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYLrQoACgkQVbJhu7ck
PpQyiBAAhuSiUzwJzjz6EQSOqsHJsM73F69UmgWegQcuLgkgCbniz67B4vOtKG9r
q8KIy+2Xzs/CsJQ4JOyLCZ2FBXLiIrDMbNIGr75Pqyd4kYyttIcPkWUQU3P9/SHT
0RvW00wDm68ORPtuGrhzWRpgN7hh3YlMh80QFDDW/KX4KglXmvnsPEDMKbF733NO
bekunW06dPi0HdBz6x201Ym7SbfWT5lTwmLN7kgavkW6JZGm2Gl893xiDPudm7+i
IzeZ5sNOVTMc5J5GcO/QHNKbUvVzqvrbarVa41utoVznCSWaUDfzaph4nYKbnTP/
s17NFtjzN7QKd51K1GWkQ1HkCOTr7CHt4c1/N9BKJksEMebaKUL4qNiWDY2j/OyL
jUNhe1JOfWIoqLgIz/CyqxZHf5lbKRwhZS3rAtmZFEgLDDdn8NHTTwAUlCgIOb4h
uAixddm5ZpRfNnldDLh43dVAPxk5FLHFMVDtpEyYugRM56A9s6q4KV1PpqSgyifb
KCapvpKO4qvm0q7bvZOQCruIpeYpmOvJPPk+3N9on9+fmC6njAFN8eEwnDQ2a+eH
stEvhAIO+y8wB7K8UqJ/RDIS8FsP6/TmlK27CCZNxe7wss727+8ATAA6u4EMT9Tm
dS5z6yN5HRF61roWfBQAiXzlToejSwmbj6E9aYFLlKgt5ZSFFUk=
=Oj2h
-----END PGP SIGNATURE-----

--AzdPhtNhXLq8jou4--
