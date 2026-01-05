Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4F1CAA4
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767618058; cv=none; b=RDn5TMEDlMzLZLgA+rCB42avOQRJIxtbLN92K00hDExCdb11xs30eUftbcTKRQNIuhd1V66I2yEK4KUJIn3bgxz8+2FL/MwurL7STBF2qUomE6IhgLgWwN0qc5gKlpUwZXALTrSIUPoSgjTSZYsnNp8XFl+W3VfaBLxBLVkHH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767618058; c=relaxed/simple;
	bh=jUOgfvFTxEUkmSxegj7gtv2TaaOYUrttGXgrwJT07BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjcwSi8Eu90MrJSOjYDJk/ACZPo+AQpjBlzhOQ2gw0XEkulon/Ye0uhuRic4zrFGGzbbg1390N06OYxs/jKUw6MHWBHAAFmsBdGPQCN1s/MGlqNf7fOcC021wxfsQjoQK8zTKHvr2kwKRGrHIHkk5qKI0A3eXjR1+J7tecbIcVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CMccz/b3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LXkahol+; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CMccz/b3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LXkahol+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 575321D00131;
	Mon,  5 Jan 2026 08:00:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 05 Jan 2026 08:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767618055; x=1767704455; bh=KU23Ff5Ysg
	hoRWmhGXuCtvl247Dw4e5C5u6EJafZjPI=; b=CMccz/b3gJ70lMhyoHcXrtgN2J
	J5tDoPuYVqXUUUynYcnD1ACIT1ifl4QnwVF42Eo9y3+jCga+hnUgslGJRnN/syF/
	uLY966ZctjQJh3pBVQlZPX2xiY3EgfAFqdWqZP+LpwxtzHtwLfZf2aliCrIGCpWO
	4eNsM1R9T6oe32YKovnhdDNQGGF3igqgPHZSunWtZmhftSTbjnqh37QK7W005e0Y
	730DiRrlyOyU/f6S9R8yW2nakcXzj9pZMUP3ZfKyRNFqzB7x40Y0MfP7GXYtduXG
	wklbLY9yG8fShv4s0edbtz0d2bCVVcbttlEgiFSczwmeqXCdwcfUGG2ZmIEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767618055; x=1767704455; bh=KU23Ff5YsghoRWmhGXuCtvl247Dw4e5C5u6
	EJafZjPI=; b=LXkahol+GSLsgE3a4ZpIVm9sSI7YmeuquawbYWQTh4wgiIocgfl
	Dl9hZoYU1J3d9kBWv5PumCaYful1pVXawZH+tG3lg6FKfuCSnc3clHPDQIUji+Mi
	zctnLYRy4u+O2LjJjXUxXoeoHvFKBVN1CUPBAwqFYr6BPRYCLmQYHCpiQ+v3UaZW
	yyN1LsfrYwVZbuqb38B2pFDS2gH0W+BgEhWNMQ34sWgvbvnPREsxymsvgUIq3jAZ
	TQ61F5RRKzDcAZhylMR19Zz6owGT6jd4FWLt6WsoRI+s83i/ejn2GmppTNKc/KFR
	cHwxjPPDEqzemZTHbMfQANYwFb2wPzikRgw==
X-ME-Sender: <xms:B7ZbaTpsHYBB-O4tZCy8Q0CAXYNWPcZHZ3ZiqvcFTIFbcuqHy-79KQ>
    <xme:B7ZbaUgXaCgWAosazqrR-JToYehm_SInKcnn-2uvHFdaUoz_98xiCXDJbRLFwdi9f
    Q2_z_BQiOZnN3P2sz8tEHXkn4XAi9_CHDZsiQE7VaO07dezqCyfAsw>
X-ME-Received: <xmr:B7ZbaYgsr0Ib848SzjcBbwVdTGtx3S3HT_wo7vet1sZY1FTiemASW-5fF69xWD1z8jejxF86zxKe6akf0r7nwD7uoT63wH30KeGAa72V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hmrghtshdrughougguuddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghmfihilhhl
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:B7ZbaShQmUktJwteDETv2jd2_7Z--FsVbM4j9iJUI6xoQjA_u7ho0Q>
    <xmx:B7ZbaQLOQN5McnpALHq7n4Tk7uBX9PH_jLoKJJJVZzHAfrqnDTpPNg>
    <xmx:B7ZbaZHcgYTSgzzDIEEA267_jdhFpqLPvQvQhDuWaasro5yiLfm1FQ>
    <xmx:B7ZbacR3WoGBiaiKunaGv8mOxf3KSsG-psMPA5BUtQzQDHhJeVZeTQ>
    <xmx:B7ZbaUV9imkHqUVbMDRCEWcrxmG2Wzx3oWgOQYvfHPZ1DTN_w4DnBruU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 08:00:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8177397 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 13:00:52 +0000 (UTC)
Date: Mon, 5 Jan 2026 14:00:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Matthew Dodd <mats.dodd12@gmail.com>
Cc: git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] upload-pack: send shallow-info before wanted-refs in
 protocol v2
Message-ID: <aVu1_FOWqwuVPH9i@pks.im>
References: <20251224003504.52660-1-mats.dodd12@gmail.com>
 <20251224003504.52660-2-mats.dodd12@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224003504.52660-2-mats.dodd12@gmail.com>

On Wed, Dec 24, 2025 at 01:35:03AM +0100, Matthew Dodd wrote:
> From: Mats-Dodd <mats.dodd12@gmail.com>
> 
> The protocol v2 specification (Documentation/gitprotocol-v2.adoc) defines
> the ordering of optional sections in the fetch response as:
> 
>     [acknowledgments delim-pkt] [shallow-info delim-pkt]
>     [wanted-refs delim-pkt] [packfile-uris delim-pkt]
>     packfile flush-pkt
> 
> However, since the ref-in-want feature was introduced in 516e2b76bdc
> (upload-pack: implement ref-in-want, 2018-06-27), the server sends
> wanted-refs before shallow-info. This violates the specification and
> breaks the client (fetch-pack.c), which expects shallow-info first.
> 
> When a client performs a shallow clone/fetch against a server with
> uploadpack.allowRefInWant=true, the client receives sections in the
> wrong order and fails with:
> 
>     fatal: expected 'packfile', received 'shallow-info'
> 
> Fix by swapping the order of send_shallow_info() and

Nit: is there a word missing here? E.g. "Fix this by..."

> diff --git a/upload-pack.c b/upload-pack.c
> index 1e87ae9559..029ca93e69 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1830,8 +1830,8 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
>  				state = UPLOAD_DONE;
>  			break;
>  		case UPLOAD_SEND_PACK:
> -			send_wanted_ref_info(&data);
>  			send_shallow_info(&data);
> +			send_wanted_ref_info(&data);

Indeed. The accompanying code in "fetch-pack.c" expects information the
other way round:

	if (process_section_header(&reader, "shallow-info", 1))
		receive_shallow_info(args, &reader, shallows, si);

	if (process_section_header(&reader, "wanted-refs", 1))
		receive_wanted_refs(&reader, sought, nr_sought);

The bug seems to exist since the inception of this feature. 516e2b76bd
(upload-pack: implement ref-in-want, 2018-06-27) implements the server
side in the current-broken way, and 733020517a (fetch-pack: implement
ref-in-want, 2018-06-27) implements the client side in the correct way.
So this combination has always been broken, and the fix looks obviously
correct to me indeed.

One nit though: I don't really think it's necessary to split up this
series into two patches. The new test can simply be added to this commit
here.

Thanks!

Patrick
