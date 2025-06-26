Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFFE3BBF0
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750898724; cv=none; b=SvXSDH/Li8RQLdP0x3VMPO6EaDL0U29uIcMwlYUdhOih0GtbKbQfzgsrQkJ7ZbNN4JUnPfScfpoU27S9MhubDSznOzbeuqMWgDHcQ6tk8ZTU+DFEtsaQRwrw4QQzkwGlgG0PquIBQMFuCOAzSgAiJHktPtyLryGenATGdEVqnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750898724; c=relaxed/simple;
	bh=RKjRXzu+HvuOrx+7BVsXewGVPvR6zm4NUJUVwltdHgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gEeq6c/57fOmIYmEbM9zeW65nLIb5s1XMtRdylmWoh2p+xIEWn4JSDkTz2WedakzV7En6LsAb4xj1xPSjmWGKSyXLNMVCzRegCK118ra38ZEjY+bIco40/6RSHO4TbgtMTxbJUYB21OroT31YkHH6SGVyA85gB9A2leab/W8sK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WQRrsNWH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h09Iv5L+; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WQRrsNWH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h09Iv5L+"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B4B07A0296;
	Wed, 25 Jun 2025 20:45:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 25 Jun 2025 20:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750898721;
	 x=1750985121; bh=K80Z5du9ltA7+v1+Jo2oMxm5DLvbszCi73EZpfm35TQ=; b=
	WQRrsNWHmbG0oTKQXKpf1PbSbG7z0mlweoXYKsfQGRE+GbAITYRvYr2v/oMznL0t
	b2l7MRLoysMoRAmPASa5qdhP8ppeuz1fulbknhWYSUnaAb51EX76VxYaVHinRORR
	Tse5uUzkDDjhPQVkklhGnclj0ZAcvokbgk78rFzE+54J3b8yaQILEaKaVGBrHGkV
	2K+W6n07URStoInwv6LPYZEZXM22cnYIFn9PJZ8mCi8dR+aGQ6P7tGC5FinrXK5r
	6oJk5rnDONoRZAb0fuS1UL8Nux5UAYQ5CwmlmRJSmB8kUEDHC10YWyEjZ7yeCqwa
	EFhyX5ms89fojSCN13wB4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750898721; x=
	1750985121; bh=K80Z5du9ltA7+v1+Jo2oMxm5DLvbszCi73EZpfm35TQ=; b=h
	09Iv5L+hWL+f918Ht613oa4coGO8HueFgmoQyJBA0MKWXRsAYcV3i5tc/9aKLmIH
	jpn+s2kgBnj8Jn5C/06vVSbsgkbeYbQnagvJDhGOBjkcACrq1i4tqNFoQhragblr
	BIo0QM5i5Yy0M5W2b/i6HtDBYlsWZywQxzmaNI5BKoBAAC3udl+wBS56C158Vo03
	X5JBTwYuWgXPMzylWprwM9ZCZ8tS/BFDDzRTfSuv1jDCLi5ijYTLZ/KiK2Zn11Oe
	jJCA+D+qRe4f1yO1F2UlBZQIaXj6K3G/z3SvuOLPL0Zpgnp3LSSj9+bVj3Yzv2Fw
	O0wW9w6m8gZxKeOcOS0gw==
X-ME-Sender: <xms:IJhcaGFQtgK8-1Pd8wl3gG0LY9qyBjkPrTRp_ygwaLVrxfSexTgSyQ>
    <xme:IJhcaHV7OXOhnQBn8LFp60I7_EACoVcomEiGE5FcriN-ZnVS7HvEphOvJfHqKv5mr
    fksXowjKUt57N8xTg>
X-ME-Received: <xmr:IJhcaAIHofFp4rHER39qBy4fuMSx-Bq3QHj2BEFGef9sPSKjRhljFeEgoI_14t8GlrlfUQXqD3kDs-YDE2m7O7wYoZtWjCNaLRHHzkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvgedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorh
    gvkhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:IJhcaAE0lwShAeup6r_xrR8ijZIXiJM4ugZafmU8-tt95Z-JzawjHw>
    <xmx:IJhcaMXOSdjgG7xGA-1ta43BOssMp7IBTfOWgaEGx7ffF-gSnG6sfg>
    <xmx:IJhcaDOktFtinmGfUfBGqOmCMWFFDUPpWVJbRwHb4wRO3zZ1gWArOg>
    <xmx:IJhcaD1NEWMrb-_XuduhOEBWNBjOZZXrnT1L3qdCiUL1DBFS_lL3LA>
    <xmx:IZhcaAlMlZEnT_zlzYDCLCO9BPqb62Jyxu8ZQ3DP9hqhsQYS0xAbbqEZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 20:45:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 1/3] compat/posix.h: track SA_RESTART fallback
In-Reply-To: <e82b7425bbc2540fa5ef3fd4584e6f902485d064.1750836928.git.gitgitgadget@gmail.com>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Wed, 25
	Jun 2025 07:35:26 +0000")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<e82b7425bbc2540fa5ef3fd4584e6f902485d064.1750836928.git.gitgitgadget@gmail.com>
Date: Wed, 25 Jun 2025 17:45:19 -0700
Message-ID: <xmqqplerqqjk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Carlo Marcelo Arenas Belón via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> +# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
> +# prefer to use ANSI C signal() over POSIX sigaction()
> +#

I may or may not have mentioned this, but this is not helpful enough
for folks, as there is no clue for users to decide if they "prefer".

We need to state how they need to decide between the use of
"signal()" and "sigaction()" in the affected codepath, especially
when they have both.

If their system lacks sigaction() at all, the decision may be
trivial, but the conditional compilation you are trying to achieve
in daemon.c is _not_ like "my system has both, so I can use either
one and the resulting binary works just fine".  Rather, "Even though
my platform has both, the sigaction() my system has is not quite
right in such and such way and I have to use signal(), unlike
everybody else, unfortunately".

It may cause us to rethink the name USE_NON_POSIX_SIGNAL; I though
I've already discussed this point in my response to the cover
letter.

Thanks.
