Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA225485D
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414516; cv=none; b=AQDVk7hV39dQECt2vio+JfGyPHomzHwa72c4nc9ljPCvhT+5E/7JGyqF6+16b+mV75GVZy5F609WDMWHUDRMy8zJlW8BUwNPryshsioWYXat4Y4po46KZMFdjKlyb/WZagG8REp6kklzgpG2lcugB1Ekno9hG+JT9PSWGBHiGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414516; c=relaxed/simple;
	bh=gZgLA67EKKe0DStoVq6maSdoLNFm6zuOPwivGzxTT2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OUI7nen3Q5EO3hKMZ6tj7EKfeSR+N/vO4rRqOfJWF97n0ED7vq2wJX5O5pxWbJYYE2s+YboambtqqPcayAo9c/73nuMd0SKuKhoprT7Jtgc16+Bbc6SAs+9SMnRpyam3wbgg5h8eNtRtrhfYkkmIOUsvEr2Ss7S0VT/8IIa43tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G+HSZmqt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCgx2N6B; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G+HSZmqt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCgx2N6B"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CCA911401F8;
	Mon, 24 Feb 2025 11:28:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 24 Feb 2025 11:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740414513; x=1740500913; bh=ioX4rFecTy
	wSogVuBhKlfTknzwS0QuW3yQ3oz4wY4po=; b=G+HSZmqthObtxTE4+6vQUrm+Pl
	0DPO5LSwwIZnfNTGQIi4RMHYXkY3Jf5eEpvwvjnUo1/U2XbhU3nBCyXLZeeLqLwY
	fUpUiNERy86Ho0R4U/sNGSjIYZD6QHzeO6D+brX64JQkNc8b+8RliJ8Gq3sxpF1U
	H/SKQj4QPcbgsot5vBT++UXaRS4kIoun3KKMfniNAGSxAVOt88ge4XXUgA25ALSm
	4cenUC+HlpWoPq/9KMJiHuh5uc7Lg4qqehdi4AhmvVqaFYaM//mP4c/Tpzut7ADj
	UhAkHUbSBk54Ios1WkiYLHDOYrUAOJnYjYlaw4kMCdSdvQ8mupxhxqXkj0Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740414513; x=1740500913; bh=ioX4rFecTywSogVuBhKlfTknzwS0QuW3yQ3
	oz4wY4po=; b=eCgx2N6BMxKUknt7hlpIELRekFYCMqepkfaDIjNbnxmxq/4a6oQ
	i8qkCT22uOybXeUvotVXv1evfC7dWty9lZtGU1+j59rpnc9Ed5dh/cFwNQzSnd4J
	dDdrmiwtfvtJ+B9/fGTjV+64XbbCH2r/BfD71rXGprPY1a74B/mrWrpdYq5PR6ce
	55COT2PaFteHLiRgmSvabILAwb2SeWHGq/yR1PjNputeEUN/5vL2LqZS3H0rYg34
	g6fpWF33Uh1ut8VgUibKUhe1OqZrqtanySW2JwME4suKwWwPWDIveQu+D8S28wnV
	07CfMZQn9u532IY8eBeeqaPlwo51KkIbYMw==
X-ME-Sender: <xms:MJ68Z6DBiPcZBheAnlIJ5Bg4posxOpfMDvkyfukUFY2z9qLmZQw6uw>
    <xme:MJ68Z0hNpspaEUmwQbVc26xKrVI5FmWFzCGCCd1sp7o7jxmANzc1c85VBIl9i6jYh
    m3Iw0K5N2MCWmDvRA>
X-ME-Received: <xmr:MJ68Z9nv_Vd10X8OSdrCoLhCfx-510TM5jZzT9EqlB5-AOhdPHr6N6b2YQX25pWKE-M2XQjDU_3_hTTjttYx-Q4pbqXhd0s0G5JzEoM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejledviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepte
    dttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsgh
    drohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepughhrghrieduheelheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MJ68Z4yBiyvp__H-KqHuwCi8msAHvf9rAqrim5qf1TFpaWiohQOblQ>
    <xmx:MJ68Z_S0HfIC0eA3AphUYILsTEzerIn_RvyoiRsQrJL7ODE270rDLw>
    <xmx:MJ68ZzbgD7H0h-7f73CwvmeIOZ4T-JUtrP6XgPCf3Uw0hgLJ5s3XpQ>
    <xmx:MJ68Z4SMmJ9_YwXKSaA5TuP8hfWciJeprf9Ar_IxPf-Wq5_SOiQBuA>
    <xmx:MZ68Z9On9fGMK_kL6ShOJ6hLPnqqZqGa9QUba8Kz4zi2YmQz_majh3_T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 11:28:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org,  Moumita <dhar61595@gmail.com>
Subject: Re: [PATCH v2 1/1] userdiff: extend Bash pattern to cover more
 shell function forms
In-Reply-To: <85d3318f-5e5b-48c5-8ba0-27465a2e733f@kdbg.org> (Johannes Sixt's
	message of "Sat, 22 Feb 2025 19:15:34 +0100")
References: <20250211114611.9334-1-dhar61595@gmail.com>
	<20250218153537.16320-1-dhar61595@gmail.com>
	<20250218153537.16320-2-dhar61595@gmail.com>
	<xmqqy0y3jbjk.fsf@gitster.g>
	<85d3318f-5e5b-48c5-8ba0-27465a2e733f@kdbg.org>
Date: Mon, 24 Feb 2025 08:28:31 -0800
Message-ID: <xmqqjz9f71e8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 18.02.25 um 20:30 schrieb Junio C Hamano:
>> Moumita <dhar61595@gmail.com> writes:
>>>  	 /* -- */
>>> -	 /* Characters not in the default $IFS value */
>>> -	 "[^ \t]+"),
>> 
>> We used to pretty-much use "a run of non-whitespace characters is a
>> token".  Now we are a bit more picky.
>> 
>> Which may or may not be good, but it is hard to tell if it is an
>> improvement.
>
> It is only a stand-in, because every built-in userdiff driver must have
> a word pattern.

Yeah, I know.  I was merely saying that it was not obvious that the
new pattern, which is way more elaborate, is improvement over that
stand-in pattern.  As these patterns are meant to be applied to only
syntactically valid text, by going more specific pattern from simple
and lenient pattern, we stop recognising some word that we used to
take as a word (i.e. specific patterns need to worry about false
negatives, while simpler patterns only have to avoid egregious false
positives).

> See the old thread here:
> https://lore.kernel.org/git/373640ea4d95f3b279b9d460d9a8889b4030b4e9.camel@engmark.name/

Yup, 2ff6c346 (userdiff: support Bash, 2020-10-22) is where the
stand-in pattern came from, which is the v3 iteration of that patch.

Thanks.
