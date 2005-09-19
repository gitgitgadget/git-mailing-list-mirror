From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What to expect after GIT 0.99.7
Date: Mon, 19 Sep 2005 07:34:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509190727110.9106@g5.osdl.org>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
 <7vpsr6ymg3.fsf_-_@assigned-by-dhcp.cox.net> <pan.2005.09.19.07.35.56.960375@smurf.noris.de>
 <7vwtldsbv2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 16:39:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHMk8-00018j-5i
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVISOfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 10:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVISOfh
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:35:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932437AbVISOfh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 10:35:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8JEYbBo010982
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 07:34:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8JEYXPt028721;
	Mon, 19 Sep 2005 07:34:35 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtldsbv2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8867>



On Mon, 19 Sep 2005, Junio C Hamano wrote:
> 
> I used to do 'cvs update -p foo.c >foo.c', and extending
> git-checkout may be familiar to cvs migrants.  The most
> roundabout way (albeit with perhaps least typing) is:
> 
>     git-tar-tree HEAD | tar xf - foo.c

Uhh.

I use

	git-checkout-index -f -u foo.c

which works fine. Of course, that doesn't help if you've updated the
index, but then I actually think it's fine to expose the index.

Now, admittedly, we should probably make that easier to do.

If you want to reset to the HEAD state _and_ your index is stale, I'd just
precede it with a

	git reset

and be done. Yes, it will reset your whole index, not just that file, but 
hey, big deal. In practice it works fine.

> I originally talked about reverting file(s) in the working tree,
> but I wonder if reverting a cache (eh, index) entry to the state
> in a committed tree is useful.  read-tree with a pathspec to
> overwrite index entries for specified paths while leaving others
> intact.  We could think of it as undoing git-update-index.

Yes, I think it would be useful to be able to read in just part of the
tree.

		Linus
