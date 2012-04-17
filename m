From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 17 Apr 2012 14:37:37 -0400
Message-ID: <201204171837.q3HIbbcW013784@no.baka.org>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com> <m3hawjagw9.fsf@localhost.localdomain> <nng3983phhc.fsf@transit.us.cray.com>
        <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Git Users <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Namit Bhalla <namitbhalla@yahoo.com>, Dave <dag@cray.com>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:37:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKDHe-0002fW-7j
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab2DQSho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 14:37:44 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:43277 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab2DQShn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 14:37:43 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q3HIbcM2005430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 17 Apr 2012 14:37:38 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q3HIbbcW013784;
	Tue, 17 Apr 2012 14:37:37 -0400
In-reply-to: <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
Comments: In reply to a message from "Hilco Wijbenga <hilco.wijbenga@gmail.com>" dated "Tue, 17 Apr 2012 10:29:56 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195789>


In message <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>, Hilco Wijbenga writes:

    On 16 April 2012 13:08,  <dag@cray.com> wrote:
    > Jakub Narebski <jnareb@gmail.com> writes:
    >> Put reusable library in its own repository, and use submodules to link
    >> it up to project-a and project-b repositories.

    If you really have only one or two libraries then submodules will work
    just fine but if you have quite a few (we had around 50 when we moved
    away from submodules) you will find it pretty much unworkable. [...]
    Branches are per submodule but you want them for all
    submodules. You might want to look into git-slave if you want to
    go this route.

    In general, I do not think the blanket statement "one repo per
    project" is good advice. If projects depend on each other they should
    be in the same repo. At least with the current support in GIt for
    including separate projects. Please note that I'm not disagreeing with
    the notion "one repo per project" itself. It's just not supported well
    enough to be feasible if you have a fairly large group of projects
    that depend on each other.

As you mentioned, this is exactly the environment that gitslave was
designed for.  It provides the flexibility to work on the subprojects
as if they were standalone independent git repositories (which of
course they are) or treat the entire superproject as one giant git
repository (with only a few cracks showing through).  All gitslave
commands are just git commands (s/^git\s/gits /) so training to use it is
rather easy.

Unlike with git-submodules there is no strict binding between the
parent repo's commits and the sub-project's commits except at tag
boundaries.  This gives you the flexibility of person A saying that A
is master and B is underneath it while person B says that B is master
and A is underneath it (or alternatively you can also say that A
include B plus whatever B includes).  However, I would in general
recommend that the common library be factored out and be a child of A
and B.  gitslave makes it trivial to work with federated git
repositories, if you can handle only having binding between
repositories at tag boundaries.


					-Seth Robertson
