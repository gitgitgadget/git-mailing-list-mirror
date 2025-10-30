Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BDB283FD9
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853357; cv=none; b=bS6LL/627xgk0QxY8aFN4zvpuzoZJx35KzgUhJ3ntn8lNDkNv097jenhjT0qY9A99tlBp64AY67irNk5dr2NbIrqD8OYE+iq1Es9Kz5s/7hPAecamaz3BKCqZoSXdTfwaOFtrCNqC3juhILvjcpRFDyxd94LmMqK1bQcbisuVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853357; c=relaxed/simple;
	bh=6qtFd1PKzOwW6Haxkx0nzM1QAAAfe+PA0aqmJzNh/ko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J3YQm0o9YfpROk3/KUSHsk2dlU3PVzHI1LbSu4qQyMvAmZGN00qkJlKI6ScjgA4IwfNaChD58p+FUWEChqNZiNJga/0cOO19WIutGolgZrcctGHumIJ51KAaxcinrRjFHGzK2Lg0GC2mn6trttG2QuoeiKrtH94nufPKOmfgYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bFBLTgv5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nojoMtP3; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bFBLTgv5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nojoMtP3"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AA0B7A00E4;
	Thu, 30 Oct 2025 15:42:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 30 Oct 2025 15:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761853354; x=1761939754; bh=6k5b7ckSJn
	hkCmjyT3o/1SXEtFztxShJ9NGgbpp94ss=; b=bFBLTgv5SKkzsR106HZoiEZL7C
	cnQD5TRjC7Jw8rB6sxuCY8ra2CFgsz6SHOaPRRgqsyd+9rR0jTVrfGJa6oA+/zRI
	1akmcoIUlA2VvexOrh8cJR731JHFjY1wwE2UpygNwrQgpK3xTSYUZVOuY9oOnHFh
	YnT6zyRqvl53poD2ZP8rxtnOCudstVEaDLBasZ0utfpo+4Yg8h0iK/ZdmvBshNjx
	6QQTlBdobiz9Lrq7AJpMJzvajgIRYJNnhxCPiGgf9pykNiuoyJDS8MV6Kwna0stU
	TMhapTLfARyjqksZbcHCA7mGcx5hweMS6crVocVpkveYOtY/eywkqWA8VG1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761853354; x=1761939754; bh=6k5b7ckSJnhkCmjyT3o/1SXEtFztxShJ9NG
	gbpp94ss=; b=nojoMtP3PgDstDLosnq2VPFtQeTAa+NLx/3EvSWLVG7yK7mhe1E
	0pNU4W7Rjq5/zwHHfF+jumM95McabxhSsf5TM31U5whujrCaYNNxolyhJFzHfjPd
	r9K5ISoKWfFo+X1vXMJHAP8A2Smbxa2Xggc6FP1DYqegFIAgnzSeSpbtGoPtXefp
	1BkksZU4P5gcUThlpsKY9nWCeGiiDg9uo/MKsRSar57zMRNIdZO7Oavs0WHP/6Yn
	7Yph4Qo2OApynbyHK06NdMGvu6M5h9BdYp191J4wawrdABMi+x3PImLx42PVwUPx
	xBllyIVETDJcKcHuI4AkgyIY5UBLde4uiRA==
X-ME-Sender: <xms:qb8DaaiK8G1DyX6UIalakZt2N9c2uzQvzcZ7Ude6wYRVe5TQrdQOxw>
    <xme:qb8DaSC6DNLIUUetx2Z5_nJpoxbozJyXc34AfdzkFN8EvUg5SZOwaW5wK_O4cPkBs
    VriwUixCJ_1vkvBhZATxUaLGs-0Qbaw5118DYj0qEIkUv8Cpog>
X-ME-Received: <xmr:qb8DaXENDqJ8qT_CdS3c3JYl3PHjhv4QOchNDS2QaAoO-zEemZvJ8uTJhXFaX75QCFiiiJy4HR9O1ekjBTdP-xsnh_jFjbKzuv0H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgu
    ghgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qb8DaSJNW9sVm899D-aOZwNtIdAyxxYmApNPXR1qLpbNc31NS3vFlQ>
    <xmx:qb8DaTmZxbF1_PiLb7E0i-5LmW0dNmAPkKuNV2GiYlNQAtKMxVyisg>
    <xmx:qb8DaSTB7TXUoBf3KY2gHyzRgjmUIOzGoRAqGFSV9axwEUowHKWLqA>
    <xmx:qb8DadKn3F6so5NWa4LjOVwfQ1EOd7v-Uwitewvq9dnEd8KUd5BfSQ>
    <xmx:qr8DaWo8WM7h_yJ_IIwbNWebnBx1eDDLozu53yvFTlgKL0gzHBYDRFq2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 15:42:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: rsbecker <rsbecker@nexbridge.com>,  git@vger.kernel.org
Subject: Re: [BUGS] Git v2.51.2 on NonStop
In-Reply-To: <729f9bbf-b75b-4161-b8aa-505ff906bb8a@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 30 Oct 2025 16:15:27 +0100")
References: <xmqqo6psjq2n.fsf@gitster.g>
	<000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>
	<729f9bbf-b75b-4161-b8aa-505ff906bb8a@app.fastmail.com>
Date: Thu, 30 Oct 2025 12:42:32 -0700
Message-ID: <xmqqecqk5g7r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Oct 28, 2025, at 18:40, rsbecker@nexbridge.com wrote:
>> I have found new defects on 2.51.2 that were not present in 2.51.1 when
>> building with OpenSSL 3.5 (probably unrelated).
>>
>> Many failures in t7900 resulting from the use of test_subcommand ! as
>> seen below. This is run in bash 5.0.18:
>>
>>[snip]
>
> Would it make sense for maintenance releases to have a small release
> candidate pre-release?  Both of these maintenance releases have had
> issues.

Well, that is usually called "the tip of 'master'".  Has NonStop
been having issues with the tip of 'master'?  For how long?  Why
haven't we heard about it at all?  After things are merged there
(which requires them to be cooking in 'next'---oh, has NonStop been
having issues with 'next'?  For how long?), only fixes are chosen
and merged to 'maint' to be the next maintenance release.  I doubt
any pre-release on 'maint' has much value in that anybody who are
not testing the tip of 'master' would not be testing it either.

