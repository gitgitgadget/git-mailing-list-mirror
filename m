Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217A41B8F7
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949402; cv=none; b=I2Nj4P969gp3eZVD4+2zIqz0JaIziahmsL8tHMK/xmZEsn51BtKZ4Dg7B9l7cy5liebs8K6wGvCiaiM2Cia3C8ekhrv7f9zkN5zyZCRGrtcy2HeRogJFJKyr0wk8/dgD/9Zy9HGy6I2JiCdkhQFKufl6j95Ay3bevYWtN2cDqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949402; c=relaxed/simple;
	bh=NmrfpSWDHmdMRQylMvhmK2HydB4GE9idxLk1ok74EiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ntI7h91S0G4SgipGDwdK1qRw9IurVXILGGHu8AL/znImNvd90lOM3loYFh4snsNueYPb6gDkTFIDE8B68d/kSCnWzFN9qDwZZ3hQHDg3FES261JAsWuQZP+hSR7aNAy0ruK8gc6mXwUzww+/tsvixiBQh9tZBqzHYATWLAKBbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LnSJDA8O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jzFpZxrM; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LnSJDA8O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jzFpZxrM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DF3A31D00121;
	Wed,  5 Aug 2026 13:03:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 13:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785949399; x=1786035799; bh=lFIJsduPa+
	9ZT3kHJYb7356dI3N3EeBwV6GE9vbw/Bc=; b=LnSJDA8Om5/L/j50sCpe8fK/+X
	VX92EhCBnejrGbSCfqJ5HlVag1Z5kYT+KNlBsUBRtbsfJfGr+8fluSUXdLXvRlla
	1Ktjj/mrKDvCPn4yRYv50N4omirFhR0nnoEfAtZMP1ixgwM/rzOd+AVHPE8DUSPy
	wbIcninO/KmCm0odNEXUmsKpmhR8HWNtrPpdaaeeEg7aRcn8ZICu649AGvdmSglN
	9aevrOVNAE5MbH4Ck9Mq9OTgaRBjQyYFVVebLeaC5DwUpJ4sy3AWNEC6vOaEcMD0
	jSxrK7GWs2eP7XwYR8Pj9e6vx5+g62lclMRanzBgThO0ePpVV17AkHk5aepg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785949399; x=1786035799; bh=lFIJsduPa+9ZT3kHJYb7356dI3N3EeBwV6G
	E9vbw/Bc=; b=jzFpZxrMG1XNcaow1JLoyyUQSQVrZo+8x4QK38H85Topp/99lsQ
	n05/uJnF58jebfVJu7YcIfoHzTsXaglIagEB8hN5rEocQlhsheouABvZLudWR/Uw
	Se0m1EzFzLlo4A7qKlXg400jeaFfP2EFt/3ybpVEN/dJ1B0dT/1/Vg4fxJjEVz4l
	U7yfX50qCHFlwm2P1NJyQxp0non/5MokwxkUkP7aYjC/d6zdwyHuheouDjeyl5ru
	JyWk2gF0+IJiNJuckYmoyu8kTzJ21hiu07ER1Lew/NO0hNPN9WaAsMISw+y8v1MC
	I3O7BDbM7OsnTcoULmyjkPttOOAuZ/fH1jQ==
X-ME-Sender: <xms:12xzaiCfdCXSH_grBv3lgvhZo4u5Sns3-FaF3w0LZjUtu85R8qeCnw>
    <xme:12xzajhBTY473HmBBK4zPfp6XcqN1dyn7SGByhjJZO0A9UYYGmXLjmU4eNB1XvYpA
    rWwwzKzipZmshlwZ3913eHG2rpJff3w8PViY5aIPczruTGh1SdqJJU>
