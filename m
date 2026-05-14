Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460433AB267
	for <git@vger.kernel.org>; Thu, 14 May 2026 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778788592; cv=none; b=EiH6pyUCUYmTTMAzEbIDwSWhb82wyNwKbkzB8u1ajdbOYGBs8e6ZJn2JjpHEnqm3lmpdxAnehrB5NYjLPMrto/tXCuwLS4/9ZjXGnFbP6Pfn0pHW+em1NVgvPpUxDb31IGnImpfTVp+z9OJbZFtugJfT0KBCWm+TWFOzqFubbnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778788592; c=relaxed/simple;
	bh=+n+0+K9kYEXTyY1MNGxbhpDsPCTVwAIpRxGd3C1WhyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DY9Pkbcq8a6vyt34WyNbEDWb+BKruQJj7BBzrrE9P48yAIymAVfJvNVVj7pRWnnAw8AA7QNs+B4wfx12XAb7jN0OVRSGClcqtkOfGudBcOLhfaiFyy1d0/8em7Ev+8EAjnZKSSql5TUvhBzgIKLHfuc5bNIW8ZZwC62OvlVcU10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QELx+NBG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cKRCNj8M; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QELx+NBG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cKRCNj8M"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87A3B140007D;
	Thu, 14 May 2026 15:56:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 14 May 2026 15:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778788589; x=1778874989; bh=yNrSOzqt06
	G30lLCiPg/K0DyLMkQC2uas+OV2l0LaqI=; b=QELx+NBG+Krgg3vhZUikBZQjpi
	E722NYU9t4wXX/t1pIJc+sqPihvSvvguEi9q2I/mJ/2Wuvg8QJQVBAvdQNQR5A01
	6UnTEIYAMzqBxXVZa1Vxt+8fWsbVC1cG3N1A5ZDJYCL6lVScNVcF2Mp7otGCIihs
	xCh0ksxfJw8Rpdm8c6ZT4aJVvTMP0EkkLnysEaIJzp99bGc4+jnU/TikuV1C4KjM
	TLUeQ+2jEvUmljuo6yPGlw7pdlIYAN1l//HFSVD2d2t1/l7cQYWZMebyBHYOQL3U
	vColz29GR7vBZLjBQE5gtn8yDr1G/gqqxyNbKMkAXqLMU5cO8HNBO9tzk/8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778788589; x=1778874989; bh=yNrSOzqt06G30lLCiPg/K0DyLMkQC2uas+O
	V2l0LaqI=; b=cKRCNj8Mf5zg5weIXtFKHPj84q7B+Gae90TyuGTI6QXWOtrGTOU
	YfsnmCV04O/IugHx+rFew0hR5/ZM6LCqgAOjnzWQCbF8U4NmFuoXTqwJBUkxwrBJ
	YRA86Ri6n4OJWHWQ2pbgcXLaCJHjR6ZVofc2l0OvCyVpu1t6vOUYtUV2rqZtUi9x
	Ixg2eFI5zpdW7iHZgRpIqHKRPHxS6s6kmHhW2us4PiyZITnBvdxKbzbZEC7+fq4n
	UFK6ZlgvHlbwZhKShjqvgXJrnMkcHL4e1tjpFe3gIIbAOdNnWfzv2K22oyXtNTCE
	ouEe6nOZeryT485PGnHiQfsgNicnl2wfksA==
X-ME-Sender: <xms:7CgGahGdQuNbBAXDvtm__PsohzUVprc7M_9Mu5DZN8sUVyE_vhKznA>
    <xme:7CgGavqVEwrUn2LYO4CjPVXWWIpfSTXWobB8uX1D6Sogri8u6KlaBaP8-NY44D8JZ
    gkV3HmJ1loD3U12vxWNFHoGV9idg0WgTOb0iYqkBIN6XR6iCcvcDmk>
