Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A201BE854
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669285; cv=none; b=ju/QSufU1aLUURAlqLwk4eNx0xrdl/pmPm4UGCUK448knDujlEujbkeQi6N2Gmbqrs1m1EDHXyI9HjldBHv4fEeQ3sRkWnyBu7CKB8so9V6UFncgwlaqOBJqApeYN6fwDPHSDA8zGdCtDi1GMHnBSjKY8ITmIQl2lRYaDBt8UxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669285; c=relaxed/simple;
	bh=Cp0VUCelH65tW16SWDtL7EYPulwfTlim/RSpoxPMLos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M9B2M+EZwRe70AfIfvuts9mIjQqOA7dPTKmCLHTWnmQ2/9wlbZW89xdnGMQ5ojzyvxRbeReuRiYmivsd8fbEpAPdCPuFF2jjU3adPivX3uNWhV76JZPbd33wkotMIvRG412tWox7euz1fup08xWdWPhSreF7EicHRQ+Mk0adPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fPRLHuu6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hS913rMm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fPRLHuu6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hS913rMm"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FE2A138036A;
	Fri, 11 Oct 2024 13:54:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 11 Oct 2024 13:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728669282; x=1728755682; bh=GKNOiEzPXl
	JCzntkB77Gcy47mfNw7OO2F93XpNaMd7o=; b=fPRLHuu6FqCfI+DDyXBJulLluq
	IL7FOZZz5yrQWEbYznBjgcFQ1NvsJHuyrUqZumEsLcc/uDlUARldYBhisEd3ezrz
	gcXh5jLcVX/B6ZUu0EZ1XG0OJlCFdyeiuUyXZyqyd4h9SXnkMV7D9L2CCCf1tHXz
	Y5gLEsVOsZJ/hNgrOrca7FVtYuUUCyHXKrAP2d0ihNWBBV8r5huTXZGcCWFBvxz+
	3hCXY9WWwIbS8byRSAio3xhmfu14SWY5UeDltifsEXa82oj8zqiJKtjJsb/eEzyT
	YlATrT9oMW7PwgBx162Ldif61uEV8ht8ONx7Uc+kA59c/4/+6bmm3W7/Jpiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728669282; x=1728755682; bh=GKNOiEzPXlJCzntkB77Gcy47mfNw
	7OO2F93XpNaMd7o=; b=hS913rMmCxBt+XHw/xUn0weISmIAQrKPs51gVJAuqnJ3
	XQcOXUCrsk+uHxPKm+ZosErTk7VFdTei9umPQdwt8tN6D4cerb6Qy7JiQpDuD6Pz
	oOku/+wNLz2C/OQlb0ONizoIy/RYCP+RdVzcHOFar2Fv5cdAxQawgvMIhk0gOpwy
	XQxuHI5lY9a/spMltxtfGpTs73dmoFXZgIx+gVP9Vn1IWbKxhB1KcA3WsMAVPA20
	K3dfJuK3H9qaw0p5gXT/8MMi+fHpfdt0i1hIEf7PCO6zq0wjmG//25QT3UqbnEmB
	qNx1V/Iph0eT8qunRbUwaizLnKZwa4jEqY90eZCDLA==
X-ME-Sender: <xms:YWYJZ41i0sqAsyZ7lIWKV_YOEWx59Yyu4RjuFwTPcpIrNMJuuc-XQw>
    <xme:YWYJZzHAEMgI7vDp6AeT7nCViYBK5LZln5zTB5avt4IeshmD41nrJ-cxTA1LtDURL
    KmI_6FlhmRm_CcQrg>
X-ME-Received: <xmr:YWYJZw4zWt5CQnMovRnwA-yHjZIvwzlOG_NtEdPsI6aFrrGwW99U1bRHxdS_WTMCAQJoka2oO2ooQDxqEfc8FK2nfrYse314Pr5py1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrghsrghmuhhffh
    hinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehhrghnhigrnhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgt
    phhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehsohhktggvvhhitgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YWYJZx29ETA2elEtZJJUw-BTPRbWrJjN1yg36vmr4ELYq3ZJ_BivPQ>
    <xmx:YWYJZ7FXdSA973Ykq-nRI4jbeGDXpeoO47RMWGpaRo0Qxy_TpIroiA>
    <xmx:YWYJZ6_40RQ4exnv84n9vmrKoNUNvs3GC0-ZNepMdPar7qNsa00yOw>
    <xmx:YWYJZwmuxfhxwZYI64uDajp5Th6osjDnNuA3McfA9mG5A2zZmk7l3A>
    <xmx:YmYJZ624XlZuX_9UoPhYP7MIITCsOSf8BaCIGgqrjCeMajU-Woo8aJtP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 13:54:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Han Young
 <hanyang.tony@bytedance.com>,  Jonathan Tan <jonathantanmy@google.com>,
  sokcevic@google.com
Subject: Re: [RFC PATCH] promisor-remote: always JIT fetch with --refetch
In-Reply-To: <CAJoAoZ=todZ6Ej9CQcF+f-C6vBZ8x-H6VX0dKhJwfvmJyGOW7w@mail.gmail.com>
	(Emily Shaffer's message of "Fri, 11 Oct 2024 09:40:04 -0700")
References: <20241003223546.1935471-1-emilyshaffer@google.com>
	<xmqqset8c0o7.fsf@gitster.g>
	<CAJoAoZ=todZ6Ej9CQcF+f-C6vBZ8x-H6VX0dKhJwfvmJyGOW7w@mail.gmail.com>
Date: Fri, 11 Oct 2024 10:54:40 -0700
Message-ID: <xmqqttdied9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emily Shaffer <nasamuffin@google.com> writes:

> By "lazy fetch", are you referring to the partial clone fetch, or are

Anything we do to compensate for the fact that that initial clone or
fetch can be told to deliberately omit objects, in the hope that we
can grab missing objects on demand.

> Yeah, this is on me for not reading the entire documentation, just
> noticing in code that it disabled this COMPLETE cache thingie. You're
> right that it would be too expensive to use this way. As I said at the
> top, I'll try to send one of the other alternative approaches today.

I thought you were already on your vacation ;-).  I'll go offline
end of this week and won't be back until the end of the month.

