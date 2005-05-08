From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Broken adding of cache entries
Date: Sun, 8 May 2005 18:59:15 +0200
Message-ID: <20050508165915.GW9495@pasky.ji.cz>
References: <20050506233003.GJ32629@pasky.ji.cz> <1115423450.32065.138.camel@localhost.localdomain> <20050507001409.GP32629@pasky.ji.cz> <1115431767.32065.182.camel@localhost.localdomain> <20050507152849.GD9495@pasky.ji.cz> <7vhdhealjm.fsf@assigned-by-dhcp.cox.net> <20050507224116.GF9495@pasky.ji.cz> <7vll6q8s4o.fsf@assigned-by-dhcp.cox.net> <7vbr7m8p05.fsf@assigned-by-dhcp.cox.net> <7vll6q70mg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 18:53:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUp1H-0004Q3-P3
	for gcvg-git@gmane.org; Sun, 08 May 2005 18:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVEHQ7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 12:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbVEHQ7Z
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 12:59:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29913 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262894AbVEHQ7S (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 12:59:18 -0400
Received: (qmail 553 invoked by uid 2001); 8 May 2005 16:59:16 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vll6q70mg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 07:22:31AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:
> 
> JCH> I am not quite sure the semantics is quite right, so I am
> JCH> holding it off from putting it in git-jc repository for now, but
> JCH> please review it, give it a try and tell me what you think.
> 
> Ok, I have two updates pushed out at git-jc archive at
> http://members.cox.net/junkio/git-jc.git/

I wanted to merge with you, but I'd like to make some (mostly minor)
nitpicks first.

Sorry for totally garbled whitespace and everything, this is just gpm.

--- e19665d8d42877246ac7e98a7c671d11adbe8b56/read-cache.c  (mode:100644)
+++ uncommitted/read-cache.c  (mode:100644)
+               char *ep = strchr(cp, '/');
+               if (ep == 0)

Please use NULL.

+static struct alternate_object_database
+{
+       char *base;
+       char *name;
+} *alt_odb;

The commonly accepted style is to have the { bracket on the same line as the
struct identifier.

Sticking a brief explanation to prepare_alt_odb(), like "pass 0
allocates the array and pass 1 fills it" couldn't hurt, it took me a
while of staring at it to figure out. There's also unused @buf variable.
But I personally think all this alt_odb code is quite creepy. ;-)

--- e19665d8d42877246ac7e98a7c671d11adbe8b56/write-tree.c  (mode:100644)
+++ uncommitted/write-tree.c  (mode:100644)
-                       if (++unmerged > 10) {
+                       if (10 < ++funny) {

Do those changes make any sense? The former version is certainly much
easier to read for me. I can live with it in the new code, but changing
old code to it...

With the current update-cache protections, how can you legally achieve a
cache with duplicate entries, so that you need to check for that in
write-tree?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
