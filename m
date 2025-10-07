Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A381B2DEA90
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857647; cv=none; b=sOQhcnNhnIiusMgZ2iiakAVJmcGN0AJLaTCpwymUpKV/MHC0ghJFoqJyF8SmC98mx6UyjBqVaCRa4QFOAQyb19zoT/NBthPmwptg/LdszF794++TVviVs/1h1wa1X9EJjAR5j7V/k2jOAfnfn4JvcXBDrk5t4CfiQhWZ1K7GW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857647; c=relaxed/simple;
	bh=XuNCLIMEauFE68NejCFeA6JTnuOE5YVSe04F+OEBR24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hpKLntK+ynrQYAMyvnChN8owCgtReO4mJO6sgo8q8Sgn/OPdjK9ADy6x9iWYyNKnf2Sqoj8sfvb5ebz11hfspbE63IEycIayN+du7jnoeCyEBl1prbF6MBVYFx9/HYJFAGV5tBI1rmQt4ReuVtElZDHnfI2Rty/2b2StQWyALSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BCKPem8I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YTncXtX5; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BCKPem8I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YTncXtX5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 824121D00233;
	Tue,  7 Oct 2025 13:20:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 07 Oct 2025 13:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759857644; x=1759944044; bh=UfC4pA/FS6
	QnRifiJMj5T1oOpbip/v119VFIl36QMKk=; b=BCKPem8INXdosP6w3ywbd66gQI
	QAPmaO3yr7PK+4bQqYnVueVJLVpM+xzh1pRxWYZwNikC6Gdego87+taSKOdFIWHQ
	9NGCIUx0N7JtKVYrWKUWrobF3nAxo4QxHMm+LHkNwxzEFPXOYn9dGqxQcymcRErg
	cGJSsToG2bXu0tdwrnOemewi0a+g8mDBN1nVzDceOlsHQ74WUNU0GAr53a2WqfYg
	E0t1QF8UchM+8LfzYvy1BpsxxLuA78y/m7gyl0e4b34qqKpnJlo3VGFUunWYYqiv
	aM4EEGqe6nj5cDOqlUSnt9ZTxffIizarO9T0Kls392RPLBzgZ0wAqMKwFCUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759857644; x=1759944044; bh=UfC4pA/FS6QnRifiJMj5T1oOpbip/v119VF
	Il36QMKk=; b=YTncXtX5ZDsfEP643M9pEHqFGAlAevwLbuqTZfVmgvttlmTu01e
	q88O2dUdFdktnwYq3m581qsbuKp537QWAt9p8x5BIQCU/qA4xxJHh+j2+q0VGKpz
	92xSc/hGxzpIMICluYXZxeJYQi7scdBkw9hrEEta1anWIbH5AlGdhqnQ61V7z1OV
	ooM7NdPdaqqIWuTvQeT54biLPIewtsXrELTeNexPD5xqkv80IbCXT7KX/vdG3P1H
	xGjbyKPXYWAjvrDav9y6exNttZuP93HNh5goEZUqlVaaSGpgfzGeU1tZMH2DVvL6
	oNz2IE0NHOV9Uer0r2sZvyx9Cs8lHMQmHoQ==
X-ME-Sender: <xms:7EvlaJ4vm-EW2cp1hLkjKxZXUqoMiV68rXEnQ1v30TAd-NYcmvFUzQ>
    <xme:7EvlaCultCIPdA2MeDcjKcjitTP2HyEmJfgPTssNnNi4M_K95-rqXn4puhjoL7fUp
    lMLed6d4NWNxbe8__GAC4ooRwLNqZc-haoq4nhD5EQzbseqbqyV>
X-ME-Received: <xmr:7EvlaL0uRGmGpOEtwg2vaMrGp4ztUCO_f_CTCTU2K6k2BY7tAYCOGucUOKs44tV8ljknsc0vO_2W1nSnICPa_wsYy3RDFGKDwGgR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtph
    htthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:7EvlaLrx70LMEqv6jIHDrYks2F767g5B71ZlForkwJ7uX7xrg7TrVw>
    <xmx:7EvlaLKeWX1Vk8LqPmhED71hV0Eu36MMLfWWO7WhrX-Ov4ao0CPa7A>
    <xmx:7EvlaHRP07bkPPMDEWs1P_G9w5aTTtaGUwLiyDOWH7b6v_4kgXoXHQ>
    <xmx:7EvlaDMa5FF-2a4xjUyFqNAmjyxcQ0jydAHmGIIXdcWoUyFA_Fgnnw>
    <xmx:7EvlaA2sYBE_wWtfl4FysI58xkMn0vCuGeVgQ0tDJIkreZww0j8b_2Sz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 13:20:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 4/5] submodule: encode gitdir paths to avoid conflicts
In-Reply-To: <87cy6y4xb4.fsf@collabora.com> (Adrian Ratiu's message of "Tue,
	07 Oct 2025 17:10:39 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-5-adrian.ratiu@collabora.com>
	<xmqq347wq87s.fsf@gitster.g> <87cy6y4xb4.fsf@collabora.com>
Date: Tue, 07 Oct 2025 10:20:42 -0700
Message-ID: <xmqqo6qik4r9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> I will percent encode the upper case by modifying 
> is_rfc3986_unreserved().

Again, do we really need to encode everything?  We need to only when
(1) there are other submodules that would collide with us (e.g., by
being only case-different, or by having our name plus a slash as the
prefix of their name, make us overlap with them) or (2) our name is
not filesystem friendly and needs munging.  A letter being in an upper
case is not a crime.

>>> For now url-encoding is the only option, however in the future 
>>> we may add alternatives (other encodings, hashes or even 
>>> hash_name). 
>> 
>> Let's not say "For now". 
>> 
>> Choose a single encoding that we can use forever so that we do 
>> not have to upgrade extensions.encodeSubmoduleName with suffixes 
>> like extensions.encodeSubmoduleNamev2, 
>> extensions.encodeSubmoduleNamev3, etc. to cover our earlier 
>> mistakes and force renaming on users. 
>
> Understood. Will drop that idea.

If we are to consistently use submodule.<name>.gitdirpath as the
authoritative collection of name-path mapping, then the exact
algorithm to derive path from name can be improved over time without
having to worry about an old submodule whose path was computed by
older iteration of the algorithm colliding with a new submodule
whose path is derived by the more modern algorithm.  So I do not
mind to make ourselves aware of the possibility that we can tweak
and improve.  But as I said elsewhere, I do not think we need to
even say what exactly algorithm is used to the end-users.

Thanks.
