Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384FD302759
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753563; cv=none; b=W51YjoKjekfyGviEXQM192HmHJgQG97alWilSJPteHl0Zdv7AfPmCuwaaIEfhIcWt3M4xrONR7SMovGxvijIPkXT2XiNN4oKo4DGKRMz3AY+WnICHa+euyMpxWh6JF76zAjm1UuPIZpvnbPJhV8K8ZOLiwv00V+TQW0AwjVURkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753563; c=relaxed/simple;
	bh=+VnfzC5nJ2n+AtiQvZgY/lJEEmrhDNuVc8uNHFNQCYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NNHRlHKvzC40oyt1XTRLmWjG7RfYzdl4h5Kw5qEUnHO0a9DgsDW0osnIMmAV0aS00tzse34OP96t7GQs+dLHjxEIZ9HVSDzVZN12lLjLH8P4grptZH/3xSReGVMohJMw8m1Csgl49oI7t8N270nEPT9o6UCiYLb9kJ7wry8gEgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iZLECvoL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VW/EVy15; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZLECvoL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VW/EVy15"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F0CF7A0157;
	Fri, 21 Nov 2025 14:32:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 21 Nov 2025 14:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763753560; x=1763839960; bh=v5sxqfTAV0
	Jbm2dxh4j9EDDDdkRRoglSUvVSYMjTK5s=; b=iZLECvoL7KZoM6fn+1lPagmygt
	HC4NcVj8At2HkIwoNru3FYKNMKhZi3kUzTPNZx62TcPeOZw/4P9IbetDMSXuxQH2
	z3jwSTTK2TssscF5lRpiHL6Nh6fuAAbMmAStZmFnJRCbTyp8Ut/OomdDmb7puJcR
	ijKkr/OwTr6w1JTAxJJioQFV324c6eWOFqi/6ijJJbfC7JQ57slEoDf6EtaN4hEi
	ABFGaZUMZcEf2LHX9cTRTJlfu/tqcc+lk1lAtKkml0corKFUJrsXNp7vsiENDrb0
	VyrSFCuDbndl0Qj9PSzTxaexYMjWhtfDTTSwUgMj+3UfFLKspdoCGSYy4eWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763753560; x=1763839960; bh=v5sxqfTAV0Jbm2dxh4j9EDDDdkRRoglSUvV
	SYMjTK5s=; b=VW/EVy15t+R8YTifQw8FSOiQ4PTsqHIzx0xkrzkmwaDPwMhc7W/
	FIwOYOkRwluebFBl/Jwu+o++wgxSnCBz90Ul5CFMFXrFwo6362pXIul2riD6cWtU
	DAgzTw4wfhIL/5l+jrKdC/Lwgz973bk+Y9H2Bx2xEISNxF8A1Ex+9gieiRhTam0i
	5dLNDdaX+uhP/BKf0soFD44oOv3RowdQHHxnEx0KFky7O7VuQQxlx7PVwOlAjOkP
	znQjTUx7z7Uoaer8OU4hTHR3VUvss+uPedzRtuKIDeOkt/UTjL7By0dprwE2YRQZ
	NDGZ/oF21PobvVeXjzPZr27NbxOjo6CRH/A==
X-ME-Sender: <xms:V74gaeNGYYT1YhnXicuY5WKDCu5keWB3BxHEDu1P207HC4x7rS1bkg>
    <xme:V74gaT0HjBGxsGTPLaohyL5AXnG5Np9mfAhmC5baZUfzgieyaOGpn_kI6x4RJZM8p
    cTj2ar4Avl6Bxkk_G0iuxwy6df_trxmaMACmANQUzaGOQgssFmx>
