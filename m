Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB6128382
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996131; cv=none; b=gdwJAiccpI/dCl2Xlc/kRojwlbxjV1i34Cjg+/jGc1nrcs7u3EX7QAuPaTb8ia8Okjv2x3krjtK2PMXLylMC2lh33ntLJT8FMH8r7n3Zn4Z+MXV7gxjKJKm3LC0vTdBz1XgQXsYjZymBjpIeHQg+q6hZU+pxuNlvW4c0DvQ3cLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996131; c=relaxed/simple;
	bh=jBZjholDjr8I8rhvZgCDFs2S5McYtvhwZO6hep2Ggaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1XhjeWTLVip455I1tc9KnV4xJw9g1BIc5T6f76UGGngap3UogK5Jx+OD8AQfQRbNQRAsRYI+W1xLEEBhTHlolF6zv0YKo9/BJROAfqTbEtKyDI1w7wNu5ZABzMk2rnf8ZUojHt+t7ayGldwFKLehRqz8RfMJasH7a8bhzGW4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fE0MbUC2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UbnTi3f2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fE0MbUC2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbnTi3f2"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C726013800F0;
	Thu, 15 Feb 2024 06:22:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Feb 2024 06:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707996127; x=1708082527; bh=N5GTME1zwe
	CNzVw8NKmMcHs4+HS6WuEsj5IzooZa6Oc=; b=fE0MbUC29Ee61EAwsg0ozbqApe
	wNENY7Ob+ypGw9dJ8D9tKnxUgF7hBBpXXLzLvhID3ISyZAHwfN1Y8OraIPZfbwF6
	frWLrYQktT4XTSkK4omqdDJqxv3x61xBbKRhIilvwAZUSzar08PHPoxlraKzJens
	8ejmhvD3yIitNcACU3PxgaDEa6pkuQdJyTp3i6viWhuZYBi7hcyiXzqvnoH/MOFm
	BHSNaWymkdszHsVQO5UrRlzGFgNUirrffZaZOX1or0DzUvqY/LO3DURDu8jEKi4Z
	LfEKOCMELoH8cuhISVTiV16smyYxPjVWoVBD487rGqaQ8B8FehWNKSGg5/Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707996127; x=1708082527; bh=N5GTME1zweCNzVw8NKmMcHs4+HS6
	WuEsj5IzooZa6Oc=; b=UbnTi3f2cibe9r2Kq0vgjPcqbsJWRXn+w2pixfJZylG8
	DhVnbb63qcC0evxet1IhldQs9oqLt8nB17SmiDiDJSuLnM3gVZ9oL587blMirdJI
	7SenAxS7eR7Bx84l2sbS60mN7E3te0Y6WdL3FG4uc9YniI/3i88687OGHbvklslK
	BuEz1LHISiyfFDsio79xPA4+Buqhv9g5Tow1yhXXy9F2Jdcuf09ZpgBaXZysKdgs
	68twPTI5HMfgFNJbKQtI05QnFKyQ0AYwiuUzMlN+RFslfjQ5P0Wg0uCK+m8qtZIA
	AUWECsc0SqhFXPjXqS89foZVEdXmWgiBR4cV0xAaJg==
X-ME-Sender: <xms:3_PNZedzDygL57YOg9SwD7I1wsMU4cnQ4ZmFIgEqaMBgSY8n8R-9Wg>
    <xme:3_PNZYP_n2PeUAGb0Hs8MWFMJMuldt2YymnZ6DQq3_9IwNxe1kVGk2yUsPR2alpl1
    _9LYOSms7Bfbcb69g>
X-ME-Received: <xmr:3_PNZfjU00iDGG_uBsMoEkRl3nbEC6Y6OE18sSHzxV9AnHO59El6b0RAsqCUdOV6YrAnv7IWlz3d-i9ALq8GNcrxIfdayW0K6rSyLOCzSf3O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:3_PNZb_pC_11k8Xww148dF7Lb-iBAu5u7NMIlVRBAZQkDdqOOSWnKg>
    <xmx:3_PNZavka8zM-k1UNYqAkk9QUWURUt_AQgX0C_A1NkxL11N3YNsfJg>
    <xmx:3_PNZSGb7JGV2uXFPajUWKCuYXh_BUlihwqiVRUJVh0L7WMhQdkH5g>
    <xmx:3_PNZeig7RoJcMIeq--wazqr8KOd2OQF_myMwUr9syRzMxFfVdMDNw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 06:22:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cfc3616d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 11:18:14 +0000 (UTC)
