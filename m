Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72323309F1D
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009247; cv=none; b=iwB4vjgiXmCPuWzluA6B4cErbmmka6zn2LSYzOBXwGnyxkwoIkfYmvLs/d04pn4xjOc13ubtzgT7eOAhvD7VCoK7jjbLT3WBPrUNFWn9Xf4yettDdVHFWQKnMnI86gw+eKyZ9Roe4pwUL+1uHO02MffdYy4Q6F0ExLj9o1HS56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009247; c=relaxed/simple;
	bh=qi4+Nluf54egngxNzPuHHX0b37nxKJ8BSL3R4Jtl6Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3yiSGDdtYO26nH9AjNufe5PQCnVDIgc34YYAemHYR0y7pZVzYKI6Kv7PTvd2g2gpKqHzW0ycQe07OYJTumTsJbiXbyKLPvjqJVI7AbER/CrfY1s/qx6vZ169ZyzlaYMpzuEWrKJNKzAs5UPTbSqWrlgJsL1mochyCCXa75NVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=HowxpOgx; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="HowxpOgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778009243; x=1778614043; i=tboegi@web.de;
	bh=HfTkUm2NqJJ3ukfF0r9H9euP70bfMk0e6bQnPStBw8M=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HowxpOgxdJEiBDktK7YUJ8Qh+ck8GKGOHs3nxnqgqt/kEBxcnipH9Vl6oj7mCTjS
	 ST5XHgIkBLzKN/H61Hcrev8IO5W9nG4MmctMbCIINwPUtZPmsslu9h8X2wmLFyQxz
	 xoSLYokcyvAHjqmWpo30l/BYfkOkfss1ZDmPj1t6zM03WBIKxwEO4e85lchQMnIa/
	 ojZYrIJ+dlUUAdytbYq8KvxSCE7GMTBub8FV+PGxuvLllx99wSJkVdM/Htub1LY7U
	 Htzl0mZCe1gOJYjsq+JPn2vvP/W/NdW8iH04ofwoyqexgfxkOPh0HUSPo8Jneo1+Z
	 QzuMRUpKhIwpZeYmIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ac-1vYgTV0RYE-00oMO3; Tue, 05
 May 2026 21:27:23 +0200
Date: Tue, 5 May 2026 21:27:22 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 03/11] odb, packfile: use size_t for streaming object
 sizes
Message-ID: <20260505192722.GB12275@tb-raspi4>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
 <3a539061c5f62c65d46bd0eb774bb1b1239463ff.1777914508.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a539061c5f62c65d46bd0eb774bb1b1239463ff.1777914508.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:CuR0Zeox4oKQfyIfxSFoE8+um7yZ2WDkGXDKRewOUa+4aohv72i
 BtnmghVoO3vDLH5Y7/IG4zIr1WlBIMfupVGyiGE5eiIKKtUtR7pHTHjfZ/C34u685ZxldF6
 QkSZyWifCRd/7GKTV/nHNjcHt40tD/FDw5lQMaq1bJtpks3m5TtHZpXSJUbS9MyOFKR7vIh
 A2jQdjfVXHm9Fmrs6qXbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3hp7zG6AnEY=;B3zD10bT8yF+o/ukwAjlfhVSZD+
 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
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2026 at 05:08:20PM +0000, Johannes Schindelin via GitGitGa=
dget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> The odb_read_stream structure uses unsigned long for the size field,
> which is 32-bit on Windows even in 64-bit builds. When streaming
> objects larger than 4GB, the size would be truncated to zero or an
> incorrect value, resulting in empty files being written to disk.
>=20
> Change the size field in odb_read_stream to size_t and introduce
> unpack_object_header_sz() to return sizes via size_t pointer. Since
> object_info.sizep remains unsigned long for API compatibility, use
> temporary variables where the types differ, with comments noting the
> truncation limitation for code paths that still use unsigned long.
>=20
> This was originally authored by LordKiRon <https://github.com/LordKiRon>=
,
> who preferred not to reveal their real name and therefore agreed that I
> take over authorship.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/pack-objects.c       | 23 ++++++++++++++++-------
>  object-file.c                | 10 +++++++++-
>  odb/streaming.c              | 13 ++++++++++++-
>  odb/streaming.h              |  2 +-
>  oss-fuzz/fuzz-pack-headers.c |  2 +-
>  pack-bitmap.c                |  2 +-
>  pack-check.c                 |  6 ++++--
>  packfile.c                   | 24 +++++++++++++++---------
>  packfile.h                   |  4 ++--
>  9 files changed, 61 insertions(+), 25 deletions(-)
>=20

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index dd2480a73d..aa4b1cb9b8 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c

