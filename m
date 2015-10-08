From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Thu, 08 Oct 2015 19:10:04 +0200
Message-ID: <vpq8u7dp9qr.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3l5zgst.fsf@grenoble-inp.fr>
	<CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 19:10:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkEhv-0003Me-KM
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 19:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbbJHRKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 13:10:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42441 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964921AbbJHRKL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 13:10:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t98HA2Qq012048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 8 Oct 2015 19:10:03 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t98HA4f8008364;
	Thu, 8 Oct 2015 19:10:04 +0200
In-Reply-To: <CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 8 Oct 2015 21:39:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Oct 2015 19:10:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t98HA2Qq012048
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444929005.12895@UinAeRgD1SXpzzFvFqO4BA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279249>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Thu, Oct 8, 2015 at 5:57 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> +                             unsigned int nobracket = 0;
>>> +
>>> +                             if (!strcmp(valp, ",nobracket"))
>>> +                                     nobracket = 1;
>>
>> The code to parse comma-separated values is different here and
>> elsewhere. I'd rather have the same code (possibly factored into a
>> helper function), both to get consistent behavior (you're not allowing
>> %(upstream:nobracket,track) for example, right?) and consistent code.
>>
>
> Speaking of comma-separated values, the only other place we use that is
> in the align atom. Also I find this very specific to get a function out of.
> Somehow I think this is the simplest way to go about this.

Well, most pieces of code start with one instance, then two, then
more ;-). When the second instance starts being different from the
first, it doesn't give a good example for the future third instance.

This particular piece of code is so important and I won't fight for a
better factored one, but in general "there are only two instances" is a
dubious argument to avoid refactoring.

Still, I find it weird to force the nobracket to be always at the same
position.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
