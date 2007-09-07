From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: fix "Malformed network data" with svn:// servers
Date: Fri, 7 Sep 2007 03:07:11 -0700
Message-ID: <20070907100711.GA24166@muzzle>
References: <20070626133704.24521.qmail@a4f750d1ddce1f.315fe32.mid.smarden.org> <20070704210526.GA9582@muzzle> <20070807134220.23420.qmail@c96e4a6cce1e57.315fe32.mid.smarden.org> <20070907073424.GA16468@mayonaise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 430091@bugs.debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 12:07:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITakE-0003Kv-0t
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 12:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbXIGKHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 06:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbXIGKHQ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 06:07:16 -0400
Received: from hand.yhbt.net ([66.150.188.102]:33278 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964859AbXIGKHP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 06:07:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E61252DC08D;
	Fri,  7 Sep 2007 03:07:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070907073424.GA16468@mayonaise>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58013>

Eric Wong <normalperson@yhbt.net> wrote:
> We have a workaround for the reparent function not working
> correctly on the SVN native protocol servers.  This workaround
> opens a new connection (SVN::Ra object) to the new
> URL/directory.
> 
> Since libsvn appears limited to only supporting one connection
> at a time, this workaround invalidates the Git::SVN::Ra object
> that is $self inside gs_fetch_loop_common().  So we need to
> restart that connection once all the fetching is done for each
> loop iteration to be able to run get_log() successfully.
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>

Actually, drop this for now.  Seems to cause the SVN to block
when doing do_switch() again...

-- 
Eric Wong
