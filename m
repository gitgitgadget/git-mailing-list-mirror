From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: cg-update with local uncommitted changes
Date: Tue, 31 May 2005 21:11:21 +0200
Message-ID: <429CB6D9.8060204@gmail.com>
References: <1117463114.7072.185.camel@pegasus> <20050530183932.GB10439@pasky.ji.cz> <1117480796.7072.204.camel@pegasus> <d7g430$1cq$1@sea.gmane.org> <20050531155825.GA7013@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue May 31 21:16:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdCCY-00058k-Kv
	for gcvg-git@gmane.org; Tue, 31 May 2005 21:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVEaTRU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 15:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVEaTRU
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 15:17:20 -0400
Received: from main.gmane.org ([80.91.229.2]:6087 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261339AbVEaTOd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 15:14:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DdC7q-0004Yj-FP
	for git@vger.kernel.org; Tue, 31 May 2005 21:10:06 +0200
Received: from h65n2fls35o265.telia.com ([217.211.115.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 May 2005 21:10:06 +0200
Received: from holmsand by h65n2fls35o265.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 31 May 2005 21:10:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h65n2fls35o265.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <20050531155825.GA7013@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Tue, May 31, 2005 at 12:31:28AM CEST, I got a letter
> where Dan Holmsand <holmsand@gmail.com> told me that...
>>This patch would make cg-merge and cg-admin-uncommit refuse to do 
>>anything if there are conflicting uncommitted changes. Note: this only 
>>applies to fast-forward merging, as cg-merge otherwise bails out if 
>>there are *any* uncommitted changes (which is perhaps going to far).
> 
> 
> Well, non-fast-forward cg-merge will do cg-commit and it would blend the
> unrelated previously uncommitted changes into that, which is not what
> you want.

cg-merge should obviously only commit the files touched by the 
"slow-forward" merge (note: this is not a big deal for me, I have no 
problem with cogito saying "no" once too often. It's when it tries and 
fails that trouble starts).

>>[PATCH] Make tree_timewarp safe, by refusing to handle conflicts.

> I don't really think this makes any sense. What do you then do when you
> want to do some merging of the local uncommitted changes and upstream
> update?

I've never really wanted to do that. I commit, then merge.

> How have you been bitten, and how could we destroy the local changes?
> You get rejects and patch will be pretty vocal about it, so then you
> just go and resolve them. The correct direction is to make it do a
> three-way merge, not make it do no merge at all.

Huh? When I get to the patch rejects, the merge will have happened and 
the local changes pretty much be gone forever. And it's really easy to 
miss the .rej files altogether.

I'd much prefer not having to worry before doing cg-merge/update, then 
to have to salvage old stuff from .rej files. And three-way merges don't 
really solve this; they may work more often, but when they fail, data is 
potentially lost. Why take the chance?

/dan

