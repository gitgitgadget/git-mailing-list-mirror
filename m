From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 15:23:16 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-10-30-15-23-16+trackit+sam@rfc1149.net>
References: <18696.32778.842933.486171@lisa.zopyra.com> <1225343538.10803.9.camel@maia.lan> <18697.41702.241183.408377@lisa.zopyra.com> <18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se> <2008-10-30-14-52-52+trackit+sam@rfc1149.net> <4909BF58.9010500@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 30 15:24:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvYRw-0001QO-7L
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 15:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbYJ3OXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 10:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbYJ3OXW
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 10:23:22 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:49682 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbYJ3OXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 10:23:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id C720D111093;
	Thu, 30 Oct 2008 15:23:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CCPo1IIwGwE8; Thu, 30 Oct 2008 15:23:17 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id 37BAB111033;
	Thu, 30 Oct 2008 15:23:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 86A20C40BC;
	Thu, 30 Oct 2008 15:23:16 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5H8uESvN+6KC; Thu, 30 Oct 2008 15:23:16 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 5CE50C40BD; Thu, 30 Oct 2008 15:23:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4909BF58.9010500@op5.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99471>

* Andreas Ericsson <ae@op5.se> [2008-10-30 15:06:16 +0100]

> --all pushes all refs, even the non-matching ones, which is very
> rarely desirable and only accidentally sometimes the same as "push all
> matching refs".
>
>> I know that I've never had the intent to push all the refs without
>> thinking about it first. Most of the time, I intend to push only
>> the current branch I am in.
>
> Then say so. There's a very simple command syntax for it:
> "git push <remote> <current-branch>"

I update the branches I'm working in maybe 20 times a day, sometimes
more. When I make a change and all the tests pass, I prefer to call

  git push

rather than

  git push origin 2.0-beta1

(and "2.0-beta1" is a short name here, some branches have much longer
names)

I think it would be better to have :

  git push                <= push the current branch
  git push --all          <= push all matching refs
  git push --all --create <= push all matching refs, create if needed

The latest command is probably used so rarely (compared to the others)
that it wouldn't be a problem to make it longer. Of course, if a
refspec is given explicitely, it should be honored and remote refs
created if needed.

I am curious of what other people workflows are. Do you often push
multiple branches at the same time? More often than one at a time?
Many times a day?

> "git pull" is actually only vaguely connected with "git push". The
> opposite of "push" is "fetch" in git lingo.

I know, but "git fetch" only updates remote tracking branches, and I
think that in the majority of the cases you want to advance all the
remote references. And even if you screw up, the problem will only
happen in your local copy, not in an upstream or shared repository.
I assume that most people "push" to public repositories and not
many of them "pull" into public repositories directly.
