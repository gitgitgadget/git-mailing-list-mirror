From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Tue, 18 Dec 2007 11:49:49 +0100
Message-ID: <20071218114949.711ba447@pc09.procura.nl>
References: <20071217192306.5da48540@pc09.procura.nl>
	<7v8x3t6nq1.fsf@gitster.siamese.dyndns.org>
	<4767934F.7070706@op5.se>
	<7vir2w1ghi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 11:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4a2y-0007lB-HK
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 11:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbXLRKvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 05:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbXLRKvM
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 05:51:12 -0500
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:4156 "EHLO
	smtp-vbr12.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbXLRKvL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 05:51:11 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr12.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBIAnnpL048783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 11:49:50 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vir2w1ghi.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68727>

On Tue, 18 Dec 2007 01:47:53 -0800, Junio C Hamano <gitster@pobox.com> wrote:

> Andreas Ericsson <ae@op5.se> writes:
> 
> > Junio C Hamano wrote:
> >>
> >> Besides, isn't _HPUX_SOURCE a feature-test macro?  Feature test macros
> >> are for the application to define, and for the implementation (iow, the
> >> header files) to find out what set of names the application wants to
> >> see.  You are making the application examine the symbol to see what
> >> implementation it is on, which feels backwards to me.
> >
> >
> >  #if defined(hpux) || defined(_hpux) || defined(__hpux)
> >
> > should work ok, although as you say, trying
> >
> >  #if _POSIX_VERSION < 200112
> >  # include <non-POSIX.1-2001 headers>
> >  #else
> >  # include <sys/select.h>
> >  #endif
> >
> > would probably be more suitable.
> 
> I cannot take credit for having said that (I didn't), but it sounds like
> a sensible thing to compare _POSIX_VERSION with 200112L.  For previous
> SUS, <sys/time.h> would have defined select(2), but that header file is
> already included anyway.
> 
> Merijn, discarding the earlier patch I did to configure it out for
> HP-UX, does the following patch based on Andreas's idea work for you?

Probably not:

HP-UX 10.20, 11.00, 11.11, 11.23/PA, and 11.23/IPF all have:

/usr/include 103 > grep -r POSIX_VERSION *
sys/unistd.h:#    define _POSIX_VERSION _POSIX1_VERSION_88
sys/unistd.h:#      define _POSIX_VERSION       _POSIX1_VERSION_90
sys/unistd.h:#      define _POSIX_VERSION       _POSIX1_VERSION_93
sys/unistd.h:#  define _SC_1_VERSION_88    7     /* _POSIX_VERSION: Date of POSIX.1-1988 */
sys/unistd.h:#  define _SC_1_VERSION_90   102 /* _POSIX_VERSION: Date of POSIX.1-1990 */
sys/unistd.h:#  define _SC_1_VERSION_93   103 /* _POSIX_VERSION: Date of POSIX.1b-1993 */
sys/unistd.h:#  if (_POSIX_VERSION == _POSIX1_VERSION_88)
sys/unistd.h:#    if (_POSIX_VERSION == _POSIX1_VERSION_90)

and the two 11.23 do have select.h

> ---
> 
>  git-compat-util.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 79eb10e..68a580f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -68,7 +68,9 @@
>  #include <sys/poll.h>
>  #include <sys/socket.h>
>  #include <sys/ioctl.h>
> +#if _POSIX_VERSION >= 200112L
>  #include <sys/select.h>
> +#endif
>  #include <assert.h>
>  #include <regex.h>
>  #include <netinet/in.h>

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
