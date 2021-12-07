Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1CBC433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 11:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbhLGL5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:57:46 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55945 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230001AbhLGL5p (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 06:57:45 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 38C435C023A;
        Tue,  7 Dec 2021 06:54:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 07 Dec 2021 06:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=dOTjRXloMdyloxRyPDfYt46L2h5
        Z+c/8xp7GPaUVf/c=; b=lCjzONArVVB9GTRSaki1XhoNKnK9Kts6oVwzWB1zLWQ
        VtbGsOJiwWe04aSKbC29PscpoSMW2bA24uYYfu4rygLnKLMO5wEIEJ58OpK15TIS
        NRi1qpMMwh9ks+sSssWQyFG00VB9KnkKSQ0Dv8tci2BoUIwX+d67iKhe2ux2sE5U
        v7kiCdw52qJm+i4xifAgrrhXHvHzYeXZMelDG1jrhpbYXWvL75L0/BoQI/FSk+rD
        N0uI73QIqRnU5p5iXMTrUwTdUesijGUg70j/ByOP4LHq0N/UD0W6yn5ODijimxZr
        DoozBzu678DiBBwmeYru3qXt3C8nnMcdwQ0xDIJU7lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dOTjRX
        loMdyloxRyPDfYt46L2h5Z+c/8xp7GPaUVf/c=; b=OSYseDB7BQlz4ihO6WphMO
        OAxlwbzDKOaAH1V8IO9BM4K/e1HVUPxG7jS0Mbu/OpK9Qx/6Hgs8xT0yXT6U0D+D
        yWjETl1HSmT1pqQnNItVOnY1vrTGdZgWnIAqny7NyN4YBWjBuLnle23KugR9JdeM
        8kS58YH+mnktRbMxL8uAYv5j6dZ8w4Ydu6nMqwbPKMGzSV1qAqV3/PJlZ7PZAj77
        hjdLllxkWb6YNP/UAWTRt5fZzTMotaxdebVKlmVddObkwAZu/cGNv8Ahp5E8PM5S
        cYEMubYKZRTuWJs+nhtDQY9nZxDjLMipZIsCBj1piU+tdIpTcWnYGwB6szT8W+Lg
        ==
X-ME-Sender: <xms:Z0uvYWRXzjQrB4japtGKMQa4RElzCz4x4NTy0FpqFvIb9DneVeVELw>
    <xme:Z0uvYbwphW4K25I7E_cKUGj9-JjGQUatnvkIcGueYMypcvzAwx_JLMzNoA6VJnnLp
    7BXj68Fk3tUXuFBCw>
X-ME-Received: <xmr:Z0uvYT0F4ioOcjkKtqdzJyxzjaXhc7AfujLrc75PvWrrkBI0lXWW0l61kWbJ8fDW6baOTB6ecMlg7vQpnkJAH_LDOYOQ_D95uSi-dIVhePNSWOXrCfdTp8Ot>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:Z0uvYSB1EFLCUnfKRRdb844Ltf9iE1HtTBNO0aEoKdSZ-LTZsdDVpw>
    <xmx:Z0uvYfhiALASvP3YxqGTQTZHorfYy9ZoC3fwDCOO0CUQkCGmqJDgtA>
    <xmx:Z0uvYeqPmxaSZUCKwYSUKm3-as6mWKa6WXUpAt95TtisOdzmCgP6Dw>
    <xmx:Z0uvYaVd0Ml-GVJRXR7OCuOV4IcE_0n2pjPFZYUq1h4dgqP-oUH8uQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 06:54:13 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e15f927c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 13:23:49 +0000 (UTC)
Date:   Tue, 7 Dec 2021 12:53:32 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/3] core.fsync: introduce granular fsync control
Message-ID: <Ya9LPOseu8geBi4v@ncase>
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
 <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rj+/7kVG+u/4iNlT"
