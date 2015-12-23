From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 08/16] refs: add methods to init refs backend and db
Date: Wed, 23 Dec 2015 06:33:28 +0100
Message-ID: <567A3228.2060407@alum.mit.edu>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-9-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 06:40:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBcAB-0004Kr-Ph
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 06:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020AbbLWFkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 00:40:36 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:60895 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932426AbbLWFkf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Dec 2015 00:40:35 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Dec 2015 00:40:34 EST
X-AuditID: 12074412-f79a76d000007c8b-58-567a322904d4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 10.70.31883.9223A765; Wed, 23 Dec 2015 00:33:30 -0500 (EST)
Received: from [192.168.69.130] (p4FC971CA.dip0.t-ipconnect.de [79.201.113.202])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBN5XSxL006412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 23 Dec 2015 00:33:29 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <1449102921-7707-9-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42IRYndR1NUyqgoz2LeCyWL+phOMFl1Xupkc
	mDwWPL/P7vF5k1wAUxS3TVJiSVlwZnqevl0Cd8bvdT8ZCyYpVCzv38vUwNgi1cXIySEhYCLR
	vvEpC4QtJnHh3nq2LkYuDiGBy4wSz9auBksICVxgkvj3NQfEFhbwkNgx/QMziC0i4CBxeddR
	ZoiGVkaJGRv3s4Mk2AR0JRb1NDNBTJWT6O2eBDaIV0Bbonv3M0YQm0VAVWLmkzVgNaICIRJ7
	d3ZA1QhKnJz5BMzmBFo2e89DsJnMAnoSO67/YoWw5SWat85mnsAoMAtJyywkZbOQlC1gZF7F
	KJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERKqQjsY15+UO8QowMGoxMPr0FYZ
	JsSaWFZcmXuIUZKDSUmUV5e7KkyILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG/6O6By3pTEyqrU
	onyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJ3pcGQEMFi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQbEaXwyMVpAUD9DevyDtvMUFiblAUYjWU4yKUkBbQRICIImM0jy4
	sbAE9IpRHOhLYd7rIFU8wOQF1/0KaDAT0OA/68pBBpckIqSkGhgD7NXjdBem385LMpSX1nM5
	f8HmoIKZrZo3j39m7KYVwq+5K3YaR8bs9ztZ/+PhzjhJ9lP73jxqVry9Sfro3ytS0de2Sk6b
	ubzM9Tn7P5X+2W9nxHaZpllOkt+8ppdPr5LnmvGuNw/5Z/Ds+BLZPYW39P4J82X2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282923>

On 12/03/2015 01:35 AM, David Turner wrote:
> Alternate refs backends might not need the refs/heads directory and so
> on, so we make ref db initialization part of the backend.  We also
> might need to initialize ref backends themselves, so we'll add a
> method for that as well.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/init-db.c    | 14 ++++----------
>  refs.c               |  8 +++++++-
>  refs.h               |  4 +++-
>  refs/files-backend.c | 23 +++++++++++++++++++++++
>  refs/refs-internal.h |  4 ++++
>  5 files changed, 41 insertions(+), 12 deletions(-)
> 
> [...]
> diff --git a/refs.c b/refs.c
> index 9a2fed7..bdeb276 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -22,13 +22,14 @@ struct ref_be *refs_backends = &refs_be_files;
>  /*
>   * This function is used to switch to an alternate backend.
>   */
> -int set_refs_backend(const char *name)
> +int set_refs_backend(const char *name, void *data)

The purpose of the data argument is rather mysterious at this point,
especially since set_refs_backend() still doesn't have any callers. I
hope that will become clearer later in the series. Nevertheless, it
would be nice for its use to be described in the docstring (which should
preferably be moved to the header file).

> [...]
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index e769242..6600c02 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3313,6 +3313,11 @@ static int ref_present(const char *refname,
>  	return string_list_has_string(affected_refnames, refname);
>  }
>  
> +void files_init_backend(void *data)
> +{
> +	/* do nothing */
> +}
> +
>  static int files_initial_transaction_commit(struct ref_transaction *transaction,
>  					    struct strbuf *err)
>  {
> @@ -3534,9 +3539,27 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
>  	return -1;
>  }
>  
> +static int files_init_db(struct strbuf *err, int shared)
> +{
> +	/*
> +	 * Create .git/refs/{heads,tags}
> +	 */
> +	safe_create_dir(git_path("refs"), 1);
> +	safe_create_dir(git_path("refs/heads"), 1);
> +	safe_create_dir(git_path("refs/tags"), 1);
> +	if (shared) {
> +		adjust_shared_perm(git_path("refs"));
> +		adjust_shared_perm(git_path("refs/heads"));
> +		adjust_shared_perm(git_path("refs/tags"));
> +	}
> +	return 0;
> +}
> +
>  struct ref_be refs_be_files = {
>  	NULL,
>  	"files",
> +	files_init_backend,
> +	files_init_db,
>  	files_transaction_commit,
>  	files_initial_transaction_commit,
>  
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 478ad54..85a0b91 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -208,6 +208,8 @@ const char *find_descendant_ref(const char *dirname,
>  int rename_ref_available(const char *oldname, const char *newname);
>  
>  /* refs backends */
> +typedef void ref_backend_init_fn(void *data);
> +typedef int ref_backend_init_db_fn(struct strbuf *err, int shared);
>  typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
>  				      struct strbuf *err);
>  
> @@ -267,6 +269,8 @@ typedef int for_each_replace_ref_fn(each_ref_fn fn, void *cb_data);
>  struct ref_be {
>  	struct ref_be *next;
>  	const char *name;
> +	ref_backend_init_fn *init_backend;
> +	ref_backend_init_db_fn *init_db;
>  	ref_transaction_commit_fn *transaction_commit;
>  	ref_transaction_commit_fn *initial_transaction_commit;
>  
> 

Your naming seems inconsistent here. I would have expected a
"files_init_backend()" function to satisfy the typedef
"ref_backend_init_backend_fn" or "ref_init_backend_fn", not
"ref_backend_init_fn". Or, conversely, for the function implementing
"ref_backend_init_fn" to be called "files_init()".

More generally, it would be nice to have a consistent naming pattern
between (1) the name of the typedef, (2) the name of the member in
"struct ref_be", (3) the names of concrete, backend-specific
implementations of the functions.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
