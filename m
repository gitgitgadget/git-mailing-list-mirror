From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: how to combine two clones in a collection
Date: Mon, 9 Jul 2007 19:35:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707091923300.3412@woody.linux-foundation.org>
References: <20070709222250.GA8007@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 04:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I85Zp-0005OJ-Fx
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 04:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758470AbXGJCfm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 22:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758227AbXGJCfm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 22:35:42 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33428 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758470AbXGJCfl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jul 2007 22:35:41 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6A2ZQ9T005460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 Jul 2007 19:35:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6A2ZL8H030780;
	Mon, 9 Jul 2007 19:35:21 -0700
In-Reply-To: <20070709222250.GA8007@piper.oerlikon.madduck.net>
X-Spam-Status: No, hits=-2.638 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52033>



On Tue, 10 Jul 2007, martin f krafft wrote:
> 
> I am now ready to move to using git for most of my everyday work,
> but I am still unsure how to tackle one specific aspect of it, for
> which I used svn:externals in the past. I know about git
> subprojects, but these aren't what I want, really.

I really _think_ that what you want is to just use separate branches, if I 
understand correctly. That makes it really easy to just have both lines of 
development (both the "trunk" and your "debian" one) in one git 
repository.

Of course, especially if you want to continue to work the way you probably 
worked with SVN (ie you are used to seeing those two branches as two 
separate directories), that means that while you can (and should) see it 
as a single git project, you'd normally end up just having two copies of 
that project: they'd _both_ have two branches, but they'd just en dup 
having different branches checked out.

Of course, after you get comfy enough with the setup, you might end up 
just deciding that you might as well just switch branches around in a 
single repository (which is what a lot of git users end up doing), but at 
least initially, it's probably easier from a conceptual standpoint to just 
have the two branches checked out in separate copies of the repos.

> With SVN, I would have a directory with two external entries:
> 
>   upstream.trunk svn+ssh://svn.upstream.org/path/to/trunk
>   upstream.trunk/debian svn+ssh://svn.debian.org/svn/pkg/trunk/debian

So in git, you'd have just one "project" with two branches - perhaps just 
called "upstream" and "debian".

Of course, with git, that single "project" can then exist in a distributed 
manner in many different places, and having two copies with different 
branches checked out would just happen to be the one that most closely 
resembles your current situation.

> How can I do this with git? I am aware that maybe the best way would
> be to use git-svn to track the upstream branch remotely and to add
> ./debian in a separate git branch (and to stop using SVN and switch
> to git for ./debian)

I don't think you'd have to stop using SVN. Just continue to track the 
"upstream" branch with git-svn, and then you can merge in the upstream 
into your "debian" branch that also has all the debian-specific stuff.

(And no, I don't know what the standard debian package management setup 
looks like, but I would hope that your extra stuff would be just a few 
files and package descriptions, and obviously any of the local debian 
changes to the project).

		Linus
