From: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Tue, 9 Jun 2015 22:17:32 +0200 (CEST)
Message-ID: <550645264.367778.1433881052933.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <vpqbngpl5zu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, jch2355@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 22:16:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Pwu-0000BT-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 22:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbbFIUQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 16:16:36 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:40378 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752587AbbFIUQf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 16:16:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B2F2A48867;
	Tue,  9 Jun 2015 22:16:32 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 061wtRwL1+lH; Tue,  9 Jun 2015 22:16:32 +0200 (CEST)
Received: from zm-int-mbx2.grenet.fr (zm-int-mbx2.grenet.fr [130.190.242.141])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 94E2948800;
	Tue,  9 Jun 2015 22:16:32 +0200 (CEST)
In-Reply-To: <vpqbngpl5zu.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: bisect: simplify the add of new bisect terms
Thread-Index: 2J8SbW9+MloTc2a+AzjrdYOT6cK0iA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271237>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> I think you would want to error out if errno is not ENOENT.


Junio C Hamano <jch2355@gmail.com> wrote:

> We might want to see why fopen() failed here. If it is because the
> file did not exist, great. But otherwise?


This file is always supposed to exist when the function is called
unless the user has manually deleted it (or a bug in our programs).

Maybe we should just return an error if the file cannot be opened,
regardless the reason. We kept it like it is, with the default case,
because it was what our elders did, and that aborting because of
BISECT_TERMS is not good for backward compatibility.

But then, in both cases, there is no reason to differenciate ENOENT.
Is that right ?
