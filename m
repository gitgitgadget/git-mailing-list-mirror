From: "David Jeske" <jeske@willowmail.com>
Subject: Re: policy and mechanism for less-connected clients
Date: Thu, 26 Jun 2008 06:08:55 -0000
Message-ID: <32645.6224699088$1214461121@news.gmane.org>
References: <20080626052310.GC8610@mit.edu>
	<willow-jeske-01l6@3PlFEDjCVAh-01l6it3ZFEDjCd5X>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 26 08:18:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBkoQ-0003Wq-Pq
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 08:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbYFZGRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 02:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYFZGRQ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 02:17:16 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60752 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751513AbYFZGRN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 02:17:13 -0400
Received: (qmail 10482 invoked by uid 90); 26 Jun 2008 06:17:02 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Thu, 26 Jun 2008 06:08:55 -0000
In-Reply-To: <20080626052310.GC8610@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86402>

-- Theodore Tso wrote:
> If you are going to preserve the workflow of CVS, then you're
> also going to preserve all of the downsides of CVS.

I don't agree with this, and I don't see you proposing any logic that proves it
to be true. Of course I plan to make small changes. However, in my previous
message I proposed 3 same-workflow improvements, and 2 small-workflow-extension
improvements. I have more in mind..

http://marc.info/?l=git&m=121442660332114&w=2

Maybe it was too confusing or too long to read. Just consider the first simple
example.

Currently "cvs up" in a dirty tree is a destructive operation. If you merge
badly, you can't get back to your local working files before the "up". I've
been burned by this in cvs/perforce enough that now when there are complicated
update-conflicts I tar up the tree before trying to fix them. I still can't
really get back to the pre-up state.

I can be better than cvs with the EXACT same workflow, by checking in their
local changes (git checkin;) and then doing the "up" (git pull;). If they
decide they botched their merge, they can get back to where they were before
the UP because I'm using a richer underlying mechanism to implement their
workflow.

Do you think that's not an improvement? or not the same workflow? It sure seems
like a same-workflow improvement to me.

----

git's mechanisms are really great for making a hybrid central/distributed
system which has the simplicity of cvs/perforce and several of the benefits of
git. The git interface is just too complicated to be used for this.
Fortunately, building on git means that power users will still be able to use
git directly and people can distribute the repositories as much as they want.

> how much change are you willing to make them deviate from
> the CVS workflow, and how much smarts are you willing to assume that
> they have?

Good question. I'm working on a command-line wrapper for git that does it.
Digging into the "plumbling" is making it more obvious why I find git's
porcelain operations hard to understand. I think I can make a 2-repository
setup (personal-inaccessible, origin) work like cvs/perforce with local
checkins, and I can make a 3-repository setup (personal-inaccessible,
personal-accessible, origin) work nearly the same as cvs while allowing
distributed collaboration. I think I will need a tiny bit of custom server
support (to create the personal-accessible repositories automatically).

Right now it looks like I'll be a simple hybrid of cvs/perforce, with a couple
git concepts peppered in. (but just a couple) It seems simple so far, it's just
taking me a while to dig through git-plumbing to understand it.

Also remember, this isn't built to handle what linux-kernel folks do with git.
It's designed to provide a familiar environment for cvs/perforce style users
that is just as simple but a whole lot better. Even if it eventually gets lots
of git concepts, they won't HAVE to understand them to use it. They can learn
them as they go.  This is obviously something that people want, as cogito and
easy-git show.
