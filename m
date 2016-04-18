From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge branch --no-commit does commit fast forward merges
Date: Mon, 18 Apr 2016 09:36:30 -0700
Message-ID: <xmqqy48a6fht.fsf@gitster.mtv.corp.google.com>
References: <874mb0kkkk.fsf@gmail.com>
	<alpine.DEB.2.20.1604180825170.2967@virtualbox>
	<CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
	<87a8krpehl.fsf@gmail.com>
	<CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christoph Paulik <cpaulik@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 18:36:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asCAL-0001WA-H0
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 18:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbcDRQgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 12:36:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753262AbcDRQge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 12:36:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A187147FC;
	Mon, 18 Apr 2016 12:36:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZowDKhsMwfVLUBh+ZcBgJ14LIEg=; b=aC/81r
	0+rFu3NRO6UTKE6wOxyzJpB2RPLjm5SqnUHi79qEUafuStHm9Z4r4R8xdPp+3/sB
	Gp0MXcS++oYHuYh8SsZj3Zabh61AT0OT8sfTeKs+CgCdDCbt2/9BbkRhwWrQV2J5
	Z+09mQX1L93tt9GKzVi1xUzyLYHSityfLUh2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PuRlpfb4yYt7iRrkXop+YDi3MWgWK1lM
	zeRJp8Ls8E7Q/Zrq+9o6B/wJg9o2XN7j9cbKEuKANnuSkb2Sa//yz7KzbSamzrLF
	buR2hYDYHgJ4yFG9sit7jUHykXPx8JBbmUbVCxIipyFjIJ2YMbnymMcMDmt06DZh
	Xs83M/vDu9o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 917A3147FB;
	Mon, 18 Apr 2016 12:36:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1E87147F9;
	Mon, 18 Apr 2016 12:36:31 -0400 (EDT)
In-Reply-To: <CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
	(Andrew Ardill's message of "Mon, 18 Apr 2016 17:44:13 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B51BD552-0583-11E6-9611-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291808>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> Yes, I think the mis-alignment in expectations comes from a
> technicality in the description you quote. The fast forward is in some
> ways not really counted as a true merge, and no new commits are
> created.

Looking at 123ee3ca (Add --no-commit to git-merge/git-pull.,
2005-11-01) and $gmane/10998 [*1*], it is clear that "--no-commit"
was never meant as a "preview of what would happen".  The original
documentation update at 37465016 (Documentation: -merge and -pull:
describe merge strategies., 2005-11-04) was not great, but was
clarified at d8ae1d10 (Document the --no-commit flag better,
2005-11-04), and that version of text survives to this day.

The real reason why "--no-commit" was added was because back then
"git commit --amend" did not even exist; it appeared only at
b4019f04 (git-commit --amend, 2006-03-02).

What is (and was back then) the recommended way to see what changes
merging the other branch brings in to your branch, then?

There are at least three ways, all of which are better suited than
"--no-commit".

When you want to study and understand what changes other branch 
made since it forked from what you are working on, then

    $ git diff ...other_branch

would give you the change as a single ball of wax [*2*].

If you want to see individual changes explained by their authors,
you can also do

    $ git log -p ..other_branch

Finally, if you want to see what the merge result would look like,
you just do the merge.  Advancing the HEAD by one commit and then
going back once you are done is a cheap operation.  If you want to
avoid updating your branch for real, these days you can even do so
on a detached HEAD, unlike old days back when there was not even
"commit --amend".

    $ git checkout HEAD^0
    $ git merge other_branch

    $ git diff ORIG_HEAD     ;# what changed overall?
    $ git log -p ORIG_HEAD.. ;# inspect individual changes

    $ git checkout - ;# come back to the original branch

> I do think that the --no-commit option should imply --no-ff (as this
> would make the behaviour consistent for end-users). I don't know if
> this is something that would break scripts etc, but if so you could
> make it implied only if we detect a terminal or something like is done
> in other places.

If we were living in an ideal world where "git commit --amend" were
already there in November 2005, we wouldn't have "merge --no-commit"
or "pull --no-commit" in our system today, and in such a world, I
would agree that "try to populate the working tree and the index
with result of a hypothetical merge and stop without updating HEAD
nor creating MERGE_HEAD, only to show what would happen if I merged"
option could be a useful addition to these two commands.  And we may
choose to call such an option "--no-commit".  I agree that such an
option should probably imply "--no-ff".

But we are not living in that world.  Making "--no-commit" (which is
not that "try to populate and show" command) imply "--no-ff" will
break existing scripts.  And unlike cosmetic things like "do we show
in color", changing the behaviour of a command in a fundamental way
based on term and istty() is a sure way to make commands harder to
understand ("it works this way from the terminal, but it works
differently in my script. what is going on?"  is not a question we
are better off not seeing on this list).

Thanks.

[Notes and References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/10998 

*2* Notice the three dots; it is a short-hand for

    $ git diff ^$(git merge-base HEAD other_branch) other_branch
