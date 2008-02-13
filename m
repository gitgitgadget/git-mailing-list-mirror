From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: libcrypto core dump in 64bit
Date: Wed, 13 Feb 2008 11:57:38 +0100
Message-ID: <20080213115738.75301520@pc09.procura.nl>
References: <20080211112822.16b69495@pc09.procura.nl>
	<alpine.LSU.1.00.0802112240280.3870@racer.site>
	<20080212150612.4d28c373@pc09.procura.nl>
	<loom.20080212T152138-849@post.gmane.org>
	<20080212173842.0a3704b1@pc09.procura.nl>
	<bcfb3e870802130104n46d88964uee3eb3841c38807b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michal Rokos" <michal@rokos.cz>
X-From: git-owner@vger.kernel.org Wed Feb 13 11:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPFJo-0006ib-RQ
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 11:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbYBMK5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 05:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbYBMK5u
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 05:57:50 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:1485 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbYBMK5r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 05:57:47 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1DAvdR7043644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Feb 2008 11:57:39 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <bcfb3e870802130104n46d88964uee3eb3841c38807b@mail.gmail.com>
X-Mailer: Claws Mail 3.3.0cvs11 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73772>

On Wed, 13 Feb 2008 10:04:23 +0100, "Michal Rokos" <michal@rokos.cz> wrote:

> Hello,
> 
> On Feb 12, 2008 5:38 PM, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> > Did you get the full test suite to pass?
> 
> No - vanilla git's master won't pass (since HPUX vsnprintf is broken
> (it returns -1 when n is exceeded).

diff -purN git-1.5.4/strbuf.c git-1.5.4p/strbuf.c
--- git-1.5.4/strbuf.c  2008-02-02 05:09:01 +0100
+++ git-1.5.4p/strbuf.c 2008-02-13 11:26:56 +0100
@@ -127,7 +127,7 @@ void strbuf_addf(struct strbuf *sb, cons
        int len;
        va_list ap;

-       if (!strbuf_avail(sb))
+       if (strbuf_avail(sb) < 64)
                strbuf_grow(sb, 64);
        va_start(ap, fmt);
        len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);


> With strbuf workarounds test suite passes up to t4200-rerere.sh.
> 
> I did not try to investigate further or continue with the rest of the tests.

I did, and got here
http://www.xs4all.nl/~procura/git-1.5.4-hpux1123ipf64.diff

Note, ntar = GNU tar, and npatch is the 'patch' as the rest of the world
knows it. Our perl is in /pro. We do not want to interfere with the system
perl (and mine is always newer anyway).

git-clone is a shell script, and it's return value is ignored somewhere

/pro/3gl/LINUX/git-1.5.4p/t 122 > cat do-tests
#!/bin/sh

export TAR=ntar
rm -f *.err
for t in t[0-9]*.sh ; do
    echo $t
    sh $t > test.err 2>&1 || mv test.err $t.err
    rm -f test.err
    done
/pro/3gl/LINUX/git-1.5.4p/t 123 > ll *.err
204744 -rw-rw-rw- 1 merijn softwr  344 Feb 13 11:49 t5600-clone-fail-cleanup.sh.err
204788 -rw-rw-rw- 1 merijn softwr  458 Feb 13 11:49 t5701-clone-local.sh.err
205057 -rw-rw-rw- 1 merijn softwr 3039 Feb 13 11:50 t6002-rev-list-bisect.sh.err
204643 -rw-rw-rw- 1 merijn softwr 3980 Feb 13 11:50 t6003-rev-list-topo-order.sh.err
204808 -rw-rw-rw- 1 merijn softwr  899 Feb 13 11:50 t6022-merge-rename.sh.err
204697 -rw-rw-rw- 1 merijn softwr 1340 Feb 13 11:52 t7201-co.sh.err
204747 -rw-rw-rw- 1 merijn softwr  149 Feb 13 11:53 t9300-fast-import.sh.err
204699 -rw-rw-rw- 1 merijn softwr 1651 Feb 13 11:53 t9301-fast-export.sh.err
/pro/3gl/LINUX/git-1.5.4p/t 124 >

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
