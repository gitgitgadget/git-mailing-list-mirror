Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C8244679
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215736; cv=none; b=XIR4eGCu+MPyIejP4N87gN+QrK0G81niioE6q1jpB3hjsGo4FYEocdUqrHTogkFrHrjn0OfwM3ax9E1p+R9LOLaXSouePKZ+BczdqHSE+vWOtK4Xk3sa+AVn2dJpm6YFgp4puEBLRof0RcORwgUy6gt3PoEsYdVrFl6WdaSIPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215736; c=relaxed/simple;
	bh=d1XLBXnDQ3uojcWsBb8MWYNpDFxEmQx2zP38K73Btxc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GrAD3WfU2JM9QP4Lj/iNriyFqJrWfJyz94j6o/ix1a3BU/sTS76h5Ove0rgMN6OHqovRwO3GB53gAm3xPThr/4m1ttd0IdbPehrf+GJ6kuuRwy3ENXt7NHoGVFbzY5XJgSGMmDMtODDpUvuBqnONYHVQg7tjjQraRs9OoB60hnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C04ouxl0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PyBFZsnu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C04ouxl0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PyBFZsnu"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 754901400561;
	Tue, 22 Jul 2025 16:22:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 22 Jul 2025 16:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753215733; x=1753302133; bh=Kn7IkUyHEM
	TZSYoyz01U0o7DiXDrevoJq12vGTmitJI=; b=C04ouxl0ZWCaYHYo1EZxFJOyqI
	LdA5qrdFa5VzYOppTz2LaqdP8IXU6cgI19P1HwBzan5kBrAG1Nrr3MTqGWgDneb7
	i8WnDvCDXIwGRpF5wwlfWIM8qHgpBKZbYcY1I4+PPohHIGkYL3ypHLw2yNuQpw1z
	4Ax6IL/QTsAyyGIjIQchdw8YBTOTY9pEAp6NySb7y1n+VGCs9v+jR6zWzssyZBvi
	FNByojI6LjNkznSGBxlTOk2yF7p5Ckybn7zNpjT307jOi2FsPNWDusEOHYiREoGC
	+Ayt3ejDxePUOpTeGmUSy5/QsveQ0H/4Uj01QZnoC/IalaHv5L1rfcYykLuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753215733; x=1753302133; bh=Kn7IkUyHEMTZSYoyz01U0o7DiXDrevoJq12
	vGTmitJI=; b=PyBFZsnuaTVODhe5SEgROo2Q3j1vEB7P5Z4OCf+OlXzQUqpyQ89
	HWYXoPrqKbeWbrdvgp6bzS6fEnaqPD7ouv1uOjX0lAhPbSD2U88q4D3eAHuMng9s
	DVWbR68oP7bZZmTR7XZO5PL4UJAf8t0ean8N+tmfinsYWZVRqBEwxDwbRBOhsfmY
	xinQXCKSqdTG/8uu/EiCDBny4CVpqqcbmOiU4MICvzyJNHNHc873LiDHmH2CRg0y
	VypkFLZTKFZt6h/EqHKaFv+0pwcteVZVrD7ohIB3/bDE60VZxBwpDcxAUdwyaDT8
	uSJbifXcrreLusWW+yPwkohUKdaMk6J41tw==
X-ME-Sender: <xms:9fJ_aH98cs1ibEu-w8J3P6Sg7nB-C6YHP_1Xe7GFk_lgI_ZrNg70JQ>
    <xme:9fJ_aOQpl6o_akH-BB1gvg7CI2aUa3_NgLPjFU1ndqLyoWh-NdIA-_LJL1bbhG_9C
    Yebkiwodea_YRD4fw>
X-ME-Received: <xmr:9fJ_aBm8T6EDsJ0OagAFhWH1XVwSGz27bE1-zUBKkXUR3imuCw2kND15WniNPTVrq3Ft0R-gEoeLm4f0ipq32YyHP7TVTEaIH47hzOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9fJ_aGTCPhRD9PH1dDywotb9PbHpGzhAQgEL-QqpkyIRhY_43RJJ-w>
    <xmx:9fJ_aHPqJDww3VYJ2TQz_IiJ3uXRb95PHxNQscCXirCPUUKhxqlyvQ>
    <xmx:9fJ_aHU4SiqNgOITDmJ9vpQIvL4pm8GMkgrZ0r4ETT9fLfCpIsg7Pw>
    <xmx:9fJ_aGcOXE05E6LGF4o74ntc-mCkYGR5QTtrNwso2VYNIqw5H1nuWA>
    <xmx:9fJ_aCOjYBAYqe3s6ig7R0IyWRbGoSTOiGd7lDrB4u3tAIGnnVz__Z_Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 16:22:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 0/2] builtin: unmark git-switch and git-restore as
 experimental
In-Reply-To: <20250722180818.1043014-1-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 22 Jul 2025 13:08:16 -0500")
References: <20250722180818.1043014-1-jltobler@gmail.com>
Date: Tue, 22 Jul 2025 13:22:11 -0700
Message-ID: <xmqqldogrn64.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Greetings,
>
> In 4e43b7ff (Declare both git-switch and git-restore experimental,
> 2019-04-25), the newly introduced git-switch(1) and git-restore(1)
> commands were marked as experimental. This was done to provide time to
> make breaking changes to the interface. It has now been over six years
> since these commands were implemented and, over this time, there has not
> been much change that would warrant these commands being labeled as
> experimental.

Do you mean "as not experimental anymore", don't you?  We were
hoping that we would come up with vast UI improvements, that are so
much better that warrant departure from the past, allowing us room
to even break the backward compatibility.  Unfortunately, we do not
have much to show after 5 years.  But ...

> At this point, it seems rather difficult to justify changing
> `-c/--create` to something different as it has been that way for a long
> time and is used frequently.

... yeah, people grew to rely on that experimental UI that we added,
with intention to revamp and replace with much better alternative,
and now it is too late to change it.

> By removing the experimental marker, we help clarify the stability and
> maturity of these commands.

So, even though I may agree with the conclusion that we no longer
would allow ourselves to break backward compatibility for these two
commands, I doubt that it is stability and maturity to celebrate
about.  It (not the "have two speparate commands" part, but "leave
ourselves room to improve these two commands" part) was a clearly
failed experiment.

