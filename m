Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB701EA65
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805839; cv=none; b=l1eANRBpqqtr6/Dx3AKovU7DXMvJCXbkpA4MrsMuiQDy3dhTMeijYSz6Kea9JOwI7nbwm4+77Y69oYxgc0uPCMw7M5mmVd6HDoLMEkQVtl1DVZ9fSZPOQsFJ01q45yu3o0VSWJCdS27As0zx12zony+7HaMDW8/s8z9xq3npPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805839; c=relaxed/simple;
	bh=jlWSEeDSzIPZWxDoBVZudmmO7nb7E3VknCm6fxRplTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O/L8bBqKULClLU/U+R/vJV/ICXKg2PbLPC2tPQSP+MJiaHVpGHRlm/S3IMQsPohQi82aWtLElUDI6C5UZ+MQ/7Ij+L2NYK0tShl0RNsF9WB+ggYpZxXAmHHbtxA/djs/LQeqrDFxNkn4zWJxua4AdBYebmKThl6LetZcHN9iKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NIJj9tpk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ev4wHH0a; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NIJj9tpk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ev4wHH0a"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E36491D00199;
	Thu, 21 Aug 2025 15:50:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 21 Aug 2025 15:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755805836; x=1755892236; bh=HC0lvCVsTb
	28E3kA4krENTPHFVgugrisFax9/3ELY1o=; b=NIJj9tpkiLKxGPBUUL0VDVs4ry
	OCnXMjUOyQS8YTfPT0MFA2ux/aAdvQa4GC6gjkfUDZ7JO58GnRk9z5wvXE5+V3l7
	MbJQybynnwN9W++Mkexuz0m1efh4eQvfxJjHAa9pyOtCbUUV1rjNcCEq32mHFC9V
	BuK6sTgMOcgEe1QBelZWBqk0um0esQ0eoKyqVH2laHKGkVnWtiaSbSXUnmvpHZeg
	vI7DCviQeHdjLl4vcg58JyYuCaOR0+OOcCJS+ycUSQ7vdLR38uykBcrJ4qNBD4Za
	o/fsQhYPbNW7l4spjtabnNncCDFU01AFqXaAtTB+1J2MzaAogdaBosc5d0Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755805836; x=1755892236; bh=HC0lvCVsTb28E3kA4krENTPHFVgugrisFax
	9/3ELY1o=; b=ev4wHH0aSMm91iti/Xptp0ROhDIDAE0wxUSxINij0My3J2RubYv
	grvn7bMEkxBZmW7wcQjuiiibZF+jaaq2KU5TZ2f1nVTMA6kwTSr+KpjvUPtu8zV7
	Twwvukq6aVgFctrrZlZnoMmmGzv8BYmZ5OO/lxz/LAyvK/NPF8zF6oVdwDr8LqKW
	6PZDJz5kjy+NroqkXEn67embWZAP6p/ndUoymJ3rd6Hnwx8JfIvcgpyn3jCQjY6f
	SOysn1DaCAoEBlsZ1z4Zm/2hLm8punFJrDkty7wP4FGYYPN6uxiDPzWtFsXoOXMn
	TdnWn35HrLW91TwAHNjpgGII9YB48o+Pikg==
X-ME-Sender: <xms:i3inaC2DQHvcN7SZ03lZ2aqM1j0pBzgZ2WU5rRviWHx0CTI1-5Pd4g>
    <xme:i3inaI4cg6vtnJB3y24IJ0ENc5em-ucXo-isQ61oUJJqCqbuqRw-glb4FvdqW5AXH
    T75IBneMdsnH7Uz1w>
X-ME-Received: <xmr:i3inaD8csJv8G-C9t9Jef1QaqXbB7mJ7byCcqunrKCE1ypMDpOBKyhyjMP8bES5TbqrpiQbIjQrN3ljB3NEY1ucI_zrVFGTP1DvpQ58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepjeelhfdtkedtkeekgeegleevffevfeetfffhhfeiveevveeggfdtteffueek
    vdeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpohhpvghnghhrohhuphdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdho
    rhhgrdhukhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:i3inaHX8SqOXlj6vwCkE9scMelDlYItVASawcuVRdljS9LfX1LNFGQ>
    <xmx:i3inaOqWA6ZSWCCEOgScbxYK4OGRNrdYiXhIo170EDYraYDhzpy5vg>
    <xmx:i3inaJk7YojiBsc3KdLtNg5yxQqqrZoAdSD_ovL77ntho0-yN74faQ>
    <xmx:i3inaO3zU2dniYlltzTYPLItNeFhaKwmZ5y7N23eDrz1fk0ulKm_Sg>
    <xmx:jHinaJfw21f6aCmOrnnp42PQ3O5QjlMzYScati1QUT3VI1CT1Vfz4bRl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 15:50:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Taylor Blau <me@ttaylorr.com>,  Christian
 Couder <christian.couder@gmail.com>
Subject: Re: [FEATURE] Proposal: git format-patch with `--with-line-numbers`
 flag
In-Reply-To: <CAGedMtf2CW_L8uSc1KRqmAoJ=2Sw4t5AL2AC0uKQJb5keX63ZA@mail.gmail.com>
	(Seyi Kuforiji's message of "Thu, 21 Aug 2025 13:04:02 +0100")
References: <CAGedMtd_atWTAQXOPSJThB_tpHiOSY=PUhrfFxFZOEkgUtHf1w@mail.gmail.com>
	<xmqqfrdok1g6.fsf@gitster.g>
	<CAGedMtf2CW_L8uSc1KRqmAoJ=2Sw4t5AL2AC0uKQJb5keX63ZA@mail.gmail.com>
Date: Thu, 21 Aug 2025 12:50:34 -0700
Message-ID: <xmqqa53s1mk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

>> One things I try in my reviews is, even though I trim my quotes
>> heavily and leave only the part I comment on, I try to leave the
>> filename part (i.e. "diff --git" line) and the hunk header (i.e. "@@
>> -L,K +M,N @@" line) in.  See
>>
>>     https://lore.kernel.org/git/xmqqikla86id.fsf@gitster.g/
>>
>> for an example.
>>
> Ah, thanks for the clarification; that makes sense now. Up until this
> point, I didn't know the hunk headers "(@@ -L,K +M,N @@ lines)"
> provided enough context in terms of the lines the changes were made. I
> just never read them and usually just jump to the reviews on the code
> changes, and I try to locate the changes locally :(. I agree this
> already provides sufficient context, and I've definitely learned
> something new here :). I am wondering if a description of this is
> covered in our documentation. If not, maybe I could add it, since I
> imagine others might have the same question.

I do not think our documentation (documentation proper, not
handholding newbies tutorials) wants to repeat what is in

https://pubs.opengroup.org/onlinepubs/9799919799/utilities/diff.html#tag_20_34_10_07

and explain what different parts of a "patch" output look like, but
perhaps MyFirstContribution would be a good place to add it, if not
done already.

Thanks.


