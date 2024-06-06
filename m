Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958D15279C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666752; cv=none; b=HruuIVxjQtf/XsvUJqaltB4Aq+ekyvAYa90C1iX0UOLZ4QyrzbCtdFFl6bhP6EfhJEWwOe9A5VNh2ArSs5WL0i0tAv5oc4pmte/LcLmiosIpih7Jm/LcUS5WmvwOe+HENksnPcVlwvFB8Tjk73D1jI22s+pdlIuOjHh/5Lelsjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666752; c=relaxed/simple;
	bh=hDneVtIDX9kHfdwQjpNoLZQ0/bTcXk5m0cNnf/1gCqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6kliaLL2U5zLVrVBubTIwqj/vlQUeJfSFNtMvgUjC58CRB7dEcZ5BIfWdtJvVZWbb3/JFDkfRLiDRyd0yilyfkYil1rUiiH3bI7AuXZWAXwfyYxz0sIqHL5a8gVVtyNZ4KaPOlorkjPeWeUBbA7/L4kW8QOrIsrpbmF2yH3eLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DWkrQNAK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WGd2xXHz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DWkrQNAK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WGd2xXHz"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id BB175138017F;
	Thu,  6 Jun 2024 05:39:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 05:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717666749; x=1717753149; bh=IPNyNNX9DU
	7M0iPHh4nVrFRw0anZkg5TY4DHaq89E8w=; b=DWkrQNAK1UmRORPi3CmznXIfST
	HRUHNMIY4F4Cz06cznoGeEfJDA1qNw9XHivR07ONrofUJy5oK7n0vZVoUlaQ9z4Q
	7NKUfXH31UOXUGhqWKOWuRoMOx8epc5/uEya5o/epYHTKHejORgsBl59WnAtpd4x
	J4qBaYC9BjF+QEwj7Yb6Cv5sLA7SUtxeZas9zS35fSWoyxgq/V9qY82grTPQgvuW
	IxtZzlqlbfONs6hu+iZ7IeInSW6bFw4JLzk+CN42d8t94TG3rJNqyN3mXun7BLZS
	dPWerss3MLVm+0S34tUYTJxl/UE0LrSs72en4MVD40DJwOi7WhR8nk4K65uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717666749; x=1717753149; bh=IPNyNNX9DU7M0iPHh4nVrFRw0anZ
	kg5TY4DHaq89E8w=; b=WGd2xXHzV/iHz/1zpp5uiQjWWSE5E2X+oqYwNCZ0760v
	XT17mo8Yw0ZkFkf9uf7KqYE72m7bQSyBkFTjWvnCj5YSww6a9a2o+6H4p4x8bu4Y
	X6ioOynH00oM74zFoEMUCKgxHRgqKoXf8uEVP1ncfRM/+Ccm46oC0Sb7TjEK9HP1
	elr3b/a0Lgi9Jpl7Vz22d1JW1sNFmG9QoD8C7Sjx35k9GCKzXlpUxITLgPZIYyCv
	ZPBCV4ZWbu1VriawhAe9bbjHcOAbdaALPzcldOnxjJTi2fRRw2hsPp5R+2Kq1QEB
	ZYHif/WuJRXiXgMTZWzN2Xsf8zEyvnEZCUBDXhyM5w==
X-ME-Sender: <xms:vYNhZv8-z1FDN0L_Jvi1dmHvmFvwQL12esdB2f56EZNB8fA1yS33iw>
    <xme:vYNhZrsI4YSQZQK_RFZanbcP1lCs1NHJdCjWJ8coH0riD0aQdkJPyoxLDKKqhc8Qj
    n4z3GJSY_dCGyzKVw>
X-ME-Received: <xmr:vYNhZtARbe9lxy4VRl1GjPUAW9qtfe5VoIm3f7-dCLwCgzRJq5jW-RqdfRZe9_QQ2Hl8juYKYsjip_Pd7BGfAFPm98uka40eJDs0YcDW6xEVfPPn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:vYNhZrfhFABPF9zwGecj7ZABKXy9xpuFEI1jQawj_YOBGH5hOAOQ-g>
    <xmx:vYNhZkNJps7vMiZpy1xRNrAZ-a8dn2Zt6K5nLZxjf-CtJOx3hj-GNg>
    <xmx:vYNhZtn_SYdpiUYshadLjdpyX344Jo-bJGj4glIt4uknSlE44YNn-w>
    <xmx:vYNhZut2CJM3ykXP3-VMgEmQ1vDWNI-x6CO8H3KAPDkvGCU-HBwOgw>
    <xmx:vYNhZtYbatuNkLE0huqV3N0-CpyI1Kn5LZhT3heFb9SFg2OL5a3Tlfat>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 05:39:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4c3a85e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 09:38:37 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:39:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ls-remote: introduce --branches and deprecate
 --heads
