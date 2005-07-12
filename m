From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: [PATCH] tagger id
Date: Tue, 12 Jul 2005 23:42:13 +0000 (UTC)
Message-ID: <loom.20050713T011619-369@post.gmane.org>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org> <m1eka574c8.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org> <m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507111815180.17536@g5.osdl.org> <m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com> <m18y0c1prv.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507121152260.17536@g5.osdl.org> <m1pstnzn5j.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 13 01:49:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsUUd-0001VK-Tj
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 01:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVGLXsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 19:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVGLXqH
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 19:46:07 -0400
Received: from main.gmane.org ([80.91.229.2]:29405 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262520AbVGLXoN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 19:44:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DsUPL-0000lx-BG
	for git@vger.kernel.org; Wed, 13 Jul 2005 01:43:23 +0200
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2005 01:43:23 +0200
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jul 2005 01:43:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511 Firefox/1.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Eric W. Biederman <ebiederm <at> xmission.com> writes:

> Since we are still looking at this there is one change in the user
> interface I would like to make to simplify things for the end user.
> The only time when GIT_COMMITTER != GIT_AUTHOR is in git_commit_script
> when we you are making a new commit based on an old commit...

I am afraid I do not follow you.  For a "project lead" person like Linus, who
takes an e-mail submission of patches, GIT_AUTHOR is almost always different
from the committer, and typically set up by the program that reads the e-mail
to snarf the From: and Date: lines via environment variables, when the incoming
patches are being processed.  He is saying "I am the COMMITTER, and this commit
I am making is written by this AUTHOR".

AUTHOR can be set to somebody other than yourself and that is a typical mode
of operation for a "project lead" person.

On the other hand, we made COMMITTER overridable only because (1) the
computed value from the system are often not quite right on many systems
with weird GECOS field or domain/e-mail setup, and (2) when converting from
a foreign SCM, we wanted to keep the committer information (and dates), if
available.  Only in (2), which is quite a special case, COMMITTER names
somebody different from yourself.

What this means is that if you are asking the question "who the user is",
the answer _should_ always come from COMMITTER.  

> That also simplifies the tagging case and answers the question 
> which environment variables tags should look at, to see who the
> user is. 

The intent of "tags" (especially the signed kind) is to express "trust":
"This commit is called v2.6.12 and *I* vouch for it."

COMMITTER is the only sensible thing to use there, because (as you said)
what you care is "who I am", not "for whom I am doing this".  
