From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Wed, 4 May 2005 12:12:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0505041202270.22203@cag.csail.mit.edu>
References: <200505030657.38309.alonz@nolaviz.org>
 <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
 <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
 <200505041156.19499.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 18:08:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTMOz-0002Hn-Lp
	for gcvg-git@gmane.org; Wed, 04 May 2005 18:07:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVEDQNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 12:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVEDQNg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 12:13:36 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:19693 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261871AbVEDQNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 12:13:34 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DTMUY-0005wf-00; Wed, 04 May 2005 12:12:54 -0400
To: Chris Mason <mason@suse.com>
In-Reply-To: <200505041156.19499.mason@suse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 4 May 2005, Chris Mason wrote:

> 3) create a git-pack tool that can pack/unpack existing changesets,trees and
> files, optionally adding/removing deltas.

A 'git-pull' tool might be more use.  I can imagine Linus maintaining his 
local tree uncompressed, but the 'kernel.org' tree set up to 
git-pull-delta from him every hour or whatever, so that the 
network-accessible version is always network-efficient.  'git-pack'
would then simplify to a git-pull-delta from an existing local repository.

Ideally, you'd also be able to git-pull from a network packed repository 
and (transparently) unpack and undelta-fy the pulled files as they're 
added to your local repo.  This would keep Linus from accidentally getting 
packed files in his tree when he pulled from a maintainer's 
packed/delta-ed network-accessible tree.

I'd also be interested in seeing the speed/space numbers for some other 
delta chain lengths between 1 and 16.  Maybe some intermediate point is 
optimal.  [Also, limiting delta chains to a certain number of other 
*packed* objects -- instead of just 'objects' -- might be an improvement. 
Right now you're packing entire commits together, right?  Maybe defining a 
delta chain as 'N other commits max' might improve i/o performance, as 
you'd just have to keep N other unpacked files around, instead of an 
arbitrary number.]
  --scott

SSBN 743 BOND ESGAIN SUMAC ZPSECANT MHCHAOS Castro Flintlock payment 
anthrax SCRANTON PLO MKNAOMI DNC AVBLIMP RUFUS Secretary AK-47 Noriega
                          ( http://cscott.net/ )
