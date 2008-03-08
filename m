From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 05/11] Add a library function to add an alternate to the
 alternates file
Date: Sat, 8 Mar 2008 18:22:41 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803081820310.19665@iabervon.org>
References: <alpine.LNX.1.00.0803081804090.19665@iabervon.org> <alpine.LSU.1.00.0803090017150.3975@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 00:23:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8Ny-000503-8Y
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbYCHXWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbYCHXWn
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:22:43 -0500
Received: from iabervon.org ([66.92.72.58]:34165 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642AbYCHXWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 18:22:43 -0500
Received: (qmail 19573 invoked by uid 1000); 8 Mar 2008 23:22:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Mar 2008 23:22:41 -0000
In-Reply-To: <alpine.LSU.1.00.0803090017150.3975@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76618>

On Sun, 9 Mar 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sat, 8 Mar 2008, Daniel Barkalow wrote:
> 
> 
> > +void add_to_alternates_file(const char *reference)
> > +{
> > +	char *file;
> > +	char *alt;
> > +	int fd;
> > +
> > +	file = mkpath("%s/objects/info/alternates", get_git_dir());
> > +	fd = open(file, O_CREAT | O_WRONLY | O_APPEND, 0666);
> > +	if (fd < 0)
> > +		die("failed to create %s", file);
> 
> Even with alternates, which are probably written only rarely, I would have 
> expected a lockfile procedure (if only to be consistent with the rest).

That's a good idea; I started with this inside clone, where you can be 
pretty certain not to get contention (and the shell version is using >> to 
update it), but in the library the lockfile is the right thing to do, so 
that other code can use it safely.

	-Daniel
*This .sig left intentionally blank*
