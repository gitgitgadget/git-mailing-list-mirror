From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: feature-request: git notes copy --to <ref>
Date: Thu, 20 Feb 2014 22:03:34 +0100
Message-ID: <20140220210334.GM6988@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de, Johan Herland <johan@herland.net>,
	Stephen Boyd <bebarino@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 20 22:03:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGamX-0004af-IO
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 22:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660AbaBTVDl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Feb 2014 16:03:41 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43362 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbaBTVDk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 16:03:40 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1WGamP-0004vI-KU; Thu, 20 Feb 2014 22:03:37 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.82)
	(envelope-from <ukl@pengutronix.de>)
	id 1WGamM-0003mX-Ia; Thu, 20 Feb 2014 22:03:34 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242448>

Hello,

I'm playing around with git-notes and want to share some of my notes
with my co-workers. We have a central repository for our various topic
branches and want to track upstream inclusion in git-notes. So we have
to share our notes branch somehow.

The workflow I think makes sense here is (untested):

	### hack hack, add notes bla blub
	### -> nice topic branch with some notes

	git fetch serverrepo refs/notes/commits:refs/notes/servercommits
	git notes merge refs/notes/servercommits
	git rev-list origin/master.. | awk '{print $1 " " $1}' | git notes cop=
y --to refs/notes/servercommits --stdin
	git push serverrepo refs/notes/servercommits:refs/notes/commits

Then maybe:

	git notes merge refs/notes/servercommits

again.

The idea here is to only include notes in refs/notes/servercommits that
are relevant for my coworkers and not all intermediate notes that were
created during development or while working on other branches.

Does this make sense? Do you have better ideas or suggestions how to
improve the workflow?

The only problem now is that git notes copy doesn't take a --to
parameter. Maybe there is a volunteer to implement it? Then I'd
volunteer to test it :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
