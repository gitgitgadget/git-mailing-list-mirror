From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 20:24:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com>
 <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com>
 <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com>
 <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com>
 <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org> <42BA271F.6080505@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 05:20:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlIGA-0002mI-Tg
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 05:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVFWD0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 23:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVFWD0E
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 23:26:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28073 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262035AbVFWDZc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 23:25:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N3MHjA017693
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 20:22:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N3MFXs023149;
	Wed, 22 Jun 2005 20:22:16 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42BA271F.6080505@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Jeff Garzik wrote:
> 
> Concrete example:  I have a git tree on local disk.  I need to find out 
> where, between 2.6.12-rc1 and 2.6.12, a driver broke.  This requires 
> that I have -ALL- linux-2.6.git/refs/tags on disk already, so that I can 
> bounce quickly and easily between tags.

Absolutely not.

I might have my private tags in my kernel, and you might have your private 
tags ("tested") in your kernel, so there is no such thing as "ALL".

The fact that BK had it was a BK deficiency, and just meant that you 
basically couldn't use tags at all with BK, the "official ones" excepted. 
It basically meant that nobody else than me could ever tag a tree. Do you 
not see how that violates the very notion of "distributed"?

This is _exactly_ the same thing as if you said "I want to merge with ALL
BRANCHES".  That notion doesn't exist. You can rsync the whole repository,
and you'll get all branches from that repository, that's really by virtue
of doing a filesystem operation, not because you asked git to get you all
branches.

A tag is even _implemented_ exactly like a branch, except it allows (but
does not require) that extra step of signing an object. The only
difference is literally whether it is in refs/branches or refs/tags.

> It is valuable to have a local copy of -all- tags, -before- you need 
> them.

You seem to not realize that "all tags" is a nonsensical statement in a 
distributed system.

If you want to have a list of official tags, why not just do exactly that? 
What's so hard with saying "ok, that place has a list of 'official' tags, 
let's fetch them".

How would you fetch them? You might use rsync, for example. Or maybe wget. 
Or whatever. The point is that this works already. You're asking for 
something nonsensical, outside of just a script that does

	rsync -r --ignore-existing repo/refs/tags/ .git/refs/tags/

See? What's your complaint with just doing that?

			Linus
