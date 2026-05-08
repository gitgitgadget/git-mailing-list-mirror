Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6518B260580
	for <git@vger.kernel.org>; Fri,  8 May 2026 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225929; cv=none; b=opwARShhrWicTiRMjg4MmUs8bd26iX2fA1u770I3cC8XLLxiqlagPiQpH5+mGicBt8lOuQ4ikhA6XLXVGsiGRymYcfKKLhth4Lqy0GYJ81f+KuMxX9+YlxP4hPFn763JDScXSCIqAXA4LBfRRJb8KWLbIfkPS1xgg/+TaKVPkz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225929; c=relaxed/simple;
	bh=MUEALcrniCq51Le4WPdqVkzD5LmbhXZlENgf+dcX0eg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GIjDJV6ppS82KyzGQjvGGQeufXfKW0F/l8dJV/Wdvb+MBOSrDHxjQ6kkBw8lTnK5WB28u0TmNbTf2wAhoWLWoWoYT1qlNG3LHjdWtheki7P/7O+yD9zwNvCbAHOXaLeycElNjArUO95xUoODhevx35UkL05xDiW33Y5DK+uQtow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=cnL1y5OA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="cnL1y5OA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1778225924; x=1778830724;
	i=johannes.schindelin@gmx.de;
	bh=r90eaHoyAbHV7GuH/ajieDLGBC/wbC9lGgtP4Z4+cW0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cnL1y5OAD9RuKgZFk6ug/zbhmx3vtFAc92UMyos7HaZDlnCCaxYenqINhQwmMOXq
	 N/CiZp29sdofwkHzZyiL9sK3VtA4dTv7WNGQzaf5m+QwSrozP6uFvvKQc/Nx9KyNw
	 nLXfas8Da9RUfk2qA9+CKgwQ3uFpeYqJRugWM3udYF8XpGowHiQgC2+Z3Gb34zTVJ
	 rnZz5x3xPInikokBIKmqbBdFL2ly78Yj8FD1eLtYp6EF/tXAC86AP8R2UPMHmFmxs
	 IRtFu3kLhN2NAlFonDsog5RMUbIg8T0UzlIQtCfvvvh/AvbjidE3igg0qDOx+WuuC
	 bqX+67bWkMw4HMDmDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiHl-1vwIA72oNL-00Z8rY; Fri, 08
 May 2026 09:38:44 +0200
Date: Fri, 8 May 2026 09:38:43 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
    Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 03/11] odb, packfile: use size_t for streaming object
 sizes
In-Reply-To: <20260505192722.GB12275@tb-raspi4>
Message-ID: <34a8b2ec-b651-18b3-c62d-072f49dab33e@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com> <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com> <3a539061c5f62c65d46bd0eb774bb1b1239463ff.1777914508.git.gitgitgadget@gmail.com> <20260505192722.GB12275@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1816913923-1778225925=:12327"
X-Provags-ID: V03:K1:esIyTBX3ELw593AVKGa2F9uu5jpc5GUpEOmownZn4/E5mg7Ix/S
 /sSnsZevJ9GqwFbBZFEHbyxhjm3+P/vRBnzlIu2B/u81xztgIIOgRvwnhi13QE1YzZADbao
 Tz7pJmZXXjTKVT7BqP8spU0qillmFEhtx0OryMVArNUxHaVcCMB/ozWmFLgk1LOnqQzXAdM
 LxjHB+d5kf1mRJobKseaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lspjN/cEdAU=;UoRz285qdOlIT08/9SNKovSbAXn
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1816913923-1778225925=:12327
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Torsten,

On Tue, 5 May 2026, Torsten B=C3=B6gershausen wrote:

