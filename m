Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B869F155C97
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765194404; cv=none; b=BNkRAoaK/Q62lvdg9bJ/tyQMMIJDdxq8R7wm/+tTPmzN+2lDJVFfyReAGD5nNIEHaQrhh6jb7Z7/LXZG99iAn0ohVMm08uQTsug6WiD4x5J4x3lAIZj+kc4y0thWJMiRjFR8MU6xsAAQKsbFz2nhmkxesDPTmR5QHxPBBqati3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765194404; c=relaxed/simple;
	bh=qjjOQe+1ZmzlYRMF9LTf5YMeESR4bL3uBi1brje4IMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuwxZTW0c4WSPAShwGceb4QdvknBMs8sV5Vs2ZyiskSv7P5GV8bJKmWWXLhNf27QJO2mCd/yttbUM0mhRTcolMb2lTETWt1KioUv5DuNaOOMoJEMPLqop8TVt9TleWASB0OYbYeSMdX8TqnZGvGF/mA5+iFLJczjV3GywKpqmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WQAoaGTK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rU2MpY5a; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WQAoaGTK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rU2MpY5a"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A98287A01E9;
	Mon,  8 Dec 2025 06:46:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 06:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765194400; x=1765280800; bh=d2CLVhr7kK
	AjZKhv2TZv65J/RWrovaJav2LKdgyWp88=; b=WQAoaGTKHVXLlr6kDGLOY87g5q
	sFJqZamBkJLJX1gVeHi2cNCPLDulCCZKb5bA5cZeHc92wOxSlmEs64hbtBRp67zg
	XzFLtny+kNyvbgfHxTT1ytVlgClWpI0G+ujjAZHefVcXuMn+AH4MMnm+MOEdTqLY
	aaMW2fjdI8E1lz2fa97hfZvOK42NAE0YwUdcnzP5VqzA4QjGiHJHyJfBvIuxY801
	9h9OqOfUCJdaKCkE8rx123KMVUkCzRCWS5dURnUuY/4iVyNTLst0/tPjC43/lwk1
	uNwzXxMDLaz+bcx6OKJKwk8QQGFb9OSkWvopcCPxKHji6p6x7vb/aAJmtUGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765194400; x=1765280800; bh=d2CLVhr7kKAjZKhv2TZv65J/RWrovaJav2L
	KdgyWp88=; b=rU2MpY5a7YxXPdS+tMUmjoo/Vz/aeSIDzAgdY1wCkRQDNAp1owE
	efjoLN6s/xgubgMzAk3IPxNA0CKTEbbgyCQkVlmbKlS1s7n+e5xQgsgQv/g3DSNt
	3sD57UllBJN6/E8yC8WTunJbHav0JKhvs/C0JWgGm8UrCtYEbarPJuj5UFQHSsCc
	Sz0K1HcHJbWLCQ5tNx/Ja8FLPzvIyqRB3mJhcZRossOJ4sdcJsjGUcxs3/i0D5jZ
	3jObrEC3bO7bfcl2lK4bnzM68bxM7yr5ca7FBmb9/9Vto07uU9oHzgX9CgYAs6VB
	2cDPXeVQ6849ayfKYMZ+WebcKk7glZwnSUQ==
X-ME-Sender: <xms:oLo2afBalv5e_pii2jO2QByhyCe_IGD9S3nzvae0zwOlNXNDv5ehOA>
    <xme:oLo2aRXDKS52ynYFyDyPpzAxM6veWyopgbIhVliAC7dpo9DAm_WhnQ8vqJntRa9eH
    EKaFVjd2jmS2ws_mvtnesBueZIOfb7sw1nYKiRX0FLrR9rRWSuF8Uc>
X-ME-Received: <xmr:oLo2aV8nugKbVXmCBypv36lfP8YNxzs-MIKuTWU_w_vlWayoOXHy23hvEpf7OIn4tGHCcZX5L2Hl8SsYt6PTuTGf1ZcQ6J_-op-EZps64Ic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtoh
    hmpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhm
    pdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgr
    fhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsfihilhhlihgrmhhsrdgvnh
    hgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oLo2abRa5EijFx8piayiJsFVNvrAXuyfrYwgw3BSYYMsmeTxOnlA3g>
    <xmx:oLo2aSTtMi9L8Vhkys96NQtJ_bJLSz1I4LyPsj2HbeSDENjOb46f_w>
    <xmx:oLo2af4h7NmVMak1UMO9F6e_RPaDSj2zsZClYcaRBdjKFNmW-frdvQ>
    <xmx:oLo2afW61VMNw_eTGPfpTCnt70dqNp5Jg0PKyK8sKU6BhiaJim2GsA>
    <xmx:oLo2aW9e2oU2BpsTXWPoR0mznkrLzqbJ7VER5pESduHq4nKgKk3lWTPK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 06:46:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74ba8818 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 11:46:35 +0000 (UTC)
Date: Mon, 8 Dec 2025 12:46:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH v5 4/7] submodule: add extension to encode gitdir paths
Message-ID: <aTa6lr9AOPIZlw5M@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-5-adrian.ratiu@collabora.com>
 <aTLNwHpLUcy-WsZs@pks.im>
 <87v7ikeng2.fsf@collabora.com>
 <xmqqqzt87dgj.fsf@gitster.g>
 <aTQanNSlj6VxDY-n@pks.im>
 <xmqq8qffpnui.fsf@gitster.g>
 <87tsy1uz2q.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tsy1uz2q.fsf@collabora.com>

On Mon, Dec 08, 2025 at 11:01:33AM +0200, Adrian Ratiu wrote:
> On Sun, 07 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> Maybe the right approach would be to tell users to never manually enable
> >> the extension and instead to provide a command that both:
> >>
> >>   - Persists the submodule gitdirs for any populated submodules in the
> >>     gitconfig.
> >>
> >>   - Enables the repsitory extension.
> >>
> >> If we had that then we could count on the submodule gitdirs to exist in
> >> the gitconfig, and if they don't we would die with an error message that
> >> indicates that the repository is broken, maybe even with a hint for the
> >> user on how to fix it.
> >
> > I personally like the simplicity of this approach.
> >
> > I haven't however thought about operational complexity, if one has
> > an existing user base that have been using a custom pathname munging
> > code that needs to be migrated to the new scheme.
> 
> The good news is that for all the real-world use cases I'm aware of,
> migration to the new scheme should just work.
> 
> The problem we're discussing here (automatic fallback vs requiring the
> gitdir to always exist + using a migration tool) does add a bit of
> operational complexity, however it might be manageable.
> 
> I have to see how this works in practice, especially with the users
> setting the config (likely I'll add an error to block that path) and the
> build-config to enable the extension by default (will likely run the
> migration tool automatically on existing repositories if enabled via the
> build-config).
> 
> I will attempt this approach in v6.

One suggestion: it might be sensible to move auto-migration into a
subsequent patch series. That way we can focus on the general approach
of the new extension at first, and the potentially-bigger discussion
around whether or not to auto-migrate users can then be had separately.

Patrick
