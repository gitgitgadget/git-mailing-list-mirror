From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: poll() emulation in git
Date: Wed, 5 Sep 2012 14:04:06 +0200
Message-ID: <00c601cd8b5e$8d22fec0$a768fc40$@schmitz-digital.de>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de> <CAE2SPAZnq1y7SuCAsS0YJ8wv6=L-QJiay03BerSZvgyqXyPX8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Paolo Bonzini'" <bonzini@gnu.org>, <bug-gnulib@gnu.org>,
	<git@vger.kernel.org>, "'Erik Faye-Lund'" <kusmabite@gmail.com>
To: "'Bastien ROUCARIES'" <roucaries.bastien@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 14:04:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9ELK-00063x-TB
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 14:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab2IEMEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 08:04:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:64373 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab2IEMEP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2012 08:04:15 -0400
Received: from DualCore (dsdf-4db50426.pool.mediaWays.net [77.181.4.38])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MZ9ey-1Ssmsp2iVg-00L5ZS; Wed, 05 Sep 2012 14:04:12 +0200
In-Reply-To: <CAE2SPAZnq1y7SuCAsS0YJ8wv6=L-QJiay03BerSZvgyqXyPX8w@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIgUOmy4ZEsU7RI7VRx80YFphUkTAKiEWRqlsEJqiA=
Content-Language: de
X-Provags-ID: V02:K0:2angUKrKlmXjtbM/DgH7nORCYuoU1i5hNqsU0053DTk
 ViBHfj4ed+wl+n9JINPt98XH35tiGbd5TbI3Tuv6Y6hn8hI+Cf
 d73ecZJKSskSZLm45C+KmWneIMdA741ONWUxd95Kq5SJbbfuqO
 VN298/UJgxlodGXag0x98UICaWonav3KOfJqls5TgxDUzUVPM1
 AwsnAcgQotdzUp4IZz5PSvZ8TXDy4tqiSjgTWHR3rSfPhjOE+r
 Jlg+v6XNS9KAQTi/hhJplPcDnuCKYU58CI/5XR5JY1jEM48m/o
 yibEL31NUBPxv5L18uiXYA0JFJUbgm7/enPmtv3tYL77a0mRFd
 0lvaq5zgtuknPCY5glDFqk2ikJm7FsiFewzQfNC/DiTxK58Y9S
 RzF5mGA6mv0Ig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204820>

> From: Bastien ROUCARIES [mailto:roucaries.bastien@gmail.com]
> Sent: Wednesday, September 05, 2012 1:55 PM
> To: Joachim Schmitz
> Cc: Junio C Hamano; Paolo Bonzini; bug-gnulib@gnu.org; git@vger.kernel.org; Erik Faye-Lund
> Subject: Re: poll() emulation in git
> 
> On Wed, Sep 5, 2012 at 1:24 PM, Joachim Schmitz <jojo@schmitz-digital.de> wrote:
> >> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> >> Sent: Tuesday, September 04, 2012 1:49 PM
> >> To: 'Junio C Hamano'
> >> Cc: 'git@vger.kernel.org'; 'Erik Faye-Lund'
> >> Subject: RE: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
> >>
> >> > From: Junio C Hamano [mailto:gitster@pobox.com]
> >> > Sent: Friday, August 24, 2012 9:47 PM
> >> > To: Joachim Schmitz
> >> > Cc: git@vger.kernel.org; 'Erik Faye-Lund'
> >> > Subject: Re: [PATCH v2] Support non-WIN32 system lacking poll() while keeping the WIN32 part intact
> >> >
> >> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >> >
> >> > > Different, but related question: would poll.[ch] be allowed to #include "git-compat-util.h"?
> >> >
> >> > Seeing other existing generic wrappers directly under compat/,
> >> > e.g. fopen.c, mkdtemp.c, doing so, I would say why not.
> >> >
> >> > Windows folks (I see Erik is already CC'ed, which is good ;-),
> >> > please work with Joachim to make sure such a move won't break your
> >> > builds.  I believe that it should just be the matter of updating a
> >> > couple of paths in the top-level Makefile.
> >>
> >> Haven't heard anything from the Windows folks yet.
> >>
> >> I'd prefer to move compat/win32/poll.[ch] into compat/poll.
> >> Then adjust a few paths in Makefile and that would be the 1st patch
> >>
> >> A 2nd patch would be my already proposed ones that make this usable for others (me in this case ;-)), namely wrapping 2 #inludes.
> >>
> >> diff --git a/compat/poll/poll.c b/compat/poll/poll.c
> >> index 403eaa7..49541f1 100644
> >> --- a/compat/poll/poll.c
> >> +++ b/compat/poll/poll.c
> >> @@ -24,7 +24,9 @@
> >>  # pragma GCC diagnostic ignored "-Wtype-limits"
> >>  #endif
> >>
> >> -#include <malloc.h>
> >> +#if defined(WIN32)
> >> +# include <malloc.h>
> >> +#endif
> >>
> >>  #include <sys/types.h>
> >>
> >> @@ -48,7 +50,9 @@
> >>  #else
> >>  # include <sys/time.h>
> >>  # include <sys/socket.h>
> >> -# include <sys/select.h>
> >> +# ifndef NO_SYS_SELECT_H
> >> +#  include <sys/select.h>
> >> +# endif
> >>  # include <unistd.h>
> >>  #endif
> >>
> >> --
> >> 1.7.12
> >
> > However: this poll implementation, while compiling OK, doesn't work properly.
> > Because it uses recv(...,MSG_PEEK), it works on sockets only (returns ENOTSOCK on anything else), while the real poll() works on all
> > kind if file descriptors, at least that is my understanding.
> >
> > Here on HP NonStop, when being connected via an non-interactive SSH, we get a set of pipes (stdin, stdout, stderr) instead of a
> > socket to talk to, so the poll() just hangs/loops.
> >
> > As git's implementation is based on ('stolen' from?) gnulib's and still pretty similar, CC to the gnulib list and Paolo
> >
> > Any idea how this could get solved? I.e. how to implement a poll() that works on non-sockets too?
> > There is some code that pertains to a seemingly similar problem in Mac OS X, but my problem is not identical, as that fix doesn't
> > help.
> 
> Could you give more context ? Are you speaking about win32 or about HP non stop?

HP NonStop

> If so pipe are broken and unfixable under windows see
> http://www.mail-archive.com/bug-gnulib@gnu.org/msg23365.html

Bye, Jojo
