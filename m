From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [BUG] gitk update/reload doesn't refresh notes
Date: Mon, 4 Jul 2011 17:36:00 +0200
Message-ID: <20110704153600.GF1982@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 04 17:41:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdlHU-0007rV-BF
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 17:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757753Ab1GDPlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jul 2011 11:41:35 -0400
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:16466 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947Ab1GDPlc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2011 11:41:32 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jul 2011 11:41:32 EDT
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 4 Jul
 2011 17:35:55 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 4 Jul
 2011 17:36:00 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176601>

Hi,


I would expect that when I start gitk with '--show-notes' option and
press update or reload, then it updates not just the commits, but the
notes shown in the log/diff window, too.  However, as shown below,
this is not the case.

  notes_vs_gitk$ git init
  Initialized empty Git repository in
  /home/szeder/tmp/git/notes_vs_gitk/.git/
  notes_vs_gitk (master)$ echo 1 >foo
  notes_vs_gitk (master)$ git add foo
  notes_vs_gitk (master)$ git commit -m First. foo
  [master (root-commit) 88dbd6b] First.
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 foo
  notes_vs_gitk (master)$ gitk --show-notes master &
  [1] 15673
  notes_vs_gitk (master)$ git notes add -m "Note,
  that these notes will not appear in gitk without restarting it"
  notes_vs_gitk (master)$ git log
  commit 88dbd6bf8f1e3e4fc94d1da5e73754c7d2f0f244
  Author: SZEDER G=E1bor <szeder@ira.uka.de>
  Date:   2011-07-04 17:18:28 +0200
 =20
      First.
 =20
  Notes:
      Note, that these notes will not appear in gitk without restarting=
 it
 =20
  # Press F5 in gitk for update.
  # Nope, notes are not shown.
  # Press ctrl-F5 in gitk for reload.
  # Notes are still not shown.
 =20
  notes_vs_gitk (master)$ kill %1
  [1]+  Terminated              gitk --show-notes master
  notes_vs_gitk (master)$ gitk --show-notes master &
  [1] 15826
 =20
  # Notes are shown, finally.

  notes_vs_gitk (master)$ git notes remove=20
  Removing note for object HEAD

  # Press F5/ctrl-F5 in gitk.
  # The removed notes are still there.


Best,
G=E1bor
