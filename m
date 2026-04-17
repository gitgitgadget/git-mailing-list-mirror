Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC02363C46
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 04:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776399318; cv=none; b=jcXZcByAOUFhqRImavgq5IO17MIll78jBXtE2yz5tOsdCbEO86f1FniZvg4oXlZT4ihtfhSBCsrCSFc8E2bvSe7C07A9uch/KdOCBUR9jk1KD+vd7RVOL7C/eWGYa1toZPnKAYQnHNF5Fu0brF2yOFqWV3C/5stDerf+CxKoowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776399318; c=relaxed/simple;
	bh=Z0LPFiqmEeQrXHdtpDqDZomjAb+ciRVg4yV4iyyaU0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLZrQLwR1An1W8aOFHATPvPhIz6c1ecC50t9FEjp2vSVvJbGX0Aztkjyk/iZ+bIiRlnluvQ7Fe8v7QF0zbcnyR5M7NQRLS/z2wCS/GrG1RsylI8kOs7I+TlyRZuBf85hZJTpA/yjECK7ohrk4q9Yk3tbNDRY3pLRr11B5nRosl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vPATxrHq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DM9AlRMV; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vPATxrHq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DM9AlRMV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B23BC140009C;
	Fri, 17 Apr 2026 00:15:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 17 Apr 2026 00:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776399315; x=1776485715; bh=STYaEcLYhe
	3Ts6Ufgmh7cwWuoYlLFtS4V0zWARp230E=; b=vPATxrHq3qkKMOFrIXHnWYG/Gb
	LX02N4SwDNol5/m2mozf/yG2MslbK1GqcNPDRqSYNOy733UH5+33oMVpbZT/EgTk
	kO4ASLD3BooD/8ROHWr9SJfFSoskkokseZ7D+RffJEgEOu1eeSQHE6D7BFcKxCWB
	SVUCUomhCK0U2m5NCLroYHtel36y31bH4WS1PMaiBeG8qidKEH7eidsJ8cJJpFEC
	cdNZ6xwMOvYoK3LyxPTnd5123OSXmYLgCzE2OaeandubMF9GZ0Pg9uPCEd47gIsA
	31Dk9HyqPQBI7cwgSs9MrJm5y8c2g5VeDrB5rwCPVCLbrn8tcaWDVbtSA+6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776399315; x=1776485715; bh=STYaEcLYhe3Ts6Ufgmh7cwWuoYlLFtS4V0z
	WARp230E=; b=DM9AlRMV7IPnuxybux3bsomtcVmasghIEfXEOh4U3PmkWCvr+S3
	dCHSiJgO4ylq2yelbOunrRGtN8nI7jzufeNnXSqMhouax+Dj8+ERKRhHkfsuncTR
	ylD8OMaxf3MMX6wnPOZjhPu2SRlLM5VA3RlnfIrUL5RFRlRM91uRZiUdYjgRH2Hz
	DizXgJGEtgC3rZlFL4tyTdzccYc4Yv0JPYlMkxsBbP17tExJx1XyXtoPzxexC6gT
	rRUfbn6gqg1JlQNs5sHo0o1J6/3N15Jp1LH3CXbR7zHLX8RRGWbGjS1NsTAyrBV0
	GFpsqfdiEvGN/TkZvQ6SoMSIhkaMpI9E4dA==
X-ME-Sender: <xms:07PhaV9DzXUMEYJf6HpOwl1l-avq1ZfrdOJ0DljsnX3_80vvtQUQhA>
    <xme:07PhaQnwrSvCfp-VbPXIvC-bTMkDIkGAwiyEv1aF2omJdA4K41J0d9oe6UXFJvCXc
    b5STnstIOylrynkrCkfEsbK4mDqiGSn5CmH6sQOUod6QMPcSxIk>
X-ME-Received: <xmr:07PhabXcFZiRTRAs_zIMVr3Igppxm7Ft6oc_3CIMSFmCFWdgMuLuJGb2PhXC6c_QxIR18joIIiR9qoBzCTtLpJv8shEe3FZIvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegkeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:07PhaVHBFlgZvpSE1YSEDRK51I3vhAqV41D0swucDQ7icReycnxVtg>
    <xmx:07PhaXfSIJ0HefZ5Jwl6lt772vQXeXqY5q8b8bJ1R5odD5UwJymRUA>
    <xmx:07PhaWLgwJ80XrlpEuG4wSfUVugISgujH7FpV4eI2m8iEwd8sdumLw>
    <xmx:07PhacHdSHupoguAmsBTPLE2duQe-Uw9UFUJK3kDOiFpOXzJV-l6KA>
    <xmx:07PhaTdhR7WZyi9O-OsdpEfe_d88r7q1T872zv0BhgPyrJSnDU0e3Ipd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 00:15:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
In-Reply-To: <20260416232319.GA1904316@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Apr 2026 19:23:19 -0400")
References: <xmqqqzohd0sh.fsf@gitster.g>
	<8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
	<xmqq5x5s540j.fsf@gitster.g>
	<20260416051732.GA48541@coredump.intra.peff.net>
	<20260416053435.GA646718@coredump.intra.peff.net>
	<xmqqldem22uw.fsf@gitster.g> <xmqqh5pa22h0.fsf@gitster.g>
	<20260416194922.GA1887222@coredump.intra.peff.net>
	<xmqqqzoezmt9.fsf@gitster.g>
	<20260416232319.GA1904316@coredump.intra.peff.net>
Date: Thu, 16 Apr 2026 21:15:14 -0700
Message-ID: <xmqqqzoexlwt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Apr 16, 2026 at 01:12:50PM -0700, Junio C Hamano wrote:
>
>> Looking at the later part of load_multi_pack_index_one() function,
>> it is full of die() calls, not prepared to degrade gracefully at
>> all.
>
> OK, I confess I did not look past the two goto calls below the lines I
> touched, since I didn't think we'd be applying it immediately anyway.

Heh, I confess I did not look, either, until I decided I have to
respond to your message ;-)

>> The reason why I do not think reword is worth doing is that as far
>> as this function (i.e., "Here is an MIDX file---please read it and
>> give me struct multi_pack_index back") is concerned, these error
>> returns are giving diagnosis on the nature of errors.  Sometimes we
>> cannot learn the length of the file, sometimes we find that the file
>> is unreasonably short, sometimes it is not sorted properly, etc.
>> None of the existing "error + cleanup" says "we are continuing
>> anyway" and that is good.  The decision to keep going without using
>> midx file (or not) belongs to the caller, so if we wanted to say
>> that, we should say so in the caller, not here.
>
> Yep, I agree with all of that.

Yup, I would feel safer to have those who know this code path better
to help us decide if it makes sense to turn all of these die() calls
to error + cleanup.

In any case, that would be an issue for much later.

Thanks.

