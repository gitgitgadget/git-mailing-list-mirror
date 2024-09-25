Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BF4134BD
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283544; cv=none; b=dkpckMpkufh42gtpFLF+YLSJ4HgJjWeI0gzpK80DbHddP6aobt07+yXrPeRjbL0wEmy7I1owhoahS0lq3cbZTKQCsJmCX3vGvZANNX3LGT1ZYaju/Ay4/eE5cVQl9TXWpk6g6y1i67148xeOsBwhfsxT/6UC+xZI9aJfgHKR17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283544; c=relaxed/simple;
	bh=u2BMjtRBKnNhpsAYgvOXR2Y+mIRqBsMIE/3ZhDiREZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYmknU1cSO9z0LXJ5rr8igFQC3t3i1eMU+X9orxd+uUOzntkpuJFgsIgRFJ4QHzEyEBVHLb3ydmneCagW4l7ktv06jKLeXCEP2eSPFQSGcblP3vP9yiZnLU5jgY1k2BpVK8KYiXgJaLSUVpp00470mL578z1IntDwWsvD1zUmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivS8Gkx8; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivS8Gkx8"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a08489f757so4216435ab.0
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727283541; x=1727888341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YylD56wnsbQySrZVxZrki8fBW5SLj+hd8jp0Z8oFf7E=;
        b=ivS8Gkx8bcSsXVelegy154V2jsoc3pcOBqVXGL/M1edlL7knwxPuSlShqR/dZgPapw
         9LIgkca8OQF4cpvLEnOoVayDboFtLvvsydYy9sIV0KNkYgkBx4MzC7LnP8VCPBrNw3wv
         NDD2iUkBnyMIz66QCkcMpHR7EdLBioGhA7blUBw0kwv3Tm+HUT9nvU6nKDvFMq7n99qx
         Ltq5os8mikGPW3EFpOrTK+R96ybOIh/vJOdaqkOh6XpvUnjDeVgljWaBwsPqppeB22o2
         DNUbrgUfquUw0Bs/ST+2spyAPKJ/zd7ISIMFaXi7Rlc4VdzsX6j0yt0Vp8ijwWGsk9Im
         oyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727283541; x=1727888341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YylD56wnsbQySrZVxZrki8fBW5SLj+hd8jp0Z8oFf7E=;
        b=Be4/Hf8bQ1B+5j9ZlF5ryRgRObLtT4bQDtndbzBcG5Ru14bm8lbLWeRS7C187sYvIr
         GWrbJe6Z+w/IU57PswVHIj2Uwih/0AlgQsf9E6VatdYXT/c5UYFlLhaInfg7HUx5VwLs
         Cwh7/HKGVAZ6zHPtd1UbmUmKmj5vjTsdlm/MDy6BUOg+hlDlgnHWF8NSGtwSlOURsKmO
         Qdl5NXubUCLIyxmSMqq+WLKlcEjTmocPzAOQ9WFxJHDZ+vCB57BFfa51iBGFy3eB4NoS
         YG5iTlxQ+Xa35i1aPAF4g8ds4HnZhPeq7HvTnZcbT3Bk2lX81jNDmkAFFnrWYJ4XzLHy
         W6DA==
X-Gm-Message-State: AOJu0YwC3r0vfnYC8XEK6zROlxHzeqwzi31eMKzynxsAR29d9R+yNZRz
	xLQ89WgFDMpvOtmiZXgaqiL8U8pm62cu1LVdKTZIJ3I9K89ZMk8fIEAQZLAS/iFyLF/HZh/xDU4
	b1fz6nNrqgCN1eDjv2hl5iuyu0CY=
X-Google-Smtp-Source: AGHT+IFySE9H0kEs6kTcrAZjXpXtElaKGzbolysIel3fcwP5HoIAEu+084/A37HbNUWjFUhVRzKrpye45qZp8uc6MN8=
X-Received: by 2002:a05:6e02:19ca:b0:3a0:c8b8:1b0f with SMTP id
 e9e14a558f8ab-3a27684fe22mr2491695ab.2.1727283541037; Wed, 25 Sep 2024
 09:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725206584.git.me@ttaylorr.com> <cover.1727199118.git.me@ttaylorr.com>
In-Reply-To: <cover.1727199118.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 25 Sep 2024 09:58:47 -0700
Message-ID: <CABPp-BEqWhSVSEArOu_45Bt8W0d8PWThSbWrYAEWKrcMsDGsHw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 10:32=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> Here is a reroll of mine and Peff's series to add a build-time knob to
> allow selecting an alternative SHA-1 implementation for
> non-cryptographic hashing within Git, starting with the `hashwrite()`
> family of functions.
>
> This version is another fairly substantial reroll, with the main
> differences being renaming the "fast" SHA-1 options to "unsafe", as well
> as not running the collision checks via finalize_object_file() when
> handling loose objects (see the relevant patches for details on why).
>
> Note also there is an important bug fix in finalize_object_file() to
> unlink() the temporary file when we do run the collision check, but no
> collisions were found. This bug was causing a pile-up of tmp_obj_XXXXXX
> files in GitHub's infrastructure.

Yup...

