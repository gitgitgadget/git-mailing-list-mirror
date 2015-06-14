From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Sun, 14 Jun 2015 21:30:00 +0200 (CEST)
Message-ID: <835646176.485512.1434310200681.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr> <vpqy4jq2rjr.fsf@anie.imag.fr> <1155395826.552092.1434285546884.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 14 21:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Dac-0007ql-G7
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 21:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbbFNT2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 15:28:55 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:50084 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752024AbbFNT2x (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jun 2015 15:28:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4C27336CD;
	Sun, 14 Jun 2015 21:28:51 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mQTxfbE6sgc; Sun, 14 Jun 2015 21:28:51 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3129336B3;
	Sun, 14 Jun 2015 21:28:51 +0200 (CEST)
In-Reply-To: <1155395826.552092.1434285546884.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF10 (Linux)/8.0.9_GA_6191)
Thread-Topic: bisect: allows any terms set by user
Thread-Index: oB8gF3dMW9agWav+gt43BKvKsz9Slqvltvsh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271647>

Louis Stuber <louis--alexandre.stuber@ensimag.grenoble-inp.fr> writes: 

>Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes: 
> 
>> Modifying in PATCH 7 some code that you introduced in PATCH 3 is 
>> suspicious. Is there any reason you did not name the variable 
>> "terms_defined" in the first place? (i.e. squash this hunk and the other 
>> instance of start_bad_good into PATCH 3) 
>> 
>> (Whether this is a rethorical question is up to you ;-) ) 
> 
>In the previouses versions where we only want to introduce old/new, 
>the terms can only be defined in bisect_start if the user typed 
>start <bad> <good>. The name "start_bad_good" is not very explicit 
>indeed, but isn't it more appropriate in this case than terms_defined ? 

I agree with Louis, but maybe a consistant commit history is more 
important. But if only the first patches (which implement old/new ) 
would come to be accepted the name of the variable would sounds strange. 

>> I don't understand why you need to delete this file. I did not review 
>> thoroughly so there may be a reason, but you can help the reader with a 
>> comment here. 
> 
>I think it's a mistake. I'd say we should put this test just before the 
>"bisect_clean_state || exit" line, but that would deserve more attention 
>indeed. The idea is to delete the file at the right moment because we 
>don't want it to exist again when the user starts an other bisection, 
>but also have an intelligent behaviour if the start command fails. 

Yes if the start commands fails, like if you gave wrong sha1, it would be 
nice not to have to type again 'git bisect terms ...' . There is no use to 
put it before clean_state because clean_state because clean_state will 
actually delete the file. So we can just let clean_state do this. 
