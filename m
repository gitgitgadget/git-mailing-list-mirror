From: =?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: rebase -i: drop, missing commits and static checks
Date: Mon, 29 Jun 2015 22:20:29 +0200
Message-ID: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:20:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fXm-0007m2-NJ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbbF2UUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jun 2015 16:20:38 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:35702 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753179AbbF2UUh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2015 16:20:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id F1B9D3872;
	Mon, 29 Jun 2015 22:20:34 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x6jof8nR70dk; Mon, 29 Jun 2015 22:20:34 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id DFC432858;
	Mon, 29 Jun 2015 22:20:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id DA2B320E4;
	Mon, 29 Jun 2015 22:20:34 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tKtFQ7C7NvTl; Mon, 29 Jun 2015 22:20:34 +0200 (CEST)
Received: from galanalr-Dell-System-Inspiron-N7110.univnautes.lan (eduspot-condillac.crous-grenoble.fr [193.52.241.183])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id BCF1420D2;
	Mon, 29 Jun 2015 22:20:34 +0200 (CEST)
X-Mailer: git-send-email 2.4.3.532.gab13793
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273009>

Changes between versions:

In t3404:

Changed 'test_rebase_end' to 'rebase_setup_and_clean'.
Changed the indentation in 'rebase_setup_and_clean'.
Changed the names of the branches created in my tests (avoid names
like 'tmp').
Added 'test_might_fail' in front of 'git branch -D'.
Remove 'test_config rebase.missingCommitsCheck error' in the last test
('static check of bad SHA-1') because it was useless.

In git-rebase--interactive.sh:

Errors found in commands and SHA-1 (static check) are displayed on the
spot.
I used return values to signal to the calling functions if there is an
error.
The whole while block in 'check_bad_cmd_and_sha' with the return is in =
a=20
'(
	[...]
)'
block because 'retval' would not have been correctly affected when
getting out of the loop since the while is in a pipe.

A thought occured to me:
Shouldn't all the checking also be called in a 'rebase --continue',
considering that it can be called after a 'rebase --edit-todo' ?
(Right now it is only called after closing the editor in 'rebase -i')

[PATCHv7 1/3] git-rebase -i: add command "drop" to remove a commit
[PATCHv7 2/3] git rebase -i: warn about removed commits
[PATCHv7 3/3] git rebase -i: add static check for commands and SHA-1

R=C3=A9mi
(It seems that with 'send-email', 1 time out of 2 I get:
'5.7.8 Error: authentication failed: authentication failure')
