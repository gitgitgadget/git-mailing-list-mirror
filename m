From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Sun, 14 Jun 2015 21:40:20 +0200 (CEST)
Message-ID: <323480549.485629.1434310820944.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <vpqy4jq2rjr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 14 21:39:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Dka-0004Aj-BY
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 21:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbbFNTjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 15:39:14 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:39784 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752109AbbFNTjN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2015 15:39:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 6D0E027E9;
	Sun, 14 Jun 2015 21:39:11 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GQkXLbj+70Hw; Sun, 14 Jun 2015 21:39:11 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 56DC227E0;
	Sun, 14 Jun 2015 21:39:11 +0200 (CEST)
In-Reply-To: <vpqy4jq2rjr.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF10 (Linux)/8.0.9_GA_6191)
Thread-Topic: bisect: allows any terms set by user
Thread-Index: XPuhuLRGQxyUMWU0O0Yjn/9SYi1S0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271648>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> +        if test -s "$GIT_DIR/TERMS_DEFINED"
>> +        then
>> +                terms_defined=1
>> +                get_terms
>> +                rm -rf "$GIT_DIR/TERMS_DEFINED"
>
>I don't understand why you need to delete this file. I did not review
>thoroughly so there may be a reason, but you can help the reader with a
>comment here.

I will just complete Louis' answer. We delete it with backward
compatibility with old/new in mind (even if old/new is not merged yet).
For instance, after a old/new mode, if you do a 'bisect start rev1 rev2'
the mode would be bad/good ie the default mode. So if you defined your
terms, we decided it would only be for the following bisection. The next 
'bisect start rev1 rev2' would be in bad/good mode.
But this have to be discuted, do the user have to type 'git bisect terms'
each bisection if he wants to use special terms ?
