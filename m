Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF42C11FA
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492620; cv=none; b=FRxIZpn+VCTRFgxMbKpwVIBa1KQbxLQMo81KiO44PfsHb34Tx2MqyQH8Z5ge22urAsJn5+zDPU4JbWhXUxD/tJkpYRK6MvIYXfGGZ/7IB3x+C3QzSuLpi1LA//AWkGF9Ris8oOcmlus/Iu2XgHYh4d421sVHyDhSMwQlgkPr8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492620; c=relaxed/simple;
	bh=l9/ARszCWQacrLa1wJ3qOxEvs4y2Um0pGeNIza8J5FE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ddX44/BqaXdokjXg6AMM9lcNjltRX+DeTec6A6pqnvqsN9oaUwS90XOgZpPfY1kBkyXL4DjR2JcxItp4+oHvUcFGB/fHx9ewtsnzoxYSdvvdC37gqGmTVQYHSTf9Lxd74GhywAcuSmhI5ZBV+w1gUt87bfF8ktaKhV9AcLbeJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IFaqCFjl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j1UIH24F; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IFaqCFjl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j1UIH24F"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D1467A0195;
	Fri, 26 Jun 2026 12:50:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 26 Jun 2026 12:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782492618; x=1782579018; bh=l60Y2WvxWw
	wqFpwIs2BTqLcVckX44g7V5mSf9TqedOk=; b=IFaqCFjl0O5f30DJZYgo61WhjB
	NTDJUsrsqp4IB/dlIYH2nCliQcn2vG/5wa0zpirJzPk5vWjlmHfMuPXPxKufNxln
	OCI2I4xN1vIbmba4lUhoHxdD0QAe00wgaIcdvJw9kZREZzVAzgP+xRpctKXL1hSX
	I597wNu/cCXTM+eBD+jNJQ+crK2u4Ylvc4QlaABkScjo3GRj9qrFw3WXCGs72l4J
	8bDrsr4Mt1PrS6X0Hop+9grx2gNRF6pUaeX53IM2AMhZXuUoPuf7et3grDUneKxx
	l0nohY8r42Dpj9p2rpwXmzGTZh/tl223/B6YOjDWERD8OeGuAcqVaBNDrgUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782492618; x=1782579018; bh=l60Y2WvxWwwqFpwIs2BTqLcVckX44g7V5mS
	f9TqedOk=; b=j1UIH24FUCoXZQ+tdRlBJpUfk1PiiqW3PZrzeUSApWBbTCb2KN+
	w1jx4yObRtPwXkYIPddm5FFwzhznR/wd6lWBae7QawUBO9sA7eh3Y+iZg35wvENu
	gOEi7CXPPN1rL9W+wzIcT/1sphssNHQW47FxG6sDySF05A+00UnLbH6iIPOkPWBi
	wkIVCy1RXXEVhzSEmYF7CLj3WZiGT3WeOqve6P8HVGbNxx8WcIjoIc6aSPQrRlZV
	S+osZO6uBOVs9gKaNlYYg65TFrVV3apaTRZUF62z6z6hue/r4e+DSwgEQ/HlRSsi
	hIh2r+yZZZTDMz040iYWra4gnqkOJ9sRDfQ==
X-ME-Sender: <xms:yq0-ahgY5dfea5VzhL-fLIpvQ69h3KzoPje6E54HHhSK3AYEIqM7yA>
    <xme:yq0-atCSfykgn5dJH4KK_clshiMQgtpToNfUqJw5oe2MJepai9QLPFNLB_0GxfTKb
    xJodw8swLnuPLLg1x4DgIzxXNd5AOiJdblvaB8OdCI4W_1XhedfQX8>
X-ME-Received: <xmr:yq0-amFw4m5Y4JNsjRzzPg-jygJxRDy2MWmEv_kIsXYFOUunSCyTZRjU-gamjWl0KghGYdYDSHMxhaQLidmm_Digwl-PKi8VO9eZZW0>
X-ME-Proxy-Cause: dmFkZTGb1wYF/ettNBGiZZroTzU8EKVSCQd0TWgJ1HS5R9zOuojMLWNHYD20lsGgruxy5v
    Y5dzCPytNtg1J04mSKv1U7RWmubyHWvRguaYJKEBkuRIeA/OgzVluHRNvFtMNlpi0wsOMR
    yoS0JYJpDYn6n5ZwzXEtm1G11r076eTOlhNVffSFJCfyIGN4VmpHfvgp6Asx9DM3UTVhwv
    smXjL6FLIDF3Us5H4VA2Vn6cZJ6/J+GiWeqBEmJbZLOUhhBwRVVjeh+21PzUpF3cwbiKzC
    PPXYg1AitNSQGW9kRZzuSm1KFQNGH6XPQBmFGGlZte4tma30lwijK2avXDvQkI34ayz0nn
    +ZW/As2m44eQdV3hC5e5Bc2C7YIB3LXEjlpVuSPygbaHmeDFx+b7ZBq7MiTuwCsIqvYRGn
    LC0yOkeDqAgv77adv4KIm4rysIvHTpJ+MSkCejZ8G9zJB4Ih4H8SRJe8T6bqz+r+iMxcyb
    QwNJz9Qi+3ADiBuFnjjD2BknDWMGCaSTiiYejQI2CUWvf3WsSTfm0XZfclesomlAIRUwHB
    CXH3/jcZKeKRyGw5awXB7cE+rK+TEWuBw0A5fTVCClrYJ9P5HUqkGm1R81xgJR1grQI6md
    Ksxab3ShJnlvsEXhsnSkRhTM7mmSraS8q7hPNOmixJFomGk07cnM33GAxqeA
X-ME-Proxy: <xmx:yq0-alIN7TdOJtm09yntqf8-n-AADXyUej71t93BBuFUaCBDTk_jEw>
    <xmx:yq0-aqmNv9rfKXJN2f9kjnjH-GSbPUAYlSed2AaYnc_la_iD9Hb-CA>
    <xmx:yq0-atR0N7GjWhjW-oX0iq9f9VUSUwwoQ0prQGXNCEa-u6fPTG5hSg>
    <xmx:yq0-asJJ7lq4CHYUcAJbzE44LWEJaEmjIuC0Bcbqpb7BsQZlF0uMoQ>
    <xmx:yq0-apF4rwWbYyKj31Dag0R0UTvZ4Bdi4rVHRVRO_m9uwCZVC4wMuYwi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 12:50:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 1/3] replay: add helper to put entry into mapped_commits
In-Reply-To: <20260626-toon-git-replay-drop-merges-v5-1-5e120738b9d0@iotcl.com>
	(Toon Claes's message of "Fri, 26 Jun 2026 07:48:11 +0200")
References: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
	<20260626-toon-git-replay-drop-merges-v5-1-5e120738b9d0@iotcl.com>
Date: Fri, 26 Jun 2026 09:50:16 -0700
Message-ID: <xmqqa4sh8cvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> +static void put_mapped_commit(kh_oid_map_t *replayed_commits,
> +			      struct commit *commit,
> +			      struct commit *new_commit)
> +{
> +	khint_t pos;
> +	int ret;
> +
> +	pos = kh_put_oid_map(replayed_commits, commit->object.oid, &ret);
> +	if (ret == 0)
> +		BUG("Duplicate rewritten commit: %s\n",

Please do not add terminating LF at the end of single-liner messages
that use our print infrastructure, like BUG(), warning(), error(),
and die(), as the machinery adds one for you.

Other than that, looking good.
