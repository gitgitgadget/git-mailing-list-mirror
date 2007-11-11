From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t7005 and vi in GIT_EXEC_PATH
Date: Sun, 11 Nov 2007 16:28:39 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111622350.4362@racer.site>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
 <Pine.LNX.4.64.0711111557370.4362@racer.site>
 <FCFF59B3-D3F1-4BEB-B3C3-D07DD5D5D8EF@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrFgN-00026l-Q7
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 17:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbXKKQ2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 11:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbXKKQ2v
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 11:28:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:59690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752337AbXKKQ2u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 11:28:50 -0500
Received: (qmail invoked by alias); 11 Nov 2007 16:28:49 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp054) with SMTP; 11 Nov 2007 17:28:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/elVRrVD3eXR0/CYmB5ooFVsgSqz4C2ABQgSXGfy
	RE/PfkqScRYNJx
X-X-Sender: gene099@racer.site
In-Reply-To: <FCFF59B3-D3F1-4BEB-B3C3-D07DD5D5D8EF@silverinsanity.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64472>

Hi,

On Sun, 11 Nov 2007, Brian Gernhardt wrote:

> On Nov 11, 2007, at 10:58 AM, Johannes Schindelin wrote:
> 
> > > If vi is in GIT_EXEC_PATH, then t7005-editor.sh fails because the 
> > > real vi is invoked instead of the test vi script.  This is because 
> > > the git wrapper puts GIT_EXEC_PATH ahead of ".".  I see no easy 
> > > solution to this problem, and thought I should bring it up with the 
> > > list.
> > 
> > I don't understand.  GIT_EXEC_PATH should be set to the build 
> > directory when you are running the tests.  Unless you copy vi _there_, 
> > you should not have any problem.
> 
> I'm sorry, I should have been more clear.  I was referring to the 
> GIT_EXEC_PATH build variable, not the environment variable.  The git 
> wrapper always adds the path determined during build to the front of 
> PATH.  When I was changing my build script, this got set to 
> "/usr/local/bin" (I usually use /usr/local/stow/git, instead).  Since I 
> have a /usr/local/bin/vim, PATH for git-commit.sh during the test was:
> 
> - my git build directory
> - /usr/local/bin (containing a symlink vi -> vim)
> - the t/trash directory, added by the test via `PATH=".:$PATH"` (containing
> the test vi script)
> - my normal path
> 
> The test appeared to hang when running it normally.  When I ran it with 
> -v, I saw that vim was started.

The obvious solution would be to copy "vi" into the git build directory 
for the test, or skip the test if that copy could not be performed.

Ciao,
Dscho
