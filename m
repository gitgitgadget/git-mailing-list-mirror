From: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Sun, 14 Jun 2015 14:39:06 +0200 (CEST)
Message-ID: <1155395826.552092.1434285546884.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <vpqy4jq2rjr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 14 14:37:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z47AQ-0005Hr-DM
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 14:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbbFNMhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 08:37:33 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:38993 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751185AbbFNMhb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2015 08:37:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 19AA3270B;
	Sun, 14 Jun 2015 14:37:30 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jl1pSUCHB3WF; Sun, 14 Jun 2015 14:37:30 +0200 (CEST)
Received: from zm-int-mbx2.grenet.fr (zm-int-mbx2.grenet.fr [130.190.242.141])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 05C782701;
	Sun, 14 Jun 2015 14:37:30 +0200 (CEST)
In-Reply-To: <vpqy4jq2rjr.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: bisect: allows any terms set by user
Thread-Index: oB8gF3dMW9agWav+gt43BKvKsz9Slg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271637>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Modifying in PATCH 7 some code that you introduced in PATCH 3 is
> suspicious. Is there any reason you did not name the variable
> "terms_defined" in the first place? (i.e. squash this hunk and the other
> instance of start_bad_good into PATCH 3)
>
> (Whether this is a rethorical question is up to you ;-) )

In the previouses versions where we only want to introduce old/new,
the terms can only be defined in bisect_start if the user typed
start <bad> <good>. The name "start_bad_good" is not very explicit
indeed, but isn't it more appropriate in this case than terms_defined ?

> I don't understand why you need to delete this file. I did not review
> thoroughly so there may be a reason, but you can help the reader with a
> comment here.

I think it's a mistake. I'd say we should put this test just before the
"bisect_clean_state || exit" line, but that would deserve more attention
indeed. The idea is to delete the file at the right moment because we 
don't want it to exist again when the user starts an other bisection,
but also have an intelligent behaviour if the start command fails.
