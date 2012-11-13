From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Tue, 13 Nov 2012 04:01:11 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.1211130400030.13573@bonsai2>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com> <03ED9D50D1F64467863C051959CFC433@PhilipOakley> <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com> <509FD668.20609@lsrfire.ath.cx> <20121111165431.GA25884@sigill.intra.peff.net>
 <CA+TMuX2p4ck0qXijH+OOcBoveBC42U8PqnXdisau57RXwt1isg@mail.gmail.com> <20121112231453.GA21679@sigill.intra.peff.net> <alpine.DEB.1.00.1211130114180.13573@bonsai2> <20121113034605.GB8387@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>, 
    =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>, 
    msysgit@googlegroups.com, Git List <git@vger.kernel.org>, 
    Philip Oakley <philipoakley@iee.org>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCZPH74Q5YNRBCMMQ6CQKGQE5M3EX3Y@googlegroups.com Tue Nov 13 05:01:27 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBCMMQ6CQKGQE5M3EX3Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBCMMQ6CQKGQE5M3EX3Y@googlegroups.com>)
	id 1TY7gi-0001Yh-Pr
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 05:01:24 +0100
Received: by mail-wi0-f186.google.com with SMTP id x18sf474841wia.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 Nov 2012 20:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=N8P2mJx+ADxsVZfNGl9Pkroi7uvpJBxOnjYBxUCdAbE=;
        b=S96ozfMuLiAOXvntGVa14dZZfudgIzLhstX8rgzW9xJNei3APMaz+wjJ6+JfJHMk/l
         KnlFNipc/kcDsO8c7IyvCCQ/JfKsh4HYjNKCgx8rMpDByuwoLeQBluAp1ohf6ZzwGOPQ
         JVSV/4/GrWzaVx7RdKfpfnmejYapGnXBHhkterMguOqjQDt0qWKamM+yPgir0VDXbY3T
         vas3Fn8ksYrfgV4opFp1YoPXIqNYnuh+nffsbJy28RFoFjvib2Rs0UOFFZGRFnXNxMEz
         xMBYZlVar+zriv47Pu 
Received: by 10.180.19.39 with SMTP id b7mr1868302wie.0.1352779275230;
        Mon, 12 Nov 2012 20:01:15 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.221.73 with SMTP id q49ls4776865eep.7.gmail; Mon, 12 Nov
 2012 20:01:13 -0800 (PST)
Received: by 10.14.199.6 with SMTP id w6mr21627854een.0.1352779273192;
        Mon, 12 Nov 2012 20:01:13 -0800 (PST)
Received: by 10.14.199.6 with SMTP id w6mr21627852een.0.1352779273181;
        Mon, 12 Nov 2012 20:01:13 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.22])
        by gmr-mx.google.com with SMTP id z47si2132818eel.0.2012.11.12.20.01.13;
        Mon, 12 Nov 2012 20:01:13 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 13 Nov 2012 04:01:12 -0000
Received: from unknown (EHLO bonsai2.local) [94.185.209.43]
  by mail.gmx.net (mp040) with SMTP; 13 Nov 2012 05:01:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7nHEWhwu7KN8gUtgArZPlUp/siFRqv/EMJ/0CwR
	X6oraQ+S4IYfAh
X-X-Sender: gene099@bonsai2
In-Reply-To: <20121113034605.GB8387@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209569>

Hi Peff,

On Mon, 12 Nov 2012, Jeff King wrote:

> On Tue, Nov 13, 2012 at 01:16:01AM +0000, Johannes Schindelin wrote:
> 
> > > We can do much better than O(number of commits), though, if we stop
> > > traversing down a path when its timestamp shows that it is too old to
> > > contain the commits we are searching for. The problem is that the
> > > timestamps cannot always be trusted, because they are generated on
> > > machines with wrong clocks, or by buggy software. This could be solved
> > > by calculating and caching a "generation" number, but last time it was
> > > discussed there was a lot of arguing and nothing got done.
> > 
> > Sadly, not only machines with skewed clocks, but in particular buggy
> > 3rd-party SCMs make this more than just problematic. In a git-svn clone
> > that was used as base for heavy Git development, I encountered quite a lot
> > of Jan 1, 1970 commits.
> 
> Yeah. We tolerate a certain amount of skew (24 hours for --name-rev, and
> 5 broken commits in a row for --since). But the big ones are usually
> software bugs (the big kernel ones were from broken "guilt", I think) or
> broken imports (when I published a bunch of skew statistics last year,
> the interesting ones were all imports; I don't know if they were
> software bugs, or just garbage in, garbage out).
> 
> > It just cannot be helped, we must distrust timestamps completely.
> 
> Note that name-rev will produce wrong answers in the face of clock skew.
> And I think that you even wrote that code. :)

IIRC the cute code to short-circuit using the date is not from me. If it
is, I am very ashamed.

Ciao,
Johannes

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
