Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C7270EA4
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367316; cv=none; b=jConsbuO/n5dlDDDinCfbcfkmBJfwZjjIk1rPb9Gtf3j/OFa09rPzMl9m3sSswAci4QxIvaFXAaX0VSD4TUqyaf3kS5YqTkMzqMzJZYomVkRm1qODMJ71Qfvqfq+d2EhpFXqJl9nosGHG8X+51sm3+GD/u/vN+kf8DXkpzQ2ef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367316; c=relaxed/simple;
	bh=SmVRWGNl8GzGTFaOFQlRYiq45U0blNJwAizuzKEv3E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cP/Q9nPywo8d1VeX/sJ5AEKx70AFa2MPhPCd6ria8htVRYn7FVAk1PjIlXGRfrhqwz67Ipdj6qyh9gNYibbc+RMzsN6TUevmZLLWfi1fODqpVK/CzBwOdDowcXkQHGo7bUruyFJ8HWP93R4FnXFR3TfND4BZTIxanUhUMLFkgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bc8I91bE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nWSnqdsF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bc8I91bE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nWSnqdsF"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 755A51D0020D;
	Tue,  1 Jul 2025 06:55:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Jul 2025 06:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751367313;
	 x=1751453713; bh=2h04j8XHhIOI50tueho1CQu/jjE0yjUer+8Y/tIMOCg=; b=
	bc8I91bE1pnO65rWxY4tSx8Uulmi6eoYUi6IlPJuSCBw5ZCHBzHyLuM05ni+YF69
	Zpxk4iSsQvqf7kHdFmXttfI/kkLEEK4hM5ZBDRRxl3FbBCjIl9D5zbEHXZE5v9o3
	usXQCNRhgagl930rHP71IX4kqLiXUCkifBNtM4pWk5Kbf9eUhgEZuS5VUkc3iikm
	VCPmxoNqxdW8S0VMXlZ0X6x6K3QEUOj3UGOUAwS+Mvnwmdl7U3xG1ouxk5c8eG3q
	byYiHbtHwiF2eKZyfFCS/IEid4d/uzray/WvPDQedUg3X56hMW5yPbLeKQqcHJA4
	1c/mXPHh5+cQPSrx3XJVpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751367313; x=
	1751453713; bh=2h04j8XHhIOI50tueho1CQu/jjE0yjUer+8Y/tIMOCg=; b=n
	WSnqdsFVscI26xk5q37JqhqS14DNBQl7YwG/2RDqyLn4cRGyNbv7NNvKLDGv7x5W
	+6myeBy2IQhhEt5mcSfM4ChiIVqRmK6OneV72dZOaHOgVbpSaj6iKzTFJgguvktE
	w5q4+Nsqz5v13LFMnCENSrO9K4Gdi/U+18ulIprVruFLj2iMAULWKJWMP9JBvFAE
	kAEv0ll44LQntaKtMwL0enElVcOFNhKAmGW8anmxeiRNdjWsU0JphwUSOpah/zca
	rUZuDjCdnvZom5QS85YuBHXikamTsMkq06nd3suHEGXWcWCNt26S3C7C4AXqFQqJ
	sThy20XjGfoIYdCwDE2bA==
X-ME-Sender: <xms:kb5jaCLwBpFkcENtbQh03icVNQN1og-KGK7P7fyytBVFbUoOigJFow>
    <xme:kb5jaKLmAB_LyeEFam0hDXgxQrmVZ1eg8FA1d2SWWM2F2Zn5rO6DuGMbpbPoG2yWW
    6rjQnuiQIIpCMVmOw>
X-ME-Received: <xmr:kb5jaCsXUBMwtVH0Is7YG2cqgbgwtTwTINeYSYTV7oos1J9lPce-wPzWkR0-RLmxPKDeMQhX04HRH_r-cmYIx8JUQum5bon_OglI6AvocQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kb5jaHbrcRj4e7Qp2wLkjAVYtT4wa1SYbtCLKVEGfI0rewg9lcpVeA>
    <xmx:kb5jaJYJGWOSaNaNOQ2HiSX_ZlufJapCgsP-lGkQmuYZW0caqCln-Q>
    <xmx:kb5jaDB1dBuLSNM_Eb7fWgqA7H8jqgufTP1IkDDQRlBhWqS7XUFK4A>
    <xmx:kb5jaPaWvGy-9i51ucTNQTq6Fz5jqQgO528B-bRLyRGmv5ra4Ll-0A>
    <xmx:kb5jaGLDsE4YwYoiFTdv_qvWOCkoCnzOpnbxGCTF3ypR0a286mPmzE_P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 06:55:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 916d1ffe (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 10:55:10 +0000 (UTC)
Date: Tue, 1 Jul 2025 12:55:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] parse-options: add precision handling for
 PARSE_OPT_CMDMODE
Message-ID: <aGO-i6V6_iN678_7@pks.im>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <d92697a6-5367-4412-88db-164ba4dd6230@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d92697a6-5367-4412-88db-164ba4dd6230@web.de>

On Sun, Jun 29, 2025 at 01:50:31PM +0200, René Scharfe wrote:
> Build on 09705696f7 (parse-options: introduce precision handling for
> `OPTION_INTEGER`, 2025-04-17) to support value variables of different
> sizes for PARSE_OPT_CMDMODE options.  Do that by requiring their
> "precision" to be set and casting their "value" pointer accordingly.

Makes sense.

> get_value() needs to access all PARSE_OPT_CMDMODE values in addition to
> the actual value it is supposed to get to detect conflicting changes.
> Give it an example struct option pointer in cmdmode_list instead of just
> the "value" pointer to allow it to use the proper "precision".
> 
> Use optbug() in get_int_value() to report options with unsupported
> "precision" values without requiring enum opt_parsed flags, as we don't
> have them in build_cmdmode_list().  Use BUG right afterwards to abort
> for uses outside of build_cmdmode_list() by aborting immediately.

Hm. I have a bit of a hard time understanding these two paragraphs, to
be honest. Might be that my brain is still in vacation mode.

> @@ -280,19 +297,18 @@ static void build_cmdmode_list(struct parse_opt_ctx_t *ctx,
>  
>  	for (; opts->type != OPTION_END; opts++) {
>  		struct parse_opt_cmdmode_list *elem = ctx->cmdmode_list;
> -		int *value_ptr = opts->value;
>  
> -		if (!(opts->flags & PARSE_OPT_CMDMODE) || !value_ptr)
> +		if (!(opts->flags & PARSE_OPT_CMDMODE) || !opts->value)
>  			continue;
>  
> -		while (elem && elem->value_ptr != value_ptr)
> +		while (elem && elem->reference_opt->value != opts->value)
>  			elem = elem->next;

Hm. Previously we checked for the pointers to be equal, now we check for
the value to be equal. Are we sure that this is always equivalent? Can't
it ever be that two elements might have the same value?

Patrick
