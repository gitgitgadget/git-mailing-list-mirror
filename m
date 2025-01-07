Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2751D8DFE
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736278958; cv=none; b=u9VFcwF7jdVdgUI+XyxlUWB6MtoFCOxE0ubIoUvuXcgmWRe3vReJr+KGO8xeXGCzsnGPtsAKsKXQYP2DQUuufYaFltpgl047DoW65ZFA0iw390iGsUEhZTlwZuc60XJCBJ/amb1llajA1orXSuAZ2XQIkpRAXnRPDA+l66g5giM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736278958; c=relaxed/simple;
	bh=btNAN//eqrjMU6d/nFDuPt+fw+ZHIl7z+xIMHlPsaZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hN8ORtwWnxIAC2Cum5Y6Phq8GkJfDqOf74Ds3dPm+OhNPGkTlwuCSYzUeMZtU5rpzYoYHyKQG1UOL/iH4BmtH5oW64ZBo3hirM/xsjw4VNoC6/LRLt8qOOQBxZ4LZQ1cPknPQQI5GnZoVvkxtk0+hrHlCP3XT0sBgIvIGmpzLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bVfybEow; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=labRh1UP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bVfybEow";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="labRh1UP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49B6E11400F3;
	Tue,  7 Jan 2025 14:42:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 07 Jan 2025 14:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736278954;
	 x=1736365354; bh=btNAN//eqrjMU6d/nFDuPt+fw+ZHIl7z+xIMHlPsaZU=; b=
	bVfybEowJUYefG9KOp9QUDO+FTH8KEpxsCzz3UkN16MS+JcDdMMitcaHQ0zhGThN
	UxA5rU7oqA+DOHOOEzncjJuxkdRSmvlLx70QrL5QkMnNXPTOL4LgD+qhCXeR01I9
	mx8YhC3UP4dNIjBbJ5gS4zzf7SXqUuBDxEr1EiKFLwGklqKcDpEDQo0VaBcN0mNX
	kwMCM0Gc9Vpv04K+A2shRUSgfyydd0RSXMSL1W61NCpPuMbhTJsWBFYOCo6bc4if
	j+A2DJz03pJtMYhmF1aMDsXyJ5QukInG9B4Jlp7Ooc+BFEV3g81sR1yuNQMaM5pE
	8/5XKUT78LBhHFAWu29lNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736278954; x=
	1736365354; bh=btNAN//eqrjMU6d/nFDuPt+fw+ZHIl7z+xIMHlPsaZU=; b=l
	abRh1UPT7hmxVoAwZJaDSnt7osvEVmh7wyLWxg9AoMKHrEGkOS//ZEf/HJh89h+2
	oixr1XbNLYBA2VZmbuo3DFH1MnfQ1JZokmFTD+NncdQDWl4H6Yct/WF/w3SHpoAL
	dCkRPtH1adpfN82NKkzd6O5LidHYtCnhhByhf3HlN8iSFnaR6ZFbh4vPPpuZqfA0
	qvHwYpp+XDV/NwP4LkgdpESCb0CyMm8txuYIbOKG5FhgWZo58b/sdYItqAmjX4mC
	KxsMmFrOB88zpdiWj8KztsiwfVf6GjV/k81JxpJThtgifCz7wGocGOeLcbgD1cjU
	OOESRs57p9xC9iBEhYhGQ==
X-ME-Sender: <xms:qoN9Z-TagYYkIs5jfVa3VKtZxnFK8WDHrpHC1zKRvPDoBieMdsWGQQ>
    <xme:qoN9ZzwnGbq0i0d9hWdKFun5j1rlqwwdA1YYx5zpudgqoYIOCPEa8aQtGUDJTBQWa
    dnDuxvS6C1Y6JgPww>
X-ME-Received: <xmr:qoN9Z730pQBAcif3vjyyq9DTFOtSoaWnP6zJ7TdAkw8Qbgv2meRi64BvbAFJsVZQTgIfIoMgNNO7fqNpcfbVHW-GjLoHswmOKb2O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qoN9Z6BuqinJmBccpe0bH0BcNEyd-wytXZsgAYgI7nvEtd1kPbuwKg>
    <xmx:qoN9Z3ieuNR-DUxj8tALBQoh50iJ4APvh1cdHz8bBvRXpUSJ9mVEPw>
    <xmx:qoN9Z2rlgRgVuP0-_COaIZ86jPvbUdjSDYZx-C6tmD2kfbadzAsXwA>
    <xmx:qoN9Z6h7wf85SAEeQNvxWWGhGHNIEFwoKmJLEOL1bRjzpAegNJHVNg>
    <xmx:qoN9Z3fX969BXu0JQwZOHBDsyFScTYPS1T2seAAFFavDJeqD75uZTZ2P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 14:42:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Jeff King" <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] t7407: use test_grep
In-Reply-To: <f3ab08db-5dff-4da3-a075-7e9b3eaf1f78@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 07 Jan 2025 12:01:14 +0100")
References: <20250107071824.GA594237@coredump.intra.peff.net>
	<f3ab08db-5dff-4da3-a075-7e9b3eaf1f78@app.fastmail.com>
Date: Tue, 07 Jan 2025 11:42:32 -0800
Message-ID: <xmqq5xmqs95j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Jan 7, 2025, at 08:18, Jeff King wrote:
>> get rid of them.
>>
>> (It is also curious to grep in the expected file in the first place, but
>> that is because we are auto-generating the expectation from a Git
>> command. So this is double-checking it did what we wanted).
>
> Missing “that”? s/it did/that it did/

It is colloquially correct, isn't it?

