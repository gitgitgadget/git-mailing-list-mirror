Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EA5265298
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765039714; cv=none; b=B9H0/DwR8C9FfkVNynBA9sL1XekH56L9SGH9iC+NugGl3g2AgtSE8+yE8z8S/w7PCE+zzvRZ2/IA2mB4gd8HW8J4zgJfV7GrRZWB6tuycTH8DgUMyDMVvc6hpMrm5Yoif99ANrg8WHm00I9IWjArfSzsb1/qSKVbsalieKwAwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765039714; c=relaxed/simple;
	bh=QlwCBj8p/X8gQsaMM2Cjpk2T5owGzXRItvc2fG4dg4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mu/BOlRHUJvyeyjRoYE6TOIHVlWdF/268s8EXS73FacIR2qdw/P+peLQEJDpupeXYYIKTGeoLvSJJv/D9RXgca5iW1fwTYjy+Afd3YSkOzRtk7PEsGZ6CD4jMsRx9IWnkYUfriU8RRdtVtjE+AfMd5zYGsnNlsYV8bXch894eLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TBIqf1AV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kh7ttn9E; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TBIqf1AV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kh7ttn9E"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E51F1400133;
	Sat,  6 Dec 2025 11:48:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 06 Dec 2025 11:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765039711; x=1765126111; bh=7AaCZfGZqx
	2Yiy1RTRR+YT5chDcqDu56EaiRxlCrHyo=; b=TBIqf1AVxdjCxVqAZCceARGhgc
	S3o4vVv5m/2AkTbOgIQXueTiFfWssjlkuWmDa6XTi+Xu88bsntSXbc8h78A96lYD
	gdVxoXqNAdnzmOn7wq5uLDu9Z2d00UY6qbXnhEY3D7sxemSOL6+j5oE4Xs61LP/K
	cF0qn7n3ZvJ4ckXZgIKyBe6n3CoWZndk3XsVxgJZHuvAChBuKr+hR+SZkV7hwc+C
	8l0olLY/JcGHp/Pruibqdf+UmX/AhBvMz6jHbLoBBeRyFhpb9BjhqefQLqGUpHKp
	ekNXG/7DKy+d4STcIQXPh1xSba/Cl8MCUzl8ZgR68O2e/Am7FPu6RjDI/2Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765039711; x=1765126111; bh=7AaCZfGZqx2Yiy1RTRR+YT5chDcqDu56Eai
	RxlCrHyo=; b=kh7ttn9EAcWNN+OfJ/OqsHn0plDLDDJNsEopwBZdnjYam3gdEKG
	iFtN1D1DdspclUuLn+Sc91D+46nJFtFi91WEVRIChnJmyS29k4ODfnDBcqipKDEi
	VapGTHbn3sc2sPVvk3lRsvJJiQSZyvtfKWjzDElICK2sE08XDjgUBSoliiHoBd6e
	oKjYbQDql4YLSlnpURjmH18T3mktipMkHT2ewWAdbCX2dLpuI3rQ4tWirtze6RfF
	POx7yOw04J4dJnZFINCyKFvLGt7hH1PmrRMW7l0stTBccVq+CcXTczBLY5JXpoCX
	3f2g4OFLOF4AeqbS9yhW97gZ+vwLiDlKWLg==
X-ME-Sender: <xms:X140aV-ltjqtgxFLPY4Mw253cG-UxrRPfF4REZwyujg6ItMy0RMfeA>
    <xme:X140aVguHatDkMvN3TpjJiua0qc7wBURock3UeoowMRRLvhrOgw4lY2j6QKJ4WyQ4
    cFCRJuPxMnaUYtC4BMi-9Vg1AsOMyO-P4xr8-RJIChR9B_V2YASsw>
X-ME-Received: <xmr:X140aeYEgeSQEbn1iaEXAjHaoKy8-Yws5sPbx3dX_VES7eiPiZGw6f92QYYgTycHTZKlErjIZ8v5F7qnp1t8CvbPHerDpOoepw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegrughrih
    grnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegrrghroh
    hnsehstghhrhgrsgdrtghomhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:X140aS_3C2BfQP_Vi7a96-29UF_v1jeBMxJi_0GypJw_oxXbuUhopA>
    <xmx:X140aYMPC437Vscz_cJqsN7RbMUtJ7K_pnrlCShzu07efQi121yRDw>
    <xmx:X140aXEeaA_2yLvzrJl8qZDwQ7C2OkUzwmRX2edUXZmZlXbiGl_Bxw>
    <xmx:X140aeyJc_JOsrgzzqlR693sK2DDy-X6l-67FtY9rFgeRVKf6_H29Q>
    <xmx:X140aRaM0bIWTB0f8PMYCqn_A0YnlmnRgGYtAJUR5fTrjLd-hXjiWr21>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 11:48:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Emily
 Shaffer <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Jeff King <peff@peff.net>,  Aaron Schrab
 <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,  Josh Steadmon
 <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 7/7] meson/Makefile: allow setting submodule encoding
 at build time
In-Reply-To: <aTQbbFisaCG8N_Z_@pks.im> (Patrick Steinhardt's message of "Sat,
	6 Dec 2025 13:02:52 +0100")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251119211030.2008441-1-adrian.ratiu@collabora.com>
	<20251119211030.2008441-8-adrian.ratiu@collabora.com>
	<aTLNxlKh02T_1PYB@pks.im> <87sedoemvr.fsf@collabora.com>
	<xmqqms3w7d9e.fsf@gitster.g> <aTQbbFisaCG8N_Z_@pks.im>
Date: Sun, 07 Dec 2025 01:48:29 +0900
Message-ID: <xmqq4iq3pndu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> How would that lead to build-time behaviour change, though?
>> 
>> Users in managed environments like $CORP can rely on /etc/gitconfig
>> or equivalents managed by their corp-eng, so I am having a hard time
>> imagining why we need anything more than an configuration variable
>> looked at runtime.
>
> I guess you could kind of have both: make it a runtime configuration
> key, but have its default depend on a build configuration. You could for
> example auto-enable it in case `WITH_BREAKING_CHANGES` is enabled. But I
> myself am not sure whether the latter would really be all that important
> in the first place.

Me neither ;-)
