From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] builtin/apply.c: use iswspace() to detect line-ending-like
 chars
Date: Fri, 21 Mar 2014 12:14:02 +0100
Message-ID: <532C1EFA.3000109@alum.mit.edu>
References: <1395344384-7975-1-git-send-email-g3orge.app@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: George Papanikolaou <g3orge.app@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 12:14:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQxPE-0002a4-MK
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 12:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760319AbaCULOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 07:14:08 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:62454 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759943AbaCULOH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 07:14:07 -0400
X-AuditID: 12074414-f79d96d000002d2b-92-532c1efdeb0e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id BC.21.11563.DFE1C235; Fri, 21 Mar 2014 07:14:05 -0400 (EDT)
Received: from [192.168.69.148] (p57A25836.dip0.t-ipconnect.de [87.162.88.54])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2LBE3Aq006269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 21 Mar 2014 07:14:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1395344384-7975-1-git-send-email-g3orge.app@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqPtXTifY4PVtEYvGAwfZLLqudDNZ
	NPReYXZg9tg56y67x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGdc3dPCWNDDVbF/dTt7A2MD
	RxcjB4eEgInE5I0yXYycQKaYxIV769m6GLk4hAQuM0q8uX2XFcI5xyTxZNIUJpAqXgFtifN9
	F8FsFgFViY87OtlAbDYBXYlFPc1gcVGBYInVlx+wQNQLSpyc+QTMFhHQk1i88DUjiM0soCWx
	rqUXrFdYIFxi+7edYDVCAs4SZ59vA5vDKeAicWvvL1aIQ8UlehqDIFp1JN71PWCGsOUltr+d
	wzyBUXAWkm2zkJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuhV5uZoleakrpJkZI
	QIvsYDxyUu4QowAHoxIPbwWndrAQa2JZcWXuIUZJDiYlUV4TaZ1gIb6k/JTKjMTijPii0pzU
	4kOMEhzMSiK8j2SBcrwpiZVVqUX5MClpDhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErzK
	wMgVEixKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFb3wxMIJBUjxAe3VA2nmLCxJz
	gaIQracYdTk2bFvTyCTEkpeflyolztsBcpwASFFGaR7cClj6esUoDvSxMMQoHmDqg5v0CmgJ
	E9AS/qlaIEtKEhFSUg2MDM1sWyuqPgR7/vm5f77tRZUbEkd6D7mfn63Kw1N9ro27+d9Hy/ZH
	hf38xWcfKklKSJ3kPOaWN2/Gi9NFgjPOP1mkq+CpHbTRf9EK45U5Dx95u6e3Jx5Q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244684>

On 03/20/2014 08:39 PM, George Papanikolaou wrote:
> Removing the bloat of checking for both '\r' and '\n' with the prettier
> iswspace() function which checks for other characters as well. (read: \f \t \v)
> ---
> 
> This is one more try to clean up this fuzzy_matchlines() function as part of a
> microproject for GSOC. The rest more clarrified microprojects were taken.
> I'm obviously planning on applying.
> 
> Thanks
> 
> Signed-of-by: George 'papanikge' Papanikolaou <g3orge.app@gmail.com>
> 
>  builtin/apply.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/apply.c b/builtin/apply.c
> index b0d0986..912a53a 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -295,9 +295,9 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
>  	int result = 0;
>  
>  	/* ignore line endings */
> -	while ((*last1 == '\r') || (*last1 == '\n'))
> +	while (iswspace(*last1))
>  		last1--;
> -	while ((*last2 == '\r') || (*last2 == '\n'))
> +	while (iswspace(*last2))
>  		last2--;
>  
>  	/* skip leading whitespace */
> 

In addition to Eric's comments...

What happens if the string consists *only* of whitespace?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
