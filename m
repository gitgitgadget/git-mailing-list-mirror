From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: read_branches_file ()
Date: Fri, 8 Feb 2008 17:49:24 +0100
Message-ID: <20080208174924.24203ff3@pc09.procura.nl>
References: <20080208165008.52630d36@pc09.procura.nl>
	<20080208170305.069d43d2@pc09.procura.nl>
	<alpine.LSU.1.00.0802081618210.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 17:51:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNWR9-0007hU-HC
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 17:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762886AbYBHQtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 11:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761965AbYBHQtc
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 11:49:32 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:3072 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762871AbYBHQtb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 11:49:31 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id m18GnPDw035127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Feb 2008 17:49:25 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <alpine.LSU.1.00.0802081618210.11591@racer.site>
X-Mailer: Claws Mail 3.2.0cvs74 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73112>

On Fri, 8 Feb 2008 16:22:45 +0000 (GMT), Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Fri, 8 Feb 2008, H.Merijn Brand wrote:
> 
> > --8<--- remote.c.diff
> > --- remote.c.org        2008-01-27 09:04:18 +0100
> > +++ remote.c    2008-02-08 17:01:09 +0100
> > @@ -1,6 +1,7 @@
> >  #include "cache.h"
> >  #include "remote.h"
> >  #include "refs.h"
> > +#include <sys/stat.h>
> 
> This should not be necessary; we include all system headers in cache.h.

dropped

> > @@ -173,11 +174,15 @@ static void read_branches_file(struct re
> >         char *frag;
> >         char *branch;
> >         int n = slash ? slash - remote->name : 1000;
> > -       FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
> > +       char *gp = git_path ("branches/%.*s", n, remote->name);
> 
> Please use a more descriptive variable name, such as "branches_file" or 
> "branches_path".

took another approach, as that also addresses the other fopen () call

> Also, we only leave a space after operators like "for", "while", but not 
> after function names.

This patch was not sent to be applied as-is, only as a proof-of-concept
Not that I agree to the layout/indentation, the new patch is sent trying
to follow what you use.

> > +       if (stat (gp, &st_buf) || S_ISDIR (st_buf.st_mode))
> 
> Again, please remove the spaces after "stat" and "S_ISDIR".

you said please :)

> Other than that, the patch looks obviously correct: please resubmit with a 
> nice commit message and a sign-off.

Done

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
