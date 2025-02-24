Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD711A9B3E
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420332; cv=none; b=a7WlvcIgDaet/gPey5g2eSsIdRM1L2Fo0hrlaGO5RfQ80F1FvNRy0GxF3H36GNFfnKi2NZvL2dtdd8vOmsaOQFxVSbKcnNBQuGrA0fezotqQ1FHGIQ9wADxVgztaZhyjg4xQeE0tdNTE3hpPlPgGUMj3FTz6I3rsxa+63RMUK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420332; c=relaxed/simple;
	bh=sQNe+IXif8MAcWdcgGqHDbugBHDGQgVAOX0qu/wyiKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JzZQ3xPNEoS6SIkeq2aSe5+rpUkYbDIIMzKKuT6/n+kLmY5eCM+MuiUwekCdcktNl/CcuQZbdOZg4N3cUoEird7+VEO4wNVyDNbPLi1fQf0nt0J7CuAqmbIrXG13o+EuaJVAjGwT2IFNXkdn2n/ozjmLAzKvv2spCQMrDzEsc70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UOXb8Kjn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pJ0hijdB; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UOXb8Kjn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pJ0hijdB"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C85A1140151;
	Mon, 24 Feb 2025 13:05:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 24 Feb 2025 13:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740420329; x=1740506729; bh=W0K7RhANT+
	BQc2eSeMh+Qe3siFVHfRSk73vYpMWHeXQ=; b=UOXb8KjnLEgnyB2pXXAdr3M61d
	7PAjMHrODjIF9sQD6c7H5EeZg0j+bFaGdz7h7G/c7mmPjRtNZkBSljGdFI2+U2wE
	GlfQ36KrT6cl1B5zrTAtUgRjHALhBSjhmHCP5ZIJapZlDxTftL4+qE61NWj4AB3W
	yVyF/vAoYZI51+RzoZHNhwtb/4PbmmPc9Zm2wJSnGkCVm/Q6MYmyQPXvW9+dSKmW
	roeHa4ducM2bDeh98xf1NE3Q8p3i/Vz/5bdC0iUkxipoUczosRgia04qBzCz0+Fl
	7Ziu6O/CKWA4iIh8S89AaDXnSsbGR+448dzUHY/Q6lWGIlAFeWPlcZsTF9ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740420329; x=1740506729; bh=W0K7RhANT+BQc2eSeMh+Qe3siFVHfRSk73v
	YpMWHeXQ=; b=pJ0hijdB5d5cizzv07UpShP5Lg6X717xsiOsiEvJ3gisp8a4hcO
	VM/G03mcwSffLEDqb7vWwrK4nIoHEOw3pgHzxbcN/bLqdaj5GIT7b/ib9F5MaUwe
	c4P4gESrtkCyKIXCIEz0kPgs/5Yt3G69tDYMbMU2Mcu0VPTSAR3T0ITwF2fALOQS
	VvfRv6naPqZJ6dZQ1iL8TDVrdQzgeFc95b1NuP63hxhgCqs8K7kJVGFQZrjD56me
	0YkNUFpYBtJ43VJQz0FnmNulxbVxxaCz9sBxPMwlf+u8Zps8Jce2QULGKE0x0yTi
	kMG5msrdKGuDucedfJNUqMEHO2QpUY18Okw==
X-ME-Sender: <xms:6LS8Z2D-3OVCzQthUfn6XBrDtJnA-e57BYWX5Go4LF5R1iFSCi7F8w>
    <xme:6LS8ZwirGHTXJt9LkLruBEiXzM3nXnH7ZX19amaKgN2hx1hp9rY9Qdqhyoo9ho9L-
    0HGXOpHW3JZiUcrig>
