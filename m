From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Moving a file back to an earlier revision.
Date: Fri, 31 Mar 2006 13:26:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603311324040.27203@g5.osdl.org>
References: <4dd15d180603311313t7781f2ebk616276e9134f6472@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 23:26:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPR8Y-0006eq-SP
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 23:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWCaV0X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 16:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCaV0X
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 16:26:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29842 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751063AbWCaV0W (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Mar 2006 16:26:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2VLQKEX020962
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 31 Mar 2006 13:26:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2VLQJaa005050;
	Fri, 31 Mar 2006 13:26:20 -0800
To: David Ho <davidkwho@gmail.com>
In-Reply-To: <4dd15d180603311313t7781f2ebk616276e9134f6472@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18234>



On Fri, 31 Mar 2006, David Ho wrote:
> 
> I am working on a board port on a separate branch.  The branch has
> accumulated several revision of changes to a driver I worked on.  Now,
> someone has come along with a better fix so I want to help test his
> patch.  To do that I have to revert my changes to that driver (several
> revisions back) before I can apply his patch.
> 
> What would be a convenient way to do that with git?

Don't revert.

Just pick the point you want to start testing his patch at (with gitk, for 
example, just cut-and-paste the sha1), and do

	git checkout -b test-better-fix <sha1>

which creates a new branch ("test-better-fix") that starts at that point, 
and checks it out. 

Then, just apply the patch, and off you go. You now have _both_ his patch 
and your own series in separate branches, so you can cherry-pick and do 
other things (like do a "diff" between branches - which can sometimes be 
useful too to verify that the two branches end up fixing all the same 
problems).

		Linus
