From: "Brown, Len" <len.brown@intel.com>
Subject: RE: new file leaked onto release branch
Date: Sun, 18 Dec 2005 22:21:53 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30056F9395@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 19 04:23:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoBbR-0003YV-NQ
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 04:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVLSDWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 22:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbVLSDWI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 22:22:08 -0500
Received: from fmr14.intel.com ([192.55.52.68]:60578 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751191AbVLSDWH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 22:22:07 -0500
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jBJ3Luxn026856;
	Mon, 19 Dec 2005 03:21:56 GMT
Received: from fmsmsxvs042.fm.intel.com (fmsmsxvs042.fm.intel.com [132.233.42.128])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id jBJ3LoGK016948;
	Mon, 19 Dec 2005 03:21:56 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs042.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005121819215603828
 ; Sun, 18 Dec 2005 19:21:56 -0800
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx331.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 18 Dec 2005 19:21:56 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 18 Dec 2005 19:21:55 -0800
Content-class: urn:content-classes:message
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new file leaked onto release branch
Thread-Index: AcYDoeIN3bFY9I9EQGG6ZBRT3rsfjgApb1ag
To: "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@osdl.org>
X-OriginalArrivalTime: 19 Dec 2005 03:21:55.0994 (UTC) FILETIME=[5D3C77A0:01C6044B]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13808>

 
>This theory however does not seem to match what really happened.
>Len did mention that he has "5165" branch (there is a commit
>marked "Pull 5165 into release branch" near a problematic
>merge), but he did not say he also has a 5165 tag; the bug does
>not trigger if you do not have the tag of the same name.  Also
>if this theory holds true, the problematic commit should have a
>commit whose object name begins with 5165 as the second parent
>but that is not the case.  And the problem happened with a
>commit that is not a merge between release/test and topic
>branch anyway; it is with an "Auto-update from upstream" commit.

Per Tony's topic-branches howto, I do plenty of branching,
where the topic branch name , #### below , is a 4-digit number:

git checkout -b #### linus

and I use the wrapper script to do this:

git checkout test && git merge "Pull #### into test branch" test ####
git checkout release && git merge "Pull #### into release branch" release ####


But
1. I don't create tags with #### names, indeed, I never use tags at all
2. I agree that while #### names may be an area of a potential
   problem, it may not be related to the observed failure.  This is
   because the file in question was added to to a topic branch called "acpica"
   which IIR never interacted in any way with a branched named ####,
   but only with the branches called "linus" and "test".

>So I am still puzzled by the "where did this file come from"
>problem.  The most plausible explanation was the driver error
>mentioned already in the thread: "update-index --add" in the
>middle of merge with manual committing.

I too suspect that a failed automatic merge is related.
Likely the sequence of events is not something that either
a git expert or a git beginner would ever issue, but takes
somebody like me who knows just enough to be dangerous:-)

-Len
