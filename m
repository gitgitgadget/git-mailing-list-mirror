From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 16:00:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504191557410.26365@qynat.qvtvafvgr.pbz>
References: <200504191250.10286.mason@suse.com><Pine.LNX.4.58.0504191017300.19286@ppc970.osdl.org><200504191412.00227.mason@suse.com><Pine.LNX.4.58.0504191143220.19286@ppc970.osdl.org><Pine.LNX.4.62.0504191508060.26365@qynat.qvtvafvgr.pbz>
 <Pine.LNX.4.58.0504191514550.2274@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:57:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1eg-0000QC-6H
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVDSXBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVDSXBE
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:01:04 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:6390 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261729AbVDSXAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 19:00:21 -0400
Received: from sacims01.digitalinsight.com by warden3.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Tue, 19 Apr 2005 16:00:19 -0700
Received: by sacexc01.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <JDH1CN15>; Tue, 19 Apr 2005 16:00:06 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id JDHHA6JZ; Tue, 19 Apr 2005 16:00:04 -0700
To: Linus Torvalds <torvalds@osdl.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.58.0504191514550.2274@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Apr 2005, Linus Torvalds wrote:

> On Tue, 19 Apr 2005, David Lang wrote:
>>
>> what if you turned the forest of quilt patches into a forest of git trees?
>> (essentially applying each patch against the baseline seperatly) would
>> this make sense or be useful?
>
> It has a certain charm, but the fact is, it gets really messy to sort out
> later.
>
> The thing is, there's a huge benefit to a straight-line tree: you can do
> binary searching etc of patches that cause problems, and in general it's
> just a lot _easier_ to work with a linear set of patches for pretty much
> everybody.
>
> So yes, it's "cool" to show the fact that patches are independent and show
> them as each applying to the baseline (and then you can have the "mother
> of all merges" that ties them all together), but that's just a _nightmare_
> when you actually try to debug things and sort things out.
>
> So while I'm a huge proponent of parallell development, and having lots of
> branches, I actually think that _linearizing_ stuff is a good thing.
>
> So let's put it this way: parallel development and merging is wonderful as
> a tool to handle true distributed development, and it's the thing that GIT
> really tries to do. But once you have "local" development (like in a set
> of quilt patches), the _last_ thing you want to do is try to make it look
> parallel. You're much better off picking a good order, and sticking with
> it. Because otherwise, 2 months down the line, you'll just look at that
> tree, and what you'll want to do is to visualize them linearly anyway.

if you are useing quilt for locally developed patches I fully agree with 
you, but I was thinking of the case where Andrew is receiving independant 
patches from lots of people and storing them in quilt for testing, and 
then sending them on to you. In this case the patches really are 
independant and it may be useful to continue to treat them this way 
instead of collapsing them into one 'update from Andrew' feed.

I don't know if this sort of thing happens enough to matter or not.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
