Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F81422AA
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592095; cv=none; b=XgPi2BFo2PD8Jq3JHEwOIVLsbYSeQFCIIEKooZ8ZPwdSqnmPPY1vlje40ye/NjSx8LWza2cb0AuDbqLzvhIsPOtuCNiZe6/s69OvxPxbAWemC1/jbV3So/Xim5sp16JD0cRp17JPtA8vLe8u6COsb4sEkRR5q4xMmRLNaKIkEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592095; c=relaxed/simple;
	bh=2WZOiZPK+9/XIje8HpmayxsFErVltWbTr/DSu937Yi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SanHh0I2FC1iUbbVWQN5pa3jMqrS0L0s/at1vdIj9RNbMNcy3sLaceaQFlewcMqZtD9emgE196OuRPTh44gpDyV8jXa6VvRUuTH2ksuTi0MNDAA9Sf6aN4noFZoJgacO0xvf5HlyxU6ugUJKGqblvtxhwknNVJHWR7C5vVJFJxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u5k3wBp8; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u5k3wBp8"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4451B38F3A;
	Mon,  8 Apr 2024 12:01:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2WZOiZPK+9/XIje8HpmayxsFErVltWbTr/DSu9
	37Yi8=; b=u5k3wBp8pnonYXk9Z2DyJN6vZ/4d9XkdTSmZ5UuLfbBQIo0n8QkOM0
	X80KLIO/Gvp1es/LLHS/dBwP9/81bI1pzJ6YIdvjC7jemAhXtXj8gyS7+BvHxSTM
	0aKG30TUPlBjdLVNfJDtVmNOtn3tnztrbEWWaS3IbyJfUA8Tt+Ydw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D8C538F39;
	Mon,  8 Apr 2024 12:01:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8467938F36;
	Mon,  8 Apr 2024 12:01:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  code@khaugsbakk.name
Subject: Re: [PATCH v4] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <6cd48321180195e7070825dbc3f49578@manjaro.org> (Dragan Simic's
	message of "Sat, 06 Apr 2024 19:08:55 +0200")
References: <8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org>
	<xmqqwmpbm4lp.fsf@gitster.g> <xmqq5xwul8vn.fsf@gitster.g>
	<6cd48321180195e7070825dbc3f49578@manjaro.org>
Date: Mon, 08 Apr 2024 09:01:28 -0700
Message-ID: <xmqqttkbetd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 42EFCCD6-F5C1-11EE-B74D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> On 2024-04-06 19:05, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> The whole thing deserves to be a three-patch series, the first one
>>> being a preliminarly "let's move the final newline out of the
>>> translatable string" step, followed by "let's have a gap between
>>> output for each patch sent out".  Perhaps another "even during
>>> sending a single patch, we may want extra blank lines when use of
>>> editor and other user interation is involved" patch on top.
>> Or the latter two could be done in a single patch.  I'll have to
>> re-review the thing (if I were the only reviewer of the topic) so
>> doing so would delay the completion of the topic, though.
>
> Huh, I've already separated this patch into three patches, and IMHO
> they look nice and make everything less error prone.  Would you agree
> with the three-patch approach, please?

My "or the latter two could be done in a single patch" was
"alternatively you can", so either way is fine as long as the result
is well structured.  I know how to explain "insert a gap between
patches" well.  I do not know which one is easier to explain,
between 

 (1) now we have "insert a gap between patches" with patch [2/3],
     but when editor invocation and confirmation prompts are
     involved, there are these three cases where we want to tweak
     the logic to show gaps.  Here in patch [3/3] I explain how each
     of these three affect the logic from the previous step.

or

 (2) We want to insert a gap before showing the second and
     subsequent patches, unless in such and such cases.  We also
     want to insert a gap when we do this and that.  We do all of
     these in this patch [2/2].

So doing it in three-patches results in a series easier to
understand by readers, by all means, please do.

Thanks.