Message-ID: <ZmGDuThKIbexY-xa@tanuki>
References: <20240603200539.1473345-1-gitster@pobox.com>
 <20240604220145.3260714-1-gitster@pobox.com>
 <20240604220145.3260714-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XbEoTqe8sO10Xu+d"
Content-Disposition: inline
In-Reply-To: <20240604220145.3260714-3-gitster@pobox.com>


--XbEoTqe8sO10Xu+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 03:01:44PM -0700, Junio C Hamano wrote:
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 65fb22a8a2..69841ed49f 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -9,7 +9,7 @@
>  #include "wildmatch.h"
> =20
>  static const char * const ls_remote_usage[] =3D {
> -	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=3D<exec>]\=
n"
> +	N_("git ls-remote [--branches] [--tags] [--refs] [--upload-pack=3D<exec=
>]\n"
>  	   "              [-q | --quiet] [--exit-code] [--get-url] [--sort=3D<k=
ey>]\n"
>  	   "              [--symref] [<repository> [<patterns>...]]"),
>  	NULL
> @@ -68,7 +68,10 @@ int cmd_ls_remote(int argc, const char **argv, const c=
har *prefix)
>  			   N_("path of git-upload-pack on the remote host"),
>  			   PARSE_OPT_HIDDEN },
>  		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
> -		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_BRANCHES),
> +		OPT_BIT('b', "branches", &flags, N_("limit to branches"), REF_BRANCHES=
),
> +		OPT_BIT_F('h', "heads", &flags,
> +			  N_("deprecated synonym for --branches"), REF_BRANCHES,
> +			  PARSE_OPT_HIDDEN),
>  		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
>  		OPT_BOOL(0, "get-url", &get_url,
>  			 N_("take url.<base>.insteadOf into account")),
> diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
> index 5dbe107ce8..42e77eb5a9 100755
> --- a/t/t5512-ls-remote.sh
> +++ b/t/t5512-ls-remote.sh
> @@ -47,6 +47,7 @@ test_expect_success setup '
>  	git show-ref -d	>refs &&
>  	sed -e "s/ /	/" refs >>expected.all &&
> =20
> +	grep refs/heads/ expected.all >expected.branches &&
>  	git remote add self "$(pwd)/.git" &&
>  	git remote add self2 "."
>  '
> @@ -71,6 +72,27 @@ test_expect_success 'ls-remote self' '
>  	test_cmp expected.all actual
>  '
> =20
> +test_expect_success 'ls-remote --branches self' '
> +	git ls-remote --branches self >actual &&
> +	test_cmp expected.branches actual &&
> +	git ls-remote -b self >actual &&
> +	test_cmp expected.branches actual
> +'
> +
> +test_expect_success 'ls-remote -h is deprecated w/o warning' '
> +	git ls-remote -h self >actual 2>warning &&
> +	test_cmp expected.branches actual &&
> +	test_grep ! deprecated warning
> +'

It is a bit funny to grep for something that wasn't ever there. But I
don't mind it much as we may eventually want to introduce such a
deprecation warning if we ever decide to go through with the
deprecation.

Patrick

--XbEoTqe8sO10Xu+d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhg7gACgkQVbJhu7ck
PpR+HA//SfVBsMvJeVUAqFRw/9UexVoSbYCWstZ8/YLfZVxQ8H+45/dGb9nEsweQ
z9EEsCd2UwW1y+2ZwRmK/Kr5nBW5aWAnSR15T4G+booxHXfmYRt1vj7zrp/itVpI
11av3Cx7hpZy3aE+l55zAjxdw7kAjMtOEMu7W4o6Lr7++NEJ2JHsyR5tO3RgPI9F
J2yOufndx63butUm1TPTWT/w2rm3fI81w7MiOnl+MXycWsY/laQA1xPr1YD21RM3
KFUvgFZ9oNuOhK6jH4oOXL2mdkkZFvNJe3LZvYSpnJ7p+xZkbGouZi/i0PLLsHXO
IpRK2AKMPpKuZh0SWL7PNtk3prZRw4lpn8l9aNtpZXN7dXZTf5IEqJ0PJhIzu8io
Z+woQj5pBjow2D8oHU2dlPE+iyyMxjNhJ80EEsv8xCIbpGeMhMSj9wftMKB3MuVa
vBTVBt80kuPrynzhHfbktm7N5q/FMow4fv8M55Bz8eRTdpbaQP0eKbXUfJygS0qO
ZZ+of3fXd20orvzplCAjtFGl8U4QzV4iTOIls6lOHbbPxsOiGC6284lxxZKWRhrr
llxbjB5JBUwZrt29DKM9zGJ4V7uMZ7uLblBbTyeIGtYO+iXK8LRulJ8k0EQcSpKT
geNRkstE5T7nBH+AvbrAFYJF1KRDizjU0tecbYrI6VIsqe1UqpE=
=MsLG
-----END PGP SIGNATURE-----

--XbEoTqe8sO10Xu+d--
