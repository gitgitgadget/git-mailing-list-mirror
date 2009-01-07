From: Nicolas Pitre <nico@cam.org>
Subject: Re: Problems getting rid of large files using git-filter-branch
Date: Tue, 06 Jan 2009 19:56:07 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901061948590.26118@xanadu.home>
References: <c09652430901061359q7a02291fk656ab23e54b19f5e@mail.gmail.com>
 <alpine.LFD.2.00.0901061709510.26118@xanadu.home>
 <20090106231726.GB13379@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: ?yvind Harboe <oyvind.harboe@zylin.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jan 07 01:58:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKMkQ-0005R5-82
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 01:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbZAGA4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 19:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753488AbZAGA4t
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 19:56:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61308 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbZAGA4t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 19:56:49 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KD2003TLT9JAYP0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Jan 2009 19:56:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090106231726.GB13379@cuci.nl>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104742>

On Wed, 7 Jan 2009, Stephen R. van den Berg wrote:

> Nicolas Pitre wrote:
> >On Tue, 6 Jan 2009, ?yvind Harboe wrote:
> >OK, try this:
> 
> >	git pull file://$(pwd)/../my_repo.orig
> 
> Alternately, try:
> 
> rm -rf .git/ORIG_HEAD .git/FETCH_HEAD .git/index .git/logs .git/info/refs \
>   .git/objects/pack/pack-*.keep .git/refs/original .git/refs/patches \
>   .git/patches .git/gitk.cache &&
>  git prune --expire now &&
>  git repack -a -d --window=200 &&
>  git gc

This might not be sufficient.  Or at least you better run 'git prune' at 
the very end, and possibly add -f to 'git repack'.  And if you somehow 
delete something you shouldn't have deleted then you're really screwed, 
whereas the pull method in another repository doesn't alter the original 
repository in case you need to go back to it and try something 
different.


Nicolas
