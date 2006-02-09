From: Greg KH <greg@kroah.com>
Subject: Re: Handling large files with GIT
Date: Wed, 8 Feb 2006 20:54:20 -0800
Message-ID: <20060209045420.GB15924@kroah.com>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com> <87slqty2c8.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 05:55:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F73pb-0006gF-Ck
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 05:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422797AbWBIEyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 23:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422798AbWBIEyy
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 23:54:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:54681 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422797AbWBIEyy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 23:54:54 -0500
Received: from [192.168.0.10] (dsl093-040-174.pdx1.dsl.speakeasy.net [66.93.40.174])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id k194slK02144;
	Wed, 8 Feb 2006 20:54:47 -0800
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1F73oy-4BP-00; Wed, 08 Feb 2006 20:54:20 -0800
To: Florian Weimer <fw@deneb.enyo.de>
Content-Disposition: inline
In-Reply-To: <87slqty2c8.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15787>

On Wed, Feb 08, 2006 at 10:20:39PM +0100, Florian Weimer wrote:
> * Martin Langhoff:
> 
> > SVN does reasonably well tracking his >1GB mbox file. Now, I don't
> > know if I like the idea of putting my own mbox file under version
> > control, but it looks like projects with large and slow-changing files
> > would be in trouble with GIT.
> 
> To my surprise, it's not that bad.  The Debian testing-security team
> uses a single 1.8 MB file (400 KB compressed) to keep vulnerability
> data.  Most changes to that file involve just a few lines.  But even
> in this extreme case, git doesn't compare too badly against Subversion
> if you pack regularly (but not too often).  Disk usage is actually
> *below* Subversion FSFS even with --depth=10 (the default,
> unfortunately a bit hard to override).

I have a project that has 2.5Mb files, and git handles them just fine,
even on my old slow laptop.

But when I tried to use it to backup my old email archive a few months
ago, running about 2Gb in about 300 files, it took forever.  Luckily I
only archive stuff off every other month or so, otherwise it would be
unusable.

However, I did notice one problem.  When cloning from one machine to
another, for a project that is already fully packed, it seems that the
whole project is packed again before sending it accross the wire.  With
an archive this big, that takes over an hour for my slow old fileserver.
I ended up just rsyncing over the files and pointing the parent back to
the original.  Is there anyway to not repack everything if it's not
needed?

thanks,

greg k-h
