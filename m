From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] compat/fopen.c: avoid clobbering the system defined
 fopen macro
Date: Thu, 8 May 2008 12:37:32 +0200
Message-ID: <20080508123732.33d6ef00@pc09.procura.nl>
References: <7vfxsudrt0.fsf@gitster.siamese.dyndns.org>
	<4821E81A.4030600@nrlssc.navy.mil>
	<e2b179460805080027pf9ff518xf4fcbb248ecac4bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Mike Ralphson" <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 12:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju3dR-0006BF-9u
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 12:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731AbYEHKpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 06:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757634AbYEHKpK
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 06:45:10 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:1422 "EHLO
	smtp-vbr14.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbYEHKpI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 06:45:08 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2008 06:45:07 EDT
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr14.xs4all.nl (8.13.8/8.13.8) with ESMTP id m48AbWlx033675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 May 2008 12:37:33 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <e2b179460805080027pf9ff518xf4fcbb248ecac4bf@mail.gmail.com>
X-Mailer: Claws Mail 3.4.0cvs25 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81523>

On Thu, 8 May 2008 08:27:48 +0100, "Mike Ralphson"
<mike.ralphson@gmail.com> wrote:

> 2008/5/7 Brandon Casey <casey@nrlssc.navy.mil>:
> >
> > Some systems define fopen as a macro based on compiler settings.
> > The previous technique for reverting to the system fopen function
> > by merely undefining fopen is inadequate in this case. Instead,
> > avoid defining fopen entirely when compiling this source file.
> >
> > Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> >
> 
> Tested-by: Mike Ralphson <mike@abacus.co.uk>
> 
> Both with and without -D_LARGE_FILES. Many thanks.
> 
> H.Merijn, is this change also ok for your HP-UX?

I'm not really actively following the ML anymore, as it is kinda busy :)
I was able to compile/test/install 1.5.5.1 on HP-UX 11.00/32 and on
HP-UX 11.23-ilp64 with a reasonable small set of additional changes.

Main thing I found to make most tests that used to fail now pass is to
use bash, instead of HP's native POSIX shell.

http://www.xs4all.nl/~procura/git-1.5.5.1-11.00.diff
http://www.xs4all.nl/~procura/git-1.5.5.1-11.23.diff

We - as a company - now actively use git on HP-UX 11.00 and Linux

> I guess there may still be a case for not defining _LARGE_FILES by
> default on AIX as all the warnings may be off-putting or mask other
> issues.

I also have AIX, but I hate it, and don't really care about it. It's
just that we have some poor customers whose IT people forced this OS
upon them.

> Maybe instead having a comment for those who need large pack-file
> support? Will submit amended Makefile patch if there's interest.

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
