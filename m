Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F87DA84
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720924; cv=none; b=I93q6khaOuuB0cJmnaPW5kLbPXv4t6XKh7BE3NLm/YsqYnBlNiHO8fWml8msTxTru4msctl9zLW/Dm0yPCDHYdGy+e0YOj0NwBLPxen9amOusBJFz60eMDBuqBybn/xo+4BV4YC8rwCTUkjkLESJo4s44vWsGhDheVPM8kzDvlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720924; c=relaxed/simple;
	bh=UngFXHpERPn9+F9/2Hza/f/nwx4ld/2hnjdc/WAV6B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q61y8ETe2GLSJByFw8KzybIiTsiML/0uCvpJz0ELwHjN/GR86jvWxrYZq+tgQVBcfh1dzJtXNqjrjcLTZs9a0FCsUAwjKMsmFBMUbiAHXFJn2T6V+sPWImX1N8ZSrDmoXVAQXFWUlvBsQU496ug+v0jZaN8hr6hB/HewfV7ogrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eqRW8PoZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qTIKjtHC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eqRW8PoZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qTIKjtHC"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 47A811151D1C;
	Thu, 15 Aug 2024 05:40:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 15 Aug 2024 05:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723714855; x=1723801255; bh=VnVtg3YkTY
	VZrtVffkq0u79jVhkMe3S8sUvtahrDN/U=; b=eqRW8PoZPRGsZLAE5PUesYZ2j6
	b80DHggBuBqoQXgxalSX9lvdVnO7sEKxl1rGR3bUpJ5k+xLNf0iBsLhBAjbrgusM
	AuwuAPObj9WiSciolNBrmHtZTH7/sx2iBHUpnfVccdQi38NOWehQ4A2DlmFpU7mz
	tZ06V03i6mltPywwBSUZfMW+NvDLXkyAKHvlU3D0LxZK0ew37NhFPekuO+dD2Bgu
	z1n0qSNRKrDkGRzb/UB74JBwGZaUxQewuLif4Po/sptsFmg9q63UkfhP0N3VW+Jf
	DFTud5RoHnSG/5jUuaU1gHO6i/xa6Bu/AGt6cJJliz/lDAuroZ1lC5P9leKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723714855; x=1723801255; bh=VnVtg3YkTYVZrtVffkq0u79jVhkM
	e3S8sUvtahrDN/U=; b=qTIKjtHCdPnc52d3UHwbDpDHVl8DRaWp8bgt0hTAvuaR
	TR5eDbFQT2t/zXKLJ0ayAOklOERrnBxgGtgiIRupcXl5AaqNxJuo6T89WizpyN3R
	o+Qp/x7YZPWxJyBikIwsVhYvaldbnM+DeTY/rYYhVHSwITd8bFOlkHnVCWgV9Ohv
	WRJIb7/9uWETA4SkHoNorvC/Yw11jeZKl1X+YMTUGLyqwGzLvx0wizWaGtlHqH7X
	xuIDqWMN9kYgEd/whlY0VjpQWEXjHjpV638IWeLFVobLb5PWr6Fo8m41Ty/8rw2z
	RTHOsWCy3GtObV2cXI4isG6LSWSPyk1eSsMATaJ+rA==
X-ME-Sender: <xms:J829ZqBBAqPr7yn6vKPHJ6FZUyA5Ozhbx_dtRT5ZJMkeZ59kF_mRCw>
    <xme:J829ZkjNYfbAJjxKsCm4B579H8CHgm37dzPX0DUJa9QuJ7NjTEPKgo9VT24t5o_-3
    o4j4gYl1gFKKJSY5A>
X-ME-Received: <xmr:J829Ztlv02uUnrFJI0YS3iIhX6udfBBr-QD_Ivh1T5vCh-RdCJxPQPhek1PYaiMcLzoYYFLSsK-LSuzHBY60QCQ8RySjQrW8aOvRw2erjNaW5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J829ZowBc25WX1yKgxMLe37-gBIZtkaZGVhY_aJaxRGYvZe6rZqvyw>
    <xmx:J829ZvQ0r2ts5C5T0endGaJCl54fvJWCnYsngotx7L0RmrppMFU4XQ>
    <xmx:J829ZjZgAy3IYsaLtuEFEMNf-JFruXqL6Z5ObFrAFmBWI33yFThHwg>
    <xmx:J829ZoQMRiv1nzsN-xymHz7bPibS0XlTRDX9z8eo0BY1XiTj2lK9MA>
    <xmx:J829ZpdWpz2obmdG8zG4s4gUltJN3hd5KeiaNggVK6XLGl5fLA6sZR7Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:40:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf0ea29a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:40:33 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:40:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 04/10] t-reftable-block: use reftable_record_key()
 instead of strbuf_addstr()
Message-ID: <Zr3NJCRQ7W8KjXxb@tanuki>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240814121122.4642-5-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814121122.4642-5-chandrapratap3519@gmail.com>

On Wed, Aug 14, 2024 at 05:33:12PM +0530, Chandra Pratap wrote:
> In the current testing setup, the record key required for many block
> iterator functions is manually stored in a strbuf struct and then
> passed to these functions. This is not ideal when there exists a
> dedicated function to encode a record's key into a strbuf, namely
> reftable_record_key(). Use this function instead of manual encoding.
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-block.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
> index baeb9c8b07..0d73fb98d6 100644
> --- a/t/unit-tests/t-reftable-block.c
> +++ b/t/unit-tests/t-reftable-block.c
> @@ -81,8 +81,7 @@ static void t_block_read_write(void)
>  
>  	for (i = 0; i < N; i++) {
>  		struct block_iter it = BLOCK_ITER_INIT;
> -		strbuf_reset(&want);
> -		strbuf_addstr(&want, recs[i].u.ref.refname);
> +		reftable_record_key(&recs[i], &want);
>  
>  		n = block_iter_seek_key(&it, &br, &want);
>  		check_int(n, ==, 0);

Yup, for ref records this is equivalent indeed, as their key only
consists of of the refname. It would be different for log records, which
also include the log index.

Patrick
