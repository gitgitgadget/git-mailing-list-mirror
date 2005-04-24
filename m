From: Imre Simon <imres.g@gmail.com>
Subject: Re: Hash collision count
Date: Sun, 24 Apr 2005 18:24:14 -0300
Message-ID: <68ff9fa6050424142416fbadcd@mail.gmail.com>
References: <426AAFC3.800@pobox.com>
	 <1114297231.10264.12.camel@maze.mythral.org>
	 <426AD835.5070404@pobox.com> <20050423234637.GS13222@pasky.ji.cz>
	 <426AE9ED.4060005@pobox.com> <20050424004039.GU13222@pasky.ji.cz>
	 <426AEBAE.1060402@pobox.com>
Reply-To: Imre Simon <imres.g@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@ucw.cz>, Ray Heasman <lists@mythral.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Imre Simon <is@ime.usp.br>
X-From: git-owner@vger.kernel.org Sun Apr 24 23:20:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPoW1-0000bY-6b
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 23:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVDXVYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 17:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVDXVYi
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 17:24:38 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:24952 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262436AbVDXVYO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 17:24:14 -0400
Received: by wproxy.gmail.com with SMTP id 68so1552211wra
        for <git@vger.kernel.org>; Sun, 24 Apr 2005 14:24:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GjAncW3F5PgD+bK6Z3a4nIyX084csgwxcbw8CouE3zYkYKCAxsl510RYsjr+nChAdOQrzo75216taUyZzokOnjXPfE8kAAhRzM5/SQNLv7/j6xlZpxzqpHZPzV3nilWNfesG4LSmXNzZeLvugt+cYNrGHGq2TGO29nrqRBG2dlE=
Received: by 10.54.49.31 with SMTP id w31mr1516202wrw;
        Sun, 24 Apr 2005 14:24:14 -0700 (PDT)
Received: by 10.54.138.20 with HTTP; Sun, 24 Apr 2005 14:24:14 -0700 (PDT)
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <426AEBAE.1060402@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/23/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Petr Baudis wrote:
> > -DCOLLISION_CHECK
> 
> Cool.  I am happy, then :)
> 
> Make sure that's enabled by default...
> 
> Thanks,
> 
>         Jeff

I would like to second the suggestion that this should be enabled by default.

First, I do think it is highly unlikely that a collision will ever be
found. Actually because of this if one is found it would be an
important byproduct of git and it would probably influence future
system designs. Hence, I believe that it is worth loosing some
efficiency in order to illuminate better this question of the
collision.

I would like to add a reciepe by which one would surely produce a
collision with two files of the same length and quite similar to each
other. I believe that there is a popular belief that this is pretty
much impossible. Of course, we do not have time to execute this
algorithm, but I believe that it convinces everyone that similar files
*do* exist (actually in abundance) with the same hash.

1. Take your favorite text file, at least 160 characters long. 
2. Choose 160 positions in this file.
3. For each position choose your favorite mispelling of that character.
4. Produce all 2^160 text files, all of the same length, choosing for
each position either the original or the alternate character
5. Add an arbitrary file of the same length, different from the above

Two of these files have the same sha1 hash. Or, for that matter, for
any 160 bit  hash the same is true.

Cheers, Imre Simon
