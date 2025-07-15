Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B862D12E4
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569647; cv=none; b=vEkBq9DX2KzEy9dDmes5F1iTyrTQirsb5bNmk/Wyzjm26H6SbHYBR+Vu/SJJWJFAH/vc8BnctpYDQL/iEPix5PU0ehDB3LUnqoyTI+hwChgzA4IRA9famCqr+rInI1o3XoGW/gd1C03k/lUCafkd5mVDiiN5z3oNU4wsQcVYFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569647; c=relaxed/simple;
	bh=1QGjR5Wna4VKuPvMdEkhmAXLOiM+e/J6Zdswfd0VGL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1OkZui5AQ92Fc/3gvEuqyaPO2WQhvl7vBYstZl3rkBlzqNuKOFi1TO+7Xbd2paTRdZFEkKEJg+4TVt9SevVZwfk2I2RhD9x2auAgKdmMH++++hodky/dR4C9rY28kQy1/x9cobobC3Ht5zz/c4oq+PxQ2+l0/AL7J8azNWDOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=phIBFygd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frhMG/Ir; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="phIBFygd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frhMG/Ir"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 044BA14001D4;
	Tue, 15 Jul 2025 04:54:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Jul 2025 04:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752569645; x=1752656045; bh=SzJHFzyFXW
	VZgPEU6uvE0Eo/Qz8gSqi5HWxqpVWS0V4=; b=phIBFygd2QS2zhVakR9H1lPsmW
	84Qprute5rOhZjQyWHfOP2oUTqbWQg/TjmRgoHB5K5kwge4f6R5f9Jq9fBMtyGrW
	DZ14OLNiSE9qj1/8RwDLigFEKz8YRkMw0AqpHELExqH1jqJJMIIX4PcHrb44C2Jq
	Vn3s0dzESavX+Xcu5zzeu7U77vKpF+YA2AA/pPJ2FgjDoKtjIX4AgqWoUEobTOdV
	JcFmcziDRHV+F8Zdo3aDML6UlYJmkFPuxV2WM3i8GSUeRtXMAlyBjZdqGUsvhZcV
	IwmohwdMLh5MlsZ//6cQ/b/YJPpi5GOpgtuRTw8E1fbYrmX5rwZV0+Itvu0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752569645; x=1752656045; bh=SzJHFzyFXWVZgPEU6uvE0Eo/Qz8gSqi5HWx
	qpVWS0V4=; b=frhMG/Irjkb3gsrZI1OXMBGslZ35BqDVdK/2C0TYog+xL7I7eUY
	bdacReqcACJtScJbg5geNx42F5JizuHQBvDet1qLfmovbN76xi+ESEpQYPUz7q5A
	C//0bpiRjsbFcFb812Y7AkD7Hwvumb1Tzd2bl0Vj6PhK5y1zKCMNGz1qlLnGXAM6
	msdyVh+g9jdzJ0ST+vqCS+zj+wfyl4Mw6M+agVd06ZPXXBqXncKE4tEQsAR5+UCd
	D2hiX8VEPtOmknKyT87Ny6FmxTACvlEgKfnKBOMeLTx2sojylwfq1kHgkpeyUU/O
	KaCZEsc49Q+sD4ZnoyhGEYBPmprlMrwu5gw==
X-ME-Sender: <xms:LBd2aAf0BVEi1qABD6GKdcFjalIy-XyngWWN2zOzmJUtjJfMnjPsNA>
    <xme:LBd2aFc5uRV7-zat-R0TOjGwx2o4lB-TG5UWgxKZbKkWK9z6WKuxrhWuyX66koSv4
    sTHoOdCnFEo8q0kmQ>
