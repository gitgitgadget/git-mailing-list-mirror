Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ABB158DDF
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862714; cv=none; b=nv+3EtKt+vISS8Kq4tVCA1dpatKGYftmhDzog0D3TC8yWRNEauz45IMW/0kjelxBpf0Kt8PMON80yyU3KkVO8X0FywTOvOkL5rsW4S6O99Rht2t7uwNFc3IYhEdTSh6z2UDy+sXEHkmudE93KxXwYxcpgo3h1nhw5QHXm/RVPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862714; c=relaxed/simple;
	bh=4OrWFz0LpbBdOxxAdYLilp+vl6e5QKTytEq/G7wt/0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAtXiD/FcZOYBDfv5HDlA89n3t4pCT4rqR+L5j8DdP/bvmuwUKynoDsYeZy2CGjwkxMvoPNdDOxrWHzNyEaK1gmdtLxlNP1ji1sWYd4bYluLvMd8jGacqPar/NlStC4TgFMstFpQZ8KWP6p2g5Ca0dMCT4iaxYxfsUhmh4X5AD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n8F4BwqW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B1EoCQ14; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n8F4BwqW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B1EoCQ14"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DDA381151B72;
	Mon,  5 Aug 2024 08:58:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 08:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722862711; x=1722949111; bh=ga0IYV2n78
	Fw8K8Rr9R7JHeCQRPs0sRZcqyjKxzpUQc=; b=n8F4BwqWhFH6td4dGPgrHkp8dh
	118ZoGQEcVZ0xATg0Y4SP2xjXGJ1gIMch1P8bw9YdfEphrzTo5QbDGtdm9zYW0/w
	fuQenPqGqhxsao7stA2kqtZNvOcn1JVa3Gr66XFc5Ai9LhQKG8dKBSR3tdWpzlcs
	pmUL151ZiY4KQf0HCu2WJR8S5ODY36bQT+Y6dzbecJMoo5WvJfNGHL/6G8L5Xsrm
	mSfKLogIsL5ydYPMNMxo4Z2hPyQKtxw3ADbY0rjB+CZoPYZXlJipyH9LRMFfjjmE
	OmsPZRsXQxGgLN06GuXrsZCAg8NcWqp3ntoNLfniBkqw+D1HHpstz/AOP70w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722862711; x=1722949111; bh=ga0IYV2n78Fw8K8Rr9R7JHeCQRPs
	0sRZcqyjKxzpUQc=; b=B1EoCQ14MPYmSSSL1cHA5KnPZX9TLy9Z+c6WpggMf0U4
	EFG6f7yQTcFIjQqc9d4dhxtxRBEvOcJm5bfNtfh8ikIcy5N3obxbIQHmDN9oC6g0
	G/w4T5LbTqKNqQfvDrxqphyssnttlI/tw5NjWaY7n3cMYTcmX8NcT9CXlV4KsMEo
	QRILaGo/ije9+0NsbJDzKh02js6C/WvN9bptWsghDERNrQOAqw4gj4ro6+JP3cbi
	gYUjZa3ZOxScIIvB4HQVn0pg9P24pInXFrhqf/N/TjsU0HOHCWRLoTjuBxGK6dmc
	DKkTIglPIsifIcJp+MLSLEQdDnR/iaA0Q94+fXKFuw==
X-ME-Sender: <xms:d8ywZl08NJ04V23uZE0JJFgriEWp5hN1p_o2o61vAMm8oO2Ef6oY6Q>
    <xme:d8ywZsFdK3Fr3gSjrJy3n9I7rGovYZexS9J9J4lRlXLM9v5w6uLgQcuavG0GObxYZ
    oOt0zS7JuAF_-YwJw>
X-ME-Received: <xmr:d8ywZl6p_ujVgjNH75wtOiTfuwHXWSwLmQ5BIX-Ic9WUntpLTecBUdNEb9Vc8HPUesjo3XieNUav8wvMALsZo71jJBW9P9kqU4Pdgc2EvNFILv-SVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:d8ywZi39I-znqQ2vM3Z5SIslMCtLhvzUnuOuK8XEpa5qCAbGGxYDEA>
    <xmx:d8ywZoH-iIiSQFr1cWyRuy-VcWhrP0U43i4_prjxs9rz94sb1yL2ng>
    <xmx:d8ywZj_fzjTarIC8upBuBDE1GkNEi4-BJCqpfyVCFOTdTVQUTv9szg>
    <xmx:d8ywZlk5WTsxh23EwEjc_Gt8eT0_H6f2t0tFyRV4a1a5fQdENtkaLg>
    <xmx:d8ywZt5yTTiM6hKjOPGXvjbCiGMyTlUY_yKkj7eNkH7mplEwn1Nj3yP9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:58:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 254155a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:58:29 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:58:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 09/11] builtin/fsck: add `git-refs verify`
 child process
