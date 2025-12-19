Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67642230270
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 03:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766116336; cv=none; b=VPlxuMks5ybbyVkGrR5WToiTH76DgS7z9QGt019USV8WT/n9Yx3RfRVhY+K90OpzUqWrLSW/HCa91usygfCqi5UoQrcjDXhB4Go7B3RK0olHYsJXYFO30LJdpgOYJqJJx5/TbPTFK+iiOjYel5q8+OOqId4ylMIyjvEaCxR0WyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766116336; c=relaxed/simple;
	bh=E1V62hJQwfpHcVcJOLfWTfXc/hm1LPN0vAk5AX8n1Gk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j/WIRzuxLjgT2Ib4MpwH3HOJ0ZuU6WIUAqRmEDM8cjy3VMKP/BFtLWAErTQu0GorKpXg7lIqamQg4lcy7nC1JQ80e6eFaQgrxk6RK5BpULrqbSfxL3mLA3auV1a0P1fz7miziA9A/5h9GtzDaBd6h9ESaw7q22hSx0YAuMKHdOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gc5jTuIP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OkscbEQp; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gc5jTuIP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OkscbEQp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A9F91D000AB;
	Thu, 18 Dec 2025 22:52:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 22:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766116332;
	 x=1766202732; bh=oGAHmPuuWSCJBxdkE5x7vy9yG/1chnITzaR8GGKB+N4=; b=
	gc5jTuIPUeJ0Xd25+8qhvZAL6AT26dRk0eawgHDKjkkvZ0yJjiclqgZn4ZYwgOAY
	2c8rRf5sd1tbg2KOeGiLbQVXQ4JhBXrSKnAC7gWlIu8t0xvtIIyKOCsATdejwexQ
	ErZHJjn0e/JuzQL5xMO03VcfMtSY64nz57zhC7g1it5vPOeyTiX07wTyadGsZ8lu
	xP84rDuCXkF7FVJGuPocu6XLRu3g9s7mG7zB/+CQgvM07O3sGZ/mbKdFWV5jXZcR
	KEIrl57CbGBuxVbk0N+zvUxhVPBfTWAc84Va5bdMlO3VCrgP9jnLEsVBCaoC5GFS
	/eOvG9Dr4GPSwZfwptwQtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766116332; x=
	1766202732; bh=oGAHmPuuWSCJBxdkE5x7vy9yG/1chnITzaR8GGKB+N4=; b=O
	kscbEQpxs5heAE2H9VdhVMY5JTXDBBd1vG+rewm195Q5S3K19aB90rRP87kH54/N
	s/eNwva+a1TCzANVXmdn7EK+q5YALN54X4+0i8hdbupn3p8eEdLACMOtklFS4yRa
	EzRR7H8p/Q2MxudxA10jO04V1M1USOUhWDbThqdqc7ult0dBE3AirQ+w+IkhSlFq
	laI1livklqE3YJhq8RpiQusvFGDPrUDueOWgEwKEOHxXWl2E9C1FHBJ4CkhdUD2R
	iXRQbYeupecdzOprzVrgGoq9v8eWPWsXfSs5ooW33OInevSMZ/Wp1+RbcouiFpAF
	jtnlI6/PVCZlSj0UW8Qtg==
X-ME-Sender: <xms:7MtEaWWz6eNra6ttIrwTZqtKxq6pgfEnAcak_9G-1x-qnL6o7Akp5g>
    <xme:7MtEaZcG9xOTnjI3cP-HEx2Onb5S8YOD_gaS9dJFATgvC-ZZMOw23ZevuBUZpWuE3
    DFyYMg7_dhllvI411kpJNcnFN6tIiemMHjRN8usx9qJ-dQCxFqGuOE>
X-ME-Received: <xmr:7MtEaSsLYBhDWwpgt4R-GSu3Ey9j9XWh6UCj6OWs1H2TT0Aoyc5bTMrXW3UGXv4JwZ8SE9tgttgO54e4srK6sfMnUqFO4PDdKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhfuh
    hnnhhivdefgeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:7MtEaY-NMsZzEKsa79Cavr4iBJ8D_2EkEg5t_6f-RD8bi8MdkQ759g>
    <xmx:7MtEad18noWtE4vYzW84DIndW2JPBDERPODP1RSJWxz2hLrglU4Zpg>
    <xmx:7MtEadARYg4j8rPamMiWZBcGwIyuAD4soQ8FWEQZE4VDDDkfDL5kSg>
    <xmx:7MtEaZe9u12B3ZSsMewSVsjzgGeSZM7jBitradI5U4KBauTJv7i3YA>
    <xmx:7MtEaRaxqGehB0xwylbqHov397mYMtJUojQjMaqnVG85OdIOVn-rIlUy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 22:52:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: AZero13 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Greg Funni <gfunni234@gmail.com>
Subject: Re: [PATCH] repository: cache->squash_msg is freed twice
In-Reply-To: <CAPig+cRsKGERBk2pVotrKhhy5FCmmrQODTJEgkO8GuTY2SLbiA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 18 Dec 2025 13:18:32 -0500")
References: <pull.2132.git.git.1766071566022.gitgitgadget@gmail.com>
	<CAPig+cRsKGERBk2pVotrKhhy5FCmmrQODTJEgkO8GuTY2SLbiA@mail.gmail.com>
Date: Fri, 19 Dec 2025 12:52:10 +0900
Message-ID: <xmqq4ipnxh5h.fsf@gitster.g>
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

> On Thu, Dec 18, 2025 at 10:26 AM AZero13 via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Thankfully, it is set to NULL, so no security consequences.
>> However, this is still a mistake that must be rectified.
>>
>> Signed-off-by: Greg Funni <gfunni234@gmail.com>
>> ---
>> diff --git a/repository.c b/repository.c
>> @@ -349,7 +349,6 @@ out:
>>  static void repo_clear_path_cache(struct repo_path_cache *cache)
>>  {
>> -       FREE_AND_NULL(cache->squash_msg);
>>         FREE_AND_NULL(cache->squash_msg);
>>         FREE_AND_NULL(cache->merge_msg);
>>         FREE_AND_NULL(cache->merge_rr);
>
> This mistake has been present since Ævar added this function in
> 759f340738 (repository.c: free the "path cache" in repo_clear(),
> 2022-03-04), so it isn't the result of someone else coming along and
> adding a new field to the structure which needs freeing but then
> botching the call to FREE_AND_NULL(). Moreover, this function does
> free all the freeable members of repo_path_cache, hence, nothing is
> being leaked, so it must have just been a silly copy/paste mistake in
> the first place. Hence, this change makes sense.

Thanks, both.  Will queue.

