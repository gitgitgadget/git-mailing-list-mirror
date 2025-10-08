Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D35A1EF09B
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940483; cv=none; b=eBM8DcIXoiMTz3Py6UMXrkLs+CqPfbaZqOdrpON+sO4yMj589dqdqL/NtUjD7D/KJDR38+YzCzXTSN7ricpwG/NTqZhTo56nDi1FsxbxIwd9Efn7y3iOj+c2WgpCuSlxeB9xslQTzIv1POzkMqfUazxlrctUNrZQEpPwVJl0emg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940483; c=relaxed/simple;
	bh=oooAiv9f/1C0GC72i7okeOj7Ey1YP0XZBg2KbJJB3Ow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ex4WVDqcbX4Qzp27Ah8/IBYptS5V+vJf0wu5lTLUamuWpqd4CsHJy4H3w2Z5DFqtsr6d8WtKILaIQ0CwLXiBSjtSbWy3uLsMkfDAXPNsbFk3lJRARuCpNjs50vL92sp7718Zvx2np+XbbNWJWbzjDXqKHMmHps5mRvfQ+8Mlj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MARktrxV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MYzzw4XE; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MARktrxV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MYzzw4XE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 78EDF7A002B;
	Wed,  8 Oct 2025 12:21:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 08 Oct 2025 12:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759940480; x=1760026880; bh=vK4TGcJc+I
	4wQSXVO9xNBvB5EsiS86gl1pJE6vNlFpU=; b=MARktrxVmbT0YCAWfW3btaBdYZ
	mrXFyljfmwrQ6+k9uB6sgoaG3TLyT5v4A0kWBnIHeMmlcHgb5XdhZiSwMjuU0liN
	lPtSRKFX+Puf7RLKsxjE1y05l0u9WfkpNz53XqPD89RG5K8cPSqenH1R9cpDV9e6
	i4I9KoUTHzN198FBWDqTwVwL++Gw8WPf/S8zw/IfBEFhtHX2P+DTUuRQJqzvOmXv
	uTNobESnOf8VGvMVs4TNN3+OWs6L9FafiBpmFxUeLyI1tEQ10Zm38lk3zzel2aDV
	k8no6LyxJOrkJd8h6nV0yNC/uQkCJGeMmOSQaK+ckLaKrAsIT8TsO0/JPw2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759940480; x=1760026880; bh=vK4TGcJc+I4wQSXVO9xNBvB5EsiS86gl1pJ
	E6vNlFpU=; b=MYzzw4XE7awWiNbVzSoWAlZA1ZKzGRGuAPBj8jR3bT9gR3Y2cSo
	zOvbD8AdSgTIj7SUzeKcvfhsqTDpLQv6BcBoCTLYydhlS7Hs1JTBtIGrT0WKLj0O
	dHrSP0JhC/zZCufX7ZnhRgSk014C8YeutIo+b5HNNRgJKYIcG6OCVfgsspeOrd3o
	s6A1ykzQxw6wxf6AHwwknlyH6pXTacUUTbZ6JS0q3EluZcxvONMNFBMTkiwlJsda
	3FbuAbVhu4apn/dOdkYPB8PkFVwDT/s5HnjLb4DoEjVDSnU6C9PtG1O073Ei1kOy
	BmUz9N6C8XzoMDeHTmpJ7Ny5DMgOHpcbHxQ==
X-ME-Sender: <xms:gI_maNjNb-29JSpFCIvoCXUYP35jB9Th-Jaqm1wNj5Br84o9mxaOYA>
    <xme:gI_maJB12QE_Mg7fLn19Dh7HOTWFtX-r7z-KNiBB-sRSuT_lhbLPCE_JfA_Chia9a
    JJzNzyBZjR-tmy78pYILxzs6B89hp0wlJgZ4vx978pL0beCy2oPbw>
X-ME-Received: <xmr:gI_maCF84NeMvf6tMDZ95sQMi2yuRxts0oKZmpLnl8Ik72O9GHyM5Up_1LkjmOsGPqaQvrbdhePa__6DZx2s_ZBAr4u7Gah2-iKn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gI_maBKOpn892L2NALAWuNibi2N3nDe1WaiuVtYKofNk4MwLRSeAbw>
    <xmx:gI_maGnfZz_I8abRIhLl37qijfhkYYtF-8wSF0dKfI3HbjnoS4N_8A>
    <xmx:gI_maJTDVKM8Vi7bb1eq4kXND0u2sPInu2pB67AN6ZERQ7hw-ZuA8g>
    <xmx:gI_maIJRKd-s3wm__kZSZXUw745LctE0xqGHIb_mNgpBm2sL1dFykA>
    <xmx:gI_maJm1qu4iOuebePTk_Evna3MVtJA9C18C2rR8PbmYjuCbaCT1m51O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 12:21:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: ds/sparse-checkout-clean
In-Reply-To: <3537e220-44b6-4e37-a568-cef34a2fddfd@gmail.com> (Derrick
	Stolee's message of "Fri, 26 Sep 2025 09:42:10 -0400")
References: <xmqqbjmydw5i.fsf@gitster.g>
	<3537e220-44b6-4e37-a568-cef34a2fddfd@gmail.com>
Date: Wed, 08 Oct 2025 09:21:18 -0700
Message-ID: <xmqq5xcpgy9t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 9/25/2025 6:06 PM, Junio C Hamano wrote:
>
>> * ds/sparse-checkout-clean (2025-09-12) 7 commits
>>   (merged to 'next' on 2025-09-25 at 00b296f153)
>>  + t: expand tests around sparse merges and clean
>>  + sparse-index: point users to new 'clean' action
>>  + sparse-checkout: add --verbose option to 'clean'
>>  + dir: add generic "walk all files" helper
>>  + sparse-checkout: match some 'clean' behavior
>>  + sparse-checkout: add basics of 'clean' command
>>  + sparse-checkout: remove use of the_repository
>> 
>>  "git sparse-checkout" subcommand learned a new "clean" action to
>>  prune otherwise unused working-tree files that are outside the
>>  areas of interest.
>> 
>>  Will merge to 'master'.
>>  source: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
>  
> I should have checked here first, but I pinged the patch series
> to see if Elijah wanted to give another round of review following
> his careful review of v2. If there is minor feedback, then maybe
> I can forward-fix on top of this branch.

Thanks.

https://lore.kernel.org/git/CABPp-BEEHsFwE-bDjcUoDtAYm9pvVN0tGUaoh0KPEJu23LywOQ@mail.gmail.com/

which Elijah concludes with:

    Yeah, I think I was hoping that patch 8 would instead be modified to
    handle the additional cases (or more patches added to make it all work
    out), but punting that for future work seems viable too.

    In summary, I think this series is close to ready to merge, but I
    think a couple wording improvements to an error message and advice
    message that I called out in separate emails on this series makes
    sense to fix up first.

    Thanks for working on this!

unblocks this topic, I think.

Thanks, both, for working well together.

