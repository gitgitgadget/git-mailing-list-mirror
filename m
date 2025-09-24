Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724B30BB94
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733874; cv=none; b=kunfEJfBUHI88CeJ4BipyZnCTNACDGF58ODuY+zS3CHNzNA5uE99RQ2arBqxmjmezcwV8LqPqXZH2rB5T2xd2nw4+I+k3Dyv5v0Dl+mW9Z/yli4SJJaJ1WmNZW1n5dKeCXEWxGt1N8ABAaOXa0IT6aBV05iB7Eonp7En6zVgVHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733874; c=relaxed/simple;
	bh=2WmHJiTGUWbZ//v345z9n1vfS5ZettvzBbTbegofLTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uvh6lCqDb7v2IghHuOSFH3KxkMveaB0XEgkhU9w01HP7N1PsTcrMdOnPXVMe9aN+gfTnFOWYilJOub268yUOgsESc2UnOLocLVQXpvpODcWbtLOvKaKFuk+vuREIFRWW3Pq6NSOBI0mu5oFCVQl06NMt8NdJho9SRNSf0iXGWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rS4D5LGE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GDD55HCt; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rS4D5LGE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GDD55HCt"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3B801400050;
	Wed, 24 Sep 2025 13:11:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 24 Sep 2025 13:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758733870;
	 x=1758820270; bh=pB5khzNai9C9nirA+NUhVLvtxFL7JW01h5LpnTGZhp0=; b=
	rS4D5LGEsYoiAKFUZZ6gFv5cduKG9Tc/TnY8YgjtyVMXSyk/DUftcnsJzzgyJzUR
	rwqNgjjo/JVA7M5UUJ1v/NyBGKhLIdJ8sDrTaYUjgs8SF2quHSXi7KKeO0YAQTZo
	bx9KrWvL/6x3rl6b8kJ2N3WAd/Y7Lrp3t9VuJFccZGpspsL4t4B2Yl+7AC4Rw2L0
	M5XIDVK8e2XgJR7UgEQESTDOa+fs9Ne82fJa1fUNDcujysQg43dAFVqhzdoDOq2H
	+TY9RpZw4vEcK84DWn/5ejK3ggdnqOCPviv8Wqa6/s6wURCItBHCaj71ijuR26Ff
	hlJJDYO8hBV1/rrxNs1uKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758733870; x=
	1758820270; bh=pB5khzNai9C9nirA+NUhVLvtxFL7JW01h5LpnTGZhp0=; b=G
	DD55HCt3ZfIo4bqRQaVA9LoNqkgnTxiUn6Sm/doupR8eHSMRK3R7EGVrxLKKB82V
	ki+zsgd3ggJqeWzA2JKWgvTUHtZ30F9lhVx279vdQRq31RdMyfEMZMUZlLRQqzpV
	ZYVNkPu3JnRidU2l7Omuay5725Y9+3vW33FBevXxldhmqUd8Lbiox4OAJbzT9gzG
	UupJqoJq2DxhUnNXUtF12Yl8Rau/+6g3+b7x+bljMFhxprbpgs4CdEbGGf4bTSEb
	2I1YUvTR75qGodd94slRzQAvqGGP1+BqstLroMN6jsuHu8MWelOl92VgV8HEihUD
	1C3qeBRqgSgaMHodCLCeA==
X-ME-Sender: <xms:LibUaEnp7xEd1y1ykgUx3ZzP9cU6w1LrvmX5pyQ4MhMzhDyIrPAwwA>
    <xme:LibUaHgre4Pu7Tf4UwMlmTNWauCOpiQXjXp-eHtuzQOnyPOb8neU603QzTPl1it36
    Z5U7irtHhQqFbgdGk1fAej-KIl0LOYet0lo7EdQvKf018Si38bx7A>
X-ME-Received: <xmr:LibUaMes4g9tD5IAISJ6t4snmvvZwEmXmWVe_6kLEAiCfxmGzwQg9adSVVBbwQw2TQZEOHIpl3Ay9gA0pt4KOlV8Y_Ssm9x8TOMl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepleehtdevjeejtddtjeeugeejieeuleekieetvdfggfdugffftdeflefhhfdu
    uefhnecuffhomhgrihhnpeigkhgtugdrtghomhdpfihithhhghhoohhglhgvrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvggvthhsohhniheftddujeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LibUaHjKHyhrW6ijq36ly84SqSemHoLSBpSYU2JCPegHSrUaanfMFQ>
    <xmx:LibUaEzUhsJwgAdQowIXzeh0LjYyxdW2nkGe01EgDCgdlVoKiOFU1Q>
    <xmx:LibUaDPLZCPeeEyjQt3cgVnvJ1Zzdu7RMFsW40n9N_s4zNj976Rgdg>
    <xmx:LibUaFXNhjvwrRsLApZ71HIRYqPhIIlIFB_VT1RbejLRdM9XmXsxOQ>
    <xmx:LibUaHJPvLhNCElov3nYM7v-Kd-eMXrZRBaeG0LX1rBi7pEsUp4WQc6a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 13:11:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Meet Soni <meetsoni3017@gmail.com>,
  git@vger.kernel.org,  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH] builtin/refs: add 'get' subcommand
In-Reply-To: <4FEB2B85-FC32-4076-9DA6-F47AAB096CB0@gmail.com> (Ben Knoble's
	message of "Wed, 24 Sep 2025 11:29:11 -0400")
References: <aNOQhncjwYCwCaZ3@pks.im>
	<4FEB2B85-FC32-4076-9DA6-F47AAB096CB0@gmail.com>
Date: Wed, 24 Sep 2025 10:11:08 -0700
Message-ID: <xmqq7bxnn5cj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>>> Perhaps "show-ref --verify --no-deref" or something that does not
>>> dereference but works directly on a symbolic ref?
>> 
>> For now: yes, it's more difficult to discover for sure. But users will
>> adjust over time as they get more familiar with git-refs(1), and from
>> thereon I think it will become significantly easier to discover that
>> subcommand.

But unfortunately, that is a tautology, isn't it?  With the same
effort to advertise git-refs to make it more familiar to the
"users", you can make "show-ref" familiar to the same "users", and
problem solved, without a need to do anything to "git-refs"?

> I think this goes to perhaps some of my unasked questions: who is
> the target audience? My experience suggest that most
> mostly-porcelain users don’t acquire familiarity with scripting
> commands, so it sounds like we’re talking about script-writers
> here (and in the commit message).
>
> But how do we encourage script writers to discover these things? 🤔 Hm. 

Great question.  I understand what the patch author is trying to
achieve (i.e. "consolidate ref-related functionality into git-refs",
which is the title of GSoC project [*]), but what are we, as Git
project, trying to achive by "consolidating"?  I often cannot shake
the feeling that it may a make-work job without a clear answer to
that question.  Or perhps xkcd.com/927/?

Perhaps the hope is to have a single kitchen sink "git refs" command
that does anything related to "refs", so that they only need to
learn this single command (and unlearn all the previous experiences
they gained) and after that, they do not have to "discover" more
things?




[Reference]

* https://summerofcode.withgoogle.com/programs/2025/projects/xVrT5e2q
