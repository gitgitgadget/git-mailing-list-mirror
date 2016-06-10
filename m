From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 00/33] Yet more preparation for reference backends
Date: Fri, 10 Jun 2016 14:50:31 +0200
Message-ID: <575AB797.809@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 14:50:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLtY-0002Ix-OA
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140AbcFJMug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 08:50:36 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53091 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932180AbcFJMug (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 08:50:36 -0400
X-AuditID: 12074412-51bff700000009f7-43-575ab79a5dda
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D9.0E.02551.A97BA575; Fri, 10 Jun 2016 08:50:34 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5ACoVBH008167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 08:50:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqDtre1S4wZJFShbzN51gtOi60s1k
	0dB7hdmie8pbRosfLT3MFjOvWjuweeycdZfd41nvHkaPi5eUPfYv3cbmseD5fXaPz5vkAtii
	uG2SEkvKgjPT8/TtErgz7rx9zFjwnrdi1pl/TA2M57m7GDk5JARMJHZdWcXSxcjFISSwlVFi
	37ft7BDOBSaJeYufsoFUCQt4StxofMUKYosIREg0vGphBLGFBMwlOtbeAGtgFjjCKHGg6RML
	SIJNQFdiUU8zE4jNK6Au8ej6ZTCbRUBVYv+kJWA1ogIhEufXbWWFqBGUODnzCVicU8BC4lDv
	cbB6ZgE9iR3Xf7FC2PIS29/OYZ7AyD8LScssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5yc
	mJeXWqRrppebWaKXmlK6iRES4EI7GNeflDvEKMDBqMTDG7ErMlyINbGsuDL3EKMkB5OSKG/i
	/KhwIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8lzcD5XhTEiurUovyYVLSHCxK4rw/F6v7CQmk
	J5akZqemFqQWwWRlODiUJHifbwVqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdF
	ZXwxMC5BUjxAe5+CtPMWFyTmAkUhWk8x6nIc2X9vLZMQS15+XqqUOK/tNqAiAZCijNI8uBWw
	dPaKURzoY2HeApAqHmAqhJv0CmgJE9CS5UfCQZaUJCKkpBoYddakr1t7c07sH55LYdZ/uPQX
	GJ30OfntvVmsz/KQFOOaiodPj2Xv973EJDsj/eWipF2O14OuzJ1760eV73aRffsd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297002>

On 05/06/2016 06:13 PM, Michael Haggerty wrote:
> [...]
> This patch series is also available from my GitHub repo [2] as branch
> "split-under-lock".
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/292772
> [2] https://github.com/mhagger/git

I was reading this area of the code again, and I found a problem in this
patch series. Now that ref_updates can be added to ref_transactions
while they are being processed, it is not correct to store a pointer to
transaction->updates in ref_transaction_commit() here [1], because the
array might be moved by realloc() if it grows during the function. The
problem wasn't detected during testing because an added commit would
have to cross an ALLOC_GROW boundary to trigger the bug.

The fix is obvious but it is textually quite a few lines. For good
measure, the same fix should be made in initial_ref_transaction_commit()
here [2].

The most logical place to fix this is by expanding commit
"ref_transaction_commit(): remove local variable n" [3], so I've done
that and force pushed the result to my GitHub account [4] as branch
"split-under-lock".

Junio, if you want to incorporate this revised version of the branch in
your big rewind of next, then we can pretend that the bug was never
there :-) Otherwise, tell me in what form you would like the fix and I
will be happy to provide it.

Sorry for finding this problem so late in the process.

Michael

[1]
https://github.com/mhagger/git/blob/088c8f756c86581ff25371983ef409044b348bb9/refs/files-backend.c#L3559
[2]
https://github.com/mhagger/git/blob/088c8f756c86581ff25371983ef409044b348bb9/refs/files-backend.c#L3725
[3] http://article.gmane.org/gmane.comp.version-control.git/293801
[4] https://github.com/mhagger/git
