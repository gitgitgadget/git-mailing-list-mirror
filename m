Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F125224234
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535369; cv=none; b=TLUeA7VpMQMYWvCeDGUpaAwu2/oKE9ZfCod+ToowG9LFhSRcJ673DGAXUNK2cILAu+tYFZWq2olq7vyYX3wNNd9FjCcJD/Zj3MjLIgsvpUb3ecI16OQs9cU75HLz3gRw29Y3gw14iQXnJ0QF1/qgcyvSxu+Zcfrb45g3XusepOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535369; c=relaxed/simple;
	bh=WeNkBdRsXGJCnkbORLyWxa+6s4nFMLW1PE9ZoUdPgfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eUDLqMNpO+guYXE10vHY5Q90m1YJjMIGFN1a+7vIRdxVVexI1uzVYPBTEzrOO4gXZFfgCY63HqWQmTNgsQbDGLc3LqUEN2XlePqtdtHhnlcUQRH5bgoKVDe5CU4ChenV7hhxW0SCec25j6kUbKB3Fv/BvK0SphcWPO0XEVBvlzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JS4RuUks; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dO2OKR63; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JS4RuUks";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dO2OKR63"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3417C14000CC;
	Wed,  3 Jun 2026 21:09:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 21:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780535367; x=1780621767; bh=O9R7X4LQ1Q
	/SEKhtcJksHcNTAgvBEbgBBOHz6aqqwMo=; b=JS4RuUksDsWB+lqW/Qaix/uT8N
	hwIe3PWUbNOGbZQhk+DJ8yxjXIXi9OoQO4+sM4H6CI1tSYZ5LsDrid0Gge2N4jl4
	VK02/EuUdPZvqd025FLvD827vLnDmzscFrAD1Pf8jlQ/G6rH7X0RZTH9I2RxRdbl
	aIxcxUM0NXmj7C5XsAsxAY8AM+cMAjjN7r5JXGSE9qAAGz6EZ++EUPoKC/aXTwXh
	Ab141J6Ac4pDJnnnUuFUowfClrntnm2O8jlIevTLoHJ76Ue3XePoV4VLK6jYyU6J
	S5qAXzeaaGqaXMpoob7e8h6V0diXEf8p1l3WXTCal1Ctwg9djhQa4pbVZNpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780535367; x=1780621767; bh=O9R7X4LQ1Q/SEKhtcJksHcNTAgvBEbgBBOH
	z6aqqwMo=; b=dO2OKR631bYggj8d6Yj/xHFXi570dD1eSoCPf/V+v93BNEVLtcn
	aBoCrQyiMV8KNQeo0ABpPe/Cv71XzekOu7huBAb+umPMmcThFKL2gxuh7Bt/2bRR
	YXXyXz5egxkOz3iA0+5zhwxYe5LmRGa6zyMIZedXPa5WEjhloVYO6pkdpcRoio4J
	rFQG5xDRviInfb6CE3zUm7eLRtw3tw40eexq1ELsRAXM4E5SmZ5ZQf9c1KQzK/dC
	4inF5LCpHQDgoz00mmD1UEM0YKdUEVhfo8MNx2glpbN9zMoz5z7aNjGypc7I8Jje
	taL1fVaiUm4RtRylYj1Ah+N5KR1dAVqgt9Q==
X-ME-Sender: <xms:R9AgaqZKZp8WXtg6ZR0bcTxl0DBmLrx4m_sYvel9Txwaq3ulX-FuYA>
    <xme:R9AgakTT06Wm6GUpT2X8K7Rj87ObiHD_0pxQ1cmLgjrrKPGJubpC8ycd7EsyCVAm6
    1Hd1se9LM7_FxYRXrc9TfC9miHZzHZrhVbrSG4UPzAuOJmb33HX>
