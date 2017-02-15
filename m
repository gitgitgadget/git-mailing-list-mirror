Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 229F42013D
	for <e@80x24.org>; Wed, 15 Feb 2017 02:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdBOCGx (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 21:06:53 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53332 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751392AbdBOCGw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Feb 2017 21:06:52 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D535D280AD;
        Wed, 15 Feb 2017 02:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487124410;
        bh=ztMcUOLk4gJC822CkNjJRwx6vKwDVa+T+VZ9YwldqrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8OKJ7PA1/6e/53Vj74gK0LxC8fIu3ZbNZwBCHfWOS7+FmXPhgoCOgxMksMPB2T8W
         W2g2OCcflWMtI0bkSIIb0bFxZdSyuZEIocr2knJUTrgDoExv77eDgWFtY6Hiu8JLkB
         epBHDU+34VT/QcayD0pFzmEcVXHM4LkmEu7PvBuxsYdCUUnsAhBaGfMrzvJcd58RaG
         7r3RTiqw1pQGnjtQyY96/Y2/a9szfhL5LqEct/QF/OBH5KpGkrfxXgXOhDxvY7XVXp
         LY5zUIBWAAOWtMJq1PUkwr3GwsOGHBkfYpy/EagrHjoOK+Z+hvaj7RgaRngcXNVYzx
         Zl9uLIMaHRbcS8xUTXFiaIeDgZJNCv9zqHffv0iVp2XVYAShchKQ3Z66WPu9ChMlT8
         mKe4h800adbOlWqCdc92O1cUALjkIKE6Ni/OVOIGmFYc7wNmpTA9uUDmSUfh0XDqvc
         VddIJDwc9PELLfQD/1R0w5i+3fEGKss1Fg0aUJqW9FB4xFsuDqq
Date:   Wed, 15 Feb 2017 02:06:47 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH 09/14] update submodules: add submodule_go_from_to
Message-ID: <20170215020647.dn2drkep7o7qwqp7@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        bmwill@google.com, jrnieder@gmail.com, gitster@pobox.com
References: <20170215003423.20245-1-sbeller@google.com>
 <20170215003423.20245-10-sbeller@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bcjqx3gcwkiaf4jk"
Content-Disposition: inline
In-Reply-To: <20170215003423.20245-10-sbeller@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bcjqx3gcwkiaf4jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2017 at 04:34:18PM -0800, Stefan Beller wrote:
> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> +
> +	cp.git_cmd =3D 1;
> +	cp.no_stdin =3D 1;
> +	cp.dir =3D path;
> +
> +	argv_array_pushf(&cp.args, "--super-prefix=3D%s/", path);
> +	argv_array_pushl(&cp.args, "read-tree", NULL);
> +
> +	if (!dry_run)
> +		argv_array_push(&cp.args, "-u");
> +	else
> +		argv_array_push(&cp.args, "-n");

I might write this as

	if (dry_run)
		argv_array_push(&cp.args, "-n");
	else
		argv_array_push(&cp.args, "-u");

In other words, avoiding the negation when you have an else branch.  I
can also see an argument for keeping the condition identical to the
other branches, though.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--bcjqx3gcwkiaf4jk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlijt7YACgkQv1NdgR9S
9ou0MQ/8DxVfaMtTz3gM0BY8xQ6dxqGtxv+FKYzqn9ag50HhZx0/NA+ApA84r+x1
czEpi0oXzhw+SS48mB+j1AgJoFIFn3UIcVpSyHAtf0dsenSpdGVNVfv6N6EIgAKb
0SsxiXBp/KADARp3mnp0zyqLPfCTp3Vw9vJQvBNom8xQEvw9Kwpd95grhwg1BOMk
bU5HUP3kAl8GEsvuEuom1wVCAQHw1wdYQ2R8IsJcoq5zmyXM48GpYcX9N6eCeYQo
4/AbRUMRUmVI8swy/MNMiEMTH5oIJd1BjMckPts7Niul3gdpCt5u++O/HKhpomVu
usz4C9zfHRiqpxgayqI4+DxadsqDOAGnwTnv4vOWOjL2zdQo1ydtq0LG4E/HMjzs
YT3L0rBC7yEKIlt8P8voPBaaxHS6fawYkG4hTE5talBYNpJ58v7KYKXjEnAbW9ir
Wf4RFavW8I+DBjInSAsTuH8OLtZm0VQ5O/ROe9Vi3wv4cWiTw0/9dv4ezu8BKcVj
yxlanLzCtK5jDC8bFjlY5/zwPd3iTd0KmvMLUserYEzSWSEwMKqsRnwwmgIdk+Bj
XdCqtM7MdxlxHvsMH15BnwjZtQN5ZVQJgU8QtdwENsq5lCFPON381xa9x9YFSdfE
Z+mNIrIrpymhcn1pycNxhDgtmwJeuxYDlepneCyyEpPi88FEqTA=
=KrfZ
-----END PGP SIGNATURE-----

--bcjqx3gcwkiaf4jk--
