From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 3/5] refs: teach for_each_ref a flag to avoid recursion
Date: Wed, 08 Jan 2014 12:29:51 +0100
Message-ID: <52CD36AF.2080705@alum.mit.edu>
References: <20140107235631.GA10503@sigill.intra.peff.net> <20140107235850.GC10657@sigill.intra.peff.net> <20140108034733.GA17198@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 08 12:37:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0rRa-0005z3-79
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 12:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380AbaAHLhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 06:37:01 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:43118 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754960AbaAHLg7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jan 2014 06:36:59 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jan 2014 06:36:59 EST
X-AuditID: 12074411-b7f426d000005455-00-52cd36b5e78e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1F.AB.21589.5B63DC25; Wed,  8 Jan 2014 06:29:57 -0500 (EST)
Received: from [192.168.69.148] (p4FDD47EC.dip0.t-ipconnect.de [79.221.71.236])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s08BTqNK013495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Jan 2014 06:29:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <20140108034733.GA17198@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsUixO6iqLvV7GyQwYFdAhYHXj5lsei60s1k
	0dB7hdmie8pbRosfLT3MDqweO2fdZfd41ruH0ePiJWWPZwdusnl83iQXwBrFbZOUWFIWnJme
	p2+XwJ1x5P10loLvxhUzNhk3MJ7X7GLk5JAQMJH4ub6bBcIWk7hwbz1bFyMXh5DAZUaJ/bdn
	s0A455gkDkyYxghSxSugLfH16Tx2EJtFQFViwaxtzCA2m4CuxKKeZiYQW1QgWGL15QcsEPWC
	EidnPgGzRQRkJb4f3sgIMpRZYAOjxKk/98CGCgv4Sezd85kVYtsMRontF4+DJTgFrCUW7TgF
	1M0BdJ+4RE9jEIjJLKAusX6eEEgFs4C8xPa3c5gnMArOQrJuFkLVLCRVCxiZVzHKJeaU5urm
	JmbmFKcm6xYnJ+blpRbpmurlZpbopaaUbmKEBL7gDsYZJ+UOMQpwMCrx8DaonAkSYk0sK67M
	PcQoycGkJMqbpXM2SIgvKT+lMiOxOCO+qDQntfgQowQHs5IIr54yUI43JbGyKrUoHyYlzcGi
	JM7Lt0TdT0ggPbEkNTs1tSC1CCYrw8GhJMGbYgrUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqX
	klqUWFqSEQ+K3/hiYASDpHiA9l4yAdlbXJCYCxSFaD3FqMsx78uHb4xCLHn5ealS4rylIDsE
	QIoySvPgVsDS3CtGcaCPhXkngVTxAFMk3KRXQEuYgJaExp0CWVKSiJCSamCMTXHQdGFaauin
	e8ducbRe30EVNt+vCoq6y8+qM/6/93b+m2I9x2sB+UqfQ9ZlTZ2bUdO41vzKy7Tj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240209>