> On Mon, May 04, 2026 at 05:08:20PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > The odb_read_stream structure uses unsigned long for the size field,
> > which is 32-bit on Windows even in 64-bit builds. When streaming
> > objects larger than 4GB, the size would be truncated to zero or an
> > incorrect value, resulting in empty files being written to disk.
> >=20
> > Change the size field in odb_read_stream to size_t and introduce
> > unpack_object_header_sz() to return sizes via size_t pointer. Since
> > object_info.sizep remains unsigned long for API compatibility, use
> > temporary variables where the types differ, with comments noting the
> > truncation limitation for code paths that still use unsigned long.
> >=20
> > This was originally authored by LordKiRon <https://github.com/LordKiRo=
n>,
> > who preferred not to reveal their real name and therefore agreed that =
I
> > take over authorship.
> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/pack-objects.c       | 23 ++++++++++++++++-------
> >  object-file.c                | 10 +++++++++-
> >  odb/streaming.c              | 13 ++++++++++++-
> >  odb/streaming.h              |  2 +-
> >  oss-fuzz/fuzz-pack-headers.c |  2 +-
> >  pack-bitmap.c                |  2 +-
> >  pack-check.c                 |  6 ++++--
> >  packfile.c                   | 24 +++++++++++++++---------
> >  packfile.h                   |  4 ++--
> >  9 files changed, 61 insertions(+), 25 deletions(-)
> >=20
>=20
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index dd2480a73d..aa4b1cb9b8 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
>=20
> I haven't been able to follow all changes, so this may be false alarm.
> Do we need a cast_size_t_to_ulong() somewhere ?

Oh, that's a really good catch, I forgot to add those. There are a couple
of callers, indeed, and they still have an implicit, _silent_ truncation
to `unsigned long` that I'd rather have explicit, with a check. I'll add
those callers in the next iteration.

Thank you!
Johannes

