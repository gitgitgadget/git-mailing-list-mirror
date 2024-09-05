Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66690187FE9
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561769; cv=none; b=EpMZeSnxnasZeCNXJWExSNVD9qnaY+BNfsRW5Ak5nDIQ1mm4avL7bQg9LpwWGCdMoVfHbQabTMZX1n8Zsl2lTXv/hCtejM9ATCaZP9BFdLKcvuJ6q6X8si82SGVtzkjREXZPyZBaZ49UE4R6yEfx0SF8vKiPTamBGYUQPLxYKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561769; c=relaxed/simple;
	bh=Q6u21rFMQ98TUQva9G9ZJfG/EGnAXFUY/JFndTvV1Z8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Don16OHVHOWZdBsTPVeWGsHAm14QhK8SrL0PQm9IZmQNb1nBjYT9YfjgsbEV5JeXO9qBEYl1o3jSiANHk5v8Y1akcdZwX9S1WBopstqI0l/pYt81JBpp8W+ts5Ao60MKQi0GYqPRel7HPlXCMIbmU1kPH2g8r7Yl1xqGIRWew28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ul8bWJJm; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ul8bWJJm"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 500B62DFDD;
	Thu,  5 Sep 2024 14:42:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Q6u21rFMQ98TUQva9G9ZJfG/EGnAXFUY/JFndT
	vV1Z8=; b=Ul8bWJJm7Z4Seu+vNK+SCl2MtkoZ9unDl1fv7vwrnt5qXtt+zSKQZU
	61dwkMQyBymhT/202ZD9JohG8esRYKzoFa4+YLuEo+sokWL4YBuKl8KdNsJLlsmD
	eOT6fgpH4+8g/dgC3FDK0GJCbwie/yf8TFTQ2TV49w864TMsSrvus=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 471CA2DFDC;
	Thu,  5 Sep 2024 14:42:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AAFF32DFDB;
	Thu,  5 Sep 2024 14:42:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 1/6] t: move reftable/stack_test.c to the unit
 testing framework
In-Reply-To: <ZtnHoNYbBh0Gkqza@pks.im> (Patrick Steinhardt's message of "Thu,
	5 Sep 2024 17:00:48 +0200")
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
	<20240904150132.11567-1-chandrapratap3519@gmail.com>
	<20240904150132.11567-2-chandrapratap3519@gmail.com>
	<xmqqmskn9w3o.fsf@gitster.g> <ZtlafDnM-geVUTQ9@pks.im>
	<CA+J6zkR35jgmCuWniqDBBcTOW68V3Kzn1x8Yc5PZLHxO_cPtaA@mail.gmail.com>
	<ZtnHoNYbBh0Gkqza@pks.im>
Date: Thu, 05 Sep 2024 11:42:45 -0700
Message-ID: <xmqqseue0wnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A4F08C98-6BB6-11EF-A897-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Sep 05, 2024 at 08:15:53PM +0530, Chandra Pratap wrote:
>
>> Should we get rid of reftable/test_framework.{c, h} as well?
>
> Ah, yeah. If it's not needed anymore we should remove it. I have a patch
> series pending anyway where I deduplicate some of the functionality that
> we have in multiple reftable tests now.

It is unclear if you are saying that Chandra should do the removal
as part of an updated version of this series, or you'll do the
removal with refactoring in a separate series and Chandra shouldn't
worry about it for now.

After reading your message three times, I am leaning to take it as
the latter.

Thanks.
