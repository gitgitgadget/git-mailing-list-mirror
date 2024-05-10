Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7516F822
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340853; cv=none; b=o9G5XkC/QTLk/CmLkGww0iWvLc75CIsTTVFVBvWkPCBHlJCAPuriPUZLIcWVYI1BrPdgCkkI96JBouv7VNsAOUgIjXP/76sc5c2eV26R/kixp7IT6v4HzdPerTanYsWb+lVIBxMBnw698fReSCVTx96HeeyuIiVA+btq1B2KlME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340853; c=relaxed/simple;
	bh=YHHaC6gCj0uM5LiQLb44fjgKjWYFYzcUwE6PGs9pJ6Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzncBgB4r7DydmiQqYJ7k/vasp7Pc9964vt0g43KN5N/VFCnFhJ74wtcK+5HgvD8lxjcqgZ4KUonSMpnXCGbrVBxdGEbSsWB1QVoow3UKQrKlDD8IKVBMJjKDkBoR0vNGmeVOD1aZTACLhLICWp4+BxJKgSDXGDRXHX6/wbVSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BKMy3Ngt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SC0qlhUI; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BKMy3Ngt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SC0qlhUI"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5D5811800101
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:34:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 May 2024 07:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340851; x=1715427251; bh=r5D/8FfaAj
	qjQ1uARrh4F3jyJRWJwXPfV7E3Ci7Yd6o=; b=BKMy3NgtQozzS5eid64D/lgzCS
	zEkH0mpw4cBMdO40QmzIC3FQDLzddbU60dTtSm9SGLUBdqwLdh3CZNaX+PS+DD6e
	72KngD0tS+PaDrFdviriE3GsCFGJeoRKdow+K5U4QHpJnltLqZ8AeJQMPk2H6jSS
	OJnjYQOSe145622iH/mbBnYJRKljWG1TUxMUr/QDG+Z6r89I4SdwRcBGtpkOlTl5
	IErqWR1EiEflZt5sYSYVWLOFFe7QWseKkDTE+Baa9WAZ2AyCJG32TVxhlFUb/VsG
	fh7+qxMkeUIc8O9P7rqpTj1OXFNrb6iVK/MK1jTw0MV2+Z+l1qxX7j0S7hJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340851; x=1715427251; bh=r5D/8FfaAjqjQ1uARrh4F3jyJRWJ
	wXPfV7E3Ci7Yd6o=; b=SC0qlhUIoc6qfqEorjXCb7AIr3+4EK24Sjdu4B5n0qhM
	ahFQH9pJov0HoGdJmLFmoxS7egMzGDcBt0iAIiBxiwFkPL+Y3wnRwI2M2vAkGnDn
	sSsVR4XTd1ikMIjeqIs3x71/ezr5NEqJnsNmQuQ4lfCIwA80OathyHJVx+W0EWx+
	sNoQlHmS95jDC9Z13fENR0//zR7w/6uIJ42txdOLU8FdrkR3qGTJKqdCaC0mH1d3
	bHRXIykMeMxTapvfqLWoNPzqm+yLMw6khzdP/3jOiACSU5Sr92bDkMkziwqhjtYh
	W3qJL6loPYSB5x8tpxuudafJo193/AtEoqakp8GjZQ==
X-ME-Sender: <xms:MgY-ZtbEVKJiyOi-mHRlJ_rnmQ6aGood4yW95ou2ISYsI_z5GnBwWw>
    <xme:MgY-ZkYvLpgDVMha_J6QXNGaWcxwcEMRy4jltJKPkLQhi5bkpXf6K7IgzrNtL52Sr
    ieO_j2tYkdxF_UY_w>
