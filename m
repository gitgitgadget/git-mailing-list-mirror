From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Use ALLOC_GROW() instead of inline code
Date: Thu, 27 Feb 2014 23:11:56 +0100
Message-ID: <530FB82C.70005@alum.mit.edu>
References: <530FA3E7.8020200@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Thu Feb 27 23:12:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ9BX-0005ok-Em
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 23:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbaB0WMC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 17:12:02 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55009 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750999AbaB0WMA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 17:12:00 -0500
X-AuditID: 1207440e-f79c76d000003e2c-13-530fb82f6e0f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id ED.F1.15916.F28BF035; Thu, 27 Feb 2014 17:11:59 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1RMBvEv025367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 17:11:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <530FA3E7.8020200@yandex.ru>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqKu/gz/Y4FqHosXBrafZLbqudDM5
	MHl83iTncbihnyWAKYrbJimxpCw4Mz1P3y6BO2P5hnnsBZvCK/o6drM3MC507WLk5JAQMJFo
	W/GEBcIWk7hwbz1bFyMXh5DAZUaJVZ3vWSGc80wSrSdug1XxCmhKHDs3hR3EZhFQlVjeuwPM
	ZhPQlVjU08wEYosKBEusvvwAql5Q4uRMiA0iAuYSzV9nA9VzcDALiEv0/wMLCwvYSBw6v58R
	xBYS0JCY/WYNI0gJJ9CqNa1uIKYEUHVPYxBIBbOAjsS7vgfMELa8xPa3c5gnMArOQrJrFpKy
	WUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdbLzSzRS00p3cQICV6+HYzt62UOMQpw
	MCrx8E7w5A8WYk0sK67MPcQoycGkJMr7dCtQiC8pP6UyI7E4I76oNCe1+BCjBAezkgiv7xyg
	HG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgtdkO1CjYFFqempFWmZO
	CUKaiYMTZDiXlEhxal5KalFiaUlGPCh644uB8QuS4gHamwfSzltckJgLFIVoPcWoy3G77dcn
	RiGWvPy8VClx3skgRQIgRRmleXArYKnqFaM40MfCvHNAqniAaQ5u0iugJUxAS45K84AsKUlE
	SEk1MAadEjVoFf25aV3sz4mGkzYzJJmF3nt5175c+c6ys5qXyphsvthVHzf/5uS7sM/WWubp
	b5Ys2eRiyzdCJryLt4Rutr7gNq3xUHtgT8iDGetkbpVM5La9bPQtbtPjVovPv5kW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242865>

Dmitry,

That's cool; I never imagined there would be so many sites that could be
cleaned up in this way.

