Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328DF40DFD5
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781086; cv=none; b=c2NQQSzni6eV6QIJ/peeeKAn41dBW4tE6IcuY7QT479N0WD4H571HVVHO/Wz2z1QbFGzskTW0oVwvJ00isemBwkyI2Nzfy0b1wowa1h31acnPf7pP+A+0tiU+sdKMqOxAmhvcFt/MFGimow0LUPXg6clOQaxusSYaq7ESt7solg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781086; c=relaxed/simple;
	bh=BYvII2ciZmXfw63JEcbFf3u3XF/4obWAwuA9Sita13o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hZCr0i2lz2PYXpnMRElbgUniROT4Dode1xwIhDI+KxOaUREPc2HJjVs5Ie4NF/DsqYCdi5/bqukORwtVE6AjrJnwwgDGR1eLdvQB2BDqqd4/njHplivUBwoWXY9uJJXiw16b3eFnCTtmSogMNx8g45RoVRv2IXBd6jrdz5bLQOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J1Dk7ST+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+7dXSgC; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J1Dk7ST+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+7dXSgC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3810EEC0197;
	Mon,  3 Aug 2026 14:18:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 03 Aug 2026 14:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785781083; x=1785867483; bh=mDF+2TlTym
	692+Be8LDH/8ntdFE9PQ+HQwkDI4DLYXY=; b=J1Dk7ST+UKYml2/vWDXPEFMzTS
	OGHjA3dFtTldQNCsvLhbPW2aubSc1YBF3lSyfgSpH5/cEEIJ5eNTq8crMfTdWJOz
	YtwRGuilN6bacW7+Zv420nkE9hWOeE4Kzom7iMnXPMSUqABvYA0qxYv2hi+zvQdA
	9h0ZOUBGIoSDwOnFrFkSk22hZNK0x7UwjIKaexp9EVii4crfq8gTB7jHhAJjG+iF
	P0Hw/Z2lXwkHz96jOv70dRcHHiZyxjArQ9A2YsWW+Ke/MhlQLkdySmZlSrOxmkoS
	oqvJIh5Cw9ccgDlfQIHXOdHIIca33Vbpg2mSFI+6+4VRO2QDqHVfOSSIOlFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785781083; x=1785867483; bh=mDF+2TlTym692+Be8LDH/8ntdFE9PQ+HQwk
	DI4DLYXY=; b=W+7dXSgCtLPmWVCV6oz7+A/hexOf5KOoJP72ENI0xqI4sZruldM
	H4KOD4SvnTyxyPidNy03O4vh+8XUrit8q5F0K0sEglunMQEahF8ZhFVqAz/QWf//
	oizSY8ryOzSxStEJm/LczagwXY7JlWQ4lx9nxE0KhJhIQaxtI+mF34w+wQZPSskz
	hsUtiEyxCy5msC9N7yRbIc78p9zePVe155JMYLhuWNkB+7ihEegGQB37dcMBzfX5
	P7I72VVyE7pBUfwmjzfXT1GjJELB8L5HzEFpY0fNoorbr4OVcCYGAdl/reKWD8/P
	bc9NBEocTBT9hy2eqGUN4nOzl460Ua/Z7Xw==
X-ME-Sender: <xms:W9twap42gOGoPFaHf0o5kdz6jE-ly0TMMk2Q_nOCkT4JuAZHZEJjcw>
    <xme:W9twaql2wom41av9jDkAUE8de35hI0WM9jayUfbrb8j2rEugzWVaVbMiZ3dAZ0z25
    cJCdml9b1F1eVzViZLoFT38EeMzdBP9Ebn9xsyNo3tq-5_ipr_bFQ>
