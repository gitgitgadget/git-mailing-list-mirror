Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A3176ADB
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612292; cv=none; b=uvzGmpntSMr+LUDxEqnvrzGq6CLh8LkOTySiEzhPcbwY3F2GRqjnu70xNctcC7pHoop6QkP+SfbMJK0GgP0+ramFtjXws3SdmpRaeRJvlYA5U0rRpL4P8jq2MKJkW0xDbLsTlp05+QN8J7SPUd4PIYiQYQXAMd2QvqigcNtf7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612292; c=relaxed/simple;
	bh=HvjykXrz1TL/dxyaNxvxjGR3csePOM8So3PlrgY0uVE=;
	h=From:To:Cc:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=A67HeMkKQ8hAphKJtb0FHsS5UL8TFjw/pZ/zxQ0/qxgjJt50MSrvixUmcAcXfUUDSlwb+k6hXsom10mWafHjCAhFaib5LfxwQsGtLy1eLdSKN17qO69dum19GuD/kGHYaVuNMV+8NFvxYpmyJlEEqCm8w2bpMmXkik2KpVakv0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V3KgDJXZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c108A1yv; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V3KgDJXZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c108A1yv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EDF1725400A7;
	Fri, 30 May 2025 09:38:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 30 May 2025 09:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1748612289; x=1748698689; bh=uzvwW5VlqnwliEl/X3CHF
	iAKqV55wULMLYdvd3rEr5Q=; b=V3KgDJXZiDKLv4MX20A1YVSE1E/Xp+ECav/7v
	SJ2nCyvK6dnOI5GsJp8Ju8By+GEK6Vfvqbh7qSUxZuOpdwimoC2Cu0zhmaQlvFWr
	zLkgnTIMMvCBTBdREjC5YzsWmLkWnp84B5QwUnpIvaGPDI6Ycce09mI2GWUc4Ht1
	kAnnTke3A3FlDcxM4M5bE1Sl9GVNqoxIv0diX3NsFV/gg70AtR/qUcA+aLMJfUBt
	kiBn6hDi23I2iWvixgNW82U+wrCXDv/kIHrp8z9psmg1BtYgrv5cHjlL+2ZyrJUE
	wqWfiOn9+OhWArYmuNJFeLqiPak+YrSt8vQX9NQJLqA6y165g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748612289; x=1748698689; bh=uzvwW5VlqnwliEl/X3CHFiAKqV55wULMLYd
	vd3rEr5Q=; b=c108A1yvKJEFJnJPmnBSQE3Fm20dt6yhTsxwj+d2dwoFqfGXdsk
	bTmP2PuSoGKrcCjFqxaUIF0ninL/3DeREKZtq5venQFLhxlf++qTPlyfih1mRivb
	HfdhRLk/pUSUWgHEgFcscZ+YkescEeWIkPTl2ZYlh7SHQpgt39qf1XiGCPA6wweP
	wI2P7SJ04dlA49mp6gbSjLnn+vEVafT/n9+LrtHrJH516Rbkn3QMF+Bt1blDmuhV
	S4SAtgrWspRFTcl5pvzW2H6p9uF5EfrBWqXro+6xIUSLtza8qRx9/OXtPvUFdEXI
	Z6V1uwnH2QRiyzxQY+miqTc7sD9PAczfbOA==
X-ME-Sender: <xms:wbQ5aEvCnqPDZbX-v0LSBELFORsxatxXm-qtPVy71_D9ut2DDvKFwA>
    <xme:wbQ5aBc4Qrz_2yOIsx0WFzL-sxv8mwslIWpqU0EIuje1tsq2Nyiu80ZLOV2ECvBR3
    3PctXYjiUo39nDxuQ>
X-ME-Received: <xmr:wbQ5aPzjKkVO8x6LfCr0gMjetXmHJNELSCy82POtPDHTHyQE2KvOCF1btgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleduheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufhffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieegudefueei
    jeejvdeffeeiueetkeekvefhvdfhiefhjeekheehgfehteejleevnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehk
    ihhmfiiftdeftdeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wbQ5aHPmSvWhg_fqS-q2ggI5tHB1BKa3xFf6FejzDxvUP4dwKOhGEw>
    <xmx:wbQ5aE81NyTHaMRGD2k5bgv4-3nuTndIumqhheRN9m7kHVtxXfksrg>
    <xmx:wbQ5aPVIIS18jITV2-zL9uNSAybERvoy7XGskQNuh-FeePARYe21Bg>
    <xmx:wbQ5aNe_MUmBk_Wq4xUikzdB4kTEH5w-vycItuef_aBvVz819jUQRQ>
    <xmx:wbQ5aN8f3zD2eDf1enQAaByoMkGRrtVxNH9FfHZd5YNLtoanW73LXWL_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:38:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: oneee <kimww0306@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Josh Soref <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] doc: sparse-checkout: Fix list markers
References: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
	<d8d8c10d-4f4f-4fde-8b91-b979e2931fad@app.fastmail.com>
	<CAPig+cTdN=x2GXGW2p_g_k4jgC0eQmjW5zLsWhJm-PP7eMBTiQ@mail.gmail.com>
	<4c1f645b-42fb-40b9-987e-08ce9e057e01@app.fastmail.com>
	<CABXyHXoCuwAUqiQPxE82mV4n0PQtY1zopD+rJDb+oyTkR8qwyg@mail.gmail.com>
	<CAPig+cQbchWLMH+pTVfLHwFshaex2vhC8Pk57EC4U-vch00ZDA@mail.gmail.com>
Date: Fri, 30 May 2025 06:38:03 -0700
Message-ID: <871ps6b4n8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> You're welcome to submit an additional patch implementing Kristoffer's
> suggestion. Normally, it would make sense to send them both as a
> two-patch series, however, I'm not so sure that that would be a good
> idea in this case. The reason I question it is that the original patch
> is an obvious and uncontroversial fix, however, Kristoffer's
> suggestion -- because it is a subjective change -- may get pushback
> from reviewers.

I had the same thought.  If I were working on this topic, I'd send
the original as-is with the suggested name fix, let it graduate, and
then after all the dust settled, do enumeration-style changes as a
new and totally independent patch, which may cover enumerations
other than this single instance.

Thanks.

