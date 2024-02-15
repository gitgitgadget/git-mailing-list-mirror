Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A037D128382
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996141; cv=none; b=ZUJ79fNJvCLkWZI6DWexUK6Jw0nH5h+c/h298ZbhiAh9d1ujwAUQMm/QnhKHjLXuuK9HV+0VNZJXMHINdd6+OtEb6nlMvnleOTN+CsCBmOlOcYoGPOnkVzTFJiaIWlRl/JGeiECQo1u+5R3ARI6eNNp1jwMpkZ6fgGuxdAQ07SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996141; c=relaxed/simple;
	bh=eKrAdNNPnlZtkj7bKaTnn1AHaWxQbo/jKz0sxfiw0v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6Azkx+meFFsK7MqBxbAFJINqfSGfjC/juvhnhwLvQHVubGJTAezQUut0ysJZxziIgqcDpepCTaLNZtFlOv3tI/JrqvMqZim3D9Qjagys8BKBccoS9ILcXFNWKtURhB8S6kAiDt/6Sl7Fg+zVkc5GrWhug9dkawWf6AiSuf9c2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JGOp8q49; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RreZwJZO; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JGOp8q49";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RreZwJZO"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8434613800F1;
	Thu, 15 Feb 2024 06:22:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Feb 2024 06:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707996138; x=1708082538; bh=mUSeW+JMhM
	KfdnOiOOBdu2yS9boxxwN0IA2hAKNAcyA=; b=JGOp8q49xnfRaNcLGUH/71tH5w
	ah/g296a5B1ftNM7BUV0icK8xX5jeRomXtWPHHBB7yN47O3jUGI4b9qhsGwO37if
	hHXq3nOYGP6ObBE1z5ZqtEndmuaMqP5eAaCEK2pFh0Q0c8OivaRc9jO0gHYZEVX4
	r+vok41ephN7tmX8i1Yf13iNDw2NcvyoS/gsyIqbHmn2hVfrBCC4VpmevM11TLUH
	jtxD3EC9PQsw2CYceMhINjbkujrnYIFxw5t0eAzHLLwiDNcw76P+N+8g9lBrFPJJ
	9gPwlJbwFMl4+HYT+rC12bmMJ9GlrvtV4tZjGpG0G3f3YtP4ifYcIZQRu1rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707996138; x=1708082538; bh=mUSeW+JMhMKfdnOiOOBdu2yS9box
	xwN0IA2hAKNAcyA=; b=RreZwJZOHjmxqBOBLhwhNepEsaGWoc1fGnC7t7xjtR7I
	/6pad1lvwjufDcqBC6Xt/fvwXvRLAoP2JHGn2lbRNBJzi4KPAHDo677Dox4F/pjl
	3qeGUSmm8MF7kqoQQlRYNlSc6k2fQfDb5L53DmsLtEzkDiMRQ1c1XOkp+DJmY9En
	FWz/eGT3cV04BcHHSberzpx/ex/YspKScFUbnywFlDKpe5CvyvJN6lN8LQtkTfXO
	SwcWjxbBbtyyYJOs9fu418VDI6rmSkU73+7BTgaUMOJtv0c5iIC1JSHzgToLcrJH
	tYG5qnzN2OtkPbwY00sKDMTFn/Tsgo0gDetSK6DXPQ==
X-ME-Sender: <xms:6vPNZZXtbiY2oRZr1SmojvOZvjbhaFD23ZZZTZ1v3YsEWPrz5vlpzA>
    <xme:6vPNZZkiAYo-OUDyv1CO_n5NtRS6VLHMPcv9nSRjnWlPD412k2hFkLB5LOV6bzPBV
    ZpIYgLSkOmhKTkdjg>
X-ME-Received: <xmr:6vPNZVaJ_VHtb3sNLdptIRquEHlrOENgtKboSLodFU4fcAxM62Ej3bXt6nP3MoJCTpXxNz85TJjI1rh9URkBmsk7uRqNjFjyyhSmU5n-PNs9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:6vPNZcUpgibAViqduxKoUGrWr3PawtR1A0UnbPt4BToT2zxehgX2MQ>
    <xmx:6vPNZTmL0upOti7dNVE8VbhVAsdiiIDtkLLdCryAjYH1U0CdJKU9uw>
    <xmx:6vPNZZcZLWxh2SbqwJni1Pq5uJOkKeX2nGxwSqysaAH8f-ZVXkP8hA>
    <xmx:6vPNZRbi9tLKnqbYIqWDljrse34r7HjV_3ukn13UD_dls-MuWDWPTA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 06:22:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 78142020 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 11:18:25 +0000 (UTC)
