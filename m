Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BDC3B6BEB
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022010; cv=none; b=NNWvD54HV3Loxzirptpx5k00ivdHxCs6YLSLzA2tGTTn4lVSYsk6KXkMkQo7CZ859Zzm5P3bPEsJSJJcDOpSpXZiG1sZ9UItl3UnrSBB/CySWtIXjSpoSl5bxBVxC0FXsYGqtcbuQ3QhryN1vc8gB+IN3JIEFcUi7ItlghegsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022010; c=relaxed/simple;
	bh=IUTPdX4SHO7fADMbsPRPYbmWQEX0pGqBqvyHCLa6EZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y+yzZe0G0+cbF+J26mJvEMKb0/6aTR3LnXOCoTNvVm0z5s8kjxE/UpDMkjpevSf6V+4mf9sVMQJz17uQrVLireXti3TgPHTn5kjjgcTuaLgwMZLKP4/gl6vW6t8953DnfQFtswehv3dzrlz+H6b68dIcr4uWB6QH2jZ8PU75nRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iLA+7EM3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b96FQkqW; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iLA+7EM3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b96FQkqW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 603297A01A2;
	Tue,  9 Jun 2026 12:20:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 09 Jun 2026 12:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781022007; x=1781108407; bh=BpXBquj7RU
	OU35xJ6PmqesiztvUXPbOcJFl93I+SQ/E=; b=iLA+7EM3J64zxOGj8QYICexwdx
	cBC1oJRq5xzrcQG83AJpixN57NDXL0tfQswcxA47pDvbdPHoe5xzPiZo8iYrYa9v
	rnUa9gveRkGtsvixrdjuO+rERv91Fegp4ZSVXfNXr7PwEpds94TH0aHSAWviH+ok
	PtZqZXzDcJcGjeEizEgz+D0GTd0qcMoV0rFSe9YRzbRYQo915fxbBJhHqu3/K7cm
	3AhB3RWn/PY6UWk47ML+OQ0ZyQhCQgldVJIHPQST5Uo+0hlZKwubxtXNFfahOTJS
	DQkxTF8lCJRSZe3v1TT8Lvwy94dhA907doSFMqxoPEFxohK83l6L9tH5CLbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781022007; x=1781108407; bh=BpXBquj7RUOU35xJ6PmqesiztvUXPbOcJFl
	93I+SQ/E=; b=b96FQkqWBlOUXp/6rBMk42/sN1Etk7M6nafIGHueNWP2p0XK9KU
	H9oeyrISKECfCRASBuDPCVT9xeJ+tbWgwp0HgUs9e3coYaqM7C9ir+RA3Xbu/fkV
	RXOqhQW3T15k5P6Agl11AYFg4MLpvTSc+rzaJApz3oaOOitvmf18a8BDCvZ6w94B
	LnwsA8OqE2qakZ+/NxnoxcTw3Ecxreb2AKwZQNOA79i10Gq5YDWU4oXG+/YwC6VM
	fR2O6MxddzBqx4MvTp0abwSWrFHN9dF1zoDNanXeOJvhtJrHSajcBFCUipnihjYK
	qogAXF6e0GwkNpXWEZyo1thn7LGi6yJik7w==
X-ME-Sender: <xms:Nz0oag-N62f9TxULgkUbbTtEhTul632lKUhJ1cWHqfKvgleJq8BKcQ>
    <xme:Nz0oanyEQ3pyhdqG10NUuM_s6O9IH96sRir8kz8YjwApq3MaHPgmCCiO8xuuyOSnE
    6aOKeG88q79AZ4sHa-ffs24Fm8EERA1BNG2B5D9ju_l9WOj24aXUw>
