From: Jeff King <peff@peff.net>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 16:07:09 -0500
Message-ID: <20130218210709.GC27308@sigill.intra.peff.net>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
 <20130218174239.GB22832@sigill.intra.peff.net>
 <20130218193424.GC3234@elie.Belkin>
 <CALkWK0mKZLotuu7pEM_3Of3i6JzU12QV_pHxOZTUr22TOq3PeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 22:07:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Xw3-0001qU-Pt
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 22:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732Ab3BRVHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 16:07:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52300 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232Ab3BRVHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 16:07:12 -0500
Received: (qmail 24718 invoked by uid 107); 18 Feb 2013 21:08:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 16:08:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 16:07:09 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0mKZLotuu7pEM_3Of3i6JzU12QV_pHxOZTUr22TOq3PeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216530>

On Tue, Feb 19, 2013 at 02:14:54AM +0530, Ramkumar Ramachandra wrote:

> >  - assimilating the distro builds: "make deb-pkg", "make rpm-pkg",
> >    etc along the same lines as the linux kernel's script/package/,
> >    to help people get recent git installed when they want it
> 
> Overkill.  I just symlink to bin-wrapper/git from a place high up in
> my $PATH.  If anything, we should be making it easier for ourselves to
> run different versions of git right from $HOME, much like rbenv.
> System-wide installs are taken care of by the distribution package
> managers, and I doubt they need any help from us.

This is not related to GSoC anymore, but I think handling multiple
versions is already pretty easy. You can just install to
"$HOME/local/git/$TAGNAME" or similar, and then symlink the "bin/git"
binary from there into your PATH as git.$TAGNAME (e.g., git.v1.7.8). Git
already takes care of the messy bits, like making sure sub-programs are
invoked from the same git version.

I already do this automagically with this script:

  https://github.com/peff/git/blob/meta/install/prefix

I just set "prefix" in the Makefile based on the script, and when I
"make install" tags or topic branches, they go to the right place (and
the "links" script in the same directory maintains the symlinks for me).

I never bothered to even submit those scripts to contrib, because I
figured they were so specific to my setup, and to keeping dozens of git
versions around (when debugging, it's nice to be able to check an old
version's behavior without even having to build it).

Of course that has nothing to do with Jonathan's proposal. I do agree
that it is pretty straightforward to just put $BUILD_DIR/bin-wrappers in
your PATH and be done. I guess that doesn't cover manpages, though (but
Real Programmers just read the source anyway, right?).

-Peff
