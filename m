Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E694C041A
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334719; cv=none; b=Vv4E7lyYh06lHCT1jmU/SWD/usuDvaPFs5qgH31aHh3RpwfTBHk+EIenpn/tb3R6GSMI71evunCDPY3TvoT9mmJ+H+bI3RrFDx++VpMmGPZG8VNBXroQCSIkndhYR7yBP01q9bIAL1eBTh6UjAFIeWpR6aFNmXUEwPDYWVk7aew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334719; c=relaxed/simple;
	bh=PhAAnV4oNYXtFSTmpb9GFfLcmPgDR5AmHFAznILzNA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g8r1+S/JVcX/68DzKWMqnHKDnGIYDkUct94uxsWOLLrNncbxAL1KhPG9bSclxeeJ01rcoRTWvRt22x7dciU0fuOuK5TAvEkh44viAF5SnVYt0Q7IkVWluqth8r3/m4bFlNGatxG8cFWOKyalKafwBe//jf/G7G5p1yG+eBz/3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mbyptnCS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xuh2M4Kl; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mbyptnCS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xuh2M4Kl"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2005F1D0013F;
	Wed, 29 Jul 2026 10:18:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 29 Jul 2026 10:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785334716; x=1785421116; bh=4NAYt+ywMt
	ZEI0IqQB9hnQir1oG+trFeY530/UOFA7M=; b=mbyptnCSDwNxZX0HEXb1yL3bt7
	UJT6dKXs6qweG4Z+2k/dv6UwmwgR3jsqHspyYCCLJ5bb8c7YtaXRL85xD+sfZfzB
	y+M9sqxwE03/QweTBd3T6wmhy+P3JH/S/a9fgtkBDBck6T/N0nxThDGZCLkURxF+
	/UIQVF2C1NcEw2JUzf64sIXtdAhtxnDuHkhMY3bIW8MZeX5rSDe2oEEXLbOZiNO1
	+aNnNMnPpFc9xR0XSD+40bT+3pfv4CIrVPbaYtlzgjqpJH09gSbPx0kQxhdTEhRI
	CCQyS8NXS4BrAmue0W+oZKLq3+S/6Zt61UwrE1fKaTBFPgBMIAEJrLsm1iNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785334716; x=1785421116; bh=4NAYt+ywMtZEI0IqQB9hnQir1oG+trFeY53
	0/UOFA7M=; b=Xuh2M4Kl8oYENqeWMuteb1jdIa162HcFZz2nohCVIl+KyiYtzEl
	0eCj6MGZPZwHfk/ZM7E9hG2T0qrlJsvLXf1V4j5naTLyuNpOSfO+wg7sVf72b0wZ
	hNMjN1+iBtQ3EbxSiuzqFt5CjcHw5JTeqr47q2PWCs8hSg5tQKW/LQrpc6TpDCdf
	Q79+AtOA2v+VaSKEKhy5uqc/EG2P/hhphabLcDghC6dPwxbst3K5giAoMDDpwF/5
	rKOldRr/HpPMYRktxKMCgOuFf+Lsm2d8Uvt4tCtsFO+gwqIN7fD2RBkLsIrdqpLV
	Ygs1S8ewIn76Idzsb0HKDBHOSsmEU0Nn7Bw==
X-ME-Sender: <xms:vAtqakvlXT8Rc1VBajUQKr6vQm1kWdsbFT9t7uf1YmgZ8-bCaDsUGQ>
    <xme:vAtqaofDTiXiufD-x3rEkXISORB7vKaenBJjed2N4U9QYJ1VVl4okYAK1wTqn_CU_
    _Txg4s_ajbqi8bWL2NXeS5Ixxg7gJu-vaLtu96eHXo73CyNman_WHw>