Date: Thu, 15 Feb 2024 12:22:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 05/30] loose: add a mapping between SHA-1 and SHA-256
 for loose objects
Message-ID: <Zc3z3YhIzCcUxXlI@tanuki>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <20231002024034.2611-5-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wG/VppaAX2UGndbh"
Content-Disposition: inline
In-Reply-To: <20231002024034.2611-5-ebiederm@gmail.com>


--wG/VppaAX2UGndbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 09:40:09PM -0500, Eric W. Biederman wrote:
> From: "brian m. carlson" <sandals@crustytoothpaste.net>
>=20
> As part of the transition plan, we'd like to add a file in the .git
> directory that maps loose objects between SHA-1 and SHA-256.  Let's
> implement the specification in the transition plan and store this data
> on a per-repository basis in struct repository.
>=20
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  Makefile              |   1 +
>  loose.c               | 246 ++++++++++++++++++++++++++++++++++++++++++
>  loose.h               |  22 ++++
>  object-file-convert.c |  14 ++-
>  object-store-ll.h     |   3 +
>  object.c              |   2 +
>  repository.c          |   6 ++
>  7 files changed, 293 insertions(+), 1 deletion(-)
>  create mode 100644 loose.c
>  create mode 100644 loose.h
>=20
> diff --git a/Makefile b/Makefile
> index f7e824f25cda..3c18664def9a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1053,6 +1053,7 @@ LIB_OBJS +=3D list-objects-filter.o
>  LIB_OBJS +=3D list-objects.o
>  LIB_OBJS +=3D lockfile.o
>  LIB_OBJS +=3D log-tree.o
> +LIB_OBJS +=3D loose.o
>  LIB_OBJS +=3D ls-refs.o
>  LIB_OBJS +=3D mailinfo.o
>  LIB_OBJS +=3D mailmap.o
> diff --git a/loose.c b/loose.c
> new file mode 100644
> index 000000000000..6ba73cc84dca
> --- /dev/null
> +++ b/loose.c

When reading "loose" I immediately think about loose objects, only. I
would not consider this about mapping object IDs, which I expect would
also happen for packed objects?

It very much seems like you explicitly only care about loose objects in
the code here, which is weird to me. If that is in fact intentional
because we learn to store the compat object hash in pack files over the
course of this patch seires then it would make sense to explain this a
bit more in depth.

> @@ -0,0 +1,246 @@
> +#include "git-compat-util.h"
> +#include "hash.h"
> +#include "path.h"
> +#include "object-store.h"
> +#include "hex.h"
> +#include "wrapper.h"
> +#include "gettext.h"
> +#include "loose.h"
> +#include "lockfile.h"
> +
> +static const char *loose_object_header =3D "# loose-object-idx\n";
> +
> +static inline int should_use_loose_object_map(struct repository *repo)
> +{
> +	return repo->compat_hash_algo && repo->gitdir;
> +}
> +
> +void loose_object_map_init(struct loose_object_map **map)
> +{
> +	struct loose_object_map *m;
> +	m =3D xmalloc(sizeof(**map));
> +	m->to_compat =3D kh_init_oid_map();
> +	m->to_storage =3D kh_init_oid_map();
> +	*map =3D m;
> +}
> +
> +static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *ke=
y, const struct object_id *value)
> +{
> +	khiter_t pos;
> +	int ret;
> +	struct object_id *stored;
> +
> +	pos =3D kh_put_oid_map(map, *key, &ret);
> +
> +	/* This item already exists in the map. */
> +	if (ret =3D=3D 0)
> +		return 0;

Should we safeguard this and compare whether the key's value matches the
passed-in value? One of the more general themes that I'm worried about
is what happens when we hit hash collisions (e.g. two objects mapping to
the same SHA1, but different SHA256 hashes), and safeguarding us against
this possibility feels sensible to me.

> +	stored =3D xmalloc(sizeof(*stored));
> +	oidcpy(stored, value);
> +	kh_value(map, pos) =3D stored;
> +	return 1;
> +}
> +
> +static int load_one_loose_object_map(struct repository *repo, struct obj=
ect_directory *dir)
> +{
> +	struct strbuf buf =3D STRBUF_INIT, path =3D STRBUF_INIT;
> +	FILE *fp;
> +
> +	if (!dir->loose_map)
> +		loose_object_map_init(&dir->loose_map);
> +
> +	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_tree,=
 repo->compat_hash_algo->empty_tree);
