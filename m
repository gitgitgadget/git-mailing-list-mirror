Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC7321445
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162596; cv=none; b=iH70KMI+y0qKxBYK2gaF+3xI3WeLCDfhICXkvPSW9KDLZApOOa1OnzVG8JKy4cVJqxxASawYHZk27mXwLhfBUB1Y3bGak+ktZS+LaF5AsZtNn9poW86Oq9ff8znkW9XYVL8kZODMIl0iQCMoDNShBlzZg4iAaGeHJLrTLmz2vCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162596; c=relaxed/simple;
	bh=rtIaKgL6sFO1mx2V0RwNhriQR8IJa6Y4d8wTHdzVAFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=niEAPGG94nBdO9WEwo45BU4Sh7BTqE718H3PFKNLl0xw9kytSsPh+XwGvzRQs57czhMMztF16secOD6YBacQl0UUV6mT1VDclHIjRFQVis3v5BGAhYCUx6sNickx/qEg2iaT+zde490lG62ljFA32AszHq5pAUjid+7DeO74Cug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DgsxmLRL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C/icPmi6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DgsxmLRL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C/icPmi6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 575E9EC0FC9;
	Tue, 10 Mar 2026 13:09:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 13:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773162593; x=1773248993; bh=n1Q8lYif39
	GxSxKAZhj61supeawQ1gtR9c+Ui8k0lhM=; b=DgsxmLRLqb6RiLbz40duCFhzqa
	CbC1+5HMTujdZEZX9A4UXK/lOp09Akvh6Vo6rYzEBM7gJ9qOU4WHcvxWSKbvc/hY
	C3cXMBXYmvDEad154/aCP2XPVdjhUc4dFW396JVf7l0QtKOPbUILsNCgcszIv+kR
	hl9FVGOCBdVOQ7jyG+m7xbzD+eD011jA8kqkINklFO9W1LiLmw9HOjLvGhV/rita
	IIrcWY8a7+5Hk/cNFKRigFu1jYeegCC0QFVWWFh5jmGsZAm/N/fGBfjSBnCtbzvq
	zYv15BjLnwqsCV+3o0mrzgFLvEHHITzhBE1LoOvwJZAHDTmez1AO6QPFUTSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773162593; x=1773248993; bh=n1Q8lYif39GxSxKAZhj61supeawQ1gtR9c+
	Ui8k0lhM=; b=C/icPmi6+fX1ya1g4sH9ZcKkDtcFb8gLVF3RGyTanMdDOZqXUsd
	RK9Ki9e/MeN78SwOgghIwBfIcrrKjyKIztQxnK5ZWOd/uBwM4mAcVQrnx2WDg4ot
	xPBqSfIlXu2XsVjJH34w/ur0nVeNpVcALaTtzVCy+dRpKIBtGxa4XbnUR97rqB8m
	fFzTPPi3zRseOwiy17l2OfFFkJ82G8ZJfg0+ggJsatbbA2d7fZt89kvmFvGFPZDJ
	HWpzpNlnokl+/vIO/h5x45tsbctskx3EMZCBWH5l9Wwr1579fQYHUYlSRogBauqA
	jvAutyDF1qTUF9VwXOQITm28dMV5JbPKzmw==
X-ME-Sender: <xms:YVCwaWk29PHCCWrCuQMuK31mJk0-R6xxeigmNOvwR2cJUZ5vVn21qw>
    <xme:YVCwaQGFd6O8uuPmD_46bweBQ-XJ7dSzgKzhSJMysqm_0b_bklDsnQpJ5912e8Ose
    but6qQiZbfiS66zbKzK-ZzLMTFEOj-dYWpFE54CM8hpWPVeKztE_2M>
