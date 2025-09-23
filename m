Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872B22ACEB
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620117; cv=none; b=jR9AXOSMKdNDtzMjCN4T3SAl3cWgrEbr+5ENwidh++ZXXygSXAH8AlOVPp6U/Zi0C1qU8/kKI/uW/tQLmm7Sg+3OFc4jC2/cPpQj/qgkPKYS1jd4azGMnkbLIcu5wge9CxG8CoF0MeWQIvXVn4PM84LdTe38htOMl67jzlWPlhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620117; c=relaxed/simple;
	bh=2ynQbUoGjR2LkX9xsN7APEhe3bmvBaq53Pc2cticzFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4ODoarXelHNdhUo8KrMmEa+8jXvFsO0wQomlP/Sem2m1r20O/d45Wh+n5nTwbX0MJsa2upAdcXvizZ/NzVRHwuqxlKeNFvKio5NCzBDwl655uJ9H/moc8FlcJqW3wmVf+2betT0ixGlUHr+IhIT4HzYmRIUke2E4WEJx6hZNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=omS1Dn8G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jSfqJ8ya; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="omS1Dn8G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jSfqJ8ya"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C4347A028F;
	Tue, 23 Sep 2025 05:35:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 23 Sep 2025 05:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758620114; x=1758706514; bh=dc0Tb6GZh5
	f/YSfgtyS2F142LoV3mAVNZAIVAfmR2as=; b=omS1Dn8GayErNpqrjCJvTaOhYH
	AT64ncXEoxqJol4aeVrbhYiRHnuGgIiGY8tRZb4COGrrS6SAPENaP9nEn16jICXj
	1rVx4MhalQBa/gs+Tsa8P80rhhmS5AVPy/VrDUFab54JA+pDR2iSDn0r4uU22hQ9
	4Lcg0xg9cuow4kdaYl/0SOFm41VzFSUUm0PX67UKDHRn8RDbNIe6qUlki5BZjQdZ
	lRD1LST2ucDk+9NrIiY9tuKNI/exgv14QUQ+IsBloA/lhCycyJPiYV6yx8s8WM9y
	mKU1/JKpGiEyp1Z4LJg4BGy7kIcR2nmpeeFGVv6kqcHWsp6xYl7kxNKhQZ3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758620114; x=1758706514; bh=dc0Tb6GZh5f/YSfgtyS2F142LoV3mAVNZAI
	VAfmR2as=; b=jSfqJ8yaLWCVJv/i8LUQTbJdAE5aLCMW+bBI2BsuUIY5BDII/d4
	e1/+47YTU4APCWxCZdCZgTlAoD96F+jdE5La3A0P8Pglb6qfDlJ9VvZVR6MpYqDk
	QNP5GgbfBz/cF1VWgJQ9FhLorZ4YEfQdQsT/b2mE3N7iwZkq6jSD+noLMXSlDIpg
	9Gt6C1O/hvQB5BUmw8dNqrIkVfan23swqC/ARZpHpboLToVeiPMQBIqW7vrrX122
	/TTYHF8vlH7OvgWvt80NJTNXDCYsyAKCCayAyHIlxaJsC6/9jETak7TMIZ8ZLk9e
	7vV4TgjGNWcurxvMd9PuKNcm5jcW2ScIZZw==
X-ME-Sender: <xms:0WnSaIAKH3BupeGFJn4DQL8sAumgWDyKtEg_AWN0hc1_SaglmVp42g>
    <xme:0WnSaC_TaZcfwmRjiuv8DePoBwx-yKpTddmWxp4aQrAVFMWM-ft57aeRaL137fcN2
    jSaUTSF_UoqpKXGy2jwQ6e9G29CRPSYgRpyWWY9Wzwkq8SMKRmr-g>
X-ME-Received: <xmr:0WnSaMCUDOFWwaekGFd4QQ2zLTvvK_jsi8uu2EUAGKnOM963eqoIypECAgmQnPngWZpJz3lz8YseGx5CqNAWF20BhOA9XU_2SF1oOJMT3iL3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvght
X-ME-Proxy: <xmx:0WnSaPSkdScDEWEEohlZHsQCGJg5avNj0Q-wiA0IpMpXqLnHspK6qg>
    <xmx:0WnSaLuSareo_WwGxqy19RDB11X_vE56y0cszSrAp3E-6u9HkE2Pyg>
    <xmx:0WnSaD3yoFSk8lHTMXan5Esj-GlqPMVN8ZL3BgQHzHUOheYA_HNv4A>
    <xmx:0WnSaEX2M9dsGh6otlo16HdVm9iaVnEYeztsftxeTpUdwNOuOlLQ1w>
    <xmx:0mnSaKbi7JApPC3q3iOaKkOdBaJ9QcKZ1dxZbfHpOfJmydensQERlahw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 05:35:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9dec1ad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 09:35:12 +0000 (UTC)
Date: Tue, 23 Sep 2025 11:35:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 04/15] odb: move packfile map into `struct
 packfile_store`
Message-ID: <aNJpzUATL6wAQiuy@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
 <20250915-b4-pks-packfiles-store-v5-4-d6340350934f@pks.im>
 <54aadwxqaxm5sewgxg6aegfrvtqrdla6mxbhkrdbbufgqpb3sd@ymwtrihoj4kb>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54aadwxqaxm5sewgxg6aegfrvtqrdla6mxbhkrdbbufgqpb3sd@ymwtrihoj4kb>

On Wed, Sep 17, 2025 at 05:15:44PM -0500, Justin Tobler wrote:
> On 25/09/15 10:54AM, Patrick Steinhardt wrote:
> > diff --git a/midx.c b/midx.c
> > index 7726c13d7e..e96970efbf 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -460,7 +460,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
> >  	strbuf_addbuf(&key, &pack_name);
> >  	strbuf_strip_suffix(&key, ".idx");
> >  	strbuf_addstr(&key, ".pack");
> > -	p = hashmap_get_entry_from_hash(&r->objects->pack_map,
> > +	p = hashmap_get_entry_from_hash(&r->objects->packfiles->map,
> >  					strhash(key.buf), key.buf,
> >  					struct packed_git, packmap_ent);
> 
> In `struct object_database`, the comment above the defined `struct
> packfile_store *packfiles` says it "should only be accessed directly by
> packfile.c". Now that the packfile map has been moved into `struct
> packfile_store`, it looks like "midx.c" now reaches into this structure.
> 
> Is this something we should consider?

Hm, probably I guess. I think overall the comment doesn't add that much
value anymore now that things are a bit more self-contained, but let's
keep it for now and update it accordingly.

Eventually, it will be dropped anyway as we move the data structures
into the object source backend, as it becomes obvious that this is
private data at that point.

Patrick
