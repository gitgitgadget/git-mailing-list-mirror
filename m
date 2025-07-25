Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7D17A2F6
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457165; cv=none; b=mtNYRrZHnFqXk4vBVz5w1+dMR2CheZXtDhxy0koeJZYmiXGP6e9y8Jew2MOLB9zB+f51V00w3FJxn4zPMCHaZ9pBsGev68zPZb5FBq7LWdJib9m6tnRxdpQXK2huPk3PZ5IE6NXZxCRa4SmBbBy1nSTXLmFjg7gF1DWbse8GDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457165; c=relaxed/simple;
	bh=mQOM/ugynMPbKSbMn6u6137cxF5DEYUKPUfxpbF4da4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=as2c9Nyyd66lsJQljI9cOxq4szkqi1AkWyOIA1wYVY1zRtLBOaNlfFb7/ynwH+Wi8+ofBLm0czktVrwLEgVhlISEtoi/a2o6yrVEzkrgezNgbPGARLqz2C2Ww48ELeYGp9lfVcVuLqejOcGawNlEmeYqf0Ms1E9GufbJwFdv2rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jekbt7ms; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ngUG/sNJ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jekbt7ms";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ngUG/sNJ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A32AEC2010;
	Fri, 25 Jul 2025 11:24:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 25 Jul 2025 11:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753457091; x=1753543491; bh=Z7TmnXMwgr
	OkafEjfawPxg02DcAeesesgVUrMWlWbnU=; b=Jekbt7msKAFcH4TaOhDea1enUQ
	TOnfl0KovsWU3GbxGV+47aIfgig/BgR9p8fMW+QG8HZNlb/SsqCD18F3/KW3evXg
	kb6p0DVWZnODH5D01GptLH88R5pUSa4V9cVzsZdoDBCl/vRmHkwDlF1z91z46hoY
	wAMRYcjW9mOHgaIoXunoFQ+i3Z1dSB1HLHJ8NPlZBysJQhtkFKw8GHYF+3swVYLk
	qKixeII4Yw9F/kLOAQ18DD2KBvk//iELHKuWmwX4IigkT7vpftc+pKxd0Dt81Xd7
	9eTfEl+MqutwA+xxxUNn/yCaX4fgOkga3vv0JVaFNZ9jN39wmOMcJoRodTpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753457091; x=1753543491; bh=Z7TmnXMwgrOkafEjfawPxg02DcAeesesgVU
	rMWlWbnU=; b=ngUG/sNJV9LQK/MWPWRmqvSqzU8IYpYrQkx3W2sIynEU/CWX/Ly
	WjzLsP8vSxAA4ckKyunR0BUCgaPPsBD2X/X6QIhZzjmdCACAMFfORaCg7ia++Wha
	2OIkS0PVutn9lzjfV90BRrMT32/w2D6a5zUJVO/bPxYpOXFMvs6XGwL9nBAcCFWW
	OyxwKZM74b/y5Pwt+Yd8Ae/+B+9urcRG74wYae3Fv4XThair6r3QvVJEK23081bT
	sBzo7dJ0keEaHOkaqZ9dMejG+M0ZWr7KJf5TD6CJCY0fRfi1lL11YSj4sc9bBJ/J
	aAOkDDBWZty19K/vpv+xIR4BhpACPJ8/XyA==
X-ME-Sender: <xms:wqGDaL0knd2tXkWScr15gv2G4qaqKbse-LuChrdFv2Wo6vTIBdvIgA>
    <xme:wqGDaN5G25Z6JjfVMIfCIeMXRuoUcrV6JAsB4i6XKzaORl1FDiK-Rdx4KHL8XmFQ7
    ZPuBn6mzIDuF59RaA>
X-ME-Received: <xmr:wqGDaE8A_me40v7jb7enAcCoGHreNMr_UZLcYb0W_ZXFnFMSTQmgs_FVNwouf3Jmgyxjwipw2qcjp9NacVWbm_dizLHjb9hgbMMsopA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehhfekfeekieevleevkeevkeekleegvddvlefguefhhffggfeiffejvdeivdfg
    geenucffohhmrghinhepshgvqhhuvghntggvrhdrtgifnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegtrghm
    rdhsthgvfhhfvghnleegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughu
    nhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhn
    rghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wqGDaEV3G7oSssXdjjChoWWWwyI2Bg4PFWWLD6CV2XFHIurEJRRwZg>
    <xmx:wqGDaHrB3kInqqY2nklSomcrfWUygJiz1Vz7AaS0TfQkZQmbDYz_mg>
    <xmx:wqGDaOm6sFb6ZShLcitxhL6EQgo01V1Qb1U3a0_aa_aCcwYomVpnow>
    <xmx:wqGDaP0I4oIr8VDDP5jK6hik1iaCW7G5jDxKX3mRURGxnKUPZvklcQ>
    <xmx:w6GDaDCciGnedG32IHpAoc9FUdAaN_2zU5mwwMXuFjD-RKSBL78oOuTu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 11:24:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Cameron Steffen <cam.steffen94@gmail.com>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: Show skipped commit message after rebase conflict?
In-Reply-To: <184ec60f-9431-43c1-bce3-405bb6b7f959@gmail.com> (Phillip Wood's
	message of "Fri, 25 Jul 2025 15:02:22 +0100")
References: <CAAVFnNkdgXuUk6ziu5FkB=sAHzEOyiynQpQJFox_p_ZL9VGRfg@mail.gmail.com>
	<xmqqwm7xxn4a.fsf@gitster.g>
	<184ec60f-9431-43c1-bce3-405bb6b7f959@gmail.com>
Date: Fri, 25 Jul 2025 08:24:49 -0700
Message-ID: <xmqqbjp847jy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> probably a good place to issue such a message but we'd want to check
> whether rebase_path_message() exists before printing the message. I

Ah, such a test intuitively feels correct.  We are not creating a
commit, yet, we have message from the iteration being polished to
use when we do create one, which is about to be lost.  The user
deserves to be notified of the lossage.

> think we could also read REBASE_HEAD to find out which commit we're
> skipping if we wanted to make the message a bit more informative.
>
> It would mean that "rebase --skip" also prints this warning but I
> think that is sensible if we're doing it for "rebase --continue" after
> removing all the uncommitted changes from the worktree.

Would --skip even pass this spot in the code by calling
commit_staged_changes()?

I am not intimately familiar with the way how the sequencer code is
organized, and am navigating largely by guesses on names of
functions and variables (iow, I didn't check).

Thanks.

>
> Thanks
>
> Phillip
>
>> I'll pick a few people from
>>      git shortlog --since=2.years --no-merges sequencer.c
>> based on their contribution to the file (not counting the internal
>> implementation changes) and Cc them to see if they have ideas.
>> Thanks.
>>   sequencer.c | 2 ++
>>   1 file changed, 2 insertions(+)
>> diff --git c/sequencer.c w/sequencer.c
>> index 67e4310edc..677d6105dd 100644
>> --- c/sequencer.c
>> +++ w/sequencer.c
>> @@ -5369,6 +5369,8 @@ static int commit_staged_changes(struct repository *r,
>>   			goto out;
>>   		}
>>   +		warning(_("omitting a step that has become empty"));
>> +
>>   		if (!final_fixup) {
>>   			ret = 0;
>>   			goto out;
>> 