In my opinion, it would be preferable for this patch to be broken into
multiple commits, one for each site (or each file, if a file has
multiple sites that are logically related).  That would make it easier
to review the patches and easier to bisect if we later find a problem.
Please make sure that you note if there are any sites where the
rewritten code doesn't have exactly the same semantics as the original
(I don't know if there are sites like this, but if there are...).  That
helps reviewers focus on the changes that might be "controversial".

[Please leave the other microprojects for other students (I just wrote
an email on this topic).]

Thanks,
Michael

On 02/27/2014 09:45 PM, Dmitry S. Dolzhenko wrote:
> Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@gmail.com>
> ---
>  attr.c                 |  7 +------
>  builtin/pack-objects.c |  7 +------
>  bundle.c               |  6 +-----
>  cache-tree.c           |  6 +-----
>  commit.c               |  8 ++------
>  diff.c                 | 12 ++----------
>  diffcore-rename.c      | 12 ++----------
>  dir.c                  |  5 +----
>  patch-ids.c            |  5 +----
>  read-cache.c           |  9 ++-------
>  reflog-walk.c          | 13 +++----------
>  replace_object.c       |  8 ++------
>  12 files changed, 19 insertions(+), 79 deletions(-)
> 
> diff --git a/attr.c b/attr.c
> index 8d13d70..734222d 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -338,12 +338,7 @@ static void handle_attr_line(struct attr_stack *res,
>  	a = parse_attr_line(line, src, lineno, macro_ok);
>  	if (!a)
>  		return;
> -	if (res->alloc <= res->num_matches) {
> -		res->alloc = alloc_nr(res->num_matches);
> -		res->attrs = xrealloc(res->attrs,
> -				      sizeof(struct match_attr *) *
> -				      res->alloc);
> -	}
> +	ALLOC_GROW(res->attrs, res->num_matches + 1, res->alloc);
>  	res->attrs[res->num_matches++] = a;
>  }
>  
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 541667f..92cbce8 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1156,12 +1156,7 @@ static int check_pbase_path(unsigned hash)
>  	if (0 <= pos)
>  		return 1;
>  	pos = -pos - 1;
> -	if (done_pbase_paths_alloc <= done_pbase_paths_num) {
> -		done_pbase_paths_alloc = alloc_nr(done_pbase_paths_alloc);
> -		done_pbase_paths = xrealloc(done_pbase_paths,
> -					    done_pbase_paths_alloc *
> -					    sizeof(unsigned));
> -	}
> +	ALLOC_GROW(done_pbase_paths, done_pbase_paths_num + 1, done_pbase_paths_alloc);
>  	done_pbase_paths_num++;
>  	if (pos < done_pbase_paths_num)
>  		memmove(done_pbase_paths + pos + 1,
> diff --git a/bundle.c b/bundle.c
> index e99065c..1388a3e 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -14,11 +14,7 @@ static const char bundle_signature[] = "# v2 git bundle\n";
>  static void add_to_ref_list(const unsigned char *sha1, const char *name,
>  		struct ref_list *list)
>  {
> -	if (list->nr + 1 >= list->alloc) {
> -		list->alloc = alloc_nr(list->nr + 1);
> -		list->list = xrealloc(list->list,
> -				list->alloc * sizeof(list->list[0]));
> -	}
> +	ALLOC_GROW(list->list, list->nr + 1, list->alloc);
>  	memcpy(list->list[list->nr].sha1, sha1, 20);
>  	list->list[list->nr].name = xstrdup(name);
>  	list->nr++;
> diff --git a/cache-tree.c b/cache-tree.c
> index 0bbec43..30149d1 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -75,11 +75,7 @@ static struct cache_tree_sub *find_subtree(struct cache_tree *it,
>  		return NULL;
>  
>  	pos = -pos-1;
> -	if (it->subtree_alloc <= it->subtree_nr) {
> -		it->subtree_alloc = alloc_nr(it->subtree_alloc);
> -		it->down = xrealloc(it->down, it->subtree_alloc *
> -				    sizeof(*it->down));
> -	}
> +	ALLOC_GROW(it->down, it->subtree_nr + 1, it->subtree_alloc);
>  	it->subtree_nr++;
>  
>  	down = xmalloc(sizeof(*down) + pathlen + 1);
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..e004314 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -147,12 +147,8 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
>  		return 1;
>  	}
>  	pos = -pos - 1;
> -	if (commit_graft_alloc <= ++commit_graft_nr) {
> -		commit_graft_alloc = alloc_nr(commit_graft_alloc);
> -		commit_graft = xrealloc(commit_graft,
> -					sizeof(*commit_graft) *
> -					commit_graft_alloc);
> -	}
> +	ALLOC_GROW(commit_graft, commit_graft_nr + 1, commit_graft_alloc);
> +	commit_graft_nr++;
>  	if (pos < commit_graft_nr)
>  		memmove(commit_graft + pos + 1,
>  			commit_graft + pos,
> diff --git a/diff.c b/diff.c
> index 8e4a6a9..f5f0fd1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1361,11 +1361,7 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
>  {
>  	struct diffstat_file *x;
>  	x = xcalloc(sizeof (*x), 1);
> -	if (diffstat->nr == diffstat->alloc) {
> -		diffstat->alloc = alloc_nr(diffstat->alloc);
> -		diffstat->files = xrealloc(diffstat->files,
> -				diffstat->alloc * sizeof(x));
> -	}
> +	ALLOC_GROW(diffstat->files, diffstat->nr + 1, diffstat->alloc);
>  	diffstat->files[diffstat->nr++] = x;
>  	if (name_b) {
>  		x->from_name = xstrdup(name_a);
> @@ -3965,11 +3961,7 @@ struct diff_queue_struct diff_queued_diff;
>  
>  void diff_q(struct diff_queue_struct *queue, struct diff_filepair *dp)
>  {
> -	if (queue->alloc <= queue->nr) {
> -		queue->alloc = alloc_nr(queue->alloc);
> -		queue->queue = xrealloc(queue->queue,
> -					sizeof(dp) * queue->alloc);
> -	}
> +	ALLOC_GROW(queue->queue, queue->nr + 1, queue->alloc);
>  	queue->queue[queue->nr++] = dp;
>  }
>  
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 6c7a72f..f54d5bf 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -38,11 +38,7 @@ static struct diff_rename_dst *locate_rename_dst(struct diff_filespec *two,
>  	if (!insert_ok)
>  		return NULL;
>  	/* insert to make it at "first" */
> -	if (rename_dst_alloc <= rename_dst_nr) {
> -		rename_dst_alloc = alloc_nr(rename_dst_alloc);
> -		rename_dst = xrealloc(rename_dst,
> -				      rename_dst_alloc * sizeof(*rename_dst));
> -	}
> +	ALLOC_GROW(rename_dst, rename_dst_nr + 1, rename_dst_alloc);
>  	rename_dst_nr++;
>  	if (first < rename_dst_nr)
>  		memmove(rename_dst + first + 1, rename_dst + first,
> @@ -82,11 +78,7 @@ static struct diff_rename_src *register_rename_src(struct diff_filepair *p)
>  	}
>  
>  	/* insert to make it at "first" */
> -	if (rename_src_alloc <= rename_src_nr) {
> -		rename_src_alloc = alloc_nr(rename_src_alloc);
> -		rename_src = xrealloc(rename_src,
> -				      rename_src_alloc * sizeof(*rename_src));
> -	}
> +	ALLOC_GROW(rename_src, rename_src_nr + 1, rename_src_alloc);
>  	rename_src_nr++;
>  	if (first < rename_src_nr)
>  		memmove(rename_src + first + 1, rename_src + first,
> diff --git a/dir.c b/dir.c
> index b35b633..72f6e2a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1329,13 +1329,10 @@ static struct path_simplify *create_simplify(const char **pathspec)
>  
>  	for (nr = 0 ; ; nr++) {
>  		const char *match;
> -		if (nr >= alloc) {
> -			alloc = alloc_nr(alloc);
> -			simplify = xrealloc(simplify, alloc * sizeof(*simplify));
> -		}
>  		match = *pathspec++;
>  		if (!match)
>  			break;
> +		ALLOC_GROW(simplify, nr + 1, alloc);
>  		simplify[nr].path = match;
>  		simplify[nr].len = simple_length(match);
>  	}
> diff --git a/patch-ids.c b/patch-ids.c
> index bc8a28f..bf81b92 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -83,10 +83,7 @@ static struct patch_id *add_commit(struct commit *commit,
>  	ent = &bucket->bucket[bucket->nr++];
>  	hashcpy(ent->patch_id, sha1);
>  
> -	if (ids->alloc <= ids->nr) {
> -		ids->alloc = alloc_nr(ids->nr);
> -		ids->table = xrealloc(ids->table, sizeof(ent) * ids->alloc);
> -	}
> +	ALLOC_GROW(ids->table, ids->nr + 1, ids->alloc);
>  	if (pos < ids->nr)
>  		memmove(ids->table + pos + 1, ids->table + pos,
>  			sizeof(ent) * (ids->nr - pos));
> diff --git a/read-cache.c b/read-cache.c
> index 33dd676..e585541 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -993,11 +993,7 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
>  	}
>  
>  	/* Make sure the array is big enough .. */
> -	if (istate->cache_nr == istate->cache_alloc) {
> -		istate->cache_alloc = alloc_nr(istate->cache_alloc);
> -		istate->cache = xrealloc(istate->cache,
> -					istate->cache_alloc * sizeof(*istate->cache));
> -	}
> +	ALLOC_GROW(istate->cache, istate->cache_nr + 1, istate->cache_alloc);
>  
>  	/* Add it in.. */
>  	istate->cache_nr++;
> @@ -1466,8 +1462,7 @@ int read_index_from(struct index_state *istate, const char *path)
>  
>  	istate->version = ntohl(hdr->hdr_version);
>  	istate->cache_nr = ntohl(hdr->hdr_entries);
> -	istate->cache_alloc = alloc_nr(istate->cache_nr);
> -	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
> +	ALLOC_GROW(istate->cache, istate->cache_nr, istate->cache_alloc);
>  	istate->initialized = 1;
>  
>  	if (istate->version == 4)
> diff --git a/reflog-walk.c b/reflog-walk.c
> index b2fbdb2..879d2ed 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -26,11 +26,7 @@ static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
>  	struct complete_reflogs *array = cb_data;
>  	struct reflog_info *item;
>  
> -	if (array->nr >= array->alloc) {
> -		array->alloc = alloc_nr(array->nr + 1);
> -		array->items = xrealloc(array->items, array->alloc *
> -			sizeof(struct reflog_info));
> -	}
> +	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
>  	item = array->items + array->nr;
>  	memcpy(item->osha1, osha1, 20);
>  	memcpy(item->nsha1, nsha1, 20);
> @@ -114,11 +110,8 @@ static void add_commit_info(struct commit *commit, void *util,
>  		struct commit_info_lifo *lifo)
>  {
>  	struct commit_info *info;
> -	if (lifo->nr >= lifo->alloc) {
> -		lifo->alloc = alloc_nr(lifo->nr + 1);
> -		lifo->items = xrealloc(lifo->items,
> -			lifo->alloc * sizeof(struct commit_info));
> -	}
> +
> +	ALLOC_GROW(lifo->items, lifo->nr + 1, lifo->alloc);
>  	info = lifo->items + lifo->nr;
>  	info->commit = commit;
>  	info->util = util;
> diff --git a/replace_object.c b/replace_object.c
> index cdcaf8c..843deef 100644
> --- a/replace_object.c
> +++ b/replace_object.c
> @@ -36,12 +36,8 @@ static int register_replace_object(struct replace_object *replace,
>  		return 1;
>  	}
>  	pos = -pos - 1;
> -	if (replace_object_alloc <= ++replace_object_nr) {
> -		replace_object_alloc = alloc_nr(replace_object_alloc);
> -		replace_object = xrealloc(replace_object,
> -					  sizeof(*replace_object) *
> -					  replace_object_alloc);
> -	}
> +	ALLOC_GROW(replace_object, replace_object_nr + 1, replace_object_alloc);
> +	replace_object_nr++;
>  	if (pos < replace_object_nr)
>  		memmove(replace_object + pos + 1,
>  			replace_object + pos,
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
