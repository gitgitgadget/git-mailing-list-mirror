From: Eric Hanchrow <offby1@blarg.net>
Subject: [BUG] Gitk elides backslashes in author names
Date: Thu, 09 Oct 2008 19:51:20 -0700
Message-ID: <87ljwxyxg7.fsf@offby1.atm01.sea.blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 05:24:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko8cO-0005zE-Qr
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 05:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYJJDWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 23:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbYJJDWQ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 23:22:16 -0400
Received: from smtp61.avvanta.com ([206.124.128.61]:56856 "EHLO
	mail.avvanta.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752032AbYJJDWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 23:22:15 -0400
X-Greylist: delayed 1854 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Oct 2008 23:22:15 EDT
Received: from mail.avvanta.com (localhost [127.0.0.1])
	by mail.avvanta.com (Postfix) with ESMTP id 3BC1B276C4E
	for <git@vger.kernel.org>; Thu,  9 Oct 2008 19:49:02 -0700 (PDT)
Received: from offby1.atm01.sea.blarg.net (q-static-138-125.avvanta.com [206.124.138.125])
	by mail.avvanta.com (Postfix) with ESMTP id 1A32B276C47
	for <git@vger.kernel.org>; Thu,  9 Oct 2008 19:49:02 -0700 (PDT)
Received: from erich by offby1.atm01.sea.blarg.net with local (Exim 4.69)
	(envelope-from <offby1@blarg.net>)
	id 1Ko864-0002K5-Eo
	for git@vger.kernel.org; Thu, 09 Oct 2008 19:51:20 -0700
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-BlargAV-Status: No viruses detected, BlargAV v1.1 on localhost.scooter.p.blarg.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97909>

Here's how to reproduce the problem with git version 1.6.0.2.415.g9800c0:

    $ cd /tmp
    $ rm -rf x
    $ mkdir x
    $ cd x
    $ git init
    Initialized empty Git repository in /tmp/x/.git/
    $ touch it
    $  git commit -a --author="back\\slash <foo@bar.com>" -m "yeah"
    Created initial commit 0f65eda: yeah
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 it
    $ git log
    commit 0f65eda51f33f5c56ba61f2c9dc1c5d38baec75c
    Author: back\slash <foo@bar.com>
    Date:   Thu Oct 9 19:42:17 2008 -0700

        yeah
    $ gitk

Now note that the author appears as "backslash", not "back\slash".

You might wonder why I have backslashes in my author names: it's
because I'm using git-svn, and our Subversion setup -- which uses
Windows authentication -- creates names with backslashes.
-- 
However lousy it is to sit in your basement and pretend to be an
elf, I can tell you from personal experience it's worse to sit in your
basement and try to figure if Ginger or Mary Ann is cuter.
        -- Clay Shirky
