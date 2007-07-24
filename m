From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Re: workflow question
Date: Tue, 24 Jul 2007 12:30:12 -0400
Message-ID: <e2a1d0aa0707240930gb99cb0csd1ce9946d33982d@mail.gmail.com>
References: <e2a1d0aa0707240653x55dd82b3pf9e3986f5c3bb344@mail.gmail.com>
	 <81b0412b0707240837l16844dbct52ffa426d8b8547b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 18:30:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDNH9-0007rF-Ox
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 18:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbXGXQaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbXGXQaP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 12:30:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:64088 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbXGXQaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 12:30:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2441549wah
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 09:30:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ehD4sySsSKK5Kra031soXmrnvvyGez7c0puf6KGPNzppgl72q8veQVlp8rBLp83Q3rdpGqcfbkbAYbqiJ8A8snBSLptW5bLZO6Aqb1AXzgKJhPI4KZIgu9h0cImsq+6HnsY6EOtuG0HPOY698e/s1KfOlkji2SK32bnjTp0S2iw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JcqMUlptxR45qNhKXrdZXdC0nZg8eGseXF4Ya+7r7Irs6E8+/6TSh7EI9OP8HxBMyoJmPX5M8HY6zHrhS7MUNjRZPiOC+0Sig20mptKGd6E9pc05rAmfgCIO4Vt075jIxYhxNs5cfSIPag8PQrPbrpsJ9MAsJ9wOMq+ahxRjl/4=
Received: by 10.114.144.1 with SMTP id r1mr4226663wad.1185294612593;
        Tue, 24 Jul 2007 09:30:12 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Tue, 24 Jul 2007 09:30:12 -0700 (PDT)
In-Reply-To: <81b0412b0707240837l16844dbct52ffa426d8b8547b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53611>

On 7/24/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 7/24/07, Patrick Doyle <wpdster@gmail.com> wrote:
> > 2) When I don't fork a branch,
>
> this is a confusing sentence: "fork" does not happen as
> an explicit operation (if at all). You just commit somewhere
> and depending on how you look at the history you either
> see or not see a "fork".
ok, I probably should have said, "When I don't create a branch, and
when I have not yet committed any changes for the particular
feature..."

>
> > ... and I don't commit until I've completed
> > the particular feature I'm working on, I can get a fairly good idea of
> > where I am and what I was doing last (which might be 5-7 days ago,
> > given high priority interrupts on other projects, summer vacations,
> > etc...) just by running a "git status".  I see that there are 7 new
> > files, and 2 modified files.  I know that, when I fork my branch, I
> > can use "git diff master" to see what's different between my branch
> > and the master, but then I get the diff of all of the changes as well,
> > which is too much information.  "git diff --name-only" and "git diff
> > --summary" are closer, but I can't tell what's been added vs. what's
> > been changed.  Any suggestions?
>
> "git log -p ..master", or even simpler "gitk ..master"
I was hoping for something less verbose than a diff or a patch file --
something that just listed what has changed -- I'll have to
investigate whether your "my_status()" macro provides the information
for which I was looking -- thanks for the pointer.

And, as for gitk, there is something about the combination of the
screen on my laptop, my Linux installation (FC6), my X server
configuration, and/or me that makes the fonts totally unreadable.  I
keep meaning to follow up on that, but I'm stuck in a
chicken-and-the-egg situation.  I don't see the utility of gitk
because I can't read the display that it produces.  I don't look for
the time to fix the display that it produces because, thus far, I
don't see the utility of gitk.  Sigh...


> my_status() {
>   git diff --cached --name-status -r -M -C HEAD -- "$@" && \
>   git diff --name-status -r -M -C -- "$@"
> }
>
> Use as: my_status [pathname-limiter].
> Does not show untracked files, though.
>
Ahhh... I was looking around git-status instead of git-diff.  That
makes sense now that you mention it.  Someday I may have the intuitive
understanding of git that would point me in that direction myself, but
I ain't there yet :-)

Thanks.

--wpd
