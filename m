From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit [its a workspace id, isn't it?]
Date: Sat, 14 May 2005 09:49:56 +1000
Message-ID: <2cfc403205051316495b46115e@mail.gmail.com>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <2cfc4032050512183788e01fc@mail.gmail.com>
	 <20050513222502.GD32232@pasky.ji.cz>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 01:52:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWjxY-0001Gs-3Z
	for gcvg-git@gmane.org; Sat, 14 May 2005 01:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVEMXwC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 19:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVEMXvZ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 19:51:25 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:34186 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262645AbVEMXt7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 19:49:59 -0400
Received: by rproxy.gmail.com with SMTP id i8so280122rne
        for <git@vger.kernel.org>; Fri, 13 May 2005 16:49:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D+7qGc6WtNDSLSSUPpMx31D+7KUFifqp+WTWcfpzQV6p3t7/ZpCzQ2k6jBbVnEoUUGDJip/t7IOHRw7wlbOm2i2aQsmtOeK56jYMh2vwP7POkAH3HXdUkWZin/DL3eMQeZHSHRsthYAYJzwKcFTUywgQNdQS4fDYHShUxJoWcHg=
Received: by 10.39.3.49 with SMTP id f49mr1089086rni;
        Fri, 13 May 2005 16:49:56 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Fri, 13 May 2005 16:49:56 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513222502.GD32232@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/14/05, Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Fri, May 13, 2005 at 03:37:47AM CEST, I got a letter
> where Jon Seymour <jon.seymour@gmail.com> told me that...
> > >
> > > I would like to suggest a few limiters are set on the repoid.  In
> > > particular, I'd like to suggest that a repoid is a UUID, that a file is
> > > used to track it (.git/repoid), and that if it doesn't exist, a new one
> > > is created from /dev/urandom.
> > >
> >
> > I think I understand what Thomas is trying to achieve, but I think
> > there is a naming problem here. The marker really isn't a repoid - it
> > is a workspace id.
> 
> Why not just call the thing "branch"? It's as well eligible for that
> term as anything. :-)
> 

I very nearly agreed with you except for one thing. In a traditional
SCM, a branch is something that can be contributed by multiple people
but I don't think we want that meaning here.

Consider this graph where there is a main Trunk R, and a branch B and
two programmers Ba and Bb working on a branch B.  Thomas wants to be
able to form views of the merge order of 3 workspaces (W(R), W(Ba) and
W(Bb)), even though Ba and Bb are working on the same "branch" in SCM
terms.

Rn -------------
|      \         \ 
Rn-1 Ba,n   Bb,n
|     /             |
Rn-2             |
|       \           |
Rn-3 Ba,n-1  |
|    /             /
Rn-4 -----------

Also, most times in a traditional SCM, branches diverge, but the
behaviour we are interested in here is the repeated converging and
diverging of workspaces on the same "branch" [ I know, a branches can
be used in that way in traditional SCMs, but that is a degenerate case
of their intended use - maintaining paths of long term divergence ].

So, while I think there may well be some value is a separate
"branchid" attribute in a commit, I think they are describing
(slightly) different things.

jon
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
