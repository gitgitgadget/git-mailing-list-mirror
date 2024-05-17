Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF082BCFD
	for <git@vger.kernel.org>; Fri, 17 May 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945430; cv=none; b=AQt9XJQ9zTda0j6F0samnyr7zqIaKqP1kG34WUfu7+0o3Uc3ruf62NZ817JbHm0s7SDnJymrREIZcml5prdKI7zSXKsRCSIbIMJ3qCG3tZlSLUxQkrJVcLLqpHamWJbkQUemiEm8MO311ADQl7dZs0pUcj9A58kAnYcfjsKxWjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945430; c=relaxed/simple;
	bh=xZoXkcdCg3ZTNXBD/TOq6ilEDsTbBWZsqJAe6yYhoo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPTHo4uu0rUb9paZxO+DQ3sePYT3P7Uyz/2MgVf8wTg6cLf+k47O27BPDD5bzJjJwbiAvX2O441lkeNUSyO35KVGi4QiNxHI/1CfBfknlXQTtJDlT2dU7PB2NyCJZhI8kYbDsA9MkEBJE11jbBFX2ArjsAp2BGu0E5gKDl0rci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mITTEVDm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zs2qlx8K; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mITTEVDm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zs2qlx8K"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id E929E1C00169;
	Fri, 17 May 2024 07:30:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 17 May 2024 07:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715945426; x=1716031826; bh=pVxIrbSHoZ
	cJNYXPrFy/LaSW+mN++PWubd8U99CGCGA=; b=mITTEVDmTGYv6kBIG5wC5yEuRP
	Y0OZAuqQ6zkxxBoK7oL/hJ8SmHnIcTHWZHe0iK1B9rzGtRp6xQ7qEVzilWhP0DDZ
	mg+10uJFSePVQasCc4eQeCPCZ0fus+QiOP8CzfGgKUj0B9Ip3nnXzq2DzRvASsAJ
	fDlxtzfO66bnMHQlhuNQEw4KQKMckJA8CnK7wJFUJ6vBILf+t620mdD2FCJYaAMs
	3lKwjzd91Gac6iC3q2ghCe/WrgM/mr3YPH5jwfkzRnuMcnCxaquRXxiIKnJgCTjV
	hn6HOYQ3ZobEyybLD5yxnWbuSELNixwVC8uTnvZj+N9WtUq6mYsz0hFTPmPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715945426; x=1716031826; bh=pVxIrbSHoZcJNYXPrFy/LaSW+mN+
	+PWubd8U99CGCGA=; b=Zs2qlx8KlTcxE+X5h9xY4vedDn0npO9l0NuhjgjvEMI5
	UbGRD3zn/QdYJwMweyuhKZsFugUvlukzTF6dXQonS26hAksgyjcnY4Vc9hdbwWcQ
	QcqUx/OWQaUwToH8xMbf3cUPGkZVAOquSaABMc/teRe2s6p/ie8Y92DfrCNhcEP9
	G2wVHJDu4GqgfuGvTSBfZUoQ6tQ140n28pL3II7Y5uIcnudaOaofEzg7/X94n4Ic
	oPmkaM0uRIxbELyLOtMbfu3vi51OFymJ5ZIsqn8t84LAxRuFwSB2FDzNjwq8PdCN
	GGoWUMZvYTPZUWzt4iEBcEZg2CMqcrp0SQCtmzDGmQ==
X-ME-Sender: <xms:0j9HZtiXwT4yQ6W6jPT1YhP4RywRjPvwJKNhhLAc34k8DiIK1dlVuw>
    <xme:0j9HZiDT7zn9uoO-Y6kfTYnv2YBuYlB2GjvhC1IynTScXVPDy8D5EQ7KvbjjtNHa1
    CCn0unITCqlf9aKXA>
X-ME-Received: <xmr:0j9HZtH8q3vWQmt2EYz7UTNUXwieKY0zkkNp43vvQMz6d74IAHdkZxaq_iouYkCxWosSQGUTAT3oIU_vqARJKVZ3LWDkyD5eTm4XzGZyEbRPZ5ZaJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0j9HZiTX7cD4GpZiwxfhXKadbrvbOagAcBIk2FXgTnsqA3yVOnOnbw>
    <xmx:0j9HZqy2Ap43_Dm84TbTPAIj1vHyONAvl5AUbYRzdXkw4EGPJO459w>
    <xmx:0j9HZo7rvMZ-zgUAWs5CFCfby1567U0TzuKU25yCjt-0qcB23k_OnQ>
    <xmx:0j9HZvxwlxdHAIPSY99-Qkx80eLVdXOgyJ3QetasHfECxS_NFM15LQ>
    <xmx:0j9HZkujD0e5WkwyHgH4bNlwerG1_RV7uxZmvWrTODPBhQEwYJah33Qo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 07:30:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2b6bc1d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 11:29:56 +0000 (UTC)
