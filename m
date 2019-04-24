Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD421F453
	for <e@80x24.org>; Wed, 24 Apr 2019 22:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfDXWcr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 18:32:47 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35666 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbfDXWcr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Apr 2019 18:32:47 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4E81060FF7;
        Wed, 24 Apr 2019 22:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556145165;
        bh=ssm27xOI2Y4BBgehd9d2h+SLaaWn/wkRp7gJGOzijM4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Yt7CrwobWY5Gu1on3OKy4rEX1TT8irRPEF9wX0FXfa0EC3B4IxsediK8Uz4LWFTIr
         7jN2cAF6MHC1RCnu7KO0Tk83rRSkYROzVIW6A8EImtQEobHQ7WnUc4uG9QzV6FOfc1
         mj/Kbk4qtTa3OTd2jBOmI4J2N3pSWQNzDiVsHFTEtiSX/s1BjTh5FEDwIk2lRHhN8s
         dW5uYeejuet8sLqJ5CooOeD0JrAbFX06eTuQkX5mfg5XpDLboya332M/xYdgz8tJW3
         OEDEQnYqm/cg5iT37hqU/xDPawqE+QaBhN4mex7mNMXowPNGszQ50PYdijKX5b1BpI
         LgWf746fzi/yVjF+ErbVRuk9eqwACzXiPbmbD0wX8BId4s8PZWcW3CMW1eqlWNNsF1
         pUxNmaaAUmCH0hVq2e1C9oemCpSblK9SI5/79ujZXtfIzhyoAqwK7OfJOTw0X37bN1
         ljsES3bBd9R/D/evLhynS1VA+L4LairMwNl5XmQH/+bJwkE/NFh
Date:   Wed, 24 Apr 2019 22:32:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] run-command: add preliminary support for multiple
 hooks
Message-ID: <20190424223240.GI6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424004948.728326-2-sandals@crustytoothpaste.net>
 <xmqqo94w2l3k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VIOdPewhitSMo36n"
Content-Disposition: inline
In-Reply-To: <xmqqo94w2l3k.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VIOdPewhitSMo36n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 11:27:59AM +0900, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > diff --git a/run-command.c b/run-command.c
> > index 3449db319b..669af5ebc7 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -1308,58 +1308,137 @@ int async_with_fork(void)
> >  #endif
> >  }
> > =20
> > +static int has_hook(struct strbuf *path, int strip)
> > +{
> > +	if (access(path->buf, X_OK) < 0) {
>=20
> Does ".git/post-commit" that is not an executable exist?
>=20
> It was perfectly fine for find_hook() to say "there is no hook for
> post-commit" in the old world in such a case, because the
> unexecutable file it found is not going to be run anyway.
>=20
> But it is not clear if has_hook(), that affects "there is no single
> hook file for post-commit, so let's look at post-commit.d" decision
> made by find_hooks(), should behave that way.  It somehow feels more
> intuitive if a post-commit file that is not executable, by merely
> existing, stops post-commit.d directory from being scanned, at least
> to me.

Unfortunately, we used to have Git versions that wrote an non-executable
file in place instead of a ".sample" file when initializing the
repository. We have a warning for that, but I have many repositories
that have lived long enough that they're still affected (and I've turned
off the warning for that reason). I feel like we'll be creating
surprising behavior for long-term users.

Also, if someone is using an old manager script that uses the ".d"
directory or some other workaround, it's easy enough for them to simply
clear the executable bit; they need not delete it, and can restore it at
any time simply by toggling the bit.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--VIOdPewhitSMo36n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzA5AgACgkQv1NdgR9S
9otlEw/+KvyyIl4sIemRQRrt9iCjdLY1MrU3QTdjoLz3UfxDiFj3JBw1QHyIyyfy
hLv2R0UEOvxd0jha3cXk9unOHcwiuUM1Wd8n4/WbRMr4v/h4n8Ig1cSef6n7BCBF
E+Lzqc5TUMy7u26cAYqNj2a9eKakovboquHoxFjKulZKJ6yomkpgNBbwi69M2zAN
OCI7qmRNcjm/epqRvxkRPh+AtV1Ec5RN/daccxkGjuoyT6euaa+gMub66aa4N7sG
PDcUTi3kyBrIm0NwEUYVJ3dyzgHRss9tkMV0KsPG1YTHlVH8K3A6ZHj3V8zrp938
yrrRfml3pp7ttj9LdL3LpSc++mpQuD8VJ6BMJAiJDtru04cw7/gU0oRwh3hllwlZ
qkF12rTlceOYoL0WzjZ2X9Tc3nJ+BlOSQQBgKBH/gl7EcYoFBHF6GrvGc8b67RQl
LObGXYiZDQbgKgMbvCj8nd5EBuxJYre1rvgeU4G//jBD/cWYxchcnAFFtXkLxs3s
C0X3UdKSvOWbJeeb4evgfFc0YiLJoXPyNIZYXcZu0KI/CwKDR+NCJSLiUp2CSYuB
CqgjBoYJp0Robs6MRWPsbCrrLQCyEqpgrB6S65fGzHOjQh3JNILT2O2RW5U3izMK
Do1qFURIRc1hj6SYV870HTklRl72eEPu/WsnJknegzffbz2QXPQ=
=d8Cj
-----END PGP SIGNATURE-----

--VIOdPewhitSMo36n--
