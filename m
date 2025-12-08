Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2246926290
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 06:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765177097; cv=none; b=p0fU32rOkhw7jbVUSlQgEar+DFW2j5MMl3L5mjT74n9cvQZtMjS0Zz3K1E4LtiSvFRQB70zAAKTyOS9agy077nhv2kG6U3+F74vKuvkdborlFX9ECn8ALDgWl55SmoaHX3845hZRn9Jv7jnIFvY8K0Ccuhruk1zuqzlIECj3Qso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765177097; c=relaxed/simple;
	bh=ECw94dj4hoLFtERj8o1vBzqjHJ8Aq3NlADQpMmcw4XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCYKQqjQQDib0+ncQJdeIv8A7fbdVxb8VDjcXzC/qs7/+1Ry46ieRloUw9sBUZ1pr2+gSTaKOuJsjtQxJIw8Km8GaQ9cBimr/wi4wxrcMjvYz9PCufG3JXGzAygZaBoq7gyW9K4dczNoKjud7tT5OsOUV/0ZLz8/Ju0me1pSuwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EsFu8rvJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t2RY5OVm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EsFu8rvJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t2RY5OVm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 04B211D0019D;
	Mon,  8 Dec 2025 01:58:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 08 Dec 2025 01:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765177093; x=1765263493; bh=vNiY9m8voq
	KIS+QuWN1LDshnMMWehSsGpixeXTQRINA=; b=EsFu8rvJVBiwe8idgEfWLDFf0v
	fO17/ApeHKKTmNYqIuvSMe52Y+sHRvulDhmrz9SrosQJDlkqKRM0t5lCFJ2FZssI
	/kv1C2hx9g8g2CY0c2bP+3hE+IMsEM7E18Twnsglsm/XUQ62T12Kjf1h8hsFGvUK
	N17lHvVZWusa3ZyFfQALEJxq2bVnOZWtUaZhZix6ukPV2Ty0tykdSpl9/j8fA2on
	nsVNd9KDhaWfFuXhpK6BZMxP53ut5GdiBD+cludOO+chToY3uGKhkZ71oK3k7Gc1
	NMyTrla5TmxS+vsnUO+ooTZ1soUrYTg5CjAIG7b0zp3Xx3gDLp0s88Ot2xrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765177093; x=1765263493; bh=vNiY9m8voqKIS+QuWN1LDshnMMWehSsGpix
	eXTQRINA=; b=t2RY5OVmpyBmyXNKaSg/jJIqirElOiieAQd5IjX9zLfFKH8Qqah
	jpH1F/cDyq4J+tuaI7XXq1baMxKp5s1yzMQdFnFXsKmwhA/vzkwJCyYP37khWttC
	/riEL8mezjPZqzeboEEglz/tSVIv0f6Eo/tyrRIoQ8EbLc9gBmIb/Il++LekQlzb
	id7yXu2VInbITGTtSbonIy/IguK0mhwFPWMsgWlzQv/F1s2geFcA6EJz3Fh9TE0c
	ed90U6lbwrib9PPMj2ZBmKex8BgSVfMafASFTW8sZIULun3yy3PvaFzzgnNRDCql
	N3XvlkKq4FhDZeziIQVE0a512Odfw6IGLZw==
X-ME-Sender: <xms:BXc2aRxqyWlngeztEcG2rnY8mTF7TrugOpjsxiOqEL5Epe6Kg26BPA>
    <xme:BXc2aThatRjC2PAdVIrJkT4Y9COK5uN5jm00BL_jmjIJBXCBaEKZKeSK98Sn1P_RV
    Er1WAKO6shCkn411Ug622LV83dEnD969oqw08yjavYsPLkIUelJ2g>
