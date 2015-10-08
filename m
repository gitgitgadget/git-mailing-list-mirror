From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Thu, 08 Oct 2015 20:26:17 +0200
Message-ID: <vpqoag9nrna.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3l5zgst.fsf@grenoble-inp.fr>
	<CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
	<vpq8u7dp9qr.fsf@grenoble-inp.fr>
	<CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 20:26:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkFte-0004EL-PD
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 20:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbbJHS01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 14:26:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43689 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbbJHS00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 14:26:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t98IQGHS006233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 8 Oct 2015 20:26:16 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t98IQHph009304;
	Thu, 8 Oct 2015 20:26:17 +0200
In-Reply-To: <CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 8 Oct 2015 22:58:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Oct 2015 20:26:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t98IQGHS006233
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444933580.47489@z2rCcd7M/l2v0QKfwE8ZNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279253>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Thu, Oct 8, 2015 at 10:40 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> This particular piece of code is so important and I won't fight for a
>> better factored one, but in general "there are only two instances" is a
>> dubious argument to avoid refactoring.
>>
>> Still, I find it weird to force the nobracket to be always at the same
>> position.
>>
>
> No i mean I could follow up with the way we use it in align, but I don't see
> how I can make a function out of this.

Ah, OK. Well, there are already two instances of

	/*  Strip trailing comma */
	if (s[1])
		strbuf_setlen(s[0], s[0]->len - 1);


(for objectname and align), one of which says

	/*
	 * TODO: Implement a function similar to strbuf_split_str()
	 * which would omit the separator from the end of each value.
	 */

I guess it's time to replace this TODO with actual code. A
straightforward implementation would be to call strbuf_split_str and
then use the same "if (s[1])" as you already have. There's probably a
more efficient way.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