X-ME-Received: <xmr:7CgGaqZGA1hwFhQIydk-AWEf3XmNSwyuqpdHvWCP6QGScOgd4ctEQVi7UO2i-gaj8FonjfTfeUDrr4PkkpIuI-HF9S2pVJDFyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgedvgfdvheehvefhhedttedtgfefgeeikeeihfehtddtheevjedtleekkefg
    udeinecuffhomhgrihhnpehmshhgihgurdhlihhnkhdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepkhgvrhhnvghlsehstghhlhgrrhgrfhhfvghnlhgrnhdruggvpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthh
    hrihhssegthhhrihhsughofihnrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7CgGaoVXFg-Xui1jVb3Eju9AR65JLkIC3sQa6fGaQeqev3sOqAvAXA>
    <xmx:7CgGaj84yZGCJfn7PvsGtK43RNTtOg43qYzPfpbMpqW7MUapC-KhfA>
    <xmx:7CgGah-RF1Zs9tOea9O5WHyhbng1paA5dfaGZqUVidA2TTSGBLuNIA>
    <xmx:7CgGajSAQmrP73rF3Hwn2nqk4k0zf2VFOYIMB35T5BZc7-gFBz0hlA>
    <xmx:7SgGaoLQNEPMtc5yjaidmnq5ruuQmbV1iJABIvJDfxCGivOBHUlGXmmI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 15:56:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonas Rebmann <kernel@schlaraffenlan.de>
Cc: git@vger.kernel.org,  Chris Down <chris@chrisdown.name>,  Jeff King
 <peff@peff.net>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 0/3] Avoid hardcoded "good"/"bad" bisect terms
In-Reply-To: <20260514-bisect-terms-v4-0-b3e3cf1b06ce@schlaraffenlan.de>
	(Jonas Rebmann's message of "Thu, 14 May 2026 11:07:03 +0200")
References: <20260514-bisect-terms-v4-0-b3e3cf1b06ce@schlaraffenlan.de>
Date: Fri, 15 May 2026 04:56:27 +0900
Message-ID: <xmqqv7cpepec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonas Rebmann <kernel@schlaraffenlan.de> writes:

> While checking whether all output messages of git bisect were covered by
> [PATCH 1/3] bisect: use selected alternate terms in status output I
> found hardcoded good/bad refs leading to incompatibility of git
> rev-parse --bisect with alternate bisect run terms. This is addressed by
> [PATCH 3/3] rev-parse: use selected alternate terms to look up refs
>
> Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
> ---
> Changes in v4:
> - Always print bisect terms in single quote (Thanks, Junio)
> - Split out quoting of bisect terms into separate commit
>> - Link to v3: https://patch.msgid.link/20260417-bisect-terms-v3-0-d659fa547261@schlaraffenlan.de

Having this "Link" is better than nothing, but it alone is not
sufficient to help those who mechanise patch consumption with b4.

  https://b4.docs.kernel.org/en/latest/index.html

Please make sure that your cover letter of the (i+1)th iteration
[v(i+1) 0/N] is a reply to the cover letter of the i-th iteration
[v(i) 0/M].  With that, anybody who has the i-th iteration can

 1. Check out the i-th iteration, e.g., 

    $ git checkout jr/bisect-custom-terms-in-output

 2. Peek at any of the commits on the topic branch with notes/amlog
    e.g.,

    $ git notes --ref=amlog show HEAD

 3. Check out the base, e.g.,

    $ git checkout --detach master...

    Note that the branch that holds the i-th iteration can now be
    accessed via @{-1} (i.e., the branch previously checked out).

 4. Tell B4 to fetch the latest round of the same series, by giving
    one/any of the message-ID we learned earlier, and apply them.

    $ b4 am -o- \
      "<20260417-bisect-terms-v3-2-d659fa547261@schlaraffenlan.de>" |
      git am -s

 5. See what changed with range-diff

    $ git range-diff @{-1}...

 6. When satisified, replace the topic with the new iteration.

    $ git checkout -B @{-1}

It is crucial that b4 can find the newer iteration when given a
message-ID from the older iteration in step 4 for this workflow to
work, and for that, [v4 0/3] must be a reply to [v3 0/2].  Otherwise
b4 will say that v3 is still the last iteration and we cannot make
progress.

> Changes in v3:
> - when referencing newly introduced terms, reference them in single
>   quotes (Thanks, Phillip)
> - Prefer test_grep over grep in updated Tests (Thanks, Phillip)
> - Improve commit messages (Thanks, Phillip)
> - Don't leak memory after read_bisect_terms() (Thanks, Phillip)
> - Don't leak memory after xstrfmt() (Thanks, Junio)
> - Add test case to patch 2/2
> - Link to v2: https://patch.msgid.link/20260323-bisect-terms-v2-0-8d6bdb2c9c7e@schlaraffenlan.de

With these improvements, v3 was already in a quite good shape, but
the latest makes it look even better.  Will replace.  Thanks.
