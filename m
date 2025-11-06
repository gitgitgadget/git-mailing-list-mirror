Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE542DF132
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413268; cv=none; b=XeQN2rj4yWPn8MzrxQnGMCjCM9fdVevPtleREHjWxbv/+QOaPju//krcEoBG/LjcdAzNQrLmnR/DAN2Rkj/TdB9LHwrhjR9CHvFadZzzoCJj1J6iDjIQQYb+P24N2Hz78d8R2bO1CCNKLkh9ztJ5JG+i9FQsjgPS5tStoJfBCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413268; c=relaxed/simple;
	bh=JrFc2yCCXvSW66CzzW9Q9248x3xVclj4nU6hpUB6e5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXZMVtSIzu6KcX59RGQQaYftEZAJKbfIbfYUNl8OkNnsP+FaSA56eVorAbLF8pIh9vZKHnEDLIl+n76N8id3Iar5zCM6r85JObmzREojuGtkoqtXHaCv185VReS20sG0swbZqlJVnS8GVSqbwLvm6qLg+x20pvmQAdQXs/HdKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vi3IF96k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xj0Q/KlX; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vi3IF96k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xj0Q/KlX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E6841400186;
	Thu,  6 Nov 2025 02:14:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Nov 2025 02:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762413264; x=1762499664; bh=ZqaY386/+Z
	kq8qKsEP3K+wt4afPV7KEfnjHelKXfVBI=; b=Vi3IF96kS/ygnbCETTh31GT/6V
	oOc8E4NFB5nYb/GTcLcmSsSi2+FOJQG6NxPsQ2fyqWq56JWP39L7bLFina86/JLR
	aEr0zJECp1xkCYVCvKyhEqr2oFM8OHVbN40dtRQngGxjofQl5S5mYd+jlG/eAi7k
	AWqY/Tx1oevsiNr9JY89xou9WtswEj4miyQFDLzHbhA8X6WC5nTNYJp6AfrHQefJ
	TdY59lwZjB/UyNRQeh3N2HrCghH0d5onjwQeO91O6HOHBkk4v9YIeeyrCgFkSZaM
	Bluju6h1ZrIJnKnD57mVS52PSS42lyq6nn/yvheqxbBzhxFCOkfV7+oevHXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762413264; x=1762499664; bh=ZqaY386/+Zkq8qKsEP3K+wt4afPV7KEfnjH
	elKXfVBI=; b=xj0Q/KlX0qr7XqiFLobLP1zroPEAEfmEc/8lM0Akl3lpQ5HAZcA
	RraQCnVhUGdmaX7nyHfhNMOk/CUJt22pJw8tqq7H7uuV3KeOBKZNBrvFHpFeP9l0
	VPVu2fqIJ0e/6lt8qC8EA7U/gNcbEiE51zMrh2VW99qkhadz5c/IgBai0vfyMIO/
	NgInc+difahva3YwSsj0d60I5/P8uAh93CzNCI/b1Gv7H0iamt3mUF9DFHo+ojgJ
	5VdH4NCewaFHEk1fNxmRnsc4/tMLGDQI7Cu8lzKwP3P7bxUVclrsXoChsp6K0bpC
	aMuc+5pKvOvkEc5Cjmx6awz5Dt019OxYA4w==
X-ME-Sender: <xms:0EoMaRXJPycU-VaOzKZwWkW1hpH05UnI5msiUQUHf2brplov3USxjw>
    <xme:0EoMaXkbwXIaSKZAGJXYj3D_Y93Srt2Joor3PkJR9clxhYR-S7KqZZfDb7FjNYPfF
    Y4eLpKrTAlWrn_THy90Co6U_rN3mwdaRzJ4GUefDvCI8ygnvYH4hg>
X-ME-Received: <xmr:0EoMabBevNDxebkgjmoctfPQ8W1YuZx5lS5GCa42ocTu9AvGYr4KQNCypLm8xg0t2BZkYfkHAk84Dh1HHSDhld3Bw7x606cVh-U0Z7S0I_7v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeiudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0EoMafe5YC9hq9oM867XeBErX-Gpx0NC-KBA5viTfFJx9OeCmr5Mag>
    <xmx:0EoMaeKVvZ6up0GNWSF4mUj9clPo79Do8q0W_5tHgbY70aHyFluvgQ>
    <xmx:0EoMaafIUbF4DFQHOHTUJrX9nR1FwArgTF8P6YlVTy5ditbeyUqakw>
    <xmx:0EoMad0roaGx7De6fWRXH7DUtxTFH__nl4u83WAgU8Phea6LFBKDDA>
    <xmx:0EoMacsFoCMdnjfdlELWdyiWf8MriHpTLOISvKZ8sJ2YU6buf1nxYVjY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 02:14:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d0a3eeae (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 6 Nov 2025 07:14:22 +0000 (UTC)
Date: Thu, 6 Nov 2025 08:14:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] GitHub CI: macos-13 images are no more
Message-ID: <aQxKymC222jUhhRT@pks.im>
References: <xmqqh5v9o0hb.fsf@gitster.g>
 <xmqqo6pgmtu1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6pgmtu1.fsf@gitster.g>

On Wed, Nov 05, 2025 at 06:34:30AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > As this image was deprecated on Sep 22nd, and will be dropped on Dec
> > 4th, replace these jobs to use macos-14 images instead.
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >
> >  * This is a monkey-see-monkey-do patch.  There may be additional
> >    adjustment necessary (versions of tools available on the system
> >    may be different, for example).
> 
> This, when test-merged to 'master' and also to 'next', seems to be
> enough to get GitHub Actions based CI pass.  I'll fast-track it in
> order to allow us to run it with the upcoming -rc1, and eventually
> down to 'maint',

Makes sense. I don't really expect any fallout from this -- GitLab CI
has been using macOS 14 for a while already, and I never noticed any
issues with it.

Could of course be that GitHub does anything special here, but I guess
that a green pipeline is confirmation enough.

Thanks!

Patrick
