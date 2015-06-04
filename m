From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH mh/lockfile-retry] lockfile: replace random() by rand()
Date: Thu, 04 Jun 2015 13:42:38 +0200
Message-ID: <557039AE.3020107@alum.mit.edu>
References: <55695770.2040303@kdbg.org> <xmqq7frqat0m.fsf@gitster.dls.corp.google.com> <55700F10.8030806@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 13:42:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0TXu-0004R8-0T
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 13:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbbFDLmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 07:42:45 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:46187 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753194AbbFDLmo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 07:42:44 -0400
X-AuditID: 1207440d-f79026d000000bad-4c-557039b158d8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 85.13.02989.1B930755; Thu,  4 Jun 2015 07:42:41 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97676.dip0.t-ipconnect.de [79.201.118.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t54BgctP000466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 4 Jun 2015 07:42:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <55700F10.8030806@kdbg.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1N1oWRBq8K2J16LrSjeTRUPvFWaL
	J3PvMjswezx81cXucfGSssfnTXIBzFHcNkmJJWXBmel5+nYJ3Bkt11IKLnJV7D1yhKmB8RRH
	FyMnh4SAicSeKe9ZIGwxiQv31rN1MXJxCAlcZpR48WAvI4Rznkni/uXnrCBVvALaEqe/NzOB
	2CwCqhItt5rYQGw2AV2JRT0gcQ4OUYEgidcvcyHKBSVOznwCtkBEwEXi39LvYOXMAloSdy7d
	ZQSxhQW8Jd5f3wBmCwkUSTyZ9gzM5hTQkPi34iwjyEhmoPFta2QgWuUlmrfOZp7AKDALyYZZ
	CFWzkFQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrpJebWaKXmlK6iREStLw7GP+vkznE
	KMDBqMTDa3EsP1SINbGsuDL3EKMkB5OSKK+YTkGoEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe
	U3pAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBK+TBVCjYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChG44uBUQqS4gHauxGknbe4IDEXKArReopRUUqc
	1wgkIQCSyCjNgxsLS0WvGMWBvhTmjQSp4gGmMbjuV0CDmYAGX2cFG1ySiJCSamCse/bhO8+j
	hSFOpyazvsrcafEi3sRQ7fL+HfNf+GXl37brnPxQn11DPmaR0eYalbUsGwVNHkyRuLxppi3T
	xl1xjHz8jm1OG8M972uZP7zdcnSnvdPkA8xfnBMkRd7fus7jO2VZX/LWtZHF8cxd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270768>

On 06/04/2015 10:40 AM, Johannes Sixt wrote:
> Am 30.05.2015 um 19:12 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> There you have it: Look the other way for a while, and people start
>>> using exotic stuff... ;)
>>
>> Is it exotic to have random/srandom?  Both are in POSIX and 4BSD;
>> admittedly rand/srand are written down in C89 and later, so they
>> might be more portable, but I recall the prevailing wisdom is to
>> favor random over rand for quality of randomness and portability, so
>> I am wondering if it may be a better approach to keep the code as-is
>> and do a compat/random.c based on either rand/srand (or use posix
>> sample implementation [*1*]).
> 
> For our purposes here, the linear congruence of rand() is certainly
> sufficient. At this time, compatibility functions for random/srandom
> would just mean a lot of work for little gain.

We *certainly* don't require high-quality random numbers for this
application. Regarding portability, there is one definite point in favor
of rand() (it's available on Windows) vs. Junio's recollection that
random() might have portability advantages, presumably on other platforms.

Maybe the easiest thing would be to switch to using rand() and see if
the OS/2 and VMS users complain ;-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
