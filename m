From: <pacco@tropezien.de>
Subject: How to get rid of doubled branch after renaming a branch in
 svn-repository
Date: Wed, 01 Dec 2010 13:48:09 +0100
Message-ID: <0a6b49e3cc0b08a717c0d6141073f32d@tropezien.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 01 13:48:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNm6b-0008Sy-FC
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 13:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017Ab0LAMsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 07:48:12 -0500
Received: from mail.croxxserver.de ([78.46.191.12]:39646 "EHLO
	mail.croxxserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab0LAMsL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 07:48:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.croxxserver.de (Postfix) with ESMTP id 53BCA8FC214
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 13:48:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv.croxxserver.de
Received: from mail.croxxserver.de ([78.46.191.12])
	by localhost (croxxserver.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q4ZeZqf+jScG for <git@vger.kernel.org>;
	Wed,  1 Dec 2010 13:48:09 +0100 (CET)
Received: from webmail.croxxserver.de (mail.croxxserver.de [78.46.191.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pacco@tropezien.de)
	by mail.croxxserver.de (Postfix) with ESMTPSA id CA4FE8FC213
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 13:48:09 +0100 (CET)
X-Sender: pacco@tropezien.de
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162504>

 Hi,

 I'm using git-svn as a tracking-tool for a Subversion repository.
 I currently detected an unexpected branch, seeming dead, but visible 
 using 'git branch -a'. I checked the svn log and saw that someone has 
 moved/renamed a branch. That results in a deletion of the old branch and 
 an adding of a copy of the old branch with the new branch name.

 The scenario is like that:

 $ git branch -a
 * master
   remotes/svnrepos/git-svn-test

 # Rename the branch (move) in the SVN-repos
 $ svn mv https://svn.repos/branches/git-svn-test 
 https://svn.repos/branches/git-svn-test-new

 # Update git-repository
 $ git svn fetch

 $ git branch -a
 * master
   remotes/svnrepos/git-svn-test
   remotes/svnrepos/git-svn-test-new

 You see the problem. Within Subversion simply a new repository version 
 now no longer "showing" the git-svn-test-branch was created. But within 
 git both branches stay visible.
 Well, I know that renaming a branch is really not that favoured action.
 But I expected that git-svn gathers also this deletion and removes the 
 obsolete branch.

 So, am I doing something wrong? Or am I expecting the wrong behaviour? 
 Or is that simply a feature, not a bug, and must be handled manually?
