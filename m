From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v13 05/12] ref-filter: add option to filter out tags,
 branches and remotes
Date: Wed, 26 Aug 2015 18:10:03 +0200
Message-ID: <55DDE4DB.2070504@alum.mit.edu>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com> <1440214788-1309-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 26 18:10:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUdHE-0002Ox-0E
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 18:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757106AbbHZQKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 12:10:09 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53921 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757102AbbHZQKH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2015 12:10:07 -0400
X-AuditID: 1207440e-f79516d0000012b3-4d-55dde4de1482
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id FD.42.04787.ED4EDD55; Wed, 26 Aug 2015 12:10:06 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97375.dip0.t-ipconnect.de [79.201.115.117])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7QGA3WE020510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 26 Aug 2015 12:10:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1440214788-1309-6-git-send-email-Karthik.188@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqHvvyd1Qg7WN3Ba3Z7YwW3Rd6Way
	aOi9wmwxe8sGNotLn9ezOrB67Jx1l91j4pfjrB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8Cd
	sX+rdsH7oIp5l1oZGxjXOnYxcnJICJhI3Pq2lR3CFpO4cG89WxcjF4eQwGVGidbFm5ghnAtM
	EhcnP2UDqeIV0JbYeecYaxcjBweLgKrEii+hIGE2AV2JRT3NTCC2qECQxIrlLxghygUlTs58
	wgJiiwjYSUyZdBBsDLNAhMSfpl9sIGOEBRIkDh9KAgkLCdRK3F0IsYlTwFXizaqJLBDlehI7
	rv9ihbDlJZq3zmaewCgwC8mGWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gv
	N7NELzWldBMjJKj5djC2r5c5xCjAwajEwyvRfjdUiDWxrLgy9xCjJAeTkiivzyOgEF9Sfkpl
	RmJxRnxRaU5q8SFGCQ5mJRHellNAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQi
	mKwMB4eSBG/SY6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCUxhcD4xQkxQO0
	Nx2knbe4IDEXKArReopRUUqclxEkIQCSyCjNgxsLS1WvGMWBvhTmnQhSxQNMc3Ddr4AGMwEN
	fhkPNrgkESEl1cDYcKtk7tzCVRGX+3iPMjV2u0Qa6b7eYz5bLVr31J6sCv+19kH7Vk5ZtbzI
	Nf2sneh3908rOi5N5MoX/7F9y+u/x1N+19ptVf97vDjr0ZkfrkIxV3ctN35nE6vh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276615>

Comments inline.

