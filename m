Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78CA357CEC
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 03:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010156; cv=none; b=CzcmlNqgBkPK7/VQGCyo+/rqW0u5f41cwjxT6ppcdEhDpkUdDeU1SasuRaDffPFPE/kp0SIcJh1AD7mOpC/hnnzVIzZmIvHRh6v2GY2KybdDmTOFSLIJpzZXAKjaAiA00y+2+lOUh3fBns4UnwaGaAaASZugxnErLd/keZIZ54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010156; c=relaxed/simple;
	bh=gyS/eymatfjGN6FH1UsoBpoh6XQ0CH2FmTcCL+a4IVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KAf6qy8io9+2Lk1g3bmGV/l1ux3vPbdgqFQ78VDCZDJqYCgxe6ugJ5wB1UF13y5YqHTAY7GEiE9ztmDrr1/0Yrnh4MSFnOXp8XKXLURwKnkzQ//6Cv7crpWuxXF+bvmoN1mE5qrQZHDRhJu0Ki2rvadBJnQPt1Ec3frPfQ7HNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CaqjYkWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XzbSfN5C; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CaqjYkWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XzbSfN5C"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 848707A009F;
	Wed,  9 Sep 2026 23:15:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 09 Sep 2026 23:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789010153; x=1789096553; bh=EhzZuzy0A0
	9TXG/kWXDhlfIZ6QjSJ4Yz9H1gSBttbQA=; b=CaqjYkWo8QQ+YvFAmzAWACYQTK
	p+EfqRp2McZnjY+tTPJCRIPuPB0LUcjt2bgWehn/7zhADM+59xJcv0+QLEHGJ2Mr
	DjtLLr/CDpqBcAax8rqtHGiRta7jthIitpBVIflWGmogkYRNule3Vl51/6NVYKlb
	TLuQuoZIe1iHzpC6RIpB6Kkjd3hUKLSlF3AKNLLEwwk4X9Uq7OyYjvhBFC1RPBYn
	H0/YiMtlhQQ/6XxeTe0xdA4jxFZnff+ykCsZ8seyJVlz6BbQadqTex2+Vv9IrSxn
	I378tnBlamx2OI1gmjuxbfJMusViMv9NOn7R95xX876Q3+qrKZdEoNWEqW+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789010153; x=1789096553; bh=EhzZuzy0A09TXG/kWXDhlfIZ6QjSJ4Yz9H1
	gSBttbQA=; b=XzbSfN5C9PJBROn9M0hgo1q7Z9aUvD2ln7xeqWMvMoGlI+EIHN5
	cTkNVsRQZv4OlPFNcQCJ5CriuMIusxVJmzZeSTZovxR+jA6S521Cq/Kf0hwXQwHn
	F+2iXN+xUDOb7WTE2mOOCQ0SphRMkhU3Sn+dWDgmpEDVU97C1OhmcpY9q8c1LWZ7
	Wht1VZ9lwuvNhhsI/X5H1qc75u+RvTPzmfsAxccnptvIvEBA06gTb1AJnYPj0KC4
	kmxYMxElES10La52gHlSD2CBF9HeoRCIOABPdbX18TknAbr0cIvHsBCMm+Ahes8w
	ZKnrDmL+bPCOhzb5TAxYXpvcu+BBCY1TdcQ==
X-ME-Sender: <xms:6CCiatGJplB8LqmW3E9xUR8a8t8Txzyu3CP7atuRWT9SPYqFYLYMbA>
    <xme:6CCiajDiFdAfIprdvxdBFnz7iLnEl60828iHfpnctXs5XmpM21SK5E-fhgc00RmzJ
    PbD8c4iYWVvinUHeUmpjqR9zEWkzMIESZp9DFklzgtHc2m_cPxDzC4>
X-ME-Received: <xmr:6CCiatVCfa67WwxUNDHLcbQJO4z51GHkzHTzzBkO82Vy1ZfU2Gpb_IIwy8HpxOPKh3xVFeA9ibMdTVmPAJlltqVUgV_8QYUdvwDV>
X-ME-Proxy-Cause: dmFkZTEVF+kHVmodB++n04QWE6BPY/w+oHQ4uGQBMMd8Ys2/EOazBDUlmn6ZGTkcseryBQ
    E9K3ulJrB8fJdm8kihCKP9shiyZLnRjFTg+GGiNtlBpTgG7TJQeip4nphawkRPkT0G1nNi
    HjTGVKTniabcByFDtobNejUwwIVdMvfxY/kqf0b8xwQrYvTMLdTQUc7jOoMeufMhzaAXON
    QQMN23cpcXbhuffzIYBDDxysNzm3myexeljDni5GDG/Wr9QhSi3ombUYtf+rkdT/W1i/tb
    Rql7CwXSVsbSb1kldUM99VgynWKVpGoo2dvz9IVCyB+WTADbbEMcBJF+iRZpt1OC8WEHbf
    zD/EmqWVKRlMgPsZFWtHd1AuliHS0VVNFgwT+JEd5j4tF6uZIEDBGwDTrLYDGezqGhoPp/
    2p0EP3XzRYADnXLD0leTnNffb0gdGGRgUHqoNOoK1AkVAsSAXnW9y+H91TXaBqJSgwWeB8
    QJKUPjkOuubTAfUrxqhWp/tkQOeg8XSM+WNkEOWm/aavtrZBTcC4FuHQw6WQ5SFqXGjf89
    Urel0jqGd4nQ+CA+oRfeMOtCpsOfusXPwiMXrYqHqe/yAFcNmtsiIO36KbM/9UI0Z8jBye
    F3QhqhCWQeiy2iWEfEw5Xu50pC8B+37iDUGy8ZoEhwLM0zMnuXOFCB+r8Axw
X-ME-Proxy: <xmx:6CCianoyCnrduGnPdZtpqskXFaIi84__P01tie_lMOoIcIwVO5Hidw>
    <xmx:6CCiapR1A-hYgCA3CPLXrYaKhqKqBFl-QjZAZ1UJrvSv5nfea8chbA>
    <xmx:6CCiah0D9S_LxJfLv9mIgjw68P7cBeOnHiJj671xWpyOeuB-TPTOwQ>
    <xmx:6CCialAfZyTppwSNEn7Gg_sePlHF59e8WiPfGNWsyeEv7saZUsW4Zg>
    <xmx:6SCiatR2ZCEtP9XeMHHBIN769XR8-k8JoxJ3ZOf-6pCwauSRd1XyMmyk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 23:15:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v9 4/4] hook: introduce the receive-report hook
In-Reply-To: <20260909-758-introduce-hook-v9-4-3043d417e0ee@gmail.com>
	(Karthik Nayak's message of "Wed, 09 Sep 2026 16:51:39 +0200")
References: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
	<20260909-758-introduce-hook-v9-4-3043d417e0ee@gmail.com>
Date: Wed, 09 Sep 2026 20:15:51 -0700
Message-ID: <xmqqjyotokyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void override_cmds_error(struct command *commands, const char *err)
> +{
> +	for (struct command *cmd = commands; cmd; cmd = cmd->next)
> +		cmd->error_string = err;
> +}

Doesn't this leak existing cmd->error_string if it is owned?  In
other words, something like

	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
		if (cmd->error_string_owned)
			FREE_AND_NULL(cmd->error_string_owned);
                cmd->error_string = err;
	}

is in order, perhaps?
