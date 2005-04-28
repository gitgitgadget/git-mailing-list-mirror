From: Dave Jones <davej@redhat.com>
Subject: Re: diff against a tag ?
Date: Thu, 28 Apr 2005 18:06:26 -0400
Message-ID: <20050428220626.GC15706@redhat.com>
References: <20050428200953.GD8514@redhat.com> <7vpswe7hvj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504281358060.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 00:02:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRH4z-0008LD-Nl
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 00:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVD1WGt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVD1WGt
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:06:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6547 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262282AbVD1WGd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 18:06:33 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j3SM6Q3M026462;
	Thu, 28 Apr 2005 18:06:26 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j3SM6QO10185;
	Thu, 28 Apr 2005 18:06:26 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j3SM6Q0R021040;
	Thu, 28 Apr 2005 18:06:26 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j3SM6QSe021033;
	Thu, 28 Apr 2005 18:06:26 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504281358060.18901@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2005 at 02:01:40PM -0700, Linus Torvalds wrote:
 > 
 > 
 > On Thu, 28 Apr 2005, Junio C Hamano wrote:
 > > 
 > > Depends on your definition of today, but with the patch below I
 > > sent today, you can say "diff-tree -p $tag $(cat .git/HEAD)".
 > 
 > I think Dave was wondering how to _find_ the tag in the first place, which 
 > is a different issue.

Indeed. Sorry if I was unclear.

 > Right now fsck is the only thing that reports tags that aren't referenced 
 > some other way. Once you know the tag, things are easy - even without 
 > Junio's patch you can just do
 > 
 > 	object=$(cat-file tag $tag | sed 's/object //;q')
 > 
 > and then you can just do
 > 
 > 	diff-tree $object $(cat .git/HEAD)
 > 
 > or whatever you want to do.
 > 
 > Dave: do a "fsck --tags" in your tree, and it will talk about the tags it
 > finds. Then you can create files like .git/refs/tags/v2.6.12-rc2 that
 > contain pointers to those tags..

Groovy. Is it 'THE LAW' that the first one it reports will always be
the most recent tag ?

Hmm, in a fresh rsync from your kernel tree, I get this..
tagged commit a2755a80f40e5794ddc20e00f781af9d6320fafb (v2.6.12-rc3) in 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
tagged commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 (v2.6.12-rc2) in 9e734775f7c22d2f89943ad6c745571f1930105f
expect dangling commits - potential heads - due to lack of head information
dangling tag 0397236d43e48e821cce5bbe6a80a1a56bb7cc3a
dangling commit 9acf6597c533f3d5c991f730c6a1be296679018e
dangling tag 9e734775f7c22d2f89943ad6c745571f1930105f

Is that last part to be expected ?

		Dave

