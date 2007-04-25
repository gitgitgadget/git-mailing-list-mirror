From: Gerrit Pape <pape@smarden.org>
Subject: Re: Problem with git-daemon and mmap.
Date: Wed, 25 Apr 2007 08:11:36 +0000
Message-ID: <20070425081136.9611.qmail@f75c6e4144fd72.315fe32.mid.smarden.org>
References: <1177483875.12689.22.camel@localhost> <20070425074233.7494.qmail@076ec8c0ddad74.315fe32.mid.smarden.org> <1177488073.12689.30.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 10:12:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgcbu-00071M-4J
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 10:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161853AbXDYILZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 04:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161848AbXDYILY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 04:11:24 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:59659 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1161847AbXDYILQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 04:11:16 -0400
Received: (qmail 9612 invoked by uid 1000); 25 Apr 2007 08:11:36 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1177488073.12689.30.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45509>

On Wed, Apr 25, 2007 at 05:31:13PM +0930, Tim Ansell wrote:
> > In the debian package version 1.4.4.4, git-daemon's memory by default is
> > limited to 64MB.  I changed that with 1.5.0, but maybe you chose to not
> > accept the changes to the run script when upgrading to 1.5.5.1-1.
> > 
> > Check /var/service/git-daemon/run, if it has 'exec chpst -m64000000
> > git-daemon ...'.  If so, remove 'chpst -m64000000', and restart the
> > git-daemon service through 'sv restart git-daemon'.

> It appears that after upgrading the git-daemon-run from 1.4.4 to 1.5.1,
> I didn't do a "sv restart git-daemon".

Probably the package upgrade should have done this for you, my fault.

> After running the command I can now do a checkout form the web
> repository, yay!
> 
> It appears to use 128m of virtual memory when checking out the
> repository (which is why it would be hitting the 64Mb limit).
> 
> Would adding a "chpst -m256000000" be a good idea?

I personally think so, yes, limiting the memory for long running
processes (services) generally is a good idea.  But finding a good
default for git-daemon isn't easy, as it depends on the repositories it
serves, and requires lots of memory per se.  So on Debian, it's now
unlimited by default.

Regards, Gerrit.
