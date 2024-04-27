Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91734848E
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714239724; cv=none; b=CLzY7U0SOQPsenf61MMWcMkSZgmrANBIydwiz5azR/2KnfJkOVaS82oN0k+OMoh7wTTuUcQZbOI3tpQ1zWS+O52CG0sAYF1nQocPv2EW8QU21/llVEBtbTRbe96q1QSzhDdFjp3wOEGhdbsOouLRhroubUFVq2yDFFlb3DFXyXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714239724; c=relaxed/simple;
	bh=vTYgSRMk0VOPZsr/CMmfQizvxp7ZRqXjyRwgM6a5cSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LwVB4fl0gYks1zj5sH+OXWLW0LAbMUx/WY6p2dgFGUto3TQduqxuM5nsN1AisSOMSsMti3gQzyRIon8OXeUDtwWJLuNhSOeD/EvkHUDGM1ItMEhngEQsX9jMq6meVTOEAt/D2HDkERCPFh0Lx6zGvaDnivqmv+2ZiZvGhiI/fKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=F+ChK37U; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F+ChK37U"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C450F26BD7;
	Sat, 27 Apr 2024 13:41:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vTYgSRMk0VOPZsr/CMmfQizvxp7ZRqXjyRwgM6
	a5cSI=; b=F+ChK37URqRjcQANkRUzm3bRhd43lUg+rVz22ZUCC+QiwtkHoYuwkP
	Qy1LxrpNFIFlB+cXbuLMxdeAce/9lGmTv2JB6Ajj+ikHjHg2FI683Hg+0O1wznkU
	EeBq9C/6x7utu1AHdv38POidQhIDy/Oqg4VqqgaRXhsLmvJSW1BpI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B16A926BD6;
	Sat, 27 Apr 2024 13:41:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5870C26BD5;
	Sat, 27 Apr 2024 13:41:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v6 2/2] send-email: make it easy to discern the messages
 for each patch
In-Reply-To: <0216a0e8369b8a3592dda90e5680be31@manjaro.org> (Dragan Simic's
	message of "Sat, 27 Apr 2024 19:27:26 +0200")
References: <cover.1712732383.git.dsimic@manjaro.org>
	<c78b043b5a6cf0de712d36e6e000804bd6e1316d.1712732383.git.dsimic@manjaro.org>
	<xmqqh6g9w5bf.fsf@gitster.g>
	<7dcc6f23cc7cb823cb19ec63c69c60e4@manjaro.org>
	<0216a0e8369b8a3592dda90e5680be31@manjaro.org>
Date: Sat, 27 Apr 2024 10:41:48 -0700
Message-ID: <xmqq8r0y66ub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6D795E4E-04BD-11EF-9746-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Just checking, is there something I can do to get this patch
> series moving forward?

Get it into a shape that is more palatable to people?  That's easy
to say and hard to define X-<.

I didn't see anybody enthused about the change, and I didn't get
enthused about it, either.