> +	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->emp=
ty_tree, repo->hash_algo->empty_tree);
> +
> +	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_blob,=
 repo->compat_hash_algo->empty_blob);
> +	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->emp=
ty_blob, repo->hash_algo->empty_blob);
> +
> +	insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->null_oid, r=
epo->compat_hash_algo->null_oid);
> +	insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->nul=
l_oid, repo->hash_algo->null_oid);
> +
> +	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
> +	fp =3D fopen(path.buf, "rb");
> +	if (!fp) {
> +		strbuf_release(&path);
> +		return 0;

I think we should discern ENOENT from other errors. Failing gracefully
when the file doesn't exist may be sensible, but not when we failed due
to something like an I/O error.

> +	}
> +
> +	errno =3D 0;
> +	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object=
_header))
> +		goto err;
> +	while (!strbuf_getline_lf(&buf, fp)) {
> +		const char *p;
> +		struct object_id oid, compat_oid;
> +		if (parse_oid_hex_algop(buf.buf, &oid, &p, repo->hash_algo) ||
> +		    *p++ !=3D ' ' ||
> +		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
> +		    p !=3D buf.buf + buf.len)
> +			goto err;
> +		insert_oid_pair(dir->loose_map->to_compat, &oid, &compat_oid);
> +		insert_oid_pair(dir->loose_map->to_storage, &compat_oid, &oid);
> +	}

Is the actual format specified anywhere? I have to wonder about the
scalability of such a format that uses a simple line-based format for
every object ID. Two main concerns:

  1. If the format is unsorted and we simply append to it whenever the
     repo gains new objects then we are forced to always load the
     complete map into memory. This would be quite inefficient in larger
     repositories that have millions of objects. Every line contains two
     object hashes as well as two whitespace characters, which amounts
     to `(2 + 40 + 64) * $numobjects` many bytes.

     For linux.git with more than 10 million objects, the map would thus
     be around 1GB in size. Loading that into memory and converting it
     into maps feels prohibitively expensive to me.

  2. If the format was sorted then we could perform binary searches
     inside the format to look up object IDs because we know that each
     line has a fixed length. On the other hand, adding new objects
     would require us to rewrite the whole file every time.

I think loading the complete object map into memory is simply too
expensive in any larger "real-world" repository. But rewriting a sorted
file format every time we add new objects feels sufficiently expensive,
too. Neither of these properties sounds like it would be feasible to use
for larger Git hosting platforms. So I think we should put some more
thought into this.

Some proposals:

  - We shouldn't store hex characters but raw object IDs, thus reducing
    the size of the file by almost half.

  - We should store the file sorted so that we can avoid loading it into
    memory and do binary searches.

  - We might grow this into a "stack" of object maps so that it becomes
    easier to add new objects to the map without having to rewrite it
    every time. With geometric repacking this should be somewhat
    manageable.

We don't have to do all of this right from the beginning, I just want to
start the discussion around this.

> +	strbuf_release(&buf);
> +	strbuf_release(&path);
> +	return errno ? -1 : 0;

It feels quite fragile to me to check for `errno` in this way. Should we
instead check `ferror(fp)`?

> +err:
> +	strbuf_release(&buf);
> +	strbuf_release(&path);
> +	return -1;
> +}

We could deduplicate the error paths by storing the return value into an
`int ret`.