X-ME-Received: <xmr:vAtqakyYkmZlyGNytF2jjBvW4wIspU9IvfgT1bLXovPrIXW-l4YIh-k-J_u4R8cl5Va1vX7zKlOMh1KybWviXNSsMmU2dSv7Dw>
X-ME-Proxy-Cause: dmFkZTGcuCoTrAcmCxBo+aU9PYg/rzt090MVZ47pexlclevOQ1cQvNmGJoTfX+D+YEhmHj
    /VKFNmzOSaU5N/4sOAk2/OwcDnNQd1VHe0MZld+PlXxpMTzJTynOdiiJWNgGWfDzZoNuYm
    LooRWLDXH7iiLWpHT0P6nsxtecca0dLoldfQttqP+zO7nCVZ+BjZx0QVRcYomIIl94TRnZ
    aSCjn48dtLOf1UHwT2uPV0kd6ZaHwinGIlozn8yMbJnPadFfTWz9A+pEfKvvkTv1ln8Kik
    9IlZqf16LG/M9RZ/r4QLOBD14YYP/DTKze+BfD8gaLJlObSE8PJhDD+cl1UKRa3kI3A7JO
    ig7wgMLABie2aGU3TsFSv/SScml6Pnyu1/uzY/Fh220Iom+42Wjw6lNjuiLWmh6aLlXgt+
    0j6pE6R6QUSnkOacF6ZVsIYjFHxav2wwN58K+PWTZ8vkFfDV26UffKQP/E98766qZKdyUq
    07VVEh7tC4JR3xkacAikVwEJNDS21iJm2hRyE9kKYCq+Na0y1gTW5eXU3vadfoZIn66eLJ
    1xRdfoDJl9IvxKY3G+J8VSF+be4Mm0dsLzv0P+62yCffe8a53/1etqzMP4J8a/Eh/3hAV9
    ais75bLWQZGXY62m6lKhuRsugnziIWA0VL4rweiJtAUvDncDus7c5NR0S5hA
X-ME-Proxy: <xmx:vAtqamEub4gyEeRquGKEnc3jmCR50Ng7WNBfvOvDaSBiA33hjBnTCw>
    <xmx:vAtqagwbr4cYRtC2YlS_sUk686QDguML0FblkeVKCdpHvaxGdVf0UA>
    <xmx:vAtqavuZgb1dVys9m2UkH8R5b4f657fproPGZeuw77YKW-yWyDxM2w>
    <xmx:vAtqal0l1UVkgxFnN63VtX1QDn3oPXKgUJpIj_Gc1sxJ1iCgUk3lDg>
    <xmx:vAtqaoSVftnD6jHSmUUGwET_ty_4ahIgC6D44vFYV8U2_J91fIs5Bf9k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 10:18:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2026, #12)
In-Reply-To: <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com> (Phillip Wood's
	message of "Wed, 29 Jul 2026 14:24:00 +0100")
References: <xmqqfr15ruw7.fsf@gitster.g>
	<f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
Date: Wed, 29 Jul 2026 07:18:35 -0700
Message-ID: <xmqq1pclc210.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   The experimental 'git history' command has been taught a new 'squash'
>>   subcommand to fold a range of commits into a single commit, with any
>>   descendants replayed on top.
>> 
>>   Will merge to 'master'.
>>   cf. <DK1KIF2OI8IF.11188A3YEQV1C@lfurio.us>
>>   cf. <DK1KIH6CXW0X.1U2V3GU8L6HB7@lfurio.us>
>>   source: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
>
> Oh, I'd missed this going into master. Has the implementation received 
> any serious review? I've seen messages from a couple of people trying it 
> out but I can't see anybody reading the code.

Thanks for stopping me.  I am happy to immediately revert the merge
of this topic into 'next'.

Perhaps I should re-evaluate the "What's Cooking" report and eject
other topics from 'next' as well.  There are indeed topics I did not
personally read, relying instead on impressions from busy exchanges
(including earlier iterations read by others X-<).

Are there other topics in 'next' that do not deserve to be there
yet?

I cannot, of course, afford to be the sole serious reviewer and
merge only those I have carefully read through, given that there are
only 24 hours in a day and I have other obligations.  So either our
quality criteria must suffer, like this episode showed us, or more
topics must be ignored.

> Having a quick look 
> through it assumes the presence of an UNINTERESTING commit means we have 
> a BOTTOM commit. It then assumes that UNINTERESTING commit means we 
> cannot reach any root commits. Both of those assumptions are false I 
> think.

Very true.

> ... I'll try and go through the patches and produce some fixups, 
> though that may not be until next week.

Thanks.
