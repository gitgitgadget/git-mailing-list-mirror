From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Sun, 11 Sep 2005 16:40:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509111631500.3242@g5.osdl.org>
References: <deofnh$jl0$1@sea.gmane.org> <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vvf17tsoa.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509111100260.3242@g5.osdl.org>
 <Pine.LNX.4.63.0509120119120.10594@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	John Ellson <ellson@research.att.com>, git@vger.kernel.org,
	Patrick Mauritz <oxygene@studentenbude.ath.cx>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Mon Sep 12 01:41:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEbRn-0004B0-0b
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 01:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVIKXk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 19:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVIKXk4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 19:40:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751080AbVIKXkz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 19:40:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8BNeWBo001172
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 16:40:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8BNeV6d027551;
	Sun, 11 Sep 2005 16:40:31 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509120119120.10594@wgmdd8.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8343>



On Mon, 12 Sep 2005, Johannes Schindelin wrote:
>
> Linus, we all know that you are always right. Only that in this case you 
> are just a little bit less right than usual. The introduction of this 
> typedef was a sane thing to do, for the same reason it is a sane thing to 
> use sensible variable names: documentation.

Nope.

Go through the history of that thing.

It wasn't introduced as "socklen_t". It was introduced as "size_t".

That was so horribly wrong that it's not even funny. 

Documentation my ass. It's a matter of people thinking that the old 
portable types aren't good enough, and that you have to make up new names 
for everything in order to allow "portability" where different systems 
have different ideas.

And it's ignoring the fact that true portability means "it just works". 
"size_t" fundamentally didn't work. 

And the really sad part is that before the standards bodies started
messing around with it, things really _did_ "just work". There was no 
question at all about what kind of type to use.

These days, we sadly have some systems that just blindly followed the 
standard, changed "int" to "size_t", and then when the standard was fixed, 
changed "socklen_t" to be "size_t".

Don't believe me? Just google for "size_t" and "socklen_t", and weep.

All this confusion, and for what? Absolutely _zero_ upsides.

Basically, if a programmer feels like he needs to remind himself what the 
variable was all about, how about using descriptive variable names? I 
claim that

	int addr_len;

is a lot more documentation than

	socklen_t len;

and that the people who think that different type-name are "documentation"
are ignoring the fact that they are _also_ "confusing".

There's a virtue in simplicity. Abstraction is _not_ a virtue.

			Linus
