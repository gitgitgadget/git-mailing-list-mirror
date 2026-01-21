Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70023A9BD
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014316; cv=none; b=UzryzGiKtWj0GElVm/0ggnTYJ7Jt0UoTf7DJTRKDsgy4HSbBORL4NKvdl0qazlv743mmo2G0nKNZtryQT8o64qlvtpmSERli16h7v4bHnm141Llh8gmc+D3/UGaXQRLvmfEgp03C+7+WVNLtoD91EWmJwm/6ndghGmJHh+9sDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014316; c=relaxed/simple;
	bh=2UXs8SmqM+unxzt9ZZMC3sep2XHZzPgVXj6SIzs5rtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HJMWfXhJJx1OEC1Mc8YEB+xHkbH7GLiBQzCG3e8JqjEdLCk1LwdsmM/QTCerKETD7xWcPFJhgLhAs8UR193luS5GRrH/HierTmWX86paVfmkFOO0C0UDLIhbZmvysoCdtZXCqjRPry8Tej8Oi+6kYXCRuH0/0L1kghgiMTr15dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rgCMG5D8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z/jIrAxM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rgCMG5D8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z/jIrAxM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A141AEC00BB;
	Wed, 21 Jan 2026 11:51:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 11:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769014313; x=1769100713; bh=2UXs8SmqM+
	unxzt9ZZMC3sep2XHZzPgVXj6SIzs5rtk=; b=rgCMG5D8SmGvdMMqVsaE9WQvfQ
	CiDT3Dtzw80VrPS8gnQTF9aCCnUNrwQmOi95y/IZgvrTfg7dFH2RFavcUqUWBVPW
	JL9KfPSjTnqreJt/X4YPVzP/duz5x/lMEge6lIuMQTP60xJXXSXR3j8wrtFPT/WK
	Css0wYkm8nHe6obgw2Mfl11dlked6JErtiQ/mrSchzL9cZHcM7YDowJycZLtnnrS
	UB81HubctmIj03VGVZNL8zr2zX7XgZYgi8K4DqzKD7NKx4er4Sx8Zj2XKlmZI+2v
	HmPwGgRAB5O0lg0tv0MiW6It7126j7Nh9M23+gVX7ol2FCXWrDFyNCMA+yGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769014313; x=1769100713; bh=2UXs8SmqM+unxzt9ZZMC3sep2XHZzPgVXj6
	SIzs5rtk=; b=Z/jIrAxMEtc0gBkS5XjS4/3sHyBuKFB98B51n42O/DNYuFV5PLw
	TfFnqum2oL1BQPruu8+hGejXmCirEIqyNjMGWPxoaVvxEax0xYWRvLBhYrxM2NUL
	u8RWbz4/Tp3zHsKA/3WM/Qh6PyEJwwq5m9aEAB3gHrgNw1+UzLnRYPtHivoCme5w
	RxQuqNBP88sU+9lfJ7nJ9S3fminWRmvJeuIFzn7Uwulu5GHqBl/+KUlt4q+qvaBs
	rgNLFYq+yB8SuZTa2oHu2cnVrhlKaRM1sN5X+cytwMXsfOltCfz/PiYhgFay0SNp
	WMjXdGvD0ic5CKjJFsB51+/TTUlkf2/0Pwg==
X-ME-Sender: <xms:KQRxaTBxDYI0YiBZvd4wQMRMysO3daFpKCbmdqufmvd78bvQ3pHP-w>
    <xme:KQRxadOSG2Pi97mhyfTYafydbjDrMv-l_4Vz5FBmyYjoLz7Ab-ELgNJfiXAiSWXI9
    1exnhO7gMRjMq895a0uXrMpw5O6lnWMvqVKqB5PxegqeCX3UPAb>
X-ME-Received: <xmr:KQRxaYZw7pWS_8l5WLk0XOCxTdr6aLQgP3gE-oerEsGusLp4esr15GjJ4SD6OaZbQcNKBJo45Zlj_PWUynRAdqBOdBoELhBkbu6KFEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htoheprghmihhshhhhhhgrrggrrgesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KQRxacu8E-PicqvPXrQ6S7giywND8CIXsNokmb905UkI2lEdcRdlmA>
    <xmx:KQRxaaOTn-ZRA7m6p2JLjioCNEUtP-EF5EablhKBQP3fCQCoGG72Ig>
    <xmx:KQRxaT5tCpRhBe_Uc0iwkNDlb93zf_diUBbhIHnH-C8aXxYFuXOBXQ>
    <xmx:KQRxaQSuxu31wHc37H3EYk47avjOJ-iZ8umHXXj_sw_L9nfD5wDu3w>
    <xmx:KQRxaSybPvxs_DCBaUk2z0cbvFOAF9tINE_btfQgG-Bm5iQB_KGozo9C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 11:51:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Amisha Chhajed <amishhhaaaa@gmail.com>,  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v7] sparse-checkout: optimize string_list construction
 and add tests to verify deduplication.
In-Reply-To: <615b31c3-a47a-43bc-8dcf-7943ead101a7@gmail.com> (Derrick
	Stolee's message of "Wed, 21 Jan 2026 11:28:06 -0500")
References: <20260120153829.48044-1-amishhhaaaa@gmail.com>
	<20260121130005.72375-1-amishhhaaaa@gmail.com>
	<615b31c3-a47a-43bc-8dcf-7943ead101a7@gmail.com>
Date: Wed, 21 Jan 2026 08:51:51 -0800
Message-ID: <xmqqqzrivrh4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 1/21/2026 8:00 AM, Amisha Chhajed wrote:
>> Improve O(n^2) complexity to O(n log n) while building a sorted
>> 'string_list' by constructing it unsorted then sorting it
>> followed by removing duplicates.
>
> Thanks for iterating on this. I think v7 is good to go.
>
> Thanks,
> -Stolee

Thanks, both.
