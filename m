From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 4/8] refs: factor delete_ref loose ref step into a
 helper
Date: Sat, 31 Aug 2013 18:30:13 +0200
Message-ID: <52221A15.20804@alum.mit.edu>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <aa8dc7fb089894b43fdf25e2e0e144229db544a6.1377885441.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Martin Fick <mfick@codeaurora.org>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 18:30:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFo48-0005b8-Dz
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 18:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab3HaQaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 12:30:19 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62720 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753901Ab3HaQaS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 12:30:18 -0400
X-AuditID: 1207440f-b7f786d000001f20-c5-52221a1996eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 75.5C.07968.91A12225; Sat, 31 Aug 2013 12:30:17 -0400 (EDT)
Received: from [192.168.69.9] (p57A2512F.dip0.t-ipconnect.de [87.162.81.47])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r7VGUEHQ029294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 31 Aug 2013 12:30:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <aa8dc7fb089894b43fdf25e2e0e144229db544a6.1377885441.git.brad.king@kitware.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqCsppRRkcLKb32LnOgmLrivdTBYN
	vVeYLe6/X8fkwOJxua+XyePjs+XsHhcvKXt83iQXwBLFbZOUWFIWnJmep2+XwJ3x6fdX5oLZ
	IhW7XjxjbmB8xN/FyMkhIWAi0bzrBiOELSZx4d56ti5GLg4hgcuMEvffPGaHcM4wSVw+38oO
	UsUroCnxdPV5VhCbRUBV4sGG5UwgNpuArsSinmYwW1QgTGLH9IlsEPWCEidnPmEBsUWA6let
	awCLMwv4SXQ9mQ02R1ggSOLH5GZWiGVbGSVuTuwDW8YpECNx7/taVogGHYl3fQ+YIWx5ie1v
	5zBPYBSYhWTHLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6KXm1mil5pSuokR
	EtD8Oxi71sscYhTgYFTi4U1YqhAkxJpYVlyZe4hRkoNJSZQ3UFwpSIgvKT+lMiOxOCO+qDQn
	tfgQowQHs5II7+mVikFCvCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakFqUUwWRkODiUJ
	3rMSQEMFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQdEaXwyMV5AUD9De8yDtvMUF
	iblAUYjWU4y6HO+a5n1iFGLJy89LlRLnvQ1SJABSlFGaB7cClr5eMYoDfSwMMYoHmPrgJr0C
	WsIEtOTaRJDniksSEVJSDYwbw2f/81WZa/KVozzt4yNrroJ9TLu+LtVmevzv9rlDvoEZHRdT
	jzeVKG1O+aGlGa+vLWS2xFnszLYJV4qT02U+fIp13L7j7tpTJibnZp3tWCeq4Rhw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233521>

On 08/30/2013 08:12 PM, Brad King wrote:
> Factor loose ref deletion into helper function delete_ref_loose to allow
> later use elsewhere.
> 
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  refs.c |   22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 2e755b4..5dd86ee 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2450,14 +2450,9 @@ static int repack_without_ref(const char *refname)
>  	return commit_packed_refs();
>  }
>  
> -int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
> +static int delete_ref_loose(struct ref_lock *lock, int flag)
>  {
> -	struct ref_lock *lock;
> -	int err, i = 0, ret = 0, flag = 0;
> -
> -	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
> -	if (!lock)
> -		return 1;
> +	int err, i, ret = 0;
>  	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
>  		/* loose */
>  		i = strlen(lock->lk->filename) - 5; /* .lock */
> @@ -2468,6 +2463,19 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>  
>  		lock->lk->filename[i] = '.';
>  	}
> +	return ret;
> +}
> +


At first glance it is odd that delete_ref_loose() takes a (struct
ref_lock *) argument but only actually uses lock->lk->filename.  But I
guess that the function is so specific to the contents of struct
ref_lock and indeed struct lock_file that it wouldn't make sense to pass
it only the filename attribute.  So OK.

Given that ret is only returned, you could restore the filename before
the if statement and replace the ret variable with an immediate return
statement:

static int delete_ref_loose(struct ref_lock *lock, int flag)
{
	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
		/* loose */
		int err, i = strlen(lock->lk->filename) - 5; /* .lock */

		lock->lk->filename[i] = 0;
		err = unlink_or_warn(lock->lk->filename);
		lock->lk->filename[i] = '.';
		if (err && errno != ENOENT)
			return 1;
	}
	return 0;
}

> +int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
> +{
> +	struct ref_lock *lock;
> +	int ret = 0, flag = 0;
> +
> +	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);
> +	if (!lock)
> +		return 1;
> +	ret |= delete_ref_loose(lock, flag);
> +
>  	/* removing the loose one could have resurrected an earlier
>  	 * packed one.  Also, if it was not loose we need to repack
>  	 * without it.
> 

Otherwise looks good.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
