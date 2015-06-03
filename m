From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv2 1/2] git-rebase -i: add command "drop" to remove a
 commit
Date: Wed, 3 Jun 2015 11:13:57 +0200 (CEST)
Message-ID: <787870724.57987.1433322837954.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433152643-4292-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433152643-4292-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <xmqqvbf7757q.fsf@gitster.dls.corp.google.com> <563732680.250935.1433180720935.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqoakz1dke.fsf@anie.imag.fr> <150689518.4344.1433229813195.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqa8wiwo33.fsf@anie.imag.fr> <xmqqk2vm3udy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 11:14:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z04kK-0000Kc-MP
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 11:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbbFCJN4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 05:13:56 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:42091 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753016AbbFCJNy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 05:13:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5808D4863D;
	Wed,  3 Jun 2015 11:13:51 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kJJ6QtiNq-aC; Wed,  3 Jun 2015 11:13:51 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3A426362D;
	Wed,  3 Jun 2015 11:13:51 +0200 (CEST)
In-Reply-To: <xmqqk2vm3udy.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-rebase -i: add command "drop" to remove a commit
Thread-Index: q6sGJxyGDMLUl+Or+yqIyRsXrgOokw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270672>

Junio C Hamano <gitster@pobox.com> writes:=20
> As long as what is given to 'drop'=20
> is checked when it matters (e.g. when the code in patch 2/2 tries=20
> see if some commits in the original list are no longer there in=20
> order to warn sees "drop foo bar" where "foo" is obviously not an=20
> object name in the original list, that should be checked), it is=20
> fine. And I agree 1/2 is not the place to do so, even though it may=20
> be easier from the implementation point of view (which is why I=20
> mentioned the possibility in the review of that patch).=20

I disagree, I think that that either the checking for the 'drop'=20
command should either be in the 1/2 where it is introduced or in the=20
function check_commits introduced by 2/2 but in a separate=20
commit/patch.=20
The 2/2 checks if there are removed commits to have the possibility to=20
avoid silent loss of information. It is not its role to check if the=20
SHA-1 following 'drop' are correct.=20

What I think should be the best for now is checking the SHA-1=20
following 'drop' in 1/2 (or not checking at all) and change the whole=20
checking system of rebase in a later patch (e.g. check beforehand=20
(probably in check_commits) if the commands exist, if the SHA-1 are=20
correct and possibly other things).=20

R=C3=A9mi=20
