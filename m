From: jpaugh@gmx.us
Subject: Specifying revisions in the future
Date: Sat, 04 Feb 2012 10:58:55 -0500
Message-ID: <jgjkk0$qrg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 05 01:05:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtpbW-0000q0-Lb
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 01:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568Ab2BEAFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 19:05:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:35191 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509Ab2BEAFH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 19:05:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RtpbK-0000m1-UG
	for git@vger.kernel.org; Sun, 05 Feb 2012 01:05:02 +0100
Received: from 74-46-161-231.dr02.blfd.wv.frontiernet.net ([74.46.161.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 01:05:02 +0100
Received: from jpaugh by 74-46-161-231.dr02.blfd.wv.frontiernet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 01:05:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 74-46-161-231.dr02.blfd.wv.frontiernet.net
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111229 Thunderbird/9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189924>

Hello.

Is it possible to specify revisions in the future? The gitrevisions man
page implies otherwise. Alternatively, is there a way to find out the
number of commits between two revs---assuming one is an ancestor of the
other?

I want to do a certain arbitrary operation for each revision between
where I am now and the tip of the branch.

          v1.0-a     master
            \          \
o---o---o---o---o---o---o
            |
           I am here

I've been using the following to do what I want:

ref=master; \
for i in {5..1}; do \
  echo; \
  git log --stat $ref~$i^\!; \
  read -p 'Full diff? '; \
  echo; \
  if [[ $REPLY == 'y' ]]; then \
    git diff $ref~$i^\!; \
  fi; \
done;

which lists the log and diffstat for last 5 commits between master and
where I am (e.g. an older tag/branch) with an optional full diff. I know
implementing revision specifiers to the future is nontrivial. (I
realized that when I considered non-linear histories.) In this case,
I've distilled it to the point that all I need is the number of commits
between two revs. Can this be had without manually inspecting git log?
Or, is there a better way to get detailed diffs like this?

Thanks.
Jonathan Paugh
