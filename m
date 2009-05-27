From: John Koleszar <john.koleszar@on2.com>
Subject: git-svn: importing internal externals
Date: Wed, 27 May 2009 12:51:29 -0400
Organization: On2 Technologies
Message-ID: <1243443089.3192.43.camel@cp-jk-linux.corp.on2.com>
Reply-To: john.koleszar@on2.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 27 18:51:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9MM6-0003zT-BP
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 18:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbZE0Qvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 12:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754764AbZE0Qvo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 12:51:44 -0400
Received: from mail.on2.com ([66.162.65.131]:38643 "EHLO on2.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754658AbZE0Qvn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 12:51:43 -0400
X-Mailer: Evolution 2.24.5 
X-On2-MailScanner-i: Found to be clean
X-On2-MailScanner-From: john.koleszar@on2.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120077>

Hi,

I'm working on a one-off import of an SVN repo that makes use of
"internal" svn:externals; i.e. all URLs refer to different spots in the
same repo, potentially with peg revisions. The SVN repo holds a number
of projects, and my plan is to import them into individual git repos,
incorporating the history from any svn:external linked sub-projects.

My current strategy is to let git-svn fetch the project as it normally
would, then fix up the history on each branch by parsing the
unhandled.log with a filter-branch script. I'm currently using an index
filter, which works reasonably well, but has the undesired effect of
squashing commits on the subproject into commits on the parent project.
So if the subproject is modified in rA and rC, and the project in rB and
rD, my modified history shows only rB and rD, with rA squashed into rB
and rC squashed into rD, when I'd really like to see all 4 commits.

I have a git-svn clone of the whole repo available, and I use that to
pull out the missing external objects when recreating history. Maybe a
better idea would be to resolve the externals with my index filter on
this whole super-repo, where the history is properly linear, then
somehow filter the now-populated projects from that. I had originally
set aside this idea because I wanted git-svn to do its automagic
branch/tag extraction, and while I think I could get a git repo with the
svn layout, I'm unsure how to turn that into proper git branches and
tags.

Can anyone offer any suggestions on how to achieve this? I'm still new
to git, so nothing is jumping out at me. I'd be happy to share my filter
script (about 100 lines) if someone wants to see it.

Thanks!

John
