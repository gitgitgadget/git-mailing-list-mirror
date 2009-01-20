From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
 #04; Mon, 19)
Date: Tue, 20 Jan 2009 15:50:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302>
 <20090120141932.GB10688@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 15:52:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPHxS-0007d7-I2
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 15:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196AbZATOuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 09:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755870AbZATOui
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 09:50:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:51707 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755867AbZATOuh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 09:50:37 -0500
Received: (qmail invoked by alias); 20 Jan 2009 14:50:35 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp015) with SMTP; 20 Jan 2009 15:50:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+nllRoFjSnWjErWKIPCiLz0q33lYOqwjNd9461UF
	tiLl4a7dWs6yLn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090120141932.GB10688@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106478>

Hi,

On Tue, 20 Jan 2009, Jeff King wrote:

> On Tue, Jan 20, 2009 at 02:51:49PM +0100, Johannes Schindelin wrote:
> 
> > > I think creating it inside the trash directory for each test run 
> > > that wants to use valgrind makes more sense (probably as 
> > > .git/valgrind, which is unlikely to hurt anything but will stay out 
> > > of the way of most of the tests).
> > 
> > Here I disagree.  But I think that test-lib.sh should create it 
> > on-demand, and it should traverse all executables in all paths listed 
> > in $PATH, replacing the ones that start with "git-" ("git" itself 
> > should be the first one) that are no scripts by symlinks to the 
> > valgrind script (which should therefore live in t/), and those that 
> > _are_ scripts by symlinks to $GIT_ROOT/$NAME.
> 
> How will you deal with race conditions between two simultaneously 
> running scripts? I.e., where are you going to put it?

There are no race conditions, as for every git executable, a symbolic link 
is created, pointing to the valgrind.sh script [*1*].

Besides, what with valgrind being a memory hog, you'd be nuts to call 
valgrinded scripts simultaneously.

Ciao,
Dscho

[*1*] Before anybody complains about symbolic links not being available on 
Windows, or $GIT_SHELL not being heeded by the valgrind.sh script: get 
valgrind to compile on those platforms, and _then_ we'll talk again.
