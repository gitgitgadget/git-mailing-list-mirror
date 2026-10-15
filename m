Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A33DC4AB
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086626; cv=none; b=GwVMcjXzxb3GhV/E3dIiU5sOtnccieujV3tIhA1hQe6nEtTOEFg7K8ysEOM8rtjmPW3NOKteUmIfmXKqXqNN5esEfK/ELUWQfSBW3s1EMUwvH+oPeLQq6sHeAMXp+eop9OFZASKBVXY3hpNYDcycIUVZ8YIVH281gRn76zJIKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086626; c=relaxed/simple;
	bh=zxMWzWLEKnvxkx8qNc+7dSbZMmndeUo1LyUbIz49GDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sbahLuWY7MXHq6f27txVoOKTzrMV5squEkDa0klETaAcZopbVYMYlOj4Lkso/YYniQ3vKA1aJWhBnQp6S12FZDeSLFPzg2E2Hb17f3QRCHcgGDwPbn39gkslMLAmtp3Dn/sbGo9QKlt/Il+XDqrM0A5q7hwaSs28qQPN+QCjArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aquiL/p1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nnuu4brB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aquiL/p1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nnuu4brB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BD5D71D00124
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:50:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 13:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792086615; x=1792173015; bh=sLUz31nYLV
	0jg8oeMOc41/kE5XVVclcd5snNDunq7k4=; b=aquiL/p1Q7mxPkbbOqAb4PrgS8
	kqH81msDNkYBlTtnXSx+Vy2KPOn7+XMI5Kh6mFWuEegOIqJ13fCFoFlfVAeozSc/
	tNnELkLk/+aCtGuY02ttMLb+SHRE2b4Fnff5OMrOZArZL+ctW79UwZLh8jywXHn1
	rHGifrcpY8vD+eln/UOzXTS2gZgao9Ly7FhdGgfWN4J93vpemd3ep1IYs+3AoVKC
	s8TessiPjgyGkwBdEc3sXDsA00+AWw1XBVuoG8SilRKpIHHduo1S+zOzJVLcAkAB
	VQSpK7xftB9SuqcwLWgn9F9/6YX8j/D6ggrkQ8+PR62Ptrsv4doOwjYB9w1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792086615; x=1792173015; bh=sLUz31nYLV0jg8oeMOc41/kE5XVVclcd5sn
	NDunq7k4=; b=Nnuu4brBKnSV50t/yTCNNtz038vmrXKm6r+ecc9j6vhyvUA3v2s
	rqAcZfSxVzro4eaENslvPsHnfBwgRp+xl7zWhYFs5dv/Q3wMasrZT5pApddI4o7D
	PGYmhMeL0VB9f+zTMKxXqSE9FkqVFt4PIAhPqzKX/BBHP6fJwoxVaT5pYk6hn4pO
	uYQLiDv3tUsdeTtU67jsXsEhln5khxu1yLgD8KZTPWqjndnJBS8zo2NEitNfFAu7
	+Yh+G2pJMjNCdwQJM2jKtmhGlRJko/IT6QUppiT2u7nNuB3PeZ6gjYe/y/l31vMP
	+aMCf+8NH/Q5cyiWGn72OcD8CYr4vWzHBmw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792086615; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZUAFR8nujQdlEvNIP+A8eeTgvze0sVATaT6W2hNQYpo9jf2
	6+kkecu/XDowxIua5EvD4sBQtChOBMfUz55vaQ+HaRG8eMDDHoUrVNuNiKgcLuoc
	IKv716wYhCXpy2rGKrJOuupNXatw8WR3yaElC1tyi2U2cD+U5jDZ5SY96Tw3b8of
	OXRKM+tf49VSNeZfbGwzFNHSnrwiBvII7W72BmOQzRVojBPBm/OwY2MkwhoZwkuy
	VkxFlfLz7bOzbIp3i61Y3q0giOrxiOu7wfkUlsfMnyWK2AlDeau6Q17RY0TBBLVL
	i1wUjvm34zlkL5nHhqYx65U8pj/5iSn8i7jwIDw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tswGTjebhNWKKnv9AMoGA4MjCa0p6RpCHp2knuy6YoU=:zxMWzWLEKnvxkx8qNc+7dSbZMmndeUo1LyUbIz49GDg=;