> +int repo_read_loose_object_map(struct repository *repo)
> +{
> +	struct object_directory *dir;
> +
> +	if (!should_use_loose_object_map(repo))
> +		return 0;
> +
> +	prepare_alt_odb(repo);
> +
> +	for (dir =3D repo->objects->odb; dir; dir =3D dir->next) {
> +		if (load_one_loose_object_map(repo, dir) < 0) {
> +			return -1;
> +		}
> +	}

The braces here are not needed.

> +	return 0;
> +}
> +
> +int repo_write_loose_object_map(struct repository *repo)
> +{
> +	kh_oid_map_t *map =3D repo->objects->odb->loose_map->to_compat;
> +	struct lock_file lock;
> +	int fd;
> +	khiter_t iter;
> +	struct strbuf buf =3D STRBUF_INIT, path =3D STRBUF_INIT;
> +
> +	if (!should_use_loose_object_map(repo))
> +		return 0;
> +
> +	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
> +	fd =3D hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_E=
RROR, -1);
> +	iter =3D kh_begin(map);
> +	if (write_in_full(fd, loose_object_header, strlen(loose_object_header))=
 < 0)
> +		goto errout;
> +
> +	for (; iter !=3D kh_end(map); iter++) {
> +		if (kh_exist(map, iter)) {
> +			if (oideq(&kh_key(map, iter), the_hash_algo->empty_tree) ||
> +			    oideq(&kh_key(map, iter), the_hash_algo->empty_blob))
> +				continue;
> +			strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)), oid_to_h=
ex(kh_value(map, iter)));
> +			if (write_in_full(fd, buf.buf, buf.len) < 0)
> +				goto errout;
> +			strbuf_reset(&buf);
> +		}
> +	}
> +	strbuf_release(&buf);
> +	if (commit_lock_file(&lock) < 0) {
> +		error_errno(_("could not write loose object index %s"), path.buf);
> +		strbuf_release(&path);
> +		return -1;
> +	}
> +	strbuf_release(&path);
> +	return 0;
> +errout:
> +	rollback_lock_file(&lock);
> +	strbuf_release(&buf);
> +	error_errno(_("failed to write loose object index %s\n"), path.buf);
> +	strbuf_release(&path);
> +	return -1;

Same here, we should be able to combine cleanup of both the successful
and error paths. It's safe to call `rollback_lock_file()` even if the
file has already been committed.

> +}
> +
> +static int write_one_object(struct repository *repo, const struct object=
_id *oid,
> +			    const struct object_id *compat_oid)
> +{
> +	struct lock_file lock;
> +	int fd;
> +	struct stat st;
> +	struct strbuf buf =3D STRBUF_INIT, path =3D STRBUF_INIT;
> +
> +	strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
> +	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -=
1);
> +
> +	fd =3D open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
> +	if (fd < 0)
> +		goto errout;
> +	if (fstat(fd, &st) < 0)
> +		goto errout;
> +	if (!st.st_size && write_in_full(fd, loose_object_header, strlen(loose_=
object_header)) < 0)
> +		goto errout;
> +
> +	strbuf_addf(&buf, "%s %s\n", oid_to_hex(oid), oid_to_hex(compat_oid));
> +	if (write_in_full(fd, buf.buf, buf.len) < 0)
> +		goto errout;
> +	if (close(fd))
> +		goto errout;

It's not safe to update the file in-place like this. A concurrent reader
may end up seeing partial lines and error out. Also, if we were to crash
we might easily end up with a corrupted mapping file.

> +	adjust_shared_perm(path.buf);
> +	rollback_lock_file(&lock);
> +	strbuf_release(&buf);
> +	strbuf_release(&path);
> +	return 0;
> +errout:
> +	error_errno(_("failed to write loose object index %s\n"), path.buf);
> +	close(fd);
> +	rollback_lock_file(&lock);
> +	strbuf_release(&buf);
> +	strbuf_release(&path);
> +	return -1;

Same.

