Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9931EDA2F
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749762092; cv=none; b=ByKTzARdw4xAvDkz85D0Rks0C0Jup7y79PQKXvVRwQc1XRtWEXQqrPKkxFB9Oe0S898WipCcOU8bc/O3cssZBn9X9UnecXA0MUEOmwYPM2Fv+Wovj0yUOFiUerCSuV002w4s/yhGfXHfioJ5BeCJqpUxGQseUga0ynBEqbSW9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749762092; c=relaxed/simple;
	bh=ZHuEoPImn/PkfNFn2k1AIGCT79B2c7xeYwpOqcugq9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f+QKHc3uH4jT8eZ/Gwg2fhwBSNR1E3pnJ0ondiinuVXOnjwYoFG6QMgzzZZyk7cF66GU+e6j3+k1P2Sfr/9wuZqK34V66xTgo4F2CFhak/W7eXFr9OPraHBkufNoAbU4SnIHgxO+oTbuYYSC7dGUxmjauaWtVGaKGr3rWLkhO9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QWfL4A7s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LgRkhgDb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QWfL4A7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LgRkhgDb"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 20594254024D;
	Thu, 12 Jun 2025 17:01:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 12 Jun 2025 17:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749762088; x=1749848488; bh=X5uxVWIyaF
	IzM3fKd8ObPCZ2DUUqTFMEUo6N9xjHG1Y=; b=QWfL4A7s0mesPWE2Lkcokukk9E
	PGzz9KW/rz2RQFPT9H+GCTdbywREX5WTY+wUGr3F6MxqoiuOA149bwpan41GRBJG
	iUxprhDDV8rCuFYDNAKk2BUEGRX5xOOYtkGrhNcD0Bl/3bAF+o8Xqoru/fH5/Ji9
	0iG0YxbkIXBY+cqwR3GybmF64XnvAyOdiQXRONM4IkoXA6j+MrFtg676zOiTlZjU
	WcM0O8iUYdTvKBRGuhoyRQxZz8YAsQabWV8AtHcGVGEP74qzJf3GSFX3DIMRykfT
	45qBBjYj6R42LPJV7qPeQs+sMSFPyb00RjKpVmlrpnIrVUNZm71lMqE3krQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749762088; x=1749848488; bh=X5uxVWIyaFIzM3fKd8ObPCZ2DUUqTFMEUo6
	N9xjHG1Y=; b=LgRkhgDb6iO2hDIwY/RsXp7H5vk/OdK1P/QA2Ihm/mb2vXOoekR
	mPHUBqfBGdHSPMOkopuZyI3JKhBLhkw6uHV9iXZ7AUHeY0qILKMh7mgLA0nMuRoX
	r3/AW5ek/2dStPmLTa/mJBOGrfI2oMb32oZf/rHKUhlgMLfjUmnl7ozE9oe7eJMc
	jKUVFYZCkYccKQDWi0ra1siCYU2Lfhy8Zzl+dcnKfwjzBizoFvnyiQI5r8RKNBNY
	Jx++CsiOzGhXl4uaZWV5qxXT4B8voAslsrQbp6Plbub7EK/HMKDrvbGJh2zdcRiz
	Wyx9rJClIFKedgHdcQvQzQ3e5flkrczH2fQ==
X-ME-Sender: <xms:KEBLaFfvls1p3W06g_8TvCHaYRKoYIrdbg0lmRhwtSX9olMF-rYIMw>
    <xme:KEBLaDMudoLLeIDWHiOTNYPluX7JcDJ0Dl4Y2qrrx5E7Yz7Wqr0XgKztsFOLe1Sqz
    mhz_D1f8ap6myhI1g>
X-ME-Received: <xmr:KEBLaOjVN4Ixupd4MsP8-egU0ohzgsbJB2mygWyzQ_vIvUV6MKOfjWL2YZaVxrMaYTRP0OX5wPZ38AqdfUUmdi5PlQkZKQfSM4O5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduiedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhgtrghsshgvih
    hkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KEBLaO_vt0JOWX1cuL-sA3cfQagzxDtWedxvhCxPGTgxaF58FWHx8w>
    <xmx:KEBLaBuneVhic4luGpdmsLe2dWmgCs1dBXGziJxr1PwkGWJweoS_JQ>
    <xmx:KEBLaNEEue_87qeCITwpCMxc33L122S4OHg_25hHAiuPEC_59Ukv2A>
    <xmx:KEBLaINkZG3SyCytwI3CWN9VZ9s4UvwMjB2mcsdZSSROHGTvt7g3zw>
    <xmx:KEBLaHf90CzBs8jMVSIVN1uuMK8jV34iIkYmRFjm4kMXQKw4OBRvS3jJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 17:01:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [GSoC RFC PATCH 0/5] repo-info: add new command for retrieving
 repository info
In-Reply-To: <2EB72983-BA77-47C3-9331-B08760B092C4@gmail.com> (Lucas Seiki
	Oshiro's message of "Thu, 12 Jun 2025 17:25:22 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<xmqqikl3mtx2.fsf@gitster.g>
	<2EB72983-BA77-47C3-9331-B08760B092C4@gmail.com>
Date: Thu, 12 Jun 2025 14:01:26 -0700
Message-ID: <xmqq4iwkd68p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> I was trying to follow the behavior of rev-parse, where we can
> do this:
>
> git rev-parse --show-toplevel --is-bare-repository

As often said, an earlier mistake is not an excuse to pile more of
them on top.  Isn't the whole point of this new command to remove
these kitchen-sink options out of rev-parse and give them better
home?  Let's learn from our earlier mistakes and do it right in the
new incarnation.

> So, after reading your review, I though about other solution:
>
> 1. The user can provide only one field or no field
> 2. If the user provide only one field, repo-info will return
>    only its contents
> 3. If the user don't provide any field, the default set of
>    fields will be returned

Hmm.  Isn't

4. The output always comes out in JSON.  There should be plenty JSON
   reading libraries available to the GUI command or whatever that
   forks this command and reads from it, right?

an option?  If we want textual format, and assume that almost all
values are text, we could do something like

 1. In text mode, the values are shown one-item-per-line, even if
    the value has embedded LF in it.  At least we assume that the
    values do not contain a NUL byte.

 2. If a value does not have LF or double-quote in it, it is output
    literally.

 3. Otherwise, the value is shown with quote_c_style().

The implication of which is that a loosely written program that does
not grok funny values (namely, a string that contains a double-quote
or a line-feed) can be written loosely without having to worry about
quoting and assume one-line-per-item.  They may show a wrong value,
but at least because one-line-per-item assumption holds, their
input/request and value they receive from the program will not go
out of sync.  And a more carefully written program can of course
check the first byte to see if it is a double-quote, in which case
they have to unquote the whole line (which may yield a multi-line
value if the quoted string had embedded "\n"s).
