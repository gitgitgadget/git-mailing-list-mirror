From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Nesting a submodule inside of another...
Date: Thu, 14 Jul 2011 10:33:37 -0400
Message-ID: <201107141433.p6EEXbb9023826@no.baka.org>
References: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com> <4E1C9F21.6070300@web.de> <CAEBDL5U0F+QaqhW92i-s82-C9fj2knp6JPNtNvgdJY68kRYwWQ@mail.gmail.com> <4E1E0C27.60903@web.de>
        <CAEBDL5VUPE9YCX1C4pqkjb+EODkAWo9h774B=Jv5eUNbocMuZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Git mailing list <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 17:07:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhNW4-0006I2-OO
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 17:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808Ab1GNPHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 11:07:47 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:33767 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591Ab1GNPHq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 11:07:46 -0400
X-Greylist: delayed 2047 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jul 2011 11:07:46 EDT
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p6EEXbKG027282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Jul 2011 10:33:37 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p6EEXbb9023826;
	Thu, 14 Jul 2011 10:33:37 -0400
In-reply-to: <CAEBDL5VUPE9YCX1C4pqkjb+EODkAWo9h774B=Jv5eUNbocMuZQ@mail.gmail.com>
Comments: In reply to a message from "John Szakmeister <john@szakmeister.net>" dated "Thu, 14 Jul 2011 05:36:46 -0400."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177132>


In message <CAEBDL5VUPE9YCX1C4pqkjb+EODkAWo9h774B=Jv5eUNbocMuZQ@mail.gmail.com>, John Szakmeister writes:

    > I've got a project where we have several frameworks involved, and
    > external modules we want to pull into the framework tree.  We'd like
    > to make use of submodules and have something like this:
    >      top-level/<-- .gitmodules lives here
    >          src/
    >          framework1/<-- a submodule
    >              module/<-- another submodule
    >          framework2/<-- a submodule
    >              module2/<-- another submodule

    Again, I don't see how the submodule needs to be aware of the
    superproject.  In this case, it'd be the responsibility of the
    superproject to setup whatever is necessary at 'git submodule
    init/add'.  I don't see how the submodule *must* know about the
    superproject for it to succeed.  I see the opposite, the superproject
    needs to communicate some information down to the submodule, but I
    don't see the reverse.

    What I'm hearing is that while it may be possible, the idea of
    violating the concept that the "subrepo is standalone" is
    unacceptable.  Which means, unfortunately, git isn't a solution for us
    in this case.

You might find that gitslave (http://gitslave.sf.net) might be a
better solution for you than git-submodules in this case.  It works
better for many workflows (and worse for others) but is much simpler
to understand since with gitslave you have JBOR (just a bunch of
repositories) with a program which can be thought of as running the
requested git command over each repository in turn.  Gitslave thus has
a loose binding between the repositories, and you can only guarantee
the relationship between repositories at tagged locations, though in
practice this isn't a major concern.

gitslave supports nested repositories (and recursive gitslave
repositories, but those are different).  With gitslave nested
repositories it is also true that you would have to have a
supplemental gitignore entry in framework1 (which gitslave will
create).

If you have any questions, please let me know.

					-Seth Robertson
