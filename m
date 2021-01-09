Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CDFC433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 21:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105FA23A82
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 21:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbhAIVnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 16:43:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbhAIVnl (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Jan 2021 16:43:41 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9528760781;
        Sat,  9 Jan 2021 21:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610228579;
        bh=IB7nQlCHlWk9f5IhHKPlcMP7I+4MO8gu92lP8o4pb1E=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lrJPPmuk+8sGzv0pIwYoKkC4VSQvkCeroz7OGSmSZNrfl1Hm1MTeVL9TpDuf5Ic3W
         z5xX+0ZFc6XHAbOUZn/ERdvy3q10jx893owcn/1N+vS6ffALqWvrzILmH4HbPECKBK
         qbYfA5C3CHmBpNMQkMIW5WUsW1/WtmnU42YAadkeKcLlNuZABjYs32DwagP/UWN+T3
         FyCzfFQSUMB+N/4BueDBsdU54m9fDUenEZCvb6uj3xmbavAH7dI13mQxJ9QynzoPQI
         gkIsP40VtXsYbsGbMRH2WOLLLd6Sc/nA7wU8Baw0OB3qjO+uKrw6WQIhf1G5YIf6ej
         R0CDdfiQFVWRQb3g9Jpn9Kx/e5XvPtgdx5U0y5o6c8VSDApPB1qDSW0ZVLRyjx2aUk
         3/NgNyUvlgbOfHEuQ5bbuxvnt05URbchTkEXgrA2fEHOemB5lHMZCqIrGcbdfcseB0
         8sxZkNZgIciTUZ/5Wry0Yte2L6RzukpFHQQA7/FrmdMQb7fg6x2
Date:   Sat, 9 Jan 2021 21:42:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Alan Mackenzie <acm@muc.de>
Cc:     git@vger.kernel.org
Subject: Re: Difficulties of scripting git
Message-ID: <X/ojXdtGOHeP2IhY@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alan Mackenzie <acm@muc.de>, git@vger.kernel.org
References: <X/oAhdZlLwcFRCrR@ACM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WYowugLx+rvpq1bo"
Content-Disposition: inline
In-Reply-To: <X/oAhdZlLwcFRCrR@ACM>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WYowugLx+rvpq1bo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-09 at 19:14:13, Alan Mackenzie wrote:
> Hello, git.
>=20
> I want to write a bash script (more precisely, correct an existing
> script) which uses git, and it is DIFFICULT!!!
>=20
> I need a git pull in the script.  Fine, but how does the script know if
> it's worked or not?  I couldn't find any description of a return code in
> the git-pull man page (or in the git-merge man page).
>=20
> The big problem is when I have modified, uncommitted files in the target
> repo, and those same files are to be updated in commits coming from the
> source repo.  Sadly, git is unable to merge these changes.  It just
> fails, putting an error message onto stderr, but doesn't tell the
> calling script in any way that I can see.
>=20
> One idea would be always to call git stash before doing the pull, then
> git stash pop afterwards.  Trouble is, git stash is unreliable - it
> doesn't always add a new stash entry, so the stash pop at the end would
> sometimes/often pop off an entry it shouldn't.  git stash doesn't have a
> --force argument.  git stash doesn't set a result code, either, that I
> can see.  One way around this would be to do
>=20
>     $ git stash list | wc -l
>=20
> both before and after the git stash and compare the answers, but really?

git stash doesn't consider there being nothing to stash to be an error,
so it doesn't set a nonzero error code.  Think of it as, "I want a clean
working tree," not, "I want to create a stash."  In that sense, what you
wanted is already done, so it's not an error.

You are, however, not the only person who's been unhappy with this
behavior.  A --force option may be a useful option to have if someone
wanted to create it.

> So, next idea, feed the output from git status --porcelain through grep
> before and after the git pull, so as to find out whether there are any
> modified files before the git pull (thus making a stash necessary) and
> any files with conflicts after the git stash pop.  Shouldn't be too
> difficult.

Using "git status --porcelain" before and after the stash is an easy way
to find out whether there was anything to stash.  If there's a
difference, then a stash was created.

> Except, how does one recognise a file with conflicts from this git
> status output?  The man page says that
>=20
>     "   For paths with merge conflicts, `X' and `Y' show the modification
>     states of each side of the merge.  For paths that do not have merge
>     conflicts, `X' shows the status of the index, and `Y' shows the status
>     of the work tree.  For untracked paths, `XY' are `??'.  Other status
>     codes can be interpreted as follows:  ...."
>=20
> I've spent nearly an hour trying to make sense of this bit of man page.
> How is one meant to distinguish an XY of a merge conflict from the XY of
> an index/work tree entry?  I can't find that key bit of information
> anywhere.

In the chart, the options in the first section are "normal" cases that
occur without a merge conflict.  The second section is things that
happen when there's a conflict (the "unmerged" states).

So what you're looking for to find conflicts is something maybe a little
like this:

  git status --porcelain | grep -E '^(AA|DD|[AUD]U|U[AUD])'

If you believe that you're likely to need to handle names with newlines,
then of course you'll need -z as well.

I do agree that this is a little unclear; I went ahead and simulated a
merge conflict to verify.  I'll try to send a patch making the
documentation reflect what I mentioned about the chart above.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--WYowugLx+rvpq1bo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/ojXAAKCRB8DEliiIei
gQF5APwIAGb91XPZXcOOXEN153hH8kW6OdY/58+8IlhfzI6cwgEA7D8VKEc15O/0
makd3FhK8azfAoHhcPSdElRAgyYg+Ao=
=1WQG
-----END PGP SIGNATURE-----

--WYowugLx+rvpq1bo--
