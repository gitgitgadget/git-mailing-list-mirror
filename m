From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: git push hung?
Date: Sun, 7 Dec 2014 09:24:09 -0500
Organization: PD Inc
Message-ID: <F818AFA80A5F46BBA007F6EB102A75C5@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 07 15:24:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxcky-0001B9-V7
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 15:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbaLGOYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 09:24:13 -0500
Received: from mail.pdinc.us ([67.90.184.27]:32839 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbaLGOYM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 09:24:12 -0500
Received: from black (five-58.pdinc.us [192.168.5.58])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id sB7EOAln031410
	for <git@vger.kernel.org>; Sun, 7 Dec 2014 09:24:11 -0500
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdASKXb2jIbOt8A0STOKa98qyJMQAA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260989>

I am trying to push to our local intranet git (smart https behind apache), and it has been at this point for 10+ hours.

jpyeron@black /projects/git/git
$ GIT_TRACE=1 git push
09:08:45.662902 git.c:349               trace: built-in: git 'push'
09:08:45.662902 run-command.c:341       trace: run_command: 'git-remote-https' 'origin' 'https://intranet.pdinc.us/git/git/'
09:08:46.225700 run-command.c:341       trace: run_command: 'git credential-cache --timeout=99999999999 get'
09:08:46.256967 run-command.c:192       trace: exec: '/bin/sh' '-c' 'git credential-cache --timeout=99999999999 get' 'git credential-cache --timeout=99999999999 get'
09:08:46.366400 git.c:554               trace: exec: 'git-credential-cache' '--timeout=99999999999' 'get'
09:08:46.366400 run-command.c:341       trace: run_command: 'git-credential-cache' '--timeout=99999999999' 'get'
09:08:47.022999 run-command.c:341       trace: run_command: 'git credential-cache --timeout=99999999999 store'
09:08:47.038632 run-command.c:192       trace: exec: '/bin/sh' '-c' 'git credential-cache --timeout=99999999999 store' 'git credential-cache --timeout=99999999999 store'
09:08:47.116799 git.c:554               trace: exec: 'git-credential-cache' '--timeout=99999999999' 'store'
09:08:47.116799 run-command.c:341       trace: run_command: 'git-credential-cache' '--timeout=99999999999' 'store'
09:08:47.366931 run-command.c:341       trace: run_command: 'send-pack' '--stateless-rpc' '--helper-status' '--thin' '--progress' 'https://intranet.pdinc.us/git/git/' 'refs/heads/master:refs/heads/master'
09:08:47.382565 exec_cmd.c:134          trace: exec: 'git' 'send-pack' '--stateless-rpc' '--helper-status' '--thin' '--progress' 'https://intranet.pdinc.us/git/git/' 'refs/heads/master:refs/heads/master'
09:08:47.429465 git.c:349               trace: built-in: git 'send-pack' '--stateless-rpc' '--helper-status' '--thin' '--progress' 'https://intranet.pdinc.us/git/git/' 'refs/heads/master:refs/heads/master'
09:08:47.538898 run-command.c:341       trace: run_command: 'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin' '--delta-base-offset' '--progress'
09:08:47.695231 exec_cmd.c:134          trace: exec: 'git' 'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin' '--delta-base-offset' '--progress'
09:08:47.742131 git.c:349               trace: built-in: git 'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin' '--delta-base-offset' '--progress'
Counting objects: 18734, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (5707/5707), done.
Writing objects: 100% (18734/18734), 9.37 MiB | 0 bytes/s, done.
Total 18734 (delta 14519), reused 17108 (delta 12968)

Servier died, this is in the log:

fatal: protocol error: expected old/new/ref, got 'shallow 3339e9f686bd4c17e3575c71327c4ccf1e8e077b'

What steps can I take to debug this hang in the client?

Git fetch hangs the same way with a server exit of fatal: did not find object for shallow 3339e9f686bd4c17e3575c71327c4ccf1e8e077b

Note: I fixed the underlying problem with a git fetch --unshallow upstream

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