X-ME-Received: <xmr:BXc2admVKRvHMLdlk_zHaEanSgLMGU-C9M-RIEtb690vUwel8djm7MPycL0r-mO8ATmQuco3WAkTWHzBFjB7BDQMtH3zHpp2XCHMLTdQEpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgrthhthhgvfihhuhhg
    hhgvshelfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvg
    htsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grthhthhgvfihhuhhghhgvshelfeegsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:BXc2aZgxEc554M6v29E1pLNqbqXLE5fJ4HK6c_Zgt4VPT2wJ3nACOg>
    <xmx:BXc2aR2Ctf_5yKGLk1YAlL848I5bQrRbVySDrqzluJCkH8c2I3FdEQ>
    <xmx:BXc2aSLUN14G1KgrvDJqwdXfrof1ZKid504SumU9uuEn2gSocKHnug>
    <xmx:BXc2aRw6jsXs-J0fpXRV8fVShLXrG_NLMkarDhlVEDwuTS9A6zw47A>
    <xmx:BXc2aRLayQhsncM8ClWpuiHzNJ5NHulz5uTtKaVosSt0NSmAp9HI3Ylw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 01:58:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ce1cf357 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 06:58:09 +0000 (UTC)
Date: Mon, 8 Dec 2025 07:58:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Matthew Hughes <matthewhughes934@gmail.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, atthewhughes934@gmail.com,
	johannes.schindelin@gmx.de, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/5] scalar: remove stale config values
Message-ID: <aTZ2_Y2FxbASYpPd@pks.im>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <8783db6153875deb52aaa354da189ae611de1057.1764607847.git.gitgitgadget@gmail.com>
 <ciegbs72xbepxawuf42pne7eu354ntbok5e3p6jxcuyddvaea2@6ykt3iej32xt>
 <aS6bCU19x-QM84tp@pks.im>
 <zbmzxqckpmf3h2sc7g3zvrhcyur2kmanv5uz6nyd2lgmi2it3b@i65jeyvcvqqy>
 <aS88bnmZXMZCV5oS@pks.im>
 <xmqqms3vnn9e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms3vnn9e.fsf@gitster.g>

On Sun, Dec 07, 2025 at 09:34:05AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The logic around this was introduced in 2a9dedef2e (index: make
> > index.threads=true enable ieot and eoie, 2018-11-19), and the ultimate
> > reason for it seems to be backwards compatibility:
> >
> >     index.threads and index.recordOffsetTable unspecified: do not write
> >     the offset table yet (to avoid alarming the user with "ignoring IEOT
> >     extension" messages when an older version of Git accesses the
> >     repository) but do make use of multiple threads to read the index if
> >     the supporting offset table is present.
> >
> > Older versions of Git complained when they see unknown extensions, and
> > we didn't want to expose users to such warnings.
> 
> Not "Older versions".
> 
> Any version of Git should complain mandatory index extension that it
> does not understand.  And any version of Git, even today's Git,
> gives a note when it ignores an optional index extension it does not
> understand.

That's what I wanted to say, but I did so poorly :)

> > That makes me wonder
> > whether it's time now to revisit that decision -- it's been 7 years
> > since then, I guess that many clients nowadays would understand the
> > extension. 
> 
> I do not think 7 years matters.  The only reason you might see the
> "ignoring" message is after using a newer version of Git that is
> aware of that index extension, and then reverting back to an older
> version.  As the index file is a purely local matter, it is not very
> likely situation to begin with, and when it happens, the user should
> be made aware of it.  Not understanding an optional index extension
> is not a breaking sin; but being in such a situation, i.e., the user
> is using older version of Git than they once used to use, is a note
> worthy vent.

Yeah, this is of course something that can happen. I'm a bit torn on the
usefulness of the warning. Sure, it warns the user about something Git
does not understand. But that's exactly why we have optional extensions
in the first place: so that we can introduce something without old
clients understanding it.

But I can also see arguments why we want to warn. The old client would
always discard the information contained in the extension, and that may
be unfortunate depending on the extension itself. Ultimately, it's only
the user that can decide, but they are most likely not informed enough
to judge whether the warning really should be ignored or not.

Maybe there should still be a configuration that allows us to disable
this warning, for example via our advice infra?

> So yes, even this logic was introduced last week, if the only reason
> is to avoid showing the note, that design decision should be
> revisited.

I think the number of years it has been since the new extension was
introduced does matter to a certain degree: the longer we wait, the less
likely it is that users will have mixed versions of Git clients where
one of the versions doesn't understand the extension.

Thanks!

Patrick
