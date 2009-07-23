From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Thu, 23 Jul 2009 18:53:35 +0200
Message-ID: <20090723165335.GA15598@Pilar.aei.mpg.de>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain> <7vtz146mgr.fsf@alter.siamese.dyndns.org> <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 18:54:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU1ZD-0000lk-TD
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 18:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbZGWQyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 12:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbZGWQyo
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 12:54:44 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:39608 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbZGWQyn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 12:54:43 -0400
Received: by fxm18 with SMTP id 18so951281fxm.37
        for <git@vger.kernel.org>; Thu, 23 Jul 2009 09:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Xp614jnO7WfXoVv+760y6oE6Wuuu3gXMoMQJbWvXj1I=;
        b=Iip7sWmCxsShoLyMEvZkbaXkk8Hu3vIjA8YpC3iFl2a0ubgqNy9eet7lxEZ7lCRpNW
         xzpqa6ygKZ4UzZijTCqWTqd05anjvt8cEqE0Ou2nttPvFpWqk+97hl6i58sCiUO6Tdmk
         QhcbyPcpjZEu2cf6z2Re+N2wyX9ZvnxzQieWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pl4wTPc9I975KnMpKMr1BsAUpolXgR/M7ISE8ocktlo5EGqC+JbaVlEuCv1i9Htel8
         82qKLPyijLLljNFJ6oQIFE3LD31o+unmm9qWZYfLLNZBZ+Bl5idf8Y+bbRkAjPc8CW6U
         60YLUSAIlnaY2ZvWZQs/OZDT4DPaAPKWyTUkA=
Received: by 10.103.1.5 with SMTP id d5mr1247372mui.74.1248368082873;
        Thu, 23 Jul 2009 09:54:42 -0700 (PDT)
Received: from Pilar.aei.mpg.de (dynamic.aei.mpg.de [194.94.224.254])
        by mx.google.com with ESMTPS id u9sm8458434muf.37.2009.07.23.09.54.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Jul 2009 09:54:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123882>

On Thu 23.Jul'09 at  9:19:21 -0700, Linus Torvalds wrote:
> > 
> > and notice how that makes my pitiful harddisc look like Linus' SSD! And the
> > result is the same. 
> 
> The result is the same, yes, but it doesn't do error checking.

Oh, I see.

> So we _could_ make 'git branch' not actually read and verify the commits. 
> It doesn't strictly _need_ to, unless you use 'git branch -v' or 
> something. That would speed it up further, but the verification is nice, 
> and as long as performance isn't _horrible_ I think we're better off doing 
> it.

Right, but I would definitely like having some option like --dont-check to 
'git branch', and I think I would use it as default (unless experience
tells that errors happen often).

> After all, you'll see the problem only once.

True, but paradoxically that is also the reason why I notice it and
makes it feel bad.

Everytime I did the first 'git branch' those 5 seconds really hurt, because
I wondered why it couldn't be done in 0s like subsequent commands.

But sure, this was definitely not a pressing issue and your patch made
it even less. I am happy that it takes 1s now, and I really appreciated
your patch! 

Thanks,
Carlos