Content-Disposition: inline
In-Reply-To: <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rj+/7kVG+u/4iNlT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2021 at 02:46:50AM +0000, Neeraj Singh via GitGitGadget wro=
te:
> From: Neeraj Singh <neerajsi@microsoft.com>
[snip]
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index c23d01de7dc..c32534c13b4 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1286,7 +1286,7 @@ static void conclude_pack(int fix_thin_pack, const =
char *curr_pack, unsigned cha
>  			    nr_objects - nr_objects_initial);
>  		stop_progress_msg(&progress, msg.buf);
>  		strbuf_release(&msg);
> -		finalize_hashfile(f, tail_hash, 0);
> +		finalize_hashfile(f, tail_hash, FSYNC_COMPONENT_PACK, 0);
>  		hashcpy(read_hash, pack_hash);
>  		fixup_pack_header_footer(output_fd, pack_hash,
>  					 curr_pack, nr_objects,
> @@ -1508,7 +1508,7 @@ static void final(const char *final_pack_name, cons=
t char *curr_pack_name,
>  	if (!from_stdin) {
>  		close(input_fd);
>  	} else {
> -		fsync_or_die(output_fd, curr_pack_name);
> +		fsync_component_or_die(FSYNC_COMPONENT_PACK, output_fd, curr_pack_name=
);
>  		err =3D close(output_fd);
>  		if (err)
>  			die_errno(_("error while closing pack file"));
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 857be7826f3..916c55d6ce9 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1204,11 +1204,13 @@ static void write_pack_file(void)
>  		 * If so, rewrite it like in fast-import
>  		 */
>  		if (pack_to_stdout) {
> -			finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
> +			finalize_hashfile(f, hash, FSYNC_COMPONENT_NONE,
> +					  CSUM_HASH_IN_STREAM | CSUM_CLOSE);

It doesn't have any effect here given that we don't sync at all when
writing to stdout, but I wonder whether we should set up the component
correctly regardless of that such that it makes for a less confusing
read.

[snip]
> diff --git a/config.c b/config.c
> index c3410b8a868..29c867aab03 100644
> --- a/config.c
> +++ b/config.c
> @@ -1213,6 +1213,73 @@ static int git_parse_maybe_bool_text(const char *v=
alue)
>  	return -1;
>  }
> =20
> +static const struct fsync_component_entry {
> +	const char *name;
> +	enum fsync_component component_bits;
> +} fsync_component_table[] =3D {
> +	{ "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
> +	{ "pack", FSYNC_COMPONENT_PACK },
> +	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
> +	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
> +	{ "objects", FSYNC_COMPONENTS_OBJECTS },
> +	{ "default", FSYNC_COMPONENTS_DEFAULT },
> +	{ "all", FSYNC_COMPONENTS_ALL },
> +};
> +
> +static enum fsync_component parse_fsync_components(const char *var, cons=
t char *string)
> +{
> +	enum fsync_component output =3D 0;
> +
> +	if (!strcmp(string, "none"))
> +		return output;
> +
> +	while (string) {
> +		int i;
> +		size_t len;
> +		const char *ep;
> +		int negated =3D 0;
> +		int found =3D 0;
> +
> +		string =3D string + strspn(string, ", \t\n\r");
> +		ep =3D strchrnul(string, ',');
> +		len =3D ep - string;
> +
> +		if (*string =3D=3D '-') {
> +			negated =3D 1;
> +			string++;
> +			len--;
> +			if (!len)
> +				warning(_("invalid value for variable %s"), var);
> +		}
> +
> +		if (!len)
> +			break;
> +
> +		for (i =3D 0; i < ARRAY_SIZE(fsync_component_table); ++i) {
> +			const struct fsync_component_entry *entry =3D &fsync_component_table[=
i];
> +
> +			if (strncmp(entry->name, string, len))
> +				continue;
> +
> +			found =3D 1;
> +			if (negated)
> +				output &=3D ~entry->component_bits;
> +			else
> +				output |=3D entry->component_bits;
> +		}
> +
> +		if (!found) {
> +			char *component =3D xstrndup(string, len);
> +			warning(_("unknown %s value '%s'"), var, component);
> +			free(component);
> +		}
> +
> +		string =3D ep;
> +	}
> +
> +	return output;
> +}
> +
>  int git_parse_maybe_bool(const char *value)
>  {
>  	int v =3D git_parse_maybe_bool_text(value);
> @@ -1490,6 +1557,13 @@ static int git_default_core_config(const char *var=
, const char *value, void *cb)
>  		return 0;
>  	}
> =20
> +	if (!strcmp(var, "core.fsync")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		fsync_components =3D parse_fsync_components(var, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "core.fsyncmethod")) {
>  		if (!value)
>  			return config_error_nonbool(var);
> @@ -1503,7 +1577,7 @@ static int git_default_core_config(const char *var,=
 const char *value, void *cb)
>  	}
> =20
>  	if (!strcmp(var, "core.fsyncobjectfiles")) {
> -		fsync_object_files =3D git_config_bool(var, value);
> +		warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead=
"));
>  		return 0;
>  	}

Shouldn't we continue to support this for now such that users can
migrate from the old, deprecated value first before we start to ignore
it?

Patrick

> diff --git a/csum-file.c b/csum-file.c
> index 26e8a6df44e..59ef3398ca2 100644
> --- a/csum-file.c
> +++ b/csum-file.c
> @@ -58,7 +58,8 @@ static void free_hashfile(struct hashfile *f)
>  	free(f);
>  }
> =20
> -int finalize_hashfile(struct hashfile *f, unsigned char *result, unsigne=
d int flags)
> +int finalize_hashfile(struct hashfile *f, unsigned char *result,
> +		      enum fsync_component component, unsigned int flags)
>  {
>  	int fd;
> =20
> @@ -69,7 +70,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char=
 *result, unsigned int fl
>  	if (flags & CSUM_HASH_IN_STREAM)
>  		flush(f, f->buffer, the_hash_algo->rawsz);
>  	if (flags & CSUM_FSYNC)
> -		fsync_or_die(f->fd, f->name);
> +		fsync_component_or_die(component, f->fd, f->name);
>  	if (flags & CSUM_CLOSE) {
>  		if (close(f->fd))
>  			die_errno("%s: sha1 file error on close", f->name);
> diff --git a/csum-file.h b/csum-file.h
> index 291215b34eb..0d29f528fbc 100644
> --- a/csum-file.h
> +++ b/csum-file.h
> @@ -1,6 +1,7 @@
>  #ifndef CSUM_FILE_H
>  #define CSUM_FILE_H
> =20
> +#include "cache.h"
>  #include "hash.h"
> =20
>  struct progress;
> @@ -38,7 +39,7 @@ int hashfile_truncate(struct hashfile *, struct hashfil=
e_checkpoint *);
>  struct hashfile *hashfd(int fd, const char *name);
>  struct hashfile *hashfd_check(const char *name);
>  struct hashfile *hashfd_throughput(int fd, const char *name, struct prog=
ress *tp);
> -int finalize_hashfile(struct hashfile *, unsigned char *, unsigned int);
> +int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_com=
ponent, unsigned int);
>  void hashwrite(struct hashfile *, const void *, unsigned int);
>  void hashflush(struct hashfile *f);
>  void crc32_begin(struct hashfile *);
> diff --git a/environment.c b/environment.c
> index f9140e842cf..09905adecf9 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -42,6 +42,7 @@ const char *git_hooks_path;
>  int zlib_compression_level =3D Z_BEST_SPEED;
>  int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
>  enum fsync_method fsync_method =3D FSYNC_METHOD_DEFAULT;
> +enum fsync_component fsync_components =3D FSYNC_COMPONENTS_DEFAULT;
>  size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WINDOW_SIZE;
>  size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
>  size_t delta_base_cache_limit =3D 96 * 1024 * 1024;
> diff --git a/midx.c b/midx.c
> index 837b46b2af5..882f91f7d57 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1406,7 +1406,8 @@ static int write_midx_internal(const char *object_d=
ir,
>  	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
>  	write_chunkfile(cf, &ctx);
> =20
> -	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
> +	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,
> +			  CSUM_FSYNC | CSUM_HASH_IN_STREAM);
>  	free_chunkfile(cf);
> =20
>  	if (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
> diff --git a/object-file.c b/object-file.c
> index eb972cdccd2..9d9c4a39e85 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1809,8 +1809,7 @@ int hash_object_file(const struct git_hash_algo *al=
go, const void *buf,
>  /* Finalize a file on disk, and close it. */
>  static void close_loose_object(int fd)
>  {
> -	if (fsync_object_files)
> -		fsync_or_die(fd, "loose object file");
> +	fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd, "loose object =
file");
>  	if (close(fd) !=3D 0)
>  		die_errno(_("error when closing loose object file"));
>  }
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 9c55c1531e1..c16e43d1669 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -719,7 +719,8 @@ void bitmap_writer_finish(struct pack_idx_entry **ind=
ex,
>  	if (options & BITMAP_OPT_HASH_CACHE)
>  		write_hash_cache(f, index, index_nr);
> =20
> -	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOS=
E);
> +	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
> +			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
> =20
>  	if (adjust_shared_perm(tmp_file.buf))
>  		die_errno("unable to make temporary bitmap file readable");
> diff --git a/pack-write.c b/pack-write.c
> index a5846f3a346..51812cb1299 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -159,9 +159,9 @@ const char *write_idx_file(const char *index_name, st=
ruct pack_idx_entry **objec
>  	}
> =20
>  	hashwrite(f, sha1, the_hash_algo->rawsz);
> -	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
> -				    ((opts->flags & WRITE_IDX_VERIFY)
> -				    ? 0 : CSUM_FSYNC));
> +	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
> +			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
> +			  ((opts->flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
>  	return index_name;
>  }
> =20
> @@ -281,8 +281,9 @@ const char *write_rev_file_order(const char *rev_name,
>  	if (rev_name && adjust_shared_perm(rev_name) < 0)
>  		die(_("failed to make %s readable"), rev_name);
> =20
> -	finalize_hashfile(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
> -				    ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
> +	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
> +			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
> +			  ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
> =20
>  	return rev_name;
>  }
> @@ -390,7 +391,7 @@ void fixup_pack_header_footer(int pack_fd,
>  		the_hash_algo->final_fn(partial_pack_hash, &old_hash_ctx);
>  	the_hash_algo->final_fn(new_pack_hash, &new_hash_ctx);
>  	write_or_die(pack_fd, new_pack_hash, the_hash_algo->rawsz);
> -	fsync_or_die(pack_fd, pack_name);
> +	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
>  }
> =20
>  char *index_pack_lockfile(int ip_out, int *is_well_formed)
> diff --git a/read-cache.c b/read-cache.c
> index f3986596623..f3539681f49 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3060,7 +3060,7 @@ static int do_write_index(struct index_state *istat=
e, struct tempfile *tempfile,
>  			return -1;
>  	}
> =20
> -	finalize_hashfile(f, istate->oid.hash, CSUM_HASH_IN_STREAM);
> +	finalize_hashfile(f, istate->oid.hash, FSYNC_COMPONENT_NONE, CSUM_HASH_=
IN_STREAM);
>  	if (close_tempfile_gently(tempfile)) {
>  		error(_("could not close '%s'"), get_tempfile_path(tempfile));
>  		return -1;
> --=20
> gitgitgadget
>=20

--rj+/7kVG+u/4iNlT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvSzsACgkQVbJhu7ck
PpQzlg/9H/anSyKJQnHnBpnzSJ3FvmehwLWUbeM96Sk/zcA2q0A+Xb0nKe9vvBcY
LlGV/rxcAUuwZMlJ9pm88Q92EI3fUNUzqJP5lyaW48hUQsA91vSx9tZE2FiaDryp
V4gMzkc6tOhqu739HjSIBYkJ2XW+iabcpITNLodeKl0nFSKJ8rDTK3m69O0NEB4z
pGZs/agFpkI8FPBS/FKioVpmAOe/eM2mcWLGfL4gy2NjtO4FJsFNuP/sKtIxak6Q
0eaRgFcHDknkrvmgtmSCikZtCcuG58CnqcfVy1t1j2E8VwW3bvyrawBD7vWcFRb/
XALqryMaF3+8Rq/yhp7gCtfPqU18xSo/8/t6rjclBL0ldmYaBqXBLA8Ci9TXdDkh
QKlp28wMs4EnhthqXCjm/iUk+0izrDfPWbHPHnGhwiVqHP83fVF4+cNNbrYk6tM5
XaCrR5USoAjQ5IAlpOeuTr5tT2qVHBf5opiX69Ld+riIczFPrBFavV0DP32HMuPM
VOVBcveLBB+LVCR5a6JKMUxJXvypwNN61YOli7fSLhIzzW+voqIlu9q1VbdFZkkS
kscXsSTnKf+tGTEBZi2q5+SfpQFz4rfhAr710W+Zlbp5KZBgDR9v2qOKdnPfMYi4
qx1EfL4k9OmE9SLuvHMfWBiIiYdzJpUWMQ2oVO7hsfOTMKuYDvo=
=xPhw
-----END PGP SIGNATURE-----

--rj+/7kVG+u/4iNlT--
