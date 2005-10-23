From: Petr Baudis <pasky@suse.cz>
Subject: Re: Merge failure problem with cogito: How to fixup?
Date: Mon, 24 Oct 2005 00:32:40 +0200
Message-ID: <20051023223240.GU30889@pasky.or.cz>
References: <200510231557.j9NFvptA020919@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 00:34:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EToOY-00008G-MK
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 00:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVJWWcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 18:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVJWWcn
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 18:32:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29903 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750809AbVJWWcm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 18:32:42 -0400
Received: (qmail 12759 invoked by uid 2001); 24 Oct 2005 00:32:40 +0200
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200510231557.j9NFvptA020919@inti.inf.utfsm.cl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10508>

Dear diary, on Sun, Oct 23, 2005 at 05:57:51PM CEST, I got a letter
where Horst von Brand <vonbrand@inf.utfsm.cl> told me that...
> When doing the following:
> 
>    mkdir /tmp/tst1
>    cd /tmp/tst1
>    echo "Initial" | cg-init 
>       
>    cd /tmp
>    cg-clone tst1 tst2
>    
>    cd /tmp/tst1
>    echo 'Hi there!' > greet
>    cg-add greet
>    cg-commit -m "Add greet"
>    
>    cd /tmp/tst2
>    echo 'Hello!' > greet
>    cg-add greet
>    cg-commit -m "Add greet"
> 
>    cg-update
> 
> I get a message to the end that the merge doesn't work, and that I have to
> fix up by hand. The resulting greet file has no merge markers, plain
> "cg-diff" is useless. How am I supposed to find out what the problem is?
> 
> Yes, "cg-diff -r origin:HEAD" does the trick, but...

Well, yes, that's one of the "unhandled merge cases". :-)

To fixup:

	<resolve the merge somehow, probably adding greet in some form>
	cg-add greet

(You should be able to cg-rm greet instead if you decide to drop the
file after all.)

This is a _trick_ and it works just because cg-add and cg-rm purely
accidentally do the right GIT commands to also resolve an index-level
merge conflict. The proper solution would be to add the proper case to
cg-Xmergefile, which should be actually pretty easy, if only someone
does it... ;-)

Ok, and cg-status should be taught about it and report "greet" somehow
as a conflict until you choose one of the versions.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