X-ME-Sender: <xms:VxLRatCh64EvsmPDU3hsouSpYbfNWkdcH0a-t88rFWmlOmLrzPzpJg>
    <xme:VxLRatzJQo_poSjqnp6UG5sZEgO1m-9aHLZ3LamHaZ9qK4-l-eS9s0tmhEWzv8XpP
    2D_axebumvOVEPete2Smjum2pXKb0yGN3C96dmNSEeNPfXvMsI7Zp8>
X-ME-Received: <xmr:VxLRaq1238rMwn5b_98ZkOnD6i5_KPOuTECOR9x8D4bduieZOykih5RcsFZKg49ff65nb8O4_vfigKrIs7DTQl2U3Fn3iNvtDlWk>
X-ME-Proxy-Cause: dmFkZTGCGIZ0BUEj/e8NvoWpAPkAUMrBBQCjM0eZlfPQggHKdPPD72N9FZ3ZH9AQgR0FFu
    +e8BkidJEI9YkC/9by3lt08ygXN640S4NJUhY6A09YvZD/x0BY2r/RckTY2cGLMtN+NvqG
    ySHQRt4ks0u+r11YQoEAD7IUM2lY8e0IK3jtaA+PFY5uqy5ZUDRRZd68wgEFso3EeKWK8v
    Y769z/dp9EsRQywzAX2RKpU8Svtx+DB9GLCeLDGbeGWCWE9r97zdZvxRhxKAD25F+fkmbP
    /dFxqXMeX7A7UO/JdcaDvBAzeoI3VO2m6Q8ArVA4jhwyrMGsU5gJih7LZb6ko6BH6P1BY5
    90sa87Kg+fT0dTZTrhrUyKJ0Dgel6QIT6dmXzolgDP4AafRPolZSE2lLHVs34HlWVhkrtc
    Ed1gp4ddipOY+TSNBLvj9supY48N8nrMZUO16HyL+8jcfxqp6V3A0xbIMafE6dPhrcy/lK
    jnWb6cgpz9gjsFuCH5M8MlfTyYtkrPir2hTytnlkQL+PmFoM2RZAPu23vvt+lzMoMdUF99
    Yj8G7t6/ShzZwAHzeFDNjqBcwtjuaHcrEQ/s2jXhQ5s0A3H/B3dk1DOoqaF56sUjQw4zE0
    b5Rohwz4d6auePTKbEw9LQcdXjAtmKmNEqQHChKuoKxS0TinBeaztBXeAXuw
X-ME-Proxy: <xmx:VxLRatxj8CGW3OzYdiOnNcFrGdDDxEf5etnzIxG59ubKyGaLoMXBWg>
    <xmx:VxLRahEBl4s4EE_9eB6MF80L1BQ58_rybnbKwpnxdlY9W-enXQTgIQ>
    <xmx:VxLRagYaOiZ8cFmNy07JIoSKle-8xD7Z37PmZVQaDUA1cR2zPjhWjQ>
    <xmx:VxLRajDUgB9dncCxd-IcxKlRFV4xfbllK-BfgsXKooOuqwYmJMzk2g>
    <xmx:VxLRaslRodw-Q0UxncKmOGM_V250k2EYV5b5JyyVNtjG-I2faSWdPWQJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:50:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] credential-store: add lockTimeout config option
In-Reply-To: <20261014232739.23021-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Thu, 15 Oct 2026 00:27:39 +0100")
References: <20261014155529.84134-1-okhuomonajayi54@gmail.com>
	<20261014232739.23021-1-okhuomonajayi54@gmail.com>
Date: Thu, 15 Oct 2026 10:50:13 -0700
Message-ID: <xmqqcxtaonu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> index bc1453c6b2..9fef54d218 100644
> --- a/builtin/credential-store.c
> +++ b/builtin/credential-store.c
> @@ -67,7 +67,9 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
>  {
>  	int timeout_ms = 1000;
>  
> -	repo_config_get_int(the_repository, "credentialstore.locktimeoutms", &timeout_ms);
> +	/* lockTimeoutMS is a deprecated synonym of lockTimeout. */
> +	if (repo_config_get_int(the_repository, "credentialstore.locktimeout", &timeout_ms))
> +		repo_config_get_int(the_repository, "credentialstore.locktimeoutms", &timeout_ms);
>  	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms) < 0)
>  		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);

