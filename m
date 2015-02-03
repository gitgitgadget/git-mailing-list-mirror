From: Kevin Coleman <kevin.coleman@sparkstart.io>
Subject: folder naming bug?
Date: Mon, 2 Feb 2015 20:56:39 -0500
Message-ID: <27503C0E-7D33-4893-AD25-6A821D31FAB1@sparkstart.io>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 03:03:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YISpq-0007NU-EB
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 03:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965678AbbBCCDW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Feb 2015 21:03:22 -0500
Received: from relay.ox.registrar-servers.com ([199.188.203.174]:33125 "EHLO
	relay.ox.registrar-servers.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755213AbbBCCDV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 21:03:21 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Feb 2015 21:03:21 EST
Received: (qmail 21905 invoked by uid 89); 3 Feb 2015 01:56:40 -0000
Received: from unknown (HELO imap2-3.ox.privateemail.com) (192.64.116.208)
  by relay.ox.registrar-servers.com with (DHE-RSA-AES256-SHA encrypted) SMTP; 3 Feb 2015 01:56:40 -0000
Received: from localhost (localhost [127.0.0.1])
	by mail.privateemail.com (Postfix) with ESMTP id 87DD28C0081
	for <git@vger.kernel.org>; Mon,  2 Feb 2015 20:56:39 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at imap2.ox.privateemail.com
Received: from mail.privateemail.com ([127.0.0.1])
	by localhost (imap2.ox.privateemail.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EpU_-40UfwiE for <git@vger.kernel.org>;
	Mon,  2 Feb 2015 20:56:39 -0500 (EST)
Received: from [192.168.49.81] (unknown [72.16.218.22])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 59D828C0069
	for <git@vger.kernel.org>; Mon,  2 Feb 2015 20:56:39 -0500 (EST)
X-Mailer: Apple Mail (2.1993)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263301>

git isn=E2=80=99t tracking folder renames when the case of the letters =
change, but it will track it if the folder changes names.  Is this inte=
ntional?

Here is an example:

08:51:26 ~/test $ git init
Initialized empty Git repository in /Users/kcoleman/test/.git/
08:51:29 ~/test (master #) $ mkdir main
08:51:44 ~/test (master #) $ cd main
08:51:46 ~/test/main (master #) $ touch readme.md
08:51:50 ~/test/main (master #) $ ls
readme.md
08:51:53 ~/test/main (master #) $ cd ..
08:51:54 ~/test (master #) $ git add .
08:51:59 ~/test (master #) $ git commit -m "one"
[master (root-commit) b0fddf6] one
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 main/readme.md
08:52:04 ~/test (master) $ cd main
08:52:14 ~/test/main (master) $ cd ..
08:52:27 ~/test (master) $ mv main Main
08:53:51 ~/test (master) $ git status
On branch master
nothing to commit, working directory clean
08:53:53 ~/test (master) $ ls
Main
08:54:02 ~/test (master) $ mv Main MainA
08:55:44 ~/test (master *) $ git status
On branch master
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working direct=
ory)

	deleted:    main/readme.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	MainA/

no changes added to commit (use "git add" and/or "git commit -a")
08:55:45 ~/test (master *) $