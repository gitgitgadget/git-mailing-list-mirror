Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7F3542CF
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814710; cv=none; b=Oh+PHWYIbfR4ujkVMwBgyYukJASkwsdQjwzS6j9rEY1y6CTXSFWvAhCx692awqV8mrEwW8SmtttFqWx7p1x08WY/Fy81/iRCx3Gn5oukWUR8lXhRVE/2yLJuivZZbdm+1unX3bIVvnZequTHPwG8EccYmX1foDQhUYL4hx584vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814710; c=relaxed/simple;
	bh=XuGBrWZm2xySCmdZkAQkTTKNV2kpZlTRudHBY4dEbZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qm4Ot8n8LDPmrT/Uh98pIBKeAF7g0SXXWGavfQkJcGY1yhl8tT5lY/mvva3pV9t2HmDxvVhOtkycu4qhKh3rt0oih/tomewKAhz+KiJKLsEkJTd3tp4ZU4dLiSRtUl/MSNNP0msWHeRRJVOnhNFa8XKDwZtAzIqaIPf0YpWYvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l2sisIfR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hh2Az5GL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l2sisIfR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hh2Az5GL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FD18140012F;
	Mon,  7 Sep 2026 16:58:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 16:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788814707; x=1788901107; bh=5+40W1OE/k
	IlwB7C4zQItNvKXuRtuPW8E1UomTUDVHU=; b=l2sisIfRNhaEnInFJnO4c9WYXs
	qwLzRF+t5GvoIBt6FYfITzhFL8iADGFoSqCr9bGKbWRQYx3Dzl1eAPZi1jChMEEn
	9PqoP8BYaHpaloFU9qKBizsuDvbqfbd6ImFG57FEFCOYTTxy52Z5NiQH8vO0JA3x
	PZs/BF7Rf6KiUOnF5lMAIGiVr8XG4wq5yd+TWuvW0M4CqjNc9DvqKZ8mbvJnrJlq
	khBaLIRh4WGYGRydkmCxfgOLtYmQbO3DyAmK4pDFWJcQ8W3gUamRyjDHZRD5DTwh
	kwyPAekUI1Gtiyfiob8kvszE5ardqYokydjSc+DddcdddEioA3E1AFJ8N2VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788814707; x=1788901107; bh=5+40W1OE/kIlwB7C4zQItNvKXuRtuPW8E1U
	omTUDVHU=; b=hh2Az5GLuh8XbD1f3LCABuNoU5r7sivcp5wnmbnvbGtZKv++nwa
	E6ogUOrlpOGY423SEYEz+iOtvfyVJiOT8JbsncClk7RaCxjf1EbfL7AjHT3GtmJv
	U0dcTE6y0m1mDoS1ZXwHo8tSs/9npKSQcSFlRLa9wAN7a6aALQD+cWUqyHAQ2eJj
	IYQ6G9UwlQPVgOAo8vOfH+7zP3d2d/7TlAFxz+1BSfkvar9ITQK8cixu6bTqPrZD
	CrHzPzkvq83XfAuP2xO2KjopFnIzKh6JdReyMc69kurgaK3sHAKDRw5spgjDIt6p
	cdSwngLbdAwfSUz/pFo1HWhRjJZqom9PA2g==
X-ME-Sender: <xms:cyWfau_Cv0xiTxfPqiXTqbV8ndpPEtlbhXRItMN0uRncYI6-Q1ghmQ>
    <xme:cyWfavYnzHswONk9wDAicU51FdtR2kBcvHqI2My3WavaUGf4uId-e1D-WJM_u1wpi
    VjvVL2gxNTl0k0LHSuO_R5YyPJs0YuaF353okjuD-ndSaai1ZoSYQ>
X-ME-Received: <xmr:cyWfaiPcUJRqaE8SjCyx3hIcw4Zar_aDoklmcs_tj3-ImlADqhXNuk6vOxhbz1tMRzdTQFkAEqXdYQ3DKqd4F9CfP2fTlotTBp8O>
X-ME-Proxy-Cause: dmFkZTGEzHr3U5NmtwU5E01plZLrDKdz5RgWB8tcF/xo31L8y8HyR9feRezPIOHDZg01wu
    Wlsx2qFBAjmVLMDOayeh3xpeV9L59Bht8PlTU/ZHMui18D3sGtAu7IspFOUBBrmJR0FwXp
    hon6TeCrpR8q0X2zry4y11yAt0FTrZJVKN7CePIgw24Ss6VAAq9vHI4uTh/7sfPZj6NOEX
    xxp+6UuRKYkr+XVIWMsuQU29A/r5nLlkCrvHr/pnXtn06YNXez2Xsj8SwhavrYls5Y3PEW
    6fZ6OxasoMQaE+P0WC4Gaiy5S/4pUC66vP61jSHGdUv0PyYCp2zdcDNvUhCHeXit+i4tVF
    qbAndBiIohHRZfUqeT0wEGRe7tADcEYimi31riRpSsLrGrukCvb2j5bz4oXM0EiHLvvrja
    nTk780yzjAvVAs6Qynx75R1U3Yof2odPi9HVFK67zegdK0A9DYwfjDHuqIDam5iXgWaBGO
    IskffiU2wo5aIQ09+d6Zep9TC7Fcr2MgVAObDm4Yk9P5o15GzaBk+uZIJ8m8IWSN58L5sz
    ChXeo7J4+ravtDE05QAmB0J4m6UStyuLz+cqrbO8Xudf4d2r+OwKXBOr4WGHFW+MF+NBXb
    bLmet2EMHAFiUqVVmeeHyP8F8iisSFBbuu4b9ab5dvvZ0+kwhPFyQzVAToTQ
X-ME-Proxy: <xmx:cyWfarCMxmhmhq6rMWA7FA92T_ZyEQqh1tZubPDqw9SLFIkop1gQZQ>
    <xmx:cyWfapJiCsXpnxs3nXEd83U7xlNUn_iU3W66LW_iHbV1viXPpAU4Zg>
    <xmx:cyWfakMf_ELhq0axjokYNLp8b64jafVc7UzAX4H78JeffJx7VyMeDQ>
    <xmx:cyWfan4_wIjOYFir5M8NeT_CWcRvo9MA_l7ZLhGyVzdQDw7uK5tMVg>
    <xmx:cyWfao_7GIAX4lqR0WtPULS3L8E_9C3WpvyhFttylfp5W5uwnAJPyaUB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 16:58:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v7 3/4] receive-pack: move message generation to
 separate function
In-Reply-To: <20260904-758-introduce-hook-v7-3-6c66f0a3a572@gmail.com>
	(Karthik Nayak's message of "Fri, 04 Sep 2026 23:28:51 +0200")
References: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
	<20260904-758-introduce-hook-v7-3-6c66f0a3a572@gmail.com>
Date: Mon, 07 Sep 2026 13:58:26 -0700
Message-ID: <xmqq1pb43hjh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> -static void report(struct command *commands, const struct strbuf *unpack_status)
> +/*
> + * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
> + * For v2 protocol, set `detailed_report` to true, which will also add detailed
> + * report per reference update.
> + */

The second sentence is stale and no longer matches the interface.

> +static void generate_report(struct strbuf *buf, struct command *commands,
> +			    const struct strbuf *unpack_status,
> +			    enum report_status_version version)
>  {
