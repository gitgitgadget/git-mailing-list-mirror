Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7237BE85
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780350194; cv=none; b=Sas74y+vKQRXtEMvQYOV+y16/1t3ce3Xav+fR1UQf7OMJOkkrYEyRimuM1tZmujrPgnmDxdaz44F4EfkguUa39RV/rs/vyNDMW7Oo2tyzcv3PDLiI6WGAGMJvOvRmKNtrdkRhhPUJ6vtzcKcvtDl3s2eJXYURw94lt6wlfohLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780350194; c=relaxed/simple;
	bh=TcGScEI/blJsaP2vVaosd+BdCzsa61ti7ZqueINFRsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D8xRldAjY8C8dMhS0n+BUfPvpbnNJgSupg97u4JUuKPcL7D5ocrSUI8iXcUjE80lVol+uYBgyfvaoAHaJ2UByVJq/zkLJOqz3yw/x7Op7siRp0NXxi9+38acKDyNNFoiiz9rt7++2+nF5CEmJARP+dBQMjo6QFDOtE5XXYXBRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fpxN8DuU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yr42J07K; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fpxN8DuU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yr42J07K"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 58E337A0104;
	Mon,  1 Jun 2026 17:43:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 17:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780350192;
	 x=1780436592; bh=3y7zPg4avKTv/agp6fVdDfv6HIlPSYFG/b3SlLbDu+4=; b=
	fpxN8DuUkxgwYX+Flq+pCT3onVJsftFIszr0QcJdJhprXJatgmsbka0CaD9O5HDZ
	0IwbJJx4cjlxCp+E0+GkCFNVQaHoLzaNphGW6H87ZRLcLkYpmnxcxbdTUmY13ScL
	Ig0j6TBeW+yaQdaPf6iUeuLdN/9e6wNB6mSdCG3+8ztHzpGE1bIKjalzhaMxFa+s
	iJP7Cs0s6ZCK6/cTWhKwwVVnEr6akHFAGKpd9DsdkbgEm62x1JoXKZrp9xKg1U2C
	/98OaNVi7mu6UgRwFmd++k09ApdWokUlntcSWBhn1X8ovjf8FbqCzBjWZlEd0wWI
	r36bxPg+SaHE8795mVBTIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780350192; x=
	1780436592; bh=3y7zPg4avKTv/agp6fVdDfv6HIlPSYFG/b3SlLbDu+4=; b=Y
	r42J07KCK2vkhYggso714DsrZepxic+o23ew9oOPNqHJQwmyvPMRloBvbsDzo2qF
	PmGDo9Crq8UB+NZDdCvDVSGS2cQsNZZrKymaSLTQCAK1CLee8wDq+vGkdhaOiLmC
	nlBSXNjMzBZAB/XykS3ZtYjCPjX3PFZaQ6fRhVkTHwxGimb3vXL28sMZD5OICLLv
	FUUG2CkmpMA9Eys3X94/qHZTrKAetP76LUTM4qw+vjaqmt5lP7uTOtB9G7HfX4Hs
	XwUaV06w62VR5LDwIY7rWWZF/Z/L3udToKhkINkc5yi46eVCrT9LjBHVpk/JS2r5
	AfFoTSqfm57KRHiJACOlQ==
X-ME-Sender: <xms:8Pwdaju66wuDnc0aWxeJBcnE6R6WGUA-BcJA8ywyiLDLIGRH2wMw6w>
    <xme:8PwdanAtx-d8WYHbTyvhwItuCkm-GlV5oFHrBghgRLnpcGcS9MH9Hsk9pwI3a3zc5
    w_qxDptURSTp5LNLTjC2L8-WV0Iq0uB7Zavv5P-r_Fo4NcqgnxWnA>