X-ME-Received: <xmr:R9AgatSewkiQ1PybshAUVaduUuEnvTwjT4NFrO15n8gkXSeexi-IIfZ7vnQVJwXaJT93XVDHXuB6Rn8Xf5O5PQyCN2oCROPnH2Au>
X-ME-Proxy-Cause: dmFkZTEf5jOQN56N+PrC68+68EuVO2CQzF7pUqcSYNt5BhvbaKy9mv5I/xZ0U5LQgiOFAx
    y4vdv6u6jNaCM0PKlnFP3Y10WiVciN2rhgu/o5VB6NT+N3F9ZWF9u2mhTklNOpSFe1XzsW
    Lg2huv7ZXlF3oYM8rQOKQ2ZDcZviOHRRTLS7lT9L4eSlMGcMdkURdljWqE6vPYPhLYza6N
    5FwomSrfGGXvBn/CpC6E+vLK0HqOclsYLaYUZlCyhYeZU2QZhqD9PrZFgcFhrm6A4kMz4Q
    PtISmyAzDaF9uiz8S7yjewSD7mxViYVEc2ngJVywOYjhwVkVLUbodwen+Gi2ayJtKQHoFj
    s1wstld27zntMQBeQyvAa6UyXJVzgLHuSlChsZBua0MRGiWktYnihXmehOkGyN7cO6Crce
    zMtmFhyqifSHBT76B+o+8hSorLinNQiKeTzZHo9FlIarKk06/jOa4F7KERxrwX7b4X+fGy
    U8vaWCwPrKY7xa3t/VzLQR8qm1Ml1vgPr5a2/4PrG3oVDdiacywpS7OV2lsVZghsl2T1Qk
    WHuxxujAaXFbdiFT1vKb4wmaYf5Ov7pAiNtDeWYN67HPYfzdmrufKlvHvTammrUrfDYN/Y
    1xPyssnhPRCjCRihutRvkAZquEq/+c+fW4M1Wz/GUZfbXAbRc/5eNlth8K8w
X-ME-Proxy: <xmx:R9AgaoRCoZ4Bs8yOnaEy51auWGWrYCuxB3Rr0vXg7mINsdxy7Pzjhg>
    <xmx:R9Agai6nMWt2rZyWCpI0SOM_djUlDQ_IoheeLIeojZoD5t5r0Y6WEA>
    <xmx:R9Agak3cu0b4i93LVN74EgHZpWIDevI5Io4Na_S1E5dyvBNkB28h7w>
    <xmx:R9AgatBCHxnEWnxgdJGBrmPS8vh8AujWXWwuaDVUhkeJBU4KXIbYiw>
    <xmx:R9Agarhx9hnWRYixBmrV0eg_taVC4jlhe7azilY3IKh-UgiaxIxVDPuB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 21:09:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 1/2] config: let git_config_parse_key() validate quietly
In-Reply-To: <CAHwyqnXC=F-ewFy3nejzKZcSNNe5L73PcaH+b30wg_BKNpStYA@mail.gmail.com>
	(Harald Nordgren's message of "Tue, 2 Jun 2026 18:31:36 +0200")
References: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
	<pull.2302.v5.git.git.1780407557.gitgitgadget@gmail.com>
	<d938ebf95a817c00a415670c08b839747d711d29.1780407557.git.gitgitgadget@gmail.com>
	<xmqqtsrlujah.fsf@gitster.g>
	<CAHwyqnXC=F-ewFy3nejzKZcSNNe5L73PcaH+b30wg_BKNpStYA@mail.gmail.com>
Date: Thu, 04 Jun 2026 10:09:25 +0900
Message-ID: <xmqq7bofqfga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Perhaps the updated "git_config_parse_key()" in this patch should be
>> renamed to be a file-scape static internal helper, and the existing
>> "git_config_parse_key()" should become a thin wrapper around that
>> new helper function, retaining the current external interface,
>> requiring no changes to existing callers.
>
> I want to remember a discussion on one of my earlier topics, a few
> months back, where someone else suggested instead of introducing two
> thin wrappers over a helper, we should update the callers instead.
>
> But for me either way is fine, maybe here it makes more sense, because
> of the repeated NULL/0/1 parameters.

If the "quiet" and "store_key" setting were independent, then I
wouldn't have made such a suggestion.  But I got an impression that
with the updated code, there wasn't a valid use case to ask to
quietly store the discovered key.

An ideal refactoring would have been a low level helper function
that only yields error code, and git_config_parse_key() would call
it and react to the returned error code, stores the discovered key,
and produces error message on its own.  Then such an "always quiet"
helper can be used for the purpose of the new caller, without having
to have "if (!quiet)" sprinkled all over.  But that is certainly
cumbersome to arrange.

