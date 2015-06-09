From: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 1/4] status: factor two rebase-related messages together
Date: Tue, 9 Jun 2015 09:33:35 +0200 (CEST)
Message-ID: <968122035.288953.1433835215140.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr> <xmqqbngp97yp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 09:33:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2E28-0007Sa-VA
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 09:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbbFIHdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 03:33:08 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:42797 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932181AbbFIHc7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 03:32:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D24C23609;
	Tue,  9 Jun 2015 09:32:56 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZTYpoD5i1VLT; Tue,  9 Jun 2015 09:32:56 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D704A488A3;
	Tue,  9 Jun 2015 09:32:55 +0200 (CEST)
In-Reply-To: <xmqqbngp97yp.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF37 (Linux)/8.0.9_GA_6191)
Thread-Topic: status: factor two rebase-related messages together
Thread-Index: sUzq/497S8gWBWVkZ0l07ahb8v9i3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271149>

"Junio C Hamano" <gitster@pobox.com> writes:

>Hmmm, it obviously does not break anything but it is not obvious why 
>this is a good change. 

>Is it that you wanted to have a single instance of "if on a branch, 
>we say 'you are rebasing that branch', otherwise we say 'you are 
>rebasing'"? Even then, I am not sure if this code movement was the 
>best way to do so (an obvious alternative is to use a shared helper 
>function and call from the two arms of if/elseif/... chain). 

I made this change because at first sight, this piece of code was 
difficult to read for me. There was two long branches very similar
and I had to spot the differences, and the actual differences were
at the very end of the branches so I had to check back what the
condition was about. It seems now much more natural to me: the part
in common of both branches is in OR-condition and the differences 
between branches are gathered with the test on the variable they
depend.

By the way, I agree that this change is not absolutely necessary.
