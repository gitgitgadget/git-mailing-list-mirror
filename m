Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA08A35BDBB
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578839; cv=none; b=LDP6svLra21KYo7veOgzLn7NXYCB3KU8TdfZzbtmSWFwnLV9okjhv4C+MhA7lnHnwQXuIaKp4A6FmSp+L9ErxWyjiisx5AKGp615ykZu2PCADDIDXaMY9yTD2DcF9ufW7JKcXigddEC/MGgkBtRoBCnxSzMtCF9zY/nOwW4DsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578839; c=relaxed/simple;
	bh=XgTQtPJfJj2dNtm3oRa+1w5H90X5g8sF3q/UjwCtqvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TDL5IogI4UWakzy0WBkH+BJyIfIZlLLS+wthII/1EKOWjoj/IksxfWsGEHeQ2gk7LcpmP4rD6N++oRAdGf9I6mDxC44B8+3ZAdBgMn/G/vtuG0Uqk93OIl3s1hxGyYdF+OfEBbFwUFg6pUTrWY0wRVxqOqhhw9OGN6ecGS/5Uoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cu0ffc7I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U4fkgm7Q; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cu0ffc7I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U4fkgm7Q"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1605DEC04A6;
	Tue,  7 Apr 2026 12:20:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 07 Apr 2026 12:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775578838; x=1775665238; bh=bAs9po8fSE
	VbQUHXhd/GoNg7b1GHY2T66tCzIxPv+H8=; b=cu0ffc7IxpH8dPLv5HhPgMXKq/
	iVMmMy25jd4HlhTLlehD4dNZa0zR8wI02VsuLsQ3j7fczkHoa9F4U5E3+jSJiChy
	KnzoRZq4oKlHI9RtMZ9bipbCUzYCeVN52YZ9B65SokbrkNTG0cD8S94xE/z3nEiy
	4GCuzdW5sp0/AR/1xjThZbcia9uegud6TRme1W1jooNoQWxfh5Gl5tNGr43z194H
	kvdk633uRdMk1YRKX4U0vb5lUDytt9yWBwC+4pmDuVBea1VGfZeGqxqaGOSmSRD0
	mNkf9Q6gsrWNoScIJu+DGN8CaeBbiGoAFjKxnLfqypOFfeZmxvt9x9pXbE0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775578838; x=1775665238; bh=bAs9po8fSEVbQUHXhd/GoNg7b1GHY2T66tC
	zIxPv+H8=; b=U4fkgm7Qqxt7fK3+1w6MafIxCqH+G/gWYWKalS0N1EkqFh/s1PR
	/otkfjNgo/M5CANST8MYU8wgh1YNBzHAcTzSQmQAuUUbumNYnLYJpSe61BmbnqJ+
	CPAtbb/zleobNT8xFIwyEJwfew4X/0nfN3ENg0KIle9Gb+Lm+NnlTTzWvoNjSDFd
	YiHq0ci9noUuPE/4d9cUnBhZq6dg3LzbOydMnPpTO9onYqJMdPjWRmy2uzJGJ6Qj
	L9D4W66jLTgfUz0MSLcQa9BI8IitkJz1RGyp8FoS7Mmgd4TZacNXOCrvzfH1mI92
	uhI3NdT94anJH32RJs8BLPjmMg9VUpEYLWg==
X-ME-Sender: <xms:1C7VaXw6pE1lTIQSIziggluDkM4cDIBtPAVTvgMQADGLhHGL6C1gbA>
    <xme:1C7VaZpj_ZT1_GU796ES0OHeIZtYW0VX5N2IQuGXJH6XIuHIPjg7M7n6GF4LVn1Ff
    sLfSGZkHPu1NfVF56WyeE00saqbTABtSAFNRs8CrQvcCFU_VvXVQg>
X-ME-Received: <xmr:1C7VaXdkHiKW1t0Dkh2Th3Hr4g8aZDw82F6e8J6OTYaPOOoEVSwI5vU1oGaC-auyegBlL6SfLlAKDMfGE4AWIT0o6o8ZSYHO_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhhitghosegtrhihphhtohhnvggtthhorhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehmshhtrgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepmhgrrhhtihhnvhhonhiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehrvg
    hmohessghuvghniihlihdruggvvhdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehstghhrggtohhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:1C7VacrUTsAlNmkTjlfLFshJVIdTYgLo9y6KvbkbAwrZpSSNf5GpEw>
    <xmx:1C7VaRkbIZ8V06BzQAj2bYjvJrJ-XIYzJNkWo9wE6FKFP-zTpndfPg>
    <xmx:1C7VadRyJ1xpA3_6Hz4JEzqAxUgm1Okd5SlqejuHJ8MIvPsXL4cVRA>
    <xmx:1C7VaXbMScLDVqRiBB7XNxGimNIWPU1xO4WGIzEy7dUzIaV3NK5NhA>
    <xmx:1i7VaXRA2888X-8HEvtohybTyiDEnY0CG-bly4mocIDF8XY1bBt5xka8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 12:20:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nico Williams <nico@cryptonector.com>
Cc: phillip.wood@dunelm.org.uk,  Matt Stark <msta@google.com>,
  git@vger.kernel.org,  ps@pks.im,  Martin von Zweigbergk
 <martinvonz@google.com>,  remo@buenzli.dev,  Edwin Kempin
 <ekempin@google.com>,  schacon@gmail.com,  philipmetzger@bluewin.ch,
  konstantin@linuxfoundation.org,  newren@gmail.com,  tytso@mit.edu,
  rikingcoding@gmail.com
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
In-Reply-To: <adUoR/T17fKr+YLN@ubby> (Nico Williams's message of "Tue, 7 Apr
	2026 10:52:39 -0500")
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
	<xmqqqzor76nh.fsf@gitster.g> <adSO6zPwtFOWBcOw@ubby>
	<68e5a1eb-ec7b-43ca-98d1-ffdf7fef013f@gmail.com>
	<adUoR/T17fKr+YLN@ubby>
Date: Tue, 07 Apr 2026 09:20:35 -0700
Message-ID: <xmqqtstm68to.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nico Williams <nico@cryptonector.com> writes:

> On Tue, Apr 07, 2026 at 10:55:00AM +0100, Phillip Wood wrote:
>> On 07/04/2026 05:58, Nico Williams wrote:
>> > 
>> > Maybe that's the trick: local configuration for determining the
>> > copy-or-drop semantic for different operations, and maybe hooks for
>> > altering when copying.
>> 
>> I think the danger with making it configurable is that you cannot rely on
>> the semantics because they vary between commits created by different
>> authors. [...]
>
> Well, I said "site-local" and "for some definition of site", and the one
> I had in mind is that the upstream provides this [default] configuration
> for clones.  Sure, authors could override this locally, but presumably
> they wouldn't, and presumably upstreams would check for adherence to
> their rules.

This does sound quite sensible.  What you called "site", I called
"project" in my earlier responses.

Some projects do already check that the changes are signed off with
the "Signed-off-by" trailers.  If change-id or original-change-id or
whatnot are deemed essential to a project, and are expected to be
formatted in certain ways, the project will certainly validate them.

None of that requires us to hide this information in the commit
object header, by the way.  And indeed, it is easier to validate
what is in the "git log" output (where optional header elements like
"encoding" are not shown).


