From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Tue, 13 Nov 2012 01:16:01 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.1211130114180.13573@bonsai2>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com> <03ED9D50D1F64467863C051959CFC433@PhilipOakley> <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com> <509FD668.20609@lsrfire.ath.cx> <20121111165431.GA25884@sigill.intra.peff.net>
 <CA+TMuX2p4ck0qXijH+OOcBoveBC42U8PqnXdisau57RXwt1isg@mail.gmail.com> <20121112231453.GA21679@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>, 
    =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>, 
    msysgit@googlegroups.com, Git List <git@vger.kernel.org>, 
    Philip Oakley <philipoakley@iee.org>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCZPH74Q5YNRBVF6Q2CQKGQEQLRMXHY@googlegroups.com Tue Nov 13 02:16:20 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBVF6Q2CQKGQEQLRMXHY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBVF6Q2CQKGQEQLRMXHY@googlegroups.com>)
	id 1TY56y-0000o3-2D
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 02:16:20 +0100
Received: by mail-wi0-f186.google.com with SMTP id x18sf456510wia.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 Nov 2012 17:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=1lDQomGzb7MjQJsit4rlH5dI7rPoI+A6EVnqOilOM9U=;
        b=JX5sqaJnqB0XIWQ9ImyiCM80B2F4tgMnTBrTClZlLIjq3OilPu4jkhM47w/b1VMxr/
         xLH0nvsqYNCw+GPSTkm1VY+Wyp9dFQHvu2fa7KOoAmstDyGEw3l4a0EPPGZGs6kuOcPX
         ddgzCp6e52R4I8MdlY944LK4i8eFJqz06084uQxpeB5P/Ts0rvhyRW99JUgMVZE/GAl4
         AMATQVCot0XQD8guuQUZecYvmpSGRvxxsoDCLNUnRCppnrzDv8VWB8SnHCoA 
Received: by 10.216.144.25 with SMTP id m25mr847082wej.67.1352769365665;
        Mon, 12 Nov 2012 17:16:05 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.173.67 with SMTP id u43ls4729252eel.8.gmail; Mon, 12 Nov
 2012 17:16:03 -0800 (PST)
Received: by 10.14.199.6 with SMTP id w6mr21269232een.0.1352769363904;
        Mon, 12 Nov 2012 17:16:03 -0800 (PST)
Received: by 10.14.199.6 with SMTP id w6mr21269231een.0.1352769363895;
        Mon, 12 Nov 2012 17:16:03 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.22])
        by gmr-mx.google.com with SMTP id z47si2066019eel.0.2012.11.12.17.16.03;
        Mon, 12 Nov 2012 17:16:03 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 13 Nov 2012 01:16:03 -0000
Received: from unknown (EHLO bonsai2.local) [94.185.209.43]
  by mail.gmx.net (mp072) with SMTP; 13 Nov 2012 02:16:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/REeIIjsHRpWm+j0ludSkr2DnsgLxHBrLbd1l6te
	1cJdYyhpXG7am0
X-X-Sender: gene099@bonsai2
In-Reply-To: <20121112231453.GA21679@sigill.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209561>

Hi Peff,

On Mon, 12 Nov 2012, Jeff King wrote:

> On Mon, Nov 12, 2012 at 11:27:14PM +0100, Jean-Jacques Lafay wrote:
>=20
> > 2012/11/11 Jeff King <peff@peff.net>:
> > > On Sun, Nov 11, 2012 at 05:46:32PM +0100, Ren=E9 Scharfe wrote:
> > >
> > > Ultimately, I have some ideas for doing this in a breadth-first way,
> > > which would make it more naturally iterative. It would involve
> > > having N bits of storage per commit to check N tags, but it would
> > > mean that we could get accurate answers in the face of clock skew
> > > (like the merge-base calculation, it would merely get slower in the
> > > face of skew).
> >=20
> > I guess the optimal algorithm may also depend on the commit graph
> > general shape, but intuitively, I'd say that the critical factor is
> > the number and distribution of tags. As soon as you have a significant
> > number of tags (let's say 1% of the commits are tagged, evenly
> > distributed), you'll quickly end up with every commit marked as
> > containing or not the target commit, so that each additional tag check
> > is cheap.
> >=20
> > This suggests a complexity of O(number of commits) more often then
> > not, however you choose to traverse the graph.
>=20
> We can do much better than O(number of commits), though, if we stop
> traversing down a path when its timestamp shows that it is too old to
> contain the commits we are searching for. The problem is that the
> timestamps cannot always be trusted, because they are generated on
> machines with wrong clocks, or by buggy software. This could be solved
> by calculating and caching a "generation" number, but last time it was
> discussed there was a lot of arguing and nothing got done.

Sadly, not only machines with skewed clocks, but in particular buggy
3rd-party SCMs make this more than just problematic. In a git-svn clone
that was used as base for heavy Git development, I encountered quite a lot
of Jan 1, 1970 commits.

It just cannot be helped, we must distrust timestamps completely.

Ciao,
Dscho

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
