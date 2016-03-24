From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 14/33] refs: add methods to init refs db
Date: Thu, 24 Mar 2016 08:28:44 +0100
Message-ID: <56F3972C.7020901@alum.mit.edu>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-15-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	peff@peff.net, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 24 08:36:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aizoR-0008Hr-Kj
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 08:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbcCXHgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 03:36:07 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61221 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751454AbcCXHgE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 03:36:04 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Mar 2016 03:36:04 EDT
X-AuditID: 12074413-eefff7000000516b-54-56f3972e397f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 3F.A2.20843.E2793F65; Thu, 24 Mar 2016 03:28:46 -0400 (EDT)
Received: from [192.168.69.130] (p548D66F7.dip0.t-ipconnect.de [84.141.102.247])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2O7SiBM012185
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 24 Mar 2016 03:28:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1456793586-22082-15-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqKs3/XOYwZa5GhbzN51gtOi60s1k
	0dB7hdmie8pbRosfLT3MDqweO2fdZfd41ruH0ePiJWWPBc/vs3t83iQXwBrFbZOUWFIWnJme
	p2+XwJ3x5+k/toIO1YrDkzvYGhivyHYxcnJICJhIdP2/xNzFyMUhJLCVUeL9u+uMEM4FJolv
	i5rYQaqEBewlLu78xQxiiwhkS8z5dI4VoqiDUWLGlQeMIAlmATWJ9k1TWEFsNgFdiUU9zUwg
	Nq+AtsTRfd/ABrEIqEpc/NcBNkhUIERi27pvrBA1ghInZz5hAbE5Bbwkju27ywIxU09ix/Vf
	rBC2vMT2t3OYJzDyz0LSMgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW
	6KWmlG5ihISz8A7GXSflDjEKcDAq8fA2cHwOE2JNLCuuzD3EKMnBpCTK+7ESKMSXlJ9SmZFY
	nBFfVJqTWnyIUYKDWUmEl68OKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV
	4eBQkuCtnwbUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KyvhiYFyCpHiA9u4G
	aectLkjMBYpCtJ5iVJQS5/UBSQiAJDJK8+DGwpLUK0ZxoC+Fef9MBariASY4uO5XQIOZgAYv
	9PkEMrgkESEl1cCYm7azOsDllayQWUiRmHfc/Ad7fWKuztmg1ctpY+X1Jl5j4eZn/231mm+G
	njp3ImqCLtMGzlK7xmCtxVpGh3xetalbcddrZBz9teBb3jr71KUGBzVKJ9vF+FhN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289719>

On 03/01/2016 01:52 AM, David Turner wrote:
> Alternate refs backends might not need the refs/heads directory and so
> on, so we make ref db initialization part of the backend.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/init-db.c    | 20 ++++++++++----------
>  refs.c               |  5 +++++
>  refs.h               |  2 ++
>  refs/files-backend.c | 16 ++++++++++++++++
>  refs/refs-internal.h |  2 ++
>  5 files changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 6223b7d..e6d4e86 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -177,13 +177,7 @@ static int create_default_files(const char *template_path)
>  	char junk[2];
>  	int reinit;
>  	int filemode;
> -
> -	/*
> -	 * Create .git/refs/{heads,tags}
> -	 */
> -	safe_create_dir(git_path_buf(&buf, "refs"), 1);
> -	safe_create_dir(git_path_buf(&buf, "refs/heads"), 1);
> -	safe_create_dir(git_path_buf(&buf, "refs/tags"), 1);
> +	struct strbuf err = STRBUF_INIT;
>  
>  	/* Just look for `init.templatedir` */
>  	git_config(git_init_db_config, NULL);
> @@ -207,12 +201,18 @@ static int create_default_files(const char *template_path)
>  	 */
>  	if (shared_repository) {
>  		adjust_shared_perm(get_git_dir());
> -		adjust_shared_perm(git_path_buf(&buf, "refs"));

Given that this function is creating the "refs" directory, it seems like
adjust_shared_perm() should be called for it here, too (rather than in
the backend-specific code).

> -		adjust_shared_perm(git_path_buf(&buf, "refs/heads"));
> -		adjust_shared_perm(git_path_buf(&buf, "refs/tags"));
>  	}
>  
>  	/*
> +	 * We need to create a "refs" dir in any case so that older
> +	 * versions of git can tell that this is a repository.
> +	 */
> +	safe_create_dir(git_path("refs"), 1);
> +
> +	if (refs_init_db(shared_repository, &err))
> +		die("failed to set up refs db: %s", err.buf);
> +
> +	/*
>  	 * Create the default symlink from ".git/HEAD" to the "master"
>  	 * branch, if it does not exist yet.
>  	 */
> diff --git a/refs.c b/refs.c
> index d25eee2..b2697f6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1319,6 +1319,11 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
>  }
>  
>  /* backend functions */
> +int refs_init_db(int shared, struct strbuf *err)
> +{
> +	return the_refs_backend->init_db(shared, err);
> +}
> +
>  int ref_transaction_commit(struct ref_transaction *transaction,
>  			   struct strbuf *err)
>  {
> diff --git a/refs.h b/refs.h
> index 3405842..13ce2a0 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -66,6 +66,8 @@ extern int ref_exists(const char *refname);
>  
>  extern int is_branch(const char *refname);
>  
> +extern int refs_init_db(int shared, struct strbuf *err);
> +
>  /*
>   * If refname is a non-symbolic reference that refers to a tag object,
>   * and the tag can be (recursively) dereferenced to a non-tag object,
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 35328d2..acb4401 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3415,9 +3415,25 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
>  	return -1;
>  }
>  
> +static int files_init_db(int shared, struct strbuf *err)
> +{
> +	/*
> +	 * Create .git/refs/{heads,tags}
> +	 */
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
>  struct ref_storage_be refs_be_files = {
>  	NULL,
>  	"files",
> +	files_init_db,
>  	files_transaction_commit,
>  	files_initial_transaction_commit,
>  
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index beef457..dfd0326 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -211,6 +211,7 @@ int do_for_each_per_worktree_ref(const char *submodule, const char *base,
>  				 void *cb_data);
>  
>  /* refs backends */
> +typedef int ref_init_db_fn(int shared, struct strbuf *err);
>  typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
>  				      struct strbuf *err);
>  
> @@ -255,6 +256,7 @@ typedef int do_for_each_ref_fn(const char *submodule, const char *base,
>  struct ref_storage_be {
>  	struct ref_storage_be *next;
>  	const char *name;
> +	ref_init_db_fn *init_db;
>  	ref_transaction_commit_fn *transaction_commit;
>  	ref_transaction_commit_fn *initial_transaction_commit;
>  
> 

Michael
