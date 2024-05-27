Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A61754B
	for <git@vger.kernel.org>; Mon, 27 May 2024 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716792289; cv=none; b=GJONjzO21JkYQRWye08/xSMvmlMwajdHT2ACa4Xfxmv/7/xZ3PMZK36CWrT0So9DibCLyE25+2C64TvxM82naqagT2U+YeLNb8xqAsRtVWGxGrRlzJZ+k3WfYHp/CXJZ8HGmBfVlNRDMcLRg+KR5zUAEKHIbj+C523uvj+i7NxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716792289; c=relaxed/simple;
	bh=ecUevlAHrmmZkgsIOeHNdQBuBKBx3pFPUNxWMOl9eaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS6qZqZw2NH/SgU38F9LukZ+VGfrtuI7FHXUGBrfI+Lf1+byz8vdRLTAqiphIuhqGMaSfZXXoGpEqIIxBlZttB+9N2/uikZSPAk77ggnj7iiZ6L0U80CmufeF+VeT8VqICIWht9k1NSrX6LUoR/S8su+2/IH4HItt4Wn0tE8m24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NGHhxZQZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WhnR1xas; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NGHhxZQZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WhnR1xas"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id CC2F71C000C1;
	Mon, 27 May 2024 02:44:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 27 May 2024 02:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716792285; x=1716878685; bh=ANlhhsf5BK
	FDc4kb1Imlrqq3kl5OreUSPTABXOdVvqw=; b=NGHhxZQZ5UxfaeAITuF1YizluJ
	8qaszWli6WRH+RvrMRh5n0lssUg6XI57rUKvNLSKHRIFVntjz/pSzUQJkRmrVhSN
	6+QwercYjhJ5rVO5e69M3LMvDkl3LICiVGGUUVj/D7Qh+QSQNoxDchocW4PMHJZV
	H2l55LQOgV8QsZSR+oL6Sy+a7LAKFW3TLzCPCMQr3WzPY0cmOMYIc8E+cOKXZ87X
	UqSYqi8AGGCpRqlhXgCwS6jIANpOCCmIea42oR+tsfFET8kPnZfcWu1HG+L2Q1YP
	At7XxrS2/EiHel9wNq1UM2PTuogKpUFA7uwDtCUWP1ItKR/t1HjGKpP8R0Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716792285; x=1716878685; bh=ANlhhsf5BKFDc4kb1Imlrqq3kl5O
	reUSPTABXOdVvqw=; b=WhnR1xasz7BxtiTHn37CMQNfjkQOWNFb6Ho/tzUVn9dU
	kQr5T+a3ks+m/dllfGH+9hga6RqPHAL+pzNZ8RGTurUl7Tbh7BSUn+RT2omAw8zQ
	oFw9SHekN2WC4eRWISaIxxC0UlYSnDiy8HT9c1rR0mZrYXJBXdZ6U0VSwZczVQlj
	UDb1iuuLATOmxhzWczdaGoPv5q899RARWX2TW8cSx5cdckPDdG9slylQl+nU8daO
	LpAJPYMWn5uDuxYr9fSrcsrWj1SvHTVK4z0VeQAnPVvXrXtVbJ5uB8RfRwSDHTkg
	ykraLrOYMlq+/1Sw5edvpHGv1EcHvzbaW1hSGuNndA==
X-ME-Sender: <xms:3StUZrTJNhsKKBSdkywsFMF112DztKPjaSixCJl9u0__sYyBfgDj8Q>
    <xme:3StUZsy1cSGy5RsljpwZ2gbblo5mawD_g9zMJdtT15x0ifjg-9Q2YMcb7EZ1YN-B8
    y6Kyfhk4aoHFiBxbQ>
X-ME-Received: <xmr:3StUZg0IMN5dRliqM3zyHn7_itbUCFyR7irHklYXfJEyByopY-VkgYDXdx0iURZO5cEg0WknqNj1unsUYt2KkKcYgJEVZZPoxonvHnA55uqZ_angXOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejfedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfev
    leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:3StUZrCHjrhbMoL-rTKPMd9Y3c-7u75e0SCppN0WPbfOKTzy9ul78A>
    <xmx:3StUZkiqG5U6Xf07DF1NnLakkbpGkdVuKGn4PNQPCgovwvmZK04jzQ>
    <xmx:3StUZvrMCkOM02-Ywja4DYEsKdOEKVUUqBJea5x9itqWTxdgTI43ZQ>
    <xmx:3StUZvhz13SKs9JwQT70mdFFzghF5yoLjsFJtMbZINOucg3Mtje2Ng>
    <xmx:3StUZseJlgAQY4P_5vqGK2ZOm5JptrqpWVABmyH7pScuBwWoGb0NGuIe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 02:44:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 28cc342c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 06:44:32 +0000 (UTC)
