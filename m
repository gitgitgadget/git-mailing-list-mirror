From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 17/25] commit_lock_file(): make committing an unlocked
 lockfile a NOP
Date: Mon, 14 Apr 2014 10:21:28 +0200
Message-ID: <534B9A88.1000101@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu> <1396827247-28465-18-git-send-email-mhagger@alum.mit.edu> <20140407193131.GC19342@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 14 10:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZc98-0002fn-5m
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 10:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbaDNIVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 04:21:34 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47157 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754502AbaDNIVc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 04:21:32 -0400
X-AuditID: 1207440e-f79c76d000003e2c-7d-534b9a8bfabd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 85.F7.15916.B8A9B435; Mon, 14 Apr 2014 04:21:31 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3E8LSsW029110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 04:21:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140407193131.GC19342@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqNs9yzvYYPN/UYuuK91MFg29V5gt
	frT0MFucedPIaNHZ8ZXRgdXjWe8eRo+Ll5Q9Fj/w8vi8Sc7j9rNtLAGsUdw2SYklZcGZ6Xn6
	dgncGb8uH2EvWM9ZMfHqPcYGxj3sXYycHBICJhJfpqxng7DFJC7cA7G5OIQELjNKvN90lhXC
	ucAksWHJVrAqXgFtieNTL7KA2CwCqhKHt+xmArHZBHQlFvU0A9kcHKICQRJ/zipClAtKnJz5
	BKxcREBW4vvhjYwgM5kFNjBKHN9zHywhLBAn8XjqHUaIZWsZJX63t4AN5RSwlpgzYSILyFAJ
	AXGJnsYgEJNZQF1i/TwhkApmAXmJ7W/nME9gFJyFZN0shKpZSKoWMDKvYpRLzCnN1c1NzMwp
	Tk3WLU5OzMtLLdI11svNLNFLTSndxAgJe74djO3rZQ4xCnAwKvHwJm73DBZiTSwrrsw9xCjJ
	waQkyvt+snewEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHebRlewUK8KYmVValF+TApaQ4WJXFe
	tSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneFzOBhgoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQW
	JZaWZMSD4je+GBjBICkeoL0/QNp5iwsSc4GiEK2nGHU5Nmxb08gkxJKXn5cqJc7LDFIkAFKU
	UZoHtwKW5F4xigN9LMx7FaSKB5gg4Sa9AlrCBLSEpR1sSUkiQkqqgZGZIyJ21xe14OVT877J
	r95xRyB2/gUXS8fZTHFTL5fU3hRf5mfpczr6mAFD9/S3vdGb+JazsfpFTyvIY5bb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246217>

On 04/07/2014 09:31 PM, Jeff King wrote:
> On Mon, Apr 07, 2014 at 01:33:59AM +0200, Michael Haggerty wrote:
> 
>> It was previously a bug to call commit_lock_file() with a lock_file
>> object that was not active (an illegal access would happen within the
>> function).  It was presumably never done, but this would be an easy
>> programming error to overlook.  So guard the file-renaming code with
>> an if statement to change committing an unlocked file into a NOP.
>> [...]
> 
> Yeah, I would have expected a die("BUG") here.
> 
> I think it is worth making it a fatal mistake and catching it. Rolling
> back an uninitialized lockfile is probably OK; we are canceling an
> operation that never started. But committing a lockfile that we didn't
> actually fill out could be a sign of a serious error, and we may be
> propagating a bogus success code. E.g., imagine that receive-pack claims
> to have written your ref, but actually commit_lock_file was a silent
> NOP. I'd much rather have it die loudly so we can track down the case.

OK, I will change this to a fatal error in v3.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
