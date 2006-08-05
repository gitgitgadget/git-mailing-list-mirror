From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Sat, 5 Aug 2006 01:12:53 -0400
Message-ID: <9e4733910608042212p6bf56224ye0ecf3f06b2840cf@mail.gmail.com>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	 <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
	 <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
	 <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
	 <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
	 <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
	 <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org>
	 <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com>
	 <46a038f90608042115m71adc8ffo77de7940efa847a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 05 07:13:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9ETY-0004o1-CE
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 07:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWHEFM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 01:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWHEFM4
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 01:12:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:7081 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932486AbWHEFMz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 01:12:55 -0400
Received: by nf-out-0910.google.com with SMTP id k26so114558nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 22:12:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eKRwgtBCb9KKFvgO1k7C7N8VZeN4ooLFaSwWjzr5G6fQ7reKadfFYTdI2VJeAFWK1M5/3yjwv8fdvwsYvEIiyK4PqyXlxIwKl5zUeOcABk1JhEflUb5E23j8yHOcsb9MP1x0Rc7hy/iLxxOUIKijQupIB5BHM7xL05Q8UXYEtVA=
Received: by 10.78.139.5 with SMTP id m5mr1823594hud;
        Fri, 04 Aug 2006 22:12:54 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Fri, 4 Aug 2006 22:12:53 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90608042115m71adc8ffo77de7940efa847a8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24881>

On 8/5/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 8/5/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 8/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > > and you're basically all done. The above would turn each *,v file into a
> > > *-<sha>.pack/*-<sha>.idx file pair, so you'd have exactly as many
> > > pack-files as you have *,v files.
> >
> > I'll end up with 110,000 pack files.
>
> Then just do it every 100 files, and you'll only have 1,100 pack
> files, and it'll be fine.

This is something that has to be tuned. If you wait too long
everything spills out of RAM and you go totally IO bound for days. If
you do it too often you end up with too many packs and it takes a day
to repack them.

If I had a way to pipe the all of the objects into repack one at a
time without repack doing multiple passes none of this tuning would be
necessary. In this model the standalone objects never get created in
the first place. The fastest IO is IO that has been eliminated.

> > I suspect when I run repack over
> > that it is going to take 24hrs or more,
>
> Probably, but only the initial import has to incur that huge cost.

Mozilla developers aren't all rushing to switch to git. A switch needs
to be as painless as possible. If things are too complex they simply
won't switch.

Switching Mozilla to git is going to require a sales job and proof
that the tools are reliable and better than CVS. Right now I can't
even reliably import Mozilla CVS. One of the conditions for even
considering git is that they can easily do the CVS import internally
and verify it for accuracy.

-- 
Jon Smirl
jonsmirl@gmail.com
