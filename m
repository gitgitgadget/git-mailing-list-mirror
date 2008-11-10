From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Install issues
Date: Mon, 10 Nov 2008 12:17:39 +0100
Message-ID: <20081110121739.15f77a01@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 12:28:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzUwT-0003py-NB
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 12:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbYKJLZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 06:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbYKJLZd
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 06:25:33 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:4826 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301AbYKJLZc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 06:25:32 -0500
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Nov 2008 06:25:32 EST
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id mAABHeZe081196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Mon, 10 Nov 2008 12:17:40 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
X-Mailer: Claws Mail 3.6.1cvs12 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100514>

1. OpenSUSE 11.0's yast2 does not have "ignore dependency" anymore in
   the gui, which makes installing git from the GIT RPMS to fail as it
   seems to depend on openssh-clients, a package that has been
   deprecated in SUSE, and is not available anymore

   In 10.3 you could still go on after "ignore this dependency
   locally", and all worked fine.

So now I have to build from source, or download the rpm and look up the
flags to rpm to make --no-deps work. That feels dirty, so I rather build

Builds fine. Now 'make test', which I often mistype as 'make check'
because the GNU folk refuse to add 'make test' as an alias for 'make
check' and switching between all the sourse distributions that do it
right (perl, git, ...) and those that do it wrong (GNU) I often type
the wrong one

git-1.6.0.4 112 > make check
for i in *.c; do sparse -g -O2 -Wall  -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRLCPY -D__BIG_ENDIAN__ -D__powerpc__ $i || exit; done
/bin/sh: sparse: command not found
make: *** [check] Error 127

Maybe the Makefile could be a little more user-friendly with a message
like

	"Cannot run 'make check', as you do not have 'sparse' installed.
	 Did you mean to run 'make test' instead?"

FYI
'/bin/sh' ./aggregate-results.sh test-results/t*-*
fixed   1
success 3726
failed  0
broken  2
total   3729
rm -f -r 'trash directory' test-results

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
