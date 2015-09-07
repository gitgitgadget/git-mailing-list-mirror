From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v16 00/14] port tag.c to use ref-filter APIs
Date: Mon, 07 Sep 2015 16:05:53 +0200
Message-ID: <vpqfv2qqq7y.fsf@scolette.imag.fr>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
	<xmqqh9n6agcf.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQFZRKY_hHEVQQ6CuYC9XNWHJFYg1CFZCGUr-68phDMHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 16:06:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYx3h-00052o-In
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 16:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbbIGOGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 10:06:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49161 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbbIGOGA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 10:06:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t87E5pKx031217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 7 Sep 2015 16:05:52 +0200
Received: from scolette (scolette.imag.fr [129.88.43.86])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t87E5rLo018646;
	Mon, 7 Sep 2015 16:05:53 +0200
In-Reply-To: <CAOLa=ZQFZRKY_hHEVQQ6CuYC9XNWHJFYg1CFZCGUr-68phDMHQ@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 7 Sep 2015 19:26:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Sep 2015 16:05:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t87E5pKx031217
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442239554.30511@wkNXAQAVIfdPhOc8r57eAg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277464>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Mon, Sep 7, 2015 at 12:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> diff --git a/builtin/tag.c b/builtin/tag.c
>>> index 9fa1400..f55dfda 100644
>>> --- a/builtin/tag.c
>>> +++ b/builtin/tag.c
>>> @@ -43,8 +43,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
>>>
>>>       if (!format) {
>>>               if (filter->lines)
>>> -                     format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
>>> -                                                filter->lines);
>>> +                     format = to_free = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) "
>>> +                                                "%%(contents:lines=%d)", filter->lines);
>>
>> This line still looks overlong.  Would it help to stop spelling this
>> as a double "a = b = overlong expression" assignment?
>>
>
> I'm not sure, I get what you mean.

I guess

format = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
                 filter->lines);
to_free = format;

(still 83 columns + indentation, but that's a bit shorter than your
version).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