>=20
> > @@ -629,14 +629,21 @@ static off_t write_reuse_object(struct hashfile =
*f, struct object_entry *entry,
> >  	struct packed_git *p =3D IN_PACK(entry);
> >  	struct pack_window *w_curs =3D NULL;
> >  	uint32_t pos;
> > -	off_t offset;
> > +	off_t offset, cur;
> >  	enum object_type type =3D oe_type(entry);
> > +	enum object_type in_pack_type;
> >  	off_t datalen;
> >  	unsigned char header[MAX_PACK_OBJECT_HEADER],
> >  		      dheader[MAX_PACK_OBJECT_HEADER];
> >  	unsigned hdrlen;
> >  	const unsigned hashsz =3D the_hash_algo->rawsz;
> > -	unsigned long entry_size =3D SIZE(entry);
> > +	size_t entry_size;
> > +
> > +	cur =3D entry->in_pack_offset;
> > +	in_pack_type =3D unpack_object_header(p, &w_curs, &cur, &entry_size)=
;
> > +	if (in_pack_type < 0)
> > +		die(_("write_reuse_object: unable to parse object header of %s"),
> > +		    oid_to_hex(&entry->idx.oid));
> > =20
> >  	if (DELTA(entry))
> >  		type =3D (allow_ofs_delta && DELTA(entry)->idx.offset) ?
> > @@ -1087,7 +1094,7 @@ static void write_reused_pack_one(struct packed_=
git *reuse_packfile,
> >  {
> >  	off_t offset, next, cur;
> >  	enum object_type type;
> > -	unsigned long size;
> > +	size_t size;
> > =20
> >  	offset =3D pack_pos_to_offset(reuse_packfile, pos);
> >  	next =3D pack_pos_to_offset(reuse_packfile, pos + 1);
> > @@ -2243,7 +2250,7 @@ static void check_object(struct object_entry *en=
try, uint32_t object_index)
> >  		off_t ofs;
> >  		unsigned char *buf, c;
> >  		enum object_type type;
> > -		unsigned long in_pack_size;
> > +		size_t in_pack_size;
> > =20
> >  		buf =3D use_pack(p, &w_curs, entry->in_pack_offset, &avail);
> > =20
> > @@ -2734,16 +2741,18 @@ unsigned long oe_get_size_slow(struct packing_=
data *pack,
> >  	struct pack_window *w_curs;
> >  	unsigned char *buf;
> >  	enum object_type type;
> > -	unsigned long used, avail, size;
> > +	unsigned long used, avail;
> > +	size_t size;
> > =20
> >  	if (e->type_ !=3D OBJ_OFS_DELTA && e->type_ !=3D OBJ_REF_DELTA) {
> > +		unsigned long sz;
> >  		packing_data_lock(&to_pack);
> >  		if (odb_read_object_info(the_repository->objects,
> > -					 &e->idx.oid, &size) < 0)
> > +					 &e->idx.oid, &sz) < 0)
> >  			die(_("unable to get size of %s"),
> >  			    oid_to_hex(&e->idx.oid));
> >  		packing_data_unlock(&to_pack);
> > -		return size;
> > +		return sz;
> >  	}
> > =20
> >  	p =3D oe_in_pack(pack, e);
> > diff --git a/object-file.c b/object-file.c
> > index 086b2b65ff..0be2981c7a 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -2326,6 +2326,7 @@ int odb_source_loose_read_object_stream(struct o=
db_read_stream **out,
> >  	struct object_info oi =3D OBJECT_INFO_INIT;
> >  	struct odb_loose_read_stream *st;
> >  	unsigned long mapsize;
> > +	unsigned long size_ul;
> >  	void *mapped;
> > =20
> >  	mapped =3D odb_source_loose_map_object(source, oid, &mapsize);
> > @@ -2349,11 +2350,18 @@ int odb_source_loose_read_object_stream(struct=
 odb_read_stream **out,
> >  		goto error;
> >  	}
> > =20
> > -	oi.sizep =3D &st->base.size;
> > +	/*
> > +	 * object_info.sizep is unsigned long* (32-bit on Windows), but
> > +	 * st->base.size is size_t (64-bit). Use temporary variable.
> > +	 * Note: loose objects >4GB would still truncate here, but such
> > +	 * large loose objects are uncommon (they'd normally be packed).
> > +	 */
> > +	oi.sizep =3D &size_ul;
> >  	oi.typep =3D &st->base.type;
> > =20
> >  	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
> >  		goto error;
> > +	st->base.size =3D size_ul;
> > =20
> >  	st->mapped =3D mapped;
> >  	st->mapsize =3D mapsize;
> > diff --git a/odb/streaming.c b/odb/streaming.c
> > index 5927a12954..af2adf5ce7 100644
> > --- a/odb/streaming.c
> > +++ b/odb/streaming.c
> > @@ -157,15 +157,26 @@ static int open_istream_incore(struct odb_read_s=
tream **out,
> >  		.base.read =3D read_istream_incore,
> >  	};
> >  	struct odb_incore_read_stream *st;
> > +	unsigned long size_ul;
> >  	int ret;
> > =20
> >  	oi.typep =3D &stream.base.type;
> > -	oi.sizep =3D &stream.base.size;
> > +	/*
> > +	 * object_info.sizep is unsigned long* (32-bit on Windows), but
> > +	 * stream.base.size is size_t (64-bit). We use a temporary variable
> > +	 * because the types are incompatible. Note: this path still truncat=
es
> > +	 * for >4GB objects, but large objects should use pack streaming
> > +	 * (packfile_store_read_object_stream) which handles size_t properly=
.
> > +	 * This incore fallback is only used for small objects or when pack
> > +	 * streaming is unavailable.
> > +	 */
> > +	oi.sizep =3D &size_ul;
> >  	oi.contentp =3D (void **)&stream.buf;
> >  	ret =3D odb_read_object_info_extended(odb, oid, &oi,
> >  					    OBJECT_INFO_DIE_IF_CORRUPT);
> >  	if (ret)
> >  		return ret;
> > +	stream.base.size =3D size_ul;
> > =20
> >  	CALLOC_ARRAY(st, 1);
> >  	*st =3D stream;
> > diff --git a/odb/streaming.h b/odb/streaming.h
> > index c7861f7e13..517e2ea2d3 100644
> > --- a/odb/streaming.h
> > +++ b/odb/streaming.h
> > @@ -21,7 +21,7 @@ struct odb_read_stream {
> >  	odb_read_stream_close_fn close;
> >  	odb_read_stream_read_fn read;
> >  	enum object_type type;
> > -	unsigned long size; /* inflated size of full object */
> > +	size_t size; /* inflated size of full object */
> >  };
> > =20
> >  /*
> > diff --git a/oss-fuzz/fuzz-pack-headers.c b/oss-fuzz/fuzz-pack-headers=
.c
> > index 150c0f5fa2..ef61ab577c 100644
> > --- a/oss-fuzz/fuzz-pack-headers.c
> > +++ b/oss-fuzz/fuzz-pack-headers.c
> > @@ -6,7 +6,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t=
 size);
> >  int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> >  {
> >  	enum object_type type;
> > -	unsigned long len;
> > +	size_t len;
> > =20
> >  	unpack_object_header_buffer((const unsigned char *)data,
> >  				    (unsigned long)size, &type, &len);
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index f6ec18d83a..f9af8a96bd 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -2270,7 +2270,7 @@ static int try_partial_reuse(struct bitmap_index=
 *bitmap_git,
> >  {
> >  	off_t delta_obj_offset;
> >  	enum object_type type;
> > -	unsigned long size;
> > +	size_t size;
> > =20
> >  	if (pack_pos >=3D pack->p->num_objects)
> >  		return -1; /* not actually in the pack */
> > diff --git a/pack-check.c b/pack-check.c
> > index 79992bb509..2792f34d25 100644
> > --- a/pack-check.c
> > +++ b/pack-check.c
> > @@ -110,7 +110,7 @@ static int verify_packfile(struct repository *r,
> >  		void *data;
> >  		struct object_id oid;
> >  		enum object_type type;
> > -		unsigned long size;
> > +		size_t size;
> >  		off_t curpos;
> >  		int data_valid;
> > =20
> > @@ -143,7 +143,9 @@ static int verify_packfile(struct repository *r,
> >  			data =3D NULL;
> >  			data_valid =3D 0;
> >  		} else {
> > -			data =3D unpack_entry(r, p, entries[i].offset, &type, &size);
> > +			unsigned long sz;
> > +			data =3D unpack_entry(r, p, entries[i].offset, &type, &sz);
> > +			size =3D sz;
> >  			data_valid =3D 1;
> >  		}
> > =20
> > diff --git a/packfile.c b/packfile.c
> > index b012d648ad..fdae91dd11 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -1133,7 +1133,7 @@ out:
> >  }
> > =20
> >  unsigned long unpack_object_header_buffer(const unsigned char *buf,
> > -		unsigned long len, enum object_type *type, unsigned long *sizep)
> > +		unsigned long len, enum object_type *type, size_t *sizep)
> >  {
> >  	unsigned shift;
> >  	size_t size, c;
> > @@ -1144,7 +1144,11 @@ unsigned long unpack_object_header_buffer(const=
 unsigned char *buf,
> >  	size =3D c & 15;
> >  	shift =3D 4;
> >  	while (c & 0x80) {
> > -		if (len <=3D used || (bitsizeof(long) - 7) < shift) {
> > +		/*
> > +		 * Each continuation byte adds 7 bits. Ensure shift won't
> > +		 * overflow size_t (use size_t not long for 64-bit on Windows).
> > +		 */
> > +		if (len <=3D used || (bitsizeof(size_t) - 7) < shift) {
> >  			error("bad object header");
> >  			size =3D used =3D 0;
> >  			break;
> > @@ -1153,7 +1157,7 @@ unsigned long unpack_object_header_buffer(const =
unsigned char *buf,
> >  		size =3D st_add(size, st_left_shift(c & 0x7f, shift));
> >  		shift +=3D 7;
> >  	}
> > -	*sizep =3D cast_size_t_to_ulong(size);
> > +	*sizep =3D size;
> >  	return used;
> >  }
> > =20
> > @@ -1215,7 +1219,7 @@ unsigned long get_size_from_delta(struct packed_=
git *p,
> >  int unpack_object_header(struct packed_git *p,
> >  			 struct pack_window **w_curs,
> >  			 off_t *curpos,
> > -			 unsigned long *sizep)
> > +			 size_t *sizep)
> >  {
> >  	unsigned char *base;
> >  	unsigned long left;
> > @@ -1367,7 +1371,7 @@ static enum object_type packed_to_object_type(st=
ruct repository *r,
> > =20
> >  	while (type =3D=3D OBJ_OFS_DELTA || type =3D=3D OBJ_REF_DELTA) {
> >  		off_t base_offset;
> > -		unsigned long size;
> > +		size_t size;
> >  		/* Push the object we're going to leave behind */
> >  		if (poi_stack_nr >=3D poi_stack_alloc && poi_stack =3D=3D small_poi=
_stack) {
> >  			poi_stack_alloc =3D alloc_nr(poi_stack_nr);
> > @@ -1586,7 +1590,7 @@ static int packed_object_info_with_index_pos(str=
uct packed_git *p, off_t obj_off
> >  					     uint32_t *maybe_index_pos, struct object_info *oi)
> >  {
> >  	struct pack_window *w_curs =3D NULL;
> > -	unsigned long size;
> > +	size_t size;
> >  	off_t curpos =3D obj_offset;
> >  	enum object_type type =3D OBJ_NONE;
> >  	uint32_t pack_pos;
> > @@ -1778,7 +1782,7 @@ void *unpack_entry(struct repository *r, struct =
packed_git *p, off_t obj_offset,
> >  	struct pack_window *w_curs =3D NULL;
> >  	off_t curpos =3D obj_offset;
> >  	void *data =3D NULL;
> > -	unsigned long size;
> > +	size_t size;
> >  	enum object_type type;
> >  	struct unpack_entry_stack_ent small_delta_stack[UNPACK_ENTRY_STACK_P=
REALLOC];
> >  	struct unpack_entry_stack_ent *delta_stack =3D small_delta_stack;
> > @@ -1943,8 +1947,10 @@ void *unpack_entry(struct repository *r, struct=
 packed_git *p, off_t obj_offset,
> >  			      (uintmax_t)curpos, p->pack_name);
> >  			data =3D NULL;
> >  		} else {
> > +			unsigned long sz;
> >  			data =3D patch_delta(base, base_size, delta_data,
> > -					   delta_size, &size);
> > +					   delta_size, &sz);
> > +			size =3D sz;
> > =20
> >  			/*
> >  			 * We could not apply the delta; warn the user, but
> > @@ -2929,7 +2935,7 @@ int packfile_read_object_stream(struct odb_read_=
stream **out,
> >  	struct odb_packed_read_stream *stream;
> >  	struct pack_window *window =3D NULL;
> >  	enum object_type in_pack_type;
> > -	unsigned long size;
> > +	size_t size;
> > =20
> >  	in_pack_type =3D unpack_object_header(pack, &window, &offset, &size)=
;
> >  	unuse_pack(&window);
> > diff --git a/packfile.h b/packfile.h
> > index 9b647da7dd..49d6bdecf6 100644
> > --- a/packfile.h
> > +++ b/packfile.h
> > @@ -456,9 +456,9 @@ off_t find_pack_entry_one(const struct object_id *=
oid, struct packed_git *);
> > =20
> >  int is_pack_valid(struct packed_git *);
> >  void *unpack_entry(struct repository *r, struct packed_git *, off_t, =
enum object_type *, unsigned long *);
> > -unsigned long unpack_object_header_buffer(const unsigned char *buf, u=
nsigned long len, enum object_type *type, unsigned long *sizep);
> > +unsigned long unpack_object_header_buffer(const unsigned char *buf, u=
nsigned long len, enum object_type *type, size_t *sizep);
> >  unsigned long get_size_from_delta(struct packed_git *, struct pack_wi=
ndow **, off_t);
> > -int unpack_object_header(struct packed_git *, struct pack_window **, =
off_t *, unsigned long *);
> > +int unpack_object_header(struct packed_git *, struct pack_window **, =
off_t *, size_t *);
> >  off_t get_delta_base(struct packed_git *p, struct pack_window **w_cur=
s,
> >  		     off_t *curpos, enum object_type type,
> >  		     off_t delta_obj_offset);
> > --=20
> > gitgitgadget
> >=20
> >=20
>=20

--8323328-1816913923-1778225925=:12327--