Around this point the file is already full of overly long lines, but
the patch is making it even worse.

> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index c1cd60edd0..408f26bb10 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -210,4 +210,60 @@ test_expect_success 'get: store file can contain empty/bogus lines' '
>  	EOF
>  '
>  
> +# Holding creds.lock makes the next store fail. The error reports the
> +# timeout that was actually used, so "in 0 ms" means that name won.
> +test_expect_success 'credentialStore.lockTimeoutMS=0 gives up immediately' '
> +	test_when_finished "rm -f creds creds.lock" &&
> +	>"creds.lock" &&
> +	test_must_fail git -c credentialStore.lockTimeoutMS=0 \
> +		credential-store --file=creds store 2>err <<-\EOF &&
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	EOF
> +	test_grep "unable to get credential storage lock in 0 ms" err
> +'
> +
> +test_expect_success 'credentialStore.lockTimeout=0 gives up immediately' '
> +	test_when_finished "rm -f creds creds.lock" &&
> +	>"creds.lock" &&
> +	test_must_fail git -c credentialStore.lockTimeout=0 \
> +		credential-store --file=creds store 2>err <<-\EOF &&
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	EOF
> +	test_grep "unable to get credential storage lock in 0 ms" err
> +'

As it is necessary to keep the above two in sync forever, it may
make sense to do this instead:

	for v lockTimeout lockTimeoutMS
	do
		test_expect_success "credentialStore.$v=0 gives up immediately" '
			...
			test_must_fail git -c credentialStore.$v=0 \
			credential-store --file=creds store 2>err <<-\EOF &&
			...
			test_grep "unable to get ..." err
		'
	done

It is a common mistake to use double-quote in an attempt to have $v
expanded before it is passed to text_expect_success function, but
the variable $v is dereferenced correctly inside the body of the
test that is quoted with single-quote as it is eval'ed, so the way
the above is written is right.

> +test_expect_success 'credentialStore.lockTimeout wins when both are set' '
> +	test_when_finished "rm -f creds creds.lock" &&
> +	>"creds.lock" &&
> +	test_must_fail git \
> +		-c credentialStore.lockTimeout=0 \
> +		-c credentialStore.lockTimeoutMS=500 \
> +		credential-store --file=creds store 2>err <<-\EOF &&
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	EOF
> +	test_grep "unable to get credential storage lock in 0 ms" err
> +'

This is understandable.  The presense of locktimeout=0 hides
whatever locktimeoutms is set to, so it should fail the same way as
the earlier two tests.  Wait, nobody unlocks creds.lock, so what
should happen if the line that sets locktimeout=0 is removed?

Ahh, the key to this test is that we make sure "in 0 ms" part of the
error message does not say "in 500 ms" to ensure which of the two
variables are being used.  It is not like the credential-store command
would fail with 0ms timeout but succees with 500ms timeout.

> +test_expect_success 'credentialStore.lockTimeout allows a store' '
> +	test_when_finished "rm -f creds" &&
> +	git -c credentialStore.lockTimeout=1000 \
> +		credential-store --file=creds store <<-\EOF &&
> +	protocol=https
> +	host=example.com
> +	username=store-user
> +	password=store-pass
> +	EOF
> +	echo "https://store-user:store-pass@example.com" >expect &&
> +	test_cmp expect creds
> +'

This one I I am not sure what it is trying to test, though.  Would
the test start failing as the machine is loaded more and 1000 ms
becomes insufficient?  No.  The thing is not locked, nobody takes a
lock competing with our test, so with any value of the timeout we
should succeed, no?  Or would it fail if the timeout is set to 0ms?

Assuming that there is a reason to run this test, should it also be
testing locktimeoutms to ensure both variables behave the same way
when set independently, similarly to the two tests I rewrote into a
for loop?

Thanks.
