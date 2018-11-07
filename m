Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1181F453
	for <e@80x24.org>; Wed,  7 Nov 2018 13:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeKGWd0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 17:33:26 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:51241 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeKGWd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 17:33:26 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 17:33:24 EST
Received: from NSJAIL.pks.im (x5ce2d35f.dyn.telefonica.de [92.226.211.95])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id C47F3DE215;
        Wed,  7 Nov 2018 15:22:36 +0100 (CET)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL.pks.im (OpenSMTPD) with ESMTPSA id 1a10f2c9 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 7 Nov 2018 12:55:20 +0000 (UTC)
Date:   Wed, 7 Nov 2018 13:56:01 +0100
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Wildcard URL config matching
Message-ID: <20181107125601.GA20965@ncase.pks.im>
References: <20181105205652.GA890086@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20181105205652.GA890086@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Mon, Nov 05, 2018 at 08:56:52PM +0000, brian m. carlson wrote:
> In a272b9e70a ("urlmatch: allow globbing for the URL host part",
> 2017-01-31), we added support for wildcard matching for URLs when
> reading from .git/config.  Now it's possible to specify an option like
> http.http://*.example.com/.cookieFile and have it match for the URL
> http://foo.example.com.  However, since this option also allows
> wildcards at any level, the following also matches:
> http.http://*.*.*/.cookieFile.
>=20
> I'm wondering if it was intentional to allow this behavior or if we
> intended to allow only the leftmost label (or labels) to be a wildcard.
> The tests seem to test only the leftmost label, and that is the behavior
> that one has for TLS certificates, for example.  I don't really see a
> situation where one would want to match hostname labels in an arbitrary
> position, but perhaps I'm simply not being imaginative enough in
> thinking through the use cases.

The behavior is intentional. The above example of "http://*.*.*/"
obviously doesn't make a lot of sense, but e.g. the pattern
"http://*.*.example.com" should match all sub-sub domains of
"example.com" like for example "http://foo.bar.example.com". The
ability to use multiple globs is necessary as they aren't "true"
globs, but will only match the current component of the subdomain
separated by dots. So they behave similar to globs in the shell,
where they only match up to the next directory separator.

If we were to remove the ability to use globs for multiple
components, then one would have to again explicitly list patterns
for all possible combinations.

> Regardless of what we decide, I'll be sending a patch, either to add
> additional tests, or correct the code (or both).

I agree that there should've been additional tests to also verify
that multiple globs work as expected. So thanks for doing that!

> I ask because we're implementing this behavior for Git LFS, where we
> don't iterate over all configuration keys, instead looking up certain
> values in a hash.  We'll need to make some changes in order to have
> things work correctly if we want to implement the current Git behavior
> to prevent combinatorial explosion.

Regards
Patrick

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtmscHsieVjl9VyNUEXxntp6r8SwFAlvi4N8ACgkQEXxntp6r
8SwHXhAAliS5L2vTjiFFutNG5G5nf6Njz3IAn4hFL5AFa33lEoplBLMZcSXUFnmq
Afsm0NzrDuQZulRuHIzeZjiozMBcK087OmLPIrKxGtR1TfVM3wEZxxuf+bzv+i0V
+WjwFqTY8PuKO82Uf6hKXWbQfArMKY+o/dyz434YXyE2RTonl0wzlz2jvwZRlDqB
9mS1tBFtVkXN8e7m059yCep+WnvSC78JOaOzNcZtl0YS7KxI4ht8qwAuh8vWVlab
gKWbLotxAzBnn5eA3/cUfxO2K8BzMMw6tybJUHsa/i/jyAPcdWWG6eTMCPgCN8DQ
zjP9le6IdvQbQ+thhVuu6Ds/eiVJBdhErDfi+2crdG2IxeUvnKe94NsR+8kbZsmf
Vv/TdocBhBQEPvm/WfBZRldjBp5S5iM3kceSKWlH1Gr+HMNvLpGElHSRsGb58UZg
Mv2qHiM5vSA5tGnblEq+ce3vmh/pWS05l9N4sqYTgIIey/zU8D3Wc7VrX21NF9UY
1ZOS8G/r79WH1ZsnF9WhZ4L/qMErkLUZxwBG9et5tsBAhE8L3WsNDRjdS1vZODN/
UtZjgStVg9iARd14YZB7m5oqFi3hRP/H/FOY61RofJrbS4fzmhAOUnjIOO39Tz8W
O5E9B7QhMUK4jTDG2Gh+KOaZuvu83BcxoZbbn4ZX9DrDtwWszAY=
=fqBw
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
