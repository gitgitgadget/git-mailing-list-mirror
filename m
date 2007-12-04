From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 4 Dec 2007 15:22:40 +0000
Message-ID: <20071204152240.6cb6018e@pc09.procura.nl>
References: <20071204130922.731c407a@pc09.procura.nl>
	<Pine.LNX.4.64.0712041343040.27959@racer.site>
	<20071204140326.14d9e7a0@pc09.procura.nl>
	<Pine.LNX.4.64.0712041439590.27959@racer.site>
	<20071204150102.7f3ec3e9@pc09.procura.nl>
	<47556EE2.6040105@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 04 16:23:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzZc4-0007L9-Gg
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 16:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbXLDPWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 10:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbXLDPWq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 10:22:46 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:2522 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbXLDPWp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 10:22:45 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id lB4FMfHk067992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Dec 2007 16:22:42 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <47556EE2.6040105@op5.se>
X-Mailer: Claws Mail 3.1.0cvs51 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67054>

On Tue, 04 Dec 2007 16:14:42 +0100, Andreas Ericsson <ae@op5.se> wrote:

> H.Merijn Brand wrote:
> > 
> > I also meanwhile forced copied the git binaries to my bin dir
> > 
> 
> That's no good. "make test" will test binaries residing in ..
> relative to where the tests are executed.

OK, I removed those again :)

I also removed the -ldce in the HP-UX piece, which was there to
support unsetenv, but using NO_UNSETENV seems to be safer

ifeq ($(uname_S),HP-UX)
	# HP-UX
	BASIC_LDFLAGS += -L/usr/local/ssl/lib -L/usr/local/lib
	#EXTLIBS += -ldce
	NO_HSTRERROR = YesPlease
	NO_ICONV = YesPlease
	NO_INET_NTOP = YesPlease
	NO_INET_PTON = YesPlease
	NO_UNSETENV = YesPlease
endif

causes a clean build

+ + pwd
GIT_EXEC_PATH=/pro/3gl/LINUX/git-1.5.3.7/t/..
+ + pwd
GIT_TEMPLATE_DIR=/pro/3gl/LINUX/git-1.5.3.7/t/../templates/blt
+ GIT_CONFIG=.git/config
+ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG
+ + pwd
+ pwd
GITPERLLIB=/pro/3gl/LINUX/git-1.5.3.7/t/../perl/blib/lib:/pro/3gl/LINUX/git-1.5.3.7/t/../perl/blib/arch/auto/Git
+ export GITPERLLIB
+ test -d ../templates/blt
+ test -x ../test-chmtime
+ test=trash
+ rm -fr trash
+ test_create_repo trash
+ cd trash
+ + expr ./t0001-init.sh : .*/\(t[0-9]*\)-[^/]*$
this_test=t0001
+ test_expect_success plain
        (
                unset GIT_DIR GIT_WORK_TREE &&
                mkdir plain &&
                cd plain &&
                git init
        ) &&
        check_config plain/.git false unset

* expecting success:
        (
                unset GIT_DIR GIT_WORK_TREE &&
                mkdir plain &&
                cd plain &&
                git init
        ) &&
        check_config plain/.git false unset

* FAIL 1: plain

                (
                        unset GIT_DIR GIT_WORK_TREE &&
                        mkdir plain &&
                        cd plain &&
                        git init
                ) &&
                check_config plain/.git false unset



/pro/3gl/LINUX/git-1.5.3.7/t 130 > ldd ../git
        /usr/lib/libc.2 =>      /usr/lib/libc.2
        /usr/lib/libdld.2 =>    /usr/lib/libdld.2
        /usr/lib/libc.2 =>      /usr/lib/libc.2
        /usr/local/ssl/lib/libcrypto.sl =>      /usr/local/ssl/lib/libcrypto.sl
        /usr/local/lib/libz.sl =>       /usr/local/lib/libz.sl


I will leave for a meeting in 30 minutes, so don't think I don't want
to communicate any further :)

Sam is pretty enthusiastic on IRC, he's to blame!

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
