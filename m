Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D14225415
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768155859; cv=none; b=XZnDgHPgylkoNSy/UPTCy+CToTv+uBT3tRjvBpAEizxS/HJI+mmxqlxw3Pn5JgW+KVswbH8VOeBYyM0W/YlQB5gc2HwjG2UzbN8bzrZ/krSnVU9/Mm3Co376/nlTWwsxsilzNSxN5MmGRxgLhwZn5KPNbSXaNAo3eY4h8bIl6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768155859; c=relaxed/simple;
	bh=CSrwnMJHHLCRZxmcZwjWohmYWDJFHh3o84BlqgX8qHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=miLYPkTYpzRPD07tW+Gv8rXqP30rBo0KLrt/ffqkguh8rdEjgdXgR2Dw9/CgEF76hJCGoLa0mjCUuYcbi6Hu3FduQbXI5+L44aKNzLq741EtFGE2M4vn7azxTL5GOhXrnu/KGytcEmRPyRVxARcxw4RKJmo442wiURc9w3aN3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I3IfMSV6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f0uJdsQ5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I3IfMSV6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f0uJdsQ5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE38B14000D3;
	Sun, 11 Jan 2026 13:24:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 11 Jan 2026 13:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768155856; x=1768242256; bh=CSrwnMJHHL
	CRZxmcZwjWohmYWDJFHh3o84BlqgX8qHQ=; b=I3IfMSV6Z2pCMlve6sK/NCsUot
	Ry5Sds0myqz8C0VgPL1B6DlUJ8G0PPjQh+iGfJ6mEmCY3RN1OA2AlUkZALgKeEO0
	dKoKgWQqu/yh8Q+v7A/rr3qZGjJGHmkAC/EGa1C3SlILZ6mbRSp3WFkRpTt7vjxb
	axrCFW8ES0/iln6ZW/c5d1ATAXxQ3YbjXCTIy1st84H0/hywCxQ71QMyNTu7S+Qq
	1Nq7Tb0oF4xX/0dTxGPARgsXdBTgbiAE4zRRSiyXF1GyR4h9WcZ4IbiRtvutk0n3
	YjWe+9P+My9md+cyD7GKKwLrYR4V0om/qK8bSMfbV9raS+PdiJTnL3J4hi6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768155856; x=1768242256; bh=CSrwnMJHHLCRZxmcZwjWohmYWDJFHh3o84B
	lqgX8qHQ=; b=f0uJdsQ5U9y12NBekOMVr9xBYjomVEx0Ea9/POQV+UQmsv3IrUQ
	zSj0nHsSZko6ZzJj9ZPa7/2txKHw8gTL/PckE7KVdIrg9kFQ1BvNsMVhgpHNjgE+
	RFGJ6dgprlWo6I9KCwjniE2niYKDXDL5dkIsuaqLxt90MYcbwcsasHzsozjPHT7y
	aUEtdL/VMT6bWiGg+TYqymFKmvM8Qw68cv3Vl+A6BFsyuludgmQc2aEXjtXUgLah
	5PGuqzKMR8AogMBRI+NkZNS1zyScEUnHu80tSdu226L6+hCog4DXSKkdtNS7M6AK
	IhkejWsOBbpCakLBWniGslarO7G1l6hiMZw==
X-ME-Sender: <xms:0OpjaWrPc6173DlbU1njwJ2igDBAb0RwdjrYDloiOZeGMaciY5Fnrw>
    <xme:0OpjaQf3kcXGNyHtgYWySuWAdpuf44yMbmH8Ut9FgX1MsuuGxLzNvK3htPlVAEhBG
    zIyy9KuCC4-svwtmXChUnSNqrDxlfGO4BpCz4liTKR2pcksYXSzixQ>
X-ME-Received: <xmr:0OpjaWmx29dx7Vb49d9J_EJavDq2j2kujQQXkRIMPN_NTuyUnnCZ-HNBWtMRYzwvBWLm5cZStUpCLxeuPJmntYgwP6ArHuzRknUghYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegrughrihgrnhdrrhgrthhi
    uhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegrrghrohhnsehstghhrhgr
    sgdrtghomhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0OpjafYcaReMienyXj1QW6UChnTFiXnQQ5WWRfzSkWDF1AzFbB6fTw>
    <xmx:0OpjaT7vGLWX6GmyUe_EkR0WPFlpNkeZLaH9iJxoesFFIWKd3i8TuQ>
    <xmx:0OpjaRBjtv4e8-166Ufyg7FiGItpWtkHDiLAAO5Q73TbYod21BoJrA>
    <xmx:0OpjaZ-bAU2QdebzA_0muQIJ0FXYmM9I5qpRUX0ZhNr0nF_AuZ_hYQ>
    <xmx:0OpjaTnNqtj6A7f2GWcKcBy--n-MUwWt4iFFOLhtq6pNpHf92aneAdyU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 13:24:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Adrian Ratiu
 <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Emily Shaffer
 <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Jeff King <peff@peff.net>,  Aaron Schrab
 <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,  Ben Knoble
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v8 00/11] Add submodulePathConfig extension and gitdir
 encoding
In-Reply-To: <bd2wmyi5pq5rd5l23nsk7d6lp3q4664omkq4pfjuwlcdkcajr3@v2c7vsfv2hxa>
	(Josh Steadmon's message of "Thu, 8 Jan 2026 14:30:47 -0800")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20260107230145.517562-1-adrian.ratiu@collabora.com>
	<aV9S_oUJjitkeWjo@pks.im>
	<bd2wmyi5pq5rd5l23nsk7d6lp3q4664omkq4pfjuwlcdkcajr3@v2c7vsfv2hxa>
Date: Sun, 11 Jan 2026 10:24:14 -0800
Message-ID: <xmqq7btoqa7l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> Thanks Adrian for your work on this!
>
> This looks good to me too (modulo Patrick's comments, which I agree
> with).

Thanks, all.

Josh, your confirmation that the polishment brought in with these
iterations would not break the internal users is very very much
appreciated.
