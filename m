From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sat, 9 Feb 2008 23:05:51 +0100
Organization: glandium.org
Message-ID: <20080209220551.GA30139@glandium.org>
References: <200802081828.43849.kendy@suse.cz> <alpine.LFD.1.00.0802081250240.2732@xanadu.home> <200802091525.36284.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Jan Holesovsky <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Sat Feb 09 23:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNxq7-0005Is-UW
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 23:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbYBIWFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 17:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755712AbYBIWFv
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 17:05:51 -0500
Received: from vuizook.err.no ([85.19.215.103]:43143 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755595AbYBIWFu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 17:05:50 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNxqO-00073n-Ff; Sat, 09 Feb 2008 23:06:50 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNxpX-0007sM-4t; Sat, 09 Feb 2008 23:05:51 +0100
Content-Disposition: inline
In-Reply-To: <200802091525.36284.kendy@suse.cz>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73271>

On Sat, Feb 09, 2008 at 03:25:35PM +0100, Jan Holesovsky wrote:
> Hi Nicolas,
> 
> On Friday 08 February 2008 19:03, Nicolas Pitre wrote:
> 
> > > I've provided a git import of OOo with the entire history; the problem is
> > > that the pack has 2.5G, so it's not too convenient to download for casual
> > > developers that just want to try it.
> >
> > How did you repack your repository?
> >
> > We know that current defaults are not suitable for large projects.  For
> > example, the gcc git repository shrinked from 1.5GB pack down to 230MB
> > after some tuning.
> 
> After the suggestions in this thread I tried to experiment with the --window 
> and --depth options of git-repack, and indeed, there are still reserves.
> 
> So far I'm at 2G (saved 500M), unfortunately the aggressive values like 
> --window=250 --depth=250 that someone mentioned here cause out-of-memory on a 
> machine with 8G :-(. If there's anybody brave enough here to try as well, I'd 
> be grateful.  Maybe it would be also interesting to _exactly_ locate what 
> causes the oom, and eg. exclude the object from the pack if possible.

Speaking of which, I haven't taken a look at builtin-pack-objects.c deep
enough but shouldn't it be possible to do prepare_pack and
write_pack_file in one pass ?

Mike
