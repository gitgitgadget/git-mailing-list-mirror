From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4 issue
Date: Wed, 20 Apr 2011 10:51:13 +0000 (UTC)
Message-ID: <loom.20110420T121500-4@post.gmane.org>
References: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com> <BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com> <BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com> <BANLkTinJecAsXt+5JzscFYEx_ez2q9DioQ@mail.gmail.com> <20110420003100.GC28768@arf.padd.com> <BANLkTikYDR+bzJQGip9BFo-BSgsBqEcQjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 12:51:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCV0Q-0003Ik-Kj
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 12:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab1DTKv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 06:51:29 -0400
Received: from lo.gmane.org ([80.91.229.12]:39030 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944Ab1DTKv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 06:51:29 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QCV0H-0003BN-Lu
	for git@vger.kernel.org; Wed, 20 Apr 2011 12:51:28 +0200
Received: from 57.79.130.188 ([57.79.130.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 12:51:25 +0200
Received: from vitor.hda by 57.79.130.188 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 12:51:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 57.79.130.188 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:2.0) Gecko/20100101 Firefox/4.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171858>

Hi Mike,

Michael Horowitz <michael.horowitz <at> ieee.org> writes:

> I don't have a problem with the branch detection if other people use
> it in ways I don't, but it would be nice to have more options and
> documentation around it.

Yes, documentation is a bit scarce. And looking again at my patch the
description text also does not seem quite good enough.

> The best I can do to describe what I want is for it to use what is
> returned by "git-p4 branches", at minimum. If there is some optional
> additional "new branch detection" logic, I don't have a problem with
> that, but that should only be in addition to the branches it already
> knows about from "git-p4 branches". So, when I do a "git-p4 sync" or
> "git-p4 rebase", and it is importing changes from/to multiple
> branches, then it should get that list of branches using the same
> method "git-p4 branches" uses. Does that make sense?

I think I understand your point and it may make sense. Currently,
"self.knownBranches" is the list used during import from P4. The idea
behind making this list different from "self.p4BranchesInGit" might have
been to allow stop following a given branch by removing its definition
from P4. Of course, if you already imported it earlier and there is a
commit into it I think it makes sense to import the new commit instead
of ignoring it as it is being done now. With that said, I think it would
be a good idea to somehow merge the two lists together. But, as Pete
already pointed out, the branch code is too complex as it is now and it
needs a deep review. So it might make sense to include this feature as
part of that review.

The patch I directed you to ([1]) allows you to create a list of
branch-origin to branch-destination pairs independent of "p4 branches"
output. So you should be able to use this as a workaround for now.

> Thanks,
> 
> Mike

Regards,
Vitor

[1] http://article.gmane.org/gmane.comp.version-control.git/168001