> +}
> +
> +int repo_add_loose_object_map(struct repository *repo, const struct obje=
ct_id *oid,
> +			      const struct object_id *compat_oid)
> +{
> +	int inserted =3D 0;
> +
> +	if (!should_use_loose_object_map(repo))
> +		return 0;
> +
> +	inserted |=3D insert_oid_pair(repo->objects->odb->loose_map->to_compat,=
 oid, compat_oid);
> +	inserted |=3D insert_oid_pair(repo->objects->odb->loose_map->to_storage=
, compat_oid, oid);
> +	if (inserted)
> +		return write_one_object(repo, oid, compat_oid);
> +	return 0;
> +}
> +
> +int repo_loose_object_map_oid(struct repository *repo,
> +			      const struct object_id *src,
> +			      const struct git_hash_algo *to,
> +			      struct object_id *dest)
> +{
> +	struct object_directory *dir;
> +	kh_oid_map_t *map;
> +	khiter_t pos;
> +
> +	for (dir =3D repo->objects->odb; dir; dir =3D dir->next) {
> +		struct loose_object_map *loose_map =3D dir->loose_map;
> +		if (!loose_map)
> +			continue;
> +		map =3D (to =3D=3D repo->compat_hash_algo) ?
> +			loose_map->to_compat :
> +			loose_map->to_storage;
> +		pos =3D kh_get_oid_map(map, *src);
> +		if (pos < kh_end(map)) {
> +			oidcpy(dest, kh_value(map, pos));
> +			return 0;
> +		}
> +	}
> +	return -1;
> +}
> +
> +void loose_object_map_clear(struct loose_object_map **map)

Nit: I'd rather call it `loose_object_map_release()`. `clear` typically
indicates that we clear contents, but do not end up freeing the
containing structure.

> +{
> +	struct loose_object_map *m =3D *map;
> +	struct object_id *oid;
> +
> +	if (!m)
> +		return;
> +
> +	kh_foreach_value(m->to_compat, oid, free(oid));
> +	kh_foreach_value(m->to_storage, oid, free(oid));
> +	kh_destroy_oid_map(m->to_compat);
> +	kh_destroy_oid_map(m->to_storage);
> +	free(m);
> +	*map =3D NULL;
> +}
> diff --git a/loose.h b/loose.h
> new file mode 100644
> index 000000000000..2c2957072c5f
> --- /dev/null
> +++ b/loose.h
> @@ -0,0 +1,22 @@
> +#ifndef LOOSE_H
> +#define LOOSE_H
> +
> +#include "khash.h"
> +
> +struct loose_object_map {
> +	kh_oid_map_t *to_compat;
> +	kh_oid_map_t *to_storage;
> +};

Any specific reason why you don't use `struct oidmap` here?

Patrick

