From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/9] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Sun, 04 Oct 2015 10:02:56 +0200
Message-ID: <vpqr3lb6oy7.fsf@grenoble-inp.fr>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-2-git-send-email-Karthik.188@gmail.com>
	<vpq8u7kb89o.fsf@grenoble-inp.fr>
	<xmqqpp0v3mzo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 10:03:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZieGL-0000qR-26
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 10:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbbJDIDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 04:03:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38816 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbbJDIDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 04:03:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9482tIK005023
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 4 Oct 2015 10:02:55 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9482ugN011190;
	Sun, 4 Oct 2015 10:02:56 +0200
In-Reply-To: <xmqqpp0v3mzo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 03 Oct 2015 10:01:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 04 Oct 2015 10:02:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9482tIK005023
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444550577.20936@lMk8LthQncOZtT0L+FNiDg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278996>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> My take on it:
>>
>> Implement %(if), %(then) and %(else) atoms. Used as
>> %(if)...%(then)...%(end) or %(if)...%(then)...%(else)...%(end). If the
>> format string between %(if) and %(then) expands to an empty string, or
>> to only whitespaces, then the string following %(then) is printed.
>> Otherwise, the string following %(else), if any, is printed.
>
> I found all the suggestions very good, except that the distinction
> between "expands to" and "is printed" bothers me a bit, as they want
> to mean exactly the same thing (imagine this whole thing were inside
> another %(if)...%(then)).

True. Then let me try again:

Implement %(if), %(then) and %(else) atoms. Used as
%(if)...%(then)...%(end) or %(if)...%(then)...%(else)...%(end). If the
format string between %(if) and %(then) expands to an empty string, or
to only whitespaces, then the whole %(if)...%(end) expands to the string
following %(then). Otherwise, it expands to the string following
%(else), if any.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
