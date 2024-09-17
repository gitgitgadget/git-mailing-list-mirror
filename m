Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781319B3CB
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585294; cv=none; b=IgTjWFukNlCmeVtEVPWiauDaBmBLvWGy0C+QS+o1g1/mLZF1xrFOkRcn88+Ijac8Cu4O2CwzwR7xTPRpr0YolzmE7Qcg61LT241/8v+astc1CiEMeE3Wcx8LoVBBP+buk3WcYniHZnJ0g2L54KQ5yaBIFeezTXOsx3QJKRIiXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585294; c=relaxed/simple;
	bh=cdLGMZ1NoQcNb7s4PDYCAfa1nS2E1fn7ZYlfIRRnD5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kdtrurlzujaie3H+e88w3Fy8USPpPE5fVOTsWyj0C2sn7bFZQ1TNkBQT+/L1CFfvYJsVgDhwr72JDXhLPMPS0qiwFWw2UBeSeCl0K7X+7jB0+g1kYo5gZeoMhag9Mcla8wyuZfhgQSsH+FbfsIoMg0Lzkuey9Zo6W3qpYTS9PZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RQkpLsRh; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RQkpLsRh"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 54138234D9;
	Tue, 17 Sep 2024 11:01:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cdLGMZ1NoQcNb7s4PDYCAfa1nS2E1fn7ZYlfIR
	RnD5A=; b=RQkpLsRhiO45HFmyso/sHD4CbrD6hMpidwNv38KO0MzLBUL/JLN1u4
	hA+HXRtbHMfcIsMZuXz+i7QjsB1xKLHef1CdUoN9FHSLn1pmuicDhqQAqvCfdfBA
	VjCyBgAqMiDyS62gfUmgrMGQnsQW/z4vtvt7k1h4/y3Oi3jt01wuQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 230A0234D8;
	Tue, 17 Sep 2024 11:01:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B9C0234D7;
	Tue, 17 Sep 2024 11:01:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Jeff King <peff@peff.net>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] ci(linux32): make Javascript Actions work in x86 mode
In-Reply-To: <d8b15f7e-7847-f6ff-cf8f-02aee254b070@gmx.de> (Johannes
	Schindelin's message of "Tue, 17 Sep 2024 14:20:41 +0200 (CEST)")
References: <pull.1790.git.1726274559928.gitgitgadget@gmail.com>
	<20240914072932.GB1284567@coredump.intra.peff.net>
	<xmqq34m2tasj.fsf@gitster.g>
	<20240915110706.GA2017642@coredump.intra.peff.net>
	<xmqqr09krijc.fsf@gitster.g>
	<d8b15f7e-7847-f6ff-cf8f-02aee254b070@gmx.de>
Date: Tue, 17 Sep 2024 08:01:28 -0700
Message-ID: <xmqqikuul3xz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B896E2BC-7505-11EF-A3DF-9B0F950A682E-77302942!pb-smtp2.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course, my favorite solution would be for `actions/runner` to be fixed
> so that it detects the situation and uses a 32-bit variant in that case
> [*1*].

Yeah, that would be ideal.

> The next best thing, in my mind, is to come up with a solution that is
> general enough that other projects could follow this example, which is
> what I did.

I guess both patterns can be followed if they discover either, and
it made me wonder if this isn't a problem already solved by others,
but at the end of the day, any solution that was good enough and
unblocks us quickly was needed; the ones that were reviewed earlier
have been fast tracked down to 'maint' as of last night.  That does
not mean we won't have to further improve it, of course.  At least
until 32-bit archs no longer matter, that is ;-).

Thanks.

