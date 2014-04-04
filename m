From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 20/27] update-ref --stdin: Reimplement using reference
 transactions
Date: Fri, 04 Apr 2014 07:02:48 +0200
Message-ID: <533E3CF8.5080506@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-21-git-send-email-mhagger@alum.mit.edu>	<xmqqppl0zvcs.fsf@gitster.dls.corp.google.com>	<533B9A26.8050303@alum.mit.edu> <xmqq61mqs8wl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 07:02:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVwHK-0008Qb-Mu
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 07:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbaDDFCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 01:02:54 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:51006 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750897AbaDDFCx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Apr 2014 01:02:53 -0400
X-AuditID: 1207440d-f79d86d0000043db-a4-533e3cfc8087
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A9.EE.17371.CFC3E335; Fri,  4 Apr 2014 01:02:52 -0400 (EDT)
Received: from [192.168.69.148] (p5B156274.dip0.t-ipconnect.de [91.21.98.116])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3452mTN021010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 4 Apr 2014 01:02:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqq61mqs8wl.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqPvHxi7Y4PEMJYud6yQsuq50M1k0
	9F5htph3dxeTxY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6HHxkrLH501yAWxR
	3DZJiSVlwZnpefp2CdwZZ78dZC/Ywltx9MYzxgbGh1xdjJwcEgImEjPbf7NC2GISF+6tZwOx
	hQQuM0o8X+fdxcgFZJ9lknh79AgLSIJXQFvi17xzTCA2i4CqxNqFv8Ea2AR0JRb1NIPFRQWC
	JA5vOMUKUS8ocXLmE7BeEQE1iYlth1hAhjILrGaUWDplBlizsECMxJUjOxghNv9hlDh2xR3E
	5hSwljh28xdzFyMH0HXiEj2NQSBhZgEdiXd9D5ghbHmJ7W/nME9gFJyFZN0sJGWzkJQtYGRe
	xSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrpJebWaKXmlK6iRESDbw7GP+vkznEKMDBqMTDy5Fu
	GyzEmlhWXJl7iFGSg0lJlDfY0C5YiC8pP6UyI7E4I76oNCe1+BCjBAezkggvpxVQjjclsbIq
	tSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwWsJjHohwaLU9NSKtMycEoQ0Ewcn
	yHAuKZHi1LyU1KLE0pKMeFAExxcDYxgkxQO0F6ydt7ggMRcoCtF6ilGXY8O2NY1MQix5+Xmp
	UuK8M62BigRAijJK8+BWwFLfK0ZxoI+FeZ1BRvEA0ybcpFdAS5iAlnCvswJZUpKIkJJqYDT0
	mbOz6XhhBavrA7uiVJvL9XIZj5bzLgi8cXlN+h5F/eCr0lfmaZhs5CxSeSzlJhMa 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245757>

On 04/03/2014 05:57 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I assumed that rolling back a non-consummated transaction in the case of
>> early program death should be the responsibility of the library, not of
>> the caller.  If I'm correct, the caller(s) won't have to be modified
>> when the atexit facility is added, so I don't see a reason to add it
>> before it is needed by a concrete backend.
>>
>> But you suggest that the caller should be involved.
> 
> I didn't say "should".  If the library can automatically rollback
> without being called upon die() anywhere in the system, that is
> better.  The suggestion was because I didn't think you were shooting
> for such a completeness in the library part, and a possible way out
> is for the caller to help.

I was assuming that any ref backends that required rollback-on-fail
would register an atexit handler and a signal handler, similar to how
lock_file rollbacks are done.

I admit that I haven't thought through all the details; for example, are
there restrictions on the things that a signal handler is allowed to do
that would preclude its being able to rollback the types of transactions
that back ends might want to implement?  (Though if so, what hope do we
have that the caller can do better?)

So, if somebody can think of a reason that we would need to involve the
caller in cleanup, please speak up.  Otherwise I think it would be less
error-prone to leave this responsibility with the individual back ends.
 (And if something unexpected comes up, we can make this change later.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
