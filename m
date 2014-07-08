From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 44/48] refs.c: call lock_ref_sha1_basic directly from
 commit
Date: Tue, 08 Jul 2014 17:07:43 +0200
Message-ID: <53BC093F.6010604@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-45-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 17:07:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Wzo-0003u4-68
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 17:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbaGHPHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 11:07:47 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50791 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750707AbaGHPHq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 11:07:46 -0400
X-AuditID: 1207440c-f79036d000005e77-32-53bc094131c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id D2.C9.24183.1490CB35; Tue,  8 Jul 2014 11:07:45 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68F7ivb005229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 11:07:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-45-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1HXk3BNscGOKtkXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTuj+e859oImrortrRuYGhh3sXcxcnJICJhIzJj8
	iAXCFpO4cG89WxcjF4eQwGVGiX9/PjFDOOeZJNp/3mQCqeIV0JZomHKADcRmEVCV2Pj/ICOI
	zSagK7GopxmsRlQgSGL253nsEPWCEidnPgHbICJgJ7H+1kJmEFtYIEyic+sBMFtIoEZi24KJ
	YDM5BVwlni1+AVTPAXSRuERPYxBImFlAR+Jd3wNmCFteYvvbOcwTGAVmIdkwC0nZLCRlCxiZ
	VzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEBCnPDsZv62QOMQpwMCrx8K44
	uCtYiDWxrLgy9xCjJAeTkijvBKY9wUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeL+c2h0sxJuS
	WFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4HXkABoqWJSanlqRlplTgpBm
	4uAEGc4lJVKcmpeSWpRYWpIRD4rU+GJgrIKkeID22oG08xYXJOYCRSFaTzEqSonz+rEDJQRA
	EhmleXBjYannFaM40JfCvOIg7TzAtAXX/QpoMBPQ4M/vd4AMLklESEk1MErwbP4a3rB/hnFD
	/+mFhz9OjOm8xc/+bO7htbezVNiYOJ48+Pr30M99Judl7eZ/1/7vx1GascnIsFVzs9pEroL5
	LwvauHx+6l/LULrKqMLzbIqN24/iVM2Emcyd1woOzlpmfuF/v2DObOcOJ66u00d2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253029>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
> directly from the commit function.

This commit is obviously hostage to whether commit 43/48 is kept.

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index bccf8c3..f3fab37 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3598,12 +3598,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  	for (i = 0; i < n; i++) {
>  		struct ref_update *update = updates[i];
>  
> -		update->lock = lock_any_ref_for_update(update->refname,
> -						       (update->have_old ?
> -							update->old_sha1 :
> -							NULL),
> -						       update->flags,
> -						       &update->type);
> +		update->lock = lock_ref_sha1_basic(update->refname,
> +						   (update->have_old ?
> +						    update->old_sha1 :
> +						    NULL),
> +						   update->flags,
> +						   &update->type);
>  		if (!update->lock) {
>  			if (err)
>  				strbuf_addf(err, "Cannot lock the ref '%s'.",
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
