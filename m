Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BE231282F
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782636022; cv=none; b=SaEvdWL4I/q/fACHNi8noPbfNOc9enC7O1xH2vHfZK/iX0sVSDRK9BIdoyzrvLm2Nz6XgrUawuSsEmFJvA6CS3ap9TSJidTzRLzb5l/NXD5HzeTATLaAecO5bJjIJc9EOyBMuSPMosabGqF9deV1+vCOxSHFVPh0i4u5WWDH16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782636022; c=relaxed/simple;
	bh=Nx8Qn/634vRQ2UwC9J6kcwT9jm0ARjM7Je8IqOre+fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TykgnaYaS9NurQ1z6m6I3FEIvJ703kkCm0QUa0GOgRc2NGXNlxO7jbz5RRbz2PS43i2bBXfZNSnKSmeoS7gsEBPifDbAlOTdzclw9tqNizcdFx1EOBUBkGKC6xz/dVZqoSE0HG4LY5pSIYqp+i9Je2JZLX7qpO71ux9P2+aIjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AVlKl3eo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OqY6Pt83; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AVlKl3eo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OqY6Pt83"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FF787A0085;
	Sun, 28 Jun 2026 04:40:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 28 Jun 2026 04:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782636018; x=1782722418; bh=XW7sgaxpjG
	dTrAMImxYBE/71M8xa83QSao1+I/xWuGA=; b=AVlKl3eosXtIqB+GE7GVKy1cR0
	zW+HLS1lLHCD5vf2owEQm4rRS0k7dJI7+gQLRSOYOZ2BjZnp5ZTof6gRXrrQ33RM
	KwUqHo1ulk5I+YAw3nGp6IklhU2YiZfcDWFay8C+jzBkk6BMS8CnJ9672djLUX4C
	WYT3Dm+I7nnMU5DFx5ebT8KQIPCvgvGh2Sq5KBMYfe1/9xzl/0fvHFzZM2dK/Z+i
	PORVc3/9G69xNTXQBQEWdVR79EEr7H/9JtWUIr+DvPdEfPvHuunSlq3+G9WIP2nX
	2us3LlzgcGDJh6CBzgUtsNdeZa3ghBtscBgp4pYJC+iZFeQ5+CHTSMR7JVCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782636018; x=1782722418; bh=XW7sgaxpjGdTrAMImxYBE/71M8xa83QSao1
	+I/xWuGA=; b=OqY6Pt83biA1GCHPvq1hiLpgITuCPEGiggGUQlKbdNI9bJj0Mi2
	tnn3/B5Cfu4lDHvhYKS03nO7OOIn+8LW9xtwyA6VfGThKbUHF8TQ6j8JGKu81Nja
	OUScNDrpFm0rsu1r8www+gWxLhdoHs87+OuNWY2OM+0y6sRx/Sa5I7vUKCwssOfU
	rvskgwEEq2xBRSwxVPmJi/7ghsm+KDIM2qD6lLGp0gnqvmdhrGuvDsYslk6IKgd5
	TP8VXS4lzAHh5kH/jHtTO1wR52VT6hPD5Yj/KdF3lqAgOnlAq8M9iIuQLyxcxstv
	0vqN5AF1891b7N/EilBaH7+Mpcj1kibPckw==
X-ME-Sender: <xms:8t1AapBKb0iY_234CD5bJHxFSYTbHckom47HJ0IKbyM8NH7mVI-V0w>
    <xme:8t1Aamkaif_d6hTJ7ZVyTx1IbuBUBuDSCIVZnl6W0ienkL4PAPvqg1qyN-Wx9Gx_2
    0PqfiIGAUi10nBfiQ404qqaxY1w1BVTyQ629k0Nv4zM3SFDFMnvWqU>
