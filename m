Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495428152B
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121556; cv=none; b=QvJ1TWvZKjjdGZ+wRl/e2Fp3zVt5qGMKa0HNQdGJNvcZPBb6C/svDF3Lq1UiHW1XNyHGZ0hXbyRUBwmDIOh5trkunEmPL4/1IvBWzxaB+BapXXAqvCGGhahRXiassfV56DgjooeD2nTJZ0owsp5B0bBHQj+XTGl6c+3DlfDHYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121556; c=relaxed/simple;
	bh=Cq7JxyuBwgdX+dbhaqmVx3O411I8kDTD2W7yAsr/t9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQSbCwPM8AMIexRb3aAOxx0ca2Xi2YWUW7EMeIdSotGedsK4cPpI08VMKw14s29ZE8X+fsj3oFx6srvj92ai8JEWPd5gfMsQhlDDVLhAaPaERR8d0fXj60fRvNEOhYHK4ozt7fsnAgyb3R24xLj+9aDI3Rara3ToXtcMlCd9A40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JHbATOYY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AwxM6QH3; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JHbATOYY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AwxM6QH3"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F80A1D0017B;
	Thu, 10 Jul 2025 00:25:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 10 Jul 2025 00:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752121553; x=1752207953; bh=NWsKJTiLZZ
	W6fxIQ5RgfwPsYplr/XaC06qFV2+dbDGQ=; b=JHbATOYYByeyBFT6XHj0SmHtdF
	athRXiyvDclZiMuPkAX9xurhkrOzuK/MsYL9znpETzEuqTcwIOkO6/5TfV+C0cf0
	HLtWtGQMalxWZ/6C9hik4Z2l40I6KVCis+TNf5BNWApQeqaW2+auBWLejlg7y+xp
	6rVpUz64Fj7ysXhX/FCwysaCI/lEWrppnLEXUDvnzNVShuFbb1vZWMC8tyhaX+es
	skrrm9OcnukaLTA3kbZmUjUQxrYEvo6FgKMZb1yhijr8CWSw2UrENPlpDdFGmxQt
	HVCPyLSAosgzoKKo1zvhutTQ2i6baut55DmsGPdIKrEEceYKmUV06qKYCSKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752121553; x=1752207953; bh=NWsKJTiLZZW6fxIQ5RgfwPsYplr/XaC06qF
	V2+dbDGQ=; b=AwxM6QH3IfoohBBFuhy9swCc1ZnU6G8FwAYjLjLom4EwIpWJ0GX
	npyvwWBLOBdmsO8TvVfRT0/J4cTZ0F2fz1KnXFKcPCYk08FkQ/LfF4SXzTuZj65u
	zwMYTxbZVn0qsHEnvU8QKbZy6ywkE8aTgXDMI/dDgDoeHWFLScA2WI+SSVrwf79p
	KuYY4p0Htis6maitY0q+GbMAybdF0s+LlLp8xOFS28I0nQfhxQVfJEeQ6SH9wzrP
	BQXRcoLDFI9HtPy17SbslujERmT81QfmyZfITxwSICUDXLSiHbdingLUeQms+rVh
	mMdso8B6SuETT7V1CJ3kaVJdJHMLeW1/fpA==
X-ME-Sender: <xms:0EBvaCc3RnzQZorekcFco7nQIt5HLWePnnaB6ELJAavPQq24ex-5Eg>
    <xme:0EBvaErgKfIHvqT5BR-oOx193K4KTmuvb3nnecx4PAOpAc78dS8fWHWYrah1OZFiT
    o25B5w4NFkDlNUWYA>
X-ME-Received: <xmr:0EBvaD9rfI9cJwIOHt-IEpeh-AuhfkhAr8WLJyay-tc58oPMZZMRtpRjz-wgvPNnaAQYa7KGkvODbMavpA56Olv_UrUXZjnO17zsPmM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    mhgrrhhtihhnrdgrghhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvgguohhsthgvsehrvgguohhs
    thgvrdighiiipdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0EBvaAcT3sb6KUzqea3nVyGq5mI7DwJtlf-cPAxmk9c0L49MZnbWZg>
    <xmx:0EBvaNKCSl1h9jYbU5PuLc0_HY8sjvScsAoHXIALHVo72qNHtPjKGQ>
    <xmx:0EBvaAjW4m30mFYZc7CYDPVnOKLxh-1NN3l4TXGpBHYA6KIwQZNQWA>
    <xmx:0EBvaLRVDtT8SoM0jIfSnIrX2luigGh6XELC-QFuZjELVZqc_weTSA>
    <xmx:0UBvaIL4ueDmeetYFpBGsc82LMi9DjHVY2iji3LsMnIY-qdVJS7En4sY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 00:25:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Martin
 =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>,  git@vger.kernel.org,  redoste
 <redoste@redoste.xyz>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
In-Reply-To: <20250710034623.GA2066787@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 9 Jul 2025 23:46:23 -0400")
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
	<20250707204224.GB3115893@coredump.intra.peff.net>
	<CAN0heSou=BgC8ec9ZE+V-pYKt+XQiNfOBHj-5CZY8s5XCatZTg@mail.gmail.com>
	<20250708225134.GB1180568@coredump.intra.peff.net>
	<aG7wcoy3gTzSd_4w@fruit.crustytoothpaste.net>
	<20250710034623.GA2066787@coredump.intra.peff.net>
Date: Wed, 09 Jul 2025 21:25:51 -0700
Message-ID: <xmqqzfdc8yeo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Jul 09, 2025 at 10:42:58PM +0000, brian m. carlson wrote:
>
>> On 2025-07-08 at 22:51:34, Jeff King wrote:
>> > Yeah, I agree (and didn't know that before; thanks for mentioning). I
>> > think mostly I was just hoping that some of this reasoning and these
>> > pointers would make it into the commit message.
>> > 
>> > The content of the patch looked OK to me, though I do still like the
>> > CNCF wording a bit better.
>> 
>> In case it isn't clear, I'll be sending a v2, probably this weekend with
>> more of this information and some updated wording.
>> 
>> I don't love the CNCF wording because I feel it's too ambiguously
>> worded.  What is the "community"?  The open-source community?  My
>> neighbourhood?  My friend group?  Can a real name be a username or
>> handle that's distinct and unambiguous?  What about communities where
>> people share the same name?  (Debian has, or at least had, two
>> contributors who both have the exact same full legal name and can
>> therefore only be distinguished by handle.)
>> 
>> I also think redefining "real name" in that way is misleading and leads
>> to confusion that might put people off, especially those that are not
>> native English speakers.  I know it's common for lawyers to redefine
>> language to mean something very precise but different from the language
>> that ordinary humans use[0], but that's ultimately dishonest and tends
>> to deceive and we shouldn't do it.  Most people take the phrase "real
>> name" to mean something equivalent to "legal name", so we should use
>> language to describe the requirement that doesn't confuse or mislead
>> people when it's used without further context (such as in a social media
>> post).
>
> Fair points. I think what I liked about it is that it emphasized the
> purpose of the policy:
>
>   The key concern is that your identification is sufficient enough to
>   contact you if an issue were to arise in the future about your
>   contribution.
>
> I also liked the sentence before:
>
>   Your real name is the name you convey to people in the community for
>   them to use to identify you as you.
>
> but I agree that "community" is vague there. I think it mostly means
> "the development community", but I agree that we could perhaps sidestep
> the whole issue by just saying we need some way to be able to identify
> and get in touch with you.
>
>> I'll take some inspiration from the CNCF post and rephrase to make it
>> more approachable in v2.
>
> Great, thank you.

Sounds good.  Thanks, both of you.
