From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 22/27] struct ref_update: Rename field "ref_name" to "refname"
Date: Tue, 01 Apr 2014 12:53:57 -0700
Message-ID: <xmqqha6czuzu.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-23-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:54:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4l6-0002Pr-E0
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbaDATyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:54:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40299 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbaDATyA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:54:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 403627901A;
	Tue,  1 Apr 2014 15:54:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=paTmkaECNDQwfxHJ5ky99iiPuxY=; b=X8yTte
	dc8t0EAcWIgA5LFP0FubbSJJ/Tm5snJ4BvXBe/khsENtKU+ZIqYBiOwBHo0ysVSa
	8/9HXZP1Zajr5i5s1PchATs+0xETusUS8myZ38HRzPe/odOJsH3oFRBuOS5QS0mx
	RGmyo6cL4SRFViYIb1vaNrl9EJRzWqOaS8KGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pZ4RIOHO7V6LiBeMc/sZwxO4QkGzRYJ1
	vzx9r6vsQPXshJ+WOv0Wy/BfMX4b0F7+NcjmbrwhqGdt5GCnF1vqHAwNzGF+7odx
	v4OCSMtxOMSR8rzXf+QRjXxlhzdm/gMsUtc+wfj+4FbkIs9Ia35MQWVMgHuLNGNf
	vtzeRZHfS2o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 309F179019;
	Tue,  1 Apr 2014 15:54:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DB9579015;
	Tue,  1 Apr 2014 15:53:59 -0400 (EDT)
In-Reply-To: <1395683820-17304-23-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 24 Mar 2014 18:56:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5DA32612-B9D7-11E3-98A7-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245643>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This is consistent with the usual nomenclature.

I am of two minds.

Looking for "\(\.\|->\)ref_name" used to ignore refname fields of
other structures and let us focus on the ref_update structure.  Yes,
there is the ref_lock structure that shares ref_name to contaminate
such a grep output already, but this change makes the output even
more noisy, as you have to now look for "\(\.\|->\)refname" which
would give you more hits from other unrelated structures.

On the other hand, I do not like to name this to "update_refname" or
some nonsense like that, of course. A reference name field in a
"ref_update" structure shouldn't have to say that it is about
updating in its name; it should be known from the name of the
structure it appears in.

So I dunno.

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 18 +++++++++---------
>  refs.h |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index dfff117..d72d0ab 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3274,7 +3274,7 @@ static int update_ref_write(const char *action, const char *refname,
>   * value or to zero to ensure the ref does not exist before update.
>   */
>  struct ref_update {
> -	const char *ref_name;
> +	const char *refname;
>  	unsigned char new_sha1[20];
>  	unsigned char old_sha1[20];
>  	int flags; /* REF_NODEREF? */
> @@ -3304,7 +3304,7 @@ static void ref_transaction_free(struct ref_transaction *transaction)
>  	for (i = 0; i < transaction->nr; i++) {
>  		struct ref_update *update = transaction->updates[i];
>  
> -		free((char *)update->ref_name);
> +		free((char *)update->refname);
>  		free(update);
>  	}
>  
> @@ -3322,7 +3322,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
>  {
>  	struct ref_update *update = xcalloc(1, sizeof(*update));
>  
> -	update->ref_name = xstrdup(refname);
> +	update->refname = xstrdup(refname);
>  	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
>  	transaction->updates[transaction->nr++] = update;
>  	return update;
> @@ -3383,7 +3383,7 @@ static int ref_update_compare(const void *r1, const void *r2)
>  {
>  	const struct ref_update * const *u1 = r1;
>  	const struct ref_update * const *u2 = r2;
> -	return strcmp((*u1)->ref_name, (*u2)->ref_name);
> +	return strcmp((*u1)->refname, (*u2)->refname);
>  }
>  
>  static int ref_update_reject_duplicates(struct ref_update **updates, int n,
> @@ -3391,14 +3391,14 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>  {
>  	int i;
>  	for (i = 1; i < n; i++)
> -		if (!strcmp(updates[i - 1]->ref_name, updates[i]->ref_name)) {
> +		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
>  			const char *str =
>  				"Multiple updates for ref '%s' not allowed.";
>  			switch (onerr) {
>  			case UPDATE_REFS_MSG_ON_ERR:
> -				error(str, updates[i]->ref_name); break;
> +				error(str, updates[i]->refname); break;
>  			case UPDATE_REFS_DIE_ON_ERR:
> -				die(str, updates[i]->ref_name); break;
> +				die(str, updates[i]->refname); break;
>  			case UPDATE_REFS_QUIET_ON_ERR:
>  				break;
>  			}
> @@ -3435,7 +3435,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  
>  	/* Acquire all locks while verifying old values */
>  	for (i = 0; i < n; i++) {
> -		locks[i] = update_ref_lock(updates[i]->ref_name,
> +		locks[i] = update_ref_lock(updates[i]->refname,
>  					   (updates[i]->have_old ?
>  					    updates[i]->old_sha1 : NULL),
>  					   updates[i]->flags,
> @@ -3450,7 +3450,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  	for (i = 0; i < n; i++)
>  		if (!is_null_sha1(updates[i]->new_sha1)) {
>  			ret = update_ref_write(msg,
> -					       updates[i]->ref_name,
> +					       updates[i]->refname,
>  					       updates[i]->new_sha1,
>  					       locks[i], onerr);
>  			locks[i] = NULL; /* freed by update_ref_write */
> diff --git a/refs.h b/refs.h
> index 99c194b..30ee721 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -154,7 +154,7 @@ extern void unlock_ref(struct ref_lock *lock);
>  extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
>  
>  /** Setup reflog before using. **/
> -int log_ref_setup(const char *ref_name, char *logfile, int bufsize);
> +int log_ref_setup(const char *refname, char *logfile, int bufsize);
>  
>  /** Reads log for the value of ref during at_time. **/
>  extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
