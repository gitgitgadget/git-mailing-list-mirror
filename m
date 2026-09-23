Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95549572681
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193816; cv=none; b=juqnvolzs50M1i1/s6kh9H5c6aHkc4q6P/qGtyoC4qgyU0Z6pE6EiocBI/cwPpECm6cc8C7khey0CQ2R+lx1PgJ1/YysOR+PNr1EKNetUci3TPlhwCll3BsJCZgCHay7hmcPT7WWLvLoKRc/xvgzUa+ciw8CXhTiBoWyubvIht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193816; c=relaxed/simple;
	bh=IQ7q1A55szdppVqn1GUe+anV8/h3GI9ks72hBrWpvlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E7a2D2M4RLbcLRJB9QIdHcU/J2PT8qr5qjj+LJSPDAkpzDrWm1DpUdWQOu+te/VTGaq/bEa1M/el+KGgbPb+liB+Jf89et4GinqVVYtLCsJQlNV5Ba9ogQu20mMAebCm7F16HWw54BXBGZpfeGHP19bOXKc0WLVCW7PBTRdiwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xm7nrNTw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTw5Wsik; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xm7nrNTw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTw5Wsik"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 9DA2EEC0123;
	Wed, 23 Sep 2026 16:03:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 23 Sep 2026 16:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790193813; x=1790280213; bh=/GsRUGngvN
	SfKu6awj8uUUxinTGgH8maFGZ2YilN5mM=; b=Xm7nrNTwO5e9dzfMajOHzdCIjv
	Y5AKs0XGlc5c/kd9Ie7II075lw+OlN+EzQUJT/sDRKOjvrFyBfwSltasHgVOI+21
	2AzysSjF1VUg+iDfWbYJVDhtBzsDG+YzqdMbMJO1OYEYZD9b8h3I/89qJo/e4H5j
	d7IfEuGhQ/2JJ2IMpnH+eneL7QItkDc5yADlEvnGSSERnxTKsIke23JmZkPf0ujF
	q1E7pE3lNJhAFCPu8LG9nPP4QPFU53r47fk87yJVjBDWdd064kjwAg/iMqJwcW8U
	Fhy2mQinHD6mRertTHKRhlwy1fQAs8dQvmHedNKc5tJKWOkQWpL/x5eq6IWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790193813; x=1790280213; bh=/GsRUGngvNSfKu6awj8uUUxinTGgH8maFGZ
	2YilN5mM=; b=GTw5WsiktMDJqHsvYPpzU3CAvWbw80FnJTTaneBUgJhkQRU1iBG
	sSSUT+ihFcY8eB7nIgkZfB0vV11G0kX3SFe8JSfG1LMFN1jUs4+sKXzXzuP535w7
	IYHibNL5fwFKYXeqXciQhqvmPLDZ3TV+0oBIjpusFir/Rbj2vfZpwLlNmYM4yu6S
	V8QaNQo6VZO8/l5XXMt4Dylt3Zyg66Y5tfR86Dkx8CvmkxKsc28Uw7PRezXSWl/A
	TV6/1VA4WTMiLbjDxV8LOsSv4OoQW23ZzMkfZ/Qh4iH3hvMNjuxKCi1yNBBUGUKH
	FWExz3tGy1wU7xiFwz739u5pPTSHz0mdkjQ==
X-ME-Sender: <xms:lTC0aijnj8DFn-skBW5TkxlUw7CE40OADjETApkH9C4heVh1ezoVPw>
    <xme:lTC0alk8h0KmjgahnXuFbeE6aKbdSh9RyWw9bmcO9ZubseVzw1D8RttICLMoS83oa
    jiSyOK4h-AZK8vjxrC2_f5VDrHmGH89kXkD_c19LIHQsgl6cPdCKUs>
