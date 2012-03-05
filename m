From: Jeff King <peff@peff.net>
Subject: Re: Bug: pull --rebase with =?utf-8?B?w6kg?= =?utf-8?Q?in?= name
Date: Mon, 5 Mar 2012 06:58:15 -0500
Message-ID: <20120305115815.GA4550@sigill.intra.peff.net>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
 <20120305102657.GB29061@sigill.intra.peff.net>
 <87399nqqog.fsf@thomas.inf.ethz.ch>
 <F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Haber <rene@habr.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 12:58:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4WYu-0003Vr-H1
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 12:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104Ab2CEL6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 06:58:20 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37662
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932102Ab2CEL6S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 06:58:18 -0500
Received: (qmail 29454 invoked by uid 107); 5 Mar 2012 11:58:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Mar 2012 06:58:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Mar 2012 06:58:15 -0500
Content-Disposition: inline
In-Reply-To: <F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192230>

On Mon, Mar 05, 2012 at 12:42:14PM +0100, Ren=C3=A9 Haber wrote:

> I'm running git 1.7.9.2 from Fink Project on MacOS X 10.6.
> The gitconfig in hex is attached.

Hmm, looks like pretty standard utf8:

  0000020: 6d65 203d 2052 656e c3a9 2048 6162 6572  me =3D Ren.. Haber

and the same thing I used in my tests. I tried repeating the test with
v1.7.9.2 on OS X (although my test box is 10.7), and couldn't replicate
it.

Can you show us the commit that causes the problem, as printed by "git
cat-file commit $commit | xxd"? I just want to double-check that there
are no odd bytes there.

Also, what happens if you do:

  sh -c '
    . /sw/lib/git-core/git-sh-setup
     get_author_ident_from_commit $commit
  '

(my theory is that this is the underlying problem in the rebase, and
should show the bug; by narrowing it down, it should make testing a lot
simpler).

-Peff
