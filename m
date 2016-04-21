From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 19/33] refs: allow log-only updates
Date: Thu, 21 Apr 2016 16:17:32 +0200
Message-ID: <5718E0FC.7090501@alum.mit.edu>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-20-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	peff@peff.net, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 21 16:18:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atFQc-0005W1-8C
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 16:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbcDUORu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 10:17:50 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58902 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752076AbcDUORt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2016 10:17:49 -0400
X-AuditID: 1207440c-c53ff70000000b85-e2-5718e0ffba92
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 86.A1.02949.FF0E8175; Thu, 21 Apr 2016 10:17:35 -0400 (EDT)
Received: from [192.168.69.130] (p548D60DA.dip0.t-ipconnect.de [84.141.96.218])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3LEHWXA016883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 21 Apr 2016 10:17:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1456793586-22082-20-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqPv/gUS4wYwJ2hbzN51gtOi60s1k
	0dB7hdmie8pbRosfLT3MDqweO2fdZfd41ruH0ePiJWWPBc/vs3t83iQXwBrFbZOUWFIWnJme
	p2+XwJ0x+7hywSyhijk/zzA1MO7g62Lk5JAQMJHYdH0dYxcjF4eQwFZGiT+dT1ghnPNMEh//
	rGADqRIWsJJ4deIsmC0ikC0x59M5qKIORoll9+eAJZgF1CTaN01hBbHZBHQlFvU0M4HYvALa
	En9/rQOzWQRUJaZceQBWIyoQIrFt3TdWiBpBiZMzn7CA2JwCXhKnL39khpipJ7Hj+i9WCFte
	YvvbOcwTGPlnIWmZhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNK
	NzFCgplnB+O3dTKHGAU4GJV4eDnkJcKFWBPLiitzDzFKcjApifJG7gEK8SXlp1RmJBZnxBeV
	5qQWH2KU4GBWEuG1uw2U401JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ
	8M69D9QoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rJ+GJgVIKkeID2fgZp5y0u
	SMwFikK0nmJUlBLnPQuSEABJZJTmwY2FpahXjOJAXwrz2gITlhAPML3Bdb8CGswENJj/rijI
	4JJEhJRUA2PC3iVzb7MmG27WES+7Z515u7fXPIt9ppgS/7HfHREdJ0SDm/mcvnhfOrs138o8
	IXuuaWZ8u+etK+u1bwfM/h8cFJfw7BD/1Ow/vzh3eeR+K4rW+M4/9ZVv8zy/KuVL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292111>

On 03/01/2016 01:52 AM, David Turner wrote:
> The refs infrastructure learns about log-only ref updates, which only
> update the reflog.  Later, we will use this to separate symbolic
> reference resolution from ref updating.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  refs/files-backend.c | 15 ++++++++++-----
>  refs/refs-internal.h |  7 +++++++
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 1f565cb..189b86e 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2702,7 +2702,7 @@ static int commit_ref_update(struct ref_lock *lock,
>  			}
>  		}
>  	}
> -	if (commit_ref(lock)) {
> +	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
>  		error("Couldn't set %s", lock->ref_name);
>  		unlock_ref(lock);
>  		return -1;
> @@ -3056,7 +3056,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
>  			goto cleanup;
>  		}
>  		if ((update->flags & REF_HAVE_NEW) &&
> -		    !(update->flags & REF_DELETING)) {
> +		    !(update->flags & REF_DELETING) &&
> +		    !(update->flags & REF_LOG_ONLY)) {
>  			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
>  						  (update->flags & REF_NODEREF));
>  
> @@ -3086,7 +3087,9 @@ static int files_transaction_commit(struct ref_transaction *transaction,
>  				update->flags |= REF_NEEDS_COMMIT;
>  			}
>  		}
> -		if (!(update->flags & REF_NEEDS_COMMIT)) {
> +
> +		if (!(update->flags & REF_LOG_ONLY) &&
> +		    !(update->flags & REF_NEEDS_COMMIT)) {

I was just going over this series again, and I think this hunk is
incorrect. If REF_LOG_ONLY, we created and opened the lockfile. And we
didn't call write_ref_to_logfile(), so the lockfile is still open. That
means that we want to call close_ref() here to free up the file
descriptor. (Note that close_ref() closes the lockfile but doesn't
release the lock. That is done further down by unlock_ref().)

So I think this hunk should be omitted.

I realize that this patch series is obsolete, so there is no need to
re-submit. I just wanted to get a sanity check as I implement a new
version of this patch that I'm not misunderstanding something.

> [...]

Michael