X-ME-Received: <xmr:6LS8Z5la6irBaDdxa3hrq5XhLrk9brKiJzmdLT-QsrbP7lJtION9C2zvnplExezE7cl95WVkQMTGd-PHIAF6bdoUOI7eF3KsaxMgvyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:6LS8Z0x1HUuh0cvf8w3bz80_V9tFHOix0A8FIdYhkaewtkYc1U3gFg>
    <xmx:6LS8Z7T9QLlvm-Wbo2XAPEa4vYMRM1HItrJxwG374flYqQ5Yz2Hs4A>
    <xmx:6LS8Z_ZZcr_uMAHi2FFxIulmCXgdmzfpiXlCytl8zQMDfiUjjnowvQ>
    <xmx:6LS8Z0Tj6PXAoQ8-q8RXE-5_sX7BnaROwK-jHr_QPyxakSPCC_skYg>
    <xmx:6bS8Z5MW8sGzhhHSxId30XUchAJgDZ1l2c2WNJreY39k9bt-xTOh_uo7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 13:05:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/9] pack-bitmap: expose function to iterate over
 bitmapped objects
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-6-0852530888e2@pks.im>
	(Patrick Steinhardt's message of "Fri, 21 Feb 2025 08:47:31 +0100")
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
	<20250221-pks-cat-file-object-type-filter-v1-6-0852530888e2@pks.im>
Date: Mon, 24 Feb 2025 10:05:27 -0800
Message-ID: <xmqqseo35ic8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Expose a function that allows the caller to iterate over all bitmapped
> objects of a specific type. This mechanism allows us to use the object
> type-specific bitmaps to enumerate all objects of that type without
> having to scan through a complete packfile.
>
> This functionality will be used in a subsequent commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/pack-objects.c |  3 ++-
>  builtin/rev-list.c     |  3 ++-
>  pack-bitmap.c          | 65 +++++++++++++++++++++++++++++++-------------------
>  pack-bitmap.h          | 12 +++++++++-
>  reachable.c            |  3 ++-
>  5 files changed, 57 insertions(+), 29 deletions(-)

After 2189649b (pack-bitmap.c: keep track of each layer's type
bitmaps, 2024-11-19) added <type>_all bitmaps to the bitmap_index
struct, this step would need some adjustment, I am afraid.

Taylor Cc'ed.

Thanks.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 58a9b161262..8f99e2b4fa8 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1735,7 +1735,8 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
>  static int add_object_entry_from_bitmap(const struct object_id *oid,
>  					enum object_type type,
>  					int flags UNUSED, uint32_t name_hash,
> -					struct packed_git *pack, off_t offset)
> +					struct packed_git *pack, off_t offset,
> +					void *payload UNUSED)
>  {
>  	display_progress(progress_state, ++nr_seen);
>  
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index bb26bee0d45..1100dd2abe7 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -429,7 +429,8 @@ static int show_object_fast(
>  	int exclude UNUSED,
>  	uint32_t name_hash UNUSED,
>  	struct packed_git *found_pack UNUSED,
> -	off_t found_offset UNUSED)
> +	off_t found_offset UNUSED,
> +	void *payload UNUSED)
>  {
>  	fprintf(stdout, "%s\n", oid_to_hex(oid));
>  	return 1;
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 6406953d322..fc92e0aae65 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1509,50 +1509,45 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
>  		    (obj->type == OBJ_TAG && !revs->tag_objects))
>  			continue;
>  
> -		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0);
> +		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0, NULL);
>  	}
>  }
>  
> -static void init_type_iterator(struct ewah_iterator *it,
> -			       struct bitmap_index *bitmap_git,
> -			       enum object_type type)
> +static struct ewah_bitmap *ewah_for_type(struct bitmap_index *bitmap_git,
> +					 enum object_type type)
>  {
>  	switch (type) {
>  	case OBJ_COMMIT:
> -		ewah_iterator_init(it, bitmap_git->commits);
> -		break;
> -
> +		return bitmap_git->commits;
>  	case OBJ_TREE:
> -		ewah_iterator_init(it, bitmap_git->trees);
> -		break;
> -
> +		return bitmap_git->trees;
>  	case OBJ_BLOB:
> -		ewah_iterator_init(it, bitmap_git->blobs);
> -		break;
> -
> +		return bitmap_git->blobs;
>  	case OBJ_TAG:
> -		ewah_iterator_init(it, bitmap_git->tags);
> -		break;
> -
> +		return bitmap_git->tags;
>  	default:
>  		BUG("object type %d not stored by bitmap type index", type);
> -		break;
>  	}
>  }
>  
> -static void show_objects_for_type(
> -	struct bitmap_index *bitmap_git,
> -	enum object_type object_type,
> -	show_reachable_fn show_reach)
> +static void init_type_iterator(struct ewah_iterator *it,
> +			       struct bitmap_index *bitmap_git,
> +			       enum object_type type)
> +{
> +	ewah_iterator_init(it, ewah_for_type(bitmap_git, type));
> +}
> +
> +static void for_each_bitmapped_object_internal(struct bitmap_index *bitmap_git,
> +					       struct bitmap *objects,
> +					       enum object_type object_type,
> +					       show_reachable_fn show_reach,
> +					       void *payload)
>  {
>  	size_t i = 0;
>  	uint32_t offset;
> -
>  	struct ewah_iterator it;
>  	eword_t filter;
>  
> -	struct bitmap *objects = bitmap_git->result;
> -
>  	init_type_iterator(&it, bitmap_git, object_type);
>  
>  	for (i = 0; i < objects->word_alloc &&
> @@ -1595,11 +1590,31 @@ static void show_objects_for_type(
>  			if (bitmap_git->hashes)
>  				hash = get_be32(bitmap_git->hashes + index_pos);
>  
> -			show_reach(&oid, object_type, 0, hash, pack, ofs);
> +			show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
>  		}
>  	}
>  }
>  
> +static void show_objects_for_type(
> +	struct bitmap_index *bitmap_git,
> +	enum object_type object_type,
> +	show_reachable_fn show_reach)
> +{
> +	for_each_bitmapped_object_internal(bitmap_git, bitmap_git->result,
> +					   object_type, show_reach, NULL);
> +}
> +
> +void for_each_bitmapped_object(struct bitmap_index *bitmap_git,
> +			       enum object_type object_type,
> +			       show_reachable_fn show_reach,
> +			       void *payload)
> +{
> +	struct bitmap *bitmap = ewah_to_bitmap(ewah_for_type(bitmap_git, object_type));
> +	for_each_bitmapped_object_internal(bitmap_git, bitmap,
> +					   object_type, show_reach, payload);
> +	bitmap_free(bitmap);
> +}
> +
>  static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
>  			     struct object_list *roots)
>  {
> diff --git a/pack-bitmap.h b/pack-bitmap.h
> index d7f4b8b8e95..3368e79ed5a 100644
> --- a/pack-bitmap.h
> +++ b/pack-bitmap.h
> @@ -50,7 +50,8 @@ typedef int (*show_reachable_fn)(
>  	int flags,
>  	uint32_t hash,
>  	struct packed_git *found_pack,
> -	off_t found_offset);
> +	off_t found_offset,
> +	void *payload);
>  
>  struct bitmap_index;
>  
> @@ -78,6 +79,15 @@ int test_bitmap_pseudo_merges(struct repository *r);
>  int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
>  int test_bitmap_pseudo_merge_objects(struct repository *r, uint32_t n);
>  
> +/*
> + * Iterate through all bitmapped objects of the given type and execute the
> + * `show_reach` for each of them.
> + */
> + void for_each_bitmapped_object(struct bitmap_index *bitmap_git,
> +			       enum object_type object_type,
> +			       show_reachable_fn show_reach,
> +			       void *payload);
> +
>  #define GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL \
>  	"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL"
>  
> diff --git a/reachable.c b/reachable.c
> index ecf7ccf5041..dd33c7f07dd 100644
> --- a/reachable.c
> +++ b/reachable.c
> @@ -337,7 +337,8 @@ static int mark_object_seen(const struct object_id *oid,
>  			     int exclude UNUSED,
>  			     uint32_t name_hash UNUSED,
>  			     struct packed_git *found_pack UNUSED,
> -			     off_t found_offset UNUSED)
> +			     off_t found_offset UNUSED,
> +			     void *payload UNUSED)
>  {
>  	struct object *obj = lookup_object_by_type(the_repository, oid, type);
>  	if (!obj)
