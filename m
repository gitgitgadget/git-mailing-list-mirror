Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A7D13A26F
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027633; cv=none; b=jFRUl8cnO1DWBYTx8iJjN/v0l/JCiCndwhJ3VCWejWzlhFRlpTy4UDohYhRd+0zywVqv1soojnK3aSTvBropYdF3vRPVPOyUTJTgtpJNq4X4aPXJmDpFuFh75g1h7PwWI9oKJXLmrvDjnv1qNsruycjcCR+DXMhyTMSJSYPnIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027633; c=relaxed/simple;
	bh=lmgIN5KAuAlZYGJ/wbRi6sYpHmdqDdjDhYie+3IXzK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pNtEE5PAJUT2/N+hoCRxcxEHAOacZF4Lu84lHSxOLWZUtcWUHE7cSGtz6knmxXXtdAnO6UUP0m0SQBve009n+IvXndkG4TNQXYvFyb0MOYGgSRRXwUu8nNMTLazJR3ccnfTwc6LidM1sReiIcQ9UWNzmg3WOg2uhtjdqHEHKuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EyR4WSTL; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EyR4WSTL"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A9C329410;
	Thu, 15 Feb 2024 15:07:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lmgIN5KAuAlZYGJ/wbRi6sYpHmdqDdjDhYie+3
	IXzK8=; b=EyR4WSTLcBCvJQbMQ2UcLg1OMAsSDQ0h6PxAjC26GiBixnFA1DN5+P
	xjKWA43C6Qmelk4MnMkfBZF/GIuOB+Y4qQGrHHOQxrUicp4dCc599VluNic08hxJ
	9xJcw751kldepXK0uXrWFc8rOCSUakYXlhOK4ayASQZO4Z5w40NlY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 425012940F;
	Thu, 15 Feb 2024 15:07:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CFFC42940D;
	Thu, 15 Feb 2024 15:07:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] use C99 declaration of variable in for() loop
In-Reply-To: <CA+EOSBktLGnzi+DjOTVv9_cVNsM_fjEKiF9kWnaYrGtvGJ-Kdg@mail.gmail.com>
	(Elia Pinto's message of "Thu, 15 Feb 2024 19:56:40 +0100")
References: <20240215094243.147057-1-gitter.spiros@gmail.com>
	<xmqqcysxskd9.fsf@gitster.g>
	<CA+EOSBktLGnzi+DjOTVv9_cVNsM_fjEKiF9kWnaYrGtvGJ-Kdg@mail.gmail.com>
Date: Thu, 15 Feb 2024 12:07:01 -0800
Message-ID: <xmqqmss1pk4a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C8C7CE4C-CC3D-11EE-93C9-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Elia Pinto <gitter.spiros@gmail.com> writes:

> Thank you for your reply. I can understand that, clearly. However,
> this means that extensive code
> refactoring contributions are never welcome. I am not saying this is a
> problem, but just an observation.

Such changes can happen and have happened when the benefit of such
code churn outweighs the cost of reviewing *and* cost of updating or
adjusting in-flight topics that may already or may not yet be in my
tree.  Coccinelle-driven patches that can be mechanically reproduced
and whose validity can be trusted can be one way to reduce the review
and maintenance cost for such a tree-wide change.