On 08/22/2015 05:39 AM, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
> 
> Add a function called 'for_each_reftype_fullpath()' to refs.{c,h}
> which iterates through each ref for the given path without trimming
> the path and also accounting for broken refs, if mentioned.
> 
> Add 'filter_ref_kind()' in ref-filter.c to check the kind of ref being
> handled and return the kind to 'ref_filter_handler()', where we
> discard refs which we do not need and assign the kind to needed refs.
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  ref-filter.h | 12 ++++++++++--
>  refs.c       |  9 +++++++++
>  refs.h       |  1 +
>  4 files changed, 74 insertions(+), 7 deletions(-)
> 
> diff --git a/ref-filter.c b/ref-filter.c
> index ffec10a..d5fae1a 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1123,6 +1123,36 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
>  	return ref;
>  }
>  
> +static int filter_ref_kind(struct ref_filter *filter, const char *refname)
> +{
> +	unsigned int i;
> +
> +	static struct {
> +		const char *prefix;
> +		unsigned int kind;
> +	} ref_kind[] = {
> +		{ "refs/heads/" , FILTER_REFS_BRANCHES },
> +		{ "refs/remotes/" , FILTER_REFS_REMOTES },
> +		{ "refs/tags/", FILTER_REFS_TAGS}
> +	};
> +
> +	if (filter->kind == FILTER_REFS_BRANCHES)
> +		return FILTER_REFS_BRANCHES;
> +	else if (filter->kind == FILTER_REFS_REMOTES)
> +		return FILTER_REFS_REMOTES;
> +	else if (filter->kind == FILTER_REFS_TAGS)
> +		return FILTER_REFS_TAGS;
> +	else if (!strcmp(refname, "HEAD"))
> +		return FILTER_REFS_DETACHED_HEAD;

I think this would be clearer written like so:

    if (filter->kind == FILTER_REFS_BRANCHES ||
        filter->kind == FILTER_REFS_REMOTES ||
        filter->kind == FILTER_REFS_TAGS)
            return filter->kind;
    if (!strcmp(refname, "HEAD"))
            return FILTER_REFS_DETACHED_HEAD;

Or, even better, if you can set filter->kind to zero if it is not one of
these constants, then you could simplify this to

    if (filter->kind)
            return filter->kind;
    if (!strcmp(refname, "HEAD"))
            return FILTER_REFS_DETACHED_HEAD;

> +
> +	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
> +		if (starts_with(refname, ref_kind[i].prefix))
> +			return ref_kind[i].kind;
> +	}
> +
> +	return FILTER_REFS_OTHERS;
> +}
> +
>  /*
>   * A call-back given to for_each_ref().  Filter refs and keep them for
>   * later object processing.
> @@ -1133,6 +1163,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>  	struct ref_filter *filter = ref_cbdata->filter;
>  	struct ref_array_item *ref;
>  	struct commit *commit = NULL;
> +	unsigned int kind;
>  
>  	if (flag & REF_BAD_NAME) {
>  		warning("ignoring ref with broken name %s", refname);
> @@ -1144,6 +1175,10 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>  		return 0;
>  	}
>  
> +	kind = filter_ref_kind(filter, refname);
> +	if (!(kind & filter->kind))
> +		return 0;
> +
>  	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
>  		return 0;
>  
> @@ -1175,6 +1210,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>  
>  	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
>  	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
> +	ref->kind = kind;
>  	return 0;
>  }
>  
> @@ -1251,16 +1287,29 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
>  {
>  	struct ref_filter_cbdata ref_cbdata;
>  	int ret = 0;
> +	unsigned int broken = 0;
>  
>  	ref_cbdata.array = array;
>  	ref_cbdata.filter = filter;
>  
>  	/*  Simple per-ref filtering */
> -	if (type & (FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN))
> -		ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
> -	else if (type & FILTER_REFS_ALL)
> -		ret = for_each_ref(ref_filter_handler, &ref_cbdata);
> -	else if (type)
> +	if (type & FILTER_REFS_INCLUDE_BROKEN) {
> +		type &= ~FILTER_REFS_INCLUDE_BROKEN;
> +		broken = 1;
> +	}

I wouldn't mask out the FILTER_REFS_INCLUDE_BROKEN bit here. Instead I
would write

> +
> +	filter->kind = type;

as

        filter->kind = type & FILTER_REFS_KIND_MASK;

where FILTER_REFS_KIND_MASK is the OR of all of the kind bits. The
advantage is that this approach would remain correct if more bits are
added to type. Then in the following if statements, test filter->kind
instead of type.

> +	if (type == FILTER_REFS_BRANCHES)
> +		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/heads/", broken, &ref_cbdata);
> +	else if (type == FILTER_REFS_REMOTES)
> +		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/remotes/", broken, &ref_cbdata);
> +	else if (type == FILTER_REFS_TAGS)
> +		ret = for_each_reftype_fullpath(ref_filter_handler, "refs/tags/", broken, &ref_cbdata);
> +	else if (type & FILTER_REFS_ALL) {
> +		ret = for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);
> +		if (type & FILTER_REFS_DETACHED_HEAD)
> +			head_ref(ref_filter_handler, &ref_cbdata);

The usual promise of the for_each_ref functions is that they stop
iterating if the function ever returns a nonzero value. So the above
should be

                if (! ret && (type & FILTER_REFS_DETACHED_HEAD))
                        ret = head_ref(ref_filter_handler, &ref_cbdata);

Also, these functions usually iterate in lexicographic order, so I think
you should process HEAD before the others.

But there's another problem here. It seems like
FILTER_REFS_DETACHED_HEAD is only processed if (type & FILTER_REFS_ALL)
is nonzero. But shouldn't it be allowed to process *only* HEAD?

