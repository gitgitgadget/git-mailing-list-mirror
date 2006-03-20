From: James Cloos <cloos@jhcloos.com>
Subject: Re: efficient cloning
Date: Sun, 19 Mar 2006 19:32:22 -0500
Message-ID: <m3wteqj6qx.fsf@lugabout.cloos.reno.nv.us>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
	<7vu09um3ae.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 01:35:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL8Mm-00014K-CW
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 01:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWCTAfL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 19:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWCTAfL
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 19:35:11 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:39685 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1751230AbWCTAfJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Mar 2006 19:35:09 -0500
Received: from lugabout.jhcloos.org (host-69-48-10-108.roc.choiceone.net [69.48.10.108])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org", Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP
	id 475A01C497; Sun, 19 Mar 2006 18:32:32 -0600 (CST)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 7584C199DE3; Mon, 20 Mar 2006 00:32:22 +0000 (GMT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu09um3ae.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 19 Mar 2006 15:18:49 -0800")
Copyright: Copyright 2006 James Cloos
X-Hashcash: 1:23:060320:junkio@cox.net::a0udqlEqKJqqmfVj:001MXvD
X-Hashcash: 1:23:060320:git@vger.kernel.org::pSObTt09Q7gOype1:000000000000000000000000000000000000000000QXqd
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17738>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> "The same repo as this script" is a very poor way to define what
Junio> you really want. 

I don't think so.  Getting the same values in files like FETCH_HEAD,
ORIG_HEAD, branches/*, remotes/*,  info/* et al is not obvious.
Especially, eg, all of the same Push/Pull lines.

Junio> What is "git-repack -a -d -s"?

A typo.  I of course meant -a -d -l.

Junio> It might be worth adding a --reference flag to git-clone like
Junio> this patch does.

That is essentially what I tried (except only the name of the flag; I
prefer your choice).  I didn't include the reference-tmp logic, but
otherwise it looks about the same.

Junio> However, this patch alone does not reduce the transferred data
Junio> during cloning any smaller if you are using the "$1" repository
Junio> over git native transport (including a local repository),
Junio> because the current clone-pack does not look at existing refs

Exactly the wall I ran into.  And I really only need it for git://.

Junio> Maybe it would be a good idea to deprecate
Junio> clone-pack altogether, use fetch-pack -k, and implement the
Junio> "copy upstream refs to our refs" logic in git-clone.sh.  We need
Junio> to do something like that if/when we are switching to use
Junio> $GIT_DIR/refs/remotes/ to store tracking branches outside
Junio> refs/heads anyway.

And it looks like you've shown me the door in that wall.

I'll have to read up on fetch-pack as opposed to clone-pack.

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
