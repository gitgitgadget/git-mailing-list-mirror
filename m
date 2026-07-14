Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4109308F32
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051926; cv=none; b=hCwgbwra9Ucp450wO8YqW/d7fVmPGM0GhuTj540OsfaEBmkik5NKYTLQfpKx/iT8GL5UJFRjsy8ER97hf8FL2ncK7/sGe5p8V2qTZM+4jVEl2XqWcdF9NcGcOavKoqgInQl6aGkoDkEKsmfWAZEQs3nPCmGYL9HqWFM8EN0BdKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051926; c=relaxed/simple;
	bh=DmkEFQZssZepaqS8EEyMcKRyqfoF0jcD2df0cZGczwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFG9VnB45sl9CVaV3qtFMSsQFF7++bsHEGcj2OS22UCHEqd1KRUJ4ckFJTBmWpT57PUScaQEvkZLSm138f4tfTlDdVTvNVXpSYNapQEPVtYrGBFhE3XlRTmg6yYAhlGSGz4UsUxWbUaCcG8Y3wI1wnkV6yluBPeqJ5Da3LZz68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gdVANPWA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dOTqhtAF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gdVANPWA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOTqhtAF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04E491400111;
	Tue, 14 Jul 2026 13:58:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 13:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784051922; x=1784138322; bh=VXqDwIlbV2
	uJKn8FYVnvbcakcCOeNACBggDGg7QNeeg=; b=gdVANPWAE0E1UX6SsNVo4I6/gD
	83lyj2Jldm1Xr/4uM3D6et6mD0V0QQrGnMng5ZTdsNUah7xsqatsYnGygcCPJlrn
	Aa/gXKrrOnkNTPzgw4Bg7Nm8PtyTW7x6moaCpHKwbrNULhwzR4gpJ1YPQsXK2iVz
	lJMHksEMbpE+DpZQNNbGdWZgRvlewZV53bzDpsj4tzL5BLSY747pY5pV5DcMa/Gq
	03rCtlaPHwrrvrJ7h5fph7cxivh4R3Iqooi84JdsRwCKIAWy/fwqABijjVGG3gAm
	NgudhkxinbIUlL8gbUUiqRvxQ1AKVg2pt2UMQFUeiiKeqqPpGw8HDMcXMQ/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784051922; x=1784138322; bh=VXqDwIlbV2uJKn8FYVnvbcakcCOeNACBggD
	Gg7QNeeg=; b=dOTqhtAFi03q710wOBPC0irI6NiZNwy7Z6pYDLDAfCBvEYHHDOB
	PcXUCAXDno4PEy1rMC/ifoXnnWsXuhJl2jc6RJwZqwJ81wzdIibdDft1S0Fcy3q0
	OP0bGo1+gK/eXMVjD+iIjgMImzrQue505SDC0fTYPAfhexivyeC06R/CYntPAKOY
	VTAHr1NRFiRu4s2A572brg7m5lr1Q1FWUWeePoxorT15p8ck4eXeLei7zMmKtASF
	o6ceXPFdR9LKSD/armDK4yEoflvcLpIlcE6EoOqpl2HnAN6bKaGaj2kO1TA/hPjV
	gDJa5974OEVz9BsmKnGBG7DWh2wmjK92ALw==
X-ME-Sender: <xms:0XhWai-VYAqxrQNuj4JGQkCUOE8UchXlX4XPrdixyk8AwBTgHtk0PA>
    <xme:0XhWaugprTd623AcFpLGBWwlZyEeu3lF2eOKhXi_igJNV9jYW8gmVP7e0CKGmMKoW
    Tdx5NR_xktRgAoAHUUkmYOwED0ohkMXzdP_HMqHTfE1I7SWt_DLNA>
