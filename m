Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06177369985
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785877101; cv=none; b=rdNZ2y67WBQ+d5mMhN92kH2M0Y63x5DWwpjEq5pKnOao3LTFXNyAYUDnE7oGvtrqEr56oE6Fsak5DYOw1HNL2XfOewIevwbo2PTwKAh2suHnybuIFGYtO7qXlPZ3OMQOH/P909t5An2LG5M2LmfEYaum+1j4cQkFfLIrhGCqFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785877101; c=relaxed/simple;
	bh=uyvZOoT5a8aNIAAhZX/CfzVL/blu5zi95pyzhlHfvIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qSD2FxRLZH7q4k8xnfW0/5nIpfWkc09N5EZi2HO9yvNsVhP/9mcC0EsPix6LkQhLA4NNAIPEzO0PRPLXodnQ10IRoKWHbagEOsy8uj1qYuk9E9SpZsUkq9Yb9OdbLKAjel5lg2mPFjlBB52jt/2cEKzQYvDVqpN7dkt/7R8lZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=z8DwN4KD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RWdJWJPr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="z8DwN4KD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RWdJWJPr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B19FEC00E5;
	Tue,  4 Aug 2026 16:58:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 16:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785877099; x=1785963499; bh=5f3/iAP6B1
	A8Uhp66i1ZsZUmS6bMHRQp5GR4+0bhNWM=; b=z8DwN4KDgykifWpX7j/eHoO7Zg
	U/tAdSXZ+ktlB7M9gbAhC9b3KPSjyjyyeakxD6tEO0+WsomXGZosNg1nRnarVYPF
	L5ZecxW8c/GJy58JqneAm/lN4jwUGQI2THbz7f3GzzCE4YwS/4aSw0MsrAmRBrf5
	p7Hf37qFFtT6ZKDCQVN9MgMdtLx2luwMT2qbJ59FRcbv2/HX3sNhB3MMCgEqVGBW
	ALgrxNHcNcBMwQbnTLrSxuBEndz/7drB/HnZRsdJxx0rGgtBu1yxhab2yie1Cn9i
	qEvr6GVh23JxHSs1Bqf87sZQUxrKBVddbSoQ3bNUCaD6ClthGSEjNimWP4KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785877099; x=1785963499; bh=5f3/iAP6B1A8Uhp66i1ZsZUmS6bMHRQp5GR
	4+0bhNWM=; b=RWdJWJPrn4sNTvcI6FBepshSrCDNAIlSzZBgTboQRpXEXYHrQhk
	MpYjJsQMOTVGSLJTjrFBcHfPy26Y9+vRVFuaebxuH2mZLKxvsr+j3j4dzRni5m5x
	N/aLRBtA3pCQQNlnhvwyclwmbcmGalxcCG3ScgpO/wVvU3dj1c4MVZR6Y0D7hFaN
	6MDHzi2wqQyv5CbqCiih4Eo/FvPbMSJC3+TO1EVkcCsOAWZqCoJsx0XAE1x7SC1y
	hrnSjrGyWvkOoo7qlzuyZs6oHumccDjLcnmByQx/DXHWjgUBTW72Hx1XqtK/nMHY
	7H0MOq1C1aQnHeu8T5+csXNMDqZw1Lp/7dg==
X-ME-Sender: <xms:alJyaosUL7ehMd1JKT2xPLYLjYApwVaMSC_CtOBipj1XCrqPUz9oxw>
    <xme:alJyapLiFb0oShnrlLN86Y96PzzA8ixAJGF6S3P_tqhSWhTfLakevwc4ruFaBWkNJ
    lQdCNlmOpANPa-3eI3KxAL7stnQZ0I4nH_ki65eEsE8CC4nmDexETY>
