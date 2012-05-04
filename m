From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 05/18] refs.c: extract function search_for_subdir()
Date: Fri, 04 May 2012 09:24:44 +0200
Message-ID: <4FA3843C.80603@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu> <1335479227-7877-6-git-send-email-mhagger@alum.mit.edu> <7v4nrxf3m2.fsf@alter.siamese.dyndns.org> <7vmx5pdlv1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 09:31:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQCzb-0005uo-Ct
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 09:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876Ab2EDHbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 03:31:51 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:60198 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752134Ab2EDHbu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 May 2012 03:31:50 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 May 2012 03:31:50 EDT
X-AuditID: 12074414-b7fbf6d0000008cf-18-4fa3843fb094
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.B2.02255.F3483AF4; Fri,  4 May 2012 03:24:47 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q447OiKS012807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 May 2012 03:24:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <7vmx5pdlv1.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fmdqaeep1T32YanbLImBcSOdDFgsDRBxdGF6TSozu50XYm
	52yiUSRpirdM9IvTQmZpZVZMw0tWoKZpRV7JEEVIDQUtMLQP3c7bUPv28Pz+z/Pj5XlJQt3t
	pSXNvJ0TeNZCK7zlauWxHbq4vDpDVMVvhnF/KSeYotFiGZNTOkowDz5PEsz9sRqCuTPZIWN+
	5JUQR5T6duekUj88v6rQF3xdIvRzpZ1APzS8U98wvaDUL7tDTyiTfA6msvbMk+Z0PvJwio+p
	72Y1kfHJJ+tNZQfIAVWqIqAiEYxB7uV24KkD0eDUE0UR8CbVcASgxsZCLwzUsFeGKm7E45qC
	e9HA8JgUIkk5DEP5bh1uK6AOuUpyZbgOgKdR2USLzBP3Q/1VM3Jca+BuVJ7fJcf7CTgN0MeZ
	lX/AHx5H7c2VwCP+AFBJU4sSAxWMRXNLnUosI+ABtPJcwG0CbketizXELQCd/zmcGynnf6la
	QDwEoazFYdVZWbNF5NJ0YhrL85ygYyKsZnsEZ3S4gecImjbQ0x/aBSAJaF9qqN5lUHuxmWK2
	tQtsJWV0AGW5XmdQb061GbNNrGhKFhwWTuwCiCRoDQVsEqOMbPZlTrCtoWBSTgdRK3V7EtQw
	nbVzlzgugxPW6DaSpBG1L1ca9BO4dC7rotli38AyUoWXe2s1IscbOYF12E3J+KbJonRUjHwl
	rwGPU2IGa5W6ntEBoCOr7z4bA2o5b+M5bRDli0MQh0wOfl2x9vcWQJD0Yn+qEqd8pZ+5vmlB
	ksgkSXCUC0vs7AbS5gBbz+2kd2R6mSlj3hVe/7TzTJHNXUJEv2o+F1JrTnRZEhQ/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197003>

On 05/03/2012 10:56 PM, Junio C Hamano wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> Hrm.  The old code used to reset "dir" to NULL before breaking, so the
>> entire function used to return NULL.  Now, it calls search_for_subdir(),
>> which calls search_ref_dir() and gets NULL in entry, and returns NULL.
>>
>> Wouldn't we end up returning the original parameter "dir" instead of NULL
>> in that case?  Would that make a difference?
>
> In other words, isn't something like this necessary?

You are right.  Thanks for catching this.

> Otherwise, wouldn't do_for_each_ref() called for a non-existing "refs/"
> subhierarchy in "base" start from the top-level packed_dir/loose_dir
> returned from find_containing_dir(), and end up running do_for_each_ref_in_dirs()
> with both top-level packed_dir/loose_dir and traversing all of them, only
> to find nothing?
>
>   refs.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 9f2da16..af5da5f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -390,8 +390,10 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
>   			   refname + dirname.len,
>   			   (slash + 1) - (refname + dirname.len));
>   		subdir = search_for_subdir(dir, dirname.buf, mkdir);
> -		if (!subdir)
> +		if (!subdir) {
> +			dir = NULL;
>   			break;
> +		}
>   		dir = subdir;
>   	}
>


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