X-ME-Received: <xmr:Nz0oasOOo_VJmCWzzcI3g7OHWAWBau9kybo8X5i_B0Omhafzfw4NbcgHgvu5j70r6E4iadAScOnOY-otDGXKmdqTFIS5hJ-8NChY>
X-ME-Proxy-Cause: dmFkZTEyJ9le1UFK+2+K/KR9U6EZXENyzu788bohEpg7+oWDsVoAHuR7B43xwiMO2QPVPu
    DJfoqXMYg2TEPNUyARXM0CZwQ7ELOqNtaSgue6x4TE2cL85iIsui7RyQSM2vrxIWKmArzh
    LmodR8+oKDUdUNoOZVaQaShECM6fjynjIH6kKdelwAHHWY7JLraMSh9OFQtlULOZUCDsa4
    3DlbrPIAPdZZyKtrIhPVZVti1hk06tELSiMITnDT5mSIHRf5+1BKfyAZuKKlh3swY9qSdd
    bp1GGqLmqFL9o6JHb7fTKbLrCabifUSHygWxYw/nN2xdDOR6qXNJa4DAEZOCT6dmhkQ6Hg
    UjGaYWhdsyaTF/6ZcATV6xslKQG5se9/JBHIX8F99eKdSJ1Q6Uepns0GQXrOsxQs1115yR
    d27mr6RqHMdhmeodvtsNlr96QfK+ewS0UUqMOpM3KUo4KsN/ZQdtleBw3/0Ry5KuF5Euzm
    ZKt1tEbEFAe0Lb2BsLgD+PUs5zgej7BftmasBqZizNCkIn4GCdJOLqjmBma4umFtNIR8xT
    IajXzBRNf3oTJFF6uUTY7aEFlb5bxPiqeETTqHhf/Siv1hYeG1CihJKuHU/gUsb+EYw2Bj
    7wxpLsWPz5IZPUlkTarmOZS1n1lIyh52Oxf5wc+CPqFwvZeYPbUIJOJdtHsA
X-ME-Proxy: <xmx:Nz0oas8YlLNzMNHFGAwhAfdiYcByP8Wzhrg4DNFcbNXcXQQves7Lcg>
    <xmx:Nz0oap4Yaw2bvDD3G2d8TWc3xKTBH4sXavaTJ83GUEosEMjoiafM2w>
    <xmx:Nz0oai5tF4WZPRUrqbqZobVZmPy8U_Ic6O8FbU15Whx71LwqTU6GuQ>
    <xmx:Nz0oaiohPMTNXrBpsupsTI832nbRTloaeHmmY5hP-dBFwLR_T84kfA>
    <xmx:Nz0oanruQeJHK12McPIXqq44WrYP6VS8H9W2A-BlV-SByl0Is2M6gWVP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 12:20:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  git@vger.kernel.org,
  cat@malon.dev,  ps@pks.im,  kaartic.sivaraam@gmail.com,
  ben.knoble@gmail.com
Subject: Re: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
In-Reply-To: <54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com> (Phillip Wood's
	message of "Tue, 9 Jun 2026 14:25:39 +0100")
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
	<20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
	<20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
	<54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com>
Date: Tue, 09 Jun 2026 09:20:01 -0700
Message-ID: <xmqq4ijbsn2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Pablo
>
> On 09/06/2026 11:42, Pablo Sabater wrote:
>>   static int commit_tree_ext(struct repository *repo,
>> @@ -135,6 +136,13 @@ static int commit_tree_ext(struct repository *repo,
>>   					  original_body, action, &commit_message);
>>   		if (ret < 0)
>>   			goto out;
>> +
>> +		if (flags & COMMIT_TREE_ABORT_ON_SAME_MESSAGE &&
>> +		    !strcmp(original_body, commit_message.buf)) {
>> +			fprintf(stderr, _("Message unchanged, aborting reword.\n"));
>> +			ret = 1;
>> +			goto out;
>> +		}
>
> I wonder if we should check that the committer identity is unchanged as 
> well in case anyone is using this to fix commits after committing with 
> the wrong identity.
>
> Aborting when the message and committer identity are unchanged seems 
> like a good idea.

I am not sure why it would be a good idea.  The user wanted to make
the commit have this message, and the commit ended up having the
same message as the user gave.  That message may have been identical
to what the commit originally had, or it may be different.  Why is
the former an abort-worthy event?  A simple note, I may understand,
but aborting with an error message?

Thanks.
