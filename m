Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B925EF97
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506436; cv=none; b=ZhjziROBeZSYf32it+ES5D54hDAJUDZ513n85ADnLqyVTfSLoHjfTqjsWY1yOoXaCuZKg6d5NShn6HbN5snXBP1mIjqE4v7olsSRPYnAjAX25+1QOZAFtnqD25Oj4HOAfKYYJdJFOgnzGmxVBOrdWdHY+tE3qFz+9Vp6aH+rtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506436; c=relaxed/simple;
	bh=V4oGIurKvuYAPMbWXYb1dnApIyTxq4UtX4vsqTRY5E0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J5Hia/Wbd5RhGnlr89d6kquSAQZq+0G/Kjlk4frJ9qMgY3Kb65LVU0QoD/9UcuuqzBgKBOSnbWSara/GF8QWlOAZbz5Qw+9j+Z12xyfHybijuejM1R3+ulBgcICO9SwZ1SIRQbKEuR/iO7EDNO8wo3c/uNUPoMJu7WFdN5T1w4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fka0LOAC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MALZhqVb; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fka0LOAC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MALZhqVb"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 719411400395;
	Mon, 14 Jul 2025 11:20:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 14 Jul 2025 11:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752506433; x=1752592833; bh=V4oGIurKvu
	YAPMbWXYb1dnApIyTxq4UtX4vsqTRY5E0=; b=Fka0LOACLzbaSkOZ06/BgrS/+u
	G9lE4PaQrD6AJGnax6ws1oBp2tWF48v5yrkoSbrnqd1sWG3b1IUpVrO9qDf0OtzO
	ySctmGfc2KXHFyU0SxGkuGy6vvimHZzsW96tdnhYMdRlGIi+iD6ibxYQvbXoEs7E
	x8KHdvKMs0xhH+xTeUWhRC9kGpPjgDzCaOH5+nArINJj/OePnlXi+P9e92mKaOPD
	SWnM8lrzqrVCULLSkuuTDasV53VcgZS8Cz8se32NaiwhQnIUGU9SFVoWndVQhYbt
	9OgZb7NdLwXdOUnJNjiCRlSErbo+pryr9veoPgHCJg0DRsoq34V+qykNF6Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752506433; x=1752592833; bh=V4oGIurKvuYAPMbWXYb1dnApIyTxq4UtX4v
	sqTRY5E0=; b=MALZhqVb4gsNdbhTtH4zD9Wa5RdmJkETMkV6fQptCiTE72MTOTQ
	lo+nUeUpCMPwZOo+m88l+R1L6HQwYoWItXWW1OPmzNz3kBg8tvPaIE4XLrEjx5BR
	JrTNzCtLSfwWskIKV4g/QA6bEJUJIDzq2MZkPZ6NvcJEggeS5isU5d2vI/ejs9N/
	JyYh4yctnI2jpyVoTYcKL/xtQ7pOIGc2ajB2BugywACPX6AYZ+dqe4ya6e0GKmR5
	tEjimtFGm47siStBjorIKzTZnigpVokXUr3ar4Eq8Y+iqOpXlQFyox8LI1szli+j
	3DwiYnD3VCk1k6n6vvDpcPC3wceUU1X8i5w==
X-ME-Sender: <xms:QSB1aMmrEMh6kRHKM30xdxufc6fO_MmKaVsPGQB9A04PaxpCE181Zw>
    <xme:QSB1aGbIpULBo2vrOTbb_zPzPK2yXpa_fW8MQJNWSJgaR29-AGEHKq2q4k83xsRh7
    8GmMtGkGPwHZ3OtEg>
X-ME-Received: <xmr:QSB1aHMFyl2GhIepggpxlNOLpYGYFdbq_qMFfwOz1asZdXoXMaB3-rCIGD5qLUfWxtjv5LUlXAo7TF6Os2agI3VMKjQ5pJMa7YoOyIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QSB1aLbZLt24crWrrNyvumvrVPUBf1S2U_gmGE9tL2Dge_Rtm4ReGg>
    <xmx:QSB1aF2E6hoQxXtQnx3vqmO0k2Aca3G52IY_ZQ9FAEk-WSPSmGVMgQ>
    <xmx:QSB1aBf9bFzD_3hHI_voud9cqqB-t0VKDIG0aPUeK5tqr-SlRY4DDA>
    <xmx:QSB1aGFTK6RvObEyby3Q9EWzNy1o8TFbL2o5uYrsO7qs35Cr5zoibw>
    <xmx:QSB1aN2PJOIs2SxDzlDc-thNlF8WgpEdGIMADKUVkUM5Ia46G6AEkBLh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 11:20:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Arenas <carenas@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH] meson: disable PCRE2 dependency by default
In-Reply-To: <CAPUEsphoFaS7CnxXs_PsMCtCrB7ByE+y+SxQGaxoovjAdH7UFQ@mail.gmail.com>
	(Carlo Arenas's message of "Mon, 14 Jul 2025 07:00:45 -0700")
References: <20250712172615.11364-1-carenas@gmail.com>
	<aHKgu3Ew3Pk0PL2v@fruit.crustytoothpaste.net>
	<CAPUEsphoFaS7CnxXs_PsMCtCrB7ByE+y+SxQGaxoovjAdH7UFQ@mail.gmail.com>
Date: Mon, 14 Jul 2025 08:20:31 -0700
Message-ID: <xmqqikjuvlxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlo Arenas <carenas@gmail.com> writes:

>> For most
>> builds on Linux, the system libpcre2 is the right one and users will
>> expect to find PCRE support by default.
>
> Agree with you on that, and indeed I think every packager
> of git (except for NonStop) does enable it at packaging time.
>
> Maybe this is an argument to enable it by default?, one thing
> that I wonder though, is if we should first isolate the code on
> its own and link it only with `git grep`.

If we decide that PCRE is good enough to do BRE and ERE emulation in
compatible enough way more performantly everywhere, it certainly is
an option that wrap our calls to platform native regcomp/regexec
that we use for our use of BRE/ERE and internally use PCRE for them.

Before that happens, "struct grep_pat" that encapsulates the
distinction between using BRE/ERE and PCRE and compile_regexp() that
compiles an end-user supplied regular expression string into members
of "struct grep_pat" so that it can be used to match against in-core
buffer we have, would need to be exposed outside the "grep.[ch]"
machinery, and direct uses of regcomp() and regexec() in the rest of
the codebase has to be rewritten to work with "struct grep_pat".

And after that happens, teaching "git log --grep=<foo>" and "git
blame -L'/<foo>/,/<bar>/'" an equivalent to "git grep -P" option
that tells the command that the pattern given is PCRE would come
almost for free.

Is that the kind of isolation you are referring to?
