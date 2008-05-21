From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: gitignore: negating path patterns
Date: Wed, 21 May 2008 16:52:36 +0200
Message-ID: <g11cvn$ndr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 16:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyphV-0001RL-Lq
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 16:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765437AbYEUOwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 10:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765095AbYEUOwx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 10:52:53 -0400
Received: from main.gmane.org ([80.91.229.2]:46080 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758578AbYEUOwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 10:52:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JypgN-0001EM-4W
	for git@vger.kernel.org; Wed, 21 May 2008 14:52:47 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 May 2008 14:52:47 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 May 2008 14:52:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82548>

Hi there

It seems that negating path patterns in gitignore doesn't work, or I
don't understand it (or both). With the attached script, git status
(1.5.5.1) reports "dir/a" as new and "dir/b" as untracked. I would
rather expect it to report "dir/c" as untracked also.

It seems that "!b" matches to include "dir/b" (reverting the exclusion
"*" as expected), whereas "!dir/" does not match to include "dir/c".

What's going on here?

Michael

P.S.: "*" in dir/.gitignore would do what I want, but I want all
patterns in one place.

P.P.S.: My first attempt at sending this was blocked (by an MS CDO for 
Exchange 2000?! Is this gmane playing pranks on me?). So I'll resend 
with the script inline rather than attached.

---etest.sh---


#!/bin/sh
rm -Rf test
mkdir test
cd test
git init
mkdir dir
echo test > a
echo test > dir/a
echo test > dir/b
echo test > dir/c
git add dir/a
cat > .git/info/exclude <<EOF
*
!dir/
!b
EOF
git status
