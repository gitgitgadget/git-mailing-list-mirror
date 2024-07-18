Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37573186A
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721278346; cv=none; b=NYQY3yHx2VMqyWspfsg8HLXKpoB3l91GRKi4RUM1EKd2qML+T2PXLBSh15vJkXP2aENa/RSlZkTKZ9Zv1BNfCvjaFdkQhgJAVYjs4uAF4qw1E22GdrmV6EHjmaUNR+hzmdXgKnTBvw2W700L/bbAv5TZNTINv5Q9fE2hEv3upzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721278346; c=relaxed/simple;
	bh=6QIV0sQYLtZ6J7syF0Xl31VUC8jqBlbAIEGroWK1gwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XMF2gihfP8bYGIY1bA+mqyp9sp7+zOGm1lan5p4dsCa1CznkTpBkaUJpnZqjvF8+H5VTYFeNZ3sYFotgBNU4QwEluXYljDx8xcJWyUZpWCm1Df09CprxHs869vuGi4kmjjaLPs8yFkt6fkBNuVoL96LAmYsGSdEBUCd9YawEKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L9sR1+4v; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L9sR1+4v"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C13AA39BCB;
	Thu, 18 Jul 2024 00:52:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6QIV0sQYLtZ6J7syF0Xl31VUC8jqBlbAIEGroW
	K1gwQ=; b=L9sR1+4vf85qFzqEJ1sUKxIRfOuANNiGAtYYMI6GYTsT3DQzYUgDui
	JBRL39DCP5s2X5TCqXGau0L+VuYFGJN3EyS2TYvNtzkuWigIaZka16pM7mnL+KzH
	w5K8iVi6EsQ2PfFELM7O1dDCfudnfc6v1+dxNxaL7xHMbsO1tiFMU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B9A9639BCA;
	Thu, 18 Jul 2024 00:52:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4573F39BC9;
	Thu, 18 Jul 2024 00:52:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Jeff King <peff@peff.net>,  GIT Mailing-list <git@vger.kernel.org>,
  Patrick Steinhardt <ps@pks.im>,  Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: v2.46.0-rc0 test failures on cygwin
In-Reply-To: <f97198e1-bfcc-4f3c-ad0a-2dd27d4f20cf@ramsayjones.plus.com>
	(Ramsay Jones's message of "Thu, 18 Jul 2024 02:22:30 +0100")
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
	<20240717064241.GF547635@coredump.intra.peff.net>
	<3e6abe6c-2c15-47f9-89e8-3e8710802562@ramsayjones.plus.com>
	<20240718005723.GA675057@coredump.intra.peff.net>
	<f97198e1-bfcc-4f3c-ad0a-2dd27d4f20cf@ramsayjones.plus.com>
Date: Wed, 17 Jul 2024 21:52:18 -0700
Message-ID: <xmqqh6cn1ev1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83D5F2DA-44C1-11EF-8B63-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 18/07/2024 01:57, Jeff King wrote:
>> On Wed, Jul 17, 2024 at 07:05:43PM +0100, Ramsay Jones wrote:
> [snip]
>
>>> I also don't know the code well enough to answer your question regarding
>>> the re-opening of the migrated ref-store, but it doesn't look like it would
>>> cause any problems (famous last words).
>> 
>> Thanks for testing. This is new in the upcoming release, but I think
>> it's localized to the "git ref migrate" command. So aside from the
>> annoyance of the test failure for you, it is not too urgent. I'm tempted
>> to put it off until Patrick has had a chance to weigh in, even if it
>> means missing the v2.46 cutoff.
>
> Yes, I think it would be better for Patrick to take a look. I added Adam to
> the CC list to keep him in the loop (because he is the cygwin git package
> maintainer); he may have a view on the timing issues.
>
> Personally, I would be fine with a post v2.46 fix, but it is not up to me. :)

Thanks.  I am inclined to postpone it after 2.46 final, and not to
disturb Patrick during his honeymoon.

