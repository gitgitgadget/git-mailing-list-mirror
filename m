From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Better cooperation between checkouts and stashing
Date: Sun, 28 Feb 2010 14:55:37 +0100
Message-ID: <4B8A75D9.2090702@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 14:55:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nljca-0002py-V4
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 14:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab0B1Nzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 08:55:42 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:56409 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab0B1Nzl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 08:55:41 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7C9FE140D9441;
	Sun, 28 Feb 2010 14:55:40 +0100 (CET)
Received: from [78.49.67.29] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NljcR-0007TL-00; Sun, 28 Feb 2010 14:55:39 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <7vr5o6s5xf.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+GFmdizvNjAMCdcYqgU58YQTYs5cdpQGvwlizl
	8bXyzv8+eyCXtKA1R2CDZN362BA0sdzVJak7R8QdJklkQcXOZs
	AaXEakYAnus1xWGorthA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141252>

> It is important to understand that a local change does not belong to your
> current branch (it does not belong to _any_ branch).  It belongs to you,
> and you can take it around while switching between branches.  And that is
> a big time-saving feature.

It seems that we have got different expectations on the editing work flow when
we discuss the following situation.

elfring@Sonne:~/Projekte> git --version && mkdir try && cd try && git init --quiet \
> && echo one > XYZ.h && git add . && git commit --message=check-in --quiet \
> && git checkout --quiet -b feature1 && echo two > XYZ.h \
> && git checkout --quiet master && git status
git version 1.7.0
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   XYZ.h
#
no changes added to commit (use "git add" and/or "git commit -a")

I would prefer to return to the unchanged work tree because I made an adjustment
for a source file with the intention that this update should only belong to the
new topic branch. The switch did not provide a clean state from my view.


>  - You are reading a mailing list message that asks for help, and you know
>    the solution---you can give the help real quick.
> 
>  - You hack in whatever branch that happen to be checked out.

I would create another topic branch before.


>  - The branch you happen to have checked out was 'next', but the solution
>    is a bugfix, and should go to 'maint'.
> 
> Now, at this point, you want to checkout 'maint' without losing your local
> change.  The paths you touched with your quick fix are often not different
> between the two branches, and "checkout maint" will checkout the branch
> while keeping your local changes intact.

I can follow your view on convenience if the desired software maintenance is so
easy as in this example. I guess that it matters if only a simple branch switch
is needed or a corresponding content restore will also be required.


> In a case where "checkout -m" would result in a conflict too big to
> resolve, the original fix you made would not be applicable to 'maint'
> (iow, you should have solved it differently starting from 'maint'), and
> you may end up doing "reset --hard" and start from scratch, but that is a
> rare worst case.

I would like to be more careful so that I do not want to mix changes by accident.


> I said it is rare, because you would notice, while doing the "quick fix"
> based on 'next' codebase, that the code you are touching have changed
> since 'maint' and won't be applicable to its final destination (by that
> time you know you are "fixing"), and you won't waste too much time
> continuing to work in a checkout of 'next'.

I imagine that stashing will help to split the collected changes for different
branch targets.

Regards,
Markus
