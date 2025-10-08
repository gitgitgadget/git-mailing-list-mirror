Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4A2BE056
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941707; cv=none; b=CJ5xod2seq4LqEBEyka6DsvBLC27LbHV9X/5LfJpLn/Ri0cC28WjEQoMUHcU/LB+aiq/IiG3Afnhh2CKs/kj/3E6d8FbjwnXUPW/dEPm2qSg0YqSvw7taK1Z+kCqF9a6X2Yhi5Aa+icC0JO58EdmFdUlegTo4xVJ6Q+LYS8rup8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941707; c=relaxed/simple;
	bh=suqOUGCLUcCLIoTOSSbEPBGKeQnC6Wh3PmdSYnZc9Mk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BjduzGoqbCteNLafGu8ANI9GIanWQs0GOmiNXSX8TCu0U3zzH+NKTHL6ITgG1zhx+fHjSetRbuLTcD65r5AHuRaK+HCasSHvA/Tc7x0fwuYcN4AIk1jS8t/P+5+xajRxcOPZYtUHcWI8KNdmhs7MrGtMn8ZnD7wWxYO4ovqa4Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PXQprEEz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eVjK35k3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PXQprEEz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVjK35k3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB23E7A00AF;
	Wed,  8 Oct 2025 12:41:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 08 Oct 2025 12:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759941704; x=1760028104; bh=HhCin8ApC1
	tOhCxE+ZN3uZYD1nVRKGCGMSfJwS8XV8U=; b=PXQprEEzGeiNnF4DoiaKb6SEaD
	TfXXXS69LvlQSXzPNPkA98Zlcpx74l7T0rDNw0Zr6XKj0BozP1ZmL17zhpIrUi+i
	9YZQUf4qYVAk9EXlUzbLAPantvMaTdMWuCSpaMJCEUQ7sZTPg5yXHMGK3G5hSUVD
	IzwwMEmz9975JN3ypbgptaKgHFkbq/nSn/pUF7VsJP+EJDbIeQ5cGPBBIhADQgHw
	1+PVBOcpaslk8C2im/bWlyxbMxWmnF5EDHyaxFs74EjwiluKVv3Ptz0IIqy1Rm8S
	7grwb7mZmpQM06jf6VSSSsQJgNTHL3h/1mnxG2CxWRRZaBNfPPxaHhOtyTmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759941704; x=1760028104; bh=HhCin8ApC1tOhCxE+ZN3uZYD1nVRKGCGMSf
	JwS8XV8U=; b=eVjK35k3T6URUL3/v83uOzMWrlP2o3QwcRX4ZDIAqnpb9lNxXYk
	jP8sL7hxxTM+cRg4qg3kZcjft+9erIfnQMu0EmHSKwkOjHTONYps2h1nxOZRRiKp
	ip/yHkZAHgPMO7A2qC2c62bDEuK0hxg6z44eWPlaeKwp+YWhWUbQFwOu4d0hscVj
	IXehcDoVHYN/nskmttwv8WG3aKcaxBir+SITUaf/ilFxuI11lKITSU8uz3e0isDG
	ak3CSfUZnL2JcJ4suV59bov3upB7p7LLmXNvicQQkrQPUIq0sgvGjPIXKvuJqG7j
	lR1b8gquoVtuek/b1fk3GpLFOAebVZCRkSQ==
X-ME-Sender: <xms:SJTmaP_niF203XV-_BuJpCvONGdySHiJpqyllrsk7moVkQBN2wmnRQ>
    <xme:SJTmaDLZn4aSjfCsMwciubIBs0AcsVE0rruW17_NyCRMLPmasQW632QD-2Du5p_Yh
    FjoRFFSp9MBc7LbzEH4wIe73vQ9ji-aZu2MehqZ4JbAunYR0L8HkrQ>
X-ME-Received: <xmr:SJTmaKZuyLkM15DTVjoyGLogrs63Zc3TAxLkwDBceG6vEirXYWOltK6I9-PkI0gM3tAte0m74kBG5sfehxcDOt5H-6AEouaOCiWW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvg
    ifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SJTmaFLEkgtwXg2m3PIBDJmiLdzu9U5aSW-JpXll79oZxbWS6uMViA>
    <xmx:SJTmaIC-2Etl5r4FnFRHGfYqW-zBugG18Hn5h-_6s6LGzhNS8uMy4A>
    <xmx:SJTmaKqdAa_BVDDZ_wtrZawvwHjocEYBA_iPBWJDmKYpp_GeNFy5zQ>
    <xmx:SJTmaDjn4SnJ4-Hp8lra0vgQTKGc8pjZ6Oj78zjw3tADBaVHlZjBbg>
    <xmx:SJTmaPI1NDFADxCGu3rfzJm1pQKlq-UFWtk3E3bOrjcIA9i-UeWr4PKt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 12:41:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #02; Mon, 6)
In-Reply-To: <CABPp-BEPYFua9XvNBbn3kzEksyqrrTKfViMtG3=-=YSEU3Jdrg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 7 Oct 2025 21:10:23 -0700")
References: <xmqqqzvfmwcx.fsf@gitster.g>
	<CABPp-BEPYFua9XvNBbn3kzEksyqrrTKfViMtG3=-=YSEU3Jdrg@mail.gmail.com>
Date: Wed, 08 Oct 2025 09:41:43 -0700
Message-ID: <xmqqv7kpfirc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> * rj/doc-technical-fixes (2025-10-02) 3 commits
>>  - doc: commit-graph.adoc: fix up some formatting
>>  - doc: sparse-checkout.adoc: fix asciidoc warnings
>>  - doc: remembering-renames.adoc: fix asciidoc warnings
>>  (this branch uses rj/doc-missing-technical-docs.)
>>
>>  Documenation mark-up fixes.
>>
>>  Comments?
>>  source: <20251002221233.541844-1-ramsay@ramsayjones.plus.com>
>
> Documenation -> Documentation
>
> Ramsay commented that he had a small fixup to send after waiting for
> more feedback (https://lore.kernel.org/git/436fb507-6764-46f4-abb1-34c82e27b808@ramsayjones.plus.com/),
> so maybe mark as waiting for a re-roll?

I missed this one.  Very much appreciated.

> The series looked fine to me, I just feel bad for causing so much work
> for him.  Are the things in Documentation/technical/ meant to be
> pretty-formatted and distributed anywhere?  I assumed the audience was
> fellow git developers and the original .txt file (that someone else
> renamed to .adoc) was the preferred viewing format.

My assumpstion has been the same as yours.  I was surprised already
when some folks started to subject things in Documentation/howto/ to
AsciiDoc long ago, so I am no longer surprised by this, though ;-)

>> * kh/doc-patch-id-markup-fix (2025-09-29) 1 commit
>>  - doc: patch-id: fix accidental literal blocks
>>
>>  Documenaotin mark-up fix.
>>
>>  Will merge to 'next'?
>>  source: <v2-e5ad12cc3b3.1759178715.git.code@khaugsbakk.name>
>
> I think Documentation is determined to be misspelled in your release
> notes, in various exciting ways.  :-)

Thanks.  Fixed.

I blame a new keyboard at work.  If somebody measures my typo-rate
and finds it higher than other days on Tuesdays thru Thursdays, then
that is it ;-)

All others points in your list were very helpful.  Thanks.
