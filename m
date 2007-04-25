From: Gerrit Pape <pape@smarden.org>
Subject: Re: Problem with git-daemon and mmap.
Date: Wed, 25 Apr 2007 07:42:33 +0000
Message-ID: <20070425074233.7494.qmail@076ec8c0ddad74.315fe32.mid.smarden.org>
References: <1177483875.12689.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 09:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgc8p-0004ZG-8x
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 09:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161662AbXDYHmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 03:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161664AbXDYHmQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 03:42:16 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:59571 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1161662AbXDYHmP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 03:42:15 -0400
Received: (qmail 7495 invoked by uid 1000); 25 Apr 2007 07:42:33 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1177483875.12689.22.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45503>

On Wed, Apr 25, 2007 at 04:21:15PM +0930, Tim Ansell wrote:
> I am trying to use git-daemon on a Debian stable machine. We converted
> our repositories from darcs to git using tailor (which seemed to work
> well). Most of the repositories work fine, however our web repository
> which is quite large (about ~126Mb) is causing problems when trying to
> clone via git-daemon.

> The machine as only 512mb of Ram. It isn't running much else apart from
> a few websites served via apache. Here is some more (hopefully useful)

> ii  git-daemon-run                   1.5.1.1-1
> fast, scalable, distributed revision control

> Hopefully this gives you enough information to track down this bug. I'm
> happy to provide more information if needed. I'll also be on #git, but
> I'm in Australia so you might have a hard time catching me.

In the debian package version 1.4.4.4, git-daemon's memory by default is
limited to 64MB.  I changed that with 1.5.0, but maybe you chose to not
accept the changes to the run script when upgrading to 1.5.5.1-1.

Check /var/service/git-daemon/run, if it has 'exec chpst -m64000000
git-daemon ...'.  If so, remove 'chpst -m64000000', and restart the
git-daemon service through 'sv restart git-daemon'.

HTH, Gerrit.
