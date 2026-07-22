Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4D4317D
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734568; cv=none; b=u/WZUZGz83QlDETwMAB7qeSPAzKuEuLfWKm7g/SUuh0c4E8wUKMCNkPtd7irL3No7uCMnIRMNdX9TCsuUmGv6yzE8YnB6M1qW+e31AsDGyC9hxTluD0jya0mOKZYAqzE6oWiPrEG/nnii7affS65dt2IPN8VlYtlKiGhBL+OFYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734568; c=relaxed/simple;
	bh=wukaIQCPjlPG0T85xRSLKQhlk3HJKsYF3LCkd/5Cla0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R59RyPYrqu9AGCfb8YOS8LVkdGbY35xbPHx0aXnoQZPlgi2JpE9TP/7x6kqSMQRra+vfeRN0RpDohgWvvpKLeMhZjNL1RzD9ZvgErHxhLVL7+v/vehLlHi10F2wkEXBklM0USm58/Kqqa4VuX/H5vQEj89fkXqTLf8JcnGaLdqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=azs73qCM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XVXjabYv; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="azs73qCM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XVXjabYv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA7881400120;
	Wed, 22 Jul 2026 11:36:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 22 Jul 2026 11:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784734565; x=1784820965; bh=UcmnndA0qV
	ZuTDOTwhhalQ0LIlLKrHtNZoHNtIQqgaA=; b=azs73qCM4r1Z/rAm8410GSOfyy
	SJGQ+oTNfFJzXUmwDhLPTfZpJ+hi5fVdmGMXFoE/Z9L4rkH+emYWVRGwBjfYFSye
	hfLE6sUtEGuKK6b3bZe+Hvlftle48M62NDcyq7sZKbEyjJxHAIa8X5CyGGMP9eo5
	oWO6vkEHZwCayV6+RXuRLSdw41RidY1JyrSRrJEr3B37eT/2MinOEL+PXx7nz23g
	se+uIc4oOi8FV6Znm96TjSJKd31mkhayBUE4mu4ehuqwXbq6zDpAD3WHk8zE5QYo
	2CaWfksYStDnHA6p4YHo1Ix5KHC/Hq7t5mQwp+kTBC04QPBETiKuLg/+62Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784734565; x=1784820965; bh=UcmnndA0qVZuTDOTwhhalQ0LIlLKrHtNZoH
	NtIQqgaA=; b=XVXjabYvzx6NwTdcw6hWKTp9k1VHaE2Ef32B17eys7ZJdAlwncb
	xZwTUyC5aVwS5Y4t14CGgrvxVGY3kw4Tb3j4qngmPdWH34ITQVt6019rnKOpvxX5
	Z2eeusYWb/MOspVL3tHwI6omnL7zP/8pmWFakVv3NepMMEBtKTJIVCRtjMwkSTrQ
	tVouy0Bza3r1c4/OqfpkGjy5jBnIaSig3682y3Ti4XAgI1mIRM3CZZwhYYqs2zDp
	6D510U7wIkp4rKossuQPCF42S6kDKE1PRTYFZQI15C1weFnzcxwU9hheIr0WnC4A
	SzJhwpH+C7Mdh8fbbg7NbuPPahYtu0y9+Rw==
X-ME-Sender: <xms:ZeNgaoW5ui5kZ9qalvOErKsel-WJOwjnBzy7mG0t8QcDcJX50UrCDg>
    <xme:ZeNgajk8-WdJsICioj7dK3d4x5BdSzJFLyiorz9XYPai7gDcm9Tqg2H30suRg7SCn
    ZJNqWcEljRecSjRsVC6M1MIqmrCVWk3uW0Qfofudz07nO-qj2VmC40>
