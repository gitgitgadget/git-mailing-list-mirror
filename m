Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB355E73
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688175; cv=none; b=fAzXSkxpSzp9Cwx5PJ76x6lVBAF5x2Hg2+qL2zhQUf00UwO7gSN9fr+pgC0QCp+G666dcReiotLDqTuiWYkSoIWPUX5bMhLDeHa04trkPDkyVVpsXc1ChBaXU3bcNePTjxfFUus9XF3iPtlcsZ+RyF1qpIBpGhu7vqeFyzR6yQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688175; c=relaxed/simple;
	bh=tGwbhMHduK54lptZWRwsqMrX039bUBpPyFvzR4szQOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HupsONGu/4brpAnwm4/EvcS5DOAOHRnqlM/etINuNosQngdMjSDcl7L6EOOfB740nD9CLcHCYLJHuFx9r/YIjFbN7Hrn3hz48G8iQiWNn6Phzg59nFarCDVrQ/IW37tWW3wHFfP4XWlP1CYV78njObuPinBoZkd2/qs+sryKuGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U1vYP2Sh; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U1vYP2Sh"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EAA31D4DB2;
	Fri, 19 Jan 2024 13:16:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tGwbhMHduK54lptZWRwsqMrX039bUBpPyFvzR4
	szQOw=; b=U1vYP2Sh+0v8+Wub9JERL0xtzjs9ZJff5I/zbDMCm0rJxGmSU5d1Zu
	l+SjAP/8uQliWDPuCJFKeq1K6fcMtCCvh6AvfuNnD0ITXL9RqMlu8zKyQgMow4YU
	vgb/RuDYPD70HoX4pHz4hhzGYoS5eCyn5pDseRTex/ThlR5pJHrAM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64BD61D4DB1;
	Fri, 19 Jan 2024 13:16:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C1A2E1D4DAF;
	Fri, 19 Jan 2024 13:16:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Victoria Dye
 <vdye@github.com>
Subject: Re: [PATCH v2 3/4] t7450: test submodule urls
In-Reply-To: <ZaoRDniGoIBXmjVx@tanuki> (Patrick Steinhardt's message of "Fri,
	19 Jan 2024 07:05:02 +0100")
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
	<pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
	<b6843a58389170a45b5ef7809e0335a6425eadaa.1705542918.git.gitgitgadget@gmail.com>
	<ZaoRDniGoIBXmjVx@tanuki>
Date: Fri, 19 Jan 2024 10:16:10 -0800
Message-ID: <xmqqbk9hkx3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D34ADA78-B6F6-11EE-B754-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Add two tests to separately address cases where the URL check correctly
>> filters out invalid URLs and cases where the check misses invalid URLs. Mark
>> the latter ("url check misses invalid cases") with 'test_expect_failure' to
>> indicate that this not the undesired behavior.
>
> Nit: this should probably say "to indicate that this is not the desired
> behaviour." But given that the other patches in this series look good to
> me I don't think this warrants a reroll.

Good eyes.

I'll rewrite that part to "... to indicate that this is currently
broken, which will be fixed in the next step." before merging the
series to 'next'.

Thanks.
