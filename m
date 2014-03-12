From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] general style: replaces memcmp() with starts_with()
Date: Wed, 12 Mar 2014 18:22:24 +0100
Message-ID: <532097D0.4070909@web.de>
References: <1394631854-11208-1-git-send-email-quintus.public@gmail.com> <5320818C.8070200@web.de> <CALs4jVFpr=YVAagJSEkAJ6qGJmYWNdu4ZXXvMYQRd0KYQXcVQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 18:22:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNmrP-000103-EU
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 18:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbaCLRW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 13:22:27 -0400
Received: from mout.web.de ([212.227.15.3]:52103 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755583AbaCLRW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 13:22:26 -0400
Received: from [192.168.178.41] ([84.132.147.182]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MOzwh-1WU5Rv2cEh-006NOR; Wed, 12 Mar 2014 18:22:24
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CALs4jVFpr=YVAagJSEkAJ6qGJmYWNdu4ZXXvMYQRd0KYQXcVQA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:YvTR6a62AIgDLpaLS/sh1gKlr6s5JuPXGT25lBQvw7jM1+muLPd
 iySGA7nb/PXyev8TFkiP/MbnzeWiW+Ufp+eDKstMxDyW9jVzhqeKMBwN28WEssDmCQ0a5J2
 ur/N/wprrZ65HAfdoe4mwC1LVS1+DAucepT4bNQTT13m7Y+YgnbSXAS8QXhZZhmaon5kFrS
 Z00IBZRo6oIakWiLCpudw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243947>

Am 12.03.2014 17:46, schrieb Quint Guvernator:
> 2014-03-12 11:47 GMT-04:00 Jens Lehmann <Jens.Lehmann@web.de>:
>> I think this hunk should be dropped as the memcmp() here doesn't mean
>> "starts with" but "is identical" (due to the "ce_namelen(ce) == 11" in
>> the line above).
> 
> There is an issue with negation in this patch. I've submitted a new
> one [1] to the mailing list. The subject line of the new patch is
> "[PATCH] general style: replaces memcmp() with proper starts_with()".

Thanks, I missed that one (please use "[PATCH v2]" in the subject
line of a second patch to make follow-ups easily distinguishable
from the initial one ;-).

> Let me know if you still think the hunk should be dropped there.

Yes, I think so. That spot uses memcmp() because ce->name may
not be 0-terminated. If that assumption isn't correct, it should
be replaced with a plain strcmp() instead (while also dropping
the ce_namelen() comparison in the line above). But starts_with()
points into the wrong direction there.

> [1]: http://thread.gmane.org/gmane.comp.version-control.git/243940