X-ME-Received: <xmr:0XhWajaBkuI7376jnarKavGRYbKY33YBr0nH8lXZQhbHsbWu5x_SUT7yp_wnui3KutLQNbfu-OCMRkuuky9Zm9AfdHmGJZSwEjtLoEU>
X-ME-Proxy-Cause: dmFkZTFpoQyltCrBsrqgLmotkiAoNZgnSagQh70PWw3LfCHsHdm2gseo+a8/xuKCh3mOTa
    WYlwzwY07N+yI7NubZmxH218LLIiyeSfd6GF8fRJWAhqjcmxmfHz5QYjhGatcePqM0PqOG
    AMllVT9q5qS5S/1H4JnWxR35hPQGk9fnXl6blYlXJrmpBzehU77GwaI9EPRetvvlT5oTiZ
    Ld5WWFxoJWgZNlQwXCmd47sImf8k6hSS6LLLbd0+4ZqWJQlor/VUcN1YKzTJjjRHQLgMvX
    qwqCSql/8iagNFcDaxw3lV2zt7QWWUmRiiAsfmanqExew2BgThMaqNLjMPwpoLJ9SKShVA
    ZLQNyc4hzl1zSOKq5r1c/1Wz4ZS+aO/4/a6bPgMHUGdRNFPyyhtGnF755du9l7wG4mOh6a
    D/ydVYxzis0jDXJlIyyU6/vkNMjD0l3O01RaHsMLFpsy4+QiR2JrHCDPcDJ2YagDdEEvnd
    FdoXT/sdlsr2uO8NmA0VjXtikEv7teWpK+tVJTmIywe6tIcSTCwomqzmssGWJKaCMG937S
    nZNXIH6LC6EwEKzCUttsJL6L1i9L+KO37bP8HJq5JsF/hrYpa7qgfFvfEoEino82uj8oKR
    umChWTX76MltYc27W6Qgn+qiR6jrfFmjxWfN9chei2O/9DNxX2iBxMYlZdyA
X-ME-Proxy: <xmx:0XhWaj_F7Ty8fh8v3bJWGrISm_ATpR4vyITMKdyUjjW1_73dIuNxcw>
    <xmx:0XhWalMsEk9Zf38R3x7eljo7jez9w-d1-rRxjF1nbF8D-3K1dYUKow>
    <xmx:0XhWagFDEgC8CxsflpvAvmuFEmqFrLmz7rzosEbCKcppIZ2_ulBddA>
    <xmx:0XhWajx7ftytlaNbFkTvTa5NRsKHnWF7lIDSDz-4QJe5aSsMznvebw>
    <xmx:0nhWarW_Dr3y_2lIEkgzXYi9NOiHvbzFo0NwIT66sVqCHGcXvNujns3p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 13:58:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: chandrapratap3519@gmail.com,  chriscool@tuxfamily.org,
  eric.peijian@gmail.com,  git@vger.kernel.org,  jltobler@gmail.com,
  karthik.188@gmail.com,  peff@peff.net,  toon@iotcl.com,  Calvin Wan
 <calvinwan@google.com>,  Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH GSoC v17 10/13] transport: add client support for
 object-info
In-Reply-To: <20260714-ps-eric-work-rebase-v17-10-afabfc83260e@gmail.com>
	(Pablo Sabater's message of "Tue, 14 Jul 2026 13:45:06 +0200")
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
	<20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
	<20260714-ps-eric-work-rebase-v17-10-afabfc83260e@gmail.com>
Date: Tue, 14 Jul 2026 10:58:39 -0700
Message-ID: <xmqqik6htpv4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> +	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++) {

An overly long line.  Format it like this, perhaps?

	for (size_t i = 0;
	     packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr;
	     i++) {

or even:

	for (size_t i = 0;
	     packet_reader_read(reader) == PACKET_READ_NORMAL &&
	     i < args->oids->nr;
	     i++) {


> +		struct string_list object_info_values = STRING_LIST_INIT_DUP;
> +
> +		string_list_split(&object_info_values, reader->line, " ", -1);
> +		if (size_index >= 0) {
> +			if (!strcmp(object_info_values.items[1 + size_index].string, "")) {
> +				FREE_AND_NULL(object_info_data[i].sizep);
> +				string_list_clear(&object_info_values, 0);
> +				continue;
> +			}
> +
> +			if (parse_object_size(object_info_values.items[1 + size_index].string,
> +					      object_info_data[i].sizep))
> +				die("object-info: ref %s has invalid size %s",
> +				    object_info_values.items[0].string,
> +				    object_info_values.items[1 + size_index].string);
> +		}
> +
> +		string_list_clear(&object_info_values, 0);

Is this not trusting the other side too much?

If the other end returns fewer values than expected (e.g., if a
buggy or malicious server returns only "<oid>" without a trailing
space for an unrecognized object, or if we request multiple
attributes in the future and the server returns fewer values than
expected), string_list_split may return a list with fewer elements
than size_index + 1.  Accessing object_info_values.items[size_index
+ 1] will then result in an out-of-bounds read/crash.

By the way, from a stylistic standpoint, "size_index + 1" reads a
bit more naturally than the "1 + size_index" used in the current
patch.
