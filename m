From: martin f krafft <madduck@madduck.net>
Subject: Not setting M-F-T, keeping people on Cc (was: [PATCH] clarify need
	for init in git-submodules documentation)
Date: Mon, 20 Aug 2007 11:29:30 +0200
Message-ID: <20070820092930.GA32563@piper.oerlikon.madduck.net>
References: <200708161553.10991.Josef.Weidendorfer@gmx.de> <11872878021267-git-send-email-madduck@madduck.net> <20070817093116.GH1070MdfPADPa@greensroom.kotnet.org>
Reply-To: madduck@madduck.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Cc: skimo@liacs.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 11:29:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN3Zr-00085j-B1
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 11:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756439AbXHTJ3f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 05:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756738AbXHTJ3f
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 05:29:35 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:59519 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbXHTJ3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 05:29:33 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 29CF88966ED;
	Mon, 20 Aug 2007 11:29:32 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 29396-01; Mon, 20 Aug 2007 11:29:31 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 7C5C38966EC;
	Mon, 20 Aug 2007 11:29:31 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id D44A79F16A;
	Mon, 20 Aug 2007 11:29:30 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id A18E743F9; Mon, 20 Aug 2007 11:29:30 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org, skimo@liacs.nl
Content-Disposition: inline
In-Reply-To: <20070817093116.GH1070MdfPADPa@greensroom.kotnet.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56201>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sven Verdoolaege <skimo@kotnet.org> [2007.08.17.1131 +0200]:
> PS, please don't prune (me from) the CC list when replying.

I am not used to lists where the policy is to CC posters, but seeing
posts like http://marc.info/?l=3Dgit&m=3D113882569532399&w=3D2 and given
my newcomer/not-(yet-)important-contributor status, I am happy
to comply (and apologise for not doing so earlier).

To help others in similar positions do the right thing I am sharing
my relevant mutt configuration:

  # do not set M-F-T on mails to the git mailing list
  send-hook . 'set followup_to'
  send-hook '~C git@vger\.kernel\.org' 'unset followup_to'

This takes care of not sending M-F-T in outgoing mail. The remaining
issue is how to ensure that those (and only those) people end up on
Cc who want to be there. I have come up with two ways: using mutt
hooks and adding M-F-T to incoming mail:

  # do a <group-reply> for L when sending to the git mailing list
  # http://marc.info/?l=3Dmutt-users&m=3D118734866910357&w=3D2
  message-hook . 'bind pager L list-reply'
  message-hook '~C git@vger\.kernel\.org' 'bind pager L group-reply'
  macro index L '<display-message>L'

This is a bit ugly, but it works. However, since it interferes with
some other hooks and other parts of my configuration, I had to find
another way:

the theory is that my procmail *adds* the Mail-Followup-To header to
incoming git list mails that don't have it yet, and puts all
=46rom/To/Cc addresses on there. This will cause my local mutt to
behave exactly like it should when I press L, but since the
send-hook has disabled followup_to, my reply will *not*
contain/propagate the Mail-Followup-To header.

  :0
  * ! ^Mail-Followup-To:
  * ^TO_git@vger\.kernel\.org$
  {
    CORRESPONDENTS=3D`formail -cxTo: -xCc: -xFrom: | tr -s '\n' ,`
    :0 fw
    |$FORMAIL -A "Mail-Followup-To: $CORRESPONDENTS"
  }

In addition, I advice to unset metoo in mutt's configuration to
avoid CCing yourself on outgoing mail.

Now all I need is to filter duplicate messages with procmail in such
a way that the list mail makes it through and the personal CC (which
usually arrives first) is dropped:

  :0
  * ^X-Original-To: madduck@madduck\.net$
  * ^TO_git@vger\.kernel\.org$
  /dev/null

Make sure this happens *before* you weed out duplicate mail with
formail.

Comments welcome, but off-list, please (Reply-To set). If important
stuff turns up, I'll collect and append a summary to this thread in
a bit.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"for nasa, space is still a high priority."=20
                                                      - george w. bush
=20
spamtraps: madduck.bogus@madduck.net

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGyV76IgvIgzMMSnURAgpeAJ4uayxHYJk7bPvU1hfcuNE0c5MD2gCg5BWs
HNLExcmanwFIezrJlvuOiQk=
=G7UO
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