Message-ID: <ZrDMdEJR6DV5HyLD@tanuki>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumdJz3-0mqh6Rc@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/V+TGKgqvkAwD0rc"
Content-Disposition: inline
In-Reply-To: <ZqumdJz3-0mqh6Rc@ArchLinux>


--/V+TGKgqvkAwD0rc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 11:15:00PM +0800, shejialuo wrote:
> Introduce a new function "fsck_refs" that initializes and runs a child
> process to execute the "git-refs verify" command.

It's `git refs verify`, not `git-refs verify` both in the commit body
and subject.

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  builtin/fsck.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 766bbd014d..b6ac878270 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -899,6 +899,21 @@ static int check_pack_rev_indexes(struct repository =
*r, int show_progress)
>  	return res;
>  }
> =20
> +static void fsck_refs(void)
> +{
> +	struct child_process refs_verify =3D CHILD_PROCESS_INIT;
> +	child_process_init(&refs_verify);
> +	refs_verify.git_cmd =3D 1;
> +	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
> +	if (verbose)
> +		strvec_push(&refs_verify.args, "--verbose");
> +	if (check_strict)
> +		strvec_push(&refs_verify.args, "--strict");
> +
> +	if (run_command(&refs_verify))
> +		errors_found |=3D ERROR_REFS;
> +}

Okay. I think that it's sensible to execute this as part of git-fsck(1).
But do we want to provide an option to disable this new check, as well?

It does feel a bit like opening a can of worms, though. None of the
other checks have trivial ways to disable them, and git-fsck(1) is
gaining more and more checks. So if we can disable ref checks, we may
also want to have options to disable checks for objects, connectivity,
reverse indices, indices, commit graphs and whatnot. In other words, in
my opinion we need to think a bit bigger and design a proper UI around
this.

But I don't think that should happen as part of this commit series, as
it is already big enough. So either we just accept this patch as-is. Or
we evict it from this series and handle it in the future together with
all the other taks that one may potentially want to disable.

I'd rather pick option two.

Patrick

--/V+TGKgqvkAwD0rc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzHMACgkQVbJhu7ck
PpTXMw//Xa51mbJotaCVCC7u2AdnG4o2PSKiiKep5oP9kpR/rzCSlf6urdMttbSa
NxzSlmzGPZYg4cCl4s+fwDgjnVNOgAmM15yVaTLO2Kijuj8nS7D7ALMWhPHuKm20
/iYllBohu5Pj9RlHcJXbVWrfvbem7xCcliViYAQSzutX1O0sK18aW8DLYUxKa3ju
ZGTF9BeUsl3lENpuQMR7w/66izj3PTWnIsMkHTxECbiqjzQWcRyxcguvvArwpRBG
1Ju14f99utOb3ig5MbOgi4QnSZeULNnm3DXcRQFUm4kSCWDipoI07EQ5f6PGuVUV
+EnVNgfc5KYiQ8ZZ0RrRPRKEPNr+bXcKJkWmcMUl12+/VNcteaqCWu8FfiEvEJGL
HiWDzG49Vyh2Pa5ZqAbbxOzm3R3yez/erqgo7GEt2xAqAuYSuWWMq/IUEAftuva5
dNrm9ggM6Gy834KUl8bNvTn3ntqoeLpwQ18R466Pe6DqFKVVdfOKPpRiqHriOUiO
ZlUZvGYPbx3N+b0VWJbNuvtanw2YLIv7jAOxmMzF56bDTTVdtv/n1O9v3iKdb1Zb
HlFejk2oCHy4AIyFkh80DCpgjO5dC8sgiC/vI+ylakHNhc7EFuZmts7vgDl3iQju
cdVfpoGvJrwXJ0mCylHdRvAG86g2H3lb5XuO6sEif+pn0SC1Yjs=
=q6HC
-----END PGP SIGNATURE-----

--/V+TGKgqvkAwD0rc--
