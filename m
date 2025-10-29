Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4A037A3C7
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766524; cv=none; b=Ijf/kyk3yB7iq/XbPRowhR6nD6f9/Xv8XDUlYOR5K1atuUUF69tIT1nMGZFN93gIzR8q5WzLf5UxqFIBSSheSHbSonK6VOdlruKDSXyu2iyRu4imLVGe7zJOS+nfrhCz8yMyObTsZoFOivgQ6jV3t9B1DJVAEZ3ghVzMKy+AAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766524; c=relaxed/simple;
	bh=CVTwV1Oqf85dBU5Tv2CC7YS3+2WcqzJtxDzLcIbzPVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SV6udDM3hvKp6diC4qJYZdeSnmBojmp+bcVNmZDSNkix6hDrdI1v20XBW2LEFlGjlaTzOUdF/fAbuJFsy+sRrPMwY5mEcByFTQqXpXeg3txVcggeoxAq/PafJksAyrOjyttJtOFnGpLbV5Hr55lT962eihJzoFnWLse5CKf88Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mRKbendb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lu5NV7lZ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mRKbendb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lu5NV7lZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4AC87A0177;
	Wed, 29 Oct 2025 15:35:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 29 Oct 2025 15:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761766519; x=1761852919; bh=Iajin1MCX4
	4q4E6X0q50ywaxnJ4S+H1wmvA8CEH8UMU=; b=mRKbendbAs4xs+iNHwFLkk8cYx
	1hkMDDKMLt3VwokrlzcBKz3LzWqUtw9jlZGy6USctWUmBEScIQGf0mDOwJUJA/rx
	6XR4QtnQFbQ2fj23Q8okQT6CI65xbJJ15jVEl+tz5W28zGrRAbJWiqRBe0HdiDn4
	t/7fH/o3fxbM4B1J5Cxea4hvLc34D9OOXqQiQiehudwmTAmFcUaogdZuhUSReXAm
	lgFWfawuoSZ2GJuaIVhjC7oz+Efsq+tl3oczoB1FPcl61Fz29R5VvbYcbN/qEF44
	7WQNXykUOPFkrWUPnaM24JEHzFgKRZQYH7cP7kdwV9MCOTHZeviJEig4132g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761766519; x=1761852919; bh=Iajin1MCX44q4E6X0q50ywaxnJ4S+H1wmvA
	8CEH8UMU=; b=Lu5NV7lZiDNBAztJb64IyXqYADLbvNPzGIz0xa3eYAUudByH3/G
	wWOZsaMd2ZyZsBRSA655UiYk9Hu54KodDLuCjKPq0AInLqiU9A5T8Ssaht0OIxby
	CldT2GcFndfbXNfqXoNTTku1AYHpthMZLAqkONg9McAE4wjYTQ4l+gLEiQ91UPue
	TZWkVgBizH7Kz/nYJ1KVHlrP7pM34unhjS44zZcFnOUMHk0elpQGmfB2rjmePGNj
	BPeOVNbNt2vhGZ9sjgDfHGkrKsGOo1isrJW7iiaz5KgVFE375LSNwOEx+DQpAabS
	t4ScLRzG++PtT8Dy+YZXBxCeTJNF1JFfoAA==
X-ME-Sender: <xms:d2wCaSCZoV3f5pMNel1FKpjyBWtsCQQ886FfaFKy-vollgHr3dsR4w>
    <xme:d2wCaTbZDRL31sc4pswHZLZHWE9wYvn9pbrCMaSpz9yuDlyzWp9TpSdfXw9Yxq0yH
    6qWh1YwAJQDXMyHnBArTEAjgWpsbjWBg8z7FSBSq-JVOpqzx_MTpg>