X-ME-Received: <xmr:ZeNgahbor5EiXyC96PSm_3pVd07uVNeh7pawLXCbFMpBmoPScyFXKIrmLKQfLUX6r0tF1sq3Tq1HhoCTrnPCy2YhyxourUxwiw>
X-ME-Proxy-Cause: dmFkZTFC8VWbvr5k1w4o+OtBQMxUT10pT9k9RnAeXiHZ7GrNtsSwRNdh99jnwsA1vZAGKE
    YTrmj1xi3KRH0cdWMGaGMEAdBf9kaiD+kIm025qitXXfBp3QyKO9YvBm4JH9C46+MYKgwM
    asF8zntrTZEx4fPHwkNVt/DhuEltLyDWjxwjESeTrfczeRrBwyxufFAKGmXRC3h1Eg4O1w
    4dmTorbVHc+dizB3au16LIu8X/r2fVeHOyFnGgaMaHbyHjLhCGtlr10XcoPPyrRgl89mh0
    y7j5hsE2xEdmC1RSLeB0q3cntiTTWqsOaYUQLfkpo/FcE3NWlOQCTeyhdQj4u1cIti+rLy
    VK3xbZihJNGzx9RzGgXIiA3rSHDGyrcoVbQXiBhMKE46SsQcTWg/nFscvAzdsPLYyxFNzs
    wptlK/u31kD68O7VkY6P9BP77h/QsQgt148D1Uh/ffnnRhvhP2+VOqnDzvbQcCNns8cnh3
    BjGiJkiw2GS6R0uqtw9QZTnarsoufwXY6tK+hF8UuRzeKHrmCcJYeOvXWsFtBSdA7sBqyL
    SJ/pLjvYLDz8eOjgdauvfhDTigybuXYuPomMVicrDdpaF+masmjsVYiq64EmqOhisOzcXT
    O5HukuLeAAIBaELgYzBqYZRyozzh89faLizs9ln9UZ2DPI8YJ2x8B9Qnz4Qg
X-ME-Proxy: <xmx:ZeNgamOj0fMOt78LR5OVFJuWHSvLSwPs5-VPyrtvgPi1Ym6u6ztPSg>
    <xmx:ZeNgaua4kk83g-fD-kNVPb2AW4atait_ZegNrCpJbq0Eqi3ROnlCkg>
    <xmx:ZeNgas2rNerxJHqjF4qHHMWRxFrnG7yn34OKh2lCZ0dkM3MB67RBtg>
    <xmx:ZeNgasdnG6AqYmQZy2KSfxoo7rJhhRjdf0OzVumuMDnxAInhsZ1eEw>
    <xmx:ZeNgajIgSIKk8z9YksEzRHADIZMfzi36NhUvsJY3NAvyJsPO-lHbKwni>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 11:36:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Hugo Sales <hugo@hsal.es>,  git@vger.kernel.org
Subject: Re: [PATCH 0/1] rebase: add --[no-]edit to --continue
In-Reply-To: <db7edc66-9b2a-47bc-98db-87d01885cef0@gmail.com> (Phillip Wood's
	message of "Wed, 22 Jul 2026 14:39:32 +0100")
References: <20260721140443.1809379-1-hugo@hsal.es>
	<xmqqldb4xlqa.fsf@gitster.g>
	<db7edc66-9b2a-47bc-98db-87d01885cef0@gmail.com>
Date: Wed, 22 Jul 2026 08:36:03 -0700
Message-ID: <xmqqse5brq8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 21/07/2026 19:04, Junio C Hamano wrote:
>> Hugo Sales <hugo@hsal.es> writes:
>> 
>>> When a rebase stops for conflicts and the user runs `git rebase --continue`, the
>>> merge backend opens $EDITOR so the commit message can be revised. That is often
>>> useful, but not always: sometimes the user only wants to keep the message that
>>> is already there.
>>>
>>> This series adds:
>>>
>>> - `git rebase --continue --no-edit` to commit without opening an editor
>> 
>> Meh. "GIT_SEQUENCE_EDITOR=: git rebase --continue" is your friend ;-)
>
> Do you mean "GIT_EDITOR=:"? The sequence editor is only relevant for 

Oh, absolutely.  I made a last minute change s/_EDITOR/SEQUENCE_&/
before sending it out, without realizing that I made a totally
unnecessary change X-<.

Thanks for spotting.

> editing the todo list.

