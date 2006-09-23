From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC][PATCH] for_each_ref() returning heads in wrong order
Date: Sat, 23 Sep 2006 18:47:59 +0200
Message-ID: <20060923164759.GP8259@pasky.or.cz>
References: <20060923160712.5890.73139.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 18:48:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRAfe-00022R-Fs
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 18:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWIWQsB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 12:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWIWQsB
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 12:48:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26039 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751293AbWIWQsA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 12:48:00 -0400
Received: (qmail 16816 invoked by uid 2001); 23 Sep 2006 18:47:59 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060923160712.5890.73139.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27599>

Dear diary, on Sat, Sep 23, 2006 at 06:36:21PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> Using the #next branch I've now hit a problem with git-fetch-pack
> master choosing refs/bases/master (I geuss created by StGIT) instead
> of refs/heads/master. The old upload-pack returned the refs in the order
> heads-tags-everything_else but the new one just goes for whatever order
> readdir() returns them in (modulo merging with packed refs). I actually
> can't see the difference that caused this right now, though.

Portion of this is obsolete, I've since noticed what the difference
actually is - the _old_ one processed the directory unsorted and the new
one actually keeps it sorted in add_ref().

Alternate approach would be just to modify add_ref() sort order to take
heads and tags into account (but you still need to keep the cmp hack for
merging packed/loose refs). Should be pretty easy to do, but I
personally need to proceed with my TODO list for now since I've already
a working workaround.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