X-ME-Received: <xmr:MgY-Zv9cC4qyxsJCd9tbQVHTV-lLImuje51pJ8KUjfiAUFVrlVX3_N7nNHtiOglFGHvCRzMw3R7QE35-jlLDs8sWQRKm2yMjwcyvXAEzK5Rto7txBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:MgY-ZroeWx6wi6fg_BX1mkRZhthNiaiH5AEA4bf7HPWVRce2LEXvoA>
    <xmx:MgY-Zor1IqbevB2ckFi2DcFVIBnmMpFNokDmxR9q0x6pZob_yPZoKQ>
    <xmx:MgY-ZhQkm63HJWY4-em4K8QSdrdo1k4_VrE9XsEXnLjsAKpv5f8Ztg>
    <xmx:MgY-ZgrmhVoIjp6VWOidb9ikZu5zrUq8uKSLl-GiqvvQ1V08CrlIaA>
    <xmx:MgY-ZlCHDZTVZoN2MYanKgCNJ6SMcXCxW9pZX9MbdFb7mQioYVLq4uTM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:34:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id dffe9948 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:33:56 +0000 (UTC)
Date: Fri, 10 May 2024 13:34:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 09/21] builtin/config: move location options into local
 variables
Message-ID: <Zj4GLqRQCfOrmz6d@tanuki>
References: <cover.1715339393.git.ps@pks.im>
 <a96c122280ad025f94c1343cca85c67c7c617c8f.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4QFhtFcy6AKlqU1b"
Content-Disposition: inline
In-Reply-To: <a96c122280ad025f94c1343cca85c67c7c617c8f.1715339393.git.ps@pks.im>


--4QFhtFcy6AKlqU1b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2024 at 01:25:07PM +0200, Patrick Steinhardt wrote:
> @@ -638,34 +657,40 @@ static char *default_user_config(void)
[snip]
> -	if (use_global_config) {
> -		given_config_source.file = git_global_config();
> -		if (!given_config_source.file)
> +	if (opts->use_global_config) {
> +		opts->source.file = xstrdup_or_null(git_global_config());
> +		if (!opts->source.file)

This needs the following on top to plug a memory leak -- I didn't
realize that `git_global_config()` transfers ownership of the string to
the caller already.

diff --git a/builtin/config.c b/builtin/config.c
index 127bc097b2..30a49d07d7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -761,7 +761,7 @@ static void location_options_init(struct config_location_options *opts,
        }

        if (opts->use_global_config) {
-               opts->source.file = xstrdup_or_null(git_global_config());
+               opts->source.file = git_global_config();
                if (!opts->source.file)
                        /*
                         * It is unknown if HOME/.gitconfig exists, so

Will fix in v2.

Patrick

--4QFhtFcy6AKlqU1b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+Bi0ACgkQVbJhu7ck
PpTghRAAqYRZtfp+fqr4jf2JLKhd05aMSW7OqcKEd/GxdSkKl5JgMbB89hbEF+XO
uDQkb95X/ocA1BDYtwz//IHkr+rfkr/HDYQgKDSzU8X4mJ4CNUYsEJUNGBAe5Rdp
+1+n558HuRouxhUSjppslKBbTJeQ0zgildhGwyDaR7UnmWltojOKPgRGJmn7r0v4
3CnZg807PqCTsjaq40cHRAD/AJ/1Vja9j+i2ONIKvSkNbak1X2n/ZwnYLjxIrKJi
b8DhYkFD5rzjNtIf6gW5vv2802+sGnpWIIAJ2+2JlqGTEhREYopCV8X6M+9sT8WI
5JVz74GILQ5ZXyItTTb7nMAA1U8ASAeRv0yPZQ2F09U6KxCdV7Ono0ML9qk3y/Ez
bmnGgBYwEZdDdM/zBNyVr931Lm8CMqOOIXJ7h3To6vez7BkbqABYuOb2WEpK/eFk
3FZ6ByuW5eq5UiZNuGp3RHXhboSBUJPrlOnhcSSg8Y45rvjNKTMDjZkaOMQHVmXa
pND1Jw/pbCL4y/tEA6KI5DZ1pPxJC5wfwjPPZIpF90GXuOSVorEOGUP8fQ8tWb/p
VSWbA+M1rftyfO+J/jHYNopgAuY7GgCghiRe/r69JBAjuen0bcGwUv4i/Yt1XF/A
710fDpoIF9YV5ongiLk1v66NeQVxXFErwlpO9gBYsCsXfSo+D5c=
=0T/R
-----END PGP SIGNATURE-----

--4QFhtFcy6AKlqU1b--
