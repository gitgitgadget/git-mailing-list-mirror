From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 18 Jul 2008 02:43:00 -0700
Message-ID: <7v63r38r4r.fsf@gitster.siamese.dyndns.org>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
 <20080718182010.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJmVW-00086W-Px
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbYGRJnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbYGRJnL
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:43:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbYGRJnK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:43:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A1003145C;
	Fri, 18 Jul 2008 05:43:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AFEFF3145B; Fri, 18 Jul 2008 05:43:02 -0400 (EDT)
In-Reply-To: <20080718182010.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri, 18 Jul 2008 18:20:10 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC806E34-54AD-11DD-95AC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89021>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> ... I do not think it is a sensible
>> thing to say "let's take as much automerge results as possible to salvage
>> our changes where they do not overlap with what the upstream did, but I
>> would give up our changes to places that the upstream also touched,
>> because I do not understand what they did well enough to be able to
>> resolve the merge conflicts correctly", and "merge -Xtheirs" is exactly
>> that.
>
> I do not know if "I do not understand what they did well enough" is the
> only reason people would want to use that feature. Isn't it better to
> let people decide that for themselves?

We have been saying that we will give long enough rope to people, but at
the same time I believe there are things that the world is better without,
and a feature that would only encourage a bad workflow is one of them.
The way I try to tell such a (mis)feature from a feature that can be
useful to people other than myself is to ask people why they would want
such a feature and what their response to possible downsides of such a
feature.

Don't get me wrong.  Choice is good, and it is also good that some people
may choose differently from me.  After all, we are different people with
different workflows.

But they should be able to explain the reason why they choose something
clearly, at least well enough to convince themselves to choose it.  If
they can't come up with a rational explanation, it becomes an irrational
"because I want to" (and "because I can, now that you have already coded
it").  That leads to feeping creaturism and a bad feature that the world
is better without.

I haven't heard an explanation other than the one I said above, and I do
not think that explanation is rational.

	Side note. Even though I invented rerere and it turned out to be a
	great ti[mp]esaver, I do want to validate the reused resolution
	makes sense in the new context every time rerere does its job.
	Recently Ingo wanted the auto resolution to be staged
	automatically, and rerere.autoupdate was born.  I was initially
	very much against it, but his description of the workflow where it
	would be useful was convincing enough.  This "convincing" does not
	have to be "Yeah, it's useful to me as well; thanks for explaining
	it to me".  Even though my workflow might never be helped with
	such a feature, I can see that the different workflow he presented
	would be useful to people other than myself, and I could agree
	that the new feature would help such a workflow.  This was a good
	example of "choosing something I initially thought would be
	detrimental with a good reason, and with a good explanation making
	me realize that my initial thought was too narrow".

> I think such a documentation will help people to decide if 'theirs'
> option makes sense for their workflow.

So here it is.

-- >8 --
[PATCH] Document that merge strategies can now take their own options

Also document the recently added -Xtheirs, -Xours and -Xsubtree[=path]
options to the merge-recursive strategy.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/merge-options.txt    |    4 ++++
 Documentation/merge-strategies.txt |   26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index ffbc6e9..96aec48 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -58,3 +58,7 @@
 	If there is no `-s` option, a built-in list of strategies
 	is used instead (`git-merge-recursive` when merging a single
 	head, `git-merge-octopus` otherwise).
+
+-X<option>::
+	Pass merge strategy specific option through to the merge
+	strategy.
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 1276f85..39ff0a8 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -1,6 +1,11 @@
 MERGE STRATEGIES
 ----------------
 
+The merge mechanism ('git-merge' and 'git-pull' commands) allows the
+backend 'merge strategies' to be chosen with `-s` option.  Some strategies
+can also take their own options, which can be passed by giving `-X<option>`
+arguments to 'git-merge' and/or 'git-pull'.
+
 resolve::
 	This can only resolve two heads (i.e. the current branch
 	and another branch you pulled from) using 3-way merge
@@ -20,6 +25,27 @@ recursive::
 	Additionally this can detect and handle merges involving
 	renames.  This is the default merge strategy when
 	pulling or merging one branch.
++
+The 'recursive' strategy can take the following options:
+
+ours;;
+	This option forces conflicting hunks to be auto-resolved cleanly by
+	favoring 'our' version.  Changes from the other tree that do not
+	conflict with our side are reflected to the merge result.
++
+This should not be confused with the 'ours' merge strategy, which does not
+even look at what the other tree contains at all.  IOW, it discards everything
+the other tree did, declaring 'our' history contains all that happened in it.
+
+theirs;;
+	This is opposite of 'ours'.
+
+subtree[=path];;
+	This option is a more advanced form of 'subtree' strategy, where
+	the strategy makes a guess on how two trees must be shifted to
+	match with each other when merging.  Instead, the specified path
+	is prefixed (or stripped from the beginning) to make the shape of
+	two trees to match.
 
 octopus::
 	This resolves more than two-head case, but refuses to do
-- 
1.5.6.3.573.gd2d2
