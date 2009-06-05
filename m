From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] hooks/pre-commit: check for cycles in
	dependencies
Date: Fri, 5 Jun 2009 22:25:26 +0200
Message-ID: <20090605202526.GB671@pengutronix.de>
References: <1244148073-2313-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:25:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCfyt-00081q-Rd
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbZFEUZ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 16:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbZFEUZ0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:25:26 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40474 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbZFEUZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:25:25 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MCfyh-00035i-9N; Fri, 05 Jun 2009 22:25:27 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MCfyg-0000HG-H5; Fri, 05 Jun 2009 22:25:26 +0200
Content-Disposition: inline
In-Reply-To: <1244148073-2313-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120828>

Hi Bert,

On Thu, Jun 04, 2009 at 10:41:13PM +0200, Bert Wesarg wrote:
> Only newly added dependencies needs to be considered.  For each of th=
ese deps
> check if there is a path from this dep to the current HEAD.
>=20
> Use recursive_dep() for this task.  Even if recursive_dep() uses a DF=
S-like
> traversal it will not run into an infty-loop if there would be a cycl=
e, because
I'm not sure how understandable this is.  After some thinking I
understood DFS.  Up to now I thought infty is just the LaTeX macro name
for "infinity", but apart of this, is this really the right term here?
endless loop?

> recursive_dep() takes .topdeps only from committed trees.  And it is =
required
> that the committed dependency graph is acyclic.

I didn't check the implementation deeply.  But all in all I don't have
the usual warm and fuzzy feeling about it.  What happens during a remot=
e
update if only the merged dependency graph has a cycle[1]?

Best regards
Uwe

[1] The question is a bit theoretic because remote updating is broken
here.  If you are my remote and changed a .topdep file, my update simpl=
y
discards your change.

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
