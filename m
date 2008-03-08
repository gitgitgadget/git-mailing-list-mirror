From: John Goerzen <jgoerzen@complete.org>
Subject: git-svn breaks lots with rewriteRoot
Date: Sat, 8 Mar 2008 07:35:23 -0600
Message-ID: <slrnft55gq.1so.jgoerzen@katherina.lan.complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 14:36:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXzE1-0004qs-GZ
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 14:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbYCHNfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 08:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbYCHNfz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 08:35:55 -0500
Received: from main.gmane.org ([80.91.229.2]:50445 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890AbYCHNfy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 08:35:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JXzDF-000256-22
	for git@vger.kernel.org; Sat, 08 Mar 2008 13:35:45 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 13:35:45 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 13:35:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76561>

I've trying to work with a remote repo.  I initially git-svn fetched
it using svn://.  Now I have been given svn commit access, which uses
svn+ssh:// on their server.  I edited my .git/config and set url to
the svn+ssh address and rewriteRoot to the svn:// address I wasusing
before.  This appears to work fine for doing more read operations,
such as svn fetch.

I am having a problem, though, with svn dcommit and svn rebase.  I
believe both are related to this rewriteRoot.  When I run either of
these, I see:

Unable to determine upstream SVN information from working tree history

Looking at the working_head_info and find_by_url subs in git-svn, it
appears that neither is considering rewriting.  One of them needs to
be, I believe, rewriting the URL from git-svn-id back to the "true"
URL over on the server.  This causes it to never match any of the
remote sections in .git/config.

I'm not good enough with Perl anymore, and certainly not goot enough
with this program, to whip up a patch.  Can anyone help with this?


