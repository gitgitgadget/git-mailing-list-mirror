From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Mon, 30 Mar 2015 13:23:49 -0700
Message-ID: <xmqqoanaw7xm.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<5519178A.6080408@gmail.com>
	<xmqqfv8mxuuv.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP0mRYWyJiLvWHuqsVxMRPPtvu-QuWmcD8xXeVOXhwSDA@mail.gmail.com>
	<xmqqtwx2w937.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, sorganov@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 22:24:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcgED-0002Wm-8p
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 22:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbbC3UYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 16:24:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752952AbbC3UYC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 16:24:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC47E45B5E;
	Mon, 30 Mar 2015 16:24:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8gx/7jQqRRrwSdDa9SUJQitIPFE=; b=cQcMh8
	nBD8kdC0dQnJpCle5vVaRPbjrANMDS3y0thXM/EUIPgeTCD3d6NmHkhZT2jedJvN
	+K5++/9QPLVw2XjxM4VPhSbjYy16kADgeORc6LnDwHne4lP/XKQMmiqEzk0kHROh
	85okGBQ4pOBZg8V+jvLfmXfMV9pfsm96ql1Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MtbSxSkLIXSKRywbMK/iQbyo0tpMThHc
	h6xh1NAQYlk4fOGfciYck+xx3vNtyV4j9vuHoPmfDrx2+GaD8N+0+wCNJmtzGxmj
	dZt90fUNvoV1s6ijxktPzWgAJrIIDidbVPoEEA6uuQ3QcZttDYqoG2qK+ledLovT
	FzZtpvJKe2Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E43BA45B5D;
	Mon, 30 Mar 2015 16:24:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2D5945B37;
	Mon, 30 Mar 2015 16:23:50 -0400 (EDT)
In-Reply-To: <xmqqtwx2w937.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 30 Mar 2015 12:58:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD78E026-D71A-11E4-BDD3-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266472>

Junio C Hamano <gitster@pobox.com> writes:

>> Ignoring a merge sounds like dropping the merge commit and all side
>> branches it merges from history.
>
> ... Yes to _some_ people (including you, but not me).  And that is
> why we are trying to improve the text in the documentation, no?

Let's try this again as I do not think there is no need to argue in
the end.

We agree that this is a good patch:

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index d728030..47984e8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -362,7 +362,9 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 
 -p::
 --preserve-merges::
-	Instead of ignoring merges, try to recreate them.
+	Recreate merge commits instead of flattening the history by replaying
+	commits a merge commit introduces. Merge conflict resolutions or manual
+	amendments to merge commits are not preserved.
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good

The primary reason is "ignoring merges" can be read in two ways.

 - Some people, including the ones who wrote the original text (and
   also those who haven't complained to the original text since 2008
   because their reading of the phrase was the same as those who
   wrote it), read it as "We will normally replay what appears in
   the output from 'git log --no-merges', losing what was merged
   where into what.  This option instead keeps the shape of the
   history by considering where the merge commits sit in the
   original history".

 - It can however be read in a different way, namely, "We will
   replay what appears in 'git log --first-parent --no-merges'
   output, ignoring all the side branches".  Some other people,
   including you, find that inconsistent with what is actually
   implemented as a normal rebase.

And we agree the updated text is a good change, because it does not
say "ignore merge" anywhere to invite such a confusion.

I am only reacting to your description to justify that change, which
was:

> Ignoring a merge sounds like ignoring the changes a merge commit
> introduces altogether, as if the merge commit was skipped or dropped from
> history. But that is not what happens if "-p" is not specified.

And we agree that the first part of the sentence, up to
"... altogether", is good.

I am saying "as if" part is reintroducing the confusion.

    as if the merge commit was skipped or dropped from history.

To those who did not interpret the existing "ignoring merges", which
meant to be read as "replay the output of 'log --no-merges'
sequencially", the above exactly says "replay the output of 'log
--no-merges'".  That is the reason why they were happy with the
current text, without seeing how it can be read differently.

To them (including me), the justfication is saying "... sounds like
X, as if Y, but it is wrong" using Y that is completely opposite of
X, even they would agree that X is a wrong interpretation caused by
a non-optimal phrasing.

That is why I suggested to avoid "merge commit was skipped or
dropped" in the description and instead say "as if the side branch
that was merged was skipped or dropped".

The following may be agreeable to both camps of people, those who
read "ignoring merge" to mean "log --no-merges" and those who read
it to mean "log --first-parent --no-merges", I would think.

-- >8 --
From: Sebastian Schuberth <sschuberth@gmail.com>
Date: Mon, 30 Mar 2015 11:29:46 +0200
Subject docs: clarify what git-rebase's "-p" / "--preserve-merges" does

Ignoring a merge can be read as ignoring the changes a merge commit
introduces altogether, as if the entire side branch the merge commit
merged was removed from the history.  But that is not what happens
if "-p" is not specified.  What happens is that the individual
commits a merge commit introduces are replayed in order, and only
any possible merge conflict resolutions or manual amendments to the
merge commit are ignored.

Get this straight in the docs.

Also, do not say that merge commits are *tried* to be recreated. As that is
true almost everywhere it is better left unsaid.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 Documentation/git-rebase.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index d728030..47984e8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -362,7 +362,9 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
 
 -p::
 --preserve-merges::
-	Instead of ignoring merges, try to recreate them.
+	Recreate merge commits instead of flattening the history by replaying
+	commits a merge commit introduces. Merge conflict resolutions or manual
+	amendments to merge commits are not preserved.
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
