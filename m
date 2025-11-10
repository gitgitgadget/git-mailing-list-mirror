Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA62231A21
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816657; cv=none; b=F9IV7RXU/+4s+EOsx/RQvZR6vmoLggGSakVSMAFuu+NaOPJMrS18rKbEqnnupaAiaUpEmI5WovCpJvYhRMubchWuhJjuCeBrh89BNupb0Vdn1M69eV+YqXVai2/cAZYxaqj876hPAaFcm/kpfd+g+/BQ4l6op+E4wPr332P4HD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816657; c=relaxed/simple;
	bh=Tq9AXZfrS/a8YAt6tzM/snaoD0m3OAzO90lX0F2x8Ho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pzNLBRaH9k4+oqaOnDPVs09tTE59Zpxzhj4moGnn/CellYQT3OM3czpGoJ5lafTBONIhSpQBkKEkbijlUt2ocxygOP1BCDO4jPCk2Bg6E5h6sA5q3xx8PpDjes4KoHbyBZLCG6OnZKt0/cJtSju1m8OkpbHXtMk0TevmGyqnouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=flo/chMK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J5h7k21g; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="flo/chMK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5h7k21g"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B6D8C140012B;
	Mon, 10 Nov 2025 18:17:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 10 Nov 2025 18:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762816653; x=1762903053; bh=+FmG43NvCC
	F7ejIom0yKgFbnA6JX/EY/bFaqOBGbcDg=; b=flo/chMKPa9PiPuo7mqFF00bQk
	kglJEKos5H5EV7HIL0OJ7RJDkT25JYeisHpTEtwJbfh87h+N+sMbclR71Rf/+Ut1
	nEGjontqC5/7K2UreSKh8sgnYaNQ5ePGFMOKyz2ZgzsSl07oqIHUYbrHj/5eLI7M
	RHPpz5BvK/V7qXtZuN4RiY2tYm0kcqhbmHC1MHIdXITyg2CRkwGJsniU0s1NqHmL
	o8TvUn7Z54P/AEY15YK/Zrzcx+Jy8hAW3IAhneGZf+v21kpFM/R7HCERa0HpLLQL
	coDr8ZgmvF05yMoSQnEZpOERw/xZ/qybdVAbA6SIqqn0IEzhjk43MEXAyU5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762816653; x=1762903053; bh=+FmG43NvCCF7ejIom0yKgFbnA6JX/EY/bFa
	qOBGbcDg=; b=J5h7k21gPRpit99m3Krc1b+h25M2AlhYlGYDpF1ZkEy+enVGfvJ
	9grl6jFUtSDa4U5vEsmH4aIebgHIsl2Hr6bvH6/ATs2mn7utwnp7bUSw83rON0Yr
	A+xKOnSwdgIPIO8qkWHvWRC/hmr/sAypbCnnasLs3+WTyNceo2AI7Qykqy/lToN7
	O1d8MiSCeIsAscIREgdPDoJUjdGykvtDcCtie/tKWEJ7teo309LiLJ6TiywbHtxM
	wX3hMHd/9n7j1NX0aGJ8HidaMsWTrEyp/3YTLyb3h/T/VvfI6piZtjaO3WK4RF9r
	oeU1n6vD5DrAfV04VpumQOJWWegvZKvVO3w==
X-ME-Sender: <xms:jXISac_77R1m7gpdLSGYi7Kgkcl3F2Y6ug3yUw7dhUnX_kzthJ1ALA>
    <xme:jXISaQiclfCiKYlDhR8N53lgEvgSrs_6qWEy9IpO8dHN5nVCSAko4Klkhzgv7uz3f
    2lt8GeYaw0-RsUC1_YZwNt-2l2MuAu-z2f2AV9uPSJ0moAfSFEi6x0>
X-ME-Received: <xmr:jXISadbYk2nBpsrAfZ01jPHHfoWoYlvG9e5YmwBe5ZAcNfm2CTIVnDFDUcMh2OQUtQ7EKk2Spmqx1WnmLeLTJy6LVhVi3_6zYkYG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhi
    hshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehruggrmhgriihiohes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:jXISaV_UuXQcCuDKqB0DQeTJM42dM-nKx7yhxVCLuNioued1IQxasQ>
    <xmx:jXISafNcCxh51INkVpZDVwBaOin66A3TJSYfjMuCjrQTNkHXe5PyWg>
    <xmx:jXISaSG3WweQ_DmbIHWvlPuKOzVWPKDMhzxJCs4nFmiwXLwVVsJgow>
    <xmx:jXISadysmcIdwCGPbGAai6Bb06DchwZMkSy9GVhRhahqrs1fTjWpVg>
    <xmx:jXISaUNgJ1ieoHEyplvz-TbgtsDaw3A55AspVNc3rrwNa49CbRXo7ZfC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 18:17:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Aaron Schrab <aaron@schrab.com>,  git@vger.kernel.org,  Emily Shaffer
 <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Jeff King <peff@peff.net>,  Jonathan Nieder
 <jrnieder@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/4] submodule: fix case-folding gitdir filesystem
 colisions
In-Reply-To: <878qgdjxvc.fsf@collabora.com> (Adrian Ratiu's message of "Tue,
	11 Nov 2025 01:01:27 +0200")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251107150547.3272180-1-adrian.ratiu@collabora.com>
	<20251107150547.3272180-5-adrian.ratiu@collabora.com>
	<20251108T182050Z.vbNv4y2kizC1@fnord.qqx.org>
	<87ecq5ke2m.fsf@gentoo.mail-host-address-is-not-set>
	<xmqqwm3xzots.fsf@gitster.g> <878qgdjxvc.fsf@collabora.com>
Date: Mon, 10 Nov 2025 15:17:31 -0800
Message-ID: <xmqqjyzxxyt0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> I tried the mkdir approach. Unfortunately it does not work because 
> submodule_name_to_gitdir() is called on all submodule paths: both 
> existing or new, valid or non-valid.
>
> So if a dir already exists, we do not know if there is a 
> conflict. It might just be a normal valid path verification of an 
> existing module.

Puzzled.  Wouldn't that only mean that submodule-name-to-gitdir is a
wrong place to see if the name of a directory you are planning to
use for a newly added submodule is available?  IOW, don't you need a
more specific new helper function and perform the check in there?
