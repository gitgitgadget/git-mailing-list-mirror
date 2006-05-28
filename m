From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] git-receive-pack needs to set umask(2)
Date: Mon, 29 May 2006 00:06:28 +0200
Message-ID: <20060528220628.GE10488@pasky.or.cz>
References: <v0irnpn8ea.fsf@marajade.sandelman.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 00:06:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkTP2-0004rC-Iz
	for gcvg-git@gmane.org; Mon, 29 May 2006 00:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWE1WG0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 18:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWE1WG0
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 18:06:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57217 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750989AbWE1WGZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 18:06:25 -0400
Received: (qmail 24605 invoked by uid 2001); 29 May 2006 00:06:28 +0200
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Content-Disposition: inline
In-Reply-To: <v0irnpn8ea.fsf@marajade.sandelman.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20901>

Dear diary, on Sun, May 28, 2006 at 11:31:41PM CEST, I got a letter
where Michael Richardson <mcr@sandelman.ottawa.on.ca> said that...
> If there is another way to solve this, please let me know.

Well, you didn't write what do you actually want to solve. Why do you
need to fiddle with the umask at all?

The object database is considered "append-only" unless you do git-prune
(and you should better not let anyone do that), thus it's enough if you
set all directories group-writable. Other than access the object
database, the users probably only want to update the refs - the solution
is to make refs/heads/ and refs/tags/ group-writable and setgid. This is
also what git-init-db --shared (or tools like cg-admin-setuprepo) should
already set up for you.

So, what did break?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
