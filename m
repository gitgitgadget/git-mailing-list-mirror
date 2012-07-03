From: Brian Foster <brian.foster@maxim-ic.com>
Subject: [Q] Branch aliases (synonyms)?
Date: Tue, 3 Jul 2012 12:39:24 +0200
Message-ID: <1919214.YKUdgul2iY@laclwks004>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 12:55:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm0lk-0007JV-LB
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 12:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336Ab2GCKzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jul 2012 06:55:39 -0400
Received: from antispam02.maxim-ic.com ([205.153.101.183]:39174 "EHLO
	antispam02.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754571Ab2GCKzj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2012 06:55:39 -0400
X-Greylist: delayed 970 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2012 06:55:39 EDT
X-ASG-Debug-ID: 1341312330-0520cc55e61d3bf0001-QuoKaX
Received: from maxdalex02.maxim-ic.internal (maxdalex02.maxim-ic.internal [10.16.15.104]) by antispam02.maxim-ic.com with ESMTP id J8s8rDAhxl4DvID5 for <git@vger.kernel.org>; Tue, 03 Jul 2012 05:45:30 -0500 (CDT)
X-Barracuda-Envelope-From: brian.foster@maxim-ic.com
Received: from maxsvlex02.maxim-ic.internal (10.32.112.18) by
 maxdalex02.maxim-ic.internal (10.16.15.104) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Tue, 3 Jul 2012 05:39:27 -0500
Received: from laclwks004.localnet (10.201.0.45) by
 maxsvlex02.maxim-ic.internal (10.32.112.18) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Tue, 3 Jul 2012 03:39:26 -0700
X-ASG-Orig-Subj: [Q] Branch aliases (synonyms)?
User-Agent: KMail/4.7.3 (Linux/3.0.0-22-generic; KDE/4.7.4; x86_64; ; )
X-Barracuda-Connect: maxdalex02.maxim-ic.internal[10.16.15.104]
X-Barracuda-Start-Time: 1341312330
X-Barracuda-URL: http://192.168.10.183:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at maxim-ic.com
X-Barracuda-Spam-Score: 0.12
X-Barracuda-Spam-Status: No, SCORE=0.12 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=CN_BODY_332
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.101625
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.12 CN_BODY_332            BODY: CN_BODY_332
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200909>


 Having fought and lost a battle not to do this,
 we are currently planning on transitioning from
 the old version (called =E2=80=98A=E2=80=99 below) to the new
 (called =E2=80=98B=E2=80=99) by creating a TEMPORARY branch for
 the new work, and at the end of the transition,
 merging it into the old, which is then the only
 branch.  That is, at the end we have something
 like the following:

            /--a---a----------\
  ...--o---o                   n---n---A (HEAD)
            \--b---b---b---b--/

 with a starting-point of:

  ...--o---A (HEAD)

 and with during-transition intermediate points
 similar to:

            /--a---A
  ...--*---*
            \--b---b---B (HEAD)

 None of which isn't a problem per se.

 The catch is a desire(? requirement?) that, when the
 transition ends, people used to using B can continue
 to use B, people used to using A can continue to use A,
 and there is no difference.  That is, after the end of
 transition, branch names A and B are the same thing.
 Always.  Automatically.

 Using a symref seems a working answer.  That is,
 after the merge, change B from a true branch head
 into a symref pointing to A:

      git merge ...
      git symbolic-ref refs/heads/B refs/heads/A

  =E2=96=B6 What are the gotchas?
  =E2=96=B6 Are there other solutions?

 I have written a test script to explore the idea,
 and it seems to be working.  The script is a bit
 on the long side (c.500 lines) since it is trying
 to exercise a number of different cases, so I
 won't post it unless asked.

cheers!
	-blf-

--=20
Brian Foster
Principal MTS, Software        |  La Ciotat, France
Maxim Integrated Products      |  Web:  http://www.maxim-ic.com/