On 01/08/2014 04:47 AM, Jeff King wrote:
> On Tue, Jan 07, 2014 at 06:58:50PM -0500, Jeff King wrote:
> 
>> +			if (flags & DO_FOR_EACH_NO_RECURSE) {
>> +				struct ref_dir *subdir = get_ref_dir(entry);
>> +				sort_ref_dir(subdir);
>> +				retval = do_for_each_entry_in_dir(subdir, 0,
> 
> Obviously this is totally wrong and inverts the point of the flag. And
> causes something like half of the test suite to fail.
> 
> Michael was nice enough to point it out to me off-list, but well, I have
> to face the brown paper bag at some point. :) In my defense, it was a
> last minute refactor before going to dinner. That is what I get for
> rushing out the series.
> 
> Here's a fixed version of patch 3/5.

v2 4/5 doesn't apply cleanly on top of v3 3/5.  So I'm basing my review
on the branch you have at GitHub peff/git "jk/cat-file-warn-ambiguous";
I hope it is the same.

> -- >8 --
> Subject: refs: teach for_each_ref a flag to avoid recursion
> 
> The normal for_each_ref traversal descends into

You haven't changed any for_each_ref*() functions; you have only exposed
the DO_FOR_EACH_NO_RECURSE option to the (static) functions
for_each_entry*() and do_for_each_ref().  (This is part and parcel of
your decision not to expose the new functionality in the refs API.)
Please correct the line above.

> subdirectories, returning each ref it finds. However, in
> some cases we may want to just iterate over the top-level of
> a certain part of the tree.
> 
> The introduction of the "flags" option is a little
> mysterious. We already have a "flags" option that gets stuck
> in a callback struct and ends up interpreted in do_one_ref.
> But the traversal itself does not currently have any flags,
> and it needs to know about this new flag.
> 
> We _could_ introduce this as a completely separate flag
> parameter. But instead, we simply put both flag types into a
> single namespace, and make it available at both sites. This
> is simple, and given that we do not have a proliferation of
> flags (we have had exactly one until now), it is probably
> sufficient.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  refs.c | 61 ++++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 3926136..b70b018 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -589,6 +589,8 @@ static void sort_ref_dir(struct ref_dir *dir)
>  
>  /* Include broken references in a do_for_each_ref*() iteration: */
>  #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
> +/* Do not recurse into subdirs, just iterate at a single level. */
> +#define DO_FOR_EACH_NO_RECURSE     0x02
>  
>  /*
>   * Return true iff the reference described by entry can be resolved to
> @@ -661,7 +663,8 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
>   * called for all references, including broken ones.
>   */
>  static int do_for_each_entry_in_dir(struct ref_dir *dir, int offset,
> -				    each_ref_entry_fn fn, void *cb_data)
> +				    each_ref_entry_fn fn, void *cb_data,
> +				    int flags)
>  {
>  	int i;
>  	assert(dir->sorted == dir->nr);

Please update the docstring for this function, which still says that it
recurses without mentioning DO_FOR_EACH_NO_RECURSE.

> [...]
> @@ -817,7 +830,7 @@ static int is_refname_available(const char *refname, const char *oldrefname,
>  	data.conflicting_refname = NULL;
>  
>  	sort_ref_dir(dir);
> -	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
> +	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data, 0)) {
>  		error("'%s' exists; cannot create '%s'",
>  		      data.conflicting_refname, refname);
>  		return 0;
> @@ -1651,7 +1664,8 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
>   * 0.
>   */
>  static int do_for_each_entry(struct ref_cache *refs, const char *base,
> -			     each_ref_entry_fn fn, void *cb_data)
> +			     each_ref_entry_fn fn, void *cb_data,
> +			     int flags)
>  {
>  	struct packed_ref_cache *packed_ref_cache;
>  	struct ref_dir *loose_dir;

A few lines after this, do_for_each_entry() calls
prime_ref_dir(loose_dir) to ensure that all of the loose references that
will be iterated over are read before the packed-refs file is checked.
It seems to me that prime_ref_dir() should also get a flags parameter to
prevent it reading more loose references than necessary, something like
this:

====================================================================
diff --git a/refs.c b/refs.c
index b70b018..b8b7354 100644
--- a/refs.c
+++ b/refs.c
@@ -772,13 +772,13 @@ static int do_for_each_entry_in_dirs(struct
ref_dir *dir1,
  * through all of the sub-directories. We do not even need to care about
  * sorting, as traversal order does not matter to us.
  */
-static void prime_ref_dir(struct ref_dir *dir)
+static void prime_ref_dir(struct ref_dir *dir, int flags)
 {
 	int i;
 	for (i = 0; i < dir->nr; i++) {
 		struct ref_entry *entry = dir->entries[i];
-		if (entry->flag & REF_DIR)
-			prime_ref_dir(get_ref_dir(entry));
+		if (entry->flag & REF_DIR && !(flags & DO_FOR_EACH_NO_RECURSE))
+			prime_ref_dir(get_ref_dir(entry), flags);
 	}
 }
 /*
@@ -1685,7 +1685,7 @@ static int do_for_each_entry(struct ref_cache
*refs, const char *base,
 		loose_dir = find_containing_dir(loose_dir, base, 0);
 	}
 	if (loose_dir)
-		prime_ref_dir(loose_dir);
+		prime_ref_dir(loose_dir, flags);

 	packed_ref_cache = get_packed_ref_cache(refs);
 	acquire_packed_ref_cache(packed_ref_cache);

====================================================================

> [...]
> @@ -1718,7 +1732,7 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
>  	data.fn = fn;
>  	data.cb_data = cb_data;
>  
> -	return do_for_each_entry(refs, base, do_one_ref, &data);
> +	return do_for_each_entry(refs, base, do_one_ref, &data, flags);
>  }
>  
>  static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)

This change makes the DO_FOR_EACH_NO_RECURSE option usable with
do_for_each_ref() (even though it is never in fact used).  It should
either be mentioned in the docstring or (if there is a reason not to
allow it) explicitly prohibited.

> [...]

The rest looks fine to me.

It would be possible to use your new flag to speed up
is_refname_available(), but it would be a little bit of work and I doubt
that is_refname_available() is ever a bottleneck.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