X-ME-Received: <xmr:d2wCad6S5tXnyzQV0d1KImXkgByma4JG8e7RIQ3oOsUwgo9qbyXGQZ0mqJKhpuy_p9ZUcihs18iVh2an8qXL0Sh19iSfoNL1DchG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    gvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepthhmiiesphho
    sghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:d2wCacYmaanmIAw9OL9tCWgAHg-Y73tsD758dx_Rw8IV9iemjdRP9A>
    <xmx:d2wCaUgjOUK_xCCaJybAZpz7ASsK03Mf831dXAt3eQBmgRQTIX--8Q>
    <xmx:d2wCaV8PY4ImEFxIQ8XiXNxunbUPZR_Juw1-rhc5tADC8t33R48I-Q>
    <xmx:d2wCaXotymdKM4XmkxF0J4RXJOZ9Pfw7Fnz8F_Et0CuIrqD5yIqJgw>
    <xmx:d2wCacKbr2RcNITwBuFMZjaWiONiSC6Tuh7dXmSyJwJaC82jwf6m3pfy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 15:35:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,  Todd Zullinger
 <tmz@pobox.com>,  git@vger.kernel.org
Subject: Re: [PATCH] test-tool: fix leak in delete-gpgsig command
In-Reply-To: <20251029191031.GA1257596@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 29 Oct 2025 15:10:31 -0400")
References: <xmqqh5vibpqg.fsf@gitster.g>
	<20251029191031.GA1257596@coredump.intra.peff.net>
Date: Wed, 29 Oct 2025 12:35:17 -0700
Message-ID: <xmqqikfx8psa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Oct 28, 2025 at 03:55:51PM -0700, Junio C Hamano wrote:
>
>> * tz/test-prepare-gnupghome (2024-07-03) 2 commits
>>  - t/lib-gpg: call prepare_gnupghome() in GPG2 prereq
>>  - t/lib-gpg: add prepare_gnupghome() to create GNUPGHOME dir
>> 
>>  Tests did not set up GNUPGHOME correctly, which is fixed but some
>>  flaky tests are exposed in t1016, which needs to be addressed
>>  before this topic can move forward.
>> 
>>  Will merge to 'next'.
>>  cf. <ZoV8b2RvYxLOotSJ@teonanacatl.net>
>>  cf. <xmqqbjlump3m.fsf@gitster.g>
>>  cf. <87frb310d2.fsf_-_@email.froward.int.ebiederm.org>
>>  source: <20240703153738.916469-1-tmz@pobox.com>
>
> I noticed jch failing CI. I think we want this on top:

Thanks.  I was just looking at these failures and thanks for beating
me to it.

> -- >8 --
> Subject: [PATCH] test-tool: fix leak in delete-gpgsig command
>
> We read the input into a strbuf, so we must free it. Without this, t1016
> complains in SANITIZE=leak mode.
>
> The bug was introduced in 7673ecd2dc (t1016-compatObjectFormat: add
> tests to verify the conversion between objects, 2023-10-01). But nobody
> seems to have noticed, probably because CI did not run these tests until
> the fix in 6cd8369ef3 (t/lib-gpg: call prepare_gnupghome() in GPG2
> prereq, 2024-07-03).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/helper/test-delete-gpgsig.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/t/helper/test-delete-gpgsig.c b/t/helper/test-delete-gpgsig.c
> index e36831af03..658c7a37f7 100644
> --- a/t/helper/test-delete-gpgsig.c
> +++ b/t/helper/test-delete-gpgsig.c
> @@ -23,8 +23,7 @@ int cmd__delete_gpgsig(int argc, const char **argv)
>  	if (!strcmp(pattern, "trailer")) {
>  		size_t payload_size = parse_signed_buffer(buf.buf, buf.len);
>  		fwrite(buf.buf, 1, payload_size, stdout);
> -		fflush(stdout);
> -		return 0;
> +		goto out;
>  	}
>  
>  	bufptr = buf.buf;
> @@ -56,7 +55,9 @@ int cmd__delete_gpgsig(int argc, const char **argv)
>  		fwrite(bufptr, 1, (eol - bufptr) + 1, stdout);
>  		bufptr = eol + 1;
>  	}
> -	fflush(stdout);
>  
> +out:
> +	fflush(stdout);
> +	strbuf_release(&buf);
>  	return 0;
>  }
