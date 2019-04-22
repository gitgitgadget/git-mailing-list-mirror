Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC9C1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 23:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfDVXHK (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 19:07:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35556 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728738AbfDVXHJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Apr 2019 19:07:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 089E360458;
        Mon, 22 Apr 2019 23:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1555974426;
        bh=xPD7RgRQNE7woxQmyTBGE55sgsvoX7plqgiMbaZAh0M=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NrEyfh1TgJWUEsG2RbCcv+2xrJkofMod3s5xC9lYku1q3z17BfelPAQlhGcLz63y+
         ZBpdjXiQshhTgpRNjTdwMBDmiuiwahreGmFnnoyksyJN34Hw2oxR6RlN20OTyP0S4I
         gjk5meXxBeToHR/MA7OkeP8XCalsMjJMJ5O9PXOseibsFja18vS8I5HZ/COy1KPnBe
         FNDBitj69iiGT9IpOe5RqJ6qiHSuIwegkl0RkKRIHbw3Cm8v1bJGAQ9tJ7ULqFG7CZ
         fPxd/1TTa4MjLOMLBGDam9PL96QryNL793EvVhry1EWJXfo++WbKLLU4rYxP+/RxZK
         yj8k3L9mPN9dOOy5fv8ncl7ZGe0Nu52eaf6i3Mpb0zhJmNuwgtPYmaeZpepeM7Eb/f
         dMqYIw1/0b1MYYfLPEvFfTJBG/rQcFJb3bPtY2u/qBa9P/wXw7NEa3gE34OVMw97LD
         5tFx/45UdixARzVURfmZxD5KPnUICQJv8aBzh1n/Q4dadJrRCyP
Date:   Mon, 22 Apr 2019 23:07:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Santiago Torres Arias <santiago@nyu.edu>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.us
Subject: Re: [RFC PATCH] builtin:tag:verify_tag: allow gpg output + pretty
Message-ID: <20190422230701.GD6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Santiago Torres Arias <santiago@nyu.edu>,
        git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.us
References: <20190412201432.11328-1-santiago@nyu.edu>
 <20190422152726.GB1633@sigill.intra.peff.net>
 <20190422154655.sxyrkee7rnywoh2w@LykOS.localdomain>
 <20190422160211.GB9680@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Lb0e7rgc7IsuDeGj"
Content-Disposition: inline
In-Reply-To: <20190422160211.GB9680@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 12:02:11PM -0400, Jeff King wrote:
> On Mon, Apr 22, 2019 at 11:46:56AM -0400, Santiago Torres Arias wrote:
>=20
> > > In some ways I'm less concerned about verify-tag, though, because the
> > > point is that it should be scriptable. And scraping gpg's stderr is n=
ot
> > > ideal there. We should be parsing --status-fd ourselves and making the
> > > result available via format specifier, similar to the way "log
> > > --format=3D%G?" works.
> >=20
> > I think that would be great, as we could make it simpler for verifiers
> > to parse gpg output.
>=20
> Alternatively, we could make it an option to dump the --status-fd output
> to stderr (or to a custom fd). That still leaves the caller with the
> responsibility to parse gpg's output, but at least they're parsing the
> machine-readable bits and not the regular human-readable stderr.

Don't we already have that for verify-tag and verify-commit? I recall
adding "--raw" for that very reason:

genre ok % git verify-tag --raw v2.21.0
[GNUPG:] NEWSIG
[GNUPG:] KEYEXPIRED 1442879137
[GNUPG:] KEYEXPIRED 1505842336
[GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
[GNUPG:] KEYEXPIRED 1442879137
[GNUPG:] SIG_ID NZHib/GfN4TzXBhuI9ABwYXqluE 2019-02-24 1551023739
[GNUPG:] KEYEXPIRED 1442879137
[GNUPG:] KEYEXPIRED 1505842336
[GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
[GNUPG:] KEYEXPIRED 1442879137
[GNUPG:] KEYEXPIRED 1505842336
[GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
[GNUPG:] EXPKEYSIG B0B5E88696AFE6CB Junio C Hamano <gitster@pobox.com>
[GNUPG:] KEYEXPIRED 1442879137
[GNUPG:] KEYEXPIRED 1505842336
[GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
[GNUPG:] KEYEXPIRED 1442879137
[GNUPG:] KEYEXPIRED 1505842336
[GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
[GNUPG:] VALIDSIG E1F036B1FEE7221FC778ECEFB0B5E88696AFE6CB 2019-02-24 15510=
23739 0 4 0 1 8 00 96E07AF25771955980DAD10020D04E5A713660A7
[GNUPG:] KEYEXPIRED 1442879137
[GNUPG:] KEYEXPIRED 1505842336
[GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
[GNUPG:] KEYEXPIRED 1442879137
[GNUPG:] KEYEXPIRED 1505842336
[GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
[GNUPG:] KEYEXPIRED 1442879137
[GNUPG:] KEYEXPIRED 1505842336
[GNUPG:] KEY_CONSIDERED 96E07AF25771955980DAD10020D04E5A713660A7 0
[GNUPG:] TOFU_USER 96E07AF25771955980DAD10020D04E5A713660A7 gitster@pobox.c=
om
[GNUPG:] TOFU_STATS 2 1 0 auto 1555974073 1555974073 0 0 2 1 0
[GNUPG:] TOFU_STATS_LONG gitster@pobox.com: Verified 1~signature in the pas=
t 0~seconds.  Encrypted%0A0 messages.
[GNUPG:] TOFU_USER 96E07AF25771955980DAD10020D04E5A713660A7 jch@google.com
[GNUPG:] TOFU_STATS 2 1 0 auto 1555974073 1555974073 0 0 2 1 0
[GNUPG:] TOFU_STATS_LONG jch@google.com: Verified 1~signature in the past 0=
~seconds.  Encrypted 0%0Amessages.
[GNUPG:] TOFU_USER 96E07AF25771955980DAD10020D04E5A713660A7 junio@pobox.com
[GNUPG:] TOFU_STATS 2 1 0 auto 1555974073 1555974073 0 0 2 1 0
[GNUPG:] TOFU_STATS_LONG junio@pobox.com: Verified 1~signature in the past =
0~seconds.  Encrypted%0A0 messages.
[GNUPG:] VERIFICATION_COMPLIANCE_MODE 23

The idea was that users might want to restrict signatures to using
subkeys or certain algorithms or what-have-you, and this was the easiest
way to let people have all of that power.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Lb0e7rgc7IsuDeGj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAly+SRUACgkQv1NdgR9S
9otP8w//XUXqbba3UKKg10n7N5OdqIv1meN45felnqEL80EIpVQxIdNIrcD8o6B6
ttoaWBfscOaYuFJOOZ+QFb2QrTxA2h+X3URubvMKgy+6KGVs7HIKS2k7NhMaHWhF
2aXkpofajiZYNdN3RWzdu/IPFc+mNhoFiy1KSml3ESzc04rHLpJNdMWSXUJ0fsin
ZgWIvLYqUWJC05y1IYO8Eiz9RyPNloEBjdVA+rR+XxBz+EwTF3yzhtyByROpl3sb
QdMiRNnyrslF059235oRXWOGEObsGuaflOPxUw3gvitBPQFsAQtUFuiDYW03UyNh
oTAofBGwiyFkGJjWda/CdPf9YWdUXwAltkkFS1ahoD+DofAhnzaPsgt8M9KIFWIU
NpgDhrLCZBM/Vp0zUfqiSkrXyx2dtqOjDOeIbDJ0dI02Rl6HEIH1VzDhPCPWzTrd
ySXiSlexTcoTTrrkKiQqW4uJnsvNBjBT25Taa3D/WMawjdim584qkgsTtfz5EKLr
wXah1zusj4lVEhRGmGVkb+f6JUBSFVhmDXsOmA7KRrjI5cXYI089vHqtmYaQz4y8
MZ/HZdk7wzUMRfpbgo7o7919nCoet+FcRQhqu0d7QF6zWZiN0eo7GholrbWhkOhE
QtHG+AP2DQUwfrQJGAwed5nPTlN5KCKebM3wzpvGMlcagY3Ihew=
=xuZ6
-----END PGP SIGNATURE-----

--Lb0e7rgc7IsuDeGj--
