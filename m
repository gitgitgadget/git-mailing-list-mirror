From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 22:11:42 +0200
Message-ID: <4d8e3fd30808221311w7c507abboecd0893def85a073@mail.gmail.com>
References: <20080822174655.GP23334@one.firstfloor.org>
	 <alpine.LFD.1.10.0808221053080.3487@nehalem.linux-foundation.org>
	 <20080822182718.GQ23334@one.firstfloor.org>
	 <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andi Kleen" <andi@firstfloor.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:13:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWd03-0001Sv-0B
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 22:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857AbYHVULp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756429AbYHVULo
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 16:11:44 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:51341 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbYHVULn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 16:11:43 -0400
Received: by yx-out-2324.google.com with SMTP id 8so388282yxm.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Y56spUT0rCzuk69X90tVbtiHnBzZWdCVUbcpl98atx4=;
        b=Df7sIpN1SBijyxHncIuyc2qp4vqA0N/U+b6Blkr/fGcU90EzQfbkA5citLceLhQY2J
         3R0SDXy9s4xNLnnqPtnNnb3EvciNUILXZHwwDiwwDI1LgfRAzYrXXOH9W25f+k0AI5wq
         399YMwUZj/3WFrttwMPvRXd81DdKJ6bvbCiPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=YOa/AIzsvmQNDeyYmB+lw+Y+u8iTH3nA4CcG2sztZaEwFI6IIM/qSZivggp7WBnist
         HRZ+TpABekEAIdylRAgZ6GZpisyJ3wSCH4TUCcvQE8wQf0pNSJm+/daiLRu3B4svOXe2
         B+4hxk15uiShwlfr3vtfJUgydaCcgIFa7PdsU=
Received: by 10.142.163.13 with SMTP id l13mr538732wfe.265.1219435902194;
        Fri, 22 Aug 2008 13:11:42 -0700 (PDT)
Received: by 10.142.194.8 with HTTP; Fri, 22 Aug 2008 13:11:42 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0808221233100.3487@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93355>

On Fri, Aug 22, 2008 at 9:36 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Fri, 22 Aug 2008, Andi Kleen wrote:
>>
>> Well git fetch does nothing by itself.
>
> Git fetch does exactly what it should do by itself.
>
> If you think it does "nothing", you're really confused.
>
> It updates the "remote" branches - the ones you are downlaoding.
>
>> Sorry that's what I though initially too. But that's wrong.  Just clone
>> e.g. linux-next and then try to update it with pull a day later.
>
> You SHOULD NOT DO THAT!
>
> linux-next is not a tree that you can track. It's a tree that you can
> fetch _once_ and then throw away.
>
> So what you can do is to "fetch" linux-next, and test it. But you MUST
> NEVER EVER use it for anything else. You can't do development on it, you
> cannot rebase onto it, you can't do _anything_ with it.
>
> So what you can do is to "git fetch" it (to download it), and then "git
> checkout" to create a temporary checkout. That's pretty much all you can
> do with linux-next.

Linus,
sorry for the double posting.

I agree, but I would like to point out a typical use case:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
git remote add tip
git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
git remote update (to fetch both the trees, now i can "track" your
branch with a simple merge which will results in a fast forward)
git checkout -b tip-latest tip/master

since tip/master is often rebased (as pu or linux-next) what I do is
the following:
git branch -D tip-latest
git checkout -b tip-latest tip/master

but I guess lot of people would expect to "throw away" and "checkout
again" with a single git command.

Does it make sense?

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
