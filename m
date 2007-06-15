From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-repack made my pack 317x larger...
Date: Fri, 15 Jun 2007 09:39:19 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706150935530.5651@xanadu.home>
References: <20070615085057.5706.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Jun 15 15:39:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzC1M-0008Bo-3n
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 15:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbXFONjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 09:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbXFONjW
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 09:39:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36751 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbXFONjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 09:39:21 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJO0080AJ9J8RD0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 15 Jun 2007 09:39:19 -0400 (EDT)
In-reply-to: <20070615085057.5706.qmail@science.horizon.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50260>

On Fri, 15 Jun 2007, linux@horizon.com wrote:

> > ~/tmp$ git clone --reference /usr/src/linux -n hwmon-2.6.old hwmon-2.6
> > Initialized empty Git repository in /home/linux/tmp/hwmon-2.6/.git/
> > remote: Generating pack...
> > remote: Done counting 124 objects.
> > remote: Deltifying 124 objects...
> > remote:  100% (124/124) done
> > Indexing 124 objects...
> > remote: Total 124 (delta 83), reused 97 (delta 75)
> >  100% (124/124) done
> > Resolving 83 deltas...
> >  100% (83/83) done
> > ~/tmp$ rm -rf hwmon-2.6.olf
> > ~/tmp$ cd hwmon-2.6
> > ~/tmp/hwmon-2.6$ ls -l .git/objects/pack/
> > total 168
> > -r--r--r-- 1 linux users   4040 Jun 15 03:44 pack-e4de475aa6c82099b4a4a8f6f410dcc316c7cf19.idx
> > -r--r--r-- 1 linux users 161548 Jun 15 03:44 pack-e4de475aa6c82099b4a4a8f6f410dcc316c7cf19.pack
> 
> Much better!  But since that's only a few objects, let's repack them even tighter...
> 
> > ~/tmp/hwmon-2.6$ git-repack -a -d -f --window=50
> > Generating pack...
> > Done counting 18090 objects.
> > Deltifying 18090 objects...
> >  100% (18090/18090) done
> > Writing 18090 objects...
> >  100% (18090/18090) done
> > Total 18090 (delta 2465), reused 7876 (delta 0)
> > Pack pack-1af4ab6620f71733f17b16d69a89b6741e2c7fe3 created.
> > Removing unused objects 100%...
> > Done.
> > ~/tmp/hwmon-2.6$ ls -l .git/objects/pack/
> > total 50620
> > -r--r--r-- 1 linux users   435224 Jun 15 04:00 pack-1af4ab6620f71733f17b16d69a89b6741e2c7fe3.idx
> > -r--r--r-- 1 linux users 51333891 Jun 15 04:00 pack-1af4ab6620f71733f17b16d69a89b6741e2c7fe3.pack
> 
> Uh... what happened?  It's not a full kernel clone, but it's a lot more
> objects than I expected.  Where did all the extra objects come from?

Maybe you want to add -l as well to your git-repack invocation.


Nicolas
