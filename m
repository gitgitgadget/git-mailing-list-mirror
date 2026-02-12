Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7D2D47EA
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910513; cv=none; b=cv2ta/2o+f5LenY9vwvo62M1vKC2koS0m0z/dm9hE8BhkibYSOEtdchf5iGSeYiyIvCfcKV58OIqWN5N4DqJ6Rp6pbIrNEfjhRdzYj7ufqq3nQtRzAzh/4JF+9Ls9gGT5gF0nQn/rqlvpmF2nB4lOK0E9w7og3GCgZynBTFJbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910513; c=relaxed/simple;
	bh=oPvAywCq4k0yxLgmlyIu4aqDUYxrp1OIFV6F1oxXPPk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K7cUTf/RHoMqcxJNcXFpa0CgP84Vt7xJ+NH3EvmMpnJ4QwGK156U2mzNf+0u4XWDULEnDMM97cqZ0vrJredjJMn5r+4gIT/CyxebD+tGMYHzOpZjf55uRBGImSlWzmAaIgQrdADAOWYq7o6NmNwVQiJ9Tvc/XZWkon4GN/7scns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kAWUyXkz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LmZkLzYE; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kAWUyXkz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LmZkLzYE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 333667A017A;
	Thu, 12 Feb 2026 10:35:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 12 Feb 2026 10:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770910510; x=1770996910; bh=ggzIy9O06r
	BG9lVZojf/gWT/X4cgsKE1JtJRm36qliM=; b=kAWUyXkzZdWhxmyJQPFd5+VELp
	x7jukLZfkW6KhOpMJT0WIZ4KFPa5YWqdgwFBsrkvJeCTRkqB5wAkQALsasfLen6s
	wPvDG/5b01cPhN4l38Jv6CFG7zp8QB28A2pYXbCp8aiycOx+b3/gGVJeTxPOlkgC
	P2rfV00yOUGX+yF9iHMBlsTVtaYAaR/+Zvh58KT2OnqiGH8G0x5yt5/EEXaWxN+W
	yb9n1PiKR3Dmpwhbv6/F3Hu5eT9P7yvNtpHXbLxu2nPXkvY0ACbHE6VowfAquGrV
	oqLXhUyOsIYNGAR+jxcXgFQAND+5pFzCEj+a4VBwnSV5OEesIfadIzDlhOYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770910510; x=1770996910; bh=ggzIy9O06rBG9lVZojf/gWT/X4cgsKE1JtJ
	Rm36qliM=; b=LmZkLzYESaGdkyKWT5E/utCk0Xbw1X0Jt0rwccw5Q4XY3Gu+Abq
	93zgZCeLF0G4lz+X40n8yJ3LkKXCJMlVLaXYH23UMY7goEbN1neQ3eJsRYO+mEn0
	7P+k0z6miXMYpcOuoBGorkbG4pHVdJf3EJo4eyjMXbcX6JzFNmKjTZHJLfz5nY3V
	R5eBEKMPD6H3kPhv1YrjMB1EP8KWujoukHI565re+wjQmjiMxpI7M/BkJDjmAx3J
	yxzowMMFM7gtMQsKomTjjujHBvxeHdZs3HarL8bgjKuRb2QiEHZliCyH20vxaaYD
	5aAVg+a72rjvdfpnhnFt/pLTK/fzEGQE+UA==
X-ME-Sender: <xms:LvONaWcXBV0Czjr7pmEr2AdJ6hCS1xE_eOR9jHcB_tOV5cJEofVX9g>
    <xme:LvONaXp498QMp_wEGj214bQf3i7Xy0XFNe9hyL-tyltkBD-Z-nw8wypiNUEydrwwN
    0zhwDtgMoYVgvA3TVu2mwVh5NlzhdaZ6lP2slGQ1U4qG3XksAbpQQ>
X-ME-Received: <xmr:LvONaU7wkUR-3BlTw6e3YGJ22DSk12F1kx-TWSfbNiwo066y85dWyo382S_xZqL7urqU3p3-nyM-MW0_cLt1GUUn43JZLMuALQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:LvONadrou2QFFIeFdmRZl7Pk_KKO1IfLhoGn_KurdD15Yvf6i016vA>
    <xmx:LvONaWh8j9b4g197ZF-TNPzTMO3IgCP1kRcWbjlJtxPO1CiR8d_nCQ>
    <xmx:LvONaXLpTi8PvhGrp3rZag-H18iY9Rc5hPF6b_2pSbus6QkXs-NneA>
    <xmx:LvONaWDbQIlPnro0EbONMKhuC67Ca1Ksj7bxTSkQf-0dAZYSjlCz6Q>
    <xmx:LvONaXyrSgf5GJH1_PXahCIaRxQ09_v-kArLNFp8jAKh7l8puxnfRxB_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 10:35:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: document NEEDSWORK comments
In-Reply-To: <aY1892Rzp1bQsLoW@pks.im> (Patrick Steinhardt's message of "Thu,
	12 Feb 2026 08:10:47 +0100")
References: <xmqqms1ft7il.fsf@gitster.g> <aY1892Rzp1bQsLoW@pks.im>
Date: Thu, 12 Feb 2026 07:35:08 -0800
Message-ID: <xmqq7bsiq8k3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I almost feel as if NEEDSWORK is a bit of a misnomer, and that something
> like NEEDSTHOUGHTS would be a much better fit. But I don't have any
> intent to change that throughout our code base right now.

I somewhat disagree with this, by the way.  Thinking has to be the
first step of working for anybody.  It is not like somebody thinks
things through thoroughly and writes an instruction to do these in
comments, only to be implemented by somebody else who does not have
to think.

>> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>> index df72fe0177..b358d6bfb8 100644
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -33,6 +33,15 @@ Git in general, a few rough rules are:
>>     achieve and why the changes were necessary (more on this in the
>>     accompanying SubmittingPatches document).
>>  
>> + - A label "NEEDSWORK:" followed by description of the things to be
>> +   done is a way to leave in-code comments to document design
>> +   decisions yet to be made. 80% of the work to resolve a NEEDSWORK
>> +   comment is to decide if it makes sense to do so.  It can be a very
>> +   valid change to remove an existing NEEDSWORK comment without doing
>> +   anything else, with the commit log message describing a good
>> +   argument why it does not make sense to do the thing the NEEDSWORK
>> +   comment mentioned.

I wonder if adding a "still" there, i.e.,

    ... decide if it still makes sense to do so.

makes our intent clearer.

> Documenting is a good first step, but I have to wonder whether such
> authors would even discover this. But even if not, it means that we have
> an easy place to point to going forward.

Yup.

Thanks.
