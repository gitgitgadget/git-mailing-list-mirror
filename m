Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294831863E
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734570630; cv=none; b=OrJtwhULjDUtNHVIDGwaEhfmRCw9Cwn7vlUvxyf50sJ2tDSsEtPXItMLT7KJ0W+URZzblknZiwMmOue2zFMMh+APbl1fSyfQ/Dldsf4yGa3UyzDBj0P0GU5/QG9fSdCDqss+u6aUK+b7AmtoWKCPChE9qzQ8v82JRDZmjI/XhQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734570630; c=relaxed/simple;
	bh=Mkp1Bv3nfaLLhqotDt1eGu8+jelEWbE1VfPldSNlLdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bm6+b04gsc55XgFZQi0YgXP/l45/00TpUiimo/PXfDl7aZuxeCTkIKugGf53BnWCN2ZDn1fXpZ6XxAKTP/UJ4vRHf+YnAn+N11PDVc8aFGW5ohUeTavROkfkPIWaFtMLRhITM9dVdR3zXVu3pbbSHdkgh4vuQ76IM5bMC/fWzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R4JRsq2k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCHZPSLr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R4JRsq2k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCHZPSLr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3E56114013D;
	Wed, 18 Dec 2024 20:10:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 18 Dec 2024 20:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734570626;
	 x=1734657026; bh=ZL0oa7tCfjFEc9puj8nXTNmBsh6LPj+OEAAeV+dzNew=; b=
	R4JRsq2kNzkt5Sqyh2Uh/AJOaMWPOv/TOzPKI/+VQT85TbbqkF0MWFqFdVYmTk6U
	PLgIb/QGc+7HiHLEEbys/lMY8cFsf1C0opnP7/BCooiaWvuMOevoT4DcfW/NS7Ks
	91ftLoEjjUEg+rfw6cijjUbaukaXZL13LKPJeeOStGLq0HDQQg3TxJSPtqbKo5Iv
	4LrL4QaheLoSLHEepiJsR5pEW9OnqZdBokPcUalivmcizM4aB0875+D8td4DIE/B
	mql8UEC7CPWHTrRgwaEQKOgpDWJcpFh22VTtiP+v+hnsEQ5L9+ld3E+MZRrXFchn
	71Ywn2rV2REWDw6xF6o4zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734570626; x=
	1734657026; bh=ZL0oa7tCfjFEc9puj8nXTNmBsh6LPj+OEAAeV+dzNew=; b=V
	CHZPSLrS6iqwMD6JdBFdhsMP+AZJT4/Ja3taUgCxnEHgH9TnJtCWI4NbNDSNoQO0
	Oup63xQiYpBTXlDgNyHlpzPufRnxSilb147lqkcyNUD6Vq/l3gKYdCvqlUqyNVsy
	O5pMRE1GZJ4C0BuE1EBD5Ee0la6+cDaZlHKISAxMBPPjnu8/JCH1TTMnsOxTH6XX
	Af5U348DLXUDdfxY0nMvWpEVg7DzkEPQJvXGKl+B751g9Jggmnf7ruMMJMSLIQt8
	LDrflAvUzbPb1jnzbxGytydf7bIrMSftIybqjmJ5QdD2iblCBTkuI5cMJmsT++4D
	Fqo7PP5w0FwPHyGtUNTdw==
X-ME-Sender: <xms:gnJjZ3CqDxbhemZqPMeZFbrHPZSTHqFz59WbhQVyIaZYA2X4YiloGw>
    <xme:gnJjZ9hNAv-ST9_Q5kRnZK17OQ3gMTju4u6UTfOz3g1om8uEmjd3KMoXucjtH00bd
    NLl4Fjl1FrYWEV7dw>
X-ME-Received: <xmr:gnJjZymNa7A15s04dk13MSsvac813s9sTg6v5Mdn5PpwE4NEvhsS_Qgh3MnKo8QaPJ7PP92L8bDDQu-2Pg660wqXmweMaYoERA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleelgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgfhhunhhnihdvfeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughorhgvmhihlh
    hovhgvrhduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gnJjZ5xcTbN5xSL9oxHVes4y_OLuMwo_RPMOtF6VKkZAX4nnRjhvng>
    <xmx:gnJjZ8RaOL2ji04eKS9KTX3yfr2NpBnYIoE4tHVzTKRkDaf5xs9ooA>
    <xmx:gnJjZ8ZZIVgxPQ41b9GVwYSPLtU1WCapMhbuNDO84myus8RJjJiLkQ>
    <xmx:gnJjZ9SuAGbQYDPmSR1g1bY9JiqwDsl6wmwTm31HlWGIye6n9VmCgQ>
    <xmx:gnJjZ_ERrDCwCOrpAaWl11qHSGMAhQWHpB0vCVTsGjRra4wOt81Bu8Zv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 20:10:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: shejialuo <shejialuo@gmail.com>,  AreaZR via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  AreaZR
 <gfunni234@gmail.com>,  Seija Kijin <doremylover123@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] refs: exit early from the loop if it is not a main
 worktree
In-Reply-To: <CAPig+cQd=vc5rte47biFbR+w_DV2OhdCRpC2WH_dKsSi4wvZ2A@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 18 Dec 2024 18:52:02 -0500")
References: <pull.1848.git.git.1734488445457.gitgitgadget@gmail.com>
	<Z2LOpOxu0oAY0DW3@ArchLinux>
	<CAPig+cQd=vc5rte47biFbR+w_DV2OhdCRpC2WH_dKsSi4wvZ2A@mail.gmail.com>
Date: Wed, 18 Dec 2024 17:10:24 -0800
Message-ID: <xmqqv7vgo4u7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Dec 18, 2024 at 8:30 AM shejialuo <shejialuo@gmail.com> wrote:
>> On Wed, Dec 18, 2024 at 02:20:45AM +0000, AreaZR via GitGitGadget wrote:
>> >               if (is_main_worktree(worktrees[i]))
>> >                       continue;
>> >               ret = 1;
>> > +             break;
>>
>> So, when we find a linked worktree, we just return the value. From my
>> perspective, if we decide to optimize like this way, we could drop the
>> loop because the first element of the result of `get_worktrees` is the
>> main worktree. And we could just check whether the "worktrees[1]" is
>> NULL to do above.
>
> You're correct. get_worktrees() guarantees that the main worktree (or
> bare repository) is the first item in the list, so merely checking
> whether `worktrees[1]` is non-NULL would be sufficient to answer
> whether linked worktrees are present; no looping is required.

Thanks for a well-reasoned write-up.

Would many other callers potentially want to know if the repository
has more than one worktree?  It looks to me that the has_worktrees()
helper function in refs.c is a sign that the worktree API is missing
a function.  Calling get_worktrees() to prepare a list of worktrees
and then counting the result, only to see if there are more than
one, sounds a bit wasteful if we need to do so too often.


