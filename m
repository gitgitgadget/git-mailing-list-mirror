From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 02/14] tempfile: a new module for handling temporary files
Date: Wed, 10 Jun 2015 22:56:38 +0200
Message-ID: <5578A486.1070307@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>	<f7681cfc8ee4f1f5eba50f315f8e0ed0fed883a8.1433751986.git.mhagger@alum.mit.edu> <xmqqy4jrlb32.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 22:56:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2n3K-0007HV-E2
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 22:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965378AbbFJU4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 16:56:46 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55891 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965165AbbFJU4p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 16:56:45 -0400
X-AuditID: 1207440f-f79236d000000c5e-df-5578a488971b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F2.7C.03166.884A8755; Wed, 10 Jun 2015 16:56:41 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96964.dip0.t-ipconnect.de [79.201.105.100])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5AKucTP016861
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Jun 2015 16:56:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqy4jrlb32.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1O1cUhFqcOYko0XXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7ozzDQeYCjbxVDw++Ii9gfEt
	ZxcjJ4eEgInE79ePGSFsMYkL99azdTFycQgJXGaUOLPhAVhCSOACk8SKmwkgNq+AtsTEhnls
	IDaLgKrEvksfWUFsNgFdiUU9zUxdjBwcogJBEq9f5kKUC0qcnPmEBcQWEVCTmNh2iAWkhFnA
	SGLe6XqQsLCAn0TvrkusEJu2Mkpc74sEsTkFrCXWT18H1sosoCex4/ovVghbXmL72znMExgF
	ZiHZMAtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zro5WaW6KWmlG5ihIQt/w7G
	rvUyhxgFOBiVeHgdsstDhVgTy4orcw8xSnIwKYnyWs+pCBXiS8pPqcxILM6ILyrNSS0+xCjB
	wawkwmtZB5TjTUmsrEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwrl4E1ChY
	lJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitL4YmCcgqR4gPbuAGnnLS5IzAWKQrSe
	YlSUEuc9A5IQAElklObBjYUlo1eM4kBfCvP2gFTxABMZXPcroMFMQIMXMpeDDC5JREhJNTDa
	6a8+mMZzN3j3dneHm3wHm1fyLEowSrb4tvurWJh8zZyomMNpCzS48zgbH3Hua1F/Pivszvpd
	AgarmSJfdN+P6dp2uzJ/TfRplrqP35uXP3jQ6/ax8soRnejVHitbnjPKXPLTj/92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271353>

On 06/10/2015 07:36 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> diff --git a/builtin/add.c b/builtin/add.c
>> index df5135b..aaa9ce4 100644
>> --- a/builtin/add.c
>> +++ b/builtin/add.c
>> @@ -5,6 +5,7 @@
>>   */
>>  #include "cache.h"
>>  #include "builtin.h"
>> +#include "tempfile.h"
>>  #include "lockfile.h"
>>  #include "dir.h"
>>  #include "pathspec.h"
> 
> It is a bit sad that all users of lockfile.h has to include
> tempfile.h; even when trying to find out something as basic as the
> name of the file on which the lock is held, they need to look at
> lk->tempfile.filename and that requires inclusion of tempfile.h
> 
> It is a good idea to have tempfile as a separate module, as it
> allows new callers to use the same "clean-on-exit" infrastructure on
> things that are not locks, i.e. they can include tempfile.h without
> having to include lockfile.h, but I have to wonder if it is better
> to include tempfile.h from inside lockfile.h (which is alrady done)
> and allow users of lockfile API to assume that inclusion will always
> stay there.  After all, if they are taking locks, they already know
> lk->tempfile is the mechanism through which they need to learn about
> various aspects of the underlying files.

Hmmm, currently lockfile.h doesn't include tempfile.h. But I think it is
a good idea for it to do so. (I would have done it already but I thought
it was against project policy.)

I will make this change in v2.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
