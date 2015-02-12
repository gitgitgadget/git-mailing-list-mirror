From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 13:23:17 -0800
Message-ID: <xmqq8ug2rfi2.fsf@gitster.dls.corp.google.com>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
	<20150212092824.GA19626@peff.net>
	<xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
	<CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: David Glasser <glasser@davidglasser.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:23:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM1EL-0004zb-0t
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 22:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbbBLVXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 16:23:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751038AbbBLVXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 16:23:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1872383AE;
	Thu, 12 Feb 2015 16:23:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=blYUd9i+oDp/BMjzUYM0O82XY/g=; b=K9skR6
	apZMgADN5d5hHUiGcyLSm2VlaUQ/EGU2s5kvCw2clzHXQWwXhcFlWfSOiYdYCTtv
	iTYTvYmgBCFhm6XzWsKpJEUIprZC4VpUYPg4KowD1lY8qglm+mo1HFxu+/IvuRqU
	EVqZGA7HpfJGoBPJVJMqdCh4WZ+JfK9bbsY58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pvqombg4jLXGA73SYFQfUBLIhYPmVIbn
	lCoMOtEqijbYEDFM/dN1zqqbY+qxDwPfQfM7IcGxTXm3ch6myLZnM8cQl/4NSk2m
	x+9XPHLCJ+SDSJV6TK9EXUQFEsx3qFRwNon8ZNUguED3l5gMnvOOysH+Hw1RD10a
	iB0CoHfWbpY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D918B383AD;
	Thu, 12 Feb 2015 16:23:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 612FD383A6;
	Thu, 12 Feb 2015 16:23:18 -0500 (EST)
In-Reply-To: <CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com>
	(David Glasser's message of "Thu, 12 Feb 2015 12:53:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5CF660D8-B2FD-11E4-A64F-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263771>

David Glasser <glasser@davidglasser.net> writes:

> Well, using -c appears to override SQUASH_MSG entirely; it replaces
> the message as well as the author.  Often I do want to make my own
> message based on all the messages provided by the submitter.  (And
> typically the branch's tip is the least useful message anyway: it's
> usually something like "respond to code review".)

I wonder if there is a bug in the workflow.  Isn't the contributor
forcing more work to the integrator that way and making it a
responsibility of the integrator to squash multiple commits into
one, instead of asking a cleaned-up branch to be merged in the first
place?  It is a key to keep your project scalable to push as much
work out of the integrator's plate to the contributors' plates.

But that is an unrelated tangent.  Among the ideas floated in the
thread, I tend to like something like what Peff mentioned earlier.

> I assume you are already munging in your editor the template provided by
> "git commit" after the squash? What would be really nice, IMHO, is if
> there was a way to set the author during that edit (e.g., by moving one
> of the "Author:" lines to the top of the file). That would cover your
> use case, I think, and would also be useful in general.

I don't know if the exact solution Peff mentioned is good [*1*], but
being able to do an equivalent of setting --author="<author>" and
"--date=<date>" from the command line inside the log message editor
would be a huge win.


[Footnote]

*1* You would see

	gostak: do not distim doshes unconditionally

	Usually it is a good idea to let gostak distim doshes,
        but it should cause the program segfault when there is
        no doshes to be distimmed.  Detect this case and error
        out.

	Signed-off-by: David Glasser <glasser@davidglasser.net>

        # Please enter the commit message ...
        #
        # Author:    David Glasser <glasser@davidglasser.net>
        # Date:      Thu, 12 Feb 2015 04:28:24 -0500
        # ...

when you start "git commit --amend" or "git merge --squash", and the
proposal, as I understand it, is to allow you to do this:

        From: David Glasser <glasser@davidglasser.net>
        Date: Thu, 12 Feb 2015 04:28:24 -0500

	gostak: do not distim doshes unconditionally

	Usually it is a good idea to let gostak distim doshes,
        but it should cause the program segfault when there is
        no doshes to be distimmed.  Detect this case and error
        out.

	Signed-off-by: David Glasser <glasser@davidglasser.net>

        # Please enter the commit message ...
        #
        # ...

which is the same format of the _body_ of the message "git am" would
take.  The reason I am not so sure about such a change is that
having to move and edit things would be error prone.  Some may
forget to do s/Author:/From:/ and we would end up having to support
both.  Some existing commit may validly have lines that begin with
these tokens ("git am" does not have such a problem because it is
not the underlying "git commit" or "git commit-tree" that interprets
these in-body headers).  Some users may forget to leave a blank line
between the in-body headers and the subject line.

I suspect that it _might_ work better if we always look for the pair
of "# Author: " and "# Date:" lines (taking the commentchar setting
in to account, of course) immediately at the beginning of the
trailing comment block, and if exists, use that to override the
authorship identity.  If the user does not do anything when running
"git commit --amend", the resulting commit will get the original
authorship.  If the user strips all the lines in the trailing
comment block, we would do the same thing as we have always done and
retain the original authorship.

I dunno.
