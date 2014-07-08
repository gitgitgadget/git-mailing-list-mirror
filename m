From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 20/48] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Tue, 08 Jul 2014 13:48:52 +0200
Message-ID: <53BBDAA4.7020701@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-21-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 13:56:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4U08-00045f-Vo
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 13:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbaGHLz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 07:55:57 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:49060 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754250AbaGHLz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 07:55:56 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jul 2014 07:55:55 EDT
X-AuditID: 12074412-f792e6d000005517-2f-53bbdaa65fad
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D7.DC.21783.6AADBB35; Tue,  8 Jul 2014 07:48:54 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68BmqxS028704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 07:48:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-21-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLvs1u5gg/nbhC26rnQzWfybUOPA
	5LFgU6nH501yAUxR3DZJiSVlwZnpefp2CdwZbR3NzAUnVSsuvZzG3sDYL9vFyMEhIWAi8eyC
	ahcjJ5ApJnHh3nq2LkYuDiGBy4wSm2YfZodwzjNJPJh/gwWkildAW+LN0ttMIDaLgKrE7BOX
	2UFsNgFdiUU9zWBxUYEgidmf57FD1AtKnJz5BKxXRMBOYv2thcwgtrBArsT/w3/B4kICNRLN
	186ygdicAq4SN1e9ZYY4TlyipzEIJMwsoCPxru8BM4QtL7H97RzmCYwCs5BsmIWkbBaSsgWM
	zKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQkJUaAfj+pNyhxgFOBiVeHhX
	HNwVLMSaWFZcmXuIUZKDSUmU9+jx3cFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHi/nALK8aYk
	VlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2CyWpwcAhcOXhkNqMUS15+XqqSBK/zTaAh
	gkWp6akVaZk5JQilTBycIIu4pESKU/NSUosSS0sy4kHxG18MjGCQFA/QDXwg7bzFBYm5QFGI
	1lOMilLivA9vACUEQBIZpXlwY2EJ6RWjONDHwrzSIO08wGQG1/0KaDAT0ODP73eADC5JREhJ
	NTBOqN12xmCR4sf9q1ulj/yu+PvP04jnzvokiXdRn54f/iG/RHb/jXmdfQsOrKk8pVeVxHb7
	/tmad6H5J78HsQvc4Vitt8vuR7OYaJTt2+J/jFLX51gezCgLkPku8//h050T7oXN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253014>

I'm in my next attempt to get through your patch series.  Sorry for the
long hiatus.

Patches 1-19 look OK aside from a minor typo that I just reported.

See below for a comment on this patch.

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Do basic error checking in ref_transaction_create() and make it return
> non-zero on error. Update all callers to check the result of
> ref_transaction_create(). There are currently no conditions in _create that
> will return error but there will be in the future. Add an err argument that
> will be updated on failure.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/update-ref.c |  4 +++-
>  refs.c               | 18 +++++++++++------
>  refs.h               | 55 +++++++++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 63 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 3067b11..41121fa 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -226,7 +226,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("create %s: extra input: %s", refname, next);
>  
> -	ref_transaction_create(transaction, refname, new_sha1, update_flags);
> +	if (ref_transaction_create(transaction, refname, new_sha1,
> +				   update_flags, &err))
> +		die("%s", err.buf);
>  
>  	update_flags = 0;
>  	free(refname);
> diff --git a/refs.c b/refs.c
> index 3f05e88..c49f1c6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3449,18 +3449,24 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  	return 0;
>  }
>  
> -void ref_transaction_create(struct ref_transaction *transaction,
> -			    const char *refname,
> -			    const unsigned char *new_sha1,
> -			    int flags)
> +int ref_transaction_create(struct ref_transaction *transaction,
> +			   const char *refname,
> +			   const unsigned char *new_sha1,
> +			   int flags,
> +			   struct strbuf *err)
>  {
> -	struct ref_update *update = add_update(transaction, refname);
> +	struct ref_update *update;
> +
> +	if (!new_sha1 || is_null_sha1(new_sha1))
> +		die("BUG: create ref with null new_sha1");
> +
> +	update = add_update(transaction, refname);
>  
> -	assert(!is_null_sha1(new_sha1));
>  	hashcpy(update->new_sha1, new_sha1);
>  	hashclr(update->old_sha1);
>  	update->flags = flags;
>  	update->have_old = 1;
> +	return 0;
>  }
>  
>  void ref_transaction_delete(struct ref_transaction *transaction,
> diff --git a/refs.h b/refs.h
> index c5376ce..33b4383 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -10,6 +10,45 @@ struct ref_lock {
>  	int force_write;
>  };
>  
> +/*
> + * A ref_transaction represents a collection of ref updates
> + * that should succeed or fail together.
> + *
> + * Calling sequence
> + * ----------------
> + * - Allocate and initialize a `struct ref_transaction` by calling
> + *   `ref_transaction_begin()`.
> + *
> + * - List intended ref updates by calling functions like
> + *   `ref_transaction_update()` and `ref_transaction_create()`.
> + *
> + * - Call `ref_transaction_commit()` to execute the transaction.
> + *   If this succeeds, the ref updates will have taken place and
> + *   the transaction cannot be rolled back.
> + *
> + * - At any time call `ref_transaction_free()` to discard the
> + *   transaction and free associated resources.  In particular,
> + *   this rolls back the transaction if it has not been
> + *   successfully committed.
> + *
> + * Error handling
> + * --------------
> + *
> + * On error, transaction functions append a message about what
> + * went wrong to the 'err' argument.  The message mentions what
> + * ref was being updated (if any) when the error occurred so it
> + * can be passed to 'die' or 'error' as-is.
> + *
> + * The message is appended to err without first clearing err.
> + * This allows the caller to prepare preamble text to the generated
> + * error message:
> + *
> + *     strbuf_addf(&err, "Error while doing foo-bar: ");
> + *     if (ref_transaction_update(..., &err)) {
> + *         ret = error("%s", err.buf);
> + *         goto cleanup;
> + *     }
> + */

I don't have a problem with the API, but I think the idiom suggested in
the comment above is a bit silly.  Surely one would do the following
instead:

    if (ref_transaction_update(..., &err)) {
        ret = error("Error while doing foo-bar: %s", err.buf);
        goto cleanup;
    }

I think it would also be helpful to document whether the error string
that is appended to the strbuf is terminated with a LF.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
