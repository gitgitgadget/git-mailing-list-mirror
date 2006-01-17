From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: Subprojects
Date: Tue, 17 Jan 2006 09:38:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601170928240.3240@g5.osdl.org>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
 <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net> <200601161144.48245.Josef.Weidendorfer@gmx.de>
 <7vek37rj83.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601170001130.25300@iabervon.org>
 <7vfynnfkc8.fsf@assigned-by-dhcp.cox.net> <20060117140937.GI28365@pasky.or.cz>
 <Pine.LNX.4.64.0601171122270.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 18:38:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eyumx-0007kl-9T
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 18:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWAQRid (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 12:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWAQRid
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 12:38:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16001 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932238AbWAQRic (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 12:38:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0HHcFDZ004968
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Jan 2006 09:38:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0HHcDG1020982;
	Tue, 17 Jan 2006 09:38:14 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601171122270.25300@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14800>



On Tue, 17 Jan 2006, Daniel Barkalow wrote:
> 
> Think from a debugging standpoint. You know that the main project worked 
> with a particular commit of the superproject.

Yes, there are real advantages to being able to tag a very specific 
version of a tree.

You can do it manually (ie tag the versions of everything used), but 
there's a real convenience to being able to say "I want the tree to look 
exactly as it looked for our internal test-release that we shipped as a 
pre-view to customer so-and-so".

You can do it with ad-hoc build rules inside a company, but the likelihood 
that they don't work all the time is pretty high. Somebody forgot to 
follow the right procedure, and had updated a sub-tree without marking it, 
and now you can't reproduce the problem that a customer has with a debug 
build, because you have no way to reproduce the exact binary...

It's why people tag every file for huge trees under CVS for a release, and 
accept why building a release may take hours. It's crazy, yes, but there 
are other projects than just the BSD's that have that "World" mentality, 
where they want every single program under _one_ umbrella, so that they 
can tag them all together.

Me, I think it's crazy engineering ("if you can't reproduce it with 
individual projects, you're not doing programming, you're doing Voodoo"), 
but it's something that some organizations simply require.

Now, it might be enough with a cogito approach of ".git/subprojects", and 
just _version-control_ it in the top-level project, but then you'd need to 
make sure that all the tools automatically update the version when they do 
a "pull" or a "commit" on a subproject. But then it almost boils down to 
"gitlink"s after all.

		Linus