Date: Mon, 27 May 2024 08:44:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/21] Various memory leak fixes
Message-ID: <ZlQr11P_C-KyO2DF@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
 <xmqqwmniiqv2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wYXCsIDV4OWK3V6Q"
Content-Disposition: inline
In-Reply-To: <xmqqwmniiqv2.fsf@gitster.g>


--wYXCsIDV4OWK3V6Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 07:10:09PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > this is the second version of my patch series that fixes various memory
> > leaks in Git. Changes compared to v1:
> >
> >   - t4153 and t7006 aren't marked as passing anymore. I thought they
> >     pass because most of these tests were skipped because of a missing
> >     TTY prerequisite both on my local machine, but also in our CI.
> >
> >   - Add another patch to install the Perl IO:Pty module on Alpine and
> >     Ubuntu. This fulfills the TTY prerequisite and thus surfaces the
> >     memory leaks in both of the above tests.
> >
> >   - Add another unit test for strvec that exercise replacing a string in
> >     the strvec with a copy of itself.
> >
> >   - A bunch of commit message improvements.
>=20
> Looking very good.  This seems to reveal existing leaks when merged
> to 'seen'; other topics that are not in 'master' may be introducing
> these leaks.  I'll see if a trial merge to 'next' is leak-free (in
> which case I'll merge it down to 'next') or there are other topics
> in 'next' that are leaking (in which case we'll play by ear---either
> mark the tests again as non-leak-free, or plug the leak if it seems
> trivial).
>=20
>  https://github.com/git/git/actions/runs/9231313414/job/25400998823
>=20
> says t1400-update-ref has many "stdin symref-update" things are
> failing.

Indeed. The following diff fixes the leak:

    diff --git a/builtin/update-ref.c b/builtin/update-ref.c
    index 7d2a419230..e54be9c429 100644
    --- a/builtin/update-ref.c
    +++ b/builtin/update-ref.c
    @@ -130,6 +130,8 @@ static char *parse_next_arg(const char **next)
    =20
        if (arg.len)
            return strbuf_detach(&arg, NULL);
    +
    +	strbuf_release(&arg);
        return NULL;
     }
    =20

Karthik is out of office this week, so you may want to add this as a
"SQUASH???" commit on top of his topic branch to make "seen" pass.

> Also
>=20
>  https://github.com/git/git/actions/runs/9231313414/job/25401102951
>=20
> shows that t1460-refs-migrate fails on Windows.

Hm, this one is curious. There are no leak logs at all, and the exit
code is 139. Might be SIGSEGV, indicating that something else is going
on here than a memory leak.

I'll investigate.

Patrick

--wYXCsIDV4OWK3V6Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUK9YACgkQVbJhu7ck
PpQTxg//QqXsRhcihL9n+JHvUw/Asf3dWBPy7a8xUnlOCB8smerWeVXIQySvkcxR
FTzAoMZlgLxUGACGQtxbe6V1v35eZbRWxKIptu5YHF8eyPUc/9R64tuaxkDywYmp
dn0cG3rlLMAZFWfPGZZNKedyB7Sz/FK+bzBIA7udfeGe7JzebnOheT9CyF9LSBCf
qrVW3q6tyREz5UOyF5ofEzOwPE7qRfefOmZpHQuwjxpTjYkMK0qxCYdf4vnQo4H2
HPGA9CniMgQNWdrJjcgfz4iQ4NudHT7Y9laX4MsuaB/BJnwC1jyQrgXJTx6RQ35Y
t32v9R/9l1lB/TcWPZCx0k6uIPT/0ENdF0bn+TRxxOcadwfzAkILMgl2Xm53t2Ki
EM+8AQDXb9H0IZB92UM/8O3KA+kNMu9ve/WjylaIJjMBZ+NMF8uIugijtXDJmytW
LnSTMJ3Du1pUfolMXNKXrqi8iags9I7YRdA/z33qWByfSaDF57omjMp61HeuM58p
Za4Btj+yaOTCDohtQ4I7lu/+b7qbGVhNEAlSho9OiU1hB+img2zZ7hNgG6sZiPCM
Z2egRMGqv9FVtnE+INnQFqdhqzSnA1gRQRq5jBXJeYHRHfEQi0amPmOBqSbMU61P
Ag2ua6BVjTrvgMvYgTYmvcGyeQR91f+xdEch7Ge+tKHeeRvN9cw=
=omgM
-----END PGP SIGNATURE-----

--wYXCsIDV4OWK3V6Q--
