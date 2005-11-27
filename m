From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Sat, 26 Nov 2005 20:13:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511262006350.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
 <20051118205513.GA3168@vrfy.org> <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org>
 <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org> <437E51EB.7050100@zytor.com>
 <Pine.LNX.4.64.0511181520390.13959@g5.osdl.org> <7vek5deam6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511181653191.13959@g5.osdl.org> <7v7jb57wud.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511190950161.13959@g5.osdl.org> <20051127025249.GA12286@vrfy.org>
 <7vfypioi83.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 05:14:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgDvV-0001YZ-7o
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 05:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVK0EOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 23:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVK0EOF
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 23:14:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46295 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750839AbVK0EOE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2005 23:14:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAR4E0nO017321
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 26 Nov 2005 20:14:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAR4DskT032216;
	Sat, 26 Nov 2005 20:13:57 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfypioi83.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12796>



On Sat, 26 Nov 2005, Junio C Hamano wrote:

> Kay Sievers <kay.sievers@vrfy.org> writes:
> >> 
> >> If you replace "assume" with "verify", then I agree.
> 
> One problem I have that approach is what to do if it does not
> verify.  Reject and ask them to re-run the program with another
> option --binary-log-message?

We could do that. With perhaps an option to just do the trivial 
"latin1->utf8" translation, which will be correct in most of the western 
world (and, perhaps more importantly - the places it won't be correct in 
will almost universally have an explicit locale setting or similar, since 
otherwise nothing would work).

In other words, in the absense of locale settings, we can pretty much 
assume any 8-bit data is latin1 if it isn't already utf-8. That's what a 
lot of tools do already (eg, gitk automatically does the right thing, 
exactly because it will assume non-proper utf-8 being in latin1).

I'd suggest that the current "-u" flag do the latin1->utf8 autoconversion, 
and _without_ the "-u" flag, you'd just commit it as binary data..

		Linus
