Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3686AC9
	for <git@vger.kernel.org>; Wed,  8 May 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180309; cv=none; b=dcWRhRJZY71y43sRlY2WRUVZElb7wuA4CZ64ISHnW5nm3jQymq636LNy8mPfi4YSR3UBh+zHqujwdybk6aXwHQfFZn2aCL0AXgHzB1plpDy0MzCHQJ10WJIHD6EfTPltarV3MTVEHTRTGyx4hDIg9aBuazpR3NWK8mpWOeo6Apc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180309; c=relaxed/simple;
	bh=pDLI4Z2tmWKC9O1Ee6ORalf7Bl9YX7wjW32nOxQ68hI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=toTa75TqfpkTamXqaSQbgtEnMrna0vO3Hc/IEEOtaq1kiTPYWjWVGBGWCc/atwkXSa6kAQQpOC21uQqe7SXDCUtSSOJx2di4D6cNCx+fQQapUrMs6pMLjzxBnEgpJqRbSkqvZFGlD4RJO/PEm0QWo40DzciGLCUn1oe4Mya/dsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CINbxt+g; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CINbxt+g"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F070A32A3D;
	Wed,  8 May 2024 10:58:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pDLI4Z2tmWKC9O1Ee6ORalf7Bl9YX7wjW32nOx
	Q68hI=; b=CINbxt+gIr0qcUoPrtyFTUC+HlcdNfsTR7oHZJZtdyupSzV8QJQayr
	MnQWX1zKLRwFHxAhvI1rqGdu3u0VtCZ8T2/IzAuFPFrLnjHPfnXqoNGsu9MxgaSc
	wrYHifTtPf/AVn7/MUnRo/SF218d4kpa+w/4WNZwjPGMV/vMU74LY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E782732A34;
	Wed,  8 May 2024 10:58:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D54432A33;
	Wed,  8 May 2024 10:58:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
In-Reply-To: <ZjuEMNsw-KARJjwx@tanuki> (Patrick Steinhardt's message of "Wed,
	8 May 2024 15:54:56 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<xmqqle4lnuvy.fsf@gitster.g> <ZjuEMNsw-KARJjwx@tanuki>
Date: Wed, 08 May 2024 07:58:24 -0700
Message-ID: <xmqqy18kxsdr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6BCB1F74-0D4B-11EF-99E3-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Another thing we may want to describe in such a document is what we
>> do not want to drop and why, even when a new way that is a superset
>> is available, which would give newbies with a natural "why don't we
>> force everybody including the old timers to adopt new ways" question
>> a reasonable answer.
>
> Okay, I see how that may make sense for some parts. I guess one of the
> motivations here is things like git-checkout(1) and git-switch(1) /
> git-restore(1)?

Anything that we initially think it may make sense to remove but
turns out that they are so ingrained in workflows that may lead some
users to stick to pre-3.0 version.  As this is a living document,
instead of removing some ideas that are "voted down", recording the
reason why we voted it down would make sense.  Checkout and annotate
are the ones that were named so far in the discussion, but I suspect
there will be more.

> Do we want to give this class a separate name? Deprecated may feel a bit
> too strong in that context as it does imply eventual removal for many
> folks (including me, I guess). Is "superseded" better?

Traditional/established ways that will not go away?
