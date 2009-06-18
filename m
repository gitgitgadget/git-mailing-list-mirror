From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 12:59:00 +0200
Message-ID: <20090618105859.GA12924@vidovic>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com> <43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com> <7vvdmurfao.fsf@alter.siamese.dyndns.org> <20090618063348.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de> <20090618001111.GB12954@vidovic> <7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 12:59:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHFL1-0007Mq-2z
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 12:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759545AbZFRK7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 06:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760045AbZFRK7K
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 06:59:10 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:55013 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757544AbZFRK7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 06:59:08 -0400
Received: by ewy6 with SMTP id 6so1413273ewy.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 03:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=466wh4hVaJ9N1bljnm3DHGIWnq4nc3kzpzmyHyZl5Ws=;
        b=gWbWjrT1FszMom43TULSwXOh4PlQJ2wQyndrrZ3IZ+iwssWUxLcsJxH2RM9dXPEwGa
         e48Yn2StFRn14L/hBPphu6P1mKUnmgoGtWW6Xv8iOdqFeUfdCyVeJp0Ur4EI1KYlJG10
         iNSWg+kddYNQhkEUuuTTKzUApRDBRh2Qh+8P4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=m2AMapjkzKngBKqBypqTpFohTF4gQMkM8FtMCZZ/AXovYVWymKvQMDkAR+b4l7MF6H
         GcUgHIBh63ST5VvpX/Slp08TF0mR0WP0nlJuXeRfsE8D3FVMTHJONcUj23NAZdEHAWlV
         d27UlQXAec0R2qe5tJNiv+8DLBR1+MdX9v/2E=
Received: by 10.211.168.4 with SMTP id v4mr1959792ebo.90.1245322749614;
        Thu, 18 Jun 2009 03:59:09 -0700 (PDT)
Received: from @ (91-164-154-189.rev.libertysurf.net [91.164.154.189])
        by mx.google.com with ESMTPS id 10sm131896eyd.17.2009.06.18.03.59.03
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 03:59:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121828>

The 17/06/09, Junio C Hamano wrote:

> We do want our commands to be able to act intelligently and/or differently
> depending on what commit says in some cases.  It is does not make sense to
> insist that the command line or configuration mechanism must be used.
> 
> A really trivial example.  "git log -p" shows the patch text for non-merge
> commits but not for merge commits.  "git log --grep=foo" shows only
> commits that says "foo" and "git log --author=Nicolas" shows only commits
> written by you.  We used to leave an explicit note in the message part of
> cherry-picked commits where they were cherry-picked from; "git merge"
> and/or "git rebase" could have paid attention to it to act differently
> (i.e. "ah, even though that commit is not in the ancestry, the moral
> equivalent patch is already applied").

But I see a huge difference between a message added by the program
itself to act well on possible comming cases and a message added by the
user to act differently at the commit time.

The latter case is exposed to the user mistakes (wrong typo,
unintentional matching pattern, etc) which could leave the repository in
unexpected states.

Git is enough hard to learn. Please, don't make the learning curve even
worse. Having the commit message possibly making git acts differently is
not usual or expected by most users.

> Besides, if you as the end user want to tell this and that commit are
> special among other commits that are being rebased to the command, which
> is the scenario Nana's patch is about, how would you do that from the
> command line option?  "rebase -i --move=4-to-2 --squash=2"?

Well, as we always squash to one of the first direct ancestor and as
squashing to a merge is not usual (here at least), in most cases it just
gives "rebase -i --move=4-to-2" wich sounds reasonable enough to me.


-- 
Nicolas Sebrecht
