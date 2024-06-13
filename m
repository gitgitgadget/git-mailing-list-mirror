Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D97149C45
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292172; cv=none; b=oBsHSUH4SR4UOM+0VbLHGYJrxvYdyETLHcUA9ot+b7PdHfrqJ9kxOwhTrB9Y6+Nj5Ludeitw9A8U0WMfyb82BIeCIUALVknYDTT3Cy0kV8bjeT/bRimwlDvUqWVvEAxxuh/PkIxW578n+r/gACMsbAQbrSno0dTMfVv0y1tsndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292172; c=relaxed/simple;
	bh=oQAoTxMhjcnH7Z/7ZE1I0iDc1QngG/QkcFylMFeLVkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=apF66EOQuos8Whe+IV9BZ2NXGZG6EzV24fcgwYVm4a0r4cps+saYH48YkFUcy6yQVbaA5+/YcD2ntisDgt/2L3TeQZ3DrQJljL6BgCf1sAv6Kr9kSVfL3gYe6qfGjED10m818K6g73AsauiWDYlakCts1ciWoajyVEvP9HQQt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fECdi/R2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fECdi/R2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D29F119D1F;
	Thu, 13 Jun 2024 11:22:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oQAoTxMhjcnH7Z/7ZE1I0iDc1QngG/QkcFylMF
	eLVkg=; b=fECdi/R2eptFk4BAoVh5wKiVXz5nzCLEeHwHN6W26sXxw6xXpwPR3H
	4lJznKC2Wo9OZvkVEqUJ0yaYQWiBFxsvetjmyWxJS4M0f9w7jWJ3H4okMOtlb9Tp
	0MBsR9GToSicDYhf6e8l8RzZ2VM+j83YoUpqVWALxwAaw9mofvTBw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CB41B19D1E;
	Thu, 13 Jun 2024 11:22:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3381819D1D;
	Thu, 13 Jun 2024 11:22:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #04; Wed, 12)
In-Reply-To: <ZmqJDVTAiBrYJGRW@tanuki> (Patrick Steinhardt's message of "Thu,
	13 Jun 2024 07:52:13 +0200")
References: <xmqqcyolofar.fsf@gitster.g> <ZmqJDVTAiBrYJGRW@tanuki>
Date: Thu, 13 Jun 2024 08:22:47 -0700
Message-ID: <xmqq7cesoojc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB2E199E-2998-11EF-9C14-965B910A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jun 12, 2024 at 05:30:04PM -0700, Junio C Hamano wrote:
>> * ps/document-breaking-changes (2024-06-04) 4 commits
>>  - BreakingChanges: document that we do not plan to deprecate git-checkout
>>  - BreakingChanges: document removal of grafting
>>  - BreakingChanges: document upcoming change from "sha1" to "sha256"
>>  - docs: introduce document to announce breaking changes
>> 
>>  The structure of the document that records longer-term project
>>  decisions to deprecate/remove/update various behaviour has been
>>  outlined.
>> 
>>  Getting there.
>>  source: <cover.1717504292.git.ps@pks.im>
>
> Just to make sure I understand the status: do you expect me to do
> anything in this context? The latest version did have some final
> discussion, but from my point of view there wasn't anything actionable.

Yeah, the only thing from the discussion that may be missing is this
one on [1/4]:

 - https://lore.kernel.org/git/ZmE8myG5c99UJeCA@tanuki/

But otherwise, the typofix for [3/4] in the thread has already been
amended in when the topic was queued, so we are almost there.

I do not know if we want to explain the version number scheme there
(in your first response [*], you said you didn't want to give the
impression that the jump from 1.5.x to 1.6.0 was a huge deal,
implying a move from 2.45.x to 2.46.0 can be equally huge, but in a
later response [*], you seem to have liked the explanation to clear
potential confusion.  If that is your final position, then [1/4]
needs updating (with a reroll or just saying "yeah, squash that
update in").  If that is not, we can go with what we have, but I
haven't heard an explicit "even though I said it is a good addition,
explanation of the historical version scheme is a bit out of place,
so let's scratch it", either.  I have no strong preference myself,
but merging it to 'next' will close the door for you to say "ah, I
forgot about 1/4" later, so that was primarily what I was waiting
for.

Thanks.


[References]

 * https://lore.kernel.org/git/Zl_4IIqFmoPhx1Gc@tanuki/
 * https://lore.kernel.org/git/ZmE8myG5c99UJeCA@tanuki/
