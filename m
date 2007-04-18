From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 08:26:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704180822270.4684@beast.quantumfyre.co.uk>
References: <20070417161720.GA3930@xp.machine.xx>
 <Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
 <20070418055215.GA32634@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 09:26:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1He4Ys-0005YP-2y
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 09:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbXDRH0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 03:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932840AbXDRH0i
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 03:26:38 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:46830 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932808AbXDRH0i (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2007 03:26:38 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id DF4FAC629F
	for <git@vger.kernel.org>; Wed, 18 Apr 2007 08:26:36 +0100 (BST)
Received: (qmail 23981 invoked by uid 103); 18 Apr 2007 08:25:29 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3112. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.035571 secs); 18 Apr 2007 07:25:29 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 18 Apr 2007 08:25:29 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070418055215.GA32634@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44866>

On Wed, 18 Apr 2007, Peter Baumann wrote:

> On Tue, Apr 17, 2007 at 10:55:17PM +0100, Julian Phillips wrote:
>>  On Tue, 17 Apr 2007, Peter Baumann wrote:
>>
>>> running git-gc or git-gc --prune isn't save because e.g. all the tags
>>> are packed and .git/packed-refs isn't shared on the several workdirs.
>>
>>  Do you mean that the link wasn't created?  Or that the link was removed and
>>  replaced with a file when you ran gc from a workdir?
>>
>
> The problem is, when I created the new workdir, I don't have a file
> .git/packed-refs, so a new workdir was created with a dangling symlink,
> e.g.  workdir/.git/packed-refs -> repo/.git/packed-refs (but the last one
> doesn't exist). As it seems, git gc removes the dangling symlink and
> replaces it with a file.
>
> Steps to reproduce (written in this mail; after /usr/bin/script gave me an
> output whith color coded text *GRR* in ASCII squences):
>
> 	mkdir a && cd a && git init
> 	echo 1 > file.txt
> 	git add file.txt
> 	git commit -m "file added"
> 	git tag v0
> 	cd ..
>
> 	git-new-workdir a b
> 	cd b && git-gc
>
>
> Oh. Wait. Just forget that theorie about dangling symlink. git-gc replaces
> the symlink in a new workdir with a file. Just confirmed that.
>
> So it isn't save to run git-gc in a workdir.

True.  I don't think that it would be a good idea to run any purely 
repository type commands in a workdir.

-- 
Julian

  ---
You know you're using the computer too much when:
you call a doctor a "virus scanner"
 	-- Lews_Therin