X-ME-Received: <xmr:12xzaqkiBx0J6RRW9xppAra-xjIXcf0q5qCEoadYAgWqiSThvZlYSCh5kANJP7hl5cGNJpmIm2PK49Hjl18LrYribOgXPJmA7g>
X-ME-Proxy-Cause: dmFkZTGzsTuKVn82CrCow0JsbWkr/aMmG9nR5tFm+BRx/94TfOm43fntkFlFfAcTshGJeS
    wh2npuCebpa8tgwb8GQKoKajEHCIINMUWqL19Kcbc5DzNzs6l/qLvIZGFJcHbR4nfq4tkv
    C1j3t48HhzE/UfCe0EbiB2pLPRGaxY/8oBos4ZiZiP7OcZZ0QcMEtEbV3QrrrOTUV8qqlI
    r5SHjNbDjRgi6QFtb5cr/Q8e6YhIjjC7Q3vmDV6O7dhAm7MEiy0EWE7NicErbGymY6u3KY
    P9r6qXD+JeHnF5jKxA7W4C/uxThj1UBQxstbTtztiCdx2Oari78tT4vM1tP8mr0KxDvncw
    v5ODTwuf0Pz3WnHnTNlbPLX35HRP/GDj0vHfEwKQPojoIxUbwi0vT8T5pQKQFgtlO0Vg8l
    y4p3g3Zh77f7dxS8aWe45740scwpvxaN6NGfxUrOxeUAmxWBu8U0SQ/juWXFZhblkWPIGh
    Sk3Xz1veQUcIYTUWaBicDppBG0qaTVEG5pyWklp5yb0GiCoS6pwG6FcOwvkueOv1M1X1gl
    eGbU1oOzq7yqKUJFMA6czxsKVhdG18trjeYdyFLW2EyyBguAvKqA5Uat5FfjZvwEGL5obo
    iNSWmMmOIT+/NCwRlpoGvcQ6gmbUmbOIxgHFmFq+nYwMM4679sLsTCaVZzTg
X-ME-Proxy: <xmx:12xzavqlGSD9RxWpSVyH9L0ZLMdRiS1HfYJKiE65Mh-fCKqL1rQ-lg>
    <xmx:12xzajF9wzFYmgMFS5sCtIh1CDtYs-sSN1OKyo4NO8jqDHg70A2N2w>
    <xmx:12xzaryheAizX2zt8ETpuS1EMLwii6L53n02fZAusRJywfGnq23Gyg>
    <xmx:12xzaorY5qXBDqEHWECwNIs9uk3M1Oe_Wy-D1zspUcshI44XYAdXXw>
    <xmx:12xzaiHWp9xj_CvdTLXatBZ_Wb8cwBsvAKOV9OjrZgeutTQVLmkxDrHB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 13:03:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2026, #12)
In-Reply-To: <47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com> (Phillip Wood's
	message of "Wed, 5 Aug 2026 14:10:39 +0100")
References: <xmqqfr15ruw7.fsf@gitster.g>
	<f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
	<xmqq1pclc210.fsf@gitster.g>
	<414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com>
	<xmqqbjbpptzr.fsf@gitster.g>
	<47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com>
Date: Wed, 05 Aug 2026 10:03:18 -0700
Message-ID: <xmqqmrv0qz3d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 29/07/2026 18:48, Junio C Hamano wrote:
>> 
>> Perhaps the sensible thing for me to do is to stop taking any new
>> topics into 'seen', even if I've spotted them, until I see somebody
>> give them a real review.
>> 
>> Otherwise, it becomes too tempting for me to jump in, give them a
>> superficial read after seeing them linger in the "What's Cooking"
>> draft in the "Needs review" state for too long, and, believing I've
>> seen enough, mark them for 'next'.  If I don't queue a patch that
>> nobody seems to have read carefully, I won't succumb to such
>> temptation.
>
> Maybe, though I do find having the patches in seen makes it easier to do 
> an in-depth review as it means I don't have to apply them myself.

Yes, that is a very good point.  And if the authors are paying
attention, it would hopefully also help them how well their changes
play with others' changes.

OK, then I will keep picking them up, but under these conditions:

 (1) They will not leave 'seen' without anyone commenting on them;

 (2) They will automatically be discarded after four weeks without
     positive feedback; and

 (3) I will not feel obligated to review them even if no one steps up.

Thanks.
