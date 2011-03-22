From: in-gitvger@baka.org
Subject: Re: dependable submodules
Date: Tue, 22 Mar 2011 10:28:10 -0400
Message-ID: <201103221428.p2MESAkG018553@no.baka.org>
References: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com> <7vd3lmv2k1.fsf@alter.siamese.dyndns.org> <AANLkTin8Mr5xLtLqHSVuEOzzfmqnR2LU5vDdVfPprNXn@mail.gmail.com> <4D877A70.8070907@jku.at>
        <AANLkTikv+Wf_nSt0GZj0WgPjpbk6Kr_WG-ueO6US9bUM@mail.gmail.com>
Cc: Robert Pollak <robert.pollak@jku.at>, git <git@vger.kernel.org>,
	apenwarr@gmail.com
To: Daniel <daniel@netwalk.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 15:28:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q22Zd-0005Sb-0O
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 15:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab1CVO2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 10:28:36 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:33190 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754473Ab1CVO2e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 10:28:34 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p2MESC2U006448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Mar 2011 10:28:12 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p2MESAkG018553;
	Tue, 22 Mar 2011 10:28:11 -0400
In-reply-to: <AANLkTikv+Wf_nSt0GZj0WgPjpbk6Kr_WG-ueO6US9bUM@mail.gmail.com>
Comments: In reply to a message from "Daniel <daniel@netwalk.org>" dated "Mon, 21 Mar 2011 20:56:52 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169740>


In message <AANLkTikv+Wf_nSt0GZj0WgPjpbk6Kr_WG-ueO6US9bUM@mail.gmail.com>, Dani
el writes:

    I tried git-subtree. thanks but this is not what I wanted. This
    removed the .git dir for the subtree and hence updating the subtree is
    not easy.

    I want the functionality of git submodule except that I don't want the
    version checked in as part of the superproject to have to be fetched
    remotely.

Could "remotely" be a local shadow master?  gitslave is another option
to git-submodules and git subtree merge for provide a superproject
with attached slaves, but like git submodules it does require fetching
from "upstream".  However, there is nothing requiring that "upstream"
be the true Internet upstream.  It could be a local shadow copy of the
master.  I describe this scenario in more detail on the gitslave home
page starting with the third paragraph under "Gitslave is not
perfect".  I wrote this with gitslave in mind, but there is nothing
stopping you from using the concept with git-submodules (aside from
the pain of the submodule update pain added to the shadow repository
update pain breeding).

However, if you really really have a good reason to want *everything*
in one repo, perhaps you could play games with branches and subtree
merge.  For each slave repository, create a new branch with the
content you want (or do a merge from the slave onto the new branch to
get the history or whatever).  Then attach the local repository to
itself using git-submodules (bonus points if you can use a
repository-relative URL), set the correct SHA corresponding to the
branch of the "slave", and then (if it works, and I don't see why it
would not) you are all done.  I would hate to have to use and update
such a repository, though.

					-Seth Robertson
