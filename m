From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: newb: Given a commit id, find which branches have it as an ancestor
Date: Thu, 12 Mar 2009 10:21:50 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302E0F98D@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Kelly F. Hickel" <kfh@mqsoftware.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 12 16:31:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhmln-0001g5-C0
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 16:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530AbZCLPVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 11:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbZCLPVw
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 11:21:52 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:37113 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335AbZCLPVv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 11:21:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: newb: Given a commit id, find which branches have it as an ancestor
Thread-Index: AcmjJkP97P/xbzeYQW2QfzhPUF8iPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113077>

Hi all, I've been working on testing importing our cvs repo via cvs2git,
then using cvsps to pull incremental updates.  Something seems to have
gone awry with one of the commits, and I'm having trouble tracking it
down.

This is a question about how to track something down after the fact, not
a question about what went wrong with the cvsps import....

This is git 1.6.1 running on Centos 5.2 linux.

So, the scenario is that one of the last few commits pulled into my git
repo by cvsps/cvsimport should have landed on origin/master, but when I
look at the file, the change is missing.  I'm trying to figure out
"where it went", since it didn't go where I expected it.

Things I've tried that didn't tell me what I wanted to know:
$ git name-rev 15fa81b
15fa81b undefined


$ git log --children 15fa81b
This shows me a bunch of commits that, going by the commit date, appear
to be ancestors of the commit I'm interested in, not children.

$ git checkout  15fa81b5ae
Note: moving to "15fa81b5ae" which isn't a local branch If you want to
create a new branch from this checkout, you may do so (now or later) by
using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 15fa81b... Changed version to 4.1.0.157 $ gitk (as
expected, shows me that the commit I care about is the latest in the
workspace)

$ git checkout master
Previous HEAD position was 15fa81b... Changed version to 4.1.0.157
Switched to branch "master"
$ gitk
Doesn't list my target commit, in fact, doesn't list any commits after
the cvs2git date, so it appears that none of my cvsps pulled commits
landed on master (ok, so maybe this post is about what went wrong, just
a little ;-} ).

I suspect that I'm missing some factoid in trying to map my workflow to
Git, but this seems like the kind of thing I'd want to know, i.e. given
a commit, what branches have that commit as an ancestor.  It would seem
to be useful in two cases:
1) I've found a commit that introduced a bug and want to know what
releases that bug ended up in.
2) I've identified a fix for a previous bug and want to know what
releases already contain the fix.
(ok, those are pretty much the same workflow, but different reasons).

What am I missing????



--

Kelly F. Hickel
Senior Product Architect
MQSoftware, Inc.
952-345-8677 Office
952-345-8721 Fax
kfh@mqsoftware.com
www.mqsoftware.com
Certified IBM SOA Specialty
Your Full Service Provider for IBM WebSphere
Learn more at www.mqsoftware.com 
