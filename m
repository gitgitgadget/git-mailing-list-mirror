From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 16:27:00 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809111604040.23787@xanadu.home>
References: <20080909235848.GE7459@cuci.nl>
 <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
 <20080910054244.GB15715@cuci.nl>
 <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org>
 <20080910230906.GD22739@cuci.nl>
 <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org>
 <20080911062242.GA23070@cuci.nl>
 <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org>
 <20080911192356.GC1451@cuci.nl>
 <alpine.LFD.1.10.0809111534300.23787@xanadu.home>
 <20080911195516.GE1451@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 22:28:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdsm1-0002aG-T7
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 22:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbYIKU1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 16:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbYIKU1J
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 16:27:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15874 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYIKU1H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 16:27:07 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K71005B1ST0PN90@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 11 Sep 2008 16:27:00 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080911195516.GE1451@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95643>

On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:

> Nicolas Pitre wrote:
> >On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
> >> when doing things with temporary branches.  The origin field is meant to
> >> be filled *ONLY* when cherry-picking from one permanent branch to
> >> another permanent branch.  This is a *rare* operation.
> 
> >... and therefore you might as well just have a separate file (which 
> >might or might not be tracked by git like the .gitignore files are) 
> >to keep that information?  Since this is a rare operation, modifying the 
> >core database structure for this doesn't appear that appealing to most 
> >so far.
> 
> For various reasons, the best alternate place would be at the trailing
> end of the free-form field.  Using a separate structure causes
> (performance) problems (mostly).

Did you try it?  I don't particularly buy this performance argument, and 
the bulk of my contributions to git so far were about performances.  It 
is quite easy to load a flat file with sorted commit SHA1s, and given 
that origin links are the result of a rare operation, then there 
shouldn't be too many entries to search through.  Hell, doing 213647 
lookups (and many other things like inflating zlib deflated data)  with 
each of them for commit objects in my Linux repository which has 1355167 
total entries takes only 6 seconds here, or about a quarter of a 
milisecond for each lookup.  I doubt doing an extra lookup in a much 
smaller table would show on the radar.


Nicolas
