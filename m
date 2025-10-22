Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C57271451
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165588; cv=none; b=omL/liy9NruJ/e4t3rCPKUcj9j236ozDyCeQMuIocQI0FK12dz/iO2CwLLWICJlaePeztU2b3oCQurOtVkYAspnkumgjD6lYfVthdYONzlPu4IyYyuBfxHmG95mVIg4qNj5RHBU+sf/uewikJ8L9Qhh9qwzLNJ3FkMJxzoFKkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165588; c=relaxed/simple;
	bh=4bJHd3uWcvIhcupg9Zwy2ITUCqh0X/x9KcNWC0GGWxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B9fXp/2OVy0U79t0S5Dd1vX38+KCdCFWJIc8jETyeR/kplZi2qtznAdKZiyppX3hjI4inmiLSpnArKPvMdO9gk+EgXQbALXbFdfj0lg1Hmdi62yzNgHFRIKX2onozi0eAVZ9Uyin82scSa0klpHpc9fdJhwaJ4rlv06BlmxDbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PzxXDq2d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EXyPiNZE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PzxXDq2d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EXyPiNZE"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 390A7EC0169;
	Wed, 22 Oct 2025 16:39:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 22 Oct 2025 16:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761165585; x=1761251985; bh=96etc+FKjL
	kRKr8S47wDIOvveqacsZGCWvyJ2jrikLQ=; b=PzxXDq2dsqqHxMJwaKXwAY7jlo
	nEkmZPooWhkGUYRQMHhlOHD4/5VKZbfaDHHepX4VBEKkppN2RIktlAd1sU1qEflm
	KCOzSXSl88nmYqdtGlgvsiGgvcepyBe69rMRc++avZWiTY/x8u2MkNH+20cxLqnE
	Elgf/HbvJu1gTXO75bKvRLDmS8eKV+3qFhNXh3FPgETDx4xOJuO89iMjc7/RtOV4
	NAxa57HrQTxWxUxQrPdSSvHQIePD6dGVmROEy+HL/mvdkwRMjshKSP77kw2gzXp9
	veNDwt2v3SUc7rgF1Q/O3boaIacrvnEciV/ttM2x63hrvO8TFUMxjGRJXugg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761165585; x=1761251985; bh=96etc+FKjLkRKr8S47wDIOvveqacsZGCWvy
	J2jrikLQ=; b=EXyPiNZEev/BKSMZadxYnaLwoU0RHGv+zlVlolJXsVp8CJKjyvY
	rbpbkeR/z01wZu3a9c0UM8K0kMGP0EgJMGRY4dvHgN0AmIwldunhDaHFB1YJMNuL
	BBua/FF4TK/ztUe/q/EoyzPeuz/Fqg/6SWgvwVpKSqvKnz/dkhnqDYhMkFLp13WT
	9anKFpQ01NaDlXpwaYelMCyeXZf5XU5wm0ZRmPIZIAu+exWgEjBGCNgGIBvK9WhI
	E4zc+IrCoHwqXgUa7vQ0VPmcWsDHdfhMD/xtNp0KfduVPRVGXaVeTuKowWgDvdcw
	rRzXPD14MFFHxFlT5heWki2p+8z6yRaYSUQ==
X-ME-Sender: <xms:EEH5aKXA4d1UmZnnZam0C-MlygjexXHdPLRedRUYq62vIfVrn6CXfA>
    <xme:EEH5aNcqfBXkCl8RaUIqC8TEi0y4-crHPbrooN-cOW3gEa5CONnzm3F-b1KHZ8RvT
    E2jihmV_mpx-437rI9tasW8rhgd-hhQsCB1VabgF0_JjaYetJ6qPw>
X-ME-Received: <xmr:EEH5aGv6oUc5UXodOZE_-vRwwHxRvMJ_OHtFwVTlS_d9Ky7psLogbbjGWGF5gCRDJW_h_uKP1mFqiuSvKNRF12eBgSD3sADas9rN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghnthhonhhinhesuggvlhhpvghutghhrdgvuhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EEH5aM_rODG29BsnXJDNuTRGfW7Dx76xemoiyC4C0L73DFbnMg5-4Q>
    <xmx:EEH5aB0eAjNaeobTc4s2FIy4J1JC6UkLcX4JKuN_LCnHigyy_6RuEg>
    <xmx:EEH5aBA6rYsyTkUILT4ySTju8-XZaEiouI4zUE2sg6gZy5xDieHudA>
    <xmx:EEH5aNdg5dfuKVeQpIp46jZTe03g2n3L4J3Ve3aeV4IPgaIOI1SSfw>
    <xmx:EUH5aFYL0K9UlGEIoZh1JxD5iUEpa-Rd-Sp84tuQl8jJqT0uotaX1Yeu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 16:39:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Antonin Delpeuch <antonin@delpeuch.eu>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] blame: make diff algorithm configurable
In-Reply-To: <d59a2f97-1a69-44f6-924e-7419e36329a0@delpeuch.eu> (Antonin
	Delpeuch's message of "Wed, 22 Oct 2025 11:37:46 +0200")
References: <pull.2075.git.git.1760972162827.gitgitgadget@gmail.com>
	<xmqqldl51rtm.fsf@gitster.g>
	<d59a2f97-1a69-44f6-924e-7419e36329a0@delpeuch.eu>
Date: Wed, 22 Oct 2025 13:39:43 -0700
Message-ID: <xmqqfrbay8kw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonin Delpeuch <antonin@delpeuch.eu> writes:

> On 20/10/2025 18:05, Junio C Hamano wrote:
>
>>>      If the general idea of this patch is judged worthwhile, I would be happy
>>>      to add tests to demonstrate the impact of the diff algorithm on blame
>>>      output.
>> Do not ever say this here.
>>
>> I've seen from time to time people ask "I am thinking of doing this;
>> will a patch be accepted?  If so, I'll work on it." before showing
>> any work, and my response always has been:
>>
>>   (1) We don't know how useful and interesting your contribution would
>>       be for our audience, until we see it; and
>>
>>   (2) If you truly believe in your work (find it useful, find writing
>>       it fun, etc.), that would be incentive enough for you to work
>>       on it, whether or not the result will land in my tree.  You
>>       should instead aim for something so brilliant that we would
>>       come to you begging for your permission to include it in our
>>       project.
>
> I am surprised by your reaction here, both by its substance and form.

Yeah, after sending it out, I realized that the canned response
above was not fitting to this exact instance.  I overreacted
primarily because what I saw everything before that part was
indication of a great new contributor, which made my dissapointment
to see the dreaded "I will do this if this is accepted" even worse.

Your "this one lacks tests" is a bit different from what we
sometimes see on this list that I react with the above canned
response, which is "I want to do this great thing.  If you promise
you will accept this change, I'll work on it" without showing any
detailed design or code.  It is more like "I know we need test but I
have shown the main part of the change.  Am I going in the right
direction?"

You certainly didn't deserve the above response.  Sorry about that.

