From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/10] run test suite without dashed git-commands in
 PATH
Date: Mon, 26 Jan 2009 12:06:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901261201470.14855@racer>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-6-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-7-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-8-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-9-git-send-email-mmogilvi_git@miniinfo.net> <alpine.DEB.1.00.0901250255250.14855@racer> <20090126064004.GA3004@comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 12:08:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRPK4-00034A-Ut
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbZAZLFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbZAZLFk
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:05:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:50001 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750768AbZAZLFj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:05:39 -0500
Received: (qmail invoked by alias); 26 Jan 2009 11:05:37 -0000
Received: from pD9EB294D.dip0.t-ipconnect.de (EHLO noname) [217.235.41.77]
  by mail.gmx.net (mp067) with SMTP; 26 Jan 2009 12:05:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+rMuxtlBGrDrP0X4RTcPpCEOG09Mpv7PYWGrEfcH
	yNDKOK4FDX4HDy
X-X-Sender: gene099@racer
In-Reply-To: <20090126064004.GA3004@comcast.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107187>

Hi,

On Sun, 25 Jan 2009, Matthew Ogilvie wrote:

> On Sun, Jan 25, 2009 at 02:59:53AM +0100, Johannes Schindelin wrote:
> 
> > On Sat, 24 Jan 2009, Matthew Ogilvie wrote:
> > 
> > >  .gitignore          |    1 +
> > >  Makefile            |   42 +++++++++++++++++++++++++++++++-----------
> > >  t/test-lib.sh       |   14 +++++++++++++-
> > >  test-bin-wrapper.sh |   12 ++++++++++++
> > >  4 files changed, 57 insertions(+), 12 deletions(-)
> > >  create mode 100644 test-bin-wrapper.sh
> > 
> > I am strongly opposed to a patch this big, just for something as 3rd 
> > class as CVS server faking.  We already have a big fallout from all 
> > that bending over for Windows support, and I do not like it at all.
> > 
> > Note: I do not even have to look further than the diffstat to see that 
> > it is wrong.
> > 
> > The point is: if cvsserver wants to pretend that it is in a fake bin 
> > where almost none of the other Git programs are, fine, let's do that 
> > _in the test for cvsserver_.
> 
> Since by default git is installed such that most of the dashed-form 
> commands are not in a user's default PATH, my thought was that it would 
> make sense for the test suite to mimick that environment as much as 
> possible.

This sounds very generic, but you hid it in cvsserver-specific patch 
series.

So maybe I was wrong to assume that this is cvsserver specific, but then, 
you made that mistake rather easy to make.

> This could detect regressions in any installed/tested git script that 
> erroneously assumes the dashed form commands are in the PATH, not just 
> git-cvsserver.

The major point is that these scripts _will_ run if you call _them_ using 
the dash-less form, as GIT_EXEC_PATH will be added to the PATH by the Git 
wrapper.

>     3. Perhaps just use symlinks or hardlinks instead of a wrapper 
>        script.  This might have some promise, except that links are more 
>        likely to fail on windows, and the wrappers generally give you 
>        more flexibility for testing odd scenarios.

Not likely.  Sure as hell.

>     4. The test-bin-wrapper.sh script does not actually need to set 
>        environment variables (GIT_EXEC_DIT and templates) for purposes 
>        of this patch.  But my thought was that in this form you could 
>        run things straight out of the test-bin directory to manually try 
>        out new code without needing to actually install a build or mess 
>        with the environment variables yourself.  It could also be 
>        extended to handle other global wrapper needs relatively easily, 
>        such as valgrind.

Umm.

You missed the valgrind patch series.

Ciao,
Dscho
