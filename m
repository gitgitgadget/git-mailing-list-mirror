From: Christopher Faylor <me@cgf.cx>
Subject: Re: Cygwin git and windows network shares
Date: Fri, 16 Jun 2006 21:23:38 -0400
Message-ID: <20060617012338.GB23924@trixie.casa.cgf.cx>
References: <4492AAFA.20807@grin.se> <17554.48926.852000.679014@lapjr.intranet.kiel.bmiag.de> <20060616221014.GA22181@trixie.casa.cgf.cx> <20060616223006.GA23737@trixie.casa.cgf.cx> <17555.21858.292000.494454@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 17 03:23:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrPXU-0005fV-Qf
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 03:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWFQBXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 21:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWFQBXj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 21:23:39 -0400
Received: from pool-71-248-179-97.bstnma.fios.verizon.net ([71.248.179.97]:63409
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S1751042AbWFQBXj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 21:23:39 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id B8AE813C01F; Fri, 16 Jun 2006 21:23:38 -0400 (EDT)
To: git@vger.kernel.org, Juergen Ruehle <j.ruehle@bmiag.de>
Content-Disposition: inline
In-Reply-To: <17555.21858.292000.494454@lapjr.intranet.kiel.bmiag.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21992>

On Sat, Jun 17, 2006 at 03:05:38AM +0200, Juergen Ruehle wrote:
>Christopher Faylor writes:
> > I also meant to ask if there was an i is nonzero after the call to the
> > rename() above?  If so, what was the errno?  If not, it is a huge
> > problem if rename is reporting that it is able to rename a file but is
> > not actually doing it.
>
>After some testing the conclusion is that it's not lying, but only
>failing in interesting ways on my (and seemingly also Niklas') system:
>
> - rename on NTFS succeeds (and returns 0)
>
> - rename on FAT32 succeeds if target does not exist (and returns 0)
>
>   rename on FAT32 fails if target exists with EACCESS
>
>   (manual mv on commandline works)
>
> - rename on a network share always hangs for a while and then fails
>   with EBUSY (even if target does not exist)
>
>   (share served by XP, tested both NTFS and FAT32)
>
>   (manual mv still works)
>
>Various combinations of server, ntsec, and smbntsec didn't seem to
>make a difference; /etc/{passwd,group} have been freshly created.

Thanks.  I really appreciate the details.  I've passed them on to the
last person to touch the rename code.

cgf