> +void loose_object_map_init(struct loose_object_map **map);
> +void loose_object_map_clear(struct loose_object_map **map);
> +int repo_loose_object_map_oid(struct repository *repo,
> +			      const struct object_id *src,
> +			      const struct git_hash_algo *dest_algo,
> +			      struct object_id *dest);
> +int repo_add_loose_object_map(struct repository *repo, const struct obje=
ct_id *oid,
> +			      const struct object_id *compat_oid);
> +int repo_read_loose_object_map(struct repository *repo);
> +int repo_write_loose_object_map(struct repository *repo);
> +
> +#endif
> diff --git a/object-file-convert.c b/object-file-convert.c
> index 4777aba83636..1ec945eaa17f 100644
> --- a/object-file-convert.c
> +++ b/object-file-convert.c
> @@ -4,6 +4,7 @@
>  #include "repository.h"
>  #include "hash-ll.h"
>  #include "object.h"
> +#include "loose.h"
>  #include "object-file-convert.h"
> =20
>  int repo_oid_to_algop(struct repository *repo, const struct object_id *s=
rc,
> @@ -21,7 +22,18 @@ int repo_oid_to_algop(struct repository *repo, const s=
truct object_id *src,
>  			oidcpy(dest, src);
>  		return 0;
>  	}
> -	return -1;
> +	if (repo_loose_object_map_oid(repo, src, to, dest)) {
> +		/*
> +		 * We may have loaded the object map at repo initialization but
> +		 * another process (perhaps upstream of a pipe from us) may have
> +		 * written a new object into the map.  If the object is missing,
> +		 * let's reload the map to see if the object has appeared.
> +		 */
> +		repo_read_loose_object_map(repo);
> +		if (repo_loose_object_map_oid(repo, src, to, dest))
> +			return -1;
> +	}
> +	return 0;
>  }
> =20
>  int convert_object_file(struct strbuf *outbuf,
> diff --git a/object-store-ll.h b/object-store-ll.h
> index 26a3895c821c..bc76d6bec80d 100644
> --- a/object-store-ll.h
> +++ b/object-store-ll.h
> @@ -26,6 +26,9 @@ struct object_directory {
>  	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
>  	struct oidtree *loose_objects_cache;
> =20
> +	/* Map between object IDs for loose objects. */
> +	struct loose_object_map *loose_map;
> +
>  	/*
>  	 * This is a temporary object store created by the tmp_objdir
>  	 * facility. Disable ref updates since the objects in the store
> diff --git a/object.c b/object.c
> index 2c61e4c86217..186a0a47c0fb 100644
> --- a/object.c
> +++ b/object.c
> @@ -13,6 +13,7 @@
>  #include "alloc.h"
>  #include "packfile.h"
>  #include "commit-graph.h"
> +#include "loose.h"
> =20
>  unsigned int get_max_object_index(void)
>  {
> @@ -540,6 +541,7 @@ void free_object_directory(struct object_directory *o=
db)
>  {
>  	free(odb->path);
>  	odb_clear_loose_cache(odb);
> +	loose_object_map_clear(&odb->loose_map);
>  	free(odb);
>  }
> =20
> diff --git a/repository.c b/repository.c
> index 80252b79e93e..6214f61cf4e7 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -14,6 +14,7 @@
>  #include "read-cache-ll.h"
>  #include "remote.h"
>  #include "setup.h"
> +#include "loose.h"
>  #include "submodule-config.h"
>  #include "sparse-index.h"
>  #include "trace2.h"
> @@ -109,6 +110,8 @@ void repo_set_compat_hash_algo(struct repository *rep=
o, int algo)
>  	if (hash_algo_by_ptr(repo->hash_algo) =3D=3D algo)
>  		BUG("hash_algo and compat_hash_algo match");
>  	repo->compat_hash_algo =3D algo ? &hash_algos[algo] : NULL;
> +	if (repo->compat_hash_algo)
> +		repo_read_loose_object_map(repo);
>  }
> =20
>  /*
> @@ -201,6 +204,9 @@ int repo_init(struct repository *repo,
>  	if (worktree)
>  		repo_set_worktree(repo, worktree);
> =20
> +	if (repo->compat_hash_algo)
> +		repo_read_loose_object_map(repo);
> +
>  	clear_repository_format(&format);
>  	return 0;
> =20
> --=20
> 2.41.0
>=20

--wG/VppaAX2UGndbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN89wACgkQVbJhu7ck
PpRd9A/8Ci3hyvjkgGhE6+JRA7NI6FRO8gQGCk4g7QbwlV6bv/sbYW0p12wktrPW
5WUH4++FBzUH77tGeszwlXeEWcaMkSeX03tImaDuIiQK8OtMBkho2CJS5poFmTg2
W1gEeIhJRuqecJWw4Dia5i5MXi88SLUIHC1MgWJ++9nsJvdoxgrFJ2zRVpk5hAHa
iIGeTe47Uwsm6pEL+LdegM62t4sIvY8iWw13+MnRtu+jeCAYqCTVVoS1ZJyteD6O
jtv1X67+D8drfSHOdILZeamJgZGcAORL+AvsCVE5OtToLqKKdgVHl5++U8skf8qO
X+hSl4SJnVIw+goKb2HuYC3iG8ITqvXRpWvCT5A3Y0CNTgL4TtPa8O3UbuU6SrP9
3A6zTqoKe5pcV0S21x4Rt+0oyohUh2a1PDVGJnEYKpHShVXnS3NsgXjrzU6jF+Ye
Hh7ZmvjCEJn1RIUEeLeTpZArdv9w+0549UCp4JdryMj9bonQkYTxv8bf0AXMAsx9
cZeZ1mnmqzcDCP/vMNXwjaw12bGVvHv3tEFaFepZ8gQxY+boaun3SVbGM56h/JDA
Vjwms8hwe6jq3qRTk4OfA6f9wFYnAQ7p4d2rZlWm5H/urPG61aJM3mXwjwL9p83/
mdC8FGKFVkb/NNF1lSqqVWkC3NTe9AQbc9bvroedfeLVgeqW8oE=
=cwow
-----END PGP SIGNATURE-----

--wG/VppaAX2UGndbh--
