From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v4 0/5] {checkout,reset,stash} --patch
Date: Sun, 9 Aug 2009 11:17:16 +0200
Message-ID: <200908091117.19167.trast@student.ethz.ch>
References: <200907271210.40001.trast@student.ethz.ch> <cover.1248815580.git.trast@student.ethz.ch> <20090809065207.GA14093@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3981183.Kghn4dhapm";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 09 11:17:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma4X9-0008Fd-BA
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 11:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbZHIJRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 05:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZHIJRf
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 05:17:35 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:56020 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396AbZHIJRe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 05:17:34 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sun, 9 Aug
 2009 11:17:35 +0200
Received: from thomas.localnet (77.56.221.170) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sun, 9 Aug
 2009 11:17:32 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090809065207.GA14093@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125335>

--nextPart3981183.Kghn4dhapm
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> I finally got a few minutes to look at this. I tried "checkout --patch"
> first, which was very confusing:
>=20
>   $ echo old content >file && git add file && git commit -m old
>   $ echo new content >>file
>   $ git checkout --patch file
>   diff --git a/file b/file
>   index 33194a0..805c3b0 100644
>   --- a/file
>   +++ b/file
>   @@ -1 +1,2 @@
>    old content
>    +new content
>   Check out this hunk [y,n,q,a,d,/,e,?]?
>=20
> Shouldn't the diff be reversed? That is, I think what users would like
> to see is "bring this hunk over from the index to the working tree". But
> we have the opposite (a hunk that is in the working tree that we would
> like to undo).

Well, my thinking for the initial (restricted; you couldn't say 'git
checkout -p HEAD~14') version went something like this: 'reset -p'
should be the opposite of 'add -p', so it offers the same hunks with
the question "Reset?".  Then 'checkout -p' should somehow follow suit,
but asked "Discard?" (IIRC I even had it in all caps).

I'm not 100% happy with your suggested forward patches strategy
because I think (particularly for people with colors enabled, and I
suspect we all have), it's less confusing "my" way if they go through
'add -p' and suddenly think "oops, mistake, I need to reset that": it
is much easier for the (at least for my) eye to find the same hunk
again if it is really 100% the same.  Probably we would have to change
the verb to "discard" again, though.

OTOH this does become rather weird once you specify anything other
than HEAD.  And while we could of course switch the approach if the
user does that, and hope that he'll understand on the grounds that
it's an advanced usage, I'm not sure switching is a good idea in
general.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart3981183.Kghn4dhapm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkp+lB8ACgkQqUud07tmzP3YvACePqFGFgjT60GwCzv+DsFpid/b
TvYAoJ4cB6awn9CbgC786Yb1ZLvRf0kw
=dhD7
-----END PGP SIGNATURE-----

--nextPart3981183.Kghn4dhapm--
