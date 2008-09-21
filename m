From: John Freeman <jfreeman@cs.tamu.edu>
Subject: clone fails: Could not get the current working directory
Date: Sat, 20 Sep 2008 19:49:52 -0500
Message-ID: <48D59A30.5020403@cs.tamu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 03:01:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhDKH-0002H3-6w
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 03:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbYIUBAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 21:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbYIUBAJ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 21:00:09 -0400
Received: from smtp-relay.tamu.edu ([165.91.22.120]:19590 "EHLO
	sr-7-int.cis.tamu.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751259AbYIUBAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 21:00:08 -0400
X-Greylist: delayed 645 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Sep 2008 21:00:08 EDT
Received: from localhost (localhost.tamu.edu [127.0.0.1])
	by sr-7-int.cis.tamu.edu (Postfix) with ESMTP id 7AE7758326
	for <git@vger.kernel.org>; Sat, 20 Sep 2008 19:49:22 -0500 (CDT)
X-Virus-Scanned: amavisd-new at tamu.edu
Received: from b2.local (r74-192-200-91.bcstcmta02.clsttx.tl.dh.suddenlink.net [74.192.200.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sr-7-int.cis.tamu.edu (Postfix) with ESMTPSA id 1ABF1582E4
	for <git@vger.kernel.org>; Sat, 20 Sep 2008 19:49:22 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96379>

Howdy,

I'm trying to clone a remote repository.  Here's the background:

- The repository is bare, under Bob's home directory on a remote Sun system.
- Bob has set the group permissions for the repo directory to repogroup.
- I have an account on the remote system that is in repogroup.

I am trying to clone the repo on my home machine, using

 > git clone ssh://john@remote.system.edu/home/bob/path/to/repo

It fails with

remote: fatal: Could not get the current working directory
error: git-upload-pack: git-pack-objects died with error.
fatal: git-upload-pack: aborting due to possible repository corruption 
on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed

Checking the source code, this error is triggered after getcwd() returns 
a null pointer in setup.c:set_work_tree(), which is called at only one 
place, in setup.c:setup_git_directory_gently().

Can anyone provide any insight as to why am I seeing this error?

Thank you,
John
