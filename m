From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 40/48] refs.c: add an err argument to delete_ref_loose
Date: Tue, 08 Jul 2014 16:19:42 +0200
Message-ID: <53BBFDFE.5060902@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-41-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 16:19:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4WFJ-0005pp-FN
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 16:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbaGHOTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 10:19:45 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58171 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750834AbaGHOTp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 10:19:45 -0400
X-AuditID: 1207440e-f79da6d0000002fc-4b-53bbfe00ea02
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F6.31.00764.00EFBB35; Tue,  8 Jul 2014 10:19:44 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68EJg8x002913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 10:19:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-41-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1GX4tzvYYMYzGYuuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfG9OcLWAs65Svenj3I3MD4R7yLkZNDQsBEovXQ
	XjYIW0ziwr31QDYXh5DAZUaJG50zoJzzTBIXmlcyglTxCmhLHNlwhgXEZhFQlehePw/MZhPQ
	lVjU08wEYosKBEnM/jyPHaJeUOLkzCdgNSICdhLrby1kBrGFBfwkGua8AKsREqiRuP/3HpjN
	KeAqMeEXyEUcQBeJS/Q0BoGEmQV0JN71PWCGsOUltr+dwzyBUWAWkg2zkJTNQlK2gJF5FaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGusV5uZoleakrpJkZIkPLtYGxfL3OIUYCDUYmHd8XBXcFC
	rIllxZW5hxglOZiURHn3/94dLMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE98spoBxvSmJlVWpR
	PkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYL3wB+gRsGi1PTUirTMnBKENBMHJ8hw
	LimR4tS8lNSixNKSjHhQpMYXA2MVJMUDtPcvSDtvcUFiLlAUovUUo6KUOK8WSEIAJJFRmgc3
	FpZ6XjGKA30pzHsWpIoHmLbgul8BDWYCGvz5/Q6QwSWJCCmpBsY+4X+5y2vXXdVSuF/9rODr
	s6SDx9ZrpnxTS5p5a2PjjLVFb39XyT4r+Cj86mpRfOfnVX0GOx/FmZQzTn/L82Hty98KbAFL
	/Hidm1dPv7TvdZLP2sM66/pOueuLFe8VfNeSIzXHpD03UXXebr9bZ8rCDh8smGdh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253026>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Add an err argument to delete_loose_ref so that we can pass a descriptive
> error string back to the caller. Pass the err argument from transaction
> commit to this function so that transaction users will have a nice error
> string if the transaction failed due to delete_loose_ref.
> 
> Add a new function unlink_or_err that we can call from delete_ref_loose. This
> function is similar to unlink_or_warn except that we can pass it an err
> argument. If err is non-NULL the function will populate err instead of
> printing a warning().
> 
> Simplify warn_if_unremovable.

The change to warn_if_unremovable() is orthogonal to the rest of the
commit and should be a separate commit.

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c    | 33 ++++++++++++++++++++++++++++-----
>  wrapper.c | 14 ++++++--------
>  2 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 92a06d4..c7d1f3e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2544,16 +2544,38 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>  	return ret;
>  }
>  
> -static int delete_ref_loose(struct ref_lock *lock, int flag)
> +static int add_err_if_unremovable(const char *op, const char *file,
> +				  struct strbuf *e, int rc)

This function is only used once.  Given also that its purpose is not
that obvious from its signature, it seems to me that the code would be
easier to read if it were inlined.

> +{
> +	int err = errno;
> +	if (rc < 0 && errno != ENOENT) {
> +		strbuf_addf(e, "unable to %s %s: %s",
> +			    op, file, strerror(errno));
> +		errno = err;
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static int unlink_or_err(const char *file, struct strbuf *err)

The name of this function is misleading; it sounds like it will try to
unlink the file and if not possible call error().  Maybe a name like
"unlink_or_report" would be less prejudicial.

It might also make sense to move this function to wrapper.c and
implement unlink_or_warn() in terms of it rather than vice versa.

> +{
> +	if (err)
> +		return add_err_if_unremovable("unlink", file, err,
> +					      unlink(file));
> +	else
> +		return unlink_or_warn(file);
> +}
> +
> +static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>  {
>  	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
>  		/* loose */
> -		int err, i = strlen(lock->lk->filename) - 5; /* .lock */
> +		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
>  
>  		lock->lk->filename[i] = 0;
> -		err = unlink_or_warn(lock->lk->filename);
> +		res = unlink_or_err(lock->lk->filename, err);
>  		lock->lk->filename[i] = '.';
> -		if (err && errno != ENOENT)
> +		if (res)
>  			return 1;
>  	}
>  	return 0;
> @@ -3603,7 +3625,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  		struct ref_update *update = updates[i];
>  
>  		if (update->lock) {
> -			ret |= delete_ref_loose(update->lock, update->type);
> +			ret |= delete_ref_loose(update->lock, update->type,
> +						err);
>  			if (!(update->flags & REF_ISPRUNING))
>  				delnames[delnum++] = update->lock->ref_name;
>  		}
> diff --git a/wrapper.c b/wrapper.c
> index bc1bfb8..740e193 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -429,14 +429,12 @@ int xmkstemp_mode(char *template, int mode)
>  
>  static int warn_if_unremovable(const char *op, const char *file, int rc)
>  {
> -	if (rc < 0) {
> -		int err = errno;
> -		if (ENOENT != err) {
> -			warning("unable to %s %s: %s",
> -				op, file, strerror(errno));
> -			errno = err;
> -		}
> -	}
> +	int err;
> +	if (rc >= 0 || errno == ENOENT)
> +		return rc;
> +	err = errno;
> +	warning("unable to %s %s: %s", op, file, strerror(errno));
> +	errno = err;
>  	return rc;
>  }
>  
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
