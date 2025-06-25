Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94C2C3274
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868955; cv=none; b=mNyk0hcsuREOvYblLhPPXoz/hxtEnuIDHfGJWI92jGVEcOkuHzZA/W2exLBGEdoF0sm4T1hg600rZ9FuSWqfMY2E+zQf5N7ijNpm1QRXqQuxs521XrhCqMPGX2hPn4dE5M9R4O9pUHLZ7wOVffA8w058hVHRbK2PeC6ldbt4oW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868955; c=relaxed/simple;
	bh=QQgOTa5ovAvRRyK7iqUs7KKK5Y+grGZLzOFjSNEKYKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gUO8bjELLyvOqsf7fmCn+mYDFocyWvC/t2l0DHzpSCLUBB80OV+o0nfFResr2SiA6VWzMySlM/6LNDiIn6LQWdiNAx3LhxYHl7bwZ+VmmTXXagydzEdrZ3o5hrXZtxQpXneqdk5Rvh+flz8/flOcYBXVuy3irnRw5b9DiVgImjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jGsXxXER; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k9uKsAO/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jGsXxXER";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9uKsAO/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDE2F140019D;
	Wed, 25 Jun 2025 12:29:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 25 Jun 2025 12:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750868952; x=1750955352; bh=2nay7HANND
	di6NNw63XGMQhuaZVuxvlv8IU5S1gxfPM=; b=jGsXxXER9y7+W/EJD3pzwQKgYa
	eR6D+yiTyAhFc5W8eqdw8giWwXB+9qo8h5PzmPklPHryrdFRNzeKYnS7P2GY1bdV
	JvT6bpv8cYHIoUJifa5RV5onqO1+zqdiChAZrsG5rRYKTa3qT5rJ63Zl344XNZQt
	EvzMyFzPCTWiTkbj1CufF1CWwaxgShzf+HTStrrNiZLk072g0GmrJlK6vx11+8y5
	LIB2cBe8BV6+P57ahI2V7UXJ41Hsnwmk0h5pA2FK2H9xjZ7IFbfQ6llsrLsSB0Ud
	zIU0deYFl/iPAWy5k34b53sLzjs6jIu7FKj3bPLjFmmjrHNsBLRrCyO8Q+/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750868952; x=1750955352; bh=2nay7HANNDdi6NNw63XGMQhuaZVuxvlv8IU
	5S1gxfPM=; b=k9uKsAO/6Xqho05MbHCFmox00xjcW8QXSxTCXynPtF2c0myOr5T
	LKgWxlUmOLZ/VnPh1bvNR+kDPh1gxshcqGM/co9bRF0y2wJ4SnaknDK9+2Z/KSWD
	i8WxyGR7wcl2tSdX58qnGuVZFyDQca8fXYZ/CTpt1UhxofK+ULacYrXSpjN3DTBW
	1OGcqe1Oag2CICZFiigNKYMf4eE6KsG1eAhJ9KGSCLLxQnWur5Y/HE2NgEUtDki2
	FmoyItd+7UWvL/irCzHEOEACLnivIvmF3bxpxEImOgOzf2JRyeF9BdfNSnM6zquG
	pzExfZURrar47hGQ3+7Dn738cHZ/x/WDn+Q==
X-ME-Sender: <xms:2CNcaMKcIopFxyuJswYRu_j4o4cBR3cMZXCtKdGjZluJQc9OlLYRnw>
    <xme:2CNcaMImYfBSrGmNfoys3PdbPBjqP9zORofHq5gh-pz3we2N5tt1MdRSlve2jgmoI
    gHQClVihmCxzGd9Mg>
X-ME-Received: <xmr:2CNcaMskaJCccF3o-Ni7j6_ao23ChQDyQ_CUcnsjW4tXTfLMAZcYjNtr2Lm-JmY5T6aqXAbQbKgXMsAsAHnKUSZCs9fh82hDaKorilA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehohihsthifrgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2CNcaJZ4bUczUSI-0YzraSYsQf-Weyzeyn_8iV9orDqOIxSLprKs4w>
    <xmx:2CNcaDbgfj5iH9IfE2I9P6NWRC6rbmuzWm6-a_Ww7eKz6TfP8Il6ZQ>
    <xmx:2CNcaFCXJKB57_vOkgPAPHiHlQeryOU7FqkVvq1YVrOqTpbfLsI9Vw>
    <xmx:2CNcaJbe41_qBl5sqVn6nAmqTEIJxIQWeJHujbHUtdElkhI7Xqmkdw>
    <xmx:2CNcaElRatXvOysVchduRIpszpvV9ML2DhU872IwzyWzn4Eo2h6djpPX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:29:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2025, #08; Mon, 23)
In-Reply-To: <323b46b1-ba9c-48f4-a8ff-f889f8173ff5@gmail.com> (Phillip Wood's
	message of "Wed, 25 Jun 2025 09:40:35 +0100")
References: <xmqqtt462bye.fsf@gitster.g>
	<323b46b1-ba9c-48f4-a8ff-f889f8173ff5@gmail.com>
Date: Wed, 25 Jun 2025 09:29:11 -0700
Message-ID: <xmqqjz4zwzs8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 24/06/2025 01:57, Junio C Hamano wrote:
>> * ow/rebase-verify-insn-fmt-before-initializing-state (2025-06-09) 1
>> commit
>>   - rebase: write script before initializing state
>>   "git rebase -i" with bogus rebase.instructionFormat configuration
>>   failed to produce the todo file after recording the state files,
>>   leading to confused "git status"; this has been corrected.
>>   Comments?
>>   cf. <20250609221055.136074-1-oystwa@gmail.com>
>>   source: <20250609221055.136074-1-oystwa@gmail.com>
>
> I think we're expecting a re-roll
> cf. <7e796844-97e2-4b45-a76e-4c1fcb1da3ae@gmail.com>

Yeah, what I wrote there is a nonsense, referring to the entire
thread (which already is available as "source").  Besides, the patch
didn't have a sign-off.

Thanks.
