Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5103644DB
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275313; cv=none; b=nWjViAHZLTGjUO7mr0MS4KwL49W/3IVpaeAl3Bf5lN3lVBbxiUV2Y7Wd8eCyEppqU7v/lDc6Dv94LgO11Oq8E9zMa/trFhUk83mWP8GyUTd4fLmPP+A8R1fabCCVTNhQurWTjoGXUXkvOH/bm988O0p1TvH9nNMpngJM/AVImCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275313; c=relaxed/simple;
	bh=m6gynk34Q+outnuPeyIJ0XmyAb8SKDP+NZD/g8BwDVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YsyPm1HwPPk5u4FDtm+UykeXQq/cONs1WVkxCjRzxkn571zcUcOWU8KVPlRGgN43hcbHbzez1cv1paf9/LNuO8vbX8aBJ/KoBa1AUOHpq59hVs4L32xHADyOIYS2eMoNDUGfUkGkeUJ/QjGoxK9BkhQl27kBMMBjYP89VVLdY9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V/Kdr4QO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f/4CCAfN; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V/Kdr4QO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/4CCAfN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F213D7A0097;
	Fri, 12 Jun 2026 10:41:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 12 Jun 2026 10:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781275310; x=1781361710; bh=bCOoa5gLGf
	HNcw4hh2jvfPYg8hI8nJ/gTugnGgXkfxM=; b=V/Kdr4QOY99y3HLlJ6YRUElotD
	ZQEWrbjVP+2ZE8yte1WeMFkUDfruk6RvoqK85pz8UjmmBoPFthaOtfMqvQ9LrAAi
	xyUwyXP0JfWRZOIu/Cbm0cdhlqoKtLT4e1xYgAFgjnP4BBQsTPm6hjnzTAq91EwL
	crA5KDlxaRL8lwPMYdpCvlAPHZnx0zk+gNNWHR6ZE1OCmOGEF8O1PX/i9sqBfcwe
	a7wUyZzn8wcWbbUduxsZTpUjYWohXT3Rk7JDB9TmJmHEPpeRb+njfrw1Fpc3RzLE
	l7EUZBiWR31fFwm/sjmCHpoCa9cIBNHmYMfSvGuH8sP3dWynnOiJIK0PC6ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781275310; x=1781361710; bh=bCOoa5gLGfHNcw4hh2jvfPYg8hI8nJ/gTug
	nGgXkfxM=; b=f/4CCAfNt3Isi180MNWSg35VwgSM3vsW8Z0ZlLU9avt9HwYtgQI
	Pc/dZcsYOTTQ4nVn75dV9UzsEghCD7z7JyIgZ4igkZtma0xKE0uVC7eEcDhNbzdn
	RA4Od5mI/QPZ7HmNPt3nPFJpDc4p6uCwmq1Q3mG2U67fpP5t8DYv2TVtttE0qo8d
	0zjU+i9LNRzHZgPmcTmgxvZpqWvXxxsBS292g5uQPs7myfeUp67kD1PtzE2/2XNR
	6NRS9sU3dpC8dIPbH90kFcdPrFuuYdRqepMLLM/QdUxY49ZzVBeL1PfPyWqomgH2
	NWAayBSoH5RDbLFlDtuFabNiv88AK+vM/EQ==
X-ME-Sender: <xms:rhosajWqcfZeK3W-xNyT8tyrA4YvmPgXCkChGZ80mwlV3V1Nm-GaRw>
    <xme:rhosat0a--pdlyD5acnT9o0ZmgU08HqC7MHkkJHcodlpu55CKpPF4c_ePbnbuO3U7
    8OcGdpt3nXN2X-gGUMp5TMxjHX2liWjy6iyUcd2Nk3atjQy0TroKbE>
