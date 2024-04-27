Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21D10E6
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714241892; cv=none; b=faet3atkarny6koYDQ5cnEvroG4OgI3nPFrupGAiERnyfgzuP14YiVLRm3+7APTvyg/IBnjsag7IC/+WAuKxRCUxIdmhjBfSMF+YR+iTEVfHU47r7/zH5UTAPic6so8Mm/nLJJcJiogIDp2PaiB60r5Q6b9tbzR9n0yCuc8alwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714241892; c=relaxed/simple;
	bh=CN9zR6dh147CT8xCHMILqbcWVHIaooy6rGi0x09tXgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YWDffv72gTS32nkqekvc0qNaYxUjBXAZvHo7bwWzRJD8QQqgugmkcV3mEa3qvh3iMuPok4320sqn64Q118b/rZBGrV+OdD5woFX8nSxrG2Fd557umL+XMIhxKtbV6qs9FUg16y26cA00X96u4QyywhJEjUlZdNx5Nw5Mphzm/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=S2FcUum0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S2FcUum0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B9752170B;
	Sat, 27 Apr 2024 14:18:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CN9zR6dh147CT8xCHMILqbcWVHIaooy6rGi0x0
	9tXgI=; b=S2FcUum09ByRcDIA/Ecv/6Cx2lNJ4Hjqg3lJcVBy9I07HWnmh8StFY
	ImC3edkzuCmf8DX1NkbI3tfVP2okmA5Vut+U9c0eeoNxyqdjmrxgM1mBBwd4tdUd
	dtJN3AoIeN3x2oW9r52uqKThpwy8PxVxuPyMpoublZHcMl++PJ4eU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63B7E2170A;
	Sat, 27 Apr 2024 14:18:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B708321709;
	Sat, 27 Apr 2024 14:18:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v6 2/2] send-email: make it easy to discern the messages
 for each patch
In-Reply-To: <xmqqsez64r4d.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	27 Apr 2024 11:06:42 -0700")
References: <cover.1712732383.git.dsimic@manjaro.org>
	<c78b043b5a6cf0de712d36e6e000804bd6e1316d.1712732383.git.dsimic@manjaro.org>
	<xmqqh6g9w5bf.fsf@gitster.g>
	<7dcc6f23cc7cb823cb19ec63c69c60e4@manjaro.org>
	<0216a0e8369b8a3592dda90e5680be31@manjaro.org>
	<xmqq8r0y66ub.fsf@gitster.g>
	<d4d63b9f3c7692bb48ac3e7ac34b663b@manjaro.org>
	<xmqqsez64r4d.fsf@gitster.g>
Date: Sat, 27 Apr 2024 11:18:07 -0700
Message-ID: <xmqqo79u4qlc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7FE54458-04C2-11EF-9912-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Well, v1 and v3-v5 saw comments only from me.  There was a comment
> on v2 by Kristoffer Haugsbakk about phrasing in proposed log
> message.  v6 had Eric's "Meh, either way".

FWIW, somewhere between v2 and v3 may have been a good place to
stop.

"After calling send_message(), give an extra blank line before the
next message" was extremely easy to see why it was a good idea.
Mixing it with "oh, during the process of a single invocation of
send_message(), there may be other places that want extra blank
lines" made the changes less focused.  Personally I lost interest
in the series at around that point.