X-ME-Received: <xmr:V74gadl1bnxjzYqveCZJezKr3UpgXR4M2Zz9Q7x43z-a9P_j9QZcljTFKYX36qQUI80pmWNbYWzQMnG3D1IEgSE3QjQmgiHgEJbq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepudffiefhvdefveefhfeigeetgfejgffhudethfehudeifeevgfeiudekhfej
    hfdvnecuffhomhgrihhnpehprggtkhgvugdrihhsnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:V74gaaVNlpCDYmuFUdn85S93aGW0eeC40zCtE-UzKex3Ut-pYQ_n_g>
    <xmx:V74gaTsK83gd0dNtFGKGfEwfCqg_KHsc3bTwsc1GAbtpEHcaQsnkgw>
    <xmx:V74gada2DHdtkbQ4Fn2m8AwrUITRmOaA88yP3gAn3mJ6RV3kUfIHWg>
    <xmx:V74gaSVlL5QAopayg_U-UOHJGETYVxyuoty_H9-wuv0_0O36ntFWOA>
    <xmx:WL4gaXFDg-3FjpY5uOwO8okGyaKpWtsc3kwB2OOEaoBOULKxvrmfwvsz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 14:32:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 12/19] streaming: rely on object sources to create
 object stream
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-12-ca8534963150@pks.im>
	(Patrick Steinhardt's message of "Fri, 21 Nov 2025 08:40:57 +0100")
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
	<20251121-b4-pks-odb-read-stream-v2-12-ca8534963150@pks.im>
Date: Fri, 21 Nov 2025 11:32:38 -0800
Message-ID: <xmqqldjz41wp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When creating an object stream we first look up the object info and, if
> it's present, we call into the respective backend that contains the
> object to create a new stream for it.
>
> This has the consequence that, for loose object source, we basically
> iterate through the object sources twice: we first discover that the
> file exists as a loose object in the first place by iterating through
> all sources. And, once we have discovered it, we again walk through all
> sources to try and map the object. The same issue will eventually also
> surface once the packfile store becomes per-object-source.
>
> Furthermore, it feels rather pointless to first look up the object only
> to then try and read it.
>
> Refactor the logic to be centered around sources instead. Instead of
> first reading the object, we immediately ask the source to create the
> object stream for us. If the object exists we get stream, otherwise
> we'll try the next source.
>
> Like this we only have to iterate through sources once. But even more
> importantly, this change also helps us to make the whole logic
> pluggable. The object read stream subsystem does not need to be aware of
> the different source backends anymore, but eventually it'll only have to
> call the source's callback function.

Very nicely done.

> Note that at the current point in time we aren't fully there yet:
>
>   - The packfile store still sits on the object database level and is
>     thus agnostic of the sources.
>
>   - We still have to call into both the packfile store and the loose
>     object source.
>
> But both of these issues will soon be addressed.

;-)

> @@ -463,30 +461,15 @@ static int istream_source(struct odb_read_stream **out,
>  			  struct repository *r,
>  			  const struct object_id *oid)
>  {
> -	unsigned long size;
> -	int status;
> -	struct object_info oi = OBJECT_INFO_INIT;
> -
> -	oi.sizep = &size;
> -	status = odb_read_object_info_extended(r->objects, oid, &oi, 0);
> -	if (status < 0)
> -		return status;
> +	struct odb_source *source;
>  
> -	switch (oi.whence) {
> -	case OI_LOOSE:
> -		if (open_istream_loose(out, r, oid) < 0)
> -			break;
> -		return 0;
> -	case OI_PACKED:
> -		if (oi.u.packed.is_delta ||
> -		    repo_settings_get_big_file_threshold(the_repository) >= size ||
> -		    open_istream_pack_non_delta(out, r, oid, oi.u.packed.pack,
> -						oi.u.packed.offset) < 0)
> -			break;
> +	if (!open_istream_pack_non_delta(out, r->objects, oid))
>  		return 0;
> -	default:
> -		break;
> -	}
> +
> +	odb_prepare_alternates(r->objects);
> +	for (source = r->objects->sources; source; source = source->next)
> +		if (!open_istream_loose(out, source, oid))
> +			return 0;

Hmph.

Earlier we let odb_read_object_info_extended() decide which one of
the duplicated objects (e.g., perhaps a loose object is still there
after packing), and then used the one it picked.  I think the
odb_read_object_info_extended() encodes a particular order with with
solid reasons like "do in-core cached one first", "favor objects in
pack over loose ones".

Now we instead let the first one with the object in the linked list
of sources, which may be different, unless the linked list is
created with the same "why one source needs to be given precedence
over the others" reasoning.

I do not know if/how it matters, this somewhat changes the
semantics, no?