>
> Thanks in advance for your review!
>
> Taylor Blau (8):
>   finalize_object_file(): check for name collision before renaming
>   finalize_object_file(): refactor unlink_or_warn() placement
>   finalize_object_file(): implement collision check
>   pack-objects: use finalize_object_file() to rename pack/idx/etc
>   sha1: do not redefine `platform_SHA_CTX` and friends
>   hash.h: scaffolding for _unsafe hashing variants
>   Makefile: allow specifying a SHA-1 for non-cryptographic uses
>   csum-file.c: use unsafe SHA-1 implementation when available
>
>  Makefile                              |  25 ++++++
>  block-sha1/sha1.h                     |   2 +
>  csum-file.c                           |  18 ++--
>  hash.h                                |  72 +++++++++++++++
>  object-file.c                         | 124 ++++++++++++++++++++++++--
>  object-file.h                         |   6 ++
>  pack-write.c                          |   7 +-
>  sha1/openssl.h                        |   2 +
>  sha1dc_git.h                          |   3 +
>  t/t5303-pack-corruption-resilience.sh |   7 +-
>  tmp-objdir.c                          |  26 ++++--
>  11 files changed, 266 insertions(+), 26 deletions(-)
>
> Range-diff against v3:
>  1:  738b1eb17b4 =3D  1:  6f1ee91fff3 finalize_object_file(): check for n=
ame collision before renaming
>  2:  e1c2c39711f =3D  2:  133047ca8c9 finalize_object_file(): refactor un=
link_or_warn() placement
>  3:  0feee5d1d4f !  3:  ed9eeef8513 finalize_object_file(): implement col=
lision check
>     @@ Commit message
>
>          The new check will cause the write of new differing content to b=
e a
>          failure, rather than a silent noop, and we'll retain the tempora=
ry file
>     -    on disk.
>     +    on disk. If there's no collision present, we'll clean up the tem=
porary
>     +    file as usual after either rename()-ing or link()-ing it into pl=
ace.
>
>          Note that this may cause some extra computation when the files a=
re in
>     -    fact identical, but this should happen rarely. For example, when=
 writing
>     -    a loose object, we compute the object id first, then check manua=
lly for
>     -    an existing object (so that we can freshen its timestamp) before
>     -    actually trying to write and link the new data.
>     +    fact identical, but this should happen rarely.
>     +
>     +    Loose objects are exempt from this check, and the collision chec=
k may be
>     +    skipped by calling the _flags variant of this function with the
>     +    FOF_SKIP_COLLISION_CHECK bit set. This is done for a couple of r=
easons:
>     +
>     +      - We don't treat the hash of the loose object file's contents =
as a
>     +        checksum, since the same loose object can be stored using di=
fferent
>     +        bytes on disk (e.g., when adjusting core.compression, using =
a
>     +        different version of zlib, etc.).
>     +
>     +        This is fundamentally different from cases where
>     +        finalize_object_file() is operating over a file which uses t=
he hash
>     +        value as a checksum of the contents. In other words, a pair =
of
>     +        identical loose objects can be stored using different bytes =
on disk,
>     +        and that should not be treated as a collision.
>     +
>     +      - We already use the path of the loose object as its hash valu=
e /
>     +        object name, so checking for collisions at the content level=
 doesn't
>     +        add anything.
>     +
>     +        This is why we do not bother to check the inflated object co=
ntents
>     +        for collisions either, since either (a) the object contents =
have the
>     +        fingerprint of a SHA-1 collision, in which case the collisio=
n
>     +        detecting SHA-1 implementation used to hash the contents to =
give us
>     +        a path would have already rejected it, or (b) the contents a=
re part
>     +        of a colliding pair which does not bear the same fingerprint=
s of
>     +        known collision attacks, in which case we would not have cau=
ght it
>     +        anyway.
>     +
>     +        So skipping the collision check here does not change for bet=
ter or
>     +        worse the hardness of loose object writes.
>     +
>     +    As a small note related to the latter bullet point above, we mus=
t teach
>     +    the tmp-objdir routines to similarly skip the content-level coll=
ision
>     +    checks when calling migrate_one() on a loose object file, which =
we do by
>     +    setting the FOF_SKIP_COLLISION_CHECK bit when we are inside of a=
 loose
>     +    object shard.
>
>          Co-authored-by: Jeff King <peff@peff.net>
>          Signed-off-by: Jeff King <peff@peff.net>

I don't even get a Helped-by for finding the cause of the pile-up of
temporary object files and the suggested tweak to this patch?  ;-)

