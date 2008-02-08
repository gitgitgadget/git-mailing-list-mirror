From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a
 file
Date: Fri, 8 Feb 2008 21:04:47 +0100
Message-ID: <20080208210447.289022b6@pc09.procura.nl>
References: <20080208174654.2e9e679c@pc09.procura.nl>
	<e2b179460802080925s61270036q81896010c76236ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mike Ralphson" <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:06:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNZTo-0000W2-NP
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935223AbYBHUE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935220AbYBHUE4
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:04:56 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:1432 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935200AbYBHUEy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:04:54 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id m18K4mD0024991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Feb 2008 21:04:48 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <e2b179460802080925s61270036q81896010c76236ae@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73127>

On Fri, 8 Feb 2008 17:25:52 +0000, "Mike Ralphson" <mike.ralphson@gmail.com>
wrote:

> On Feb 8, 2008 4:46 PM, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> > HP-UX allows directories to be opened with fopen (path, "r"), which
> > will cause some translations that expect to read files, read dirs
> > instead. This patch makes sure the two fopen () calls in remote.c
> > only open the file if it is a file.
> >
> > Signed-off-by: H.Merijn Brand <h.m.brand@xs4all.nl>
> 
> Many thanks, this is also required for AIX. I had got some way to
> tracking it down, but I thought it was an issue with strbuf. So...
> 
> Tested-by: Mike Ralphson <mike.ralphson@gmail.com>
> 
> Your other fix there [- if (!strbuf_avail(sb)) / + if
> (strbuf_avail(sb) < 64) ] is, guess what, also required on AIX.
> 
> Thanks again.

Not there yet ...

$ cat do-tests
#!/bin/sh

export TAR=ntar
rm -f *.err
for t in t[0-9]*.sh ; do
    echo $t
    sh $t > test.err 2>&1 || mv test.err $t.err
    rm -f test.err
    done
$

197509 -rw-rw-rw- 1 merijn softwr 1633 Feb  8 18:03 t5302-pack-index.sh.err
196846 -rw-rw-rw- 1 merijn softwr  943 Feb  8 18:04 t5500-fetch-pack.sh.err
203431 -rw-rw-rw- 1 merijn softwr  344 Feb  8 18:05 t5600-clone-fail-cleanup.sh.err
202602 -rw-rw-rw- 1 merijn softwr  458 Feb  8 18:05 t5701-clone-local.sh.err
202761 -rw-rw-rw- 1 merijn softwr 3039 Feb  8 18:06 t6002-rev-list-bisect.sh.err
202641 -rw-rw-rw- 1 merijn softwr 3980 Feb  8 18:06 t6003-rev-list-topo-order.sh.err
202731 -rw-rw-rw- 1 merijn softwr  899 Feb  8 18:06 t6022-merge-rename.sh.err
197510 -rw-rw-rw- 1 merijn softwr 1340 Feb  8 18:08 t7201-co.sh.err
202705 -rw-rw-rw- 1 merijn softwr  149 Feb  8 18:09 t9300-fast-import.sh.err
197051 -rw-rw-rw- 1 merijn softwr 1651 Feb  8 18:09 t9301-fast-export.sh.err

http://www.xs4all.nl/~procura/git-1.5.3-1123ipf.tar

Tips welcome :)

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
