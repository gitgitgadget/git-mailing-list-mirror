From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] Add compat/fopen.c which returns NULL on attempt to
 open directory
Date: Mon, 11 Feb 2008 11:15:37 +0100
Message-ID: <20080211111537.2bf47448@pc09.procura.nl>
References: <47ACFFD9.2030705@nrlssc.navy.mil>
	<47AD10CF.1040207@nrlssc.navy.mil>
	<20080211102950.122ba93d@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:17:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVit-0004Hg-U3
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbYBKKQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbYBKKQl
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:16:41 -0500
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:1738 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbYBKKQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:16:40 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1BAFdLS026548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 11:15:40 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20080211102950.122ba93d@pc09.procura.nl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73503>

On Mon, 11 Feb 2008 10:29:50 +0100, "H.Merijn Brand" <h.m.brand@xs4all.nl>
wrote:

> On Fri, 08 Feb 2008 20:32:47 -0600, Brandon Casey <casey@nrlssc.navy.mil>
> wrote:
> 
> > Some systems do not fail as expected when fread et al. are called on
> > a directory stream. Replace fopen on such systems which will fail
> > when the supplied path is a directory.
> 
> I applied this patch instead of mine, and added the Makefile define
> Harder to trace, as it is not issuing error messages, but could this
> success^Wfailure be related?

No, it is not. Some shell weirdness. This fixes it. Don't know off-hand
if it is portable enough

diff -pur a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
--- a/t/t5701-clone-local.sh  2008-02-02 05:09:01 +0100
+++ b/t/t5701-clone-local.sh  2008-02-11 11:13:26 +0100
@@ -37,8 +37,8 @@ test_expect_success 'local clone from x'

 test_expect_success 'local clone from x.git that does not exist' '
        cd "$D" &&
-       if git clone -l -s x.git z
-       then
+       git clone -l -s x.git z
+       if $? ; then
                echo "Oops, should have failed"
                false
        else

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
