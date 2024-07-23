Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24413C691
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721765605; cv=none; b=ByvUIHieUztasSIAbt8HBEOqsTA9j/HMZlFTcmE8J4G1+bArwwyMmeLvOWVMqrJCyMeEtTcFadtFoek/rLq8ngljWVhvrMS7S8CegI2ptTm92zKGEeLi0FT2d5Y5fVrTzXOkqF+JjDNTXKQaaiSGiNCzrs2gEXCPxVDRrxryu/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721765605; c=relaxed/simple;
	bh=hZ1UsIMyIcLrAzo2SynBouVmu02X9in+HN9b+YO8z3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t6T6IQmrfT8FWjRK+XgoLZ4B6bK11OgiEce3rxmgc70Vz1bcwKFvhlon3zPnMSNhjgkErvuzJ486Fo1BYMExslqqCfi3loW+26d6lkLzclYUVhvIaOWJgv78zLy2BvBIirZ01dzgSN6N2n9L3YHAqL8jHEtZpT1hKRPWZGEXd0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oFxUO6nV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oFxUO6nV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E59601E9EF;
	Tue, 23 Jul 2024 16:13:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hZ1UsIMyIcLrAzo2SynBouVmu02X9in+HN9b+Y
	O8z3M=; b=oFxUO6nVtQe94eQX1hNrYgrticILWNJB8WrNVeYE+5viCDpB864skz
	A+brDt0RxmquTJoDNaaJqaQ60sD1+WvL/TvyiBv1YhrC7NId0GRz6yuyuViTD45G
	7DWfY79Qg006JEiq1+nlJqDdkJKWmQFI3I7pATLWP0npQXAHZomeQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DC7AF1E9EE;
	Tue, 23 Jul 2024 16:13:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50E4C1E9ED;
	Tue, 23 Jul 2024 16:13:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] refs: fix format migration on Cygwin
In-Reply-To: <6a4737df-16a0-4337-87ce-7ec11b40255d@ramsayjones.plus.com>
	(Ramsay Jones's message of "Tue, 23 Jul 2024 20:29:11 +0100")
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
	<d031aef5552d894784650a8c6580925e877df794.1721731179.git.ps@pks.im>
	<6a4737df-16a0-4337-87ce-7ec11b40255d@ramsayjones.plus.com>
Date: Tue, 23 Jul 2024 13:13:21 -0700
Message-ID: <xmqqcyn327fi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 02A61B04-4930-11EF-9D67-BAC1940A682E-77302942!pb-smtp2.pobox.com

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>
> I applied this patch on top of v2.46.0-rc1, on both Linux and cygwin, and
> ran the tests (just t1460-*.sh on cygwin, complete test-suite in Linux).
>
> I can confirm all 30 tests pass on cygwin! :)

Let's merge it down through 'next' to 'master' and have it in the
upcoming release.

Thanks, all.
