From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Sun, 11 Nov 2012 23:10:04 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.1211112308220.5793@bonsai2>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com> <03ED9D50D1F64467863C051959CFC433@PhilipOakley> <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com> <509FD668.20609@lsrfire.ath.cx>
 <20121111165431.GA25884@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>, 
    Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>, msysgit@googlegroups.com, 
    Git List <git@vger.kernel.org>, Philip Oakley <philipoakley@iee.org>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCZPH74Q5YNRBVHAQCCQKGQEJT5J5KQ@googlegroups.com Mon Nov 12 00:10:25 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBVHAQCCQKGQEJT5J5KQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBVHAQCCQKGQEJT5J5KQ@googlegroups.com>)
	id 1TXgfX-0002Nj-SS
	for gcvm-msysgit@m.gmane.org; Mon, 12 Nov 2012 00:10:23 +0100
Received: by mail-ee0-f58.google.com with SMTP id c1sf1895112eek.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 11 Nov 2012 15:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=zlwULb8s3SwYvw0fd1o2tMf41PMHzs1ZbRMHseiojWw=;
        b=sNULHM+tudSlM5gW4qSpv/T9oZIVHo+uopHQ85CG7fjkQtPQnD70C7kTSqJKTryCvP
         elzQOdIZ5ue1FnpLNgosisZo6BY/BhLbzv3jJ5MfvmmOdorMHkQq38cgeUIwSzuOUqpP
         QZ9Bxy2+pIdmd9OtvXlHo+Xn2eOukiJSskYffurcVfcHBj32cdXmcQBbHl1AHfAAAEnT
         2xd3fsUdioECRHoqjSbdnlYGtD1hLlCSJ3tQQVe71IyDoCys5m65EPz5XONM 
Received: by 10.216.200.197 with SMTP id z47mr424570wen.1.1352675413447;
        Sun, 11 Nov 2012 15:10:13 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.198.201 with SMTP id v49ls3876028een.0.gmail; Sun, 11 Nov
 2012 15:10:12 -0800 (PST)
Received: by 10.14.209.66 with SMTP id r42mr18303092eeo.1.1352675412527;
        Sun, 11 Nov 2012 15:10:12 -0800 (PST)
Received: by 10.14.209.66 with SMTP id r42mr18303091eeo.1.1352675412516;
        Sun, 11 Nov 2012 15:10:12 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.23])
        by gmr-mx.google.com with SMTP id u8si1259819een.1.2012.11.11.15.10.12;
        Sun, 11 Nov 2012 15:10:12 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted sender) client-ip=213.165.64.23;
Received: (qmail invoked by alias); 11 Nov 2012 23:10:12 -0000
Received: from unknown (EHLO [192.168.1.92]) [94.185.209.43]
  by mail.gmx.net (mp031) with SMTP; 12 Nov 2012 00:10:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IKG9+QwPI5M//stHEUa4xyTvtiqYtO2i85wxXtY
	3PJ9iTp5apZrkm
X-X-Sender: gene099@bonsai2
In-Reply-To: <20121111165431.GA25884@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209455>

Hi,

On Sun, 11 Nov 2012, Jeff King wrote:

> On Sun, Nov 11, 2012 at 05:46:32PM +0100, Ren=E9 Scharfe wrote:
>=20
> > >However, I couldn't reproduce it on Linux : where the windows
> > >implementations crashes at a ~32000 depth (*not* exactly 32768, mind
> > >you), on linux it happily went through 100000 commits. I didn't take
> > >time to look much further, but maybe on my 64 bit Linux VM, the
> > >process can afford to reserve a much bigger address range for the
> > >stack of each thread than the 1Mb given to 32 bit processes on
> > >windows.  Jean-Jacques.
> >=20
> > I can reproduce it on Linux (Debian testing amd64) with ulimit -s 1000
> > to reduce the stack size from its default value of 8MB.
> >=20
> > After reverting ffc4b8012d9a4f92ef238ff72c0d15e9e1b402ed (tag: speed
> > up --contains calculation) the test passes even with the smaller
> > stack, but it makes "git tag --contains" take thrice the time as
> > before.
>=20
> Right, I am not too surprised.  That function replaced the original
> algorithm with a much faster depth-first recursive one. I haven't looked
> closely yet at Jean-Jacques' iterative adaptation, but that direction
> seems like a good fix for now.
>=20
> Ultimately, I have some ideas for doing this in a breadth-first way,
> which would make it more naturally iterative. It would involve having N
> bits of storage per commit to check N tags, but it would mean that we
> could get accurate answers in the face of clock skew (like the
> merge-base calculation, it would merely get slower in the face of skew).
>=20
> But since I haven't worked on that at all, fixing the depth-first
> algorithm to be iterative makes sense to me.

Have you tried the latest tag-contains branch of
git://github.com/msysgit/git/? It contains a couple of brush-ups and a
re-write of the recursion (which I hope is right, I had only time to work
on it during an unwanted layover at O'Hare). The SHA-1 is
fc4f42787a0dd0022d202627681362081a66ef70.

Ciao,
Johannes

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
