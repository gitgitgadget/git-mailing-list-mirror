From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/9] Fix git patch header processing in git-apply.
Date: Mon, 29 Aug 2005 18:24:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508291821010.3243@g5.osdl.org>
References: <11252426672473-git-send-email-robfitz@273k.net>
 <7vslwtein3.fsf@assigned-by-dhcp.cox.net> <20050829235823.GA19351@localhost>
 <Pine.LNX.4.58.0508291744400.3243@g5.osdl.org> <7vacj06xi6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robert Fitzsimons <robfitz@273k.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 03:25:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9us1-000574-4x
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 03:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVH3BYs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 21:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVH3BYs
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 21:24:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751446AbVH3BYs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 21:24:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7U1OfjA012870
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 18:24:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7U1Oeuu003730;
	Mon, 29 Aug 2005 18:24:41 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacj06xi6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7937>



On Mon, 29 Aug 2005, Junio C Hamano wrote:
> 
> I, however, am not 100% convinced --ignore-applied is too
> dangerous to be useful in any conceivable use cases, at least
> not yet.  For example, you might be cherry-picking a change from
> a foreign branch with 'git-diff-tree -p other~45 | git apply',
> where the current branch may have already aquired part of the
> changes that foreign branch contains since 45 generations ago.

.. and that's why we use a three-way merge, and not diffs, to merge two 
branches. 

--ignore-applied really is a pretty dangerous thing. I can see that it 
might do the right thing in many cases, but definitely not in a scripted 
environment, much less in an "import". 

By definition, importing stuff must apply, since it clearly applied in
whatever original source control tool you are importing from. So if an 
importer needs --ignore-applied, it is fundamentally doing something 
wrong.

And I just realized what "SourcePuller" is. Gaah. Trust me, that export is 
bad, and the original source control tool did everything very well indeed.

			Linus
