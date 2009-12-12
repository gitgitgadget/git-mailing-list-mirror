From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/7] reset: add option "--keep" to "git reset"
Date: Sat, 12 Dec 2009 13:46:20 -0800
Message-ID: <7viqcbn9w3.fsf@alter.siamese.dyndns.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
 <20091212043259.3930.21831.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:29:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJdHM-0005Q8-KC
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 02:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933423AbZLMB24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 20:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933429AbZLMB2z
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 20:28:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33246 "HELO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933421AbZLMB2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 20:28:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E83008721D;
	Sat, 12 Dec 2009 16:46:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=bnSIX/esH/8O+H3hZI4hhfM6nJs=; b=PmV8r/OOL3sEQHzscHucrk/
	BlrZj6FxNC9+Kq05XLbdyld8G4IyRfhds9OIJzunAhT+GXgHW4F0MiMZN4sn+wTT
	/wNA9fvxFAabe4j2eOb58WYdlHk/vMU/aXrJw+aHkc6npIl+fd2GsZ6YjZmxA+UV
	L6n4WDbIVb5hP2/VVomk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=UxUTkl6rTFsrcGD/PLawWV/OKD3xNIe6O3eb3ccmMotcwXOhe
	+k+sgL5Wwv023BoLxEZXisORZekoPt5jKOLVW8BBxy3+yCMWJvBd8ezZMbtGowgf
	AfWfsEuQrmGj5PaDU0vnRN96IbMy//Nxxo9qeXI/saRqp4c9uNf0Qz1Tx4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34A5E8721B;
	Sat, 12 Dec 2009 16:46:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB39587219; Sat, 12 Dec
 2009 16:46:21 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2CB2C56-E767-11DE-B093-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135143>

Christian Couder <chriscool@tuxfamily.org> writes:

> The purpose of this new option is to discard some of the last commits
> but to keep current changes in the work tree.
>
> The use case is when you work on something and commit that work. And
> then you work on something else that touches other files, but you don't
> commit it yet. Then you realize that what you commited when you worked
> on the first thing is not good or belongs to another branch.
>
> So you want to get rid of the previous commits (at least in the current
> branch) but you want to make sure that you keep the changes you have in
> the work tree. And you are pretty sure that your changes are independent
> from what you previously commited, so you don't want the reset to
> succeed if the previous commits changed a file that you also changed in
> your work tree.
>
> The "--keep" option will do what you want.

Having two paragraphs that describe the use case near the top is a big
improvement from older rounds, but this one line is more irritating than
useful, as it tries to be convincing only by being repetitive.  The only
new information it adds relative to the first two lines is its name.  The
true convincing argument immediately follows in the form of the table
below anyway, so I'd drop this line if I were you.

> The table below shows what happens when running "git reset --option
> target" to reset the HEAD to another commit (as a special case "target"
> could be the same as HEAD) in the cases where "--merge" and "--keep"
> behave differently.
>
> working index HEAD target         working index HEAD
> ----------------------------------------------------
>   A      B     C     D   --keep    (disallowed)
>                          --merge   (disallowed)

Ok. the user has partially updated the index and has further changes; we
don't want to lose either of them.  During a failed merge, this cannot
happen, so it is a good safety measure on "--merge" side as well.

>   A      B     C     C   --keep     A      C     C
>                          --merge   (disallowed)

The user started working based on C, and has partially updated the index.
This cannot have come from a failed automerge because A != B, so using
"reset --merge" is likely to be a mistake and we should disallow it as a
safety measure.

>   B      B     C     D   --keep    (disallowed)
>                          --merge    C      C     C

For --keep this is the same as the first case (except that the "partially
updated the index" happened to be "100% pertially") and it makes sense to
disallow it.

However, I think --merge _should_ have D (target) in all of the three in
the result in this case, as I mentioned in my response to [PATCH 3/7].  Is
that "the bug" you talked about there?

>   B      B     C     C   --keep     B      C     C
>                          --merge    C      C     C

A special case of the second one for --keep.  For --merge, B can only have
come from the previous merge operation we are resetting away, and matching
all three result to the "C", which is the target, is the right thing to do.

> So as can be seen in the table, "--merge" can discard changes in the
> working tree, while "--keep" does not.  So if one wants to avoid using
> "git stash" before and after using "git reset" to save current changes,
> it is better to use "--keep" rather than "--merge".

This is a very flawed and misleading description.  These two options serve
two entirely different purposes and use cases, but your "if one wants to
avoid using ... to save current changes" is too broad and does not
distinguish between the two. "--keep" option is valid (or "better") for
only one of them, while it is absolutely the wrong option to use for the
other one.  So it may be "better" only half the time and it is wrong in
the other half.

The precondition of using a --merge is the scenario Linus described in
9e8ecea (Add 'merge' mode to 'git reset', 2008-12-01).  You started some
mergy operation and ended up in a state where all the differences, either
merged or unmerged, between the HEAD and the index came from the mergy
operation.  Also the paths in the work tree that correspond to the index
entries with differences from HEAD are modified by the mergy operation
(either updated with a cleanly resolved merge, or with conflict markers)
and do not match HEAD when "reset --merge" is run, but it is guaranteed
that you didn't have any local modification to them before the mergy
operation.  You do want to reset these changes to the work tree away,
while keeping the changes you had before the mergy operation.

"--merge" not only _can_ (as in "has the risk to") discard changes, but in
the "failed merge" scenario, it is absolutely the right thing to do to
discard the changes in the work tree for the paths that have differences
between HEAD and index and to update them to that of the target.  Not
updating like "--keep" does is not "better" but is simply _wrong_.

The use case "--keep" wants to support is very different (and you have a
good description near the beginning of the commit log message for people
to judge if the intended use case makes sense).  For it, discarding the
changes to the work tree is a wrong thing to do.

> The following table shows what happens on unmerged entries:
>
> working index HEAD target         working index HEAD
> ----------------------------------------------------
>  X       U     A    B     --keep   X       B     B
>                           --merge  X       B     B
>  X       U     A    A     --keep   X       A     A
>                           --merge (disallowed)
>
> In this table X can be any state and U means an unmerged entry.

I am wondering if we should disallow "--keep" if we see unmerged entries
in the index as a minimum safety measure.  Failing "reset --keep" when an
unmerged entry exists in the index will save people who are trying to
discard a failed merge (i.e. who should have used --merge) but was somehow
fooled into thinking that "--keep" is a better "--merge".

It also is tempting to say that we should forbid "reset --merge" without
an unmerged entry in the index, but that wouldn't work.  A mergy operation
would have left unmerged entries in the index initially before giving the
control back to the user, but the user may have used "edit && git add" to
resolve them, and then decided that it is not worth committing.  By the
time "reset --merge" is run, there may not be any unmerged path left in
the index.

I am suggesting extra safety measures primarily because I am worried that
people will get confused by these two similar looking options that are
meant for entirely different use cases.  An obvious alternative solution
to avoid the confusion is not to add "--keep" in the first place.  While I
think that is rather a cop-out than a solution, it might make more sense.
It is hopeless to educate users to pick the right one, if even the author
of the new option mistakenly thinks that "--keep is merely a better
version of --merge".

My preference is at this point to first have patches [1/7] to [3/7] to
update "reset --merge" (I am not sure about the "--mixed in $GIT_DIR"
change, though), with a new follow-up patch [3.5/7] to fix "reset --merge"
to reset paths that were cloberred by the merge to the target (not HEAD),
and start cooking these changes in 'pu' and then 'next'.

That will lay groundwork of using unpack_trees() in "reset" and after they
stabilize, build new modes like "--keep" on top of it.
