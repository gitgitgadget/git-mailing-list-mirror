Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD9343893
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780350796; cv=none; b=AyL06zZHjp60Vd9270IXVdM9RhGE9jg7MMglCd5AH16P9F1XSobD6owVmxyExEjg0ScmpJVv6E2MVYXbElxgw7IP95hmkFMrY63AIfg75pRPFKV6Ixiu+0i2wWk9Vf2Xzm6fhSueEJrqp8qEaR9efmLTvXNH/kZVmNnDgnTYS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780350796; c=relaxed/simple;
	bh=qVlin407SgrQr/eb71uxErx3V3HIWNQSilWyTu/YEcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xer9wq2bsgczi4YexFcQn8Ui77bAgsNsdSwH/JXw/yBSZ+kekcEDYK57eQX/yGEcAkma+iQ09r1WlPJkBM/Z1LcF4FjzapExvNH47xDowcMiScaKqSUgSDbEthWPXNqJSI3Qu/GFYvVgwqM2iBZwJjXuF9lXiFjvbHT059SV7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nvkUDn+m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jMpYje2R; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nvkUDn+m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jMpYje2R"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C7847A0060;
	Mon,  1 Jun 2026 17:53:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 01 Jun 2026 17:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780350794; x=1780437194; bh=ZUsj+/qfw8
	+ci9MDTE3LbRbelKNKoCsZXarrmnMI3s0=; b=nvkUDn+mgTnRIdfrNWtzedZd9u
	SiHGiaqko7vnZUpnTvs/G3asuB1FUrnuwSiUFPO+LpmzhV4Wee5w7Lu2ORKypd1y
	/z1w1A4Yb74RM24A+ZXRmcm3IGLxhvMxCuMAg1oHZUfq2PW2aW6rIeB+n3CRWf1h
	I1wltQCVMEzOwWZvhpPYFHu1oBLufG2BgvFJ35Ac1nACkM5Efcp8VQ0DSXQ/hzRE
	G+gER+/JhH2nU5NJ9Kwejuvd3zBbWfSZX5b823v0Ol2xVJrxJerOWva/6QdMFWUa
	m9puSwQJAgtCexS6UM66l3qCsz2i0JhNav9IDNKGIpXHnUxmobtTJ6LWbYlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780350794; x=1780437194; bh=ZUsj+/qfw8+ci9MDTE3LbRbelKNKoCsZXar
	rmnMI3s0=; b=jMpYje2RArjxnwoYx/3KUgBOlS7VnnQ0ZUAuXab0VW/zV/XpfXN
	znGwzmewfaiVIR4IAroHiwQcBveunOfokD11kdBdteAOaDx/Ic7xEgSOOAefsk9M
	dbDm1O/dnKXQJhnSmS8GpmCMrzYVMirY2yN2I8U6PNWNwKVpdkcKs2MLR5y2OFS3
	wlO0hMl9c0tyW8UnEGKekf6t2ty8LLlqtOWv8VaMKruabz3u4UCo6uXVRQKSpCgt
	LF2N+uvyzAXxM5bOAs2ReymzhUbsfF9LioqQxHasd6mzG0pCBGhdNbsi2HK4f8YK
	Bf2k/RWBnTBj0mYfyqxB1rkxh9rbjy+pm3w==
X-ME-Sender: <xms:Sv8dagqS-TC3eTJValx4N39xPGPaQ1n7zw4undWJnEeu3oZQNYq8eA>
    <xme:Sv8datgQ3Xvv1CxcE-MS3JB3foNnneuH7t0_ztdRJji8-CUa5JtjH4eOLFT9XkTsI
    QE31Qi3rbMl7M-lGEycDo1JCGRAKsIgRB_cMuPeFyB3woA2Q5DkzA>
X-ME-Received: <xmr:Sv8datjOdNTZxYgQJ0FS1K1NcbOB9U8lM0mmdJnPQb1MVKvD4a36o_lE2YhE2LUxWRvJYJjNKG9YcP7N2Ico6xFQhv1A5ErFO5Cj>
X-ME-Proxy-Cause: dmFkZTF5befuiwzZC5I14ijxr5Qd6p7azfs2pxvEVbJfrI3WlegN08INrW/E1i5Bsus135
    tYLq9pl5SiqzxpmTHOMmzY/bEHsXYqUrLLY6LomHE7R3Us2dn+HrbLj8RAMBUxFFojVnnm
    B/uiiKyAYn8/RnGM/s2Ct+SeeQzX/T+2Z8ibumCXh4lhuktMGP3lWFu5AdXGB22Rn11VnS
    hA83XTW27se/Y8URKLb1Qg5yKsTuVsoUTAufCCnR0fRjKPpHUKeIbUQtzY+XN7zLcJxcgP
    N5PbyWcoQixHVM/hCyPJSvBf3ezsnWzkEddfXggFuieBwap+wej4iV4c6iHIC56uUhHIFA
    xUiwvfuZfjBlT/hCUJRAIJGV9CR2WnhKmKv9afMDU+A8a4Kk6/PhUiyUHtoICQ9SXxLIlW
    YQpsuiKOP0utDLg3l7LVeXiAkj4qb3VsvQIcXOcNl8GYbvTokq8GuvjDmsaFrrSQQ7akHq
    ci0gbHlCVVug1wqsIZLwIgawPu7UUNH2GJ4esbrZYQeZAe4ihak3rncYAUgo5UNh1hFbpv
    vAVz1hvkp0wkUyJmaHg7r8VtfS3Mfzs1JrJorogRPTUYhB65ZWJR81nQN1T9mrJWH096wb
    ZY9dvxOrnRy+r1FaG6N0+x+vJD+9GRdphIjXwK6Lt3z3VmV4wepOYeVkFfzQ
X-ME-Proxy: <xmx:Sv8dajhMU-yBdKmugjOma_LREFj-OUp3DOADVipDcPbJO7HX5fRGkw>
    <xmx:Sv8datKAp35i4D4iSs4OCE8ZvMVtqfW0YgCzHp5W-1tRcdb32n9T4Q>
    <xmx:Sv8daiHfokwfEz8kPGugvObq9fFDVVAGmSKsXYsJRmG_WLN6GaASkg>
    <xmx:Sv8dahTvdZwxZqGuNom9z_OCmJFGCuBK2iUTkuc1AeBVcerMRbYARA>
    <xmx:Sv8damwkvrSt9pisI69M_yWXIKdvzA2QT3EnL-3LlZz3sZV12JG7PefI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 17:53:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v3 0/3] line-log: integrate -L with the standard log
 output pipeline
In-Reply-To: <B59BA5B1-184D-48A8-8BAD-11EB6F8EB50C@gmail.com> (Ben Knoble's
	message of "Fri, 29 May 2026 08:04:27 -0400")
References: <pull.2094.v3.git.1780001267.gitgitgadget@gmail.com>
	<B59BA5B1-184D-48A8-8BAD-11EB6F8EB50C@gmail.com>
Date: Tue, 02 Jun 2026 06:53:13 +0900
Message-ID: <xmqqzf1e2aie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ben Knoble <ben.knoble@gmail.com> writes:

>> Changes since v2:
>> 
>> * Switch "! test_grep" to "test_grep !" in tests.
>
> Thanks ! I did not read the tests carefully for semantic value,
> but the rationale and overall code looks good to me as discussed
> previously.
>
> The range-diff here looks good, too. 

Thanks, both.  Let's mark it for 'next' then.

