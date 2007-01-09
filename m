From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: Bug in git-status with non-ascii characters:
Date: Tue, 9 Jan 2007 06:39:50 +0100
Message-ID: <17827.10918.897000.825178@lapjr.intranet.kiel.bmiag.de>
References: <7BACA5DE-9DBA-4299-A965-E248263E27E2@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 06:40:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H49if-0002H1-U9
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 06:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbXAIFkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 9 Jan 2007 00:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbXAIFkS
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 00:40:18 -0500
Received: from bilbo.bmiag.de ([62.154.210.131]:1967 "HELO bilbo.bmiag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751056AbXAIFkR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jan 2007 00:40:17 -0500
Received: (qmail 13007 invoked by uid 106); 9 Jan 2007 05:40:15 -0000
Received: from eorl.intranet.kiel.bmiag.de(10.131.2.1)
 via SMTP by bilbo.bmiag.de, id smtpdqZs5jG; Tue Jan  9 06:40:06 2007
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 119B53ADC8;
	Tue,  9 Jan 2007 06:40:06 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 25678-08; Tue, 9 Jan 2007 06:40:00 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id B19263ADC6;
	Tue,  9 Jan 2007 06:39:57 +0100 (CET)
To: Brian Gernhardt <benji@silverinsanity.com>
In-Reply-To: <7BACA5DE-9DBA-4299-A965-E248263E27E2@silverinsanity.com>
X-Mailer: VM 7.19 under Emacs 22.0.92.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36314>

Brian Gernhardt writes:
 > `git status` always reports the following:
 >=20
 > ----- 8< -----
 > # On branch refs/heads/master
 > # Untracked files:
 > #   (use "git add <file>..." to incrementally add content to commit)
 > #
 > #       gitweb/test/M=E4rchen
 > no changes added to commit (use "git add" and/or "git commit [-a|-i|=
-=20
 > o]")
 > ----- 8< -----
 >=20
 > When I do `rm gitweb/test/M<tab>` to remove this apparently unneeded=
 =20
 > file, `git status` reports:
 >=20
 > ----- 8< -----
 > # On branch refs/heads/master
 > # Changed but not added:
 > #   (use "git add <file>..." to incrementally add content to commit)
 > #
 > #       deleted:    gitweb/test/M=E4rchen
 > #
 > no changes added to commit (use "git add" and/or "git commit [-a|-i|=
-=20
 > o]")
 > ----- 8< -----
 >=20
 > This is on Mac OS X, file system is HFS+ (Journaled).  Is this =20
 > expected?  I can't figure out why it's happening.

It's a known problem with HFS+: it uses different byte sequences to
identify the same file. Therefore git finds gitweb/test/M=E4rchen
unchanged but also a gitweb/test/M=E4rchen in the working directory
using a different byte sequence for the name as reported in status. If
you delete the file git doesn't find the file any longer and reports
that in status as well.
