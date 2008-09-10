From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 07:38:38 +0200
Message-ID: <20080910053838.GA15715@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <20080909195930.GA2785@coredump.intra.peff.net> <7vljy159v7.fsf@gitster.siamese.dyndns.org> <20080910001316.GF7459@cuci.nl> <7vej3s223f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 07:40:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdIQf-0005I9-4Z
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 07:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbYIJFik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 01:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbYIJFik
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 01:38:40 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:55805 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbYIJFij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 01:38:39 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 2E4355465; Wed, 10 Sep 2008 07:38:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vej3s223f.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95483>

Junio C Hamano wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>> Junio C Hamano wrote:
>>>As for "by the way ... was used to make this commit": this is git.  So how
>>>you arrived at the tree state you record in a commit *does not matter*.

>> The typical use case for the origin links is in a project with several
>> long-lived branches which use cherry-picks to backport amongst them.
>> There is no real other way to solve this case, except for some rather
>> kludgy stuff in the free-form commit message which doesn't mesh well
>> with rebase/filter-branch/stgit etc.

>> As to "does not matter": then why does git store parent links?

>The parent links describe *where* you came from, not *how*.

>And if you think the difference is just "semantics", then you haven't
>grokked the first lesson I gave in this thread.  "parents" record the
>reference points against which you make "this resulting commit suits the
>purpose of my branch better than any histories leading to these commits".

The last question of mine was/is a rethorical one.

Consider the typical use case I describe above.  The developer usually
has just created a commit in the developmentbranch, tested it, and deems
the patch worthwhile enough to backport it to the latest stable branch.
So he cherry picks the from the development branch to the latest stable
branch.
Then tests it, and decides to backport it to the older stable branch,
so he cherry-picks it again, and commits it there too.  The is repeated
in rapid succession on three older stable branches as well.

Basically that means that for the patch itself, there is a path in
history to follow as well.  I.e. the patch itself evolves over time.

Now, when another developer makes an additional change to this patch
in one of the stable versions, it is very helpful to actually be able to
have git tell you where the original patch came from and to follow back
the chain upward.  It allows you to forward/backward port the new change
more easily.

Basically, the normal parent links allow you to follow evolving
snapshots of the complete source-tree, whereas the origin links allow
you to follow evolving snapshots of a patch.
As it happens, the shortest way to describe a patch in git is by
specifying two commits of which the difference is exactly your patch.
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"
