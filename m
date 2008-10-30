From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 16:04:08 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-10-30-16-04-08+trackit+sam@rfc1149.net>
References: <18696.32778.842933.486171@lisa.zopyra.com> <1225343538.10803.9.camel@maia.lan> <18697.41702.241183.408377@lisa.zopyra.com> <18697.42140.459170.891195@lisa.zopyra.com> <4909A7C4.30507@op5.se> <2008-10-30-14-52-52+trackit+sam@rfc1149.net> <4909BF58.9010500@op5.se> <2008-10-30-15-23-16+trackit+sam@rfc1149.net> <4909CABD.1040708@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 30 16:06:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvZ5t-00013h-FL
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 16:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbYJ3PEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 11:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755378AbYJ3PEN
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 11:04:13 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:47773 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222AbYJ3PEM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 11:04:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 13E4B1114BD;
	Thu, 30 Oct 2008 16:04:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kboz5dIvPQ3O; Thu, 30 Oct 2008 16:04:09 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id B4717111467;
	Thu, 30 Oct 2008 16:04:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 1F74CC40BC;
	Thu, 30 Oct 2008 16:04:09 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IKEKqz2n-LvI; Thu, 30 Oct 2008 16:04:09 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 032BAC40BD; Thu, 30 Oct 2008 16:04:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4909CABD.1040708@op5.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99483>

* Andreas Ericsson <ae@op5.se> [2008-10-30 15:54:53 +0100]

> Correct me if I'm wrong, but wouldn't my suggestion of not trying to
> push (even matching) branches that haven't been updated since we last
> fetched from the remote do exactly the same thing for your particular
> use-case, but without syntax change and all the annoying minor parts
> that it entails?

Not exactly. I often do some work on a branch which does not mandate
a topic branch and have to switch branches to fix a bug for example.
This would continue to push unterminated changes as well.

Typical use case, which happens (to me) quite frequently:

  % git checkout master
  [start new feature, estimated implementation time 15 minutes]
  % git commit -m "Reorganize foobar in previous of xyzzy."
    (note that I'm not sure that I will keep it, I'll know that later
    when my next commit is ready, maybe in 10 minutes, no need for
    a topic branch)
  [mail from a customer, "I noticed some strange behaviour here" --
   let's fix it]
  % git checkout 2.0-beta1-release-candidate
  [fix strange behaviour and add new test]
  [test locally]
  % git commit -m "Fix strange behaviour baz."
  % git push
    (so that it goes to the buildfarm for QA testing)

Argh, "master" has been pushed as well. Ok, I could have done

  % git branch
    (because I know I am on the right branch but do not necessarily
     remember its full name all the time)
  % git push origin 2.0-beta1-release-candidate

or I could have started a topic branch, but I often push 2 or 3
commits at a time instead, the first one being a refactoring of
existing code to ease the subsequent one.

>From what I have seen, people I am working with often have the
same workflow (do not systematically start a topic branch when
in active development mode)

> Define "many". Perhaps as often as 2-3 times per day. Not very often,
> but frequent enough that I definitely want some short sweet way of
> doing it. OTOH, I also find the "rejected" messages annoying, and I
> definitely feel one could do something about them. However, it's my
> birthday today and I plan on being far too drunk/hungover the entire
> weekend for me to take any actions in that direction.

Happy birthday :)
