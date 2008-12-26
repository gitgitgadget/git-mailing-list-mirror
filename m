From: Junio C Hamano <gitster@pobox.com>
Subject: Re: a few scenarios before I create my first repo [Scanned]
Date: Thu, 25 Dec 2008 16:46:04 -0800
Message-ID: <7vabajrcfn.fsf@gitster.siamese.dyndns.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D00@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Conor Rafferty" <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 26 01:47:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG0rT-00081P-9Z
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 01:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbYLZAqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 19:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbYLZAqL
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 19:46:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbYLZAqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 19:46:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C5B38A549;
	Thu, 25 Dec 2008 19:46:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 625E78A547; Thu,
 25 Dec 2008 19:46:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 961138D2-D2E6-11DD-935D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103914>

What's [scanned]?

"Conor Rafferty" <conor.rafferty@altmore.co.uk> writes:

> (1a) Do I need to install windows git on the same machine I want to
> store the files on ?  Or can I install git on my workstation PC and
> create the repo on the server ?

The model employed by git is not "client working with centralized server".
On whichever machine you want to be recording your changes (aka "running
'git commit'"), you would need to have git installed.

> (1b) if i create a repo on my office PC, can it easily be moved
> (including all history) to another PC (e.g. LAN server) if we decide to
> implement git across the team (If not, or its inconvenient, I need to
> create the repo on the server)

git is a distributed source code management system.  People often deploy
one (or more, in hierarchical fashion in an advanced set-up) bare server
repository for everybody to meet and synchronize.  Each developer has one
repository (or more) on his or her own on his or her machines.  Most
notably, if you work on your notebook and on your desktop (i.e. two
machines), you will have (at least) one repository on each of them [*1*].

> (2) if i create a repo on my work PC, can it easily be migrated
> (including all history) to a repo on github (etc.) ?

I do not know about github in particular (that's #github question) but in
principle, yes.  Easy exchange of development histories across
repositories is the whole point of distributedness.

> (3) if I create a repo and commit the first baseline, can I later create
> an ancestor commit to that baseline, if I subsequently find an older
> version of the project lying around on the file system (or, same concept
> i guess, if i find a project version that sits between say version v1.0
> and v1.1 (where v1.0 is the parent tag of v1.1) can i interleave the
> project files as say v1.01.

You can graft the older ones behind the root commit and filter-branch the
result to cast the graft in stone.  You are strongly recommended to do
that in one repository first, and have reasonable level of confidence in
the result before you publish it to other repositories, as running
filter-branch to rewrite the history after people (or yourself) cloned the
history to multiple places would cause trouble to thoese .

For more details, see the user-manual.  Don't dive into manual pages for
individual commands, which are for people who already understood the basic
concepts in the user manual.


[Footnote]

*1* Maybe we should change our pricing structure to be based on the number
of repositories, not on the number of users.  Currently we charge $0 per
user, but we should change $0 per repository ;-)
