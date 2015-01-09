From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cat-file: Remove unused includes
Date: Fri, 09 Jan 2015 11:07:02 -0800
Message-ID: <xmqqiogfdb8p.fsf@gitster.dls.corp.google.com>
References: <1420743366-14926-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq1tn5f441.fsf@gitster.dls.corp.google.com>
	<CANCZXo7_yUT4x5fBvwNdc7d+ew5M7yaayGE_yXaeLxiPHzK9GA@mail.gmail.com>
	<CANCZXo4=TydW=DH9pU4aTOCZRgMnZr1inhmwNPUaDQZMMYt4Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 20:14:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9etv-00051j-8q
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 20:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbbAITHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 14:07:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751485AbbAITHG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 14:07:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C88C2DFD0;
	Fri,  9 Jan 2015 14:07:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nw0dP0sRhGjO6cQQ+Cw6lkgEbNM=; b=UtvRUb
	/BBGT8wYktLGBA6RsP5XBxEqfO8V+tUR6svtAxVsNNEb/Axx1QHXradbNFYi7RRV
	pfCzLz+EB4qTkk9xmtwNmVy9JgzHGd+6Fpc//8T09b3xORdufon0hmNKQrigiV4S
	lhzywRFtEHdUKiCyHUrbZUEAAcJeW11+jLhwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U6pIlalGZpsdk1fqWCL5jgWNbqGl0uoj
	ewQucSdplgsWMd5UNHLkPtnbphiA/WdCoPNpTsAU9dlrJiMHmE+TtSYdmOtViuqD
	+w3eHK8AQ+/No/IguujKmie3iQwOlpktuHrvwGvpB23iYTYiPEuRjqhmE3HvsiYa
	ceAFFS2999Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 536602DFCF;
	Fri,  9 Jan 2015 14:07:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5C172DFCE;
	Fri,  9 Jan 2015 14:07:03 -0500 (EST)
In-Reply-To: <CANCZXo4=TydW=DH9pU4aTOCZRgMnZr1inhmwNPUaDQZMMYt4Ww@mail.gmail.com>
	(Alexander Kuleshov's message of "Fri, 9 Jan 2015 14:21:30 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B271B3FE-9832-11E4-B67C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262239>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> userdiff.h used in git_cat_file_config for getting textconv driver

Yeah, but you know that I already know that when I pointed out about
e5fba602 in the message you are responding to.  And your patch does
not remove it, we still need to include it; we do not need to dig
that part of the change.

Two corrections to my message you are responding to are in order.

I said:

>>> I didn't dig further to find out the answer to the last question,
>>> but a patch to remove these include should explain these in its log
>>> message, I would think.

but I think "should" was a bit too strong, especially without
explaining why.  "It would have been nicer with such explanation"
is what I should have said.

And while on the topic, I should explain why.

Most of the time, removal of "#include" is done because we used to
include the header for a good reason (i.e. the source used to need
something that is declared in it) but with a code change to remove
the last such reference we no longer need to include it.  Commit
6d63baa4 (prio-queue: factor out compare and swap operations,
2014-07-14) [*1*] is an example.  We used to mention 'struct commit'
in the implementation of prio-queue, but the commit realizes that
the use of prio-queue does not have to be limited to queuing
commits, and removes the need to include "commit.h".

But this clean-up patch removes #includes without doing anything
else.  It is clear we _can_ remove them; the submitter of such a
patch would have made sure that the code compiles and links fine
without these includes.  So "Why can we remove them?" is not a very
interesting question.

The interesting question is "Why remove them *now*?"  Why do we have
these unused #includes?  Were they unnecessary from the start?  Were
they necessary but during the course of the development, we did
something else that made them unnecessary and forgot to remove them?

These are the natural questions that somebody reading a clean-up
patch like this one may ask, and that is why I think it would have
been nice if the proposed log message answered them before being
asked.

So here is an update after I dug a bit more.

 - "exec_cmd.h" became unnecessary at b931aa5a (Call builtin ls-tree
   in git-cat-file -p, 2006-05-26), when it changed an earlier code
   that used to delegate tree display to "ls-tree" via the
   run_command() interface (hence needing "exec_cmd.h") to a direct
   call to cmd_ls_tree().  We should have removed the include in the
   same commit, but we forgot to do so.

 - "diff.h" was added at e5fba602 (textconv: support for cat_file,
   2010-06-15), together with "userdiff.h", but "userdiff.h" can be
   included without including "diff.h"; the header was unnecessary
   from the start.

 - "tag.h" and "tree.h" was necessary since 8e440259 (Use blob_,
   commit_, tag_, and tree_type throughout., 2006-04-02) as the code
   used to check the type of object by comparing typename with
   tree_type and tag_type (pointers to extern strings).

   21666f1a (convert object type handling from a string to a number,
   2007-02-26) made these <type>_type strings unnecessary, and it
   could have switched to include "object.h" to use typename(), but
   it forgot to do so.  Because "tag.h" and "tree.h" include
   "object.h", it did not need to include "object.h" in order to
   start using typename().

   In today's code, we do not even have to include "object.h" after
   removing these two #includes, because "builtin.h" includes
   "commit.h" which in turn includes "object.h" these days.  This
   happened at 7b9c0a69 (git-commit-tree: make it usable from other
   builtins, 2008-07-01).


Having said all that, what the above satisifies is mostly curiosity,
and gives whatever value Postmortems have by analysing what we could
have done better.

It is OK to omit the postmortem and instead just say "These are no
longer used; remove them.", which was your original.  So I shouldn't
have said "*should* explain".


[Footnote]

*1* I pulled this randomly from "git log -Sinclude --grep=include"
    output.
