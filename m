From: Chris Webb <chris@arachsys.com>
Subject: Re: Editing the root commit
Date: Tue, 19 Jun 2012 12:17:10 +0100
Message-ID: <20120619111709.GC10692@arachsys.com>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 13:17:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgwQx-0001bO-1C
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 13:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab2FSLRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 07:17:15 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:38789 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab2FSLRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 07:17:14 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SgwQq-0007Cf-Lr; Tue, 19 Jun 2012 12:17:13 +0100
Content-Disposition: inline
In-Reply-To: <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200196>

Junio C Hamano <gitster@pobox.com> writes:

[symbolic reference to root commit]
> Also there is a more important question: Which root commit?  There
> does not necessarily have to be a single "the root" commit in the
> history.

Ah yes, very good point. Anything with a subtree merge would have several
roots, for example.

I suppose the thing that makes root commits special is their lack of
parents, so the most direct way to get a list of root commits for the
current branch would just be

  git rev-list --max-parents=0 HEAD

making the recipe

  ROOT=$(git rev-list --max-parents=0 master)
  git checkout "$ROOT" -- # will fail if more than one root
  git commit --amend
  git rebase [--interactive] --onto HEAD "$ROOT" master

> I personally think "git rebase -i --root" should be made to just
> work without requiring "--onto" and let you "edit" even the first
> one in the history. It is understandable that nobody bothered, as
> people are a lot less often rewriting near the very beginning of the
> history than otherwise.
> 
> Even though I wouldn't bother doing this myself, I wouldn't mind
> reviewing a patch series ;-)

Okay, I'll take a look when I finish my current project!

Best wishes,

Chris.
