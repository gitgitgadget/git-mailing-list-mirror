Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DC7E8
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714241207; cv=none; b=JzR0ECmFPZ0GrK7D/41VvYqvJUMmcDSUySkL661IWbkvbUfqYr3KodwtaS7wLxKDNy7L1r9zwOfLX+AYRFtIwPaAX4OAeSrhoEeCYZamWBi+/qdgS+6G26MRfuymmjHPJuAqDe8AsKS7Acz5vkZU7TjSzz311EbIgYxCQZTuu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714241207; c=relaxed/simple;
	bh=K6186+qDe4yYC3wyVvoCm7qn81RLNzcD0dRdUZyyJ6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U9KYy7o2UtRyOarBIQPlwPkc8c89VD2Lfb52RfCqeoUNTh+nzsftpb0twCj1bg2sZIZoaMLBQ9sBjepxGwl1UDsWVEb7VrBLBGI1gOwKqaCSpbYDkdO+AamRvJLUiTtmys9gxREPy3vy8fGrdsHEIPO8JxJDEIU8TuHdBezughY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SfxwkBA9; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SfxwkBA9"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 59CC633F37;
	Sat, 27 Apr 2024 14:06:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=K6186+qDe4yYC3wyVvoCm7qn81RLNzcD0dRdUZ
	yyJ6s=; b=SfxwkBA99X6J83CAttMy7BLCYOOWyJXB12c0wdNGigD+tFUc9yf0t6
	rBGBIshkgkOb1EU9RVc0MDnQCAkrYU1Gii/7VIIENbkQrKvMIXN8pJaEFKXzzPey
	YQMpuoTUIr5lrM89BKGmmLue/wMW4w5EvrASLeX3aWJ1zxTyvB1M0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5180533F36;
	Sat, 27 Apr 2024 14:06:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5F4533F35;
	Sat, 27 Apr 2024 14:06:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v6 2/2] send-email: make it easy to discern the messages
 for each patch
In-Reply-To: <d4d63b9f3c7692bb48ac3e7ac34b663b@manjaro.org> (Dragan Simic's
	message of "Sat, 27 Apr 2024 19:49:03 +0200")
References: <cover.1712732383.git.dsimic@manjaro.org>
	<c78b043b5a6cf0de712d36e6e000804bd6e1316d.1712732383.git.dsimic@manjaro.org>
	<xmqqh6g9w5bf.fsf@gitster.g>
	<7dcc6f23cc7cb823cb19ec63c69c60e4@manjaro.org>
	<0216a0e8369b8a3592dda90e5680be31@manjaro.org>
	<xmqq8r0y66ub.fsf@gitster.g>
	<d4d63b9f3c7692bb48ac3e7ac34b663b@manjaro.org>
Date: Sat, 27 Apr 2024 11:06:42 -0700
Message-ID: <xmqqsez64r4d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E79009B4-04C0-11EF-AB08-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> On 2024-04-27 19:41, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>> Just checking, is there something I can do to get this patch
>>> series moving forward?
>> Get it into a shape that is more palatable to people?  That's easy
>> to say and hard to define X-<.
>> I didn't see anybody enthused about the change, and I didn't get
>> enthused about it, either.
>
> Hmm, I was under impression that the amount of discussion that
> already went into the different versions of this series clearly
> showed at least some interest in these patches.  We've reached
> the sixth iteration, which shows something.

Well, v1 and v3-v5 saw comments only from me.  There was a comment
on v2 by Kristoffer Haugsbakk about phrasing in proposed log
message.  v6 had Eric's "Meh, either way".

I was not enthused in the topic myself, but was reviewing and
suggesting improvements merely to help you turn the patch into a
shape that would interest others, but the thing is, if the current
output is good enough, it is perfectly normal that there is no more
room to make material improvements, and it is not your fault.


[References]

v1. https://lore.kernel.org/git/62553db377c28458883b66bcdc0c58cc0f32d15b.1712250366.git.dsimic@manjaro.org/
v2. https://lore.kernel.org/git/0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org/
v3. https://lore.kernel.org/git/e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org/
v4. https://lore.kernel.org/git/8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org/
v5. https://lore.kernel.org/git/cover.1712486910.git.dsimic@manjaro.org/
v6. https://lore.kernel.org/git/cover.1712732383.git.dsimic@manjaro.org/
