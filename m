From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] t/Makefile: retain cache t/.prove across prove runs
Date: Sat, 19 May 2012 16:54:33 +0200
Message-ID: <4FB7B429.80805@alum.mit.edu>
References: <1335972712-20621-1-git-send-email-mhagger@alum.mit.edu> <20120502160753.GA7193@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 19 16:55:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVl3h-0004Ng-R4
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 16:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab2ESOyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 10:54:37 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:50709 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753072Ab2ESOyg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 10:54:36 -0400
X-AuditID: 1207440d-b7f336d00000097b-af-4fb7b42b7d91
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 47.6E.02427.B24B7BF4; Sat, 19 May 2012 10:54:35 -0400 (EDT)
Received: from [192.168.2.130] (p4FC0C79F.dip.t-dialin.net [79.192.199.159])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4JEsXKt020282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 19 May 2012 10:54:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120502160753.GA7193@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqKu9Zbu/wa65qhZdV7qZLBp6rzBb
	/GjpYXZg9njWu4fR4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDPa1/QyFRwWqej7fZSlgXGV
	QBcjJ4eEgInEreWrmSBsMYkL99azdTFycQgJXGaUOD13LwuEc4ZJ4u6BQ4wgVbwCmhKnX+9h
	A7FZBFQl5p/pAutmE9CVWNTTDGRzcIgKhEmsfqABUS4ocXLmExYQW0RAVuL74Y1gY5gFrCVW
	vD4M1ios4CHxYf48sBohgSKJ3W0t7CA2p4CVxOv7e5kg6s0kurZ2QfXKS2x/O4d5AqPALCQr
	ZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MkNDl3cH4f53M
	IUYBDkYlHt7KCdv8hVgTy4orcw8xSnIwKYnybt683V+ILyk/pTIjsTgjvqg0J7X4EKMEB7OS
	CO8KT6Acb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCdwvIUMGi1PTU
	irTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQpMYXA2MVJMUDtHcRSDtvcUFiLlAUovUUoy7H
	jE+LrjEKseTl56VKifO2gBQJgBRllObBrYAlqleM4kAfC/OuAaniASY5uEmvgJYwAS2pZNsG
	sqQkESEl1cDYvD3pzcn973k00qfcVYiZVOJU8+lvxZFHn40fLsmfsfiFxzKmhIuxX9f1bpj+
	d9ne3yae1wW1b71/bh6pcn6GWeWBiBLmvTt/W/5uFV/xIHNNbX3P+vzZc4ou7Vnu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198033>

On 05/02/2012 06:07 PM, Jeff King wrote:
> On Wed, May 02, 2012 at 05:31:52PM +0200, mhagger@alum.mit.edu wrote:
>> prove(1) can write a summary of its test results and timings into a
>> cache file, t/.prove, then use this information during later runs for
>> various purposes.  But deleting t/.prove after every test run defeats
>> this purpose.  So do not delete t/.prove as part of "make
>> DEFAILT_TEST_TARGET=prove test".  (Continue to delete the file on
>> "make clean".)
>
> Thanks. I had found some odd behaviors with putting "--state" into
> GIT_PROVE_OPTS when I first switched my setup to use prove, but I didn't
> investigate. I think this issue explained some of what I saw.
>
> Do note, though, that we only clean ".prove" on a successful run. So
> something like "--state=hot,save" will still see the cache from the last
> run if there were failures. However, the prove cache is meant to be kept
> across many runs, even successful ones, so I think your patch makes
> sense.
>
>> ---
>> prove(1) can be told to retain information about test runs, and to use
>> it for interesting purposes during future invocations.  For example,
>> it can be told to run tests that failed during the last run:
>>
>>      GIT_PROVE_OPTS = --state=failed,save
>
> I don't think this actually works, because we also feed all of the test
> scripts to prove on the command line. So it will run them all, both
> failed and successful.
>
> I'm not sure if it is worth solving for "make test". I suspect having
> that not test everything would be error prone (i.e., it's too easy to
> accidentally not run the full suite when you meant to, and unexpected
> regressions in other tests will go unnoticed). You can always run
> "prove" yourself from the command line, or we can add a new target to do
> a partial test (with other options set up properly).

I totally believe you that some of the variations that I listed in my 
commentary don't work in the git context.  I'm not a prove expert; I 
just noticed that removing the .prove file is counterproductive and 
breaks some other prove features.  I also agree with you that it would 
be dangerous to encourage partial testing and that it is therefore not a 
priority to make the use case that you mentioned work in the git context.

I still think my patch makes sense.  The error that Peff pointed out was 
in my commentary, not in the patch itself or in the log message.  Junio, 
is there something else keeping you from applying this patch?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
