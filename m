From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: git-svn won't remember pem password
Date: Thu, 26 Apr 2012 20:00:18 +0200
Message-ID: <20120426180018.GX4023@login.drsnuggles.stderr.nl>
References: <E56535F6-2C9B-4D14-A88F-2471E34D2769@gmail.com> <20120219013011.GB31886@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I4LDBnWaR3ZxTd6l"
Cc: Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Igor <mrigor83@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 20:32:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNTUX-0001FP-DW
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 20:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758819Ab2DZSc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 14:32:28 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:57103 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893Ab2DZSc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 14:32:27 -0400
X-Greylist: delayed 1920 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Apr 2012 14:32:27 EDT
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1SNSzK-0001EI-RS; Thu, 26 Apr 2012 20:00:19 +0200
Received: (nullmailer pid 4726 invoked by uid 1000);
	Thu, 26 Apr 2012 18:00:18 -0000
Mail-Followup-To: Igor <mrigor83@gmail.com>,
	Gustav Munkby <grddev@gmail.com>, Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20120219013011.GB31886@dcvr.yhbt.net>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196388>


--I4LDBnWaR3ZxTd6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Igor,

> > I'm running into an issue where I have to enter my pem certificate
> > password every time I git-svn fetch or git-svn dcommit. Vanilla svn
> > uses OS X KeyChain and remembers my password just fine. Is there a
> > known solution for this? Other users have ran into same issue as
> > described here:
> > http://stackoverflow.com/questions/605519/does-git-svn-store-svn-passwords.
> > However, that solution of removing .subversion folder did not work for
> > me.

I suspect this would be solved by including what svn calls "platform
specific authentication providers". This works on Linux, but I don't
have access to OSX for testing.

Could you test the patch I pasted below to see if this fixes your
problem? The patch is made against the git source tree (git master
version), but you should probably be able to apply it to your installed
git-svn file as well (it's just a perl script). I'm not sure where that
file lives on OSX though, it's /usr/lib/git-core/git-svn on my Linux
(Debian) system.

Eric, I think I got this feature sorted out finally (there is a second
patch for entering the gnome-keyring unlock password which required some
changes in the subversion bindings which got applied a while ago). Let's
see what the patch does for Igor and then I'll send over both patches
afterwards.

Gr.

Matthijs

--I4LDBnWaR3ZxTd6l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk+ZjTIACgkQz0nQ5oovr7ycfgCfX3HRb7jDRNw2dqDACSSJfWDi
j3UAoLKFn9FjDyykgUCvUcRmy0fPTkSu
=Sj9s
-----END PGP SIGNATURE-----

--I4LDBnWaR3ZxTd6l--