X-ME-Received: <xmr:8PwdaqbN_iyKzyPl95oG4AU9UY9XQccBuPekci5sYAvP5q_-jsPhykTYTISXNUq_Cuu5AmRxW1VgFcqmyHIWZHUYE50ee2DSlGkU>
X-ME-Proxy-Cause: dmFkZTE6lyJKC7aZK8yQ8+AWUOJu4IoS0iinxVWHtJP+n2ecwhK/lGyi9P2nOvbOISMSDK
    7PTEBDF53KPsepxT56yymZHTNXGtfXVxzacLE+xfcIqOfgffn8rMkayHSRjrTCkULALgb7
    qA0OFuz2dGn6krSTP3Gp3yJYBVaRbc/yZF8jRYL9igPfkMxYPno+foeNsrG7elrQ22UfOx
    UyE9N8JEf6rlSOn88rUqYwhutALESxzmIkmU2pXKAuisHryL7+sovK8UkH/FMRpv0Vwj9N
    fnQl0T/CLyGa6OQQ8F9WXDMTqWxQVZnMOogx7u8HzrT+IS1iUDkCroUCuCUBQyWc36KXh7
    r9xcTMQNiTFHcIssnmBMWwzWjBLdYOH5KjwNmRYQven6CiGbdHeROcMR5p9AeKGd5lnGNj
    QJ1aH8nPxH4byz/vWjLnC6DbFAfVoohEH20/D0uoHNi6MSYENkcU7pQ6E3K2EpvefCxSqp
    NfdceLVY57lB3gxrUKHfpaNCG6PkRdeKP+gCzVR1ub6hlg29jKvtMvCvA/yAshxP+anvrh
    0y2SIWyGlfMHCd68s1a8SRzKr+WUfPzne8rG3pw4TqyRivpTp+SUn96x299/3zimNv/RJJ
    +L3IFV5y/y6+HQ1oXGhgkA6TlMG+XvkLE38jGzsE1vYR6Jz7Fegov1Vbchkg
X-ME-Proxy: <xmx:8PwdaiVp1asFSowSUuIMMO2FvaDtwXVmADk9MQ_bSHH6P5XJsmTFMA>
    <xmx:8PwdapMy8WvjhXLLkiWYPVgtd00WOeuaLTnYRNx-zVjCPwq1JXUppQ>
    <xmx:8PwdasZQSNTX54ks2iJ-mNgyGTfx3lvZ3DHrnqj0dAl2qHhfePBU8w>
    <xmx:8Pwdao9E604Uyhk_JxC5KJS9wb16YShMGr16bqW70ptvh0vLfPXi6w>
    <xmx:8PwdauSeCM_10qh-V2Fc55oZslm7Fs4vMYZhFmrGW0V0A4tLVIdYz8Y9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 17:43:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  Tian Yuchen <cat@malon.dev>,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v3 0/8] environment: move core config globals into
 repo_config_values
In-Reply-To: <xmqqlddqu013.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	11 May 2026 11:56:24 +0900")
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
	<20260423165432.143598-1-belkid98@gmail.com>
	<xmqqqzo27fnu.fsf@gitster.g>
	<CAD=f0L8-_3sDGGkCzF4WA0xmUtaY_qiz__3zq5AemLgwTsqvsg@mail.gmail.com>
	<xmqqlddqu013.fsf@gitster.g>
Date: Tue, 02 Jun 2026 06:43:10 +0900
Message-ID: <xmqq8q8y3pjl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Bello Olamide <belkid98@gmail.com> writes:
>
>> There isn’t any semantic difference intended between
>> the "environment:" and "env:" prefixes
>>
>> I shortened some of them to stay within the recommended subject length,
>> but on a second thought I agree that consistency is more important here.
>>
>> I’ll standardize them in the next revision.
>
> Does anybody listed on the CC: in the original submission have any
> comments on this round?  It seems that v2 iteration was commented on
> quite a bit, but has anybody checked the latest iteration since it
> was posted?

Your mention of "the next revision" were made on Apr 26th and it has
been a month without any updates since then.  Tian Yuchen seems to
have made a few review comments, so perhaps it is a good time to
update the series to stir the pot, hopefully reigniting interests in
the topic?

https://lore.kernel.org/git/08efcc49-0db8-49f6-8971-633aa55eb66c@malon.dev/
