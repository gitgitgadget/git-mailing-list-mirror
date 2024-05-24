Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B683CD7
	for <git@vger.kernel.org>; Fri, 24 May 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716549260; cv=none; b=GL6BirkTPln8ELFXxTllWd0olIsrwg/3YynXTjPG83aIZtkhLTf+D8cbbjFktvJ9nGB/t4Yt3K7jGwEBB3BIZmLfcoj0GzHkx5sEn4Juj7Nbu+qISpsFDASgFiAqywGqV3tDsnIWFrrZOzErRMi4Fl3CMjjROHClxXGgY8cwbwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716549260; c=relaxed/simple;
	bh=C4g9mxHu4i3aeD3HYi32oNsXuawm5RjsyaElY96m9rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbMDDN3scao88Ge815n7OVp7jzhoCFdK+cOAE3aqmnm0mNg2f7+CUO7JkKLqJwF8blMIE/wYFtjLurXhGGQTz/4NwsHZUu0eR+jG1MLfieskgOfOU9toe1Jejn2XqAGnBuVELdb2AFKFUCSodT1NQBcv+b6tONnAHQQlMfUsrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EkX8wIN1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3UWMmRW; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EkX8wIN1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3UWMmRW"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 882271140192;
	Fri, 24 May 2024 07:14:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 24 May 2024 07:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716549257; x=1716635657; bh=dTwKp1ISyj
	IZrF10TT4o1paUjk0BR0Ayt7l/7s86KyE=; b=EkX8wIN11KCFoYrdloChh9qGCq
	1RD+7O1Kiua7fF8yIlLuMjYuy89DsDnIJUzTtR+ex7YmKTDJrcGwYo8XRkcrCvlx
	zCUNOG1knoBFkfcjOl+I1xReUwLrB3qZSWvz/yS/KclHXLBtMkmVzWoAGuAb2Shn
	Ex/V4eF+o2UY06+Rx/9+OHTY6aRc0NcVDLiSqY7mP71ettw2oE8DuLYXAEseEhlg
	IzSmOacY5e0OfbGgH2mb7YGMjEPqHaGQREMwwyp+hfeRRiCH5dQP3oCeasK4pgOB
	r76jO7KE5Xj2aoqjkc3TYY2eEnQPgKG/i2o5wRFlM83BIhZ3IN5xdMvf8Jjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716549257; x=1716635657; bh=dTwKp1ISyjIZrF10TT4o1paUjk0B
	R0Ayt7l/7s86KyE=; b=l3UWMmRWDhMN2atOQR/yQYZBTQ+TCsnyi4Zbex1+UDY1
	N8nAy1dqy4t7e6x9XgZAWyeIXh603H25tKjVWMvyP4Go7PkYFsan9pZuv1QjCb6G
	qusQIUDh+biTQv874iVcLw1MOAI9R7XQSyAraa3Hgpq1V5ksQ7QilFhtc/CpJlEz
	DBW+a342dPfjGDN/qDVrh/ztW5cQ3OIj+853LQiS7zPMNSwz7ezXXf5+kJWfnLzD
	M4Z60dRvZ9e89WJvCRbH+bEUp8GMCrtqDqNQ9BXXaSiMUfN8QeuEwZubme9IrS+8
	rypmQNP8p/XnIDXt/N31sYtk81C/yPfWh5owkTgmGw==
X-ME-Sender: <xms:iXZQZqB7Jz09NB_Q7uHUrx-cdyFBtUuOEwaC8Z-FbNS9IyWiILkwbw>
    <xme:iXZQZkh_V4JaZeEa7xnXcnUxHg1eGH9iK1KcB4zDg7E6BoRpPi56E5IqeIx8dD0fP
    WNsYXJQHM5FXb1lYQ>
X-ME-Received: <xmr:iXZQZtk5XNkQNGLvT9VPsD7Fc7FLiavScRmk9zwEtfUj6vkpCoeJLG95buOhdgi4n9DLv1ZWWpbM7ZmcIFddiEbPj4KQYEj4ZIogPjuSSdO3Vrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:iXZQZowDLS908IaS471X-oeqhJgwedXI1iGT94bCO4HI2BhoQxLNIA>
    <xmx:iXZQZvQOrnBVqMqwC9Zz-SldvS41AXlUc8PzGA1LeRv-OjPrMeb6LA>
    <xmx:iXZQZjYyYj06SzAC5RmaxaFbZ5__tZSQrmdNCpvhiMuQ4n3FT0Bh0g>
    <xmx:iXZQZoR2UexdGQUfKY1fFP0a56imm7jBrKdpF7QaOpQcWuysvl5W8g>
    <xmx:iXZQZqeGyBNELNK-ziiWX8HzrRbEXz1Ppe750ohTHkhaj7Af16PUu05o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 07:14:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 28f47b2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 11:14:10 +0000 (UTC)
Date: Fri, 24 May 2024 13:14:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] format-patch: move range/inter diff at the end of a
 single patch output
Message-ID: <ZlB2g5bTuBFz5m5_@tanuki>
References: <20240523225007.2871766-1-gitster@pobox.com>
 <20240523225007.2871766-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FcoIvs0zZ+V2XbQ3"