So, finally, I think this code should look like

        else if (!filter->kind)
                die("filter_refs: invalid type");
        else {
                if (filter->kind & FILTER_REFS_DETACHED_HEAD)
                        ret = head_ref(ref_filter_handler, &ref_cbdata);
                if (! ret && (filter->kind & FILTER_REFS_ALL))
                        ret =
for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);
        }

> +	} else
>  		die("filter_refs: invalid type");
>  
>  	/*  Filters that need revision walking */
> diff --git a/ref-filter.h b/ref-filter.h
> index 45026d0..99f081b 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -13,8 +13,14 @@
>  #define QUOTE_PYTHON 4
>  #define QUOTE_TCL 8
>  
> -#define FILTER_REFS_INCLUDE_BROKEN 0x1
> -#define FILTER_REFS_ALL 0x2
> +#define FILTER_REFS_INCLUDE_BROKEN 0x0001
> +#define FILTER_REFS_TAGS           0x0002
> +#define FILTER_REFS_BRANCHES       0x0004
> +#define FILTER_REFS_REMOTES        0x0008
> +#define FILTER_REFS_OTHERS         0x0010
> +#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
> +				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
> +#define FILTER_REFS_DETACHED_HEAD  0x0020

Do you expect it to be useful to OR these bits together, or will (in
practice) all callers want to iterate over one or the other type of
reference, or all references? I ask because allowing an arbitrary
bitmask complicates the code a bit (otherwise filter_ref_kind() wouldn't
be needed).

If there is code that wants to iterate over, say, branches *and* tags,
then maybe it is an acceptable imposition for it to make two function calls,

    for_each_reftype_fullpath(fn, "refs/heads/", broken, cb_data) ||
    for_each_reftype_fullpath(fn, "refs/tags/", broken, cb_data);

which might even be a bit more efficient because it only has to iterate
over those two namespaces rather than all references.

But the more flexible bitmask code is not a lot of extra overhead, so if
you think it will have a use case then it is fine to keep this interface.

>  
>  struct atom_value;
>  
> @@ -27,6 +33,7 @@ struct ref_sorting {
>  struct ref_array_item {
>  	unsigned char objectname[20];
>  	int flag;
> +	unsigned int kind;
>  	const char *symref;
>  	struct commit *commit;
>  	struct atom_value *value;
> @@ -51,6 +58,7 @@ struct ref_filter {
>  	struct commit *merge_commit;
>  
>  	unsigned int with_commit_tag_algo : 1;
> +	unsigned int kind;
>  };
>  
>  struct ref_filter_cbdata {
> diff --git a/refs.c b/refs.c
> index 4e15f60..3266617 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2150,6 +2150,15 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
>  			       strlen(git_replace_ref_base), 0, cb_data);
>  }
>  
> +int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
> +{
> +	unsigned int flag = 0;
> +
> +	if (broken)
> +		flag = DO_FOR_EACH_INCLUDE_BROKEN;
> +	return do_for_each_ref(&ref_cache, type, fn, 0, flag, cb_data);
> +}
> +
>  int head_ref_namespaced(each_ref_fn fn, void *cb_data)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> diff --git a/refs.h b/refs.h
> index e9a5f32..6e913ee 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -179,6 +179,7 @@ extern int for_each_remote_ref(each_ref_fn fn, void *cb_data);
>  extern int for_each_replace_ref(each_ref_fn fn, void *cb_data);
>  extern int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
>  extern int for_each_glob_ref_in(each_ref_fn fn, const char *pattern, const char *prefix, void *cb_data);
> +extern int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data);

This function is most like for_each_ref_in(prefix, fn, cb_data).
Therefore, I suggest that you rename the "type" parameter" to "prefix",
maybe reorder its arguments, and maybe rename it (to
for_each_fullref_in()?) for consistency, and maybe put its declaration
next to that function's. (I see that the argument orders among these
functions are already pretty inconsistent, but it seems best to be
consistent with the function that is most similar to it.)

I think the "type"/"prefix" argument can be "const char *".

>  
>  extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
>  extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
