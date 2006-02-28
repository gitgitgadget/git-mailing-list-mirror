From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Tue, 28 Feb 2006 13:58:18 +1300
Message-ID: <46a038f90602271658h35623e58o7237a1703e6f4abd@mail.gmail.com>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
	 <20060227184641.GA21684@hand.yhbt.net>
	 <20060227185557.GA32142@delft.aura.cs.cmu.edu>
	 <20060227192422.GB9518@hand.yhbt.net>
	 <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com>
	 <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 01:58:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDtC3-0003BH-EH
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 01:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWB1A6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 19:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWB1A6U
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 19:58:20 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:17476 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751774AbWB1A6T convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 19:58:19 -0500
Received: by wproxy.gmail.com with SMTP id i27so977575wra
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 16:58:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ByysQ8mR9HC7Kpx0YRCnBRglGNRezFctH6IPEPH03pYPI2muSnh6ZaEXdRwFN3wacy8/9oGx1zD/7GD2t3NKEUjlhO2LGDoIfFB8QhF6t7ShL4dSssF9q54WDEfNLgp0fVXg4L/Qu+yudD/4zcgjokSpB/Rd3ETxne8bIZ3H9wE=
Received: by 10.54.71.13 with SMTP id t13mr38950wra;
        Mon, 27 Feb 2006 16:58:18 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Mon, 27 Feb 2006 16:58:18 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16899>

On 2/28/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Tue, 28 Feb 2006, Martin Langhoff wrote:
> > git-svn-HEAD "moves" so it's really a bad idea to have it as a tag.
> > Nothing within core git prevents it from moving, but I think that
> > porcelains will start breaking. Tags and heads are the same thing,
> > except that heads are expected to change (specifically, to move
> > forward), and tags are expected to stand still.
>
> Well, I wouldn't say that tags are expected to stand still. Some kinds of
> tags are expected to move: a "this is the last tested version" tag would
> be expected to move with testing.

Alrighty... in my git projects where things like these matter, my
"latest tested" and "current in production" refs are actually in
refs/heads.

> That said, the movement is _different_ from a branch. A branch is expected
> to move _with_ development, while a tag is expected to either stay the
> same, or move _after_ development.

Grumble. I'd say a head is expected to reliably move _forward_...
"with" development, yes, but definitely forward. In my book a tag
wouldn't move, but if I take your word for it, then a tag can perhaps
change arbitrarily?

I'm not sure how much support we have in porcelains for "tracking" a
tag if it starts changing. Right now I think we'd find all sorts of
problems, we'd need to think carefully what moving tags means for
porcelains.

> Or something even more specific, like "refs/svn-tracking/". Git
> shouldn't care - all the tools _should_ work fine with any subdirectory
> structure.

I think the moving-forward (therefore is trackable) vs stays reliably
in place distinction *is* useful. "Moves randomly" may also be useful,
but it should get a different treatment, because it's not "trackable".

Not that git and porcelains can't deal with all this stuff. But if
there is a clear convention then porcelains can be smart and refuse to
commit to the wrong place... it'd be a bit of a UI enhancement
perhaps?


martin