X-ME-Received: <xmr:W9twaqS295jbull3jR_W35jbzrgJNksxdq1DgfMS2YKpwQnTSsoVIZMO6gF2IVb7dpyq_VjAcdGs9qxliCOiW57CAhM6l_87TQ>
X-ME-Proxy-Cause: dmFkZTEfaDvmq6dhdjcxODd7c8BtO6UGmSvMifmgCfj0y3DRtN0IcPieJeLZidCxFZqgjR
    L+KVb04CgzGMHuBpVoC9k2oSvJLe30ljyZ8ZSWPAlCEWkXnuzjRmu0oVP349iFq49YZen0
    Sfp7BRBFsKtkoHTUGyiOj2hC6Z9pOKPTP/Ycws6Icr/5RFz3/40POgAcSTUATjEzNi3jXT
    DUFphtGkE5WL0sb9GeMn3VBoRVelnCAfqoQQiqHIthSJ61lnUF1kTjQMqCbXbe+Kyvqg3D
    /Rv8cvskFvvgQOuuYDnOL/LDnJFJCa1+T8RiJUrhPHtXytzfmo6l+x9EHt4OKYx1UkBORT
    9QVrkfY8Y0GoYhccy3n3tayLxfIkYUpsyr9cu1yF1Q3FbtCheTKvYWO0/PMo0kl+H9xOTX
    MwfvFxs1Xhi38/iue6bAgxx113VrmEtjDSTRx2sL8NQ18BtTpUeWgfaezV0I1DyYRWCKyy
    CjvhZ4TThaNR2vRLfEpgieHNb5P4L0VXwtcwq9T7cEftjXWNGDRpEeSST4V4VfzfCkawjL
    14nrjgvjc/GCPaZejWAhTU1jDT4Axg1v9WvRyyKTTd+BXI4hD2T2PZxcEiHqkV02FmoyTf
    0MwvgQpr+i/I3lsaYDru0PO5+PVCXK1y+djHFUoobqzB3N77JhsLx0M/lohQ
X-ME-Proxy: <xmx:W9twapGLrSrSPQE3Pv0EBw7QDFtGPoMgNwNWe068oKzml9dpuyxsuw>
    <xmx:W9twavGBauVDddGo1EDIUPFN0h-MxA4Qs_9o6qvxGQP5rn1AN_LFBQ>
    <xmx:W9twanT4c7bRekWNNs9rU0BHeOH6zdKhM667-yGOIVj8P_ObDBspnw>
    <xmx:W9twagJ4kZG9a9S9Jppw4PyH4hKsY7NG7KRqU5g-LhKOkITOayDGqQ>
    <xmx:W9twarqiNbwjVo52H4y6TBadPQ-pzpZ6XwWyWUp0qonL2MVhf6vNghcC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 14:18:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  karthik.188@gmail.com,  peff@peff.net
Subject: Re: [PATCH GSoC v3 2/8] fetch-object-info: detect truncated server
 responses
In-Reply-To: <20260803-objecttype-support-v3-2-7176fecf7950@gmail.com> (Pablo
	Sabater's message of "Mon, 03 Aug 2026 16:39:29 +0200")
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
	<20260803-objecttype-support-v3-2-7176fecf7950@gmail.com>
Date: Mon, 03 Aug 2026 11:18:01 -0700
Message-ID: <xmqq7bm7yso6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> The loop reading the object-info response stops as soon as the reader
> returns something other than PACKET_READ_NORMAL. A server that somehow
> answers with fewer objects leaves the end of the result arrays empty.
>
> The caller trusts that every requested object will be filled in.
>
> die() if the loop doesn't reach the number of oids expected.

This tightening is obviously a good thing to do.

The above description makes me wonder what happens if the other side
sends responses for more objects than we requested.  We allocate for
N objects and loop for up to N iterations, so we will not read more
than N.  But do we detect that we are out of sync when we read the
response to our next request, or before we shut down the connection
if we do not have any further requests?

> @@ -49,6 +49,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  		      struct packet_reader *reader, struct object_info *object_info_data,
>  		      const int stateless_rpc, const int fd_out)
>  {
> +	size_t i;
>  	int size_index = -1;
>  
>  	switch (version) {
> @@ -82,7 +83,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  		BUG("unknown protocol version");
>  	}
>  
> -	for (size_t i = 0; i < args->object_info_options->nr; i++) {
> +	for (i = 0; i < args->object_info_options->nr; i++) {
>  		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
>  			check_stateless_delimiter(stateless_rpc, reader,
>  						  "stateless delimiter expected");
> @@ -106,7 +107,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  		}
>  	}
>  
> -	for (size_t i = 0;
> +	for (i = 0;
>  	     packet_reader_read(reader) == PACKET_READ_NORMAL &&
>  	     i < args->oids->nr;
>  	     i++) {
> @@ -150,6 +151,11 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  
>  		string_list_clear(&object_info_values, 0);
>  	}
> +
> +	if (i != args->oids->nr)
> +		die(_("object-info: expected %" PRIuMAX " objects, got %" PRIuMAX),
> +		    (uintmax_t)args->oids->nr, (uintmax_t)i);

OK.  We give 'i' a bit longer lifetime so that we can do this
comparison, which is inevitable.

>  	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
>  
>  	return 0;
