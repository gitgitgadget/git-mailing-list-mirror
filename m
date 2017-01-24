Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8A62092F
	for <e@80x24.org>; Tue, 24 Jan 2017 11:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750893AbdAXLfr (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 06:35:47 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:44383 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbdAXLfr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 06:35:47 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jan 2017 06:35:46 EST
Received: from localhost (x4e340422.dyn.telefonica.de [78.52.4.34])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 2182A16C78E;
        Tue, 24 Jan 2017 12:29:53 +0100 (CET)
Date:   Tue, 24 Jan 2017 12:29:52 +0100
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v1 0/2] urlmatch: allow regexp-based matches
Message-ID: <20170124112952.GA2603@pks-pc>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
 <xmqqsho9r1rs.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <xmqqsho9r1rs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2017 at 11:53:43AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <patrick.steinhardt@elego.de> writes:
>=20
> > This patch is mostly a request for comments. The use case is to
> > be able to configure an HTTP proxy for all subdomains of a
> > certain domain where there are hundreds of subdomains. The most
> > flexible way I could imagine was by using regular expressions for
> > the matching, which is how I implemented it for now. So users can
> > now create a configuration key like
> > `http.?http://.*\\.example\\.com.*` to apply settings for all
> > subdomains of `example.com`.
>=20
> While reading 2/2, I got an impression that this is "too" flexible
> and possibly operates at a wrong level.  I would have expected that
> the wildcarding to be limited to the host part only and hook into
> match_urls(), allowing the users of the new feature to still take
> advantage of the existing support of "http://me@example.com" that
> limits the match to the case that the connection is authenticated
> for a user, for example, by newly allowing "http://me@*.example.com"
> or something like that.
>=20
> Because you cannot have a literal '*' in your hostname, I would
> imagine that supporting a match pattern "http://me@*.example.com"
> would be already backward compatible without requiring a leading
> question-mark.
>=20
> I also personally would prefer these textual matching to be done
> with glob not with regexp, by the way, as the above description of
> mine shows.
>=20
> Thanks.

Thanks for your feedback. Using globs in the hostname only was my
first intent, as well. I later on took regular expressions
instead so as to allow further flexibility for the user. The
reasoning was that there might be other use cases which cannot
actually be solved with using globs only, even if I myself wasn't
aware of different ones. So this might be indeed over-engineered
when using regular expressions.

There are several questions though regarding semantics with
globs, where I'd like to have additional opinions on.

- should a glob only be allowed for actual subdomains, allowing
  "http://*.example.com" but not "http://*example.com"?

- should a glob also match multiple nestings of subdomains? E.g.
  "http://*.example.com" would match "http://foo.example.com" but
  not "http://foo.bar.example.com"?

I'll send a version 2 soon-ish.

Regards
Patrick

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYhzqwAAoJEBF8Z7aeq/Es6DMP/ReSRwBx8W/RKotX5Ab775QQ
Gz1M3yd3X0Mp6RlbHDIbTWcB+WLvQCv2cTQEL22EJFtD+DZ2QaX0i1O/uRcA8Aiu
vMZoU3B2y1VolEn2fGKBWInywQB4qFUcStfsdQiA9M9wndtoxHbojHrWrQ77YQRU
tC95kohd5XjXlMOGigUME6gidH39CtedB1qSAw7PTDVOJ7aE6iOG+aFfwICJ2pld
k4IyY7o2cLAHzm7ZD/3kpx+e7PtUnJnvSKptV2YH1fLZdC5Z4qRUfV5XABfVdIwk
1+QqZ/y185k22MC3fiMkItVDmj0uU1NSUNTEVGAOepgqZMwUxmTA1EbySnedYENU
3vVQSy9m7tfOqQAC90MbfCOLDfuKy7yvSof7oMa34oyhP5XQZjsqMbYz02xaa1UQ
Jw5Qp5Y145zRIm3wW9FN8sshjPheBpVqDGWwmWPOfWehtQUhsVXA+MRGQ1SURUEU
NkGb+OItqH7xAH2bkNlTM8e8D1T0YvSJghqG6/k+ksV8BvOSARn+rf5wgqIHgYtQ
6OR7LlbNkgh7u7lK7jDzzAO28pWfXY/SCHyU8+eWFeU9WDkCPkbyeizOU3bFgX8b
DUOnMrFYRjYQBbdrbWidSOHiDI3S2uzFq7faEuzWyG/S5xbdAC0ewsg7VF5Ryv8L
GluNrEsRIY4F0OH3Wj7m
=7vpA
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
