From: Jeff King <peff@peff.net>
Subject: Re: Bug! Git merge also fails with a wrong error message
Date: Fri, 13 Jan 2012 13:54:36 -0500
Message-ID: <20120113185436.GA13522@sigill.intra.peff.net>
References: <loom.20120112T193624-86@post.gmane.org>
 <loom.20120113T181805-423@post.gmane.org>
 <20120113175040.GC9373@sigill.intra.peff.net>
 <4F107CAD.1020103@unclassified.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Fri Jan 13 19:54:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlmGx-0001cG-TY
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 19:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758844Ab2AMSyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 13:54:40 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36814
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758826Ab2AMSyj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 13:54:39 -0500
Received: (qmail 11507 invoked by uid 107); 13 Jan 2012 19:01:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jan 2012 14:01:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jan 2012 13:54:36 -0500
Content-Disposition: inline
In-Reply-To: <4F107CAD.1020103@unclassified.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188525>

On Fri, Jan 13, 2012 at 07:49:17PM +0100, Yves Goergen wrote:

> On 13.01.2012 18:50 CE(S)T, Jeff King wrote:
> > Whether a file in the working tree is tracked or not does not have to do
> > with the history, but rather with whether it is mentioned in the index.
> 
> I'm not using the index. In fact I don't even know how that what I have
> read about it can be useful.

Whether you realize it or not, git is using the index to store state.
When you "git add", "git rm", or "git mv", it is updating the index.

> > Does the file appear in "git ls-files"?
> 
> Yes, it's in the list along with all other files.

Then it should be considered tracked, and there's a bug.

I notice that in your first mail, you mentioned a problem with
"checkout", and in the second one, a problem with "merge". Do you still
have the repo around with the "checkout" problem? If so, is the file
also in your "git ls-files" output in that repo?

It is much more likely to me that there is a bug in the merge than in
regular checkout (because merge has many complex corner cases
surrounding the 3-way merge, whereas checkout is simply moving from one
state to another). I'd like to make sure we're not seeing two different
problems.

> Here's the git status output:
> # On branch master
> nothing to commit (working directory clean)
> 
> I have switched to master and the very next action was trying the merge.
> There's no change in the working directory, and nothing uncommitted.

Which version of git are you using? There were many bugs fixed around
this area of merge around the v1.7.7 timeframe.

-Peff
