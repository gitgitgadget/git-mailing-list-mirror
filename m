Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E87F
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 01:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720919950; cv=none; b=ZZoVZJP7l4/tNDVjFxRP8WB9zs85KBPEaoOUK9KrpsbaWlHe5UcdSJvBToqcAIkLfVe3W1YgywK+AISz0YoN5b/qAy/MPFyWms/Mrl0GQ5JGoD+7vaxF6NHLuqMiPXbXAndW6HMmxPjoKHGWeBk+6bUnplv5F+aQkapKardGn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720919950; c=relaxed/simple;
	bh=BthENAs80j2ryMlUGtZblj5wCKuohrpbcD+xhjPD8pE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=itS8v1+qUiOymHIyDMbMRLrXctiMAm+8doIC24q46Ob2xP0PvC1k1rPLZG1TAfxxKO6M6FwHsiEwp2DXUhd70phYvvn8D/DR9DJGSeQFP9x+K83/a5Qx8KqoMEIl3yWgY8GuhNqVyxOUHmoJAVld84of5gF25m9r7GPeZDGVY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fqY/OcdL; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fqY/OcdL"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F8841D691;
	Sat, 13 Jul 2024 21:19:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BthENAs80j2r
	yMlUGtZblj5wCKuohrpbcD+xhjPD8pE=; b=fqY/OcdLzqZRoctDM4ywXLv80Gh4
	2eHUUaMLOx5qvD3gWwQLVP24Ke5/4ZhRi5ZQ8oc+h75rG/oV+NwSz8iiYmTjsuNc
	Nk+4t1dN7hqNozieqNNcS4158CtNxE9VmxWg39RqrUhguN/C7V5/ZRNgd09yk2RF
	8kiqJneED96VcRo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3E1481D690;
	Sat, 13 Jul 2024 21:19:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7B6611D68D;
	Sat, 13 Jul 2024 21:18:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,
  Jeff King <peff@peff.net>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/4] use the pager in 'add -p'
In-Reply-To: <ec13ed8a-3ad8-45d0-9120-2f5ddabc14fc@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 14 Jul 2024 08:21:28 +0900")
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
	<ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
	<xmqq7cdpb4op.fsf@gitster.g>
	<ec13ed8a-3ad8-45d0-9120-2f5ddabc14fc@gmail.com>
Date: Sat, 13 Jul 2024 18:18:57 -0700
Message-ID: <xmqq34ocbwji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0C5372EA-417F-11EF-8154-C38742FD603B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Ouch. I'll fix it.  I think I'll go back to "head -1".

I think "head -<n>" is deprecated, too. =20

Say "head -n 1" probably, if you really wanted to take the first
line and quit.


