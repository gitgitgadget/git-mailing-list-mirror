Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B645000
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786666; cv=none; b=R60FwjsEjkDEIZQJdZ6FnMNOstAitZXi0dFcwD4jAijs7Hwdtsdj62JVGSmsmIr3Zj6dtGTsxCRtLWyvE8BBw34EdM07ySF4ikNHlhJdJd4gs0oHDkUKiZtb/EsMi8pIu4BLGttFEorzs1e1wMVinw7K3pnL76jgIiy3OPrv7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786666; c=relaxed/simple;
	bh=xuvKHRs9NpNOdiMuEOCga+V+7gKEvzNwb2yoZxgFHhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RCadk66IoURsBezQkm1JZnl0sNISQN55k8sJsG4eBGCTOhAxU/GFQuv9AV/ggMopMBrc7NC/mxPs7Ty1eEh0nOUpViCVuNpSrqAE++JuOjr3SxsQoEpa7dDZCGxiRnRw/odd4CleEHV3MrXBvf9vuBvFwTwgqfB6jdfd4ReVPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BB2hCfty; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BB2hCfty"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A72A185CA;
	Fri,  7 Jun 2024 14:57:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xuvKHRs9NpNO
	diMuEOCga+V+7gKEvzNwb2yoZxgFHhQ=; b=BB2hCftytNcXFKD13P9LYPKq8l8d
	AyoNQldOT+qikw0KygdS+0IcEcrV3jVv+PMUY9GvIUhUdsmDY32L3nmromF08pqu
	zPokJC8aLjU6dhzRWHnuFrF4EvuubapGJmJTpM35PAMCKzngYRCrOFSfzX+oOl8H
	FyTAZQE5KBx/Lws=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 128DF185C9;
	Fri,  7 Jun 2024 14:57:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E088185C8;
	Fri,  7 Jun 2024 14:57:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 1/2] t4014: cleanups in a few tests
In-Reply-To: <de9d8f38-6e4c-43d4-acc4-a38e860787a7@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 7 Jun 2024 19:38:25 +0200")
References: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
	<14365d68-ed04-44fe-823b-a3959626684e@gmail.com>
	<cb6b6d54-959f-477d-83e5-027c81ae85de@gmail.com>
	<9f520828-f87e-49b1-aa4b-c00ec6bb0133@gmail.com>
	<20b95372-12cf-49bd-b1b7-dc069e7c86dd@gmail.com>
	<xmqqed98ekv1.fsf@gitster.g>
	<de9d8f38-6e4c-43d4-acc4-a38e860787a7@gmail.com>
Date: Fri, 07 Jun 2024 11:57:42 -0700
Message-ID: <xmqqa5jwd1i1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D24D652E-24FF-11EF-8983-B84BEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>> If "notes add" fails to create a note for HEAD, test_when_finished
>> would notice that it cannot remove a note from HEAD, wouldn't it?
>
> Yep.  Something like this, no?

That's following the "grep for them" advice ;-)

>> A failure in the when-finished handler is noticed (which we might
>> argue is a misfeature)
>
> Dropping it doesn't seem like something to be strongly opposed to :-)

It does protect us from careless test writers.  At least, when we
see the care has been taken to make sure the "clean-up" tasks covers
both cases where the main test did or failed to create the cruft to
be removed, that assures us that the test writers were thinking it
through.

But of course, those who blindly cut and paste the "|| :" pattern
would fool such protection measure X-<.

;-)