Date: Thu, 15 Feb 2024 12:22:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Eric W. Biederman" <ebiederm@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 07/30] object-file: update the loose object map when
 writing loose objects
Message-ID: <Zc3z53gXllPafrFr@tanuki>
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
 <20231002024034.2611-7-ebiederm@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cnoDTZWGAFZ18xHQ"
Content-Disposition: inline
In-Reply-To: <20231002024034.2611-7-ebiederm@gmail.com>


--cnoDTZWGAFZ18xHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 09:40:11PM -0500, Eric W. Biederman wrote:
> From: "Eric W. Biederman" <ebiederm@xmission.com>
>=20
> To implement SHA1 compatibility on SHA256 repositories the loose
> object map needs to be updated whenver a loose object is written.

Not only when loose objects are written, but also when packfiles are
written e.g. when accepting a push via git-receive-pack(1). Basically,
whenever an object gets written into the main object database.

This also brings up another interesting angle: how will this work in the
context of alternate object directories? We have no control over new
objects being written into those, and thus the object mapping that we
have in our satellite repository that uses the alternate would be out of
date.

I think this is another indicator that stacking might be the right way
to go. Like that, the stack of object maps would be the main stack plus
all stack of alternates concatenated. Finding a mapping would then have
to go through all of these maps to find the desired object.

> Updating the loose object map this way allows git to support
> the old hash algorithm in constant time.

As mentioned before, appending objects is constant-time, but the reading
side is unfortunately not. It's probably more something like `O(nlogn)`
because we have to load all objects and add each of the objects into the
map, which I expect to be `O(logn)`. So the reading time isn't even
linear.

Patrick

