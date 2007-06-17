From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsserver: fix legacy cvs client and branch rev issues
Date: Mon, 18 Jun 2007 09:27:17 +1200
Message-ID: <46a038f90706171427g43c4ccf2vdf1172a962481964@mail.gmail.com>
References: <11820198064114-git-send-email-djk@tobit.co.uk>
	 <20070617081959.GD1828@planck.djpig.de> <4674FA9B.10806@tobit.co.uk>
	 <20070617103744.GE1828@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Dirk Koopman" <djk@tobit.co.uk>, git@vger.kernel.org
To: "Frank Lichtenheld" <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun Jun 17 23:27:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I02HJ-0004Gv-Ii
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 23:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbXFQV1U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 17:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbXFQV1U
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 17:27:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:40688 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbXFQV1T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 17:27:19 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1336007wxc
        for <git@vger.kernel.org>; Sun, 17 Jun 2007 14:27:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uLxXoUQAlYZOzxHM/+kVi4ZJQ4XQodzxxbQINkeWWFg6P5lLZ2AeS+wiiWXm9ENNWWv61ZUwrskOqYG8FIusftdv+lUDmb4fkuR9YryuL73gF8nvUIPemK/zIjU+PB35dARww3izSWnX0JGgFJg3qa7vu8TAXCZ7MOCk6xD5NGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=unMpVfPQWNz4p1jmzRv4nSENtJiZIKkHP/mKdcmRX1gHrLnzKQpAwFiRkPh+vBh2SClt9T/thylyLZbU7kBZxYJrwuzQtanXZY9bLmyNOGWSV7tNB7h7djTPgZVLiMsRUh4WAC7dzUtw4YnGSexYi0/HX4XEKT/2xQvyCDgFhwI=
Received: by 10.90.105.19 with SMTP id d19mr3358109agc.1182115637802;
        Sun, 17 Jun 2007 14:27:17 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Sun, 17 Jun 2007 14:27:17 -0700 (PDT)
In-Reply-To: <20070617103744.GE1828@planck.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50374>

On 6/17/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> On Sun, Jun 17, 2007 at 10:10:51AM +0100, Dirk Koopman wrote:
> > Frank Lichtenheld wrote:
> > >On Sat, Jun 16, 2007 at 07:50:06PM +0100, Dirk Koopman wrote:
> > >Hmm, I don't see how you could have a problem with that since cvsserver
> > >doesn't support branches and never generates any revision numbers in
> > >that format?
> > >
> > >There is probably much more code out there in cvsserver that does assume
> > >that revision is always a simple integer.
>
> Let me rephrase that (after actually looking through the code):
> All of the revision handling code assumes that.

Exactly. cvsserver emulates CVS on a single HEAD, that's why you use
the headname as the 'module' parameter you pass to CVS when doing a
checkout.

...

> Hmm, so you did the cvs update in an old working copy of the original
> CVS repository? Then CVS sent those version numbers from the CVS/Entries
> file to the server, cvsserver certainly never generates numbers like
> that. And I would be very suprised if you could do anything remotely
> useful with abusing the old working copy this way...

Agreed - that's not really supported.

Now, I'd _love_ to have a bit of time to implement CVS-style branch
support to cvsserver (so a check for valid version numbers that have
more dots would be a good thing), but it's hard hard hard, specially
because there are many ambiguities to resolve. It would enormously
useful to have branch support together with support for a bit of
"version skew" so that you can replace a real CVS server with
cvsserver and have people continue using the old cvs checkouts --
because the file versions and branches match.

As things stand, I want to say thanks to Frank for giving cvsserver
some love :-)

cheers,


martin