X-ME-Received: <xmr:alJyatn-O-963ZBUa537JRw3oJsfmmTcy8_8Ke9v1VyGRPLTBWIizDXy1zuJQlnJ05CzBjSx-6pcGIjObTlKeF--8ppBNMViBg>
X-ME-Proxy-Cause: dmFkZTFaUhGmhx2lV7niB9slqprVzuiaeyE6Mhq6z6UbdeBjCgIVRRqDn0esQ7VFsTR1YE
    HS7sWMfPwK/3dbpUPmgi0e8kh9Qklrp4T9+Y3Cuhk4c/EOLHeXzZ/E2k1MiQ1Zwh/FWEIg
    qGAZOI8WPDblja27Ir+Xe/FQCoIZw70VNV1nBW/dEKJZ0C/x8yWnE9BUPaJdQ6MSfwhsrG
    WeBhb2dy+u8tb9WCP5rjecCJ1aYMs+cjOyXDpRSvm4bBornT/oEHhUL9T2viCwvz//rHZX
    NhbmRTvGPYIJXsc5xPApJbScUVw8VAaJS9vup1hE9sJTZwtIyqh65Q21FB0YVtr1O6ZxoC
    ysZDJ8ffxWmeHeFabtR99TxZp8mgUaZ5JfL2as0ruUxAdJSb32DMjL4LfAtbtOFBU6JXw4
    Uea323hMkT1NdPBYRlTW02yQb+lpQsznMo3SMHvpcpeuAXMjynALk/SpgDzQc6rFm1JbSP
    XyjoBVeLpc8iptJq/xz9654WdAoTuqA/vta0GzzMGq46zPHMkMMI3+vc14spbBfNzPahlI
    dJjGFXv8b09WDukud2WNMp2KLwNNwlzlAGSg6Ubsp27LsqXqgTBU3Rn1+6c2xafj4+csKp
    6T3D2XDU2rz0C0m2nj+aoOm3o12CL70NRMp4Potykuq7QE96y9WdaLa8U+Dg
X-ME-Proxy: <xmx:alJyaiLoe8UiULsx5R5iPM8yGKkINkT_1AP_ybo4kusIBLvpbHQnIg>
    <xmx:alJyaq4xHkr3Si1EsB08t3r8zkd9F4QSMzdp8l3rIno4DB__NASWEA>
    <xmx:alJyau2ZFe-MAERvit5sYUj_pzltOoEXHH4-T-qUg1iznKufVNCwTg>
    <xmx:alJyaofuAa_FpB_BsrfeX2UpElo0mgZ3i0jEGI_ynkMRgxGCfn7-Ow>
    <xmx:a1JyaldjKyxAXkYmw3z7-XfefxWKkCxwzX2aHjprRybNII0AQO5R5qbQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 16:58:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  karthik.188@gmail.com,  peff@peff.net
Subject: Re: [PATCH GSoC v4 4/9] fetch-object-info: use dedicated struct for
 the results
In-Reply-To: <20260804-objecttype-support-v4-4-31511b0231be@gmail.com> (Pablo
	Sabater's message of "Tue, 04 Aug 2026 20:42:58 +0200")
References: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
	<20260804-objecttype-support-v4-4-31511b0231be@gmail.com>
Date: Tue, 04 Aug 2026 13:58:17 -0700
Message-ID: <xmqqh5l9txg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

>  builtin/cat-file.c  | 59 +++++++++-----------------------------
>  fetch-object-info.c | 81 ++++++++++++++++++++++++++---------------------------
>  fetch-object-info.h | 27 +++++++++++++-----
>  object-file.c       | 10 -------
>  odb.h               |  3 --
>  transport.c         |  3 +-
>  transport.h         |  5 ++--
>  7 files changed, 77 insertions(+), 111 deletions(-)

We lost ~30 lines mostly thanks to losing an intermediate structure
and need to flip pointer members in it to point at heap allocated
locations?

> -struct protocol_placeholder_entry {
> -	const char *option;
> -	const char *atom;
> -};
> -
> -static const struct protocol_placeholder_entry remote_atom_map[] = {
> -	{"size", "objectsize"},
> -	{"type", "objecttype"},
> -	/*
> -	 * Add new protocol options here. Even if the server doesn't support
> -	 * them the allow_list will drop them if the server doesn't advertise
> -	 * them.
> -	 */
> -};

Hmph, it would not make any difference in the final result, as we
are losing protocol_placeholder_entry and this list of atoms, but
I am somewhat confused.   Why we already had "type" here, even
though we are adding support for it much later in the series (and
unlike the previous iteration, this iteration did not do the
ask/want_type thing in the previous step)?