Content-Disposition: inline
In-Reply-To: <20240523225007.2871766-3-gitster@pobox.com>


--FcoIvs0zZ+V2XbQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 03:50:07PM -0700, Junio C Hamano wrote:
[snip]
> @@ -1176,6 +1172,9 @@ int log_tree_commit(struct rev_info *opt, struct co=
mmit *commit)
>  	opt->loginfo =3D NULL;
>  	maybe_flush_or_die(opt->diffopt.file, "stdout");
>  	opt->diffopt.no_free =3D no_free;
> +	if (shown)
> +		show_diff_of_diff(opt);

Shouldn't we write the range-diff before `maybe_flush_or_die()`?

>  	diff_free(&opt->diffopt);
>  	return shown;
>  }
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index ba85b582c5..c0c5eccb7c 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -2482,13 +2482,18 @@ test_expect_success 'interdiff: reroll-count with=
 a integer' '
>  '
> =20
>  test_expect_success 'interdiff: solo-patch' '
> -	cat >expect <<-\EOF &&
> -	  +fleep
> -
> -	EOF
>  	git format-patch --interdiff=3Dboop~2 -1 boop &&
> -	test_grep "^Interdiff:$" 0001-fleep.patch &&
> -	sed "1,/^  @@ /d; /^$/q" 0001-fleep.patch >actual &&
> +
> +	# remove up to the last "patch" output line,
> +	# and remove everything below the signature mark.
> +	sed -e "1,/^+fleep\$/d" -e "/^-- /,\$d" 0001-fleep.patch >actual &&
> +
> +	# fabricate Interdiff output.
> +	git diff boop~2 boop >inter &&
> +	{
> +		echo "Interdiff:" &&
> +		sed -e "s/^/  /" inter
> +	} >expect &&
>  	test_cmp expect actual
>  '

Do we also want to have a test that demonstrates the new behaviour for
range-diffs?

I also think that there's a bug here. The output from the above command
is:

    From 15bea9f4ecca544a87b671e6b9aba65a8c8d9667 Mon Sep 17 00:00:00 2001
    Message-ID: <15bea9f4ecca544a87b671e6b9aba65a8c8d9667.1716549087.git.co=
mmitter@example.com>
    From: A U Thor <author@example.com>
    Date: Thu, 7 Apr 2005 15:38:13 -0700
    Subject: [PATCH v2] fleep
    Header1: B E Cipient <rcipient@example.com>
    To: Someone <someone@out.there>
    Cc: C E Cipient <rcipient@example.com>

    ---
     blorp | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)

    diff --git a/blorp b/blorp
    index 2fa8fca..bb6e81c 100644
    --- a/blorp
    +++ b/blorp
    @@ -1 +1 @@
    -fnorp
    +fleep
    Interdiff against v1:
      diff --git a/blorp b/blorp
      new file mode 100644
      index 0000000..bb6e81c
      --- /dev/null
      +++ b/blorp
      @@ -0,0 +1 @@
      +fleep
    --
    2.45.1.248.g15a88ae3cc.dirty

The diff is before the separator for the signature, and there is no
clear delimiter between the actual diff and the interdiff. The reason
why I wanted to check this in the first place is that I didn't find
expectations of the test itself clear, so I wanted to double check what
the actual output looks like to confirm that it does the right thing.

Patrick

--FcoIvs0zZ+V2XbQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQdoIACgkQVbJhu7ck
PpS8GQ//ZfrfGm/bGayGqf4H/8ESW10BgRYV2FAbYAcpshnieEyT1CbNGm8krTFJ
kSF5UyRfsr9RTVGqtfXML2TghU9E3LSB91vCMsMtht75gGNSHpOJQIK/eE8cYAhx
2SpAmoSj9ZxQ5Cj46aBJWOyfN99Ol0sspYqBpR6z1ThigtEtdZqtliSUoZNbT4t0
dxdrDO9gy8YG5yvk+dfm6SfQ08hYKh8dO9pkGhpDAynOjBRRbWCqgjC1yiY/AZab
7bm3+AjI6nIYe1hVcPrzOdyQv106JKBai+1RsEFrFifBXHoGy7uO+3UwwuqOMRAk
CvmlW5mRy5o2kyU3Z5Gr2FqtK0kmY2kQP6tCnis3l2qXRw4cQd9vs46z9Gny43MX
voNtN/bW8tbJ85pPQqwcoM1moxYopeCqrvQx8M4Oe5eVvXUrqXM9o3l85Jcr218n
lCelHSXFbv99o26OWtGQaGx1Xw6f+afaI7+mMHBIx76kuHRJFwyZ6V68ZyGgAF5p
Sz4rtd1jwFKhsGFAzw+P4CKleUVep+cDUxaaz5f4RY/dXKsgHYk0Rw2fSMRgN5Yc
Yh2APdgRC3sw4wbgM3NXHK5vK5NXhDMlIKOjq5wazFYIw3JtP0XTkvgKYMdl6Hs2
rspMu+z86IXsHql8VbPK1v1nEzEpkKjFAiJy4q5QEGEOz0SlrF8=
=arHl
-----END PGP SIGNATURE-----

--FcoIvs0zZ+V2XbQ3--
