Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B42264B6
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011547; cv=none; b=THDXjwUytHt5U89CO4VNdxW4BSVtp2ar7EONMBhZpCEEcOva9pZLDp2/+Ec7O4hbTHdOABTzNTlbMBUFse5Tu6nH/6D9dqguOkFAsQ3jzfpXYLQLDXdQ9mM4+1wNNG2aeqexDSuQ6LONc1Jtks1lKak1qeqeehuUdrca+qj79XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011547; c=relaxed/simple;
	bh=R0UUKdgiNc/mJdBHldMormfXTlk/xnnBox8Cf2Wc1NU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mU2rCfnLNqrpDfTUrHhZhdWlTMla2Q4RREmitF0WCw1cqV43hU2oF2qlgbCocLX8p8tc9Mtz67Ki408uGRmkKWSb5GxXd5eYJFJg23NDNEF1HebvsoRN2LdjJPI64ZQUotTONh76vvRfP/lcoiwCkd53yUhp487Qmk8/5YfxZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U217lvTo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIRzxvFk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U217lvTo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIRzxvFk"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id F0F95EC02B4;
	Tue,  8 Jul 2025 17:52:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 08 Jul 2025 17:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752011543; x=1752097943; bh=BXc97sTlzn
	jwwHJHtWoga/x4hROh8gsZJJNMQ1Kv4aQ=; b=U217lvTosDkZXH4ew18tPncamS
	KPWcbIy3j5EvKczQHSOzUauDPJjL8SVVHr103ATOj+IXTA+nRArYEO2VIuxwOE59
	VOQWTtSHuodbC6tY+FK8TiKtlwAivDatsPIJWbSctdVQES9i6RxZv0KhBAT93B0f
	9EGDt6SmhvAwK/+xZLe0prCjD1b1J9oYiV/etIwFz7L7bn4/MrDOuimzLrqgnyjQ
	sqZ/HCZpwee7Yglljk/Y5AkNr3+TiJqIChirXkro5Ssfo5OHkNgcf9vtLPjvHhCe
	OpPwX1TAVIWmksQCVr5BJ6ZJ23Myn4RG9t0GFqf2JBGu/Yuc8KBSN6+kJYMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752011543; x=1752097943; bh=BXc97sTlznjwwHJHtWoga/x4hROh8gsZJJN
	MQ1Kv4aQ=; b=LIRzxvFkZFLADc8LTbDWzi3lP+K7w+6+ztyt3PHeUM+wbXeDCYZ
	sBGGfQeDFvoKgomKWCoqIgrIhfW4MSOTK9tadWfXt9Uz8DM3//BRXmWdVMreLj5G
	HMbTA1nXA25lMiXevYcL66F9xjyACvlvw0ves+pFkwfzIDeW6CMMh/xxG7ZjGpB3
	//uO/PiiNa4xDdbZZM+wUqLbtcEsmlyOr2+BokcPw0eI4C847jSKg2vDJY6rppLq
	966Er8XDQhSyIXPN6GMR6lotxg8+AI4Hk6qJ1X1SrXakhwbjAtW/x56QchAzm6au
	SWBUJ+oJqrlASydLrtwV8i/KyCnQNlNnKqQ==
X-ME-Sender: <xms:F5NtaOFI2_BoBlpzNq0zYqU6kxJGCF4X0ADgqQgWHSuIgZJ1-Lxg8g>
    <xme:F5NtaCk2whL9QBF55eR8I5-tFL3WG5Cr7SeOTD_D2Tn2M8Ckl-pfnDw4aSIDKXPiq
    LVk6Ox-65J2GeoXwQ>
X-ME-Received: <xmr:F5NtaBlp8N2PJCl9jl86X-Et17Mi59h84TBGJ27i91lG_D-lUg5_XuRAtTWgAbk2EayASBXYH8ezKt35LWacwl1XV6FVjmZV2yPzHlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:F5NtaDuxNnlL29wf4CzOgn1fcGXingFRm_PAtXcnF_TOMPMROa-1Rg>
    <xmx:F5NtaEn5eVaxJaSbhF7x0zLrAYcph6dlYVfh8pDvBky5Qq0UfMJvqg>
    <xmx:F5NtaOvDBfMXKk_loSMI70LQFOmKJ_ji4ot4yjWcyl33-yq0n8Fv8A>
    <xmx:F5NtaKdNTHFldrH9oo87ifrNvPJmcw2DMWr5UP8nBsaF7orF7Xv1Hg>
    <xmx:F5NtaKJJ8hyqkyagExzm2_jVB_9FX9LWGevKrOh5OP_mGB7Lb6nY00vs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 17:52:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] refs/files: remove empty parent dirs when ref creation
 fails
In-Reply-To: <20250708-b4-pks-reffiles-prune-empty-dirs-on-abort-v1-1-3bae02e4f034@pks.im>
	(Patrick Steinhardt's message of "Tue, 08 Jul 2025 12:19:54 +0200")
References: <20250708-b4-pks-reffiles-prune-empty-dirs-on-abort-v1-1-3bae02e4f034@pks.im>
Date: Tue, 08 Jul 2025 14:52:21 -0700
Message-ID: <xmqqzfdes63u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When creating a new reference in the "files" backend we first create the
> directory hierarchy for that reference, then create the lockfile for
> that reference, and finally rename the lockfile into place. When the
> transaction gets aborted we prune the lockfile, but we don't clean up
> the directory hierarchy that we may have created for the lockfile.
>
> In some egde cases this can lead to lots of empty directories being
> cluttered in the ".git/refs" directory that really serve no purpose at
> all. We know to prune such empty directories when packing refs, but that
> only patches over the issue.
>
> Improve this by removing empty parents when cleaning up still-locked
> references in `files_transaction_cleanup()`. This function is also
> called when preparing or committing the transaction, so this change also
> helps when not explicitly aborting the transaction.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> this issue is something we recently discovered in Gitaly. It's nothing
> world breaking, but I think it makes sense to try and keep the refdb in
> a as-clean-as-possible state anyway.

Would we lose an empty ".git/refs/tags/" directory if we fail to
create the first tag?

	... goes and looks at the try_remove function ...

OK, we protect the leading two levels when doing so, so we are safe.

Will queue.  Thanks.
