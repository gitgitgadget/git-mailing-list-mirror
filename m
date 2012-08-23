From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: git on HP NonStop
Date: Thu, 23 Aug 2012 11:23:02 +0200
Message-ID: <000001cd8110$e5954fc0$b0bfef40$@schmitz-digital.de>
References: <001101cd79f2$f21b3bd0$d651b370$@schmitz-digital.de> <7vr4r98rfd.fsf@alter.siamese.dyndns.org> <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de> <alpine.LNX.2.01.1208191824100.29175@frira.zrqbmnf.qr> <000701cd7ebf$af552aa0$0dff7fe0$@schmitz-digital.de> <503217F2.5070105@viscovery.net> <7vfw7hle6l.fsf@alter.siamese.dyndns.org> <001901cd7f15$98c6ab50$ca5401f0$@schmitz-digital.de> <7vy5l9f186.fsf@alter.siamese.dyndns.org> <002b01cd8084$8459abc0$8d0d0340$@schmitz-digital.de> <5035E887.3030209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Johannes Sixt'" <j.sixt@viscovery.net>,
	"'Jan Engelhardt'" <jengelh@inai.de>, <git@vger.kernel.org>
To: "'Andreas Ericsson'" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Aug 23 11:23:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4TdI-0003vb-Ul
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 11:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169Ab2HWJXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 05:23:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:54704 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756152Ab2HWJXN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 05:23:13 -0400
Received: from DualCore (dsdf-4db5f6fe.pool.mediaWays.net [77.181.246.254])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0LdmTL-1TUyg3162N-00j1gZ; Thu, 23 Aug 2012 11:23:08 +0200
In-Reply-To: <5035E887.3030209@op5.se>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHB61oVp3im4Dlw7d/lKpMa4E4AEgJhlvNkAetPHqoCQtTARwHvED+rAsdKdxQC5ubl3QG7ob31Al/IT/0CPlvqfAIqNuw5lsi1b+A=
Content-Language: de
X-Provags-ID: V02:K0:j8jUSEbzPs9KFIxx2Y1wMZ8Ala1DUHTj+Mx4V7FCLMt
 /a19gP3UD+hXBe3F5ubQolJl3fEHrPwHpXuZvX2pad5w/N4Quz
 /v8xcG53o3zah4ctKb6hLeLTT9Oa3BbeuUY18iz+6kU/1KZLNY
 Ijyv5inQszI2OqZNjnVOEBCO71Bqn/0jlnaSr9i7rz/w6HmjVv
 vBxsC8X6NArXErz1PAnt5UogvUxOVsTnKSpxzoGHq82FjXCHDg
 SmZuU/0uPBZe4p8qZEkdNSAvR/fC3SYCbfD51/eNz5U15VYOTa
 i2tKiJp8gA10i4PeB7XLt9xgqpxLzOerpumwFY+nYG6KOmnXmn
 KaNGs7SGM7hG7/Q7QJgd5zJmreAgCKHZArPbspd0oDug0kzx9b
 2dmY1TkgpPLhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204141>

> From: Andreas Ericsson [mailto:ae@op5.se]
> Sent: Thursday, August 23, 2012 10:24 AM
> To: Joachim Schmitz
> Cc: 'Junio C Hamano'; 'Johannes Sixt'; 'Jan Engelhardt'; git@vger.kernel.org
> Subject: Re: git on HP NonStop
> 
> On 08/22/2012 06:38 PM, Joachim Schmitz wrote:
> >
> >
> >> -----Original Message-----
> >> From: Junio C Hamano [mailto:gitster@pobox.com]
> >> Sent: Tuesday, August 21, 2012 4:06 AM
> >> To: Joachim Schmitz
> >> Cc: 'Johannes Sixt'; 'Jan Engelhardt'; git@vger.kernel.org
> >> Subject: Re: git on HP NonStop
> >>
> >> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >>
> >>> OK, so let's have a look at code, current git, builtin/cat-file.c,
> >>> line 196:
> >>>          void *contents = contents;
> >>>
> >>> This variable is set later in an if branch (if (print_contents ==
> >>> BATCH), but not in the else branch. It is later used always under the
> >>> same condition as the one under which it is set.
> >>> Apparently is is malloc_d storage (there a "free(content);"), so
> >>> there's no harm al all in initializing it with NULL, even if it only
> >>> appeases a stupid compiler.
> >>
> >> It actually is harmful.  See below.
> >
> > Harmful to initialize with NULL or to use that undefined behavoir?
> >
> > I checked what our compiler does here: after having warned about "vlues us
> > used before it is set: it actually dies seem to have initializes the value
> > to 0 resp. NULL.
> > So here there's no harm done in avoiding undefined behavior and set it to 0
> > resp NULL in the first place.
> >
> 
> There is harm in tricking future programmers into thinking that the
> initialization actually means something, which some of them do.

Hmm, OK, I can agree to that.

> It's unlikely that you're the one to maintain that code forever, 

It is unlike for me to ever have to maintain this code.
Currently that's Junio's job and I won't apply for in ;-)

> and the "var = var" idiom is used widely within git 

This is overstating it a bit. I went thru the entire code and reported all places I could find in an earlier email.
I went back and counted: It is used in 11 files, at 15 places, for 21 variables. 
OK, I may have missed  a few more that were in code paths my compiler didn't see, but still some 21+ isn't really much.

>with a clear meaning

Only if you call undefined behavior a  'clear meaning"!

> as a hint to programmers who read a bit of git code. If they aren't
> used to that idiom, they usually investigate it in the code and
> pretty quickly realize that what it means.

Whether I realize what it means, is irrelevant, my compiler does not and warns about it, and as per the ANSI/ICO C standard it
invokes undefined behavior.

If a proper initialization is meaningless for these cases, don't do them at all, let the stupid compiler complain about it and the
clever programmer check whether the warning is useful, but don't avoid a compiler warning on one compiler by introducing undefined
behavior and provoke a compiler warning on another.

Bye, Jojo
