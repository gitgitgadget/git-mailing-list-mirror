From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 15:44:05 -0700 (PDT)
Message-ID: <m3od85qxcl.fsf@localhost.localdomain>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
	<alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
	<FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Apr 20 00:44:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnLnl-0008Ke-59
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 00:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbYDSWoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 18:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbYDSWoJ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 18:44:09 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:8357 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466AbYDSWoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 18:44:08 -0400
Received: by fk-out-0910.google.com with SMTP id 19so1492442fkr.5
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=haT5KK+uMf7XaNFZ+WAgPGbYNz/Zs7olaCgq6a5FB3w=;
        b=ek+EJ7SJ1w4cBka5j5DcdQaZxGWXvM3jpwDbmhND0issu4knViAg5nu6krxGpOb6nmKhfzvcLgk2+IpRLLppR65jxzetqEJjDirq3LjPKI6jLURWdi2EBAb6/5Uxg11etW69SizPbesAysaZSe7JgdpfG47jKsYKmsrfmBIoilQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=U7KWpgstrQgcXzGbc5IfT9DWcR6UquT4iackepjYAhiked7AAfegM4BzppUdiQ6AhRsZwR5Q0UETUzh4U2eJ62MNwhr2ORQVv/5KILWg2r8Se05zye29anWa34qaC1Fi7BfxPLQXlxHo70whjDMJkccR90CR5xSPD/uSzMF5qMY=
Received: by 10.82.111.8 with SMTP id j8mr7740691buc.43.1208645046705;
        Sat, 19 Apr 2008 15:44:06 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.225.130])
        by mx.google.com with ESMTPS id d2sm2523896nfc.11.2008.04.19.15.44.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Apr 2008 15:44:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3JMhwq4016783;
	Sun, 20 Apr 2008 00:44:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3JMhsXB016780;
	Sun, 20 Apr 2008 00:43:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79929>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> On 19 apr 2008, at 23:54, Linus Torvalds wrote:
> >
> > And yes, most of the time in "git status ." is going to be the lstat()
> > calls. Which are expensive on OS X. And yes, we do too many of them.
> > I'll
> > look at seeing if we can avoid some.
> 
> I just tested this. "git status ." does 428815 (400k!) lstats, almost
> 10x as many as there are files in the repository. I'd agree that this
> is the reason it's slow on OS X :).

By the way, what version of git do you use? Because in RelNotes for
1.5.5 there is:

 * "git commit" does not run lstat(2) more than necessary
   anymore.

which I guess also apply to git status.  This change was written by
Linus if I remember correctly...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