Date: Fri, 17 May 2024 13:30:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
Message-ID: <Zkc_zJGjwg0fZkRG@tanuki>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162544.GC1708042@coredump.intra.peff.net>
 <Zj3F9EVpSmQtyy0R@tanuki>
 <20240510201348.GE1954863@coredump.intra.peff.net>
 <Zj8blb0QqC2zdOAC@framework>
 <ZkX9w6etjDVAh-ln@tanuki>
 <20240517081132.GA1517321@coredump.intra.peff.net>
 <ZkcUcPhrTrbSbZO8@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qz9YEkXVWE4XpEJw"
Content-Disposition: inline
In-Reply-To: <ZkcUcPhrTrbSbZO8@tanuki>


--qz9YEkXVWE4XpEJw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 10:25:20AM +0200, Patrick Steinhardt wrote:
> On Fri, May 17, 2024 at 04:11:32AM -0400, Jeff King wrote:
> > On Thu, May 16, 2024 at 02:36:19PM +0200, Patrick Steinhardt wrote:
> [snip]
> > One can guess that scalar is in waitpid() waiting for git-fetch. But
> > what's fetch waiting on? The other side of upload-pack is dead.
> > According to lsof, it does have a unix socket open to fsmonitor. So
> > maybe it's trying to read there?
>=20
> That was also my guess. I tried whether disabling fsmonitor via
> `core.fsmonitor=3Dfalse` helps, but that did not seem to be the case.
> Either because it didn't have the desired effect, or because the root
> cause is not fsmonitor. No idea which of both it is.

The root cause actually is the fsmonitor. I was using your tmate hack to
SSH into one of the failed jobs, and there had been 7 instances of the
fsmonitor lurking. After killing all of them the job got unstuck and ran
to completion.

The reason why setting `core.fsmonitor=3Dfalse` is ineffective is because
in "scalar.c" we always configure `core.fsmonitor=3Dtrue` in the repo
config and thus override the setting. I was checking whether it would
make sense to defer enabling the fsmonitor until after the fetch and
checkout have concluded. But funny enough, the below patch caused the
pipeline to now hang deterministically.

Puzzled.

Patrick

diff --git a/scalar.c b/scalar.c
index 7234049a1b..67f85c7adc 100644
--- a/scalar.c
+++ b/scalar.c
@@ -178,13 +178,6 @@ static int set_recommended_config(int reconfigure)
                     config[i].key, config[i].value);
    }
=20
-	if (have_fsmonitor_support()) {
-		struct scalar_config fsmonitor =3D { "core.fsmonitor", "true" };
-		if (set_scalar_config(&fsmonitor, reconfigure))
-			return error(_("could not configure %s=3D%s"),
-				     fsmonitor.key, fsmonitor.value);
-	}
-
    /*
     * The `log.excludeDecoration` setting is special because it allows
     * for multiple values.
@@ -539,6 +532,13 @@ static int cmd_clone(int argc, const char **argv)
    if (res)
        goto cleanup;
=20
+	if (have_fsmonitor_support()) {
+		struct scalar_config fsmonitor =3D { "core.fsmonitor", "true" };
+		if (set_scalar_config(&fsmonitor, 0))
+			return error(_("could not configure %s=3D%s"),
+				     fsmonitor.key, fsmonitor.value);
+	}
+
    res =3D register_dir();
=20
 cleanup:

--qz9YEkXVWE4XpEJw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHP8wACgkQVbJhu7ck
PpTJNg//fH9dqoLCKLigdvMSPGyHnYJOYOPpJgwzzRfZMpe7k2UlYL34bL9Tk1u0
3c6Z0wZ8hzB7jrM/v4Xxszwy6ucQVdafKGLaWEi3gQ71DFs6VrVg0Uc15+gOL9ka
zQ1tShjqBGKEpSNj6rzMh89s6tZ5TjbC73OZjklcsaFgAunHpJsyZNNDzZujQvDQ
lhywbUmi6lipfv+f4LK29XPGOxtKqXJWKWv5ZgOIhUPaTIFHTGp7kKLsujS2llnr
GwDd/0EvpTeMZGJnDS4YCuEBqcaihp9wgXTWcTSMDJsQMaz5T8Ol/TD0gfkb+f+V
PXlP60I+YaF5KfrFXHlcuPdirMfJDkUgmYDX1epNWQTbM1eTvMbdLUygQYAns62o
82C/kRM7bK4+4NHH1iQg+O5XCRGf0KgfSdsmTjD1IUioRKL3icQgLe8+JLnJSr7A
q9c5ZViJtXip4u8V5aSytiGc2sAvdH+F+rxpy+hqIXxi3oqNcVao6DzIqKSGaYeq
c35JKlHSIGGUS7tudQQXxjulsjv15ralmw0t6ZU2nPbLluu7P2sw6a0Gg1I8hzYc
yvZalIpauBQlHM50k6ML+FhvYLkYeaCahfHMCLMC++RRk5xs0BjjOaCHLQw4uj0b
eRZodY0zfutyiyH73zasqnob4rHimcZhhZEh3jcKib2CKKHhuM0=
=GOco
-----END PGP SIGNATURE-----

--qz9YEkXVWE4XpEJw--