X-ME-Received: <xmr:8t1AaqxSc_V1NjReFXY5WNyGJc6ZOfyfqYZmUE1jUfMOx9ECZRoLA1LFL9aX7nPZXatLbjIyzvJOosw2a3gAmTvhc75dGzeufChFQ1o>
X-ME-Proxy-Cause: dmFkZTG1Lme9D7PmGw9DH9sDD3ikZmrslSVh35vfF7li28uORisRZ/TymxlX0kpQS1sKb3
    DyGe+bBJIxH1W1CHTeSMp8iCMvtrMR2M803mflnGwILbXVz0fkDoA489M5a4FuoOTKMNe/
    3RjYRCnySjQnKhTh2L2bVKV6bfeMBYqQZJDW01+fLibCgSHgwJ15P8N84UP6RfNJiH2EFZ
    QxywHb1+zK3d2mVhTzlIrYCro8/pO1wi5YGW0fiPfhDor+xHD9AJO0sG4mATenLX/816tq
    gbhv6JFjzVGXqsdp4Lqbf5PRyHuCIutY8AS03KrmVCvKkg5epwiScNJxANkaBNec0x8oVB
    z8MrWD5tOitlLLhxEXne8nbH3JslUFI+xGGZAGA6DzPk2cHytd9uQdWyLWf7E4HqOqVQ0d
    mNkPuUzHERyFCCDKn5hq4d37dI8DwuMpUFpvCutQfCfpTCVhMxkfZNtn06dNo7805uqcGO
    ecNoU3PaVRtwVpDCw9si/di3yDfTZVy3bkSCpuT2KwyqHiawFGFLG0KrH63HNQmjfKR5ua
    uEf7SGaWoKX0njOR5TkykFTBO89i8Q+JhK+S5lZWtVPv2A4lAGqVdu7i5coOGUc/UxXK0U
    KuDKAF+mL3c4QVMSDgkcsRXsFrbypgVdUuyxKBfnrRaHBB7h/f9np+tuoOIQ
X-ME-Proxy: <xmx:8t1AagTZ2fHLhSBWYZA8mu-6BIo_IK10KIW6l13VKLzY22R_yJMiGA>
    <xmx:8t1Aai-NqWLVKAt4qkhNl0UsPGpV1TrKC4ryHw2sp-WdcBH38421TQ>
    <xmx:8t1AautUFSG6NpqaD4s9EKf0ZnQboyqxbmMYtxKtzNc0C-VEAy7goQ>
    <xmx:8t1AaqOax9VkIpNpdYdCR1FEuX9B5A99lVaA5e38mPRmkuBnK-L7ZQ>
    <xmx:8t1AamurKnZD6Gqu8JR0mbuwN5UFKelowTmTGn4euPR_bLR82cklTIJi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jun 2026 04:40:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  cirnovskyv@gmail.com,  szeder.dev@gmail.com,
  Christian Couder <christian.couder@gmail.com>,  Ayush Chandekar
 <ayu.chandekar@gmail.com>,  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v4 1/1] environment: move excludes_file into
 repo_config_values
In-Reply-To: <eabb8169-2c13-4961-9b21-f44b1fa66f70@malon.dev> (Tian Yuchen's
	message of "Sun, 28 Jun 2026 11:19:55 +0800")
References: <20260626075037.532164-1-cat@malon.dev>
	<20260627160813.1074201-1-cat@malon.dev>
	<20260627160813.1074201-2-cat@malon.dev>
	<04d1a7d5-ef83-4728-b816-5cdf1cb4aa25@malon.dev>
	<xmqqv7b34snt.fsf@gitster.g>
	<eabb8169-2c13-4961-9b21-f44b1fa66f70@malon.dev>
Date: Sun, 28 Jun 2026 01:40:16 -0700
Message-ID: <xmqqbjcv2h3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

>> Wouldn't we rather want to try to be more strict and say
>> 
>> 	if (!repo || !repo->initialized)
>> 		BUG("repo must be an initialied repository");
>> 
>> here?  Aren't all the callers of this function supposed to be
>> dealing with an already initialized repository?
>
> That makes sense, but from my point of view...
>
> 'repo_config_values()' already has a check for 'repo->initialized'. If 
> we're absolutely certain that the 'repo' is initialized, wouldn't it be 
> better to simply remove all the checks inside the getter and leave the 
> judgment to 'repo_config_values()'?

Yes, that was what I was getting at ;-).
