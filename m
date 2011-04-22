From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: slowness in pulling data to mobile devices using git
Date: Thu, 21 Apr 2011 23:41:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104212332310.24613@xanadu.home>
References: <4DB0B608.5090704@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Qianqian Fang <fangqq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 05:42:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD7G8-0007vZ-7O
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 05:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab1DVDl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 23:41:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33485 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab1DVDl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 23:41:58 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LK1004LPBKVYOA0@vl-mo-mrz24.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Apr 2011 23:41:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4DB0B608.5090704@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171931>

On Thu, 21 Apr 2011, Qianqian Fang wrote:

> hi list
> 
> I am not sure if this is the right place to ask.

Yes, it is.

> I am having some difficulties to speed up synchronization of a large 
> git repo (~4GB) to a mobile phone via USB cable. It appears that the 
> "git pull" command has to read through the entire history to make a 
> single update, even the update is very minor.
> 
> I post my full question at this link:
> 
> http://groups.google.com/group/git-users/browse_thread/thread/9f33536257535b28?hl=en
> 
> does this make sense? is there a way to speed up
> the updating without letting git to do all the file readings?

try doing "git fetch" instead of "git pull".  That should make the 
actual transfer faster without looking at the local checked-out files.

Also, make sure the repository on your SD card is fully packed.  You'll 
need to repack it by mounting the SD card on a PC with sufficient amount 
of RAM.

If the repo is checked out on your SD card, and if it contains a large 
number of files, then any status-like operation (checkout, pull) will 
need to stat every file which may take time on a slow storage link.  
And if your phone changes the dates of those files then Git has no 
choice but to read the entire file in order to determine if the file is 
still the same or not.


Nicolas
