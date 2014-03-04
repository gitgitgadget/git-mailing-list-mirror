From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] cache_tree_find(): remove redundant checks
Date: Tue, 04 Mar 2014 23:24:57 +0100
Message-ID: <531652B9.4000001@alum.mit.edu>
References: <1393921868-4382-1-git-send-email-mhagger@alum.mit.edu> <xmqq8uspk72g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:25:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKxlu-00053i-0L
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 23:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688AbaCDWZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 17:25:04 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61692 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752123AbaCDWZB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 17:25:01 -0500
X-AuditID: 1207440e-f79c76d000003e2c-4b-531652bc1a8a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.CC.15916.CB256135; Tue,  4 Mar 2014 17:25:00 -0500 (EST)
Received: from [192.168.69.148] (p57A2482C.dip0.t-ipconnect.de [87.162.72.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s24MOwsp004979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 4 Mar 2014 17:24:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqq8uspk72g.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqLsnSCzY4PsXM4vZN7axWXRd6Way
	aOi9wuzA7NE2zczj4iVlj8+b5AKYo7htkhJLyoIz0/P07RK4M+70b2ct6OequLrmDlsD4y/2
	LkZODgkBE4meF/dZIGwxiQv31rN1MXJxCAlcZpS4eGQ3lHOWSWLByz5WkCpeAW2J3w2LGEFs
	FgFViUnnuphBbDYBXYlFPc1MILaoQLDE6ssPWCDqBSVOznwCZosIqElMbDsEZjMDbf6x4BTY
	FcICThITvm8FmykkUCRx+NUvNhCbU8Ba4sadfqB6DqDrxCV6GoMgWnUk3vU9YIaw5SW2v53D
	PIFRcBaSbbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkhA
	8+1gbF8vc4hRgINRiYf3BYdYsBBrYllxZe4hRkkOJiVRXm5gPAjxJeWnVGYkFmfEF5XmpBYf
	YpTgYFYS4Y3RBsrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4FwYC
	NQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIji+GBjDICkeoL0HQdp5iwsSc4Gi
	EK2nGHU5brf9+sQoxJKXn5cqJc5bD1IkAFKUUZoHtwKWvl4xigN9LMzbClLFA0x9cJNeAS1h
	AlrSA/ZccUkiQkqqgVGwefOqs5s3L+D7dC0rbd4XRwnmPS/Td23indSq1rM0OyNF3TGIw3yF
	qMidBWt3C6XkL7yz0nSKhNWeLJ99pkvXWhpx3RZ3YPt5roFt1uwFC8xW3ylxm5f9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243398>

On 03/04/2014 10:05 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>  	while (*path) {
>> -		const char *slash;
>>  		struct cache_tree_sub *sub;
>> +		const char *slash = strchr(path, '/');
>>  
>> -		slash = strchr(path, '/');
>>  		if (!slash)
>>  			slash = path + strlen(path);
> 
> Isn't the above a strchrnul()?

Oh, cool, I never realized that this GNU extension was blessed for use
in Git.  Will change.

> Combining a freestanding decl with intializer assignment to lose one
> line is sort of cheating on the line count, but replacing the three
> lines with a single strchrnul() would be a real code reduction ;-)

I suppose you are just teasing me, but for the record I consider line
count only a secondary metric.  The reason for combining initialization
with declaration is to reduce by one the number of times that the reader
has to think about that variable when analyzing the code.

And as I am writing this I realize that after converting to the use of
strchrnul(), sub can also be initialized at its declaration.

I really wish we could mix declarations with statements because I think
it is a big help to readability.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
