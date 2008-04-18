From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH (try 2)] git-svn: fix "Malformed network data" with
	svn:// servers
Date: Fri, 18 Apr 2008 13:25:54 +0000
Message-ID: <20080418132554.3548.qmail@3605a0899cbb1f.315fe32.mid.smarden.org>
References: <20080208162433.25929.qmail@dd8a37fc58824d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 14:42:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmqiR-0003oq-Kd
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 15:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbYDRNch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 09:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbYDRNch
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 09:32:37 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:58721 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752784AbYDRNcg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 09:32:36 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Apr 2008 09:32:35 EDT
Received: (qmail 3549 invoked by uid 1000); 18 Apr 2008 13:25:54 -0000
Content-Disposition: inline
In-Reply-To: <20080208162433.25929.qmail@dd8a37fc58824d.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79881>

On Fri, Feb 08, 2008 at 04:24:33PM +0000, Gerrit Pape wrote:
> On Fri, Sep 07, 2007 at 04:00:40AM -0700, Eric Wong wrote:
> > We have a workaround for the reparent function not working
> > correctly on the SVN native protocol servers.  This workaround
> > opens a new connection (SVN::Ra object) to the new
> > URL/directory.
> 
> Hi, this problem popped up again, please see
>  http://bugs.debian.org/464713
>  
> I can reproduce it with v1.5.4 through
> 
>  $ git svn clone svn://svn.debian.org/chinese/packages/lunar-applet
>  [...]
>  r159 = 010d0b481753bd32ce0255ce433d63e14114d3b6 (git-svn@159)
>  Found branch parent: (git-svn) 010d0b481753bd32ce0255ce433d63e14114d3b6
>  Following parent with do_switch
>  Malformed network data: Malformed network data at /usr/bin/git-svn line
>  2251

Hi, the problem seems to persist, this is 1.5.5:

$ rm -rf lunar-applet && rm -rf lunar-applet &&
  git version &&
  git svn clone svn://svn.debian.org/chinese/packages/lunar-applet 2>&1 |
    tail -n 14
git version 1.5.5
r155 = e99aaa44f7c306d631501b949a0b35be162c1447 (git-svn@159)
        M       debian/copyright
r156 = d94a736d4b89e3f54ca36b0fc827929050a48a5c (git-svn@159)
        M       debian/doc-base
r157 = bf2661df6d35a88ff40a6aea9829fbbc94a5c06b (git-svn@159)
        M       debian/changelog
r158 = 1107cff6309c979751e0841d40b9e2e471694b26 (git-svn@159)
        M       debian/changelog
        M       debian/rules
r159 = 010d0b481753bd32ce0255ce433d63e14114d3b6 (git-svn@159)
Found branch parent: (git-svn) 010d0b481753bd32ce0255ce433d63e14114d3b6
Following parent with do_switch
Malformed network data: Malformed network data at /usr/bin/git-svn line 2270


I can't to suggest a fix, sorry.

Thanks, Gerrit.
