From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: diff against a tag ?
Date: Thu, 28 Apr 2005 14:01:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281358060.18901@ppc970.osdl.org>
References: <20050428200953.GD8514@redhat.com> <7vpswe7hvj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Jones <davej@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 22:57:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRG3d-0000o8-ID
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 22:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVD1VBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVD1VBU
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:01:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:33940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262244AbVD1U76 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 16:59:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SKxfs4011336
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 13:59:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SKxe0g009333;
	Thu, 28 Apr 2005 13:59:41 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpswe7hvj.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Junio C Hamano wrote:
> 
> Depends on your definition of today, but with the patch below I
> sent today, you can say "diff-tree -p $tag $(cat .git/HEAD)".

I think Dave was wondering how to _find_ the tag in the first place, which 
is a different issue.

Right now fsck is the only thing that reports tags that aren't referenced 
some other way. Once you know the tag, things are easy - even without 
Junio's patch you can just do

	object=$(cat-file tag $tag | sed 's/object //;q')

and then you can just do

	diff-tree $object $(cat .git/HEAD)

or whatever you want to do.

Dave: do a "fsck --tags" in your tree, and it will talk about the tags it
finds. Then you can create files like .git/refs/tags/v2.6.12-rc2 that
contain pointers to those tags..

		Linus

