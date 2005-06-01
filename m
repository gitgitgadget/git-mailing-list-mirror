From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list: proper lazy reachability
Date: Wed, 1 Jun 2005 10:14:19 +1000
Message-ID: <2cfc4032050531171437d5d9eb@mail.gmail.com>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
	 <2cfc4032050531005820979ca7@mail.gmail.com>
	 <Pine.LNX.4.58.0505310758270.1876@ppc970.osdl.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 02:12:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdGpr-0006Vl-Kp
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 02:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVFAAO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 20:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVFAAO3
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 20:14:29 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:20514 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261214AbVFAAOV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 20:14:21 -0400
Received: by rproxy.gmail.com with SMTP id i8so2009279rne
        for <git@vger.kernel.org>; Tue, 31 May 2005 17:14:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ErHogro0RLkMPxE6L6QZ1vb0hmJ3StL6dBxQbSPO+yVxeEK2mtmDRebgiRdXvJSdcL0RVsM3iIen4bgaSa/DnYo4kPsTx0IiEHOBs1oMkhr8HffttQwyT6H4a2RFqgeN/okBGzwQ28po7/i5pEzGceMLWP/8F1saGaIXIvb1Fy4=
Received: by 10.39.3.56 with SMTP id f56mr2059189rni;
        Tue, 31 May 2005 17:14:19 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 31 May 2005 17:14:19 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505310758270.1876@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/1/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Tue, 31 May 2005, Jon Seymour wrote:
> >
> >      A
> >   /  |  \
> > B    C   D
> > |  /   /
> > E
> > | \
> > F G
> >
> > and searching for git-rev-list A ^B it would actually be better to stop
> > at E (printing A,B,C,D,E)
> 
> Btw, you probably looked at the actual code, so you know this, but maybe
> it wasn't clear to everybody else: the code obviously _will_ look at all
> of ABCDE before it can even decide that it should print out ACD, since it
> really needs to.

I did look at the code and concluded that ACD would be displayed and
simply assumed B would also be displayed. Anyway, you are right, for
the purposes you are interested in neither B nor E are interesting.

> 
> But if somebody wanted to actually show this as a _graph_, what you would
> probably want is actually all of ABCDE, except you'd get the "interesting"
> bit separately (ie ACD would be tagged some way). Then you could show a
> sane graph that is colored by whether something is new or not, for
> example. That's absolutely trivial to do wiyth the new rev-list algorithm,
> in case somebody really cares - it's literally just changing the printout
> to show the entries marked "ignored" with some extra marking.

This will also fall pretty naturally out of the --merge-order patch
that I am working on with an appropiate tweak. But I'll shut up about
that until I have code to share...

jon.
