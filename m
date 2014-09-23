From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 20/35] api-lockfile: document edge cases
Date: Tue, 23 Sep 2014 14:56:25 +0200
Message-ID: <54216DF9.3020307@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-21-git-send-email-mhagger@alum.mit.edu> <20140916222344.GT29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 14:56:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWPdy-0007gd-6t
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 14:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbaIWM4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 08:56:30 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64302 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751307AbaIWM43 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Sep 2014 08:56:29 -0400
X-AuditID: 12074412-f792e6d000005517-8d-54216dfca878
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id EF.49.21783.CFD61245; Tue, 23 Sep 2014 08:56:28 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1DCD.dip0.t-ipconnect.de [93.219.29.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8NCuQV6020165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 23 Sep 2014 08:56:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140916222344.GT29050@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqPsnVzHE4OFDfYuuK91MFg29V5gt
	nsy9y2zx9uYSRosfLT3MFv8m1Fh0dnxldGD32DnrLrvHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOePPqEVvBDM6KVQu/szUwrmTvYuTkkBAwkfi46Akb
	hC0mceHeeiCbi0NI4DKjxJfOnywQznkmie3fzzGDVPEKaEvM2LARrINFQFVi7skLjCA2m4Cu
	xKKeZiYQW1QgQOJD5wNGiHpBiZMzn7CA2CICGhLPP30D28As8JFRYu71k6wgCWEBe4lZZ+dD
	bVvEKLH0+22wBKeAgcTrO11gk5gF9CR2XP/FCmHLS2x/O4d5AqPALCRLZiEpm4WkbAEj8ypG
	ucSc0lzd3MTMnOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkGgQ2sG4/qTcIUYBDkYlHl6PNQoh
	QqyJZcWVuYcYJTmYlER5k7MUQ4T4kvJTKjMSizPii0pzUosPMUpwMCuJ8IplAOV4UxIrq1KL
	8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4DYBRLyRYlJqeWpGWmVOCkGbi4AQZ
	ziUlUpyal5JalFhakhEPitf4YmDEgqR4gPaeygHZW1yQmAsUhWg9xajLsa7zWz+TEEtefl6q
	lDjvLZAiAZCijNI8uBWw1PeKURzoY2HeEJBLeIBpE27SK6AlTEBL7h+XB1lSkoiQkmpgDGaQ
	kLygefbwTj4FKUYG3dlXRdwVnT+vUr7/PP/ciqmtCbUL7XnUvj3ZuPpfgUQo57r0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257417>

On 09/17/2014 12:23 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> * Document the behavior of commit_lock_file() when it fails, namely
>>   that it rolls back the lock_file object and sets errno
>>   appropriately.
>>
>> * Document the behavior of rollback_lock_file() when called for a
>>   lock_file object that has already been committed or rolled back,
>>   namely that it is a NOOP.
> 
> I think this would be easier to read in a separate error handling
> section.  That way, when writing new code using the lockfile API,
> I can quickly find what functions to use and quickly find out what
> the error handling conventions are --- each use of the documentation
> wouldn't interfere with the other.

I added a little blurb in the error handling section explaining how
commit_lock_file() and close_lock_file() behave on failure, but I left
the detailed information in the sections on those functions because I
couldn't find a graceful way to put all of the information in the error
handling sections.

If you have a concrete suggestion, as they say, "patches are welcome" :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
