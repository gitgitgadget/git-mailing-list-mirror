From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Sun, 21 Jun 2009 19:50:29 +0530
Message-ID: <2e24e5b90906210720h135b3386t6e7c0a8235fdae57@mail.gmail.com>
References: <19004.34350.109422.730109@cargo.ozlabs.ibm.com>
	 <slrnh3ru9v.vgo.sitaramc@sitaramc.homelinux.net>
	 <7v3a9uszzl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 16:20:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MINuQ-0005jk-T8
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 16:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbZFUOU3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Jun 2009 10:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbZFUOU2
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 10:20:28 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:23919 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbZFUOU1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2009 10:20:27 -0400
Received: by an-out-0708.google.com with SMTP id d40so5242213and.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2009 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aZAvAHjwyveEruDlaP/LpzdmRGYqzcxvhsCkWndebXQ=;
        b=GX9Aj3OSBFVLc7TFepao+ni54Iewu61No6dFD+lOPxH1qDdptMagDyOdM2FirXw11K
         IGRgcfch8qPZ9PvA3sNBTdxzPydr0hAtnUmX50zMDwd5kxdaUOlSXX6t174yUyTdubZk
         NZfCotqBTSkeVcJk1DMP2Sd1rYOwaKijstsZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f25egrfQftEGl0RRTzq3oIryjAyk3xjkD5oLTmGKjJMx5eNXFJH8c4lZtcVbhnE0+o
         ZkBms1QTM4CfXndfRAqUJdWvuJ6lerJvNjpGNVrB5w8Y6qN41siXfWC+0VE8YebOheC0
         eafCydZsITjuoZxFEFNjzuZh4IjvRejNCvQjM=
Received: by 10.231.17.70 with SMTP id r6mr475508iba.37.1245594029839; Sun, 21 
	Jun 2009 07:20:29 -0700 (PDT)
In-Reply-To: <7v3a9uszzl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121986>

On Sun, Jun 21, 2009 at 2:52 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
> > At the command line, this gives you a detailed warning message, but=
 the
> > GUI currently allows it without any fuss.
> >
> > Since the GUI is often used by people much less familiar with git, =
it
> > seems reasonable to make the GUI more restrictive than the command =
line,
> > not less.
> > ...
> > This patch helps me a lot.
>
> The patch seems to disable checkout unconditionally, but it at least =
needs
> an "expert mode" switch to bypass the patch's logic, or (better yet) =
a
> "training wheel" switch for you to set in repositories of the people =
you
> manage.

Indeed it does disable checkout of a remote/* branch unconditionally.

I'm not just thinking of people *I* teach when I say that the
"training wheel" mode should be the default.

I believe that when someone does this _from the GUI_, it's 100%
certain they intended something else.  My basis for saying so is (1)
even from CLI, it is quite likely, which is why we have a warning, and
(2) people who use GUI are often much less expert than people who use
CLI.

Actually, what are the odds that someone is expert enough to use a
detached HEAD _properly_ (without shooting themselves in the foot),
but is _not_ expert enough to just say "git checkout origin/master" at
the CLI?=A0 I did not think that combination is worth bothering about.

You're welcome to tell me I'm wrong and that there _are_ such people
-- you guys are the gurus here -- but this is what I believe :-)

[Of course, I could just be trying to cover up the fact that those
were literally the first 3 lines of Tcl I ever wrote in all my life,
and the size and scope of gitk is well beyond my comprehension to do
anything non-trivial :-)  I'll let you decide which it is, heh!]

>
> The above should ideally read:
>
> > diff --git a/gitk b/gitk
> > index 8c66d17..411bc52
> > --- a/gitk
> > +++ b/gitk
>
> if the patch goes to Paulus.

Thanks -- I had not realised that subtlety.

Will make that change and re-send after hearing from either of you
about the above.=A0 Because if the decision is that the patch does need
to be conditional etc., it'll take me a long while anyway :-(

Regards,

Sitaram