>     @@ object-file.c: static void write_object_file_prepare_literally(con=
st struct git_
>       /*
>        * Move the just written object into its final resting place.
>        */
>     + int finalize_object_file(const char *tmpfile, const char *filename)
>     ++{
>     ++  return finalize_object_file_flags(tmpfile, filename, 0);
>     ++}
>     ++
>     ++int finalize_object_file_flags(const char *tmpfile, const char *fil=
ename,
>     ++                         enum finalize_object_file_flags flags)
>     + {
>     +   struct stat st;
>     +   int ret =3D 0;
>      @@ object-file.c: int finalize_object_file(const char *tmpfile, cons=
t char *filename)
>                         errno =3D saved_errno;
>                         return error_errno(_("unable to write file %s"), =
filename);
>                 }
>      -          /* FIXME!!! Collision check here ? */
>     --          unlink_or_warn(tmpfile);
>     -+          if (check_collision(tmpfile, filename))
>     -+                  return -1;
>     ++          if (!(flags & FOF_SKIP_COLLISION_CHECK) &&
>     ++              check_collision(tmpfile, filename))
>     ++                          return -1;
>     +           unlink_or_warn(tmpfile);

My suggested tweak had been simpler and didn't have a way to skip the
collision check, but I like the improvement you've made here; the
explanation you give for allowing it to be skipped makes sense to me.

>         }
>
>     - out:
>     +@@ object-file.c: static int write_loose_object(const struct object_=
id *oid, char *hdr,
>     +                   warning_errno(_("failed utime() on %s"), tmp_file=
.buf);
>     +   }
>     +
>     +-  return finalize_object_file(tmp_file.buf, filename.buf);
>     ++  return finalize_object_file_flags(tmp_file.buf, filename.buf,
>     ++                                    FOF_SKIP_COLLISION_CHECK);
>     + }
>     +
>     + static int freshen_loose_object(const struct object_id *oid)
>     +@@ object-file.c: int stream_loose_object(struct input_stream *in_st=
ream, size_t len,
>     +           strbuf_release(&dir);
>     +   }
>     +
>     +-  err =3D finalize_object_file(tmp_file.buf, filename.buf);
>     ++  err =3D finalize_object_file_flags(tmp_file.buf, filename.buf,
>     ++                                   FOF_SKIP_COLLISION_CHECK);
>     +   if (!err && compat)
>     +           err =3D repo_add_loose_object_map(the_repository, oid, &c=
ompat_oid);
>     + cleanup:
>     +
>     + ## object-file.h ##
>     +@@ object-file.h: int check_object_signature(struct repository *r, c=
onst struct object_id *oid,
>     +  */
>     + int stream_object_signature(struct repository *r, const struct obje=
ct_id *oid);
>     +
>     ++enum finalize_object_file_flags {
>     ++  FOF_SKIP_COLLISION_CHECK =3D 1,
>     ++};
>     ++
>     + int finalize_object_file(const char *tmpfile, const char *filename)=
;
>     ++int finalize_object_file_flags(const char *tmpfile, const char *fil=
ename,
>     ++                         enum finalize_object_file_flags flags);
>     +
>     + /* Helper to check and "touch" a file */
>     + int check_and_freshen_file(const char *fn, int freshen);
>     +
>     + ## tmp-objdir.c ##
>     +@@ tmp-objdir.c: static int read_dir_paths(struct string_list *out, =
const char *path)
>     +   return 0;
>     + }
>     +
>     +-static int migrate_paths(struct strbuf *src, struct strbuf *dst);
>     ++static int migrate_paths(struct strbuf *src, struct strbuf *dst,
>     ++                   enum finalize_object_file_flags flags);
>     +
>     +-static int migrate_one(struct strbuf *src, struct strbuf *dst)
>     ++static int migrate_one(struct strbuf *src, struct strbuf *dst,
>     ++                 enum finalize_object_file_flags flags)
>     + {
>     +   struct stat st;
>     +
>     +@@ tmp-objdir.c: static int migrate_one(struct strbuf *src, struct s=
trbuf *dst)
>     +                           return -1;
>     +           } else if (errno !=3D EEXIST)
>     +                   return -1;
>     +-          return migrate_paths(src, dst);
>     ++          return migrate_paths(src, dst, flags);
>     +   }
>     +-  return finalize_object_file(src->buf, dst->buf);
>     ++  return finalize_object_file_flags(src->buf, dst->buf, flags);
>     + }
>     +
>     +-static int migrate_paths(struct strbuf *src, struct strbuf *dst)
>     ++static int is_loose_object_shard(const char *name)
>     ++{
>     ++  return strlen(name) =3D=3D 2 && isxdigit(name[0]) && isxdigit(nam=
e[1]);
>     ++}
>     ++
>     ++static int migrate_paths(struct strbuf *src, struct strbuf *dst,
>     ++                   enum finalize_object_file_flags flags)
>     + {
>     +   size_t src_len =3D src->len, dst_len =3D dst->len;
>     +   struct string_list paths =3D STRING_LIST_INIT_DUP;
>     +@@ tmp-objdir.c: static int migrate_paths(struct strbuf *src, struct=
 strbuf *dst)
>     +
>     +   for (i =3D 0; i < paths.nr; i++) {
>     +           const char *name =3D paths.items[i].string;
>     ++          enum finalize_object_file_flags flags_copy =3D flags;
>     +
>     +           strbuf_addf(src, "/%s", name);
>     +           strbuf_addf(dst, "/%s", name);
>     +
>     +-          ret |=3D migrate_one(src, dst);
>     ++          if (is_loose_object_shard(name))
>     ++                  flags_copy |=3D FOF_SKIP_COLLISION_CHECK;
>     ++
>     ++          ret |=3D migrate_one(src, dst, flags_copy);
>     +
>     +           strbuf_setlen(src, src_len);
>     +           strbuf_setlen(dst, dst_len);
>     +@@ tmp-objdir.c: int tmp_objdir_migrate(struct tmp_objdir *t)
>     +   strbuf_addbuf(&src, &t->path);
>     +   strbuf_addstr(&dst, repo_get_object_directory(the_repository));
>     +
>     +-  ret =3D migrate_paths(&src, &dst);
>     ++  ret =3D migrate_paths(&src, &dst, 0);

The rest of the changes here are just to plumb the new collision check
skipping flag through; makes sense.

>     +
>     +   strbuf_release(&src);
>     +   strbuf_release(&dst);
>  4:  620dde48a9d =3D  4:  3cc7f7b1f67 pack-objects: use finalize_object_f=
ile() to rename pack/idx/etc
>  5:  bfe992765cd <  -:  ----------- i5500-git-daemon.sh: use compile-able=
 version of Git without OpenSSL
>  6:  22863d9f6df =3D  5:  8f8ac0f5b0e sha1: do not redefine `platform_SHA=
_CTX` and friends
>  7:  119c318d812 !  6:  d300e9c6887 hash.h: scaffolding for _fast hashing=
 variants
>     @@ Metadata
>      Author: Taylor Blau <me@ttaylorr.com>
>
>       ## Commit message ##
>     -    hash.h: scaffolding for _fast hashing variants
>     +    hash.h: scaffolding for _unsafe hashing variants
>
>          Git's default SHA-1 implementation is collision-detecting, which=
 hardens
>          us against known SHA-1 attacks against Git objects. This makes G=
it
>     @@ Commit message
>          the collision-detecting implementation, which is slower than
>          non-collision detecting alternatives.
>
>     -    Prepare for loading a separate "fast" SHA-1 implementation that =
can be
>     +    Prepare for loading a separate "unsafe" SHA-1 implementation tha=
t can be
>          used for non-cryptographic purposes, like computing the checksum=
 of
>          files that use the hashwrite() API.
>
>          This commit does not actually introduce any new compile-time kno=
bs to
>     -    control which implementation is used as the fast SHA-1 variant, =
but does
>     -    add scaffolding so that the "git_hash_algo" structure has five n=
ew
>     -    function pointers which are "fast" variants of the five existing
>     +    control which implementation is used as the unsafe SHA-1 variant=
, but
>     +    does add scaffolding so that the "git_hash_algo" structure has f=
ive new
>     +    function pointers which are "unsafe" variants of the five existi=
ng
>          hashing-related function pointers:
>
>     -      - git_hash_init_fn fast_init_fn
>     -      - git_hash_clone_fn fast_clone_fn
>     -      - git_hash_update_fn fast_update_fn
>     -      - git_hash_final_fn fast_final_fn
>     -      - git_hash_final_oid_fn fast_final_oid_fn
>     +      - git_hash_init_fn unsafe_init_fn
>     +      - git_hash_clone_fn unsafe_clone_fn
>     +      - git_hash_update_fn unsafe_update_fn
>     +      - git_hash_final_fn unsafe_final_fn
>     +      - git_hash_final_oid_fn unsafe_final_oid_fn
>
>          The following commit will introduce compile-time knobs to specif=
y which
>          SHA-1 implementation is used for non-cryptographic uses.
>     @@ hash.h
>       #define platform_SHA1_Final       SHA1_Final
>       #endif
>
>     -+#ifndef platform_SHA_CTX_fast
>     -+#  define platform_SHA_CTX_fast     platform_SHA_CTX
>     -+#  define platform_SHA1_Init_fast   platform_SHA1_Init
>     -+#  define platform_SHA1_Update_fast platform_SHA1_Update
>     -+#  define platform_SHA1_Final_fast  platform_SHA1_Final
>     ++#ifndef platform_SHA_CTX_unsafe
>     ++#  define platform_SHA_CTX_unsafe      platform_SHA_CTX
>     ++#  define platform_SHA1_Init_unsafe    platform_SHA1_Init
>     ++#  define platform_SHA1_Update_unsafe  platform_SHA1_Update
>     ++#  define platform_SHA1_Final_unsafe   platform_SHA1_Final
>      +#  ifdef platform_SHA1_Clone
>     -+#    define platform_SHA1_Clone_fast platform_SHA1_Clone
>     ++#    define platform_SHA1_Clone_unsafe platform_SHA1_Clone
>      +#  endif
>      +#endif
>      +
>     @@ hash.h
>       #define git_SHA1_Update           platform_SHA1_Update
>       #define git_SHA1_Final            platform_SHA1_Final
>
>     -+#define git_SHA_CTX_fast  platform_SHA_CTX_fast
>     -+#define git_SHA1_Init_fast        platform_SHA1_Init_fast
>     -+#define git_SHA1_Update_fast      platform_SHA1_Update_fast
>     -+#define git_SHA1_Final_fast       platform_SHA1_Final_fast
>     ++#define git_SHA_CTX_unsafe        platform_SHA_CTX_unsafe
>     ++#define git_SHA1_Init_unsafe      platform_SHA1_Init_unsafe
>     ++#define git_SHA1_Update_unsafe    platform_SHA1_Update_unsafe
>     ++#define git_SHA1_Final_unsafe     platform_SHA1_Final_unsafe
>      +
>       #ifdef platform_SHA1_Clone
>       #define git_SHA1_Clone    platform_SHA1_Clone
>       #endif
>     -+#ifdef platform_SHA1_Clone_fast
>     -+#  define git_SHA1_Clone_fast platform_SHA1_Clone_fast
>     ++#ifdef platform_SHA1_Clone_unsafe
>     ++#  define git_SHA1_Clone_unsafe platform_SHA1_Clone_unsafe
>      +#endif
>
>       #ifndef platform_SHA256_CTX
>     @@ hash.h: static inline void git_SHA1_Clone(git_SHA_CTX *dst, const =
git_SHA_CTX *s
>         memcpy(dst, src, sizeof(*dst));
>       }
>       #endif
>     -+#ifndef SHA1_NEEDS_CLONE_HELPER_FAST
>     -+static inline void git_SHA1_Clone_fast(git_SHA_CTX_fast *dst,
>     -+                                 const git_SHA_CTX_fast *src)
>     ++#ifndef SHA1_NEEDS_CLONE_HELPER_UNSAFE
>     ++static inline void git_SHA1_Clone_unsafe(git_SHA_CTX_unsafe *dst,
>     ++                                 const git_SHA_CTX_unsafe *src)
>      +{
>      +  memcpy(dst, src, sizeof(*dst));
>      +}
>     @@ hash.h: enum get_oid_result {
>       /* A suitably aligned type for stack allocations of hash contexts. =
*/
>       union git_hash_ctx {
>         git_SHA_CTX sha1;
>     -+  git_SHA_CTX_fast sha1_fast;
>     ++  git_SHA_CTX_unsafe sha1_unsafe;
>      +
>         git_SHA256_CTX sha256;
>       };
>     @@ hash.h: struct git_hash_algo {
>         /* The hash finalization function for object IDs. */
>         git_hash_final_oid_fn final_oid_fn;
>
>     -+  /* The fast / non-cryptographic hash initialization function. */
>     -+  git_hash_init_fn fast_init_fn;
>     ++  /* The non-cryptographic hash initialization function. */
>     ++  git_hash_init_fn unsafe_init_fn;
>      +
>     -+  /* The fast / non-cryptographic hash context cloning function. */
>     -+  git_hash_clone_fn fast_clone_fn;
>     ++  /* The non-cryptographic hash context cloning function. */
>     ++  git_hash_clone_fn unsafe_clone_fn;
>      +
>     -+  /* The fast / non-cryptographic hash update function. */
>     -+  git_hash_update_fn fast_update_fn;
>     ++  /* The non-cryptographic hash update function. */
>     ++  git_hash_update_fn unsafe_update_fn;
>      +
>     -+  /* The fast / non-cryptographic hash finalization function. */
>     -+  git_hash_final_fn fast_final_fn;
>     ++  /* The non-cryptographic hash finalization function. */
>     ++  git_hash_final_fn unsafe_final_fn;
>      +
>     -+  /* The fast / non-cryptographic hash finalization function. */
>     -+  git_hash_final_oid_fn fast_final_oid_fn;
>     ++  /* The non-cryptographic hash finalization function. */
>     ++  git_hash_final_oid_fn unsafe_final_oid_fn;
>      +
>         /* The OID of the empty tree. */
>         const struct object_id *empty_tree;
>     @@ object-file.c: static void git_hash_sha1_final_oid(struct object_i=
d *oid, git_ha
>         oid->algo =3D GIT_HASH_SHA1;
>       }
>
>     -+static void git_hash_sha1_init_fast(git_hash_ctx *ctx)
>     ++static void git_hash_sha1_init_unsafe(git_hash_ctx *ctx)
>      +{
>     -+  git_SHA1_Init_fast(&ctx->sha1_fast);
>     ++  git_SHA1_Init_unsafe(&ctx->sha1_unsafe);
>      +}
>      +
>     -+static void git_hash_sha1_clone_fast(git_hash_ctx *dst, const git_h=
ash_ctx *src)
>     ++static void git_hash_sha1_clone_unsafe(git_hash_ctx *dst, const git=
_hash_ctx *src)
>      +{
>     -+  git_SHA1_Clone_fast(&dst->sha1_fast, &src->sha1_fast);
>     ++  git_SHA1_Clone_unsafe(&dst->sha1_unsafe, &src->sha1_unsafe);
>      +}
>      +
>     -+static void git_hash_sha1_update_fast(git_hash_ctx *ctx, const void=
 *data,
>     ++static void git_hash_sha1_update_unsafe(git_hash_ctx *ctx, const vo=
id *data,
>      +                                size_t len)
>      +{
>     -+  git_SHA1_Update_fast(&ctx->sha1_fast, data, len);
>     ++  git_SHA1_Update_unsafe(&ctx->sha1_unsafe, data, len);
>      +}
>      +
>     -+static void git_hash_sha1_final_fast(unsigned char *hash, git_hash_=
ctx *ctx)
>     ++static void git_hash_sha1_final_unsafe(unsigned char *hash, git_has=
h_ctx *ctx)
>      +{
>     -+  git_SHA1_Final_fast(hash, &ctx->sha1_fast);
>     ++  git_SHA1_Final_unsafe(hash, &ctx->sha1_unsafe);
>      +}
>      +
>     -+static void git_hash_sha1_final_oid_fast(struct object_id *oid, git=
_hash_ctx *ctx)
>     ++static void git_hash_sha1_final_oid_unsafe(struct object_id *oid, g=
it_hash_ctx *ctx)
>      +{
>     -+  git_SHA1_Final_fast(oid->hash, &ctx->sha1_fast);
>     ++  git_SHA1_Final_unsafe(oid->hash, &ctx->sha1_unsafe);
>      +  memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RA=
WSZ);
>      +  oid->algo =3D GIT_HASH_SHA1;
>      +}
>     @@ object-file.c: const struct git_hash_algo hash_algos[GIT_HASH_NALG=
OS] =3D {
>                 .update_fn =3D git_hash_unknown_update,
>                 .final_fn =3D git_hash_unknown_final,
>                 .final_oid_fn =3D git_hash_unknown_final_oid,
>     -+          .fast_init_fn =3D git_hash_unknown_init,
>     -+          .fast_clone_fn =3D git_hash_unknown_clone,
>     -+          .fast_update_fn =3D git_hash_unknown_update,
>     -+          .fast_final_fn =3D git_hash_unknown_final,
>     -+          .fast_final_oid_fn =3D git_hash_unknown_final_oid,
>     ++          .unsafe_init_fn =3D git_hash_unknown_init,
>     ++          .unsafe_clone_fn =3D git_hash_unknown_clone,
>     ++          .unsafe_update_fn =3D git_hash_unknown_update,
>     ++          .unsafe_final_fn =3D git_hash_unknown_final,
>     ++          .unsafe_final_oid_fn =3D git_hash_unknown_final_oid,
>                 .empty_tree =3D NULL,
>                 .empty_blob =3D NULL,
>                 .null_oid =3D NULL,
>     @@ object-file.c: const struct git_hash_algo hash_algos[GIT_HASH_NALG=
OS] =3D {
>                 .update_fn =3D git_hash_sha1_update,
>                 .final_fn =3D git_hash_sha1_final,
>                 .final_oid_fn =3D git_hash_sha1_final_oid,
>     -+          .fast_init_fn =3D git_hash_sha1_init_fast,
>     -+          .fast_clone_fn =3D git_hash_sha1_clone_fast,
>     -+          .fast_update_fn =3D git_hash_sha1_update_fast,
>     -+          .fast_final_fn =3D git_hash_sha1_final_fast,
>     -+          .fast_final_oid_fn =3D git_hash_sha1_final_oid_fast,
>     ++          .unsafe_init_fn =3D git_hash_sha1_init_unsafe,
>     ++          .unsafe_clone_fn =3D git_hash_sha1_clone_unsafe,
>     ++          .unsafe_update_fn =3D git_hash_sha1_update_unsafe,
>     ++          .unsafe_final_fn =3D git_hash_sha1_final_unsafe,
>     ++          .unsafe_final_oid_fn =3D git_hash_sha1_final_oid_unsafe,
>                 .empty_tree =3D &empty_tree_oid,
>                 .empty_blob =3D &empty_blob_oid,
>                 .null_oid =3D &null_oid_sha1,
>     @@ object-file.c: const struct git_hash_algo hash_algos[GIT_HASH_NALG=
OS] =3D {
>                 .update_fn =3D git_hash_sha256_update,
>                 .final_fn =3D git_hash_sha256_final,
>                 .final_oid_fn =3D git_hash_sha256_final_oid,
>     -+          .fast_init_fn =3D git_hash_sha256_init,
>     -+          .fast_clone_fn =3D git_hash_sha256_clone,
>     -+          .fast_update_fn =3D git_hash_sha256_update,
>     -+          .fast_final_fn =3D git_hash_sha256_final,
>     -+          .fast_final_oid_fn =3D git_hash_sha256_final_oid,
>     ++          .unsafe_init_fn =3D git_hash_sha256_init,
>     ++          .unsafe_clone_fn =3D git_hash_sha256_clone,
>     ++          .unsafe_update_fn =3D git_hash_sha256_update,
>     ++          .unsafe_final_fn =3D git_hash_sha256_final,
>     ++          .unsafe_final_oid_fn =3D git_hash_sha256_final_oid,
>                 .empty_tree =3D &empty_tree_oid_sha256,
>                 .empty_blob =3D &empty_blob_oid_sha256,
>                 .null_oid =3D &null_oid_sha256,

This is basically a big s/fast/unsafe/ replace.  Simple enough.

>  8:  137ec30d68a !  7:  af8fd9aa4ed Makefile: allow specifying a SHA-1 fo=
r non-cryptographic uses
>     @@ Metadata
>       ## Commit message ##
>          Makefile: allow specifying a SHA-1 for non-cryptographic uses
>
>     -    Introduce _FAST variants of the OPENSSL_SHA1, BLK_SHA1, and
>     +    Introduce _UNSAFE variants of the OPENSSL_SHA1, BLK_SHA1, and
>          APPLE_COMMON_CRYPTO_SHA1 compile-time knobs which indicate which=
 SHA-1
>          implementation is to be used for non-cryptographic uses.
>
>     @@ Makefile: include shared.mak
>       # Define APPLE_COMMON_CRYPTO_SHA1 to use Apple's CommonCrypto for
>       # SHA-1.
>       #
>     -+# Define the same Makefile knobs as above, but suffixed with _FAST =
to
>     -+# use the corresponding implementations for "fast" SHA-1 hashing fo=
r
>     ++# Define the same Makefile knobs as above, but suffixed with _UNSAF=
E to
>     ++# use the corresponding implementations for unsafe SHA-1 hashing fo=
r
>      +# non-cryptographic purposes.
>      +#
>       # If don't enable any of the *_SHA1 settings in this section, Git w=
ill
>     @@ Makefile: endif
>       endif
>       endif
>
>     -+ifdef OPENSSL_SHA1_FAST
>     ++ifdef OPENSSL_SHA1_UNSAFE
>      +ifndef OPENSSL_SHA1
>      +  EXTLIBS +=3D $(LIB_4_CRYPTO)
>     -+  BASIC_CFLAGS +=3D -DSHA1_OPENSSL_FAST
>     ++  BASIC_CFLAGS +=3D -DSHA1_OPENSSL_UNSAFE
>      +endif
>      +else
>     -+ifdef BLK_SHA1_FAST
>     ++ifdef BLK_SHA1_UNSAFE
>      +ifndef BLK_SHA1
>      +  LIB_OBJS +=3D block-sha1/sha1.o
>     -+  BASIC_CFLAGS +=3D -DSHA1_BLK_FAST
>     ++  BASIC_CFLAGS +=3D -DSHA1_BLK_UNSAFE
>      +endif
>      +else
>     -+ifdef APPLE_COMMON_CRYPTO_SHA1_FAST
>     ++ifdef APPLE_COMMON_CRYPTO_SHA1_UNSAFE
>      +ifndef APPLE_COMMON_CRYPTO_SHA1
>      +  COMPAT_CFLAGS +=3D -DCOMMON_DIGEST_FOR_OPENSSL
>     -+  BASIC_CFLAGS +=3D -DSHA1_APPLE_FAST
>     ++  BASIC_CFLAGS +=3D -DSHA1_APPLE_UNSAFE
>      +endif
>      +endif
>      +endif
>     @@ hash.h
>       #include "block-sha1/sha1.h"
>       #endif
>
>     -+#if defined(SHA1_APPLE_FAST)
>     ++#if defined(SHA1_APPLE_UNSAFE)
>      +#  include <CommonCrypto/CommonDigest.h>
>     -+#  define platform_SHA_CTX_fast CC_SHA1_CTX
>     -+#  define platform_SHA1_Init_fast CC_SHA1_Init
>     -+#  define platform_SHA1_Update_fast CC_SHA1_Update
>     -+#  define platform_SHA1_Final_fast CC_SHA1_Final
>     -+#elif defined(SHA1_OPENSSL_FAST)
>     ++#  define platform_SHA_CTX_unsafe CC_SHA1_CTX
>     ++#  define platform_SHA1_Init_unsafe CC_SHA1_Init
>     ++#  define platform_SHA1_Update_unsafe CC_SHA1_Update
>     ++#  define platform_SHA1_Final_unsafe CC_SHA1_Final
>     ++#elif defined(SHA1_OPENSSL_UNSAFE)
>      +#  include <openssl/sha.h>
>      +#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >=3D 3
>     -+#    define SHA1_NEEDS_CLONE_HELPER_FAST
>     ++#    define SHA1_NEEDS_CLONE_HELPER_UNSAFE
>      +#    include "sha1/openssl.h"
>     -+#    define platform_SHA_CTX_fast openssl_SHA1_CTX
>     -+#    define platform_SHA1_Init_fast openssl_SHA1_Init
>     -+#    define platform_SHA1_Clone_fast openssl_SHA1_Clone
>     -+#    define platform_SHA1_Update_fast openssl_SHA1_Update
>     -+#    define platform_SHA1_Final_fast openssl_SHA1_Final
>     ++#    define platform_SHA_CTX_unsafe openssl_SHA1_CTX
>     ++#    define platform_SHA1_Init_unsafe openssl_SHA1_Init
>     ++#    define platform_SHA1_Clone_unsafe openssl_SHA1_Clone
>     ++#    define platform_SHA1_Update_unsafe openssl_SHA1_Update
>     ++#    define platform_SHA1_Final_unsafe openssl_SHA1_Final
>      +#  else
>     -+#    define platform_SHA_CTX_fast SHA_CTX
>     -+#    define platform_SHA1_Init_fast SHA1_Init
>     -+#    define platform_SHA1_Update_fast SHA1_Update
>     -+#    define platform_SHA1_Final_fast SHA1_Final
>     ++#    define platform_SHA_CTX_unsafe SHA_CTX
>     ++#    define platform_SHA1_Init_unsafe SHA1_Init
>     ++#    define platform_SHA1_Update_unsafe SHA1_Update
>     ++#    define platform_SHA1_Final_unsafe SHA1_Final
>      +#  endif
>     -+#elif defined(SHA1_BLK_FAST)
>     ++#elif defined(SHA1_BLK_UNSAFE)
>      +#  include "block-sha1/sha1.h"
>     -+#  define platform_SHA_CTX_fast blk_SHA_CTX
>     -+#  define platform_SHA1_Init_fast blk_SHA1_Init
>     -+#  define platform_SHA1_Update_fast blk_SHA1_Update
>     -+#  define platform_SHA1_Final_fast blk_SHA1_Final
>     ++#  define platform_SHA_CTX_unsafe blk_SHA_CTX
>     ++#  define platform_SHA1_Init_unsafe blk_SHA1_Init
>     ++#  define platform_SHA1_Update_unsafe blk_SHA1_Update
>     ++#  define platform_SHA1_Final_unsafe blk_SHA1_Final
>      +#endif
>      +

Likewise.

>       #if defined(SHA256_NETTLE)
>  9:  4018261366f !  8:  4b83dd05e9f csum-file.c: use fast SHA-1 implement=
ation when available
>     @@ Metadata
>      Author: Taylor Blau <me@ttaylorr.com>
>
>       ## Commit message ##
>     -    csum-file.c: use fast SHA-1 implementation when available
>     +    csum-file.c: use unsafe SHA-1 implementation when available
>
>     -    Update hashwrite() and friends to use the fast_-variants of hash=
ing
>     -    functions, calling for e.g., "the_hash_algo->fast_update_fn()" i=
nstead
>     +    Update hashwrite() and friends to use the unsafe_-variants of ha=
shing
>     +    functions, calling for e.g., "the_hash_algo->unsafe_update_fn()"=
 instead
>          of "the_hash_algo->update_fn()".
>
>          These callers only use the_hash_algo to produce a checksum, whic=
h we
>          depend on for data integrity, but not for cryptographic purposes=
, so
>     -    these callers are safe to use the fast (and potentially non-coll=
ision
>     +    these callers are safe to use the unsafe (and potentially non-co=
llision
>          detecting) SHA-1 implementation.

Is the "and potentially non-collision detecting" parenthetical comment
still needed now that it's referred to as unsafe?  Even if we keep
most of it, maybe we should drop the "and"?

>
>          To time this, I took a freshly packed copy of linux.git, and ran=
 the
>     -    following with and without the OPENSSL_SHA1_FAST=3D1 build-knob.=
 Both
>     +    following with and without the OPENSSL_SHA1_UNSAFE=3D1 build-kno=
b. Both
>          versions were compiled with -O3:
>
>              $ git for-each-ref --format=3D'%(objectname)' refs/heads ref=
s/tags >in
>              $ valgrind --tool=3Dcallgrind ~/src/git/git-pack-objects \
>                  --revs --stdout --all-progress --use-bitmap-index <in >/=
dev/null
>
>     -    Without OPENSSL_SHA1_FAST=3D1 (that is, using the collision-dete=
cting
>     +    Without OPENSSL_SHA1_UNSAFE=3D1 (that is, using the collision-de=
tecting
>          SHA-1 implementation for both cryptographic and non-cryptographi=
c
>          purposes), we spend a significant amount of our instruction coun=
t in
>          hashwrite():
>     @@ Commit message
>          , and the resulting "clone" takes 19.219 seconds of wall clock t=
ime,
>          18.94 seconds of user time and 0.28 seconds of system time.
>
>     -    Compiling with OPENSSL_SHA1_FAST=3D1, we spend ~60% fewer instru=
ctions in
>     -    hashwrite():
>     +    Compiling with OPENSSL_SHA1_UNSAFE=3D1, we spend ~60% fewer inst=
ructions
>     +    in hashwrite():
>
>              $ callgrind_annotate --inclusive=3Dyes | grep hashwrite | he=
ad -n1
>               59,164,001,176 (58.79%)  /home/ttaylorr/src/git/csum-file.c=
:hashwrite [/home/ttaylorr/src/git/git-pack-objects]
>
>     -    , and generate the resulting "clone" much faster, in only 11.597=
 seconds
>     +    , and generate the resulting "clone" much unsafeer, in only 11.5=
97 seconds

This fast->unsafe translation isn't so good; this one should be undone.

>          of wall time, 11.37 seconds of user time, and 0.23 seconds of sy=
stem
>          time, for a ~40% speed-up.
>
>     @@ csum-file.c: void hashflush(struct hashfile *f)
>         if (offset) {
>                 if (!f->skip_hash)
>      -                  the_hash_algo->update_fn(&f->ctx, f->buffer, offs=
et);
>     -+                  the_hash_algo->fast_update_fn(&f->ctx, f->buffer,=
 offset);
>     ++                  the_hash_algo->unsafe_update_fn(&f->ctx, f->buffe=
r, offset);
>                 flush(f, f->buffer, offset);
>                 f->offset =3D 0;
>         }
>     @@ csum-file.c: int finalize_hashfile(struct hashfile *f, unsigned ch=
ar *result,
>                 hashclr(f->buffer, the_repository->hash_algo);
>         else
>      -          the_hash_algo->final_fn(f->buffer, &f->ctx);
>     -+          the_hash_algo->fast_final_fn(f->buffer, &f->ctx);
>     ++          the_hash_algo->unsafe_final_fn(f->buffer, &f->ctx);
>
>         if (result)
>                 hashcpy(result, f->buffer, the_repository->hash_algo);
>     @@ csum-file.c: void hashwrite(struct hashfile *f, const void *buf, u=
nsigned int co
>                          */
>                         if (!f->skip_hash)
>      -                          the_hash_algo->update_fn(&f->ctx, buf, nr=
);
>     -+                          the_hash_algo->fast_update_fn(&f->ctx, bu=
f, nr);
>     ++                          the_hash_algo->unsafe_update_fn(&f->ctx, =
buf, nr);
>                         flush(f, buf, nr);
>                 } else {
>                         /*
>     @@ csum-file.c: static struct hashfile *hashfd_internal(int fd, const=
 char *name,
>         f->do_crc =3D 0;
>         f->skip_hash =3D 0;
>      -  the_hash_algo->init_fn(&f->ctx);
>     -+  the_hash_algo->fast_init_fn(&f->ctx);
>     ++  the_hash_algo->unsafe_init_fn(&f->ctx);
>
>         f->buffer_len =3D buffer_len;
>         f->buffer =3D xmalloc(buffer_len);
>     @@ csum-file.c: void hashfile_checkpoint(struct hashfile *f, struct h=
ashfile_checkp
>         hashflush(f);
>         checkpoint->offset =3D f->total;
>      -  the_hash_algo->clone_fn(&checkpoint->ctx, &f->ctx);
>     -+  the_hash_algo->fast_clone_fn(&checkpoint->ctx, &f->ctx);
>     ++  the_hash_algo->unsafe_clone_fn(&checkpoint->ctx, &f->ctx);
>       }
>
>       int hashfile_truncate(struct hashfile *f, struct hashfile_checkpoin=
t *checkpoint)
>     @@ csum-file.c: int hashfile_truncate(struct hashfile *f, struct hash=
file_checkpoin
>                 return -1;
>         f->total =3D offset;
>      -  the_hash_algo->clone_fn(&f->ctx, &checkpoint->ctx);
>     -+  the_hash_algo->fast_clone_fn(&f->ctx, &checkpoint->ctx);
>     ++  the_hash_algo->unsafe_clone_fn(&f->ctx, &checkpoint->ctx);
>         f->offset =3D 0; /* hashflush() was called in checkpoint */
>         return 0;
>       }
>     @@ csum-file.c: int hashfile_checksum_valid(const unsigned char *data=
, size_t total
>      -  the_hash_algo->init_fn(&ctx);
>      -  the_hash_algo->update_fn(&ctx, data, data_len);
>      -  the_hash_algo->final_fn(got, &ctx);
>     -+  the_hash_algo->fast_init_fn(&ctx);
>     -+  the_hash_algo->fast_update_fn(&ctx, data, data_len);
>     -+  the_hash_algo->fast_final_fn(got, &ctx);
>     ++  the_hash_algo->unsafe_init_fn(&ctx);
>     ++  the_hash_algo->unsafe_update_fn(&ctx, data, data_len);
>     ++  the_hash_algo->unsafe_final_fn(got, &ctx);
>
>         return hasheq(got, data + data_len, the_repository->hash_algo);
>       }

This patch was also fast->unsafe translations; I identified two above
that I think should get some tweaks.