X-ME-Received: <xmr:lTC0att89iprK13fM4YkYAjZD8JKoCqMjzVE4w0bMtBf9I-_yrAlthffQzNTxki2PoTFAFU195oovCGQ-qDA3FeBRuxkNPiZY3Qx>
X-ME-Proxy-Cause: dmFkZTEG6d7eUyjPxmZ5JY5G6LxfsObO7kn7pFoXdZFpHtBTPKGA9ITJQtNRAbz/OWX8Q/
    iqnmlJWHVDbChPocPeDYQfCKd74yJcYHl9leWfKmgHEFvVK4DNjDrS0TKXIhrxXx1q0ECS
    3hhwjR5gbrh4RzqBgjwYV0FGabDSFNSJeHFLHw6zfroH0+i70doGcF2RwojtEPiPZCKF0h
    e8/TDTl7L8AgdJI6GWLzeKMpsEqUp5kiswHorU6cxPy/0zDgxiJCVJbTCBQNP7cDlKkGuD
    Wg/qrSj1Xkf5+YlsQ6g2QvW7Pp7FWJUlFcDm28dzweUzgDNS0V37bYoROCvO0OX59/YiO5
    38dRKS85pHshjJ+Z2i0bGZ4u1DD2g1ikJR3iu2ZQtM7wOivk9sxSYtJWR9//2qw3x/l+Zj
    UM9/fokEVFzPxSvrSE1pgKAGSw3BkFaL6frs1bTo3cbZ0Bf9L0FOGw22q+URpMf0NYGhRc
    jggYSFtj9bb8mn4+/aijb22dyf2J91sISbqzv82P/UGLQoz3SSMMJbkWKdrEnEj+bmpviJ
    8IqAtUBE8LrMt7/NyIKXYpS/3oovTtwYV6CWpZIywN9rZTqs3vNPwYGSymCk/GU8fo1xeh
    WvFhxLzqmIBCxV9hYQsCrHeCbkdr5QVSRwNLdUe1YuVZz8p4iX2PAQWFj1kg
X-ME-Proxy: <xmx:lTC0aragkNBf_EW8eY6gKgfEXwjXCbeDlrnUci-ITSujwpXGcmSVbQ>
    <xmx:lTC0alAhQDu82Z0bEMCNsABi52Qckko_zSrPd2tfAH7zbQb_VDbGFg>
    <xmx:lTC0aj_Fnf9UcBsSx8g-nacxM8P3mmvyXsEJY2p_PYnXmZg3-7_HmA>
    <xmx:lTC0ahSSftYuYTdYgwNDTRof7iePg2RP9NTOVNZaCNXRkGsM1ZjTdg>
    <xmx:lTC0amM0hM-yZOd4U2GKOHU7S0hXb2vh-IYOAoTDEYS3qd4GgpJp04Md>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 16:03:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Phil Hord <phil.hord@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  "D . Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v4 3/3] fetch, remote: retain old OIDs when pruning refs
In-Reply-To: <6f34853c79625794d2eb364d227660be57d1539b.1790113781.git.maciej.ciemborowicz@gmail.com>
	(Maciej Ciemborowicz's message of "Wed, 23 Sep 2026 00:31:10 +0200")
References: <cover.1790079917.git.maciej.ciemborowicz@gmail.com>
	<cover.1790113781.git.maciej.ciemborowicz@gmail.com>
	<6f34853c79625794d2eb364d227660be57d1539b.1790113781.git.maciej.ciemborowicz@gmail.com>
Date: Wed, 23 Sep 2026 13:03:31 -0700
Message-ID: <xmqq4iffag6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b662216bf..95789edb8 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1471,22 +1471,29 @@ static int prune_refs(struct display_state *display_state,
> ...
>  		} else {
> +			for (ref = stale_refs; ref; ref = ref->next) {
> +				string_list_append(&refnames, ref->name);
> +				oid_array_append(&old_oids, &ref->new_oid);
> +			}
>  			result = refs_delete_refs(get_main_ref_store(the_repository),
>  						  "fetch: prune", &refnames,
> -						  NULL, 0);
> +						  &old_oids, &failed_refs, 0);

Isn't adding a new parameter to refs_delete_refs() needed before
this step?  The corresponding changes to refs.[ch] was done in
[1/3], and the fact that the callsite receives this update to add an
extra parameter this late in the series means [1/3] and [2/3] does
not even compile, right?

Thanks.
