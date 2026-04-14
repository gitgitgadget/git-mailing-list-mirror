Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE62B2FF160
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183818; cv=none; b=rdsmUB9PwFavaOH8cm8JDkxju1y1dHDeXPUVLic/i9QbjZkeH5Ge5lcU1WCzJerOxFMX1iUdo25ZO2Lsnn9F3rdV9WXKSsKADRtV5/7Q2mWqm143F+y6HGGF3R332eQOCc1qiQaaNmdoxdTUuKuiElJdSh31ZNiNordIG8YetA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183818; c=relaxed/simple;
	bh=CrgokR337bV2UBflUCDO7Qz6xKwkWYBx3XTwAfuT7EY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KF3FHUu/DQbZlgvIOUDFavvI41rqYFpRZ5HZuKZJ2Bz5NfZp7p7BVDsnSJBI29LHNIGoNmuLDC8xVqLlHrpMXwUwQQIF5zzQIuNurIJeuAgd8iycqBVpnC/FmQ+0IHsxmqnZhg4tag2nqDiMU81LtknKRqGis3ZMqASsGMoVK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rQBlj3sy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eVROtPGy; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rQBlj3sy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVROtPGy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E22FE1D00029;
	Tue, 14 Apr 2026 12:23:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 12:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776183815; x=1776270215; bh=h6SAVt5Z/Y
	QAgYDIhVWRYGhQveosZGLOpDRyn+a2lw8=; b=rQBlj3sylLX/HFcn0OtJ2YTX20
	0qdxHv7+GAx8Dz87e5OXbvejiq8yktvcq+gUlUwiX9WWzPqvZhTCsVn369DgqDLE
	RPYpM/mCIYAzqUPqHtEQBwRaUJtSydhbVVas7KEtqFOFyo763l2mCpok0j6Bxurt
	iQBOZwhIM8q1b3ulWuF8I0Zti74VP0b4vSF+b6F2JHOB/jb4QuWlBzd7yVJJcVZ0
	CmhNpgf2XBBZpsuLTqcPnHEMqlSSrNKQc33pHqQhutSQ4d14lGSTTmMc5O7zmfV4
	5g6gvWgjJ8e8KxrTwN+aryItqF/KtfB1hyfglpouCsmeJ5D0Ar5JoFOKiKhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776183815; x=1776270215; bh=h6SAVt5Z/YQAgYDIhVWRYGhQveosZGLOpDR
	yn+a2lw8=; b=eVROtPGyJ0q28K2eYcD6w7idmfsXpC+EKkk+pVpbEBWX9vVILj3
	sSIafA5lC6+UhVEOaSe/qxN07y8JnwC3HGpaOiDHNlMb3Vk2BdOA8l/2dqn3ssX5
	Dku0nZFR081LuHNZLv88E2A0mT0xiXhsgYVEqrR4xV6YzZQVOybmnCKGjzquGcBh
	tDuIJ2HjmAt6P73SxzdLoqVlq/ZYHtMZR8zYDV1YIFp1A6JIU2e3ba3M0YVX+vX7
	KOwpugSzfyz5ZQTeQWNBeWLOK9Vvq6lIHfBq6y5NpJgagBS8JDcBtsxFOkkjlbPK
	HcqC6XiLxPPq27yTttFHg2dnS3Tm6ucgkyg==
X-ME-Sender: <xms:B2reaVvXtno76Ku8F83fDLOnm4Zio-E73TEn2QnrQVAqFqGD1PekpA>
    <xme:B2reaQt4B_YapJvjRI_uK_p9goMCkTxF9coW0ozPuncE1uSYbPNf3QgXRzhruFppn
    QlDZbpvIGTCcjZmp9mdPZcI50ezNqLpudWT8Cow-CZgzWABegF6>
X-ME-Received: <xmr:B2reabDab5affK4fuEP4j3xiY8xN7RI7ErVtGTHr7xdKZ1xjzlb5mOMMf7BcN0dLOerqAp_gX16lVdqUnK9-ME7aOBRsZXaDrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthh
    hrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:B2reaSOrCVVUo83COPft3_nhSZVAmfhCS8KKF4HutFAfvhow3JOhhQ>
    <xmx:B2reaUwk2EpKndy1BNI14M_bl_MmFQIlaefHxVSCAqeDHIDiN2pZUQ>
    <xmx:B2reaSUcAb-XdddZ-bDjBKBOuEmQ_UfamQOI1Fx-nlVWT6dMGIq1KA>
    <xmx:B2reaWOVuM7Xl6lwEumq0jWwPxH9aliImqIJzzXXPSyx4B6ut4PG0w>
    <xmx:B2reaVbPPbivcSkt6P7ezLVFdwgL7ZykOKB2gXKmL4L4yv4KkRn9temK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 12:23:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  Jeff King
 <peff@peff.net>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v12 1/4] stash: add --label-ours, --label-theirs,
 --label-base for apply
In-Reply-To: <d5a47638-545b-44b3-9da5-803c06b3f98a@gmail.com> (Phillip Wood's
	message of "Tue, 14 Apr 2026 15:05:39 +0100")
References: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
	<pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
	<9ab5431b4773c29097ae9bdd497822477c7ba56a.1776171585.git.gitgitgadget@gmail.com>
	<d5a47638-545b-44b3-9da5-803c06b3f98a@gmail.com>
Date: Tue, 14 Apr 2026 09:23:34 -0700
Message-ID: <xmqqbjflcxyx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +static int do_apply_stash_with_labels(const char *prefix,
>> +				      struct stash_info *info,
>> +				      int index, int quiet,
>> +				      const char *label_ours, const char *label_theirs,
>> +				      const char *label_base)
>
> There are only four callers of do_apply_stash so it might be better just 
> to change the function signature and update the existing callers rather 
> than adding another function.
>
>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>> index 70879941c2..00bcb1f802 100755
>> --- a/t/t3903-stash.sh
>> +++ b/t/t3903-stash.sh
>> @@ -1666,6 +1666,35 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
>>   	)
>>   '
>>   
>> +test_expect_success 'apply with custom conflict labels' '
>> +	git init conflict_labels &&
>> +	(
>
> I'm still unclear why we're creating a new repository here. Our test 
> suite is slow enough already without each test spending time creating 
> its own repository. There doesn't seem to be anything here that requires 
> isolating the test in this way.

Both are exellent points.  

I also agree with your comments on create_autostash_ref() in [2/4],
extending apply_autostash_ref() with optional three or four extra
parameters and updating existing callers in [3/4].

I have v10 already merged to 'next', but I think it is better to
revert the merge and give these finishing touches, as we are not
in a rush to add more topics to 'next' before 2.54 final anyway.

Thanks.

