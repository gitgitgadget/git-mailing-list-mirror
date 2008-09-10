From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert, and more about porcelain-level metadata
Date: Wed, 10 Sep 2008 17:15:42 +0200
Message-ID: <20080910151542.GA10523@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080909230525.GC10360@machine.or.cz> <48C794D6.20001@gnu.org> <20080910143329.GE28210@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:17:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdRR5-00049j-Ry
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 17:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbYIJPPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 11:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbYIJPPo
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 11:15:44 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:34993 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbYIJPPn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 11:15:43 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 6C8A25465; Wed, 10 Sep 2008 17:15:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080910143329.GE28210@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95526>

Dmitry Potapov wrote:
>On Wed, Sep 10, 2008 at 11:35:18AM +0200, Paolo Bonzini wrote:
>> Another problem is that in some projects actually there are two "maint"
>> branches (e.g. currently GCC 4.2 and GCC 4.3), and most developers do
>> not care about what goes in the older "maint" branch; they develop for
>> trunk and for the newer "maint" branch, and then one person comes and
>> cherry-picks into the older "maint" branch.  This has two problems:

>> 1) Having to fork topic branches off the older branch would force extra
>> testing on the developers.

>If a branch is meant to included in the oldest version, it must be
>tested with that version anyway, and it is better when it is written for
>the old version, because functions tend to be more backward compatible
>than forward compatible. In other words, functions may often acquire
>some extra functionality over time without changing their signature, so
>the code written for a new version will merge without any conflict to
>the old one, but it won't work correctly under some conditions. It is
>certainly possible to have a problem in the opposite direction, but it
>is much less likely, and usually bugs introduced in the development
>version are not as bad as destabilizing a stable branch. Thus starting
>branch that is clearly meant for inclusion to the old version from that
>version is the right thing do.

>Of course, if you have more than one stable branch for a long time then
>you may want some branches forked from the new stable. You can do that
>by merging uninteresting changes from the new stable with the 'ours'
>strategy (so they will be ignored), and after that merging actually
>interesting features from the new stable.

>In contrast to cherry-picking, the real merge creates the history that
>can be easily visualized and understood.

Could you explain how the above mechanisms work based on the following
cherry-pick action:

A -- B -- C -- D -- L
      \            /
       E -- F -- G -- H -- K

D is the stable branch.
K is the development branch.
G is cherry-picked and applied to D producing L.
The origin link of L would have contained (G, F).

How would such a workflow be implemented using the temporary branches
you describe?

>If you clearly mark all bugs in the commit message, there will be no
>problem to find them by grepping log. There is a lot of potentially

Sometimes they're not bugs, yet they still are backported and thus carry
no special marks.

>useful information, and the 'origin' link is just one of many. It may

True, but it's one of the few machine-useable ones.

>be okay to do some general mechanism for custom commit attributes (if
>it's really necessary),

That's the problem, a general mechanism is undesirable, that we already
have the free-form textfield for.

> but making a hack for one specific item of
>information feels very wrong.

It's a rather well-defined usefull property (which precludes it from
being a hack, I suppose).
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"
