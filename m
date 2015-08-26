From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Wed, 26 Aug 2015 17:48:55 +0200
Message-ID: <vpq8u8ym4ns.fsf@anie.imag.fr>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<xmqqy4h04mx4.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZRYWNVmMeMCZSa+GcOTQ7NzuVB9RH_TFJ6-u7aFhrU=NA@mail.gmail.com>
	<xmqq8u904ix0.fsf@gitster.dls.corp.google.com>
	<xmqq37z82u2a.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZS=Mtz0ny0tUWRBY0vfAgiRzaszeF0m_pxnK3+VGn1eVg@mail.gmail.com>
	<vpqd1yap8ml.fsf@anie.imag.fr>
	<xmqqy4gyukag.fsf@gitster.dls.corp.google.com>
	<xmqqtwrmuk7b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 17:49:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUcwl-0003Y3-U6
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 17:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbbHZPtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 11:49:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42630 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbbHZPtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 11:49:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7QFmrqb032138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 26 Aug 2015 17:48:53 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7QFmtFt004096;
	Wed, 26 Aug 2015 17:48:55 +0200
In-Reply-To: <xmqqtwrmuk7b.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 26 Aug 2015 08:46:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 26 Aug 2015 17:48:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7QFmrqb032138
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441208935.11847@ch68uGV4FrgCRlNW6aRsFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276611>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>>> For the current code %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
>>>> would print non-empty, I guess the documentation holds in that case.
>>>> Not sure if we require it to print non-empty.
>>>
>>> You don't want the %(if) condition to depend on whether
>>> --shell/--python/... is used. Since %(if:empty)%(align)%(end)%(then)
>>> holds when you don't use --shell, you also want it to hold when you
>>> quote. IOW, you should check for emptyness before (or actually without)
>>> doing the quoting. I guess this is what you're doing, and if so, I think
>>> it's "The Right Thing".
>>
>> I agree that %(align)%(end) should expand to empty and %(if:empty)...%(then)
>> should look at that empty string without quoting.  So 
>>
>>     %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
>>
>> should give "Empty"; otherwise the code is buggy, I think.
>
> (I shouldn't be typing while eating...)
>
> It should give "Empty", but the --shell/--python/... may make the
> whole "Empty", as the result of %(if:...)...%(end), be quoted.  So
> you may see "'Empty'" in the output.

Agreed (with both points).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