X-ME-Received: <xmr:LBd2aK8XYOBUDYQGm7x3uRQn7HY7e9vExBdTTEbxUHypiS-u0rkIis2fHyRKiQHIb68bxHI6A0AsUUChUEJTC2KIOQ4zodCj712ddd6C9h7nVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehgeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LBd2aBnL5t_Hcmcq0NyWne0AlwGF0Lc_UDdnUmYnaLD37MrLZLEcVw>
    <xmx:LBd2aM9wWqMmn8j28dPHfLjtpUttDZzZ-PWpszgC0Lz0cdON-UpZtA>
    <xmx:LBd2aPkLg71Vm_S4xXhrXxvch-rQDbDayuMUYiSwvheFTfRyV0i4jw>
    <xmx:LBd2aJ2PSMh_CWwOQcYIUu2CU-VU3kUO77y1gMl3zdzS23M_Ztk2eg>
    <xmx:LBd2aKEg-7bSYZvTVk_ADXoFLQ3jrtKaIFENbo_TSLabyQlJLHbRehGC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 04:54:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 141d9429 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 15 Jul 2025 08:54:02 +0000 (UTC)
Date: Tue, 15 Jul 2025 10:53:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] strbuf: add compound literal test balloon
Message-ID: <aHYXJ7EmRQE1P5xe@pks.im>
References: <7ac55a5096c261b706f47ca239c381f71db2b67a.1752499653.git.phillip.wood@dunelm.org.uk>
 <xmqqa556x2z4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa556x2z4.fsf@gitster.g>

On Mon, Jul 14, 2025 at 07:26:55AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > A C99 compound literal creates an unnamed object whose value is given by
> > an initializer list. This allows us to simplify code where we cannot use
> > a designated initalizer because the values of some members of the object
> > need to be calculated first. For example this code from builtin/rebase.c
> >
> > 	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
> > 	struct reset_head_opts ropts = { 0 };
> > 	int ret;
> >
> > 	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
> > 		    opts->reflog_action,
> > 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
> > 	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
> > 		    opts->reflog_action, opts->head_name);
> > 	ropts.branch = opts->head_name;
> > 	ropts.flags = RESET_HEAD_REFS_ONLY;
> > 	ropts.branch_msg = branch_reflog.buf;
> > 	ropts.head_msg = head_reflog.buf;
> > 	ret = reset_head(the_repository, &ropts);
> >
> > can be be simplified to
> >
> > 	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
> > 	int ret;
> >
> > 	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
> > 		    opts->reflog_action,
> > 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
> > 	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
> > 		    opts->reflog_action, opts->head_name);
> >         ret = reset_head(the_repository, &(struct reset_head_opts) {
> >                 .branch = opts->head_name,
> >         	.flags = RESET_HEAD_REFS_ONLY,
> >         	.branch_msg = branch_reflog.buf,
> >         	.head_msg = head_reflog.buf,
> >         });
> >
> > The result is more readable as one can see the value of each member
> > of the object being passed to the function at the call site rather
> > than building the object piecemeal in the preceding lines.
> 
> Hmph, is it simpler, I have to wonder, in other words, I doubt you
> simplified the code.
> 
> One thing the above rewrite did is to make it clear to readers that
> the struct instance is used just once and then immediately got
> discarded.  As long as the object that gets passed this way does not
> hold resources that need to be discarded itself (in other words,
> does not require a call to reset_head_opts_release()), it makes the
> code easier to follow.
> 
> But once the struct gains members that need to be released, I am not
> sure if this construct does not make it harder to spot leaks.
> Somebody who adds a member to _release() to the struct presumably
> audits and find all places that need to call _release(), but among
> them they find this place---now what?  They need to first convert it
> to the old fashioned way and then call _release() after the
> reset_head() call returns, I guess.
> 
> I am not arguing against all uses of literals---I am just
> anticipating future fallouts of encouraging overuse of this pattern,
> and preparing what we would say when somebody adds a new use to
> inappropriate places.  Simple cases like the initialier should be
> fine.

We already have a two test balloons, both defined in
"reftable/system.h":

    #define REFTABLE_FLOCK_INIT ((struct reftable_flock){ .fd = -1, })

    #define REFTABLE_TMPFILE_INIT ((struct reftable_tmpfile) { .fd = -1, })

Both of those are getting used in a way that'd break if those weren't
properly supported in "reftable/stack.c":

	for (i = 0; i < last - first + 1; i++)
		table_locks[i] = REFTABLE_FLOCK_INIT;

	tab_file = REFTABLE_TMPFILE_INIT;

Those are rather recent additions though, released with Git 2.50. I also
totally missed that we didn't have any test balloons for this syntax.
Should we maybe retroactively mark them as test balloons instead of
converting and marking some new sites?

Patrick
