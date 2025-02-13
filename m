Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6AF1C84CB
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 23:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739490336; cv=none; b=MzneshBEnwibIDFkABgxJGSsblykTU30Q+ajgDU7LjKGoGQcdjl21RUfTKWwsK0wFP1d3ecEAVBzoj/kdy9ivZoKAGd9ECSZX1ag1Qsr7UxV+aJx9sCqwviOUBgjlyPkanGmtPJPlo1Vd6P81bnkXDKTCb9dPIYYkDGZJejAtRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739490336; c=relaxed/simple;
	bh=6qU5ldV6gTIk3chGey4FafZUxC562LEMmjNFnJXuVKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uTs0PlqKLPANcNVlWHS3YTEi0zovYrVOTbMN8xNqsoKDUpbF5LdsKqo/ijmtOPO4SFqVMW74xvejOW97E/JesZ8azKbGwt4f+CTJq1M8+w3hMGbIRXLTKPn+lql0b46BNlP7CGu0Wl3k+998cG5vXNG/tLPYn3x94x6Z0CkcK70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GroxJ1iA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=plqXBECl; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GroxJ1iA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="plqXBECl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADA1025401B5;
	Thu, 13 Feb 2025 18:45:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 13 Feb 2025 18:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739490332; x=1739576732; bh=SWJq1jotfQ
	bIVUtfY+BzLweVHm2xc86KOhGMZ6AI+Lg=; b=GroxJ1iA0OEIvAmmQjveDxlDyi
	24pYxRwysswG2Z9OSY54U2pdcjqjj70oDbd9vjIggjl2mbPiqa9HWZ3/6rVZ5AZN
	EJTzAlbKkytjc4LeORKw56/SskD3+MqHwuEnSdjbl7ASpd2e30g6uDXMnia/Qmim
	szxRFQH5Iot9aNmShMfNyz8+l8oP0bkp7Yf5n7iU9DawwV8KGn9ee7qHilL/6rYz
	A6YLQjR40PEfuvMGZtXRuQbudyv+S/CkJtMqkpbW1nkeUmqTKwX5ZqIIz6N93QuG
	vpoTKLv6Y0V0fDgcc3wQVeAY1LbAPsKSAJSUe1GpvNxWYt16DD5x61mUGdQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739490332; x=1739576732; bh=SWJq1jotfQbIVUtfY+BzLweVHm2xc86KOhG
	MZ6AI+Lg=; b=plqXBECltPn19CGppFR4MVTvAqXvlbyF3Noae93PGkjkEiG288L
	/CB1bkcj7nj+EJ7iaxwRfbsB4172/SLdRICqNSvDJTojDPf+gkipKIMvKk3HqztI
	pGhcvjVdsBrIxoBclPm7mrvb30x1RiwchLkMGPNjubl+w7yp8ueGYIg/ITg2VUOb
	Nj+eEd/waSWMvHf7hvRqY27+X/Zkj/Eu0qYxo88fg4zJ7N21eumsqM96oJrYTY5v
	1tcYdPrXX4BRALuoNpLP1cvmK0mxTC5rORH5gSdY+oAJG2d5GYfMaOdduSA4mhMM
	u8Gl26Pf46bkCmWWwgS/JsD2eIk6YMhUQtA==
X-ME-Sender: <xms:HISuZ8Mk4tfFzQXp0ex9wkYe1_o82mY8l6jIzab52JGfB1ErXHKBxg>
    <xme:HISuZy_1Cl5KtosFm6v87UVs8-0H8Ga1agJ7_OJkuUg5Br6zYR9saKfKmL3-Au1ca
    uqDRpO943cGR4BReg>
X-ME-Received: <xmr:HISuZzT3pqM1GXLHqW7CNo2LLEZZFB_NcbRuiIGvr5zYxNgZLGFw0JKTjit3DOCRb_oTUdnYw71I9mNyw_Km-1F8DZE7COAn1lobwR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegkeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtohgsrdgvrd
    hkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HISuZ0tlA_GFVVtnygmVY0YzZDjhC1-Y6I-7pG33CLk_pbYD4E1Oag>
    <xmx:HISuZ0dH21LEjvwK4A50haa54Y5BIG-CqRhEhe8wRPeKmWrHZygX0g>
    <xmx:HISuZ42_wRGmo8nmkrj9nhijao-yRxGFcmSeZl-5BQ8fGAFKqWsa8A>
    <xmx:HISuZ4_OMPBO3ul8Hf5NjBYqLhDbsM1Y1irMmkEaj1adpGyptp2D2A>
    <xmx:HISuZz4AMkeE4c7u2iM7cpcZIiO9mMI3B_9Oc5X8I1gGTB3TwoVcEOLb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 18:45:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH RFC] mailmap: fix check-mailmap with full mailmap line
In-Reply-To: <20250213-jk-fix-sendemail-mailinfo-v1-1-c0b06c215f21@gmail.com>
	(Jacob Keller's message of "Thu, 13 Feb 2025 14:47:22 -0800")
References: <20250213-jk-fix-sendemail-mailinfo-v1-1-c0b06c215f21@gmail.com>
Date: Thu, 13 Feb 2025 15:45:30 -0800
Message-ID: <xmqqwmdtmmsl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> I recently had reported to me a crash from a coworker using the recently
> added sendemail mailmap support:
>
>   3724814 Segmentation fault      (core dumped) git check-mailmap "bugs@company.xx"

Thanks for relaying the report.
    
I can easily reproduce your segfault with our own mailmap, by
picking at random an entry with both name and e-mail listed as
the mapping source, e.g.

    $ git check-mailmap ksaitoh560@gmail.com

> With a mailmap file containing:
>
> A <a@domain.com> B <b@domain.com>
>
> I get the following unexpected result:
>
> $ git check-mailmap b@domain.com
> <b@domain.com>
>
> Based on my interpretation of the mailmap documentation, I would have
> expected this to translate to "A <a@domain.com>".

After reading "git help mailmap" twice, my interpretation is
different (disclaimer: I haven't read the implementation of the
mailmap code lately, and the last time I read any part of it is
probably at least a few years ago if not before).

Unlike "please map anybody with this e-mail address to 'A <a>'"
entry, which is spelled "A <a> <b>", the "fully spelled" form limits
the damage to those that match both name and e-mail, in order to
avoid "D <b>" from getting modified, while rewriting "B <b>" to "A
<a>".  So I would not expect a request with no name to be mapped at
all.

And the command emits the e-mail intact when it does not find any
match, "b@domain.com" being answered by "<b@domain.com>" is quite
expected from my point of view.

Thanks.
