From: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Mon, 18 Apr 2005 11:35:16 -0700
Organization: http://madrabbit.org/
Message-ID: <1113849317.23938.48.camel@orca.madrabbit.org>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr>
	 <20050418122011.GA13769@abridgegame.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Mon Apr 18 20:32:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNb1u-0001sl-Cm
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 20:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVDRSf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 14:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVDRSf0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 14:35:26 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:39140 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S262110AbVDRSfS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 14:35:18 -0400
Received: from orca.madrabbit.org (orca.madrabbit.org [192.168.1.51])
	by madrabbit.org (Postfix) with ESMTP
	id C30454C0AC5; Mon, 18 Apr 2005 11:35:17 -0700 (PDT)
To: David Roundy <droundy@abridgegame.org>
In-Reply-To: <20050418122011.GA13769@abridgegame.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 08:20 -0400, David Roundy wrote:
> Putting darcs patches *into* git is more complicated, since we'll want to
> get them back again without modification.  Normal "hunk" patches would be
> no problem, provided we never change our diff algorithm (which has been
> discussed recently, in the context of making hunks better align with blocks
> of code).  We could perhaps tell users not to use "replace" patches.  But
> avoiding "mv" patches would be downright silly.

Okay, I still haven't used git yet (and have only toyed around with
darcs for a bit), so take what I'm saying with a grain of salt.
Regardless, I think you may be asking the wrong question. The tracking
of renames was bandied about pretty thoroughly on-list from Wednesday
through Friday (for far better commentary and insight, see Linus'
messages with subject: Merge with git-pasky II.)

git does track changesets that describe the parent tree(s) and the
result. The trees track filenames and hashes. So, doing a fairly
straightforward compare on two trees will let you immediately discover
renames that have occurred, as the filename in the tree changed while
the hash didn't.

So, the question then becomes, can an outside tool cheaply derive all
the information that darcs would need to perform it's work? The renames
should be easy, as long as no content changed during the rename. As for
token replacement (and whitespace changes, etc.), that could be
discovered via domain-specific parsers (something specific per language,
for example). Linus tossed a link to one such tool (hmm, where was it.
Sheesh. You sure right a lot, dude :-).)

	http://minnie.tuhs.org/Programs   (see Ctcompare)

...which should be viewed more as a proof-of-concept than a mergeable
code-set. It does show that diff's vocabulary is sadly lacking in
expressiveness, and improving that, I think, would be a useful area to
expend effort. 

Again, I may be off here, especially considering I've a backlog of a
couple hundred messages to read since the weekend. (You guys need to go
outside more often.)

Ray

