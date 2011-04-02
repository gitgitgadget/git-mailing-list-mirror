From: Junio C Hamano <gitster@pobox.com>
Subject: Re* git commit fails under some circumstances
Date: Sat, 02 Apr 2011 12:16:23 -0700
Message-ID: <7vhbagh3aw.fsf@alter.siamese.dyndns.org>
References: <AANLkTikHRM10p9e8XCzuiih7cYtQRG7Az2Qn5qtPzhZJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Sat Apr 02 21:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q66JM-0007ZE-9L
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 21:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628Ab1DBTQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 15:16:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556Ab1DBTQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 15:16:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4D50C52DC;
	Sat,  2 Apr 2011 15:18:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=haIhSWwJN+15QB2etKIov3iR/0M=; b=pSzaJP
	HvXVCXibEQVNdP4mMZwmo1qrYXmfbLAvk2XJ0ps3E5jqAi4aMAIh/wzpcnvRw9kg
	k57xlSeNySGtHvnphPIs4BL+4VfdbRCSnuL5eJJvFQRIFPILEhOB92bZ3TUaKzwx
	nT4VVRXF1igsnf/buDQ7F9bhLRl+4VXHxpR/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KxkIIKzxwCYT6kCUwSXUKuaHArJpkN2h
	8ZphmEHXwwu/aL+lgHplFdVCslEm9hplCeOKilnuJApGqyVeO+lTV/bc8kLHXMHf
	a1upGKNwHCdNV2WZNcHKd3QwsyDuBv1qxVa+szphodmSzUrVW1Q1+g/Awk7sRDDx
	H/ausOCkbBo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A31952DB;
	Sat,  2 Apr 2011 15:18:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BB08852DA; Sat,  2 Apr 2011
 15:18:15 -0400 (EDT)
In-Reply-To: <AANLkTikHRM10p9e8XCzuiih7cYtQRG7Az2Qn5qtPzhZJ@mail.gmail.com>
 (Laszlo Papp's message of "Sat, 2 Apr 2011 17:18:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7BBF5B4-5D5D-11E0-9995-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170658>

Laszlo Papp <djszapi@archlinux.us> writes:

> There are 2 bugs and 1 wish in this case:
> 1) It says "Changes to be committed:", but they are actually not
> committed, there cannot even be committed since they were not added
> "properly". This output is bogus
> 2) error: Error building trees

Thanks.

You gave us a concise reproduction recipe and the output you get from it,
which is far better than what an average new user would do.  But that is
still two out of three of what makes a good bug report.

When you utter the word "bug" (or the word "bogus") to an existing
project, please make it a habit to mention what you think should happen as
well.  This is not limited to git but in any open source project you are
not familiar with in general.

It helps tremendously to have a reproduction recipe and its output to
diagnose certain kinds of issues.  If somebody else tries to run it, and
if it gave results different from the output you are getting, you may have
uncovered some unintended environment dependency bug.

But what if your output matches what the original developers expected to
see?  Possibly after spending many hours to design how the thing ought to
behave, it is possible that they still might not have thought about a
better behaviour in some cases, and you may have an idea to present the
result in a more useful way---and your complaint might be that the current
output does not match that idea of yours.  In such a case, a bug report
that does not state what should be shown stops short of being useful.

When running "commit" and "status" with files marked with "intent to add",
I think there are three possible interpretations of what the user wants to
do.

 (1) I earlier said "I'll decide the exact contents to be committed for
     these paths and tell you by running 'git add' later." when I said
     'git add -N'.  But I forgot to do so before running "git commit".
     Thanks for catching this mistake and erroring out.

 (2) I said "I'll decide the exact content to be committed ... later."
     when I said 'git add -N'. I am running "git commit" now, but I still
     don't know what the final contents for this path should be.  I
     changed my mind, and I do not want to include the addition of these
     paths in the commit I am making.  Please do not error out, but just
     ignore the earlier 'add -N' for now.

 (3) I said "I'll decide the exact content to be committed ... later."
     when I said 'git add -N'. I am running "git commit" now, without
     explicitly telling you with 'git add' about the final contents for
     these paths.  Please take it as an implicit hint that I am happy with
     the contents in the working tree and commit them as if I said 'git
     add' on these paths, but do leave modifications to already tracked
     paths that I haven't added with 'git add'.

The current behaviour of "git commit" that refuse to commit without
telling git what the final contents for these pathse is a very deliberate
design and implementation of (1).

The second one is a possible interpretation, but it is a very error prone
one.  People who want to commit without these new files wouldn't have
marked them with "add -N" in the first place, and (2) feels more like
disabling a useful error checking than making the command useful.  Also it
is a silent bug to behave like (2) to people who expect (3), as they will
only later find out that some of the additions were not committed against
their will.

The third one also is a possible interpretation, but it is a very
inconsistent one.  Why should new paths marked with 'git add -N' be
treated differently from paths that were already tracked and you made
changes to the working tree?  In addition, it is a silent bug to behave
like (3) to people who expect (2), as they will only later find out that
some of the additions were committed against their will.

Note that the user who may want to see variants of (2) and (3) can still
name which paths to include (and to exclude by not naming them):

    $ edit foo bar baz
    $ git add baz
    $ git add -N foo bar
    $ git commit baz foo

or include everything

    $ git commit -a


I thought the above issues through when I wrote "git add -N" and
determined that (1) is the only sane and useful behaviour, and I still
think it is.

Having said all that, we might want to differentiate these paths in the
output from 'status'.  The 'status' command in its current form and
semantics came much later (v1.7.0) than "add -N" (introduced in v1.6.1),
and because "add -N" is such a low-key corner case (adding new paths is
far less frequently done than modifying an existing paths, and showing
only intent to add new paths is even less frequently done), we probably
didn't think about special casing them.

Currently we show these paths as both added for commit (i.e. appears in
the top portion of the verbose output, and in the first column of the -s
output) and having local modification (i.e. appears in the second part or
in the second column, respectively).  For example, here is what I get:

    $ cp COPYING RENAMING
    $ git add -N RENAMING
    $ git status -s
    AM RENAMING
    $ git status
    # ... to be committed ...
    # new file: RENAMING
    # ... have local changes ...
    # modified: RENAMING

We should be able to say something like:

    $ git status -s
    IM RENAMING
    $ git status
    # ... to be committed ...
    # new file: RENAMING (needs 'git add')
    # ... have local changes ...
    # modified: RENAMING

if we don't care about the backward compatibility.

> 3) It would be nice to have one command (with no (git) alias for sure)
> to see the difference like "git diff" but also the new files.

Doesn't "git diff" show the difference for files you told git about via
the "add -N" interface?  After the above "addition" of RENAMING, if I ask
"git diff" (or "git diff HEAD"), I get what I expect to see (addition of
the contents taken from the whole file in the working tree).

Again, please describe what you think should be the right output if it
differs from your expectation.

Also having said that, I notice that "git diff --cached" behaves as if an
empty blob is added in such a case.  I am not sure if we want to special
case this.  After all paths marked with "git add -N" does _not_ have a
concrete contents in the index by definition (as the user told "I'll tell
you later" but hasn't done so), and may want to behave more like unmerged
entries for certain operations (i.e. the path does exist, but comparing
something with it does not have a usual meaning, etc.)