I haven't been able to follow all changes, so this may be false alarm.
Do we need a cast_size_t_to_ulong() somewhere ?

> @@ -629,14 +629,21 @@ static off_t write_reuse_object(struct hashfile *f=
, struct object_entry *entry,
>  	struct packed_git *p =3D IN_PACK(entry);
>  	struct pack_window *w_curs =3D NULL;
>  	uint32_t pos;
> -	off_t offset;
> +	off_t offset, cur;
>  	enum object_type type =3D oe_type(entry);
> +	enum object_type in_pack_type;
>  	off_t datalen;
>  	unsigned char header[MAX_PACK_OBJECT_HEADER],
>  		      dheader[MAX_PACK_OBJECT_HEADER];
>  	unsigned hdrlen;
>  	const unsigned hashsz =3D the_hash_algo->rawsz;
> -	unsigned long entry_size =3D SIZE(entry);
> +	size_t entry_size;
> +
> +	cur =3D entry->in_pack_offset;
> +	in_pack_type =3D unpack_object_header(p, &w_curs, &cur, &entry_size);
> +	if (in_pack_type < 0)
> +		die(_("write_reuse_object: unable to parse object header of %s"),
> +		    oid_to_hex(&entry->idx.oid));
> =20
>  	if (DELTA(entry))
>  		type =3D (allow_ofs_delta && DELTA(entry)->idx.offset) ?
> @@ -1087,7 +1094,7 @@ static void write_reused_pack_one(struct packed_gi=
t *reuse_packfile,
>  {
>  	off_t offset, next, cur;
>  	enum object_type type;
> -	unsigned long size;
> +	size_t size;
> =20
>  	offset =3D pack_pos_to_offset(reuse_packfile, pos);
>  	next =3D pack_pos_to_offset(reuse_packfile, pos + 1);
> @@ -2243,7 +2250,7 @@ static void check_object(struct object_entry *entr=
y, uint32_t object_index)
>  		off_t ofs;
>  		unsigned char *buf, c;
>  		enum object_type type;
> -		unsigned long in_pack_size;
> +		size_t in_pack_size;
> =20
>  		buf =3D use_pack(p, &w_curs, entry->in_pack_offset, &avail);
> =20
> @@ -2734,16 +2741,18 @@ unsigned long oe_get_size_slow(struct packing_da=
ta *pack,
>  	struct pack_window *w_curs;
>  	unsigned char *buf;
>  	enum object_type type;
> -	unsigned long used, avail, size;
> +	unsigned long used, avail;
> +	size_t size;
> =20
>  	if (e->type_ !=3D OBJ_OFS_DELTA && e->type_ !=3D OBJ_REF_DELTA) {
> +		unsigned long sz;
>  		packing_data_lock(&to_pack);
>  		if (odb_read_object_info(the_repository->objects,
> -					 &e->idx.oid, &size) < 0)
> +					 &e->idx.oid, &sz) < 0)
>  			die(_("unable to get size of %s"),
>  			    oid_to_hex(&e->idx.oid));
>  		packing_data_unlock(&to_pack);
> -		return size;
> +		return sz;
>  	}
> =20
>  	p =3D oe_in_pack(pack, e);
> diff --git a/object-file.c b/object-file.c
> index 086b2b65ff..0be2981c7a 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2326,6 +2326,7 @@ int odb_source_loose_read_object_stream(struct odb=
_read_stream **out,
>  	struct object_info oi =3D OBJECT_INFO_INIT;
>  	struct odb_loose_read_stream *st;
>  	unsigned long mapsize;
> +	unsigned long size_ul;
>  	void *mapped;
> =20
>  	mapped =3D odb_source_loose_map_object(source, oid, &mapsize);
> @@ -2349,11 +2350,18 @@ int odb_source_loose_read_object_stream(struct o=
db_read_stream **out,
>  		goto error;
>  	}
> =20
> -	oi.sizep =3D &st->base.size;
> +	/*
> +	 * object_info.sizep is unsigned long* (32-bit on Windows), but
> +	 * st->base.size is size_t (64-bit). Use temporary variable.
> +	 * Note: loose objects >4GB would still truncate here, but such
> +	 * large loose objects are uncommon (they'd normally be packed).
> +	 */
> +	oi.sizep =3D &size_ul;
>  	oi.typep =3D &st->base.type;
> =20
>  	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
>  		goto error;
> +	st->base.size =3D size_ul;
> =20
>  	st->mapped =3D mapped;
>  	st->mapsize =3D mapsize;
> diff --git a/odb/streaming.c b/odb/streaming.c
> index 5927a12954..af2adf5ce7 100644
> --- a/odb/streaming.c
> +++ b/odb/streaming.c
> @@ -157,15 +157,26 @@ static int open_istream_incore(struct odb_read_str=
eam **out,
>  		.base.read =3D read_istream_incore,
>  	};
>  	struct odb_incore_read_stream *st;
> +	unsigned long size_ul;
>  	int ret;
> =20
>  	oi.typep =3D &stream.base.type;
> -	oi.sizep =3D &stream.base.size;
> +	/*
> +	 * object_info.sizep is unsigned long* (32-bit on Windows), but
> +	 * stream.base.size is size_t (64-bit). We use a temporary variable
> +	 * because the types are incompatible. Note: this path still truncates
> +	 * for >4GB objects, but large objects should use pack streaming
> +	 * (packfile_store_read_object_stream) which handles size_t properly.
> +	 * This incore fallback is only used for small objects or when pack
> +	 * streaming is unavailable.
> +	 */
> +	oi.sizep =3D &size_ul;
>  	oi.contentp =3D (void **)&stream.buf;
>  	ret =3D odb_read_object_info_extended(odb, oid, &oi,
>  					    OBJECT_INFO_DIE_IF_CORRUPT);
>  	if (ret)
>  		return ret;
> +	stream.base.size =3D size_ul;
> =20
>  	CALLOC_ARRAY(st, 1);
>  	*st =3D stream;
> diff --git a/odb/streaming.h b/odb/streaming.h
> index c7861f7e13..517e2ea2d3 100644
> --- a/odb/streaming.h
> +++ b/odb/streaming.h
> @@ -21,7 +21,7 @@ struct odb_read_stream {
>  	odb_read_stream_close_fn close;
>  	odb_read_stream_read_fn read;
>  	enum object_type type;
> -	unsigned long size; /* inflated size of full object */
> +	size_t size; /* inflated size of full object */
>  };
> =20
>  /*
> diff --git a/oss-fuzz/fuzz-pack-headers.c b/oss-fuzz/fuzz-pack-headers.c
> index 150c0f5fa2..ef61ab577c 100644
> --- a/oss-fuzz/fuzz-pack-headers.c
> +++ b/oss-fuzz/fuzz-pack-headers.c
> @@ -6,7 +6,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t s=
ize);
>  int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
>  {
>  	enum object_type type;
> -	unsigned long len;
> +	size_t len;
> =20
>  	unpack_object_header_buffer((const unsigned char *)data,
>  				    (unsigned long)size, &type, &len);
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index f6ec18d83a..f9af8a96bd 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -2270,7 +2270,7 @@ static int try_partial_reuse(struct bitmap_index *=
bitmap_git,
>  {
>  	off_t delta_obj_offset;
>  	enum object_type type;
> -	unsigned long size;
> +	size_t size;
> =20
>  	if (pack_pos >=3D pack->p->num_objects)
>  		return -1; /* not actually in the pack */
> diff --git a/pack-check.c b/pack-check.c
> index 79992bb509..2792f34d25 100644
> --- a/pack-check.c
> +++ b/pack-check.c
> @@ -110,7 +110,7 @@ static int verify_packfile(struct repository *r,
>  		void *data;
>  		struct object_id oid;
>  		enum object_type type;
> -		unsigned long size;
> +		size_t size;
>  		off_t curpos;
>  		int data_valid;
> =20
> @@ -143,7 +143,9 @@ static int verify_packfile(struct repository *r,
>  			data =3D NULL;
>  			data_valid =3D 0;
>  		} else {
> -			data =3D unpack_entry(r, p, entries[i].offset, &type, &size);
> +			unsigned long sz;
> +			data =3D unpack_entry(r, p, entries[i].offset, &type, &sz);
> +			size =3D sz;
>  			data_valid =3D 1;
>  		}
> =20
> diff --git a/packfile.c b/packfile.c
> index b012d648ad..fdae91dd11 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1133,7 +1133,7 @@ out:
>  }
> =20
>  unsigned long unpack_object_header_buffer(const unsigned char *buf,
> -		unsigned long len, enum object_type *type, unsigned long *sizep)
> +		unsigned long len, enum object_type *type, size_t *sizep)
>  {
>  	unsigned shift;
>  	size_t size, c;
> @@ -1144,7 +1144,11 @@ unsigned long unpack_object_header_buffer(const u=
nsigned char *buf,
>  	size =3D c & 15;
>  	shift =3D 4;
>  	while (c & 0x80) {
> -		if (len <=3D used || (bitsizeof(long) - 7) < shift) {
> +		/*
> +		 * Each continuation byte adds 7 bits. Ensure shift won't
> +		 * overflow size_t (use size_t not long for 64-bit on Windows).
> +		 */
> +		if (len <=3D used || (bitsizeof(size_t) - 7) < shift) {
>  			error("bad object header");
>  			size =3D used =3D 0;
>  			break;
> @@ -1153,7 +1157,7 @@ unsigned long unpack_object_header_buffer(const un=
signed char *buf,
>  		size =3D st_add(size, st_left_shift(c & 0x7f, shift));
>  		shift +=3D 7;
>  	}
> -	*sizep =3D cast_size_t_to_ulong(size);
> +	*sizep =3D size;
>  	return used;
>  }
> =20
> @@ -1215,7 +1219,7 @@ unsigned long get_size_from_delta(struct packed_gi=
t *p,
>  int unpack_object_header(struct packed_git *p,
>  			 struct pack_window **w_curs,
>  			 off_t *curpos,
> -			 unsigned long *sizep)
> +			 size_t *sizep)
>  {
>  	unsigned char *base;
>  	unsigned long left;
> @@ -1367,7 +1371,7 @@ static enum object_type packed_to_object_type(stru=
ct repository *r,
> =20
>  	while (type =3D=3D OBJ_OFS_DELTA || type =3D=3D OBJ_REF_DELTA) {
>  		off_t base_offset;
> -		unsigned long size;
> +		size_t size;
>  		/* Push the object we're going to leave behind */
>  		if (poi_stack_nr >=3D poi_stack_alloc && poi_stack =3D=3D small_poi_s=
tack) {
>  			poi_stack_alloc =3D alloc_nr(poi_stack_nr);
> @@ -1586,7 +1590,7 @@ static int packed_object_info_with_index_pos(struc=
t packed_git *p, off_t obj_off
>  					     uint32_t *maybe_index_pos, struct object_info *oi)
>  {
>  	struct pack_window *w_curs =3D NULL;
> -	unsigned long size;
> +	size_t size;
>  	off_t curpos =3D obj_offset;
>  	enum object_type type =3D OBJ_NONE;
>  	uint32_t pack_pos;
> @@ -1778,7 +1782,7 @@ void *unpack_entry(struct repository *r, struct pa=
cked_git *p, off_t obj_offset,
>  	struct pack_window *w_curs =3D NULL;
>  	off_t curpos =3D obj_offset;
>  	void *data =3D NULL;
> -	unsigned long size;
> +	size_t size;
>  	enum object_type type;
>  	struct unpack_entry_stack_ent small_delta_stack[UNPACK_ENTRY_STACK_PRE=
ALLOC];
>  	struct unpack_entry_stack_ent *delta_stack =3D small_delta_stack;
> @@ -1943,8 +1947,10 @@ void *unpack_entry(struct repository *r, struct p=
acked_git *p, off_t obj_offset,
>  			      (uintmax_t)curpos, p->pack_name);
>  			data =3D NULL;
>  		} else {
> +			unsigned long sz;
>  			data =3D patch_delta(base, base_size, delta_data,
> -					   delta_size, &size);
> +					   delta_size, &sz);
> +			size =3D sz;
> =20
>  			/*
>  			 * We could not apply the delta; warn the user, but
> @@ -2929,7 +2935,7 @@ int packfile_read_object_stream(struct odb_read_st=
ream **out,
>  	struct odb_packed_read_stream *stream;
>  	struct pack_window *window =3D NULL;
>  	enum object_type in_pack_type;
> -	unsigned long size;
> +	size_t size;
> =20
>  	in_pack_type =3D unpack_object_header(pack, &window, &offset, &size);
>  	unuse_pack(&window);
> diff --git a/packfile.h b/packfile.h
> index 9b647da7dd..49d6bdecf6 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -456,9 +456,9 @@ off_t find_pack_entry_one(const struct object_id *oi=
d, struct packed_git *);
> =20
>  int is_pack_valid(struct packed_git *);
>  void *unpack_entry(struct repository *r, struct packed_git *, off_t, en=
um object_type *, unsigned long *);
> -unsigned long unpack_object_header_buffer(const unsigned char *buf, uns=
igned long len, enum object_type *type, unsigned long *sizep);
> +unsigned long unpack_object_header_buffer(const unsigned char *buf, uns=
igned long len, enum object_type *type, size_t *sizep);
>  unsigned long get_size_from_delta(struct packed_git *, struct pack_wind=
ow **, off_t);
> -int unpack_object_header(struct packed_git *, struct pack_window **, of=
f_t *, unsigned long *);
> +int unpack_object_header(struct packed_git *, struct pack_window **, of=
f_t *, size_t *);
>  off_t get_delta_base(struct packed_git *p, struct pack_window **w_curs,
>  		     off_t *curpos, enum object_type type,
>  		     off_t delta_obj_offset);
> --=20
> gitgitgadget
>=20
>=20
