From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v17 05/14] ref-filter: introduce match_atom_name()
Date: Thu, 10 Sep 2015 18:59:06 +0200
Message-ID: <vpqio7inrc5.fsf@scolette.imag.fr>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<1441900110-4015-6-git-send-email-Karthik.188@gmail.com>
	<xmqq37ym5i2u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 18:59:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5Bt-0006aP-9X
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 18:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbbIJQ7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 12:59:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43816 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602AbbIJQ7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 12:59:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8AGx4ff001675
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 10 Sep 2015 18:59:04 +0200
Received: from scolette (scolette.imag.fr [129.88.43.86])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8AGx62v025274;
	Thu, 10 Sep 2015 18:59:06 +0200
In-Reply-To: <xmqq37ym5i2u.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 10 Sep 2015 09:56:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 10 Sep 2015 18:59:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8AGx4ff001675
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442509145.93011@KwITuvO2G+D5LPrnaA3WJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277605>

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> -		} else if (starts_with(name, "color:")) {
>> +		} else if (match_atom_name(name, "color", &valp)) {
>
> Why use the helper only for this one?  Aren't existing calls to
> starts_with() in the same if/else if/... cascade all potential bugs
> that the new helper function is meant to help fixing?  For example,
> the very fist one in the cascade:
>
> 	if (starts_with(name, "refname"))
>         	refname = ref->refname;
>
> is correct *ONLY* when name is "refname" or "refname:" followed by
> something, and it should skip "refnamex" when such a new atom is
> added to valid_atom[] list, i.e. a bug waiting to happen.  I think
> the new helper is designed to prevent such a bug from happening.

I fully agree, but I also think that this should be a separate topic.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
