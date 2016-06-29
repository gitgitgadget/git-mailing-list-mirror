Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D73E1FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 06:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbcF2G1n (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 02:27:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48224 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290AbcF2G1m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2016 02:27:42 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id C39E221A52;
	Wed, 29 Jun 2016 02:27:41 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 29 Jun 2016 02:27:41 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=9MYSwbarRITQDo03F1+0/7Q2q78=; b=Kvclj
	l54WplgUNiLD9zVSfXWm3Voe0HgVKDK/IG93vjuzx3OoABYTBh6ErYiq/QJzUKlI
	dgAtIBraGex9MNe+ljSxjI4N0TGvde3qocUl7gJwiDa7vOodloeREHg6asSRX3DP
	O5DAriM03gAo7XIaq6YpZburVSOWUr68pwllN0=
X-Sasl-enc: k3QS4wyq9Wf3QSwbhl3rShUWF/wRDfoWn8qsI1kfkALf 1467181661
Received: from localhost (x4e340075.dyn.telefonica.de [78.52.0.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 43A28CCDB2;
	Wed, 29 Jun 2016 02:27:41 -0400 (EDT)
Date:	Wed, 29 Jun 2016 08:28:18 +0200
From:	Patrick Steinhardt <ps@pks.im>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Hahler <git@thequod.de>
Subject: Re: [PATCH] rebase -i: restore autostash on abort
Message-ID: <20160629062818.GA416@pks-pc.localdomain>
References: <20160628175704.26095-1-ps@pks.im>
 <xmqqa8i587cx.fsf@gitster.mtv.corp.google.com>
 <vpqvb0tqc46.fsf@anie.imag.fr>
 <xmqqshvx6mpe.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <xmqqshvx6mpe.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2016 at 02:13:49PM -0700, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>=20
> > It is "interesting" if you mean "matches real-life use-case", as it
> > corresponds to the case where the user killed the editor (as reported by
> > Daniel Hahler indeed, "Abort with ":cq", which will make Vim exit
> > non-zero").
>=20
> Yes.  It is an interesting failure mode in that sense.  But breakage
> of such a basic mode is something an end-user is likely to notice
> immediately, so in that sense, having such a test alone is not all
> that interesting.

Well, given that the bug has been lingering since autostashing
has been implemented it seems users didn't catch the breakage as
fast ;) I guess it's just a little-used feature _or_ the breakage
is too obscure to regularly happen. At least I have never cause
my editor to return an error when editing the ISN-sheet.

But still, I agree that a test for conflicting autostashes is
beneficial, even though the scenario is even more unlikely (the
user's editor has to return an error code as well as that a
stashed file needs to be modified while editing the ISN-sheet).
I've just sent out a second version of the patch.

Thank you both for your input.

> > If you mean "likely to trigger nasty bugs", then indeed testing the case
> > when apply_autostash fails is interesting: for example, calling
> > die_abort when "stash apply" fails is tempting, but would lead to
> > infinite recursion (it doesn't seem to be the case, but a test would be
> > nice). Setting the editor to something that modifies uncommited-content
> > before 'false' should do the trick.

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXc2qCAAoJEBF8Z7aeq/EshPsP/jg+DFNcMIhcGp3IVEp5oGoz
LVm5Uf2Opfqz2FFdLpC4n2fgC9XnoaZ/1yAakfrp5e+vsYErLJPxgbBfXcl9pBOe
sUj6E6kc409hA5o/+xm1VX5SWwH1TEqDpY6DbsoHCUgmkuuDQaA1ElMwlcx0305z
1Nq9RWtKxVYAWQRQ8KfnnLdG+LPVuBLmtvGzVs+cc4XCQOtMMpn3QVD+qBO+Ew/A
IQPmdwxuJe/f2kcC2qU6YuC2khLUMvL8eJY9FSH+IyHdn72LbZxW2OoD8j+yL23a
6GmeI4Igmx+xlB5Be0YN/ZsefThBAcZ07jmrN17x3fhdc6QzvUViCZqDrMs2U6zG
dRe6h12hqzDJe2NDwDqRiXd3slx+TRfo6U9P9fbWqLxV5OgNClX77GDNu9DXKGB6
vA51PYSz4VYP4N129tZ03ktmG5bu26fhv9CcCEhOPbrGJ0FK350AE6C2r8un24hl
kGtCEfP69WZde4/wDN3STfQBWOEaqeIajbIowRxESWv8AwnwAVP+KC6rUCPbKF+V
TPzvfD4dlj3/vyV5pEdwlPuht93Y2Sjhzvg3W5aNcszwutThgDMyrHu8XZCKDCaY
lanP78PTquzks1v874FOopWfKOqYw07FY7+rkVDCcNkJ0EVtLNb5UuLDiSpxM0xP
WI1iKpPIsAwrVE7YLors
=Uhkm
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