> The functions write_loose_object, and stream_loose_object are
> the only two functions that write to the loose object store.
>=20
> Update stream_loose_object to compute the compatibiilty hash, update
> the loose object, and then call repo_add_loose_object_map to update
> the loose object map.
>=20
> Update write_object_file_flags to convert the object into
> it's compatibility encoding, hash the compatibility encoding,
> write the object, and then update the loose object map.
>=20
> Update force_object_loose to lookup the hash of the compatibility
> encoding, write the loose object, and then update the loose object
> map.
>=20
> Update write_object_file_literally to convert the object into it's
> compatibility hash encoding, hash the compatibility enconding, write
> the object, and then update the loose object map, when the type string
> is a known type.  For objects with an unknown type this results in a
> partially broken repository, as the objects are not mapped.
>=20
> The point of write_object_file_literally is to generate a partially
> broken repository for testing.  For testing skipping writing the loose
> object map is much more useful than refusing to write the broken
> object at all.
>=20
> Except that the loose objects are updated before the loose object map
> I have not done any analysis to see how robust this scheme is in the
> event of failure.
>=20
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  object-file.c | 113 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 95 insertions(+), 18 deletions(-)
>=20
> diff --git a/object-file.c b/object-file.c
> index 7dc0c4bfbba8..4e55f475b3b4 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -43,6 +43,8 @@
>  #include "setup.h"
>  #include "submodule.h"
>  #include "fsck.h"
> +#include "loose.h"
> +#include "object-file-convert.h"
> =20
>  /* The maximum size for an object header. */
>  #define MAX_HEADER_LEN 32
> @@ -1952,9 +1954,12 @@ static int start_loose_object_common(struct strbuf=
 *tmp_file,
>  				     const char *filename, unsigned flags,
>  				     git_zstream *stream,
>  				     unsigned char *buf, size_t buflen,
> -				     git_hash_ctx *c,
> +				     git_hash_ctx *c, git_hash_ctx *compat_c,
>  				     char *hdr, int hdrlen)
>  {
> +	struct repository *repo =3D the_repository;
> +	const struct git_hash_algo *algo =3D repo->hash_algo;
> +	const struct git_hash_algo *compat =3D repo->compat_hash_algo;
>  	int fd;
> =20
>  	fd =3D create_tmpfile(tmp_file, filename);
> @@ -1974,14 +1979,18 @@ static int start_loose_object_common(struct strbu=
f *tmp_file,
>  	git_deflate_init(stream, zlib_compression_level);
>  	stream->next_out =3D buf;
>  	stream->avail_out =3D buflen;
> -	the_hash_algo->init_fn(c);
> +	algo->init_fn(c);
> +	if (compat && compat_c)
> +		compat->init_fn(compat_c);
> =20
>  	/*  Start to feed header to zlib stream */
>  	stream->next_in =3D (unsigned char *)hdr;
>  	stream->avail_in =3D hdrlen;
>  	while (git_deflate(stream, 0) =3D=3D Z_OK)
>  		; /* nothing */
> -	the_hash_algo->update_fn(c, hdr, hdrlen);
> +	algo->update_fn(c, hdr, hdrlen);
> +	if (compat && compat_c)
> +		compat->update_fn(compat_c, hdr, hdrlen);
> =20
>  	return fd;
>  }
> @@ -1990,16 +1999,21 @@ static int start_loose_object_common(struct strbu=
f *tmp_file,
>   * Common steps for the inner git_deflate() loop for writing loose
>   * objects. Returns what git_deflate() returns.
>   */
> -static int write_loose_object_common(git_hash_ctx *c,
> +static int write_loose_object_common(git_hash_ctx *c, git_hash_ctx *comp=
at_c,
>  				     git_zstream *stream, const int flush,
>  				     unsigned char *in0, const int fd,
>  				     unsigned char *compressed,
>  				     const size_t compressed_len)
>  {
> +	struct repository *repo =3D the_repository;
> +	const struct git_hash_algo *algo =3D repo->hash_algo;
> +	const struct git_hash_algo *compat =3D repo->compat_hash_algo;
>  	int ret;
> =20
>  	ret =3D git_deflate(stream, flush ? Z_FINISH : 0);
> -	the_hash_algo->update_fn(c, in0, stream->next_in - in0);
> +	algo->update_fn(c, in0, stream->next_in - in0);
> +	if (compat && compat_c)
> +		compat->update_fn(compat_c, in0, stream->next_in - in0);
>  	if (write_in_full(fd, compressed, stream->next_out - compressed) < 0)
>  		die_errno(_("unable to write loose object file"));
>  	stream->next_out =3D compressed;
> @@ -2014,15 +2028,21 @@ static int write_loose_object_common(git_hash_ctx=
 *c,
>   * - End the compression of zlib stream.
>   * - Get the calculated oid to "oid".
>   */
> -static int end_loose_object_common(git_hash_ctx *c, git_zstream *stream,
> -				   struct object_id *oid)
> +static int end_loose_object_common(git_hash_ctx *c, git_hash_ctx *compat=
_c,
> +				   git_zstream *stream, struct object_id *oid,
> +				   struct object_id *compat_oid)
>  {
> +	struct repository *repo =3D the_repository;
> +	const struct git_hash_algo *algo =3D repo->hash_algo;
> +	const struct git_hash_algo *compat =3D repo->compat_hash_algo;
>  	int ret;
> =20
>  	ret =3D git_deflate_end_gently(stream);
>  	if (ret !=3D Z_OK)
>  		return ret;
> -	the_hash_algo->final_oid_fn(oid, c);
> +	algo->final_oid_fn(oid, c);
> +	if (compat && compat_c)
> +		compat->final_oid_fn(compat_oid, compat_c);
> =20
>  	return Z_OK;
>  }
> @@ -2046,7 +2066,7 @@ static int write_loose_object(const struct object_i=
d *oid, char *hdr,
> =20
>  	fd =3D start_loose_object_common(&tmp_file, filename.buf, flags,
>  				       &stream, compressed, sizeof(compressed),
> -				       &c, hdr, hdrlen);
> +				       &c, NULL, hdr, hdrlen);
>  	if (fd < 0)
>  		return -1;
> =20
> @@ -2056,14 +2076,14 @@ static int write_loose_object(const struct object=
_id *oid, char *hdr,
>  	do {
>  		unsigned char *in0 =3D stream.next_in;
> =20
> -		ret =3D write_loose_object_common(&c, &stream, 1, in0, fd,
> +		ret =3D write_loose_object_common(&c, NULL, &stream, 1, in0, fd,
>  						compressed, sizeof(compressed));
>  	} while (ret =3D=3D Z_OK);
> =20
>  	if (ret !=3D Z_STREAM_END)
>  		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
>  		    ret);
> -	ret =3D end_loose_object_common(&c, &stream, &parano_oid);
> +	ret =3D end_loose_object_common(&c, NULL, &stream, &parano_oid, NULL);
>  	if (ret !=3D Z_OK)
>  		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
>  		    ret);
> @@ -2108,10 +2128,12 @@ static int freshen_packed_object(const struct obj=
ect_id *oid)
>  int stream_loose_object(struct input_stream *in_stream, size_t len,
>  			struct object_id *oid)
>  {
> +	const struct git_hash_algo *compat =3D the_repository->compat_hash_algo;
> +	struct object_id compat_oid;
>  	int fd, ret, err =3D 0, flush =3D 0;
>  	unsigned char compressed[4096];
>  	git_zstream stream;
> -	git_hash_ctx c;
> +	git_hash_ctx c, compat_c;
>  	struct strbuf tmp_file =3D STRBUF_INIT;
>  	struct strbuf filename =3D STRBUF_INIT;
>  	int dirlen;
> @@ -2135,7 +2157,7 @@ int stream_loose_object(struct input_stream *in_str=
eam, size_t len,
>  	 */
>  	fd =3D start_loose_object_common(&tmp_file, filename.buf, 0,
>  				       &stream, compressed, sizeof(compressed),
> -				       &c, hdr, hdrlen);
> +				       &c, &compat_c, hdr, hdrlen);
>  	if (fd < 0) {
>  		err =3D -1;
>  		goto cleanup;
> @@ -2153,7 +2175,7 @@ int stream_loose_object(struct input_stream *in_str=
eam, size_t len,
>  			if (in_stream->is_finished)
>  				flush =3D 1;
>  		}
> -		ret =3D write_loose_object_common(&c, &stream, flush, in0, fd,
> +		ret =3D write_loose_object_common(&c, &compat_c, &stream, flush, in0, =
fd,
>  						compressed, sizeof(compressed));
>  		/*
>  		 * Unlike write_loose_object(), we do not have the entire
> @@ -2176,7 +2198,7 @@ int stream_loose_object(struct input_stream *in_str=
eam, size_t len,
>  	 */
>  	if (ret !=3D Z_STREAM_END)
>  		die(_("unable to stream deflate new object (%d)"), ret);
> -	ret =3D end_loose_object_common(&c, &stream, oid);
> +	ret =3D end_loose_object_common(&c, &compat_c, &stream, oid, &compat_oi=
d);
>  	if (ret !=3D Z_OK)
>  		die(_("deflateEnd on stream object failed (%d)"), ret);
>  	close_loose_object(fd, tmp_file.buf);
> @@ -2203,6 +2225,8 @@ int stream_loose_object(struct input_stream *in_str=
eam, size_t len,
>  	}
> =20
>  	err =3D finalize_object_file(tmp_file.buf, filename.buf);
> +	if (!err && compat)
> +		err =3D repo_add_loose_object_map(the_repository, oid, &compat_oid);
>  cleanup:
>  	strbuf_release(&tmp_file);
>  	strbuf_release(&filename);
> @@ -2213,17 +2237,38 @@ int write_object_file_flags(const void *buf, unsi=
gned long len,
>  			    enum object_type type, struct object_id *oid,
>  			    unsigned flags)
>  {
> +	struct repository *repo =3D the_repository;
> +	const struct git_hash_algo *algo =3D repo->hash_algo;
> +	const struct git_hash_algo *compat =3D repo->compat_hash_algo;
> +	struct object_id compat_oid;
>  	char hdr[MAX_HEADER_LEN];
>  	int hdrlen =3D sizeof(hdr);
> =20
> +	/* Generate compat_oid */
> +	if (compat) {
> +		if (type =3D=3D OBJ_BLOB)
> +			hash_object_file(compat, buf, len, type, &compat_oid);
> +		else {
> +			struct strbuf converted =3D STRBUF_INIT;
> +			convert_object_file(&converted, algo, compat,
> +					    buf, len, type, 0);
> +			hash_object_file(compat, converted.buf, converted.len,
> +					 type, &compat_oid);
> +			strbuf_release(&converted);
> +		}
> +	}
> +
>  	/* Normally if we have it in the pack then we do not bother writing
>  	 * it out into .git/objects/??/?{38} file.
>  	 */
> -	write_object_file_prepare(the_hash_algo, buf, len, type, oid, hdr,
> -				  &hdrlen);
> +	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
>  	if (freshen_packed_object(oid) || freshen_loose_object(oid))
>  		return 0;
> -	return write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
> +	if (write_loose_object(oid, hdr, hdrlen, buf, len, 0, flags))
> +		return -1;
> +	if (compat)
> +		return repo_add_loose_object_map(repo, oid, &compat_oid);
> +	return 0;
>  }
> =20
>  int write_object_file_literally(const void *buf, unsigned long len,
> @@ -2231,7 +2276,27 @@ int write_object_file_literally(const void *buf, u=
nsigned long len,
>  				unsigned flags)
>  {
>  	char *header;
> +	struct repository *repo =3D the_repository;
> +	const struct git_hash_algo *algo =3D repo->hash_algo;
> +	const struct git_hash_algo *compat =3D repo->compat_hash_algo;
> +	struct object_id compat_oid;
>  	int hdrlen, status =3D 0;
> +	int compat_type =3D -1;
> +
> +	if (compat) {
> +		compat_type =3D type_from_string_gently(type, -1, 1);
> +		if (compat_type =3D=3D OBJ_BLOB)
> +			hash_object_file(compat, buf, len, compat_type,
> +					 &compat_oid);
> +		else if (compat_type !=3D -1) {
> +			struct strbuf converted =3D STRBUF_INIT;
> +			convert_object_file(&converted, algo, compat,
> +					    buf, len, compat_type, 0);
> +			hash_object_file(compat, converted.buf, converted.len,
> +					 compat_type, &compat_oid);
> +			strbuf_release(&converted);
> +		}
> +	}
> =20
>  	/* type string, SP, %lu of the length plus NUL must fit this */
>  	hdrlen =3D strlen(type) + MAX_HEADER_LEN;
> @@ -2244,6 +2309,8 @@ int write_object_file_literally(const void *buf, un=
signed long len,
>  	if (freshen_packed_object(oid) || freshen_loose_object(oid))
>  		goto cleanup;
>  	status =3D write_loose_object(oid, header, hdrlen, buf, len, 0, 0);
> +	if (compat_type !=3D -1)
> +		return repo_add_loose_object_map(repo, oid, &compat_oid);
> =20
>  cleanup:
>  	free(header);
> @@ -2252,9 +2319,12 @@ int write_object_file_literally(const void *buf, u=
nsigned long len,
> =20
>  int force_object_loose(const struct object_id *oid, time_t mtime)
>  {
> +	struct repository *repo =3D the_repository;
> +	const struct git_hash_algo *compat =3D repo->compat_hash_algo;
>  	void *buf;
>  	unsigned long len;
>  	struct object_info oi =3D OBJECT_INFO_INIT;
> +	struct object_id compat_oid;
>  	enum object_type type;
>  	char hdr[MAX_HEADER_LEN];
>  	int hdrlen;
> @@ -2267,8 +2337,15 @@ int force_object_loose(const struct object_id *oid=
, time_t mtime)
>  	oi.contentp =3D &buf;
>  	if (oid_object_info_extended(the_repository, oid, &oi, 0))
>  		return error(_("cannot read object for %s"), oid_to_hex(oid));
> +	if (compat) {
> +		if (repo_oid_to_algop(repo, oid, compat, &compat_oid))
> +			return error(_("cannot map object %s to %s"),
> +				     oid_to_hex(oid), compat->name);
> +	}
>  	hdrlen =3D format_object_header(hdr, sizeof(hdr), type, len);
>  	ret =3D write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
> +	if (!ret && compat)
> +		ret =3D repo_add_loose_object_map(the_repository, oid, &compat_oid);
>  	free(buf);
> =20
>  	return ret;
> --=20
> 2.41.0
>=20

--cnoDTZWGAFZ18xHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN8+YACgkQVbJhu7ck
PpQVjw/9HDw2/PNVO3A4WbgIZtbtnad+cGJoaDl/epA92DvFeSAtsBw5g15NlgDF
S0fJgxUefHHyxGYVfooto7n8oCPpReWhhDXwzlHGkAyAzqQqP3cv7ZZR+GZR7yxW
eDhGi+LDwCVj7UiqS3BApAHEe1VZssEPiCUo4s4ZY1HheG2wnCqPju5A5Y6bBIVP
9hHarcttSFASHXw3rUus1UjCvpZsTOGaylQ2mGVzh+FKs+unmRpQ+h81e81SxX9j
d8Z2mbY6DnvMBuT+9Zd26TjIvg2TgkZokQNCXUKTCc++9r1J+MqV2zD+kPnJWQQQ
yS0ghUyVQ1fTwSTyZsc7Lu7X1lL8wbcfZdw2fl3cmOI38M2LkmbDSfCxIrbcleU3
EAWviJIIhjqv9PTLP0zOK32v2GDXnyJ4C6rH7ZJpxwK+Vd+//1IZpn6dUTJH0L6P
GMfofwI5mXmICkr7JLpLddcKYKHSwrkInea7P+yNGS5CQ/0NRDLUqa0K4sQnTg3f
xstlltCgLFOIxsuE2orQBADM5LcrxOJHe0rC7B8fPBI4B/AV6YhQTw7iVHcGb7rw
vItk/QnsJiCQpuAbPy7+EDdGe++xUXnY/ETElTUcy+8Y5S9NQoGX9L5LU0GIDRVD
2lm0KGDk4W3IEJ4G1paAk24rBCcW02BXj3YXd59TA6gMKx9+6IM=
=8+Ns
-----END PGP SIGNATURE-----

--cnoDTZWGAFZ18xHQ--
