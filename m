Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB002D8767
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972470; cv=none; b=uf69zlMLhoHvVgd9XgtAeBjWdrsSWumAXS0NgEEdEVlOpEEcxxVGqy3K18euliz9T4cckWG4g/syS9+TTeLSFFqgX/t7Ao46nv3aHjKBBnfnARNYtexgsZ8EugeqvPEvftJNuvFMIcjxExB2MhdCl1KvYO9Gd4+6NKS4pQXUYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972470; c=relaxed/simple;
	bh=l7Do6yKq7x6FMRj/NmAGnHmoke4WHQLiMPE1nlTORWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UM9PQnZgKdC/V93xFZMONaHhFOIsEPA+WMdzHooV2M9dc+s5P4jkvDV+cI2l5mAqBFEXVsYAKRkmzGMFzQd3BGxEncbezr/LZO4C6wJ3YGEXe/gYpInF3CuPklOU2H9/vob0Q9OiiYbdQleDhix+Ne1d1xGoYPS4JUfZah4dmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=I5MPIb+g; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="I5MPIb+g"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 3PE2wlM3l9QrZ3PE4w26QR; Fri, 20 Mar 2026 02:04:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1773972276; bh=Xo+EDiYbte1gbtVaqBabZjmb3bkxbQa+KWQW9RVW8jM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I5MPIb+g570+XXNcx8YgaEmbta50bOVeoDT3vn9sNPe5wCt2j8TS2pezIwgtDAaBz
	 BClilaXgVO/vefslF7ilOwVqqoF3FprrZwGEdKH473SjtCyphLRm8b/qNPUXiFidYr
	 y2TvFvZuZXrpAcs93k3SxagK2K/SMKAs74AbjFL9wgIfKUCLQ8DotvvY5+8M0RjxFR
	 ZSc+AReHcoiJN81sdMw5AAd7aEkgtxk/PI8n3IvCaG1cYBrN2XArcufpsavGiXvU7B
	 Ps/TSMQitsSjiPqswzqXSZldldIlClOSFMMtaeFuu30a6saAvTaag8pNu/Upbw/5cS
	 x/iGf5w7WOzqQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=C9tKyhP+ c=1 sm=1 tr=0 ts=69bcab34
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=0JNgP6TtcceL_STRZ_oA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <b2656d8c-7878-489e-a78b-ecb441570bf6@ramsayjones.plus.com>
Date: Fri, 20 Mar 2026 02:04:34 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: [PATCH] object-file: fix sparse 'plain integer as NULL
 pointer' error
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, GIT Mailing-list <git@vger.kernel.org>
References: <97c623fe-4e03-4fbe-a6af-9c01c101bae4@ramsayjones.plus.com>
 <xmqqqzpfgu5s.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqqzpfgu5s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKnIBECyDWGcu5vgs4o8XbEKV+yfOfYz+xdUYCtwZRTBrJIyOTsxq51dyhsx9oWVpUvOPKNe1ocQNZgSRJ412xTUdRReVAJqe7mDKNKRqOE1Ulrp6yUu
 pgk6iXcus0KZDdwimdpv7jX5TenLAvxCZmx8N14kjdim32jUzsjSha/uPznyzZ/tw8L6cDAOvyew9HGrct5A4RhdxRbsRZhrXNE=



On 20/03/2026 1:35 am, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Patrick,
>>
>> When you next re-roll your 'ps/object-counting' branch, could you please squash this
>> into the patch equivalent to the commit 2b24db1110 ("object-file: generalize counting
>> objects",2026-03-12) in tonight's 'seen' branch.
> 
> The topic being in 'next' since March 17th, that is a bit awkward to
> arrange.  I can queue the fix on top instead.

Hmm, odd. I didn't do a 'branch --contains', obviously, but this only started tonight
(and I built git yesterday - master, next and seen), so I just assumed ... ;)

Sorry about that.

Thanks.

ATB,
Ramsay Jones


