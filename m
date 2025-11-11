Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5332AADA
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871864; cv=none; b=HiBbmwpAosTDbimeV8/BDbJP4Wd0DLROzvzLUDNDUbEeTWeJ6z4PPDriweYshfYxnLB0CstszbXoWtwIvS/lbu4JMsO0Lb5Aa+b1lW7UmjNbe6MzQJ2hENy8MLgl4nBNf4Ov4wZDu8No5cCmWc62s6T8114jyvLbJRZxwKoZvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871864; c=relaxed/simple;
	bh=ZpIPTI5HF3OpvfEA/G6cCwbJtKBYzgl0eDg2JN9OkaI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6S7LROd5ZfKdyQcMvmzqXQxaxuf6563a7I6V5Rx9s73dfgz38rDSJdWh6oTxnbmKE29OWAVRGn9+yW7sd3KSTl4Mv1Pwt2+UF6TvhoB/keC/GD1AK+J64gY1Rkfc7De/jFZL9aFzjdM81VAVeADKY2m9TE1BP4Lt5cfcrXUQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S5JMZypT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F2JDP67V; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S5JMZypT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2JDP67V"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 53AB61D00100;
	Tue, 11 Nov 2025 09:37:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 09:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762871861; x=1762958261; bh=wIDpGnXeij
	axUbhDCwbcsK7V/8n9wE2bVkkEItxSr38=; b=S5JMZypTX/hKleNoBc56opttDi
	S4MiwRZVF8xyGn8tng4zwhqRRQIQ05SYS0Xc5QeMSqfQwrmFSs+63KKL9av01/A3
	ylUMox1sEEFRsDTxYL97stlfawx5bvmF50+bA3haOt4R4R7u9a9QWbrWeKCH1sIG
	cFdLBprTKTuJswEhTfZ66SjGVn202g3cKCuKAwHqrQIMK6yGBTJBsMzunoi7gXVP
	bbEq4i085p8qwTjgKLJlD+XXzfj4xXmp2pM8x6qM3Uvcb4zcRA7eXoPmeWmW112a
	MEMctos3hQUO/aumUJTfOi7IuRObJXM4i6w7/jk9oiwQ4D2yEpnpYgck2Frg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762871861; x=1762958261; bh=wIDpGnXeijaxUbhDCwbcsK7V/8n9wE2bVkk
	EItxSr38=; b=F2JDP67VeEj1JNG2VOCXbMMu3uC4sZeQi1p7CNczIc5uM/hJLBR
	iOHVVOCJw2egeHQMgZs/mam/VhA3MDQwKr3F3KTb43kSBESAv3LDdz0e2lTVGTvw
	MoEbZxzOw+D/+4ry+6ThnN5Wu/H7sxmuT2TOFJVu8H+OJb7PcomEIEuMqjHsWQ3/
	KHuSvy8vfWmG1VPWNoQOb+2MofkFl+r7yVZ/MR49pw/cA2f1fIO+Qg/zyuKsG4Wc
	5z96Mta4lJGd0rO+7qV53PySLJsBbdp/1sPCWwyXvJOUmGSZrz3TFmYdsAsr0BAA
	4K4K+BsuzkhbVpURJNvUdp/DoqWB8pK868w==
X-ME-Sender: <xms:NEoTad5esTzXUIY5zBlcdGjQED2h9HyPcYYOIcMl0mKlMKQ3KcmapA>
    <xme:NEoTaR6Zl45tD3SEioLMtGMm_QB6cedm0Tm4ruGFfrAap-YHMatUIX9jemRb4jDww
    kHKmSqsAvLou0Jz_JRRSs5Hlicchjq6WgZX-LVISKGH31Whg4u_oQ>
X-ME-Received: <xmr:NEoTaZczr4NBJl3WWFGGLVIFcC9_yndEhj7o54Sh5FSkvJlPxBzr6JN-CgC_r2-TL7G_eB5GU9hOdHUdMbkS701tF7mcga1bUBk7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:NEoTaVCvRtS9xh77qHl3D0sAwIGZgP0WaKkdRWD6fdpwbZOsWOdoPw>
    <xmx:NEoTac-6m46LnHjFC8BNsZkW3jFVwS0Zcn8Bpvoj_jcIKhHGOlElNw>
    <xmx:NEoTaQLSjqnUxNCESG7nZ7aW8vNKYWDRT_1eg80AmbjEqiL_7igCxw>
    <xmx:NEoTaVhKQGBZ3cXo95nngXXD0HF4XziXomVacPBvm80A2jFaLhjHBA>
    <xmx:NUoTaY8cB15A37o1mZ48XrIMf0pt_wjOVLCsfz8Yh-vjfLaKJi0URgex>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 09:37:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 04/12] diff: fix incorrect counting of line numbers
In-Reply-To: <4506b9c3-f4ae-488c-988c-e12b2d95195f@gmail.com> (Phillip Wood's
	message of "Tue, 11 Nov 2025 14:26:01 +0000")
References: <20251104020928.582199-1-gitster@pobox.com>
	<20251104020928.582199-5-gitster@pobox.com>
	<c41f3c65-d7ef-4e73-a1e0-03540df0b212@gmail.com>
	<xmqqjyzx213a.fsf@gitster.g>
	<4506b9c3-f4ae-488c-988c-e12b2d95195f@gmail.com>
Date: Tue, 11 Nov 2025 06:37:39 -0800
Message-ID: <xmqqbjl8y6rw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 10/11/2025 18:29, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> On 04/11/2025 02:09, Junio C Hamano wrote:
>>>
>>> The "\ No newline at end of file" line is an annotation on the previous
>>> line in the diff so why are we incrementing any {pre,post}image line
>>> numbers here?
>> 
>> No particular reason ;-)  As I said, I do not think these numbers
>> are used after these lines are seen.  At least this change makes
>> these unused data incremented in a more coherent way than the
>> previous one, which unconditionally incremented the number for the
>> preimage without even checking which side the "\ No newline" is for.
>
> It maybe coherent but it is still wrong to increment the line numbers 
> here. To be correct we should remove the erroneous increment of 
> lno_in_postimage.

Ah, if your lno_in_postimage is not a typo for preimage side, then I
can buy that and it would be even safer than the version under
discussion.  I do not think anybody has audited the code to be
absolutely sure that the existing increment for preimage line
number, which we think is wrong in this discussion thread, is not
compensated by something else, which would make removal of the
increment break it, so in the absense of such an audit (and the
theme of this topic certainly is not about it), it is prudent to let
this sleeping dog lie.

The primary thing this step needed to do was to introduce the
last_line_kind member to the emit-callback structure and switch on
its value to allow us to process "\ No newline" differently
depending on what kind of line the previous line was.  The
"consistently increment on both sides" was a "while at it" change
that does not have to be done and probably better left out.

Thanks.
