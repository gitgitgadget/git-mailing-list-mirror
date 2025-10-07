Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD962E7BDC
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854126; cv=none; b=R7if6o2v5hG4nuyiypUna76XV2GNnIutqOTZ0vNzq4XAZRz0TACW5tQaO8Do8oEEuptlw81GC8GOiCRlpcFUUJNfIda5pQjEz0DacScKIX2fYNJ1YUDI5Dy+GG2RUjINxn2ctnIqdF8rZy1oSU9BE/4OhsAT5B3Rtpj/A/TlxLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854126; c=relaxed/simple;
	bh=bSQ8euAs31hTg+uzUyZsXzMohtMZJEOBCq1E51uaktU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i+5QxWoXzXCpkRoGNORJxjBO6/xfP/N5mE/EWFsW4AzMUotAvkyC8/J+fpOl5OalCNJ/HwGj4phailBD0Za0y4y20tT+m6PQZgAhmvtI/mroRFJZWsAGEXazHL/4Qz/XYzWz1SRkwb7SeqrfTAtT0DAWz4OEbkiRueeH+ISBp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ERkiKbAT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BYKAqF6I; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ERkiKbAT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BYKAqF6I"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 346521D0019F;
	Tue,  7 Oct 2025 12:21:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 07 Oct 2025 12:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759854119; x=1759940519; bh=S4P/HDeJH8
	hf7vl/lazao1KBSuDN7BmOaUsp5Jt20TA=; b=ERkiKbATHjcQvZ1KHmPy407DsS
	qnbJYkZSrra87v84BGdbIZelmnDNj8eRTmTWJID7I/dHDCzpHE8XMJoRu/jJC5hN
	DxM+Dx30myER2efvJTd+tEcBG8MuRb32c7WEz7FwW4kOxYppUnnpJEFJexDdpjVl
	dXslcMTHzog9dbrvpdmxMDLoVUOFHuinttnoWl/VCq+1cAU1VrrNNISY5trhZWjC
	/XzD4TsgYJ0IfM5DDJJIZxnP5V8qyGhq1/qXTNIn8TWqwiz9dN309in9jIvVCxob
	Xp5hO3wvkcCitb7FAZ/Rer45bVsOfugeP7k8TKZ5KBMiPcA2H5pexqv6wgrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759854119; x=1759940519; bh=S4P/HDeJH8hf7vl/lazao1KBSuDN7BmOaUs
	p5Jt20TA=; b=BYKAqF6Ioo5sdUH3b3KPiqQxvmsR02QUdTiZ0+JZJl9k3RjgBGd
	HLgi6koFWTf+BM1Nc3s58Pe/q0HTEnwcXcYrxI1aB075qPvBF3cywj4Qac3eGfWC
	dnsd+WVAYpM5NkOXEKtEVYluOvHsulmWSqno/Bu9aAecQI4Ay9pvXRwviX+EWrrU
	OklRHUfXKv0dZXdBbGyWZI/lDMfmWase3sb2spPCO/y/R+q/sjQlYUaBAgWRwZF7
	Fg5soeDV96s3WmPK0+tDQECh3z4nbx8WWdqxTK/o9BQaMRZTBo6BbE2E15iOREeb
	LE+mBE0feJdNZdiWdg6XsHu5Tec4z6Z15WQ==
X-ME-Sender: <xms:Jj7laFCRPKOtJ42DCEOSVwjrE9SucuBY5yMpM8ftjLQGiBfIY0XnsA>
    <xme:Jj7laPUpSf7dq4ey99UtN2aiiOYJVqGyaB571DRK3WSb3jF1uYlAu6S1xubyNhHx9
    Exsc5U8ieKRerN_j3zUatBJr-DnhhlgLbQ0PY5f3CRrwPio1l4j>
X-ME-Received: <xmr:Jj7laL80Bu0B4u_TNG-HvwGN7ina5YqCeF9ZixJZghCmDHz6l4KnhB2ZORZpfIrtDAMON3ZSYCTteRsPC8fBvM6jnLSxhmEygDgH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtkeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Jj7laJRMyvOq5HFa-CPjjn7SwUTJbBwVzPnlnIDDFlQTe9C8BD5vCw>
    <xmx:Jj7laIQp6sRHfXF4o8Vp0708jsaUEHF9ro6SofnCdoRMpaJWb_6AnQ>
    <xmx:Jj7laN4WryEC79j1WKVkHReGh82GmtpBdFbfhCX9mu3ylI8x7Idy4g>
    <xmx:Jj7laFU-WQgP-intj44p9ysrcGEoAhCIGZxqWwN4o88DOyGb1u6_Ag>
    <xmx:Jz7laM9fBBI64K4ELe2iWTXIagBsNjdXMnFD5YuhrkRj8fCb0KYLXhVl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 12:21:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/5] Encode submodule gitdir names to avoid conflicts
In-Reply-To: <87frbv3qyr.fsf@collabora.com> (Adrian Ratiu's message of "Tue,
	07 Oct 2025 14:13:00 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<xmqqo6qkq9vm.fsf@gitster.g> <87frbv3qyr.fsf@collabora.com>
Date: Tue, 07 Oct 2025 09:21:56 -0700
Message-ID: <xmqqldlmlm1n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

>> If you already have submodules creted under the original scheme, 
>> then add a new submodule that needs this extension, do you 
>> enable this new extension and write the new submodule under 
>> encoded name, and move the existing submodules under their 
>> encoded names? 
> ...
> We could do a migration of existing gitdirs to the new encoding to 
> ensure consistency when the extension is enabled.
>
> This will simplify our logic and assumptions a lot, at the cost of 
> the initial up-front migration.
>
> Will do this in v4 if nobody has any objections.

Let's not.

You have support for submodule.<name>.gitdirpath already, so it is
far safer to use that mechanism to etch-in-stone-fix the existing
submodules and their gitdirs without touching the directories for
migration.

One case you might want to really move directories when migrating is
when two existing submodules' gitdirs are already overlapping, e.g.,
.git/modules/A and .git/modules/A/B are used for submodule A and
submodule A/B.  Depending on what "B" is, a project with such a
layout may not be able to upgrade to versions of Git that newly
starts using .git/B directory for a new feature.  Introduction of
a new directory or a new file directly underneath $GIT_DIR is rare
but does happen (.git/reftable/ is a relatively recent addition, for
example).

Thanks.
