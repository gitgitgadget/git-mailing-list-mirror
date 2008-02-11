From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: read_branches_file ()
Date: Mon, 11 Feb 2008 11:17:41 +0100
Message-ID: <20080211111741.2269f89b@pc09.procura.nl>
References: <20080208165008.52630d36@pc09.procura.nl>
	<20080208170305.069d43d2@pc09.procura.nl>
	<47B01CD4.4040004@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:18:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVjz-0004b8-Tb
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbYBKKRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYBKKRr
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:17:47 -0500
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:3737 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbYBKKRq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:17:46 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1BAHgpB058933
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 11:17:44 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <47B01CD4.4040004@op5.se>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73504>

On Mon, 11 Feb 2008 11:00:52 +0100, Andreas Ericsson <ae@op5.se> wrote:

> H.Merijn Brand wrote:
> > -       if (!f)
> > +       if (stat (gp, &st_buf) || S_ISDIR (st_buf.st_mode))
> 
> Shouldn't this be
> 	if (stat(gp, &st_buf) || !S_ISREG(st_buf.st_mode))

Yes, see several follow-ups in this thread.

> ?
> 
> Otherwise, you might end up opening a FIFO, a socket or a
> block/char special, which is obviously undesired.

At the moment of the patch I was unsure if these were supported :)
At least FIFO's and character devices are less error-prone than DIR's

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
