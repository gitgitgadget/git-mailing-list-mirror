Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0421B19D
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757304878; cv=none; b=t81JKMp5CINJ7Cg6DuAaLam8XmleYln0ZBWkGVdtNPo1rax23/y7hZ5S7lS6XHb+xThlXYYzKk0hrNCalvDcVWChyFFdV8fcu97m7FSw33hGmxA+L79w7mAype8y6LL6EnSrtpxq2e7w29PRXmqYupn++y7uys/i08XZnRNHaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757304878; c=relaxed/simple;
	bh=JpbsRCDjbcT6gY6UhzlBpRuiZRl5LIF9poxUJPZvLtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fIays3iFjq8JyQ1sneSaeQRlnE//Xm8zNpe698KBO9Pe7GkomtbOVMwGJIIyCC/gdevzWgqgcua89kKYJqJWvtr0fUWS6ZvCmunJLSrDDla8p4/Xyx7CzGqU8ptsqs+SPoi4so6TB/5WqUfmDcbq9rKIpBkbvRpYRkPo2nH6PKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HIa+JBUL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dmio8un0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HIa+JBUL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dmio8un0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D0DFC14000CE;
	Mon,  8 Sep 2025 00:14:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 00:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757304874; x=1757391274; bh=sVPhmqjIBD
	Gudk073tC3Ss88kGVBjbSvSo00JHIBpbc=; b=HIa+JBUL1BClbVvI6rzs4iGvv2
	Jiyy9+SyIfmLs5+yyzjwbPUJlZUtaJIBH123oblarHceYaSuSIrBT8i6U90B+TBY
	3X2AZKcBkraIhvx3L+yNo9F3aWwoX/h3NvlrhYZ9igzFkCualQ1fce/J/BTEoL21
	w8aeI55Uists9gApcp1k8ICdde5tc92qg5C7Pqgp4GO9yc0jmXgph30G1bYeP7ZE
	VKE82NjWF2NqEK/8quYUANvMF+rpsjIj6cBjp8lzX5OGOu+I8z/YxceFuz++vusj
	yQVP+9Wexwwbh/R5x83UI92kVWkj2MA5CNomDaQHXfn7CiZaIzFDiFGsJywA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757304874; x=1757391274; bh=sVPhmqjIBDGudk073tC3Ss88kGVBjbSvSo0
	0JHIBpbc=; b=Dmio8un0MlFXqszWbzqVTOinUZKnxwHgvj3N/trJaueDKocXlcK
	2tbYecEcMF2683I+VMMm94ELrD8+bY0VKClPMbwbuPKfWiM/2ezMVPxYDvfiwwN0
	6ZDvij5ZDZjNLHSWPn3qHSuMtJJhvTH/7XW4SPv3i/dspvUpxLiRivtc2KI3btMt
	eaHIO6qi3+SQ/sh7NCdZV+6DAgot7WKeo3Tc0OD9OLrO/UDSOgj3zVhqEMEI97dd
	cgQMRd+Ko+0/iYNUtrL4Yf9iRzWAPofINn2e1aqx4mnqMP/XkQH0eGkCHxGV1uvO
	o499b1/fvblTsUm6Mte3jEHcdC8aTx2twOQ==
X-ME-Sender: <xms:Kli-aGNNeYAxjeufdjQ9kvNMsZ87AiOgv-6x7YcehMLP6WQ1jgL3HQ>
    <xme:Kli-aPjyWk4le12MbiJVOrhSxs7vyXh_iVkxCdAFE0KIe2fcW06fRrbHTrySklR77
    TEHYsSGXqzh0hqL6g>
X-ME-Received: <xmr:Kli-aJ1RxPi4F_3atu4ynDbK-s7wt3UdJ-p59TqsXUgHPhhiA-WgdVXFlimWocpQA9a8qKuyYtFgoRnmcFpK1HmjBjipCt0uPQOcm_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehmihhlrghhuhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Kli-aJgD51zJyMgSuptP7V8Kr-af3m1K5i759bf2ULSSLF8k7VojRQ>
    <xmx:Kli-aJdlTYpN0KlBYOxrPwwNZvr2kUzftPjkMGqoThbVFZnHerfO4g>
    <xmx:Kli-aMn-WI07Yg_pcJBOvqLIraQeDMCFuzLAvmwr3VHjngPnaEkGPw>
    <xmx:Kli-aCv4RW7G8cdCWGbRxZ7hDwcEKEiaHeYO6g6RkL0XvyhofpDNtA>
    <xmx:Kli-aB84Fm4tYBAqrd5vO-EI6j7FAa7cCzSJW6XWsGIzD4rycODqzpK3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 00:14:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Milan Hauth <milahu@gmail.com>,  git@vger.kernel.org
Subject: Re: Git dumb HTTP protocol should work without update-server-info
In-Reply-To: <20250908000543.GB1281511@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 7 Sep 2025 20:05:43 -0400")
References: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>
	<20250908000543.GB1281511@coredump.intra.peff.net>
Date: Sun, 07 Sep 2025 21:14:32 -0700
Message-ID: <xmqqo6rlzil3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Possibly dumb-http could learn to do the same scraping that httpdirfs
> does to get the refs and pack listings (though this might be quite slow
> for unpacked refs, if the ref tree is deep).

Please don't.  Once you go that route, that is no longer "dumb http"
at all.

