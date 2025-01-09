Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDF9202F9D
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736452817; cv=none; b=h8usQ3OIHM+dep3LL+7aKh8OgVAGgLVNG/QAp5QdO3mfliFx7N2Qhoola9G+LfjXn3rZzeotUbvzz5UCLr3XgtEg5NKIgL7oz5n8R6iP9DvOaERgn2hch0iphe2l3ZmTubuSR+a8c0a0EE7Oxz1cPpuuzX+3whyfGmHRddB8ERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736452817; c=relaxed/simple;
	bh=IgvbJa3Y59ucs9wGHcT19r2wky4OR/Hm9n3MR2lgudE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bgpTkipEVbD2ofiKyBBJo9wCPUxfvdB6crzkUK+yGBzHkWGUn89S+JsAk2dlBIiszHbr18JHz1opoFx4HU0EmdLMc6q+U05vjObZTSLiQYccx6ccHB96hidz4mVM4eVJHZlq4hrZY/BeXbC+WMztSQAzuqH+egxLDP2ZDKTdvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KGDKN53D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iPkAPzS8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KGDKN53D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iPkAPzS8"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 602252540170;
	Thu,  9 Jan 2025 15:00:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 09 Jan 2025 15:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736452813;
	 x=1736539213; bh=s89ZADaHewyHuRTrbswJAUspBadqig7TPzwPMvxSe+U=; b=
	KGDKN53DA4JGU++UQTIYyURDNPaOSX7iq0+qvb1KHRIS2hHyHNG4HWu5rTQT/Dqo
	6k7aGRI0mySa073HT+qFcZo6BIVT1tizwC7TpNBVfyyQ0+Y3s3CLUK0UX7Gq+lpg
	eAYI2N1HsGBOg45M6Y6UPYGwKrB7VxffKJqrdK28d8i3eju6eAz98RJrf/lpluRI
	4HyF99PtDFdBioFRXrc8E3hxn/6Qq/Fj2qStl+bdqvUgYJDcKW/2Okj+lOUuNnyU
	5zRunz4s5MjlMoMH+4Fz8DLBLMH0siQTzDHHQM8llXVeJtaDvsLsZ/adQspQ40ip
	jkX9/FJWWzzSmkZ5sCWHdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736452813; x=
	1736539213; bh=s89ZADaHewyHuRTrbswJAUspBadqig7TPzwPMvxSe+U=; b=i
	PkAPzS8iYSTVQDETJRMN5rcyI8dyLC8TVvDvm3KoWbJS1jH5fuW3oKLPd+L+x1bG
	zjo4cdTlTTfRe7bJXcuVBWs4/TP1f6cTMLIQwfeW4iHlf50z2UsMwe5yINXlbdue
	JixQtfT0E6Vulw5BT5pYAq0oeubx4wUPDLAh3C/X0IfYglOnyJ4SU7L3TMWvw3FA
	Wmf10ipdVIwUPkgHUnjAW0Pp4a3f04o1Ls2Q/YTFBYY6wf9afUgkXJi60N3oEYVr
	Qww67brNgAffwP2tK8GFuQ01uF1ofBroMHyhrZlSDSQI0iQYhl75LelHn79T9sXJ
	MwgFxll+bmKh6T44cPlWw==
X-ME-Sender: <xms:zCqAZzlYD5oZLg5jFVYlfpTPr4phTDsDaCkkB8XGOn3MnlvrWsxcTQ>
    <xme:zCqAZ23iTWxsQvRkzrQtnADvFUtrFOLNIAOmCSunAJdqWl8W9HnrnSBdak_cQr9Qj
    EfRnZg46vgKcAeBHw>
X-ME-Received: <xmr:zCqAZ5quc1BvQDs3iYtaRLpK_IMW1oi31J7Maspxd6Rb5Hm9fiFlVVmMApWy8yIaJdomS6cnyxZpzLgJTX3JeAz39B4KJLrwo_YX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhephfetvdejheduheegleehfeeivedtgeel
    fedvffdtvedtudffieekieeijedvlefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehmrghrthhinhdrrghgrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrd
    guvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zCqAZ7kf-_YqjpPUoC4-ZqzlfEhX-UWfmR39hohMVlI4XZTHYWKkdQ>
    <xmx:zCqAZx18PLDm-XPFtyBIz_58m8AKbPzXyqKS8yPOvF0brzgTvQo_4w>
    <xmx:zCqAZ6uC5XLJA_HWpbXDvKxMBkciyObnwEQzJwcbk8BkAlaHSB_tuA>
    <xmx:zCqAZ1XWX1FAhIiLxtcwwwulX9SKxCiFSJLPWCHTntiFuOqEQGd_YA>
    <xmx:zSqAZ7o910GQ2g8cn2Yf2MFGbrp6R8_RcWvFHUMIKzc5mXJn87HMJoSE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 15:00:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] GIT-VERSION-GEN: allow it to be run in parallel
In-Reply-To: <CAN0heSo2pFmfx=zJgx2T6y+W1tG_PTXxf6uk2kBgi4c0kXz_oQ@mail.gmail.com>
	("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 9 Jan 2025 19:33:42
 +0100")
References: <pull.1850.git.1736432663587.gitgitgadget@gmail.com>
	<CAN0heSo2pFmfx=zJgx2T6y+W1tG_PTXxf6uk2kBgi4c0kXz_oQ@mail.gmail.com>
Date: Thu, 09 Jan 2025 12:00:11 -0800
Message-ID: <xmqq7c73iwqc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Martin Ågren <martin.agren@gmail.com> writes:

>> ... attempts to remedy this in git/git were unsuccessful, see e.g.
>> https://lore.kernel.org/git/pull.216.git.gitgitgadget@gmail.com/
> ...
> You could use "$OUTPUT"."$$"+ to restore this. That of course
> invalidates your remark about "Incidentally, ..." above, but might give
> this fix a tiny bit less chance of regressing something somewhere?

Thanks for being careful.

My reading of that old thread cited there tells me that the reason
that previous one failed was mostly because it wasn't being self
consistent and only touched the use of "+" in the Documentation
directory but not what the top-level Makefile did, and also because
it did not adjust .gitignore patterns, so it is good that somebody
actually read the cited thread and made sure this time we do better.

Again, I was not opposed to moving from "+" to something else that
is equally short-and-sweet, and I still am not ("~" is a fine suffix
for this kind of thing, for example).  But if we are aiming for a
short-term fix, I think your ".$$+" may make the most sense.

Thanks.

