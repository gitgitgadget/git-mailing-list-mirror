From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: stash refuses to pop
Date: Sat, 14 Apr 2012 03:12:43 -0700 (PDT)
Message-ID: <m3pqbaaaga.fsf@localhost.localdomain>
References: <4F847350.3000409@ubuntu.com>
	<7vpqbfpim2.fsf@alter.siamese.dyndns.org> <4F84827B.80104@ubuntu.com>
	<CAH5451=0KvUPB77hKyjFVXRwPfEZ8+45b20SimBPmuF-gq_A3w@mail.gmail.com>
	<4F84F39B.6070907@ubuntu.com>
	<20120414042713.GA13889@inner.h.iocl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phillip Susi <psusi@ubuntu.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 14 12:12:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIzyN-0003UO-46
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 12:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab2DNKMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 06:12:46 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57200 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab2DNKMp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 06:12:45 -0400
Received: by wgbdr13 with SMTP id dr13so3743497wgb.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 03:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=scmcs+HOWYoNtWaisnQXHZZzLjlO+BgC+h9Lf+uLxwM=;
        b=DTXY2i0us7hxPH+CcQbcN8Zuf4yq/m2mhFehxwws/Dn9jOiKbjaMBON5Qho/zTepW7
         LA6x6EQeBoVp+Gbfquw0YFYRtpjt2H0KQ8fclRmupymruvb2jhG+tQ5ELQgBLL8VT2ng
         MoYaQO20rzRPOSubaVM47QyaEED+UAKhsL1rWR3zOEmM3+O60rLza+tukCqGy4pQwLZ9
         fT05KjlFsVaHolSIoXWtaNRu4e8Z5cKlhmSysQN+pskEPZ57Xq4qInJq0CbcyIhb9KBc
         n0ZeIGaGyGGrlUCNrO26GkQOEN1tVKAmOd0KI+6us/YEkW/bd62EtAFrt9/Hc9LaW3Yo
         OOfQ==
Received: by 10.216.137.22 with SMTP id x22mr3253436wei.69.1334398364235;
        Sat, 14 Apr 2012 03:12:44 -0700 (PDT)
Received: from localhost.localdomain (addh222.neoplus.adsl.tpnet.pl. [79.184.59.222])
        by mx.google.com with ESMTPS id h8sm5565097wix.4.2012.04.14.03.12.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 03:12:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q3EACdJm002007;
	Sat, 14 Apr 2012 12:12:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q3EACcbn002004;
	Sat, 14 Apr 2012 12:12:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120414042713.GA13889@inner.h.iocl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195484>

Andreas Krey <a.krey@gmx.de> writes:
> On Tue, 10 Apr 2012 22:59:39 +0000, Phillip Susi wrote:
> ...
> > Yes, there are a number of ways you can get to the situation where
> > you can not pop the stash.  How to resolve this is unclear from
> > the results of the failed pop.  I finally ended up resolving it by
> > committing the remaining changes, then popping the stash ( which
> > performed the merge successfully ), and finally doing a git reset
> > HEAD~1 to remove the temporary commit, but preserve the merged
> > results.  This seemed like a good deal of unnecessary trouble.
> 
> (Late to the game.) Actually, this is exactly what I would have proposed
> to do. Git is a bit shy on performing a merge into a locally modified
> file. I assumed so far that is because there is no way of aborting
> such a merge (resetting to the state of local modifications before the
> attempt). With the temporary commit you have a way of retrying the pop
> merge if you lost your way in it.

It would be nice if a.) git gave this advice when unable to "git stash pop"
(or "git stash apply") for newbie users, and b.) this solution was put
in documentation including git-stash(1) manpage.
 
> And I think that is a good idea; I never liked the way in which a cvs/svn
> update merged into locally modified files without a way to undo, and
> thus forcing you to clean up the potential mess manually. (Ok, they leave
> the old files lying arond, but that doesn't help rewinding the state.)

BTW. I sometimes wonder if Mercurial's transaction-based approach
isn't a superior solution...

> Andreas
> 
> -- 
> "Totally trivial. Famous last words."
> From: Linus Torvalds <torvalds@*.org>
> Date: Fri, 22 Jan 2010 07:29:21 -0800

-- 
Jakub Narebski
