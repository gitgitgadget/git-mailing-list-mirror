From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Darcs and git: plan of action
Date: Mon, 18 Apr 2005 08:38:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504180832330.7211@ppc970.osdl.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr>
	<20050418122011.GA13769@abridgegame.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Mon Apr 18 17:34:06 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNYFA-0003pp-Oz
	for gcvdd-darcs-devel@m.gmane.org; Mon, 18 Apr 2005 17:33:01 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DNYIy-0006hY-Id; Mon, 18 Apr 2005 11:36:56 -0400
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by abridgegame.org with esmtp (Exim 4.50) id 1DNYIu-0006gj-07
	for darcs-devel@darcs.net; Mon, 18 Apr 2005 11:36:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3IFaSs4000959
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 08:36:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3IFaR54018114;
	Mon, 18 Apr 2005 08:36:27 -0700
To: David Roundy <droundy@abridgegame.org>
In-Reply-To: <20050418122011.GA13769@abridgegame.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net



On Mon, 18 Apr 2005, David Roundy wrote:
> 
> I'm cc'ing you on this email, since Juliusz had some interesting ideas as
> to how darcs could interact with git, which then gave me an idea concerning
> which I'd like feedback from you.  In particular, it would make life (that
> is, life interacting back and forth with git) easier if we were to embed
> darcs patches in their entirety in the git comment block.

Hell no.

The commit _does_ specify the patch uniquely and exactly, so I really 
don't see the point. You can always get the patch by just doing a

	git diff $parent_tree $thistree

so putting the patch in the comment is not an option.

Then you can use the patch to index to whatever extra "darcs index" 
information you want to.

> As I say, it's a bit ugly, and before we explore the idea further, it would
> be nice to know if this would cause Linus to vomit in disgust and/or refuse
> patches from darcs users.

That's definitely the case. I will _not_ be taking random files etc just 
to keep other peoples stuff straightened up.

If you want to add a "log ID", you can certainly do that, but the data the 
ID refers to is _you_ data, and will not go into the git archive. So:

> Another slightly less noxious possibility would
> be to store the darcs patch as a "hidden" file, if git were given the
> concept of commit-specific files.

No, git will not track commit-specific files. There's the comment section,
and that _is_ the commit-specific file. But I will refuse to take any
comments that aren't just human-readable explanations, together with maybe 
one extra line of

	# Darcs ID: 780c057447d4feef015a905aaf6c87db894ff58c

(others will want to track _their_ PR numbers etc) and that's it. The 
actual darcs data that that ID refers to can obviously be maintained in 
_another_ git archive, but it's not one I'm going to carry about.

			Linus
