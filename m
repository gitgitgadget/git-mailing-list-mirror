From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4 0/4] More helpful 'git status' during 'rebase -i'
Date: Tue, 30 Jun 2015 15:01:11 +0200
Message-ID: <1435669275-32102-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 15:01:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9vAK-0005Vo-QO
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 15:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbbF3NB3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2015 09:01:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56314 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbbF3NB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 09:01:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UD1GRl004164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 15:01:16 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UD1Itp024070;
	Tue, 30 Jun 2015 15:01:18 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9vA5-0000BT-TA; Tue, 30 Jun 2015 15:01:17 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Jun 2015 15:01:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UD1GRl004164
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436274077.7827@ZtF2Sl+bYLGrKI/MaZu3PA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273057>

This series makes "git status" provide an output like

  interactive rebase in progress; onto $ONTO
  Last commands done (2 commands done):
     pick $COMMIT2 two_commit
     exec exit 15
  Next commands to do (2 remaining commands):
     pick $COMMIT3 three_commit
     pick $COMMIT4 four_commit
    (use "git rebase --edit-todo" to view and edit)

in addition to the existing output, when ran during an interactive
rebase.

Previous version here:

  http://thread.gmane.org/gmane.comp.version-control.git/271184

I just fixed the missing newline I noticed, and squashed Junio's
indentation fix. These were the only two remarks on the last
iteration.

Guillaume Pag=C3=A8s (4):
  status: factor two rebase-related messages together
  status: differentiate interactive from non-interactive rebases
  status: give more information during rebase -i
  status: add new tests for status during rebase -i

 t/t7512-status-help.sh | 226 +++++++++++++++++++++++++++++++++++++++++=
+++++---
 wt-status.c            | 100 ++++++++++++++++++----
 2 files changed, 295 insertions(+), 31 deletions(-)

--=20
2.5.0.rc0.10.g7792c2a
