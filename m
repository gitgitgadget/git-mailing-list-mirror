Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA328CF5D
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801209; cv=none; b=Gr9E+oD52gSNEeM89S0VqCvmL3GyeCdaaTiheuxQbKhL8v2l88aCGUp0KLWZzKYF9EhF2QGUGnE4oqo1tvvM4xsrwgD40mewAIy16DyOsEtRROD2mooLszoWM9UUzYbvGV3kx4Ggp6Bn491s2clsxXkUCnquQBlOGFJW9BUQNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801209; c=relaxed/simple;
	bh=GZHdMdV8JF5EedCzOjTMyAhEbmFRHoN54rAytrGO9R0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=szX7A6DpVaxhBtUyKYRymZf0T8RcEKf8oNvZXtVhk5H3o2u3uSgVVXxdhxeI0I3r7s77gZlO0Vcj5F0y/DneNPCZc6zeLFs4HTFg0RVKdBuwjuVitV/vaTEJ5woKI2Tm5Stt1KBcBpyQ8dheWNUsqjj+HLaMW1mBipLIrJcjLFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bWOUak0T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EruEGWxw; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bWOUak0T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EruEGWxw"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 499697A05FB;
	Tue, 29 Jul 2025 11:00:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 29 Jul 2025 11:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753801205; x=1753887605; bh=WUEmp6kJn0
	uEyjVecas0HVIpl9BAe9+nsk9u5mzZ/wY=; b=bWOUak0TYoR4i6XYa9bZBgUFsa
	6IjeDBDpMKmBqztJelHD2KKBeyBB30wrvmT1APeHVbbS6ocpKe8r0qNio5loHct7
	0RFQXUeST55LWWZNdHtDwjM1tJJLVxnYVPTvtbtvNVM79a14ZuoOmDjDhXfMKVH6
	7hcB//bmnk1AIoJAE2zew15zV2eUxKwgxIPdii16c74ncrcrtnvaFkFDOq37HUU/
	RmjgcxPFcvzJCcpsXt1g33QTEyCmnSthEHkw6IrD7PR9Z5PfQAjR+2cPHVsHwMiT
	Bn6Wd1q5qe+4Gp47VmZZSk4PSlF7u1ORwAtt/n0f9FtctkkJlehpDyRRSkhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753801205; x=1753887605; bh=WUEmp6kJn0uEyjVecas0HVIpl9BAe9+nsk9
	u5mzZ/wY=; b=EruEGWxwPcETqqoAW0G8JvfpPHXJWAEP1UWMraIsmuXBCiMCr0t
	UWJNJdBM2v4LJpr+5H88okaMWlpPurU6QyvSzKQizXP5Aru8z623vHhZaYqBbtr/
	SIK15eDiov8d5qQYtxGBA/rFl1BCf8mb1sPPAVCdyc79J8teQ0NO/zuvlujFnzSZ
	+Ov0TkZST/cUmsvQGA3cRPVs3epSncJG9yBy5i2UAPIv5y9t/mCI3Dhf7GSml17K
	yl1ct472r14hBlOQli3yjWC43+5RG5JbjbnnE9TYx5DITPKoGRKLUrOi7NSe9l8m
	lZH1MVLrs3wYysowA5afKiGwBRqP6a5/tQw==
X-ME-Sender: <xms:9OGIaH3ALDp62FItYlYdQzUcWqfW2rNZTtUX9KYOXsQRBiLmNxiuEg>
    <xme:9OGIaC8YWFoNprZS60xiCPhcVft2lioh210GGq7C6JuvKnKD-KViRk7v3IL13k2XL
    Cjru5SxEIZ5Q5XcrQ>
X-ME-Received: <xmr:9OGIaHo7Hbhi5Ybb2mhIv1yh5WUgP7EXof5XbCzSb5A7ybywS5R8qDK2xnJkaktc26ncMHbtRbcJbenCp0NglH3S3i97Tg2zeSaKqZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelheefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthho
    ohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:9OGIaMQe2snM9FAUQf0jmMhz6YCx1wFPVny312uAtuYYUWAOoaKDWA>
    <xmx:9OGIaKPn1E9aIlWnCh1KT7LTaEOG5jcouy3lLchyT2pjk6MlyMBQGw>
    <xmx:9OGIaKgODvMsGiXOFz5com9ejWLvKSalBwXUA7jmAJfw02m7eW_Ylg>
    <xmx:9OGIaHkU08jfNt_ZR6II9q15SDCG_dGfWkf9Qed58lptkaL8c89wuw>
    <xmx:9eGIaALM9ASFmXY5t_TEs66oGlS4veB83BMVz81QpuucF6dmSZfWcw30>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 11:00:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ben Knoble <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,  Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 4/8] builtin/reflog: implement subcommand to write
 new entries
In-Reply-To: <aIhvcSHrRLG6wcMD@pks.im> (Patrick Steinhardt's message of "Tue,
	29 Jul 2025 08:51:29 +0200")
References: <6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
	<6E84D571-CC02-45E6-9E58-DD918B45998E@gmail.com>
	<aIhvcSHrRLG6wcMD@pks.im>
Date: Tue, 29 Jul 2025 08:00:01 -0700
Message-ID: <xmqqseifqbym.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> There's a big difference though: `git reflog drop` won't ever do
> anything for a reflog that doesn't exist. Consequently, we know that our
> DWIM mechanism can kick in and resolve the reference properly if such a
> reflog exists.
>
> But for `git reflog write` that's not the case, as you can write a
> reflog message for a yet-nonexistent reflog. The DWIM mechanism cannot
> kick in here as there is no reflog. So what do we do in that case? We
> could of course just pick the first DWIM rule, which would be that we
> decide to write the reflog for "refs/heads/$REFNAME". But... I dunno,
> that feels too magicky to m

I concur.  Like update-ref, a command that would work on a name that
does not yet exist, especially when it is a plumbing-ish low-level
command, would be too confusing if it dwimmed based on what names
exist already.

I wonder if it is feasible to correct the UI mistake of "git reflog"
using the dwim-ref logic, and compensate it by teaching "git branch"
and "git tag" options to drop reflog for the thing they act on.  At
that level, there is nothing to dwim---"branch" is about branches
that are either refs/heads/* or (when run with -r) refs/remotes/*.
It's sort of like "for-each-ref" requiring the refname from the top,
while "branch -l" and "branch -l -r" always limit themselves to the
relevant hierarchy.

But it is probably not a good idea and is way too late.
