Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714E81DF258
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133619; cv=none; b=htF/NRnM27i6vDauSDrcOBZknk1AeEybFGqPQghIN4Xu2gQuNYJKhmtyc3W0Z6klevSbt1Kfs3CzP9/EyQOhYwgCOAfLSgjgH7xe+zSg24nkFr+NyP7RKgrhWKSANZbl+6fT7wUq9gOuP6pEzYbLIfhTKGcny4uDGFsQyFDArTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133619; c=relaxed/simple;
	bh=VTNRFHWmUdbhdlQfJbbMU1k+wxc/Z8a6Hwtz02PuERA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pKXSuUAF5n+nBMxO/ixScUOCGBXQ+mMvdoX64fajraXNnDWm9zR2eQqYrbrVle50rIX7azjoYXHywUroZBkv0MTslq0XpALUt8yFdhCFsPMGi2o//sS0C5ooilBJTftyFMUUMpvuNFoeVUCjszvBBvlOK6xBdAlgYD8IIG5/JnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FG4Y1iZM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rySbcFVo; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FG4Y1iZM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rySbcFVo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 956ED1D001F0;
	Thu, 26 Feb 2026 14:20:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 26 Feb 2026 14:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772133617; x=1772220017; bh=VTNRFHWmUd
	bhdlQfJbbMU1k+wxc/Z8a6Hwtz02PuERA=; b=FG4Y1iZMUA9HZQTcpPxwGJx02M
	zgfSt1qwFfFihqzvJBFyQjgBPKNUiLLK/gdahs+mUmNfF07gPcZ+wTim3Yygmepd
	OZ13eIDatrMez+cv4+3E2+EJnDUoi0GZsVq+kr9v7Pgb5FUB5KCHbGi0Pj5AC2Tm
	tlwuy/BC19UqAHWENXv3+lmkj/8XpklsBBvihih8JtLVYUCRrTQfpcGr7yx/zlwV
	WO0PwnVVdc9Rmjy8ekely3yZMdAR+22pFImmxb4COkZ/i7jWFd3uzkDRCDDuNowK
	T/NchLUng6z6EPF4p96ft2ck4TujQPX7wpdVlgFSus0ysAoyTfDzSsaAi+Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772133617; x=1772220017; bh=VTNRFHWmUdbhdlQfJbbMU1k+wxc/Z8a6Hwt
	z02PuERA=; b=rySbcFVoDRp2YudBjtk+43upxsa1AApwXeIzayqwL+5Lgczb84T
	axZCJ8cLNC/opQPf41spo+cKfs8uXDHTcNMTgmWSMWBmu/EHP/RtOR2p0RI4aYHn
	m8f6QUYm/izy57Fifhk5RlC9nLripprQmsIlcidd2UJlLpAXloeg0gmdPolWQwgg
	3BeG1sa1X7aqO/VeY3sBUI80rffWfw6ui75r5DtZ625eCQR5QzmMSqmOdFxQAIYH
	8xKHgmTSPbvQblOfafXs/UliW2wxRyd2FiS4egg9MXzEHLZAzRKiS1kFEswL9To2
	jP2lYg/5MVrKU5FVuQCCQ0jAPjygjrSsn5A==
X-ME-Sender: <xms:8ZygaSJVNG-1eyVPnGfXpbiSFwHxTx_eqbTI63F1_Sjm_iFFuE8aWA>
    <xme:8ZygaRnD7gZKewwuwnRnsc45hAzm8RTYi__ht2nrJULlWb8KQ7ptP_wgjls-WElIn
    jR4qvDQq09UCxVKEqt16u_Ng1PB8X2wjGHim-0A5yyx2zTz0ncA>
X-ME-Received: <xmr:8ZygaQGQezR7nI-xPDE1ahcFpwVJe7twlJzbLBwfM-_cdrhMgQUHFkHC8TY0nRiKZNagbAeWDxXCbk5VKICJe3L0zmhrKSWrZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeikeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8ZygaRG6s-PjxiE9BbT1MYv6SZ8jo8Gmf6jSZLoA6ddpusAKkQuYbg>
    <xmx:8ZygadP6vhzejZHA4mVgzpCtfh2KT0wUSiTASeWbeJrlR-iPMg0x1g>
    <xmx:8ZygaQHfvxGldb2ab-kdifxVRZs0MNJbMYplH21pwBalhqgBvjuz8w>
    <xmx:8ZygaUPjy9H4a9o5s061JpuSIwEWfn0xTmwnRGR3t5FF8_Pc1VhlUw>
    <xmx:8ZygaZnmTAmd1kugR6TeVu6rTlqJnLiAaH3BZzZOB6ivWI3qTHlJIgrw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 14:20:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] builtin/repo: update stats for each object
In-Reply-To: <aZYUwjSEAcGRSXNa@denethor> (Justin Tobler's message of "Wed, 18
	Feb 2026 13:40:21 -0600")
References: <20260203221758.1164434-1-jltobler@gmail.com>
	<20260203221758.1164434-2-jltobler@gmail.com>
	<xmqqzf5pqwtm.fsf@gitster.g> <aZYUwjSEAcGRSXNa@denethor>
Date: Thu, 26 Feb 2026 11:20:15 -0800
Message-ID: <xmqqzf4v1fdc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Good suggestion. Some of the info added in the following commits is
> object specific and will need to be handled accordinly, but we could
> probably still benefit by structuring the data a bit better. Will
> explore in the next version.

I am looking at v2 patches, but did this happen?
