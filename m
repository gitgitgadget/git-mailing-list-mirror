From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 8/8] add tests for `git_config_get_string_const()`
Date: Thu, 07 Aug 2014 10:30:49 +0200
Message-ID: <vpq38d8pupy.fsf@anie.imag.fr>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
	<1407336792-16962-9-git-send-email-tanayabh@gmail.com>
	<vpqmwbhvdkx.fsf@anie.imag.fr>
	<xmqq4mxpmhyb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 10:31:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFJ6Y-0003ym-EP
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 10:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbaHGIbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 04:31:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57791 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754191AbaHGIbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 04:31:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s778UpgE029498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Aug 2014 10:30:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s778Unoj031416;
	Thu, 7 Aug 2014 10:30:49 +0200
In-Reply-To: <xmqq4mxpmhyb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 06 Aug 2014 14:22:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Aug 2014 10:30:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s778UpgE029498
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408005054.34771@BW5JK9jiWGbCemu5yblW0g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254947>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Tanay Abhra <tanayabh@gmail.com> writes:
>>
>>> ...
>>> +	grep "line 7.*.git/config\|.git/config.*line 7" result
>>> +'
>>
>> This is still dependant on the locale ("line" is translated). You need
>> to use test_i18ngrep instead of grep here (see its definition and
>> comment in t/test-lib.sh).
>>
>> I don't think you need these two alternatives OTOH.
>>
>> BTW, Junio, I don't understand your remark "This test is too tight (the
>> full string)" in the previous iteration. Can you elaborate?
>
> The original test was trying to match the string fully, i.e.
>
>> +	grep "fatal: bad config variable '\''alias.br'\'' at file line 2 in .git/config" result
>
> As I already was feeling funny about seeing the phrase "file line"
> in the message and expecting it to be corrected, I thought I should
> encourage a check that does not depend on minor phrasing changes, if
> it can be done without bending backwards.

OK.

I personally prefer tight tests in this case, as the patch doing the
rephrase "sees" what changed by running the tests, and documents the
visible change by changing the expected in the tests scripts. But no
strong opinion here, I'd be fine with e.g.

test_i18ngrep "fatal: .* alias.br.*line 2 in .git/config" result

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
