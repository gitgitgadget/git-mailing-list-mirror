From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls? etc.
Date: Sat, 25 Aug 2007 21:37:32 -0700
Message-ID: <7v1wdqud0z.fsf@gitster.siamese.dyndns.org>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 06:38:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP9t0-000236-Ht
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 06:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbXHZEhm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 00:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbXHZEhm
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 00:37:42 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbXHZEhl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 00:37:41 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AD7B3126FDD;
	Sun, 26 Aug 2007 00:38:01 -0400 (EDT)
In-Reply-To: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com>
	(Dmitry Kakurin's message of "Sat, 25 Aug 2007 19:59:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56672>

Dmitry Kakurin <dmitry.kakurin@gmail.com> writes:

> 1. It may be better to combine all these files into one (.gitmeta) with different sections

Merging what has traditionally been known as .gitignore's
capability to attributes has been discussed, and I think it
would make sense in longer term, as 'this path pattern is to be
ignored' is just a special case of a more general attribute.
And "precious" handling would naturally fit there.  However, as
the .gitignore and .git/info/exclude has been as old as git
itself (I think it was introduced around early May 2005), I do
not see us even start talking about deprecating .gitignore.

I do not think .gitmodules fits the model of what .gitattributes
solves.  .gitattributes is about the attribute of paths, while
.gitmodules is about attribute of subprojects, and one attribute
of a subproject is where in the superproject directory hierarchy
it sits at.

I do not know what you are talking about with .gitacls.
Personally I am not interested in turning git into a back-up
program at all, so if you are talking beyond what has already
been suggested as "owner", "group" and "perms" attributes that
could be stored in .gitattributes, I do not think it belongs to
git.

> 2. Storing metadata in regular source-controlled files feels wrong to
> me.

You are free to _feel_ whatever you want without thinking, but
please keep that _feeling_ to yourself, and speak it out after
making it into an _opinion_, which would take a bit of thinking
about it first.  For example, think about what you could do
without confusing a total newbie after the initial clone.  You
cannot avoid chicken-and-egg problem.  I think reading from
index as a fallback measure when work tree file is missing is a
very good compromise we came up recently.  The wish of the user
(i.e. the owner of the work tree) overrides what is in the
index, and the index is how the repository contents are
initially propagated back to the work tree.