X-ME-Received: <xmr:YVCwaW5jkmG-AbrLbMCVNxq0pxxuVIMHekTAcOZXVyJ3sr5vJhKGufHShyo23-8ErJFq2dTesLPrF-ZxaBGQlqcuTNASEIdMvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhsmhhilhgvhiesghhithhl
    rggsrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:YVCwaQmYwKzbZ7YK9FCK8t3-KQpmfagV6kUCrGLdI6tmjXbrto2BmA>
    <xmx:YVCwaTqmmdTIDi4-UA1n3wg8SGXjFSnt6pHh16W3d6DSNHXbgFs28Q>
    <xmx:YVCwaXtCiWx8yxGVUB2Hhxj7FCt1oA9PPJPrpeh69IkpRDb4EG69cA>
    <xmx:YVCwaQEsau-KIFHTexkqSstpAildqrrzU6aVEcexc_d6oZlFfstYnA>
    <xmx:YVCwaTa8WQIUEUwJW3ODpPJyVD1cOf4K8YkES7NwtPvKm2yKSBi6QGXS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 13:09:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Matt Smiley <msmiley@gitlab.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,
  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 03/10] upload-pack: prefer flushing data over sending
 keepalive
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-3-8bc97aa3e267@pks.im>
	(Patrick Steinhardt's message of "Tue, 10 Mar 2026 14:24:59 +0100")
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
	<20260310-pks-upload-pack-write-contention-v3-3-8bc97aa3e267@pks.im>
Date: Tue, 10 Mar 2026 10:09:51 -0700
Message-ID: <xmqq5x73wqzk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When using the sideband in git-upload-pack(1) we know to send out
> keepalive packets in case generating the pack takes too long. These
> keepalives take the form of a simple empty pktline.
>
> In the preceding commit we have adapted git-upload-pack(1) to buffer
> data more aggressively before sending it to the client. This creates an
> obvious optimization opportunity: when we hit the keepalive timeout
> while we still hold on to some buffered data, then it makes more sense
> to flush out the data instead of sending the empty keepalive packet.
>
> This is overall not going to be a significant win. Most keepalives will
> come before the pack data starts, and once pack-objects starts producing
> data, it tends to do so pretty consistently. And of course we can't send
> data before we see the PACK header, because the whole point is to buffer
> the early bit waiting for packfile URIs. But the optimization is easy
> enough to realize.
>
> Do so and flush out data instead of sending an empty pktline. While at
> it, drop the useless

Useless what?

> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  upload-pack.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index f6f380a601..7a165d226d 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -466,18 +466,27 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  		}
>  
>  		/*
> -		 * We hit the keepalive timeout without saying anything; send
> -		 * an empty message on the data sideband just to let the other
> -		 * side know we're still working on it, but don't have any data
> -		 * yet.
> +		 * We hit the keepalive timeout without saying anything. If we
> +		 * have pending data we flush it out to the caller now.
> +		 * Otherwise, we send an empty message on the data sideband
> +		 * just to let the other side know we're still working on it,
> +		 * but don't have any data yet.
>  		 *
>  		 * If we don't have a sideband channel, there's no room in the
>  		 * protocol to say anything, so those clients are just out of
>  		 * luck.
>  		 */
>  		if (!ret && pack_data->use_sideband) {
> -			static const char buf[] = "0005\1";
> -			write_or_die(1, buf, 5);
> +			if (output_state->packfile_started && output_state->used > 1) {
> +				send_client_data(1, output_state->buffer, output_state->used - 1,
> +						 pack_data->use_sideband);
> +				output_state->buffer[0] = output_state->buffer[output_state->used - 1];
> +				output_state->used = 1;
> +			} else {
> +				static const char buf[] = "0005\1";
> +				write_or_die(1, buf, 5);
> +			}
> +

OK.  The new part of the comment, "If we have pending data, flush
it", is what the new code is doing (i.e., flush all the bytes before
the final byte, and make the buffer hold only that final byte we
kept for ourselves).  Otherwise we give a keepalive packet (i.e., 0
byte thrown at the sideband #1) as before.

OK.

>  			last_sent_ms = now_ms;
>  		}
>  	}
