From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: Change set based shallow clone
Date: Fri, 08 Sep 2006 10:35:40 +0530
Message-ID: <edqtna$3v6$1@sea.gmane.org>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com> <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 08 07:06:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLYZF-0000sA-Nd
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 07:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbWIHFF7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 01:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbWIHFF6
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 01:05:58 -0400
Received: from main.gmane.org ([80.91.229.2]:51883 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752178AbWIHFF5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 01:05:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLYYr-0000pI-Tp
	for git@vger.kernel.org; Fri, 08 Sep 2006 07:05:53 +0200
Received: from palrel2.hp.com ([156.153.255.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 07:05:53 +0200
Received: from aneesh.kumar by palrel2.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 07:05:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: palrel2.hp.com
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26675>

Junio C Hamano wrote:
> I've been postponing thinking about shallow clones with a plan
> to do so when I have absolutely nothing else to do for a solid
> few days.  Since my time is booked pretty much full with day job
> and the ongoing pack-file topics these days, I will most likely
> stick to that plan after I finish this message.
> 
> Not because I think it is an insignificant problem at the fringe
> (I did not say "when I have nothing better to do"), but because
> I feel this is something important (and hard) that requires
> "think about it and only about it straight through for a few
> days, dropping everything else" kind of thinking.
> 
> When you have a ref under .git/refs/ pointing at an object, you
> are making this assertion:
> 
>         The object store associated with this repository
>         (usually, .git/objects and alternates pointed at by
>         .git/objects/info/alternates) holds _all_ objects that
>         are recursively reachable from this object by following
>         tag reference, commit ancestry chain, commit to its
>         tree, and tree to its subtrees and blobs.
> 
> So by definition, a shallow clone is a broken/incomplete
> repository.  Unless we fix the breakage in some way.
> 
> One way to do so which has often been talked about is to use the
> grafts facility.  You cut off the history at some commit, and
> cauterize the commit ancestry chain at that point by telling git
> to pretend that the commit does not have any parent.  While this
> would work after setting it up, in the sense that "git log"
> would stop at the commit and "git fsck-objects" would say
> nothing is missing, it is cumbersome to set up, we do not have
> an easy way to fetch (or clone -- but clone is a special case of
> fetch where the downstream starts out from emptiness) from such
> a repository, unplugging to get histories further back with
> a later fetch is quite involved, and it is not clear what it
> means to further fetch from such a shallow clone.


Pardon my ignorance, but won't having a http:// or ssh based url support in objects/info/alternates
will support such shallow clones. What i am wondering is can't we make the  objects/info/alternates following code
traverse the network transport and make git log work like cvs log in case things are not in local repository. This
should make all the git operation slow, but if you are interested in speed one can clone the repository fully.

-aneesh 
