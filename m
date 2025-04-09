Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5F1B0F19
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214398; cv=none; b=Sw6gWsG/3xmsP1ALAICbeNEQsCci6PkYTZzQo+q02idMJXHWjsw5u+kGLtZxWIVje84w3yWuYoR+ptU0SWVnHWtNCUcxMDD5KlDgP94VXgEBQqlwETkbdsPI6Tp2WAa62RFuMiR9eoiep5oUXZcRWGZXK/HTqbnQXWETNvgJw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214398; c=relaxed/simple;
	bh=ih+2dxMFVZ+wdYduCSKD9GseRdKzqM5zHy0gcsbICFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hOA3sRHnmxajFn/pPnkILBQIdkVGyx4PCC7dZPGaSf27P5aYIv0ShCF0XObYjFzmuY05T6X9Ii7cge34Q7WFREpPWohzv08/6DXXAW2gGWVC6kOIOgNTur+21A8z85wPqCgVNXX/afmaOcOfUTnDTVGnmyMV1Y2taBT5lYphVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DAiUHo6c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UaXsYHW6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DAiUHo6c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UaXsYHW6"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 7745611401E9;
	Wed,  9 Apr 2025 11:59:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 09 Apr 2025 11:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744214395; x=1744300795; bh=LlfNE0DrKw
	yoymnVhafX1FwGoLj0V10s6uLTB6NnzaI=; b=DAiUHo6ce60OjtQjBKpihx8Ul1
	ZtKUO0Zl6UtVjyevr94A3J0PbtdGz2WayBBZTOaQy4jeUWTx1EzaiPzYL2k237/k
	NQVSMmXReFb7JlhrFhauTZxPpb7MFA3RwhCijVesTM+HnpwnCIcYx+tXN0dLk1Mp
	2lrk0BKvfQgjAPlCgH9zwhD1pO4iN6yOi9veFrL/r/dbvNDs4MP1lPrJWFGPiMas
	PhLPm2+Z1+U98t+6LjxoGUDBeJ2AYTDkPIujd02u86rTQNENorVVIsp1zuCdFnlo
	2pHWbL/+35U+LSnBmyptScFDVuSE2opTp6y9bJRO5vbzlFRKdxhRn8stGC2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744214395; x=1744300795; bh=LlfNE0DrKwyoymnVhafX1FwGoLj0V10s6uL
	TB6NnzaI=; b=UaXsYHW6CRvVWvmkEdMazxN7sfT7bes28eOPa9o8ntYYS5aImgj
	NkerwV16NG4b5KQ5zI113BVSmnL74+S+NYbaGdZX+z4HzxXIuYAqkVKkRqxAUGHS
	l8oDk3DWrw0tRtWsRIUBPdJD3/lR7A9MWdv28RHvIyQGv+izZmWApDaKm/3j98Zq
	hdB4FpwmYzuhn3HIfeQqVoHyOdLbijYbzTeqmeWzh6txZb9TgZOv43tEKfChhq22
	vGlq0WH+7P6umSobJRqGa9IAwEjNd5K03ar/jWDHED8dDgXOxtZ3KFWyYmwIO8m7
	aaU0XL/+g4QNmHKzGKxnOhxLmrl47iPaTqQ==
X-ME-Sender: <xms:e5n2Zw3M-J26XeanFt-7r4HL5kmPxPx0vwIq8NgSQRwW19-2Kjp17Q>
    <xme:e5n2Z7GrNHRzui_2LyKJQSEajNQ6nVE_7ZnFsxqmdWaVvJ7ClIjna_7hi-dBZUTh6
    aZKESJO84ZIQWKKJw>
X-ME-Received: <xmr:e5n2Z454OonrXfxsOfNJl4rBOa8BVllGPLjx36Ny8DGN_uvhI7iFxhFbpwbo2fyqyt2w4KiSXGOQA3a0qHY_qqHGg-k1eaVVzyU->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeigedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvvhhrrghiph
    hhihhlihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:e5n2Z51UAILMfJvJ5vaeVN-Qeh-OpxPYBURBKSifNFBtGu-3-ImV7g>
    <xmx:e5n2ZzHZKAl3HrEj_nOUaFrm14eBQcMafKOP1Oxr7iIVRA2nnqdecg>
    <xmx:e5n2Zy8cmdEPBcV45T4JAoQV-3b_FhYA2OtzJQXZS4AGnz8x4VkrNA>
    <xmx:e5n2Z4nLdP1oSQh0bTJDO0wdJEFtxc04qAQy6Vnru3aI4gu4Rbe_AQ>
    <xmx:e5n2Z8zWXtnmsqZ-6wrQXzUe0PGrYo27JogDy7XtGTvPIGmjk4Sj3Kdm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 11:59:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2025, #01; Mon, 7)
In-Reply-To: <d5588a3d-db07-5c4e-3c22-ad4b751dd3fc@gmail.com> (Philippe
	Blain's message of "Wed, 9 Apr 2025 07:31:03 -0400")
References: <xmqqtt6znch3.fsf@gitster.g> <Z_TAtJ9LEeHo2AQN@pks.im>
	<xmqqmscqyag7.fsf@gitster.g>
	<d5588a3d-db07-5c4e-3c22-ad4b751dd3fc@gmail.com>
Date: Wed, 09 Apr 2025 08:59:53 -0700
Message-ID: <xmqqo6x5s4ue.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>>> I had one question around empty prereqs introduced by the patch that
>>> wasn't yet answered. Based on my testing empty prereqs do work just fine
>>> though and evaluate to true, so the patch series looks fine to me.
>
> Patrick, thank you for your review on this series, and for testing it.
> I do intend to answer you in that thread, and I also wanted to actually test
> what you mentioned about empty prereqs, I just have very limited time to
> contribute these days, so I don't know when I'll be able to.

Yup, thanks both of you.

> Junio, I see this was merged to 'next' already yesterday (the 8th), and
> you sent this "What's cooking" on the 7th. Would it be possible to wait 
> more than one day before announcing an upcoming merge to 'next' of a series
> and the actual merge ? This would allow contributors with very little time
> to contribute a little more time to say so if they wish to wait 
> before merging to next because they want to send a new iteration. 

I know the frustration.  But this is team-work; even if you are
somewhat unsure about certain details of your own change, others
(like Patrick in this case) can help you.

Instead of offering to slow down (say, wait for 3 days after marking
a topic for 'next'), I can say I'll be more careful before I mark a
topic as such.  As the former will inevitably invite "so how many
days is long enough?", whose answer depends on who you ask, and I do
not have enough bandwidth to keep track of how fast a response I
should expect from each contributor.  Two things you can do to help
are to accompany a new iteration you send with some comments like

 (1) "I am unsure about this and that aspects of this patch (yet)",
     to help others help you and the community to convince ourselves
     of these parts that you were unsure about, or simply improve on
     your work.

 (2) "I will be slow, so unless there is capable somebody else who
     can champion this patch without me, please wait before I can
     also say I am happy with this iteration", to allow others to
     either go without you (and take responsibility of the outcome)
     or wait for you.

perhaps?

