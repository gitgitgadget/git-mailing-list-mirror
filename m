From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 10:41:23 +0100
Message-ID: <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
	 <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>
	 <43FB9656.8050308@vilain.net>
	 <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
	 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
	 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 10:42:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCCyq-0006fy-H4
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 10:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWBWJl1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 04:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWBWJl1
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 04:41:27 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:50203 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751677AbWBWJl0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 04:41:26 -0500
Received: by nproxy.gmail.com with SMTP id k27so5171nfc
        for <git@vger.kernel.org>; Thu, 23 Feb 2006 01:41:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cKPETvztlo938J8xoZaiHNw6fsisGJt2XX6Bjx1IHBBygK1rtr44wkf4Fi5AVWT+aGMHzeP9G6JMUIu1QOx/hrwUTfK7NFLFiqZKvIuFP3x8t2kmrYZwqG8y8HEL1hLuhMTSAbQdQBhbz3vJLwBR310KS9o8y4fdiXiOAlfAjm4=
Received: by 10.48.238.20 with SMTP id l20mr2288376nfh;
        Thu, 23 Feb 2006 01:41:23 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 23 Feb 2006 01:41:23 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16636>

On 2/23/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 2/23/06, Junio C Hamano <junkio@cox.net> wrote:
> > "Alex Riesen" <raa.lkml@gmail.com> writes:
> >
> > > I'll keep that in mind. But there are places where a safe pipe is unavoidable
> > > (filenames. No amount of careful quoting will save you).
> >
> > Huh?
>
> Because you never know what did the next interpreter took for unquoting:
> $SHELL, /bin/sh cmd /c, or something else.
>
And that stupid activestate thing actually doesn't use any. Just tried:

  perl -e '$,=" ";open(F, "sleep 1000 ; # @ARGV |") and print <F>'

It passed the whole string "1000 ; # @ARGV" to sleep from $PATH.
It failed to sleep at all, of course. The same code works perfectly on
almost any UNIX system.
