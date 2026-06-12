Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74C3EDE6C
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270514; cv=none; b=nEBt95Nv2OBH7daKdrMaGS1ARoGudYDQee7+3aMmOHCAkH4ainl2mf66gox5eehU7JkZU0IVvffWuIZYNjHzqZBaNCl33v8AYmq6cG/NujMJLPuGOPHaqsm6Vy1MxWFZbENf3AoVbYBFEXTNi+Vl/nysVTUMcm6ayv/Up2UC4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270514; c=relaxed/simple;
	bh=UJHAqzmrja4tY8qIhghwvQFN6anFx/9VnhAuoz43I+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U1VFL/GGw0G25LvNRWa1j0AodM28hx709gXr0SUk3uVdDb0+NalsACZLZpKCKLk9NYsjCA3TqlzHCMZr1JS/f0JrRM3PF8QUgCZSTj1QbVcHzbIg9v02X+M4tnzSra6A9PdbSjtn4ThfTPPZpf1ldcfNQkrsL8MfVvXmIFt7V48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Er/jEyv1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WwwfNupa; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Er/jEyv1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WwwfNupa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FB341D00169;
	Fri, 12 Jun 2026 09:21:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 12 Jun 2026 09:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781270511;
	 x=1781356911; bh=Smr6DxWLnsGlVZiubxfC6ozz6P4R6fCmI89kKjqo36M=; b=
	Er/jEyv1RRTVLj8ChqDMefHgLB34vXXCGVRgmdN+4WGPaCRhOag8I3GejxNpg7lL
	jk3a3XVH77h/Ye9Cg1BpnwY7IbMx6vIoBV7aEoG0+qiC24hZRjCT3y8BX+aj8lOL
	u8ra1y10+N1Z/olG+NY+tssMSSi38EfwpZUPCQ7ZAuFCIsoZuHD9flWjXBdNvS25
	rZ4/p4lU3GN2EP9OHUnXSqBYtjW4SbXIU4nMPf1nNT+21OhaduJIz1JDcdybY0zJ
	HTwOhBVJkae+WgfZOOQEAc7p76tmrg5Pkm3QODMMTX5/IdlJGEhXOWDCUk9YCuee
	Q5GPMj4lVBE3m9D1a5rCrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781270511; x=
	1781356911; bh=Smr6DxWLnsGlVZiubxfC6ozz6P4R6fCmI89kKjqo36M=; b=W
	wwfNupaGwJjFV3SKFDvIwrbMrMnMs4YlORscIfxYKaFNRUDj+huKgHxUV6vRrXhY
	T/jEEygPX5ypeXWcB469EpDnaLKWjUrNaw5bK6pkjQ03XRfyJZjwjt+EzNkF9Q7z
	25NhMxehvLnIqHSDRluI1r/zG/iQGL4TdY1qSamyfA7UG5UWG4OinItbYcl+MxUE
	aXgVkMshUhpQFVfZjLRx7LnV4qG0ryggw6lCD81bayGzlZw715DvQmbUi9rMPqJv
	kjkJ02XDAK52cMgSjIqY7SA+UjRoLGD4b7bA2FL0Cf1xnV5yFMUquk8c2HUGrGa8
	96kxNMOQPi9Unr+4c1Weg==
X-ME-Sender: <xms:7gcsarqW0F-ljdbakfeRn-3XNTrbSbWNWecMnA7i5FhUW_kSa6h6bg>
    <xme:7gcsan5NgXGW7OPuSCL6HCzttbvL62M0S5_-tbc0BliAx9HBrCBDlUwaAS1uftfqd
    o5L5HblV2HkOGdcrqm6elvNT1UIsz8ueKxD-BAKFwN09onnfGN07Q>
X-ME-Received: <xmr:7gcsaqcOGR-nDyUwJ5nSrrUaGh0e0sGVSkVc4RvCPI1VIF9EP-BR10jzoESTlFfUik5M8Yh9ixX-h9D89XA2ckGvdzVQHRL105by>
X-ME-Proxy-Cause: dmFkZTGN+Ycp40sSk+g2pPUjd6MIng6wciEc9G17aiKwdJZFEM0PsNh1GSGL8U2GQ3fL4T
    DEdlFuXb5VM57ji05eitQQyRFyV0FTDEui7N1l2lS91PpFpiqFWbLx/Pgxj1ZoSMVjU1Vy
    9JJlKT+Id1JO0LWYClemVHsgBDk/7ZPzS87Kg5XXcp9Y8AT7T+9jxyefwHZP3dCRBupDXi
    B+saKTh2YZgTYt8hD+ou2WutKInXiK4DB5VK26KVIVq9ZpQINC4gC7vH3rckjnuqIV+zWg
    P/VbB6ZPN2ZVp1zGuGMDG3hUCkJo6Jqo+ykeBZ3LmReHTwsSHYFx7hvx341CeHId1AOqOI
    2QOfS2Jznig/mKqgyHvlh6btkdy8gzAVOLkQ53M2Bbo8w5GQsI/LV38e7Z4NZGmdglNs5N
    t8dHYDH5aMB4u8tJMwq4wKi6hiqcPmEue+eZ9Hox7g1qrn2BRETtyy2sX5gfweSWUiJ5t5
    XUMnfIuhDKbLm9L6JSvJS74aNGNOHibFUdpSV15ahlBd0XNjmCQ21sCDdh9LdbOoO6mTBK
    bwYi08cugASA5eQmQG3yBAUIjM68UQUfuKaKgMSjPhxB0tsP+4XAxYZzNy/dtz7orxVyeS
    wyN6Y4uCj3jLP6n8hOqZh0ccElzISdTBM3fjJKmKfEN8wFwKzkKqYKzGujlw
X-ME-Proxy: <xmx:7gcsak61eKPXspWrcKlTYmlwDs5-r8SKw4PSGg0OsBH-H75-EDL_Dg>
    <xmx:7gcsapsa5hz_cXvFRiZvoVWtG-gqFZkhqJDyHz-8LPrN1iXZ-f6QsQ>
    <xmx:7gcsasj1EU3stPhr63yYn_rWOoh36p7TaNtbnwuTdmOikwOj0JBB8g>
    <xmx:7gcsasqxsWu1tPmavn5NQrXmgx1sL2F9mcTEepCdAEqutVn2i26_tw>
    <xmx:7wcsaq5UfHHTAwxOTCHztTGBAIwNvRXGl8-pxzdyfjiNao3VjJk9eOk5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 09:21:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v4 06/16] midx: support custom `--base` for incremental
 MIDX writes
In-Reply-To: <aiuaf3fKJ6kIITrf@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Fri,
	12 Jun 2026 07:34:55 +0200")
References: <cover.1774820449.git.me@ttaylorr.com>
	<cover.1779206239.git.me@ttaylorr.com>
	<1bbb387d6b6204045d97882fd8775dbff12dedbb.1779206240.git.me@ttaylorr.com>
	<aiuaf3fKJ6kIITrf@szeder.dev>
Date: Fri, 12 Jun 2026 06:21:48 -0700
Message-ID: <xmqqqzmbj3mb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> +	layer="$(git multi-pack-index write --bitmap --incremental \
>> +		--no-write-chain-file --base="$(nth_line 1 "$midx_chain")")" &&
>
> There is no 'nth_line' helper function in this test script.

Good eyes.  It has been there in the file next door t5335 since
February, but not available here in t5334.

