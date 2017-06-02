Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BD4720D11
	for <e@80x24.org>; Fri,  2 Jun 2017 04:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750772AbdFBEsi (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 00:48:38 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32768 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdFBEsi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 00:48:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id f27so11115168pfe.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 21:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Xu8cHwpKiVdrE92dlKQQqIQVY8OYHZyCmjFurr/PHYo=;
        b=OyE8B7RWLL0KJvUO2+x6yER9WwQyLxhsYJdnYnGWBtaXet/rP0t4ytA+Zkrj+3GWWw
         HRESgEjzJxeWxUqRRAk0nh8AYI9GHIYChqGBK6K9XYTfJs3SRzqGAPwc8sUD6b61PhHz
         Wm+XWeyaSY3yJRRuAz3fe7igARPnlGUGeOIgmy71tSstJ8YgABSeMEaBCdmq8WV3mXBU
         BFv9FZSFcQjUVij60aaVHZkUC/qveNboWImoOW/N/rvZR1S2ttQDNcSVfWByb+kjmSHh
         UTIyRl+5wEyyS/7Zemu2UtE0gr4ia4r5C6ZUfBGi4h3PV1Ry0RI8V3xnCHbjDlL3oLoR
         5aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Xu8cHwpKiVdrE92dlKQQqIQVY8OYHZyCmjFurr/PHYo=;
        b=mEXwzVH7eMRmszLpXJRiqw1GLnihKZfC18gr8pWYNlh6ho1I37BGTyyOpj2kjYUxU1
         txpM9u7jRKK9M621ZdLIVYccuwKDs/DBlOIlBxN4oVnYlzIEtLXezEazR0Eq2ItVKzgg
         w7Wf5Fn9d1oej/YKq0yn7lieUL75epqa5jriobJIdoXoGABeTpN1X36y8b3Pcp9PxVyR
         QO+UP7a29i18oL8Oqy2v4VF6fWM0uCxAFWyW3d/cEQVIZsU0uOgYLPWDI/SKEvhw2OkQ
         zfCgIcnOmu5WB2/Crcvra3QeGRSjoDmPnmagAVvxGrkC4oRcPxEeqsyHRF6Tzih1TfXN
         j8JQ==
X-Gm-Message-State: AODbwcBRD00YhdICAqyTnlE0qNVpuSwbQpRd9x+mHpVNWxs68p6KzRM6
        GAEqd7Hdd/iqQg==
X-Received: by 10.101.90.199 with SMTP id d7mr5183952pgt.227.1496378916958;
        Thu, 01 Jun 2017 21:48:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id b2sm32350631pgc.16.2017.06.01.21.48.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 21:48:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [WIP 2/2] pack-objects: support --blob-size-limit
References: <cover.1496361873.git.jonathantanmy@google.com>
        <cover.1496361873.git.jonathantanmy@google.com>
        <07c7139d1cbc2b3acf73c4df14d3cf1dde955720.1496361873.git.jonathantanmy@google.com>
Date:   Fri, 02 Jun 2017 13:48:33 +0900
In-Reply-To: <07c7139d1cbc2b3acf73c4df14d3cf1dde955720.1496361873.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 1 Jun 2017 17:14:55 -0700")
Message-ID: <xmqqmv9ryoym.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index 8973510a4..c4257cacc 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -12,7 +12,8 @@ SYNOPSIS
>  'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
>  	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
>  	[--local] [--incremental] [--window=<n>] [--depth=<n>]
> -	[--revs [--unpacked | --all]] [--stdout | base-name]
> +	[--revs [--unpacked | --all]]
> +	[--stdout [--blob-size-limit=<n>] | base-name]
>  	[--shallow] [--keep-true-parents] < object-list
>  
>  
> @@ -231,6 +232,22 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
>  	With this option, parents that are hidden by grafts are packed
>  	nevertheless.
>  
> +--blob-size-limit=<n>::
> +	This option can only be used with --stdout. If specified, a blob
> +	of at least this size will not be packed unless a to-be-packed
> +	tree has that blob with a filename beginning with ".git".
> +	The size can be suffixed with "k", "m", or "g", and may be "0".

It would be nice if the name of the parameter hints that this is
counted in bytes, e.g. "--blob-max-bytes"; 

Or at least s/<n>/<bytes>/.

> ++
> +If specified, after printing the packfile, pack-objects will print the
> +count of excluded blobs (8 bytes) . Subsequently, for each excluded blob
> +in hash order, pack-objects will print its hash (20 bytes) and its size
> +(8 bytes). All numbers are in network byte order.

Do we need to future-proof the output format so that we can later
use 32-byte hash?  The input to pack-objects (i.e. rev-list --objects)
is hexadecimal text, and it may not be so bad to make this also
text, e.g. "<hash> SP <length> LF".  That way, you do not have to
worry about byte order, hash size, or length limited to uint64.

Right now, the readers of a pack stream like unpack-objects and
index-pack know to copy any "garbage" that follow a pack stream to
its standard output, so older readers piped downstream of this new
pack-objects will simply accept the (somewhat incomplete) pack and
ignore this trailer, which is probably what we want to happen.

> ++
> +If pack-objects cannot efficiently determine, for an arbitrary blob,
> +that no to-be-packed tree has that blob with a filename beginning with
> +".git" (for example, if bitmaps are used to calculate the objects to be
> +packed), it will pack all blobs regardless of size.
> +

This is a bit hard to understand, at least to me.  Let me step-wise
deconstruct what I think you are saying.

 - A blob can appear in multiple trees, and each tree has name
   (i.e. pathname component) for the blob.

 - Sometimes we may know _all_ trees that contain a particular
   blob and hence _all_ names these trees call this blob.  In such a
   case, we can _prove_ that the blob never is used as ".git<something>"
   in any tree.

 - We exclude a blob that is larger than the specified limit, but
   only when we can prove the above.  If it is possible that the
   blob might appear as ".git<something>" in some tree, the blob is
   not omitted no matter its size.

And this is a very conservative way to avoid omitting something that
could be one of those control files like ".gitignore".

Am I following your thought correctly?


> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 1062d8fe2..aaf7e92b0 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -77,6 +77,8 @@ static unsigned long cache_max_small_delta_size = 1000;
>  
>  static unsigned long window_memory_limit = 0;
>  
> +static long blob_size_limit = -1;
> +

Which is the largest, long, ssize_t, or offset_t?  Perhaps intmax_t
but it may be overkill?

In any case, not within the scope of this series; we assume that an
individual object's size fits in ulong around here.

> @@ -776,6 +778,50 @@ static const char no_split_warning[] = N_(
>  "disabling bitmap writing, packs are split due to pack.packSizeLimit"
>  );
>  
> +struct oversized_blob {
> +	struct hashmap_entry entry;
> +	struct object_id oid;
> +	unsigned long size;
> +};
> +struct hashmap oversized_blobs;
> +
> +static int oversized_blob_cmp_fn(const void *b1, const void *b2,
> +				 const void *keydata)
> +{
> +	const struct object_id *oid2 = keydata ? keydata : 
> +		&((const struct oversized_blob *) b2)->oid;
> +	return oidcmp(&((const struct oversized_blob *) b1)->oid, oid2);
> +}
> +
> +static int oversized_blob_cmp(const void *b1, const void *b2)
> +{
> +	return oidcmp(&(*(const struct oversized_blob **) b1)->oid,
> +		      &(*(const struct oversized_blob **) b2)->oid);
> +}
> +
> +static void write_oversized_info(void)
> +{
> +	struct oversized_blob **obs = xmalloc(oversized_blobs.size *
> +					      sizeof(*obs));

Can this multiplication overflow (hint: st_mult)?

> +	struct hashmap_iter iter;
> +	struct oversized_blob *ob;
> +	int i = 0;
> +	uint64_t size_network;
> +
> +	for (ob = hashmap_iter_first(&oversized_blobs, &iter);
> +	     ob;
> +	     ob = hashmap_iter_next(&iter))
> +		obs[i++] = ob;
> +	QSORT(obs, oversized_blobs.size, oversized_blob_cmp);

This sorting is a part of external contract (i.e. "output in hash
order" is documented), but is it necessary?  Just wondering.

> +	size_network = htonll(oversized_blobs.size);
> +	write_in_full(1, &size_network, sizeof(size_network));
> +	for (i = 0; i < oversized_blobs.size; i++) {
> +		write_in_full(1, &obs[i]->oid, sizeof(obs[i]->oid));
> +		size_network = htonll(obs[i]->size);
> +		write_in_full(1, &size_network, sizeof(size_network));
> +	}
> +}

> @@ -822,7 +868,11 @@ static void write_pack_file(void)
>  		 * If so, rewrite it like in fast-import
>  		 */
>  		if (pack_to_stdout) {
> -			sha1close(f, sha1, CSUM_CLOSE);
> +			sha1close(f, sha1, 0);

You do want to exclude the trailing thing out of the checksum, but
CSUM_CLOSE would close the fd and that is why you pass 0 here.  OK.

> +			write_in_full(1, sha1, sizeof(sha1));

Even though we are in "pack_to_stdout" codepath, I'd prefer to
consistently use f->fd, not a hardcoded 1 here.  Of course,
sha1close() would have freed 'f' at this point, so we need to grab
the return value from the function to learn which fd is connected to
our original "stdout" at this point.

Likewise for write_oversized_info(), which probably should just take
"int fd" as parameter.

> +			if (blob_size_limit >= 0) {
> +				write_oversized_info();
> +			}

I do not necessarily think it is a bad idea to show this as trailing
data after the pack, but when we come to this function, do we have
enough information to make the "oversize" information appear before
the pack data if we wanted to?  I have a suspicion that it is easier
to handle at the receiving end, after the capability exchange
decides to use this "omit oversized ones" extension, to receive this
before the packdata begins.  If it is at the end, the receiver needs
to spawn either unpack-objects or index-objects to cause it write to
the disk, but when it does so, it has to have a FD open to read from
their standard output so that the receiver can grab the "remainder"
that these programs did not process.  "Write to the end of the pack
stream data to these programs, and process the remainder ourselves"
is much harder to arrange, I'd suspect.

>  		} else if (nr_written == nr_remaining) {
>  			sha1close(f, sha1, CSUM_FSYNC);
>  		} else {
> @@ -1069,17 +1119,58 @@ static const char no_closure_warning[] = N_(
>  "disabling bitmap writing, as some objects are not being packed"
>  );
>  
> +/*
> + * Returns 1 and records this blob in oversized_blobs if the given blob does
> + * not meet any defined blob size limits.  Blobs that appear as a tree entry
> + * whose basename begins with ".git" are never considered oversized.
> + *
> + * If the tree entry corresponding to the given blob is unknown, pass NULL as
> + * name. In this case, this function will always return 0 to avoid false
> + * positives.
> + */
> +static int oversized(const unsigned char *sha1, const char *name) {

Not object_id?

> +	const char *last_slash, *basename;
> +	unsigned long size;
> +	unsigned int hash;
> +
> +	if (blob_size_limit < 0 || !name)
> +		return 0;
> +
> +	last_slash = strrchr(name, '/');
> +	basename = last_slash ? last_slash + 1 : name;
> +	if (starts_with(basename, ".git"))
> +		return 0;

When we have two paths to a blob, and the blob is first fed to this
function with one name that does not begin with ".git", we would
register it to the hashmap.  And then the other name that begins
with ".git" is later discovered to point at the same blob, what
happens?  Would we need to unregister it from the hashmap elsewhere
in the code?

> +	sha1_object_info(sha1, &size);
> +	if (size < blob_size_limit)
> +		return 0;
> +	
> +	if (!oversized_blobs.tablesize)
> +		hashmap_init(&oversized_blobs, oversized_blob_cmp_fn, 0);
> +	hash = sha1hash(sha1);
> +	if (!hashmap_get_from_hash(&oversized_blobs, hash, sha1)) {
> +		struct oversized_blob *ob = xmalloc(sizeof(*ob));
> +		hashmap_entry_init(ob, hash);
> +		hashcpy(ob->oid.hash, sha1);
> +		ob->size = size;
> +		hashmap_add(&oversized_blobs, ob);
> +	}
> +	return 1;
> +}
> +
>  static int add_object_entry(const unsigned char *sha1, enum object_type type,
> -			    const char *name, int exclude)
> +			    const char *name, int preferred_base)

This belongs to the previous step that renamed "exclude", no?

>  {
>  	struct packed_git *found_pack = NULL;
>  	off_t found_offset = 0;
>  	uint32_t index_pos;
> +	struct hashmap_entry entry;
>  
> -	if (have_duplicate_entry(sha1, exclude, &index_pos))
> +	if (have_duplicate_entry(sha1, preferred_base, &index_pos))
>  		return 0;
>  
> -	if (ignore_object(sha1, exclude, &found_pack, &found_offset)) {
> +	if (ignore_object(sha1, preferred_base, &found_pack, &found_offset) ||
> +	    (!preferred_base && type == OBJ_BLOB && oversized(sha1, name))) {
>  		/* The pack is missing an object, so it will not have closure */
>  		if (write_bitmap_index) {
>  			warning(_(no_closure_warning));
> @@ -1088,8 +1179,17 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  		return 0;
>  	}
>  
> +	/*
> +	 * Ensure that we do not report this blob as oversized if we are going
> +	 * to use it, be it in the returned pack or as a preferred base
> +	 */
> +	if (oversized_blobs.tablesize) {
> +		hashmap_entry_init(&entry, sha1hash(sha1));
> +		free(hashmap_remove(&oversized_blobs, &entry, sha1));
> +	}
> +

Ah, is this where the "unregistering" happens?

>  	create_object_entry(sha1, type, pack_name_hash(name),
> -			    exclude, name && no_try_delta(name),
> +			    preferred_base, name && no_try_delta(name),
>  			    index_pos, found_pack, found_offset);
>  
>  	display_progress(progress_state, nr_result);