X-ME-Received: <xmr:rhosahraDPy0Gzpb_xoFsQbj--ca6988Fyajny8yMopWuqrwSCn8kPx7goKFuaeZvLyF8vq1idyoqpU9cCIUnStOVU1EkagQEJZl>
X-ME-Proxy-Cause: dmFkZTF90bZklbgNXtnBm4XOmyz6eEjXXwIARtDsNSO7oQeyOeRDhWoPCIBUVMtnNNLMoO
    DstpSZq5TLfd0ouPy38n8foWpomOzFGdZkssAiwqcon/K44FaGnwZsbMc9YnRA87yEs2sV
    qgEn8fgrD9h7Bc6u6DP4vOW0NH5MXplFqUaCnVf/5Tr5Grbrex74wpUIvp00NQ5pQtDKqW
    6zI67FAz7Wtbx3po8abpNY6+RqjSukN3uUZhP3XMzZlY2DMjw/Gb2N9NFOkfrT8jHBBOCa
    z8Rcp+OMV8Ab6IhrhKKL3G0WrGgZJxyca2ogwnbt8rMrvCkc6D1BBBnqNcWVHWWegVJQk/
    WrdFYCBP3W4/FkS979D9ClcG1r9a7ne8+RTYKzzDSfVDWC/WPAjH+lHuqdVT8WHoqBBLKw
    0lnjjMEMVu84GgvfO5BQXNVxxjX1wiSn2jq/+q9nAtxaC/Qnn7J07yt2FrQYLAuQhP8k4T
    lE/UEiUwpmrGA25XinFNgzhXyWWS8jRKCAGkAfn/zJMZzLrGq1USNHR++BGx83SmhiA+ff
    5qn3ihXg1//Lln0yH97nQDm+2ZRKPldHjdLn/NmKdFJRUn6LZRAktDG9Mo/6vj1S6IBLts
    hgYr36zCHJUwdGtw75C6ae6bjByDYUU9NsRUrfpr2P0v4DbaQAqwl81g9sSQ
X-ME-Proxy: <xmx:rhosakWnEwigQzp8OTGxW2PtFRjruFAhXqxiLBYrm-pdLrwf3Zyu3Q>
    <xmx:rhosasYK92leEIPTuTnLaQ1y7L9xFC3gUyBk88jeN63pc023wyoxhw>
    <xmx:rhosahfasgZU-kzDU20tHgz1SGxtH7KMP71K_XKusz6L4BTck7KIFw>
    <xmx:rhosam3hJf0-gjDQqZBpkKPbM13WWiAOYhdRMKf9CGnAL-Whz73ezw>
    <xmx:rhosalc3YS92rn2dDaKQlsN87rftnEi88xZRFJaHnkntR44Z7zu_fJFS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 10:41:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: Derrick Stolee <stolee@gmail.com>,  Kristofer Karlsson via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristofer Karlsson
 <krka@spotify.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] commit-reach: remove get_reachable_subset()
In-Reply-To: <aivQv5FkTEWDn22i@wyuan.org> (Weijie Yuan's message of "Fri, 12
	Jun 2026 17:26:23 +0800")
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
	<pull.2144.v2.git.1781178567862.gitgitgadget@gmail.com>
	<ffaf26b1-c55e-43c7-84b6-f810a54f7717@gmail.com>
	<xmqq7bo5nf31.fsf@gitster.g> <aivQv5FkTEWDn22i@wyuan.org>
Date: Fri, 12 Jun 2026 07:41:48 -0700
Message-ID: <xmqqecibizwz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Weijie Yuan <wy@wyuan.org> writes:

> On Thu, Jun 11, 2026 at 10:48:18AM -0700, Junio C Hamano wrote:
>> I wonder if we should talk about it in the SubmittingPatches and/or
>> MyFirstContribution document?
>
> Hi, I think it might be a good idea to cover these details in
> MyFirstContribution, then cross-reference them from the part of
> SubmittingPatches that discusses sending a new version.

Sorry to be nitpicky, but the above is omitting too much from your
quote.  "it" in "talk about it" is totally unclear to a reader who
haven't seen the message you are replying to.

> Also, for the part about sending a new version, I wonder whether it
> would be better to summarize and fold in Patrick's explanation here,
> thank you Patrick:

Yup, that is a great example.

> From: Patrick Steinhardt <ps@pks.im>
> Message-ID: <aietF4BX1Ewt3cpG@pks.im>
