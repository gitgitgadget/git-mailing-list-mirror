From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: can I get only the list of merges?
Date: Mon, 10 Jul 2006 11:09:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607101103160.5623@g5.osdl.org>
References: <20060710192622.70c51a81.diegocg@gmail.com> <E1FzzlS-0003JE-9C@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Diego Calleja <diegocg@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 20:10:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G00CN-0001n2-3i
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 20:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422736AbWGJSJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 14:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbWGJSJ3
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 14:09:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965208AbWGJSJ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 14:09:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6AI9MnW026028
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Jul 2006 11:09:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6AI9LwR012651;
	Mon, 10 Jul 2006 11:09:21 -0700
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FzzlS-0003JE-9C@moooo.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23631>



On Mon, 10 Jul 2006, Matthias Lederhofer wrote:

> Diego Calleja <diegocg@gmail.com> wrote:
> > Hi, git-log and git-rev-list and friends have a --no-merges option. However,
> > I need the contrary functionality: a sort of "--only-merges" way of getting
> > the log? (that is, without parsing manually the git-log output)
> 
> Perhaps something like this?  It finds all commits with more than one
> parent (I dunno if there are any other commits that have more than one
> parent)
> git-rev-list --parents HEAD | \
> grep -E '^([a-z0-9]{40} ){2}[a-z0-9]{40}' | \
> cut -d ' ' -f 1

Well, the above is the "proper" way of doing things, and is efficient and 
gives the right answer. However, if you want a _sneaky_ way of doing it, 
and want a graphical result, and have a recent version of git, you can 
also just do something like

	gitk --full-history -- %%nonexistant-file%%

which will give you each commit that changes that nonexistant file (there 
should be none ;), and the full commit history for those (ie all the 
merges).

(If you use "git log", you also need to add "--parents" while gitk will do 
it for you).

			Linus
