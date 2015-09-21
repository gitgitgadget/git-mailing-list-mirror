From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 0/8] port the filtering part of branch.c to use ref-filter APIs
Date: Mon, 21 Sep 2015 08:23:18 +0200
Message-ID: <vpqfv28e1ex.fsf@anie.imag.fr>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
	<vpqwpvkgblz.fsf@anie.imag.fr>
	<CAOLa=ZSyMV04wjhdM11RK9z8fz5tHM4PzPBxrN8_VA_Cacw82g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 08:23:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZduVk-00042s-SR
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 08:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbbIUGX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 02:23:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48447 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbbIUGXY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 02:23:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8L6NHud031024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 21 Sep 2015 08:23:17 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8L6NIEA014385;
	Mon, 21 Sep 2015 08:23:18 +0200
In-Reply-To: <CAOLa=ZSyMV04wjhdM11RK9z8fz5tHM4PzPBxrN8_VA_Cacw82g@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 21 Sep 2015 11:41:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 21 Sep 2015 08:23:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8L6NHud031024
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443421398.74363@5q7Z3fxMiF4h7gF4O6fC6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278279>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Mon, Sep 21, 2015 at 12:30 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> --- a/t/t3203-branch-output.sh
>>> +++ b/t/t3203-branch-output.sh
>>> @@ -145,8 +145,8 @@ EOF
>>>
>>>  test_expect_success 'git branch `--sort` option' '
>>>       cat >expect <<-\EOF &&
>>> -     * (HEAD detached from fromtag)
>>>         branch-two
>>> +     * (HEAD detached from fromtag)
>>>         branch-one
>>>         master
>>>       EOF
>>
>> I thought this was obviously wrong, but this tests uses
>> --sort=objectsize, so it's OK. Indeed, HEAD and branch-one have
>> objectsize=215, and branch-two has objectsize=167.
>>
>> So, the previous code was hardcoding "detached HEAD always comes first",
>> but we now sort the whole list, including detached HEAD, so branch-two
>> comes first.
>>
>
> Yeah! Even Junio said this was better, and even I think this is what
> the user would expect.

Yes, that was not an objection, just me thinking aloud during my review.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
