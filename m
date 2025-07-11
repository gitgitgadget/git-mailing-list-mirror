Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734F28B519
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246689; cv=none; b=Vi+BdFhU21uAlB0uH2DOxsJUBzLXa5tlaBTqXuPjOodbCtgaXq9oYEFvDvae56v4jHblPvVDYtOhpAvsP26K9SPPRKTH+9TdnRcEmJUPqS4Az7rZYXVHLXTsyC3DhAu15PgMMlSGaCF7PyWVkwp7Tpy/Fx3xENowdiatoMgs+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246689; c=relaxed/simple;
	bh=EKrmemeTQ/tpveWGrI5xq09ZFhca2uHbfve21l3P8/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sIj1oxpTqtf61i+0+q7CxqhUIBPHcazfeGc5dQgcmRyaFIgPjecD1Vr3EaAuupkyks4MBYGF9f9/WRzYD9h2BUJC8cfYiu8Zeb0kTGzqX/H/tp/zzM1s/f64zKD/OFGggboLd2jKVA/7WEptA1YLbz2oW7njuBwsrYm36Eiex1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V+ocjIWH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b2MdND9R; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V+ocjIWH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b2MdND9R"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FAE71400177;
	Fri, 11 Jul 2025 11:11:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 11 Jul 2025 11:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752246687; x=1752333087; bh=UF1iOId5Gf
	mZSKAU82p1S8BnvKSFjsmETrzmS+pox1k=; b=V+ocjIWH8vf8j+tHSWvvOQhg1G
	Ucw8EJjMtsoFlM4BeKY/hkyVbuoV8eu3g6dDpv3Php+P3t+rfWHm5AyLk6OzhrEa
	kyNKnoFiAPFpqczfpLe+cqq+EgbujzL1kW+VV6EjyUny+LUjoFL6S0oa5U9oJyiB
	iliAw0BeOOvc3sRHdWlhqMxK6AGR3opm7AZwx/6hRkKhxkoK7AleMCPw3FVUjzvw
	BMvKHoG3roouI5vD963iQF7XToSHsfyeA8wLg7UDH7dJ757T49GLrsPFltIwrbLA
	WEQhhQ5JTmqULPz0LYmcIGGtpcz0A8y+4cYjeA13AXoR6WJqU4Rju3sbO4rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752246687; x=1752333087; bh=UF1iOId5GfmZSKAU82p1S8BnvKSFjsmETrz
	mS+pox1k=; b=b2MdND9R+wBpkByqnKnRnlaBHUDDZ/KoRBPwDBAkSN60M0Uc1w+
	0RU/BzXhG9ec02WCnyrDiuZqTj6GqDVJbrsubt25R+0a4rGP9JbzniiZ55dpdHED
	LBiNOhTEdlQV1n1ef5p6wwEribQkE9PQqY9mL46Fv+B59N7lFgjPLMw7Vtb6duOX
	gnWTFcsYxA8eoUEVPvGnCTwrCz6xvyNzHrShDIS6T5zbV8PGuqc14s2qOmA7gaT+
	x88AGVUVxHiMn3gE3Q4wbz5oEtr7CUUIsXj/LuAgdODhVrAjdsUZIZ5PNPkHP2cz
	ARBCJ5AjCy4oxYStNa6zpurgUthyg3RwT5w==
X-ME-Sender: <xms:nilxaAjXogpPpMeVBZv1ABjeUG5DUDugIwL27zAlHSyPiuX8yEmkyQ>
    <xme:nilxaEhR-aJJIlJkxh4cDCTYXjLltP6a9OompCCfu_TA49dafjQiiAaOBYz3HF5TG
    4a_ehSjqvLF6ybSEw>
X-ME-Received: <xmr:nilxaOh1L0fqNCzQ5p4DH6u6_0ZDOXGVkNaPTZc5UPLsZot1fc7mKVMq-gmv8bQ2cLOdaKD_OEaAYRwdvxc4272_XY7uN7Z2C7KXM60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrnhhhuhesghhmrghilhdr
    tghomhdprhgtphhtthhopehkohhnshhtrghnthhinheslhhinhhugihfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nilxaMJgGQpYunJx9crejuwDHBFAq5ljk7CrSM8feHA4VxeidgtAhg>
    <xmx:nilxaFHYkIzN7rxttt2-37LfP6_il14oAj1Zdo30kZtA9C_6Wri1OQ>
    <xmx:nilxaIQo6vq9R2oCcdT7J2rrjX7wLqAFbLn2PgNHshaa503CmaNwdg>
    <xmx:nilxaJcZO_8jfCAj6fu-kR3mfJk4sXMVB8HY7pcXQOLQ6Pmez6b9og>
    <xmx:nylxaPVGwPA3Qnz5igWlARSt6DFNg1GySfGqr_JM2aOPomoz2l7X7kUs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 11:11:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Stan Hu <stanhu@gmail.com>,  Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>
Subject: Re: [PATCH RESEND] sane-ctype: fix compiler error on Amazon Linux 2
In-Reply-To: <aHDDnKx9sK1ctzIR@pks.im> (Patrick Steinhardt's message of "Fri,
	11 Jul 2025 09:56:12 +0200")
References: <20250710-pks-ctype-v1-1-1db7e7568ea2@pks.im>
	<aG-EfIfyXxmS_x22@pks.im> <aG-HMnO11lCYgPiY@pks.im>
	<xmqqtt3j69r8.fsf@gitster.g> <aHDDnKx9sK1ctzIR@pks.im>
Date: Fri, 11 Jul 2025 08:11:25 -0700
Message-ID: <xmqqtt3i3gpu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jul 10, 2025 at 02:01:15PM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> >> > This error bisect back to 75a044f748 (git-compat-util.h: split out
>> >> > POSIX-emulating bits, 2025-02-18), where lots of bits got split out of
>> >> > "git-compat-util.h" into a new "compat/posix.h" header.
>> 
>> So there was a subtle change in the inclusion order or something,
>> i.e. we used to include <sane-ctype.h> a lot earlier as part of the
>> <git-compat-util.h> that tightly controls inclusion order exactly to
>> avoid this kind of problems, but that has eroded recently?
>> 
>> In any case, it means that our definitions in <sane-ctype.h> will be
>> overwritten if we allow system-supplied <ctype.h> included, and this
>> is an obvious workaround, likely to remain correct as long as their
>> <ctype.h> is not so broken to allow multiple inclusion.
>
> Yup, exactly. Toon figured out that this is actually neither glibc nor
> GCC that causes this -- it's OpenSSL that transitively pulls in
> <ctype.h>. Later versions of OpenSSL seem to not do that anymore.
>
> I can reroll and update the commit message, but am a bit hesitant given
> that I wasn't able to send out this mail in the first place due to
> whatever reason :/

I did not see much need to update the proposed log message; I was
merely trying to make sure I understand what motivation and
assumption are behind the change.

It does make me curious what in your original message got it
truncated.  If you received the message you are responding to in
full, that means there is not something funky in the diff output
;-), but then I do not know what it is in your original message,
either.
