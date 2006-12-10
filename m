X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Vilz <niv@iaglans.de>
Subject: Problems with git-svn authors file
Date: Sun, 10 Dec 2006 18:26:05 +0100
Message-ID: <20061210172604.GA18385@hermes.lan.home.vilz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 17:26:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Content-Disposition: inline
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33903>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtSRh-0004UB-Lr for gcvg-git@gmane.org; Sun, 10 Dec
 2006 18:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762269AbWLJR0f (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 12:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762273AbWLJR0f
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 12:26:35 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:2921 "EHLO
 vsectoor.geht-ab-wie-schnitzel.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1762269AbWLJR0e (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 12:26:34 -0500
Received: from localhost (localhost [127.0.0.1]) by
 vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id EAC853E77 for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 18:26:31 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1]) by localhost
 (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2u+G67VcWpIJ for <git@vger.kernel.org>; Sun, 10 Dec 2006
 18:26:07 +0100 (CET)
Received: from localhost (hermes.lan.home.vilz.de [192.168.100.26]) (using
 TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id
 4887C3E6A for <git@vger.kernel.org>; Sun, 10 Dec 2006 18:26:06 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

hello,

i tried to use git-svn with author-files and got stuck with following
error message:

Use of uninitialized value in hash element at /usr/bin/git-svn line
2952.
Use of uninitialized value in concatenation (.) or string at
/usr/bin/git-svn line 2953.
Author:  not defined in .git/info/svn-authors file
512 at /usr/bin/git-svn line 457
        main::fetch_lib() called at /usr/bin/git-svn line 328
        main::fetch() called at /usr/bin/git-svn line 187


my svn-authors file looks like this:
---->8-----------------
username = Real Name <email@address>
---->8-----------------
It is placed in .git/info/svn-authors and is configured via
svn.authorsfile. I tried to dig in the code and it says at line 2952 if
there is an $_author variable defined and no $users{$author}, then die
with that message... 

above function load_authors i have found

# '<svn username> = real-name <email address>' mapping based on git-svnimport:

now i am a bit confused, because the manual says, the svn-authors file
looks like my file above and here it sounds like 

<svn username> = real-name <email address>

is the real syntax for that file...

If i ommit the -A or --authors-file= parameter (or unset the
svn.authorsfile config-parameter)  while git-svn fetch, afterwards in 
gitk --all, there is only the svn-username and the revision-uuid.

Am i doing something wrong?

Sincerly
