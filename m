Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 2387 invoked by uid 107); 9 Feb 2009 14:08:41 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 09 Feb 2009 09:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbZBIOIS (ORCPT <rfc822;peff@peff.net>);
	Mon, 9 Feb 2009 09:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbZBIOIS
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 09:08:18 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:38688 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbZBIOIR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 09:08:17 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Feb 2009 15:08:15 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 9 Feb 2009 15:08:15 +0100
From:	Thomas Rast <trast@student.ethz.ch>
To:	git@vger.kernel.org
Subject: [RFC/RFH] Fun things with git-notes, or: patch tracking backwards
Date:	Mon, 9 Feb 2009 15:08:08 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1762019.6XaY57o4e3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200902091508.11460.trast@student.ethz.ch>
X-OriginalArrivalTime: 09 Feb 2009 14:08:15.0672 (UTC) FILETIME=[D9F2BB80:01C98ABF]
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

--nextPart1762019.6XaY57o4e3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everyone

I'll start with the fun first, try this in a git.git:

  git fetch git://repo.or.cz/git/trast.git mailnotes &&
  GIT_NOTES_REF=3DFETCH_HEAD git log origin/pu

I played around with some python code over the weekend that
automatically filters through git@vger.kernel.org history and scans
for patches, threads, and "What's cooking" messages.  So far it seems
to be working ok.

The net effect is that we get a backwards patch tracker: instead of
tracking the patches via some other means (say a web interface), the
automatic annotations can reconstruct more information about the
patches than what is eventually contained in the commits, and make it
available via git-notes.

Right now it only applies the patches that it finds, and associates
that with known commits to annotate them.  I eventually want to scan
for replies to patch text too, and insert them into the notes too.  I
also plan to publish topics for the patches somewhere (they're already
applied locally) and track at least a rudimentary status, perhaps one
of "unreplied", "replied" and "accepted".  (Distinguishing "rejected"
seems AI-complete.)

The whole process is a bunch of python scripts currently available at

  git://repo.or.cz/trackgit.git
  http://repo.or.cz/w/trackgit.git

It's all a bit after-the-fact right now, and can't cope with a few
things yet, for example patch series that aren't in git.git appearing
out of sequence to the mail reader.

Runtime is okay-ish so that I should be able to run it as a cronjob;
note regeneration is almost negligible (<1min), importing a month's
worth of mails takes on the order of 20min, and scanning history (to
know about the base blobs) since v1.6.0 is around 3min.

So the RFC bit is, is this useful to anyone?  What information would
you like to see in it, and what could be left out?

And the RFH: I don't have a full mail archive, not even since I joined
the list.  There also doesn't seem to be a convenient download button
on gmane.  Does anyone have (or know of) an archive going at least
back to v1.6.0 (not sure if any further back is interesting), which
was released in August last year, that you could send to me?

Thanks in advance :-)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1762019.6XaY57o4e3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmQOMsACgkQqUud07tmzP1KLwCeIi1LQQiOlyah+GtIZeBCJHoG
YbUAnRw1Cd6ojsmrqWI4YgPgZFPSovRv
=p97A
-----END PGP SIGNATURE-----

--nextPart1762019.6XaY57o4e3--
