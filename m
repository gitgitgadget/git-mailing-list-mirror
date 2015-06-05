From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Pack files, standards compliance, and efficiency
Date: Fri, 05 Jun 2015 17:22:08 +0200
Message-ID: <5571BEA0.2080305@alum.mit.edu>
References: <20150605014120.GE305479@vauxhall.crustytoothpaste.net> <20150605094545.GB11855@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 17:22:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0tS0-0006wJ-B3
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 17:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbbFEPWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 11:22:22 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52196 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754627AbbFEPWV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 11:22:21 -0400
X-AuditID: 12074414-f79ed6d000000cef-80-5571bea2af6f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id AC.32.03311.2AEB1755; Fri,  5 Jun 2015 11:22:10 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9741B.dip0.t-ipconnect.de [79.201.116.27])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t55FM8Ye010540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 5 Jun 2015 11:22:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150605094545.GB11855@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqLtoX2Gowc91vBZdV7qZLLqnvGW0
	+NHSw2zRNvMHk8Xmze0sDqwey2/+ZfLYOesuu8eCTaUez3r3MHp83iQXwBrFbZOUWFIWnJme
	p2+XwJ0x++RytoJVvBVXm+YwNzDu5epi5OSQEDCROHdxAxOELSZx4d56ti5GLg4hgcuMErsn
	nGCHcM4xSbzftZkZpIpXQFvi45rrLCA2i4CqxIwVS9lAbDYBXYlFPc1Akzg4RAWCJF6/zIUo
	F5Q4OfMJWLmIwG5GiQ2f2UFsYQFbiS+zT4PZQgKpEtt/TgA7glNAT+LW9BOMIDazgLrEn3mX
	mCFseYnmrbOZJzDyz0IydhaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0rXQy80s
	0UtNKd3ECAllkR2MR07KHWIU4GBU4uFtMCwMFWJNLCuuzD3EKMnBpCTK67kLKMSXlJ9SmZFY
	nBFfVJqTWnyIUYKDWUmEt3MrUI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxW
	hoNDSYJ3wV6gRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQRMYXA2MSJMUDtDcH
	pJ23uCAxFygK0XqKUZej7/7vRUxCLHn5ealS4rx7QYoEQIoySvPgVsAS1ytGcaCPhXlPg1Tx
	AJMe3KRXQEuYgJZcZy0AWVKSiJCSamD03N3b+y32jGf+3/0rz27m+bstQ0PXOrjOYe4J/ppY
	gb+qvesezfrbqhwgG/tUXHBXzJuJyvbPc46Zr97/ad7Md++eRhxbXqzx3zy0qv5b 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270840>

On 06/05/2015 11:45 AM, Jeff King wrote:
> On Fri, Jun 05, 2015 at 01:41:21AM +0000, brian m. carlson wrote:
> 
>> However, with the object_id conversion, we run into a problem: casting
>> those unsigned char * values into struct object_id * values is not
>> allowed by the C standard.  There are two possible solutions: copying;
>> and the just-do-it solution, where we cast and hope for the best.
> 
> [...]
> 
> But I'm not even sure that line of thinking is all that interesting.
> Even if we are violating some dark corner of the standard, this
> definitely falls into the "it's useful and works on all sane machines"
> category. We also do much worse things with struct-casting mmap'd data
> elsewhere (e.g., see the use of "struct pack_header"). It works fine in
> practice as long as you are careful about alignment and padding issues.
> 
> So my vote would be to retain the cast. This is very low-level,
> performance-sensitive code. I did some very naive timings and didn't see
> any measurable change from your patch, but I also don't think we are
> seeing a real portability benefit to moving to the copy, so I'd prefer
> to keep the status quo.

I don't know that there would necessarily be problems, but I would worry
about code involving structure assignment. For example, suppose the
following snippet:

    void f(struct object_id *oid)
    {
        struct object_id oid_copy = *oid;
        /* ... */
    }

The compiler is allowed to implement the copy using instructions that
rely on proper alignment. Such code would fail if oid is not properly
aligned.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
