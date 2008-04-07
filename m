From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn breaks on gtk+ import
Date: Mon, 7 Apr 2008 01:20:07 -0700
Message-ID: <20080407082007.GB28853@soma>
References: <alpine.DEB.1.00.0803071844510.27175@master.birnet.private> <20080308074737.GC1583@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Janik <timj@imendio.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 10:20:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jimb1-0004bd-GG
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbYDGIUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 04:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754420AbYDGIUM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:20:12 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44620 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbYDGIUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 04:20:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 106C47F41D5;
	Mon,  7 Apr 2008 01:20:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080308074737.GC1583@hand.yhbt.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78962>

Eric Wong <normalperson@yhbt.net> wrote:
> Tim Janik <timj@imendio.com> wrote:
> > hi Eric.
> > 
> > with git-svn from git 1.5.4.3, imports of the Gtk+ repository fail:
> > 
> >   git-svn clone -T trunk -b branches -t tags -r 19001 
> >   http://svn.gnome.org/svn/gtk+
> >   Using existing [svn-remote "svn"]
> >   Using higher level of URL: http://svn.gnome.org/svn/gtk+ => 
> >   http://svn.gnome.org/svn/gtk%2B/http:
> >   No such file or directory: PROPFIND request failed on 
> >   '/svn/gtk%252B/http%3A': Could not open the requested SVN filesystem at 
> >   /usr/bin/git-svn line 1352
> > 
> > trying the same for glib works fine:
> > 
> >   git-svn clone -T trunk -b branches -t tags -r 6601 
> >   http://svn.gnome.org/svn/glib
> >   [...]
> >   r6601 = 987f6388b211281d08fce0e63936d9e612ed4d4f (trunk)
> >   Checked out HEAD:
> >     http://svn.gnome.org/svn/glib/trunk r6601
> > 
> > looks like the '+' in the the http://svn.gnome.org/svn/gtk+ repository
> > name isn't handled correctly.
> 
> It's a known bug which I haven't had time to track down and fix.
> 
> git-svn handles files and directories with '+' within the base URL
> you're tracking correctly, but somewhere along the way the base URL
> you're tracking doesn't work correctly for HTTP.
> 
> As Harvey suggested, use the svn:// repository for now.

Hi Tim, the HTTP repository should be fixed with the patch in

  http://article.gmane.org/gmane.comp.version-control.git/78961

-- 
Eric Wong
