Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A42D876A
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939357; cv=none; b=JSPxfV06Tyfr2f+Ia1mG0T88RDuSiEwv27xObTa1KIlUGu1jyVlgN8a2MY7foi8LLvAskeLJSWDNOkODOihLMvHslSXtAkqq0syeKpDS4EkYVArI7xnx6xDP7o8Tm2vJ572uE5OHQzifNbngWwAF0gVATlJuR7n5eD9fT9+XAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939357; c=relaxed/simple;
	bh=o+CoeT2D16ugcgtUf8Pe+jNSM4H59mesL4vSC68/Plk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jS9Q6PEV6ggxmJ67UGJAcUo+MSktuw6nLeN4HabYKIvcCBcairg3NA9sjVxnI+/PcwwVgJ1vndmaJDexn73eRGUx5YIABCfp2sGeHA9X2ktPXJ3LibIZGQ92u9xIRF9K1v026WcTJ+hX4KNc+xtmbJ8EpsQhSXUOh8TsaSciV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyphfI9I; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyphfI9I"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-88703c873d5so96937539f.3
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761939353; x=1762544153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaPvmVoIE2WiJO6lbCduuTh1T+aDHRMP8LM3V+f2GI8=;
        b=eyphfI9IL9gybmn5PexlreO4/wY2Y1ZkuFAPNVU09EF0wFPBIIOm/FaUvvkn/LGlQy
         GlnedtX8qj5GhpYYIw9kEjdoG01J9Xhb8Nenhn7iKjxzGc3m17GabFhwBDqlhLzIg18U
         Tzl6T348OrxJh0sht2NEMx2fA0SJ99i6PFYrY7Vr4eg0GSmqIg8XJVm4p4QnkDbMigvO
         pop0ZxhtgC6ENBjdoOBPUmIRoi7p6YvAjgeKa8rIuMWaCecEuO2e0u9cSYhh8etFfcNE
         dK9N+vmzchZnyej9ZCobKeJc8q/VBUpmeJzNoWBr5uAeE4lW4iRXVlB+BBd13Fn3h3yf
         kUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761939353; x=1762544153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaPvmVoIE2WiJO6lbCduuTh1T+aDHRMP8LM3V+f2GI8=;
        b=VdJUQhkKexODggAt9O5i7tcxP/YdMkx5QqcGzGiTOitkWChjfWArcxfG7SgiP6M89Y
         bnHtJhYQ4XDPZ6YTdh4KTT0bR4ot/CeOLwWSAAdgj0BxxBi1g7ISYmDkclsjPgbGTcay
         jmkS9IkVEYzN8HAevN8Km7AhsE12s/6cFTPEwVxwasPZ5YGkf89tELDbvCt+8zOYgr/k
         8Pkdxa7hAqCSR2ioo5wCjjUsgtAqqSckfYlJ/z8bl6sSA+lyid2vmcOx9uDO3FId6is0
         JLqAm+KdOULsXLE9od7nDA5yZ64qnxDSMzOMJX644WTCTNZjEuHE91W4DVxSHlWOqROI
         DS7Q==
X-Gm-Message-State: AOJu0YzGUtSUbQGP5Rm7I7sSVF6XrCwdTQPla9HwBCY8exZn5sz3U4a7
	2/zJcmVR7P1flHJdVun7lVSZhFKrh2LzZE2FJKxoAEqqMXbCLZ6kkfeuMxJa3zbvA7dQG+SxeSS
	/YJHNjBKBjaXSxkRj3QE4bR1A+ogZ/hA=
X-Gm-Gg: ASbGncuEUO0bqPjA0YXkngPtuOGlaP+A9N9qOY97C4jFrPaDOFj0YumKSHQpjTLhStS
	8md9XblAsPj+UoazxdurHCCzxnR6LLurmUpjg3+eKGuEz9CCpno/C85YHXClHAjGjAWpcWypUae
	WxOa5qDFFOz32iZkVF8CJEpFSzHgQkOfkVgtN7xTKkH+hw3N2U41OpPoe3BLO1wQpfd9Epxj/XQ
	EeFpgzFtaKcrCwVjZitN6fjFnYaX1A6sRlm16+4we9xULNBXHRDubBefAwtu1pJz2wM8lMicENs
	UA15/bDGzokM4jkE
X-Google-Smtp-Source: AGHT+IGUPYZ+7XA+1VtwTNM+kyX5aNlvz0P/ey92eSdngsgonqk0TNNs1M7O54UmtQfq1A256AAXCv1akTfB0GFwN0I=
X-Received: by 2002:a05:6e02:1d86:b0:430:cfe4:6e61 with SMTP id
 e9e14a558f8ab-4330d1437dbmr77568995ab.14.1761939352864; Fri, 31 Oct 2025
 12:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028081232.3068147-1-christian.couder@gmail.com>
 <20251030123332.3337684-1-christian.couder@gmail.com> <20251030123332.3337684-5-christian.couder@gmail.com>
In-Reply-To: <20251030123332.3337684-5-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 31 Oct 2025 12:35:41 -0700
X-Gm-Features: AWmQ_bmG1wgPCthjxQQDDBZoHzmBrw2yT9lrFGBemYobuthUakQW1qNoSflKNE0
Message-ID: <CABPp-BFmL9+oXTz8UM=yPxujXBW6c1xEHMzt2KD=cEXT4EbiOg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] fast-import: mark strings for translation
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 5:33=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Some error or warning messages in "builtin/fast-import.c" are marked
> for translation, but many are not.
>
> To be more consistent and provide a better experience to people using a
> translated version, let's mark all the remaining error or warning
> messages for translation.
>
> While at it, let's make the following small changes:
>
>   - replace "GIT" or "git" in a few error messages to just "Git",
>   - replace "Expected from command, got %s" to "expected 'from'
>     command, got '%s'", which makes it clearer that "from" is a command
>     and should not be translated,

These are all good fixes you are making, but I _especially_ appreciate
this fix.  I think you might undersell it, though, not only will it
help translators, it'll help English readers who might assume the
message is garbled or hard to parse realize that 'from' is not a
preposition as used here.


>   - downcase error and warning messages that start with an uppercase,
>   - fix test cases in "t9300-fast-import.sh" that broke because an
>     error or warning message was downcased,
>   - split error and warning messages that are too long,
>   - adjust the indentation of some arguments of the error functions.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/fast-import.c  | 280 ++++++++++++++++++++---------------------
>  t/t9300-fast-import.sh |  20 +--
>  2 files changed, 150 insertions(+), 150 deletions(-)
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 8714edfc65..22d5deae9a 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -339,12 +339,12 @@ static void write_crash_report(const char *err)
>         struct recent_command *rc;
>
>         if (!rpt) {
> -               error_errno("can't write crash report %s", loc);
> +               error_errno(_("can't write crash report %s"), loc);
>                 free(loc);
>                 return;
>         }
>
> -       fprintf(stderr, "fast-import: dumping crash report to %s\n", loc)=
;
> +       fprintf(stderr, _("fast-import: dumping crash report to %s\n"), l=
oc);
>
>         fprintf(rpt, "fast-import crash report:\n");
>         fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t)=
 getpid());
> @@ -588,7 +588,7 @@ static void *find_mark(struct mark_set *s, uintmax_t =
idnum)
>                         oe =3D s->data.marked[idnum];
>         }
>         if (!oe)
> -               die("mark :%" PRIuMAX " not declared", orig_idnum);
> +               die(_("mark :%" PRIuMAX " not declared"), orig_idnum);
>         return oe;
>  }
>
> @@ -628,9 +628,9 @@ static struct branch *new_branch(const char *name)
>         struct branch *b =3D lookup_branch(name);
>
>         if (b)
> -               die("Invalid attempt to create duplicate branch: %s", nam=
e);
> +               die(_("invalid attempt to create duplicate branch: %s"), =
name);
>         if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
> -               die("Branch name doesn't conform to GIT standards: %s", n=
ame);
> +               die(_("branch name doesn't conform to Git standards: %s")=
, name);
>
>         b =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct branch));
>         b->name =3D mem_pool_strdup(&fi_mem_pool, name);
> @@ -801,7 +801,7 @@ static const char *create_index(void)
>                                 *c++ =3D &e->idx;
>         last =3D idx + object_count;
>         if (c !=3D last)
> -               die("internal consistency error creating the index");
> +               die(_("internal consistency error creating the index"));
>
>         tmpfile =3D write_idx_file(the_repository, NULL, idx, object_coun=
t,
>                                  &pack_idx_opts, pack_data->hash);
> @@ -819,18 +819,18 @@ static char *keep_pack(const char *curr_index_name)
>         keep_fd =3D safe_create_file_with_leading_directories(pack_data->=
repo,
>                                                             name.buf);
>         if (keep_fd < 0)
> -               die_errno("cannot create keep file");
> +               die_errno(_("cannot create keep file"));
>         write_or_die(keep_fd, keep_msg, strlen(keep_msg));
>         if (close(keep_fd))
> -               die_errno("failed to write keep file");
> +               die_errno(_("failed to write keep file"));
>
>         odb_pack_name(pack_data->repo, &name, pack_data->hash, "pack");
>         if (finalize_object_file(pack_data->repo, pack_data->pack_name, n=
ame.buf))
> -               die("cannot store pack file");
> +               die(_("cannot store pack file"));
>
>         odb_pack_name(pack_data->repo, &name, pack_data->hash, "idx");
>         if (finalize_object_file(pack_data->repo, curr_index_name, name.b=
uf))
> -               die("cannot store index file");
> +               die(_("cannot store index file"));
>         free((void *)curr_index_name);
>         return strbuf_detach(&name, NULL);
>  }
> @@ -853,7 +853,7 @@ static int loosen_small_pack(const struct packed_git =
*p)
>         struct child_process unpack =3D CHILD_PROCESS_INIT;
>
>         if (lseek(p->pack_fd, 0, SEEK_SET) < 0)
> -               die_errno("Failed seeking to start of '%s'", p->pack_name=
);
> +               die_errno(_("failed seeking to start of '%s'"), p->pack_n=
ame);
>
>         unpack.in =3D p->pack_fd;
>         unpack.git_cmd =3D 1;
> @@ -903,7 +903,7 @@ static void end_packfile(void)
>                 new_p =3D packfile_store_load_pack(pack_data->repo->objec=
ts->packfiles,
>                                                  idx_name, 1);
>                 if (!new_p)
> -                       die("core git rejected index %s", idx_name);
> +                       die(_("core Git rejected index %s"), idx_name);
>                 all_packs[pack_id] =3D new_p;
>                 free(idx_name);
>
> @@ -1090,7 +1090,7 @@ static int store_object(
>  static void truncate_pack(struct hashfile_checkpoint *checkpoint)
>  {
>         if (hashfile_truncate(pack_file, checkpoint))
> -               die_errno("cannot truncate pack to skip duplicate");
> +               die_errno(_("cannot truncate pack to skip duplicate"));
>         pack_size =3D checkpoint->offset;
>  }
>
> @@ -1138,7 +1138,7 @@ static void stream_blob(uintmax_t len, struct objec=
t_id *oidout, uintmax_t mark)
>                         size_t cnt =3D in_sz < len ? in_sz : (size_t)len;
>                         size_t n =3D fread(in_buf, 1, cnt, stdin);
>                         if (!n && feof(stdin))
> -                               die("EOF in data (%" PRIuMAX " bytes rema=
ining)", len);
> +                               die(_("EOF in data (%" PRIuMAX " bytes re=
maining)"), len);
>
>                         git_hash_update(&c, in_buf, n);
>                         s.next_in =3D in_buf;
> @@ -1162,7 +1162,7 @@ static void stream_blob(uintmax_t len, struct objec=
t_id *oidout, uintmax_t mark)
>                 case Z_STREAM_END:
>                         continue;
>                 default:
> -                       die("unexpected deflate failure: %d", status);
> +                       die(_("unexpected deflate failure: %d"), status);
>                 }
>         }
>         git_deflate_end(&s);
> @@ -1264,16 +1264,16 @@ static void load_tree(struct tree_entry *root)
>         myoe =3D find_object(oid);
>         if (myoe && myoe->pack_id !=3D MAX_PACK_ID) {
>                 if (myoe->type !=3D OBJ_TREE)
> -                       die("Not a tree: %s", oid_to_hex(oid));
> +                       die(_("not a tree: %s"), oid_to_hex(oid));
>                 t->delta_depth =3D myoe->depth;
>                 buf =3D gfi_unpack_entry(myoe, &size);
>                 if (!buf)
> -                       die("Can't load tree %s", oid_to_hex(oid));
> +                       die(_("can't load tree %s"), oid_to_hex(oid));
>         } else {
>                 enum object_type type;
>                 buf =3D odb_read_object(the_repository->objects, oid, &ty=
pe, &size);
>                 if (!buf || type !=3D OBJ_TREE)
> -                       die("Can't load tree %s", oid_to_hex(oid));
> +                       die(_("can't load tree %s"), oid_to_hex(oid));
>         }
>
>         c =3D buf;
> @@ -1287,7 +1287,7 @@ static void load_tree(struct tree_entry *root)
>                 e->tree =3D NULL;
>                 c =3D parse_mode(c, &e->versions[1].mode);
>                 if (!c)
> -                       die("Corrupt mode in %s", oid_to_hex(oid));
> +                       die(_("corrupt mode in %s"), oid_to_hex(oid));
>                 e->versions[0].mode =3D e->versions[1].mode;
>                 e->name =3D to_atom(c, strlen(c));
>                 c +=3D e->name->str_len + 1;
> @@ -1399,7 +1399,7 @@ static void tree_content_replace(
>         struct tree_content *newtree)
>  {
>         if (!S_ISDIR(mode))
> -               die("Root cannot be a non-directory");
> +               die(_("root cannot be a non-directory"));
>         oidclr(&root->versions[0].oid, the_repository->hash_algo);
>         oidcpy(&root->versions[1].oid, oid);
>         if (root->tree)
> @@ -1422,9 +1422,9 @@ static int tree_content_set(
>         slash1 =3D strchrnul(p, '/');
>         n =3D slash1 - p;
>         if (!n)
> -               die("Empty path component found in input");
> +               die(_("empty path component found in input"));
>         if (!*slash1 && !S_ISDIR(mode) && subtree)
> -               die("Non-directories cannot have subtrees");
> +               die(_("non-directories cannot have subtrees"));
>
>         if (!root->tree)
>                 load_tree(root);
> @@ -1576,7 +1576,7 @@ static int tree_content_get(
>         slash1 =3D strchrnul(p, '/');
>         n =3D slash1 - p;
>         if (!n && !allow_root)
> -               die("Empty path component found in input");
> +               die(_("empty path component found in input"));
>
>         if (!root->tree)
>                 load_tree(root);
> @@ -1622,8 +1622,8 @@ static int update_branch(struct branch *b)
>             !strcmp(b->name + strlen(replace_prefix),
>                     oid_to_hex(&b->oid))) {
>                 if (!quiet)
> -                       warning("Dropping %s since it would point to "
> -                               "itself (i.e. to %s)",
> +                       warning(_("dropping %s since it would point to "
> +                                 "itself (i.e. to %s)"),
>                                 b->name, oid_to_hex(&b->oid));
>                 refs_delete_ref(get_main_ref_store(the_repository),
>                                 NULL, b->name, NULL, 0);
> @@ -1646,14 +1646,14 @@ static int update_branch(struct branch *b)
>                 new_cmit =3D lookup_commit_reference_gently(the_repositor=
y,
>                                                           &b->oid, 0);
>                 if (!old_cmit || !new_cmit)
> -                       return error("Branch %s is missing commits.", b->=
name);
> +                       return error(_("branch %s is missing commits."), =
b->name);
>
>                 ret =3D repo_in_merge_bases(the_repository, old_cmit, new=
_cmit);
>                 if (ret < 0)
>                         exit(128);
>                 if (!ret) {
> -                       warning("Not updating %s"
> -                               " (new tip %s does not contain %s)",
> +                       warning(_("not updating %s"
> +                                 " (new tip %s does not contain %s)"),
>                                 b->name, oid_to_hex(&b->oid),
>                                 oid_to_hex(&old_oid));
>                         return -1;
> @@ -1729,13 +1729,13 @@ static void dump_marks(void)
>                 return;
>
>         if (safe_create_leading_directories_const(the_repository, export_=
marks_file)) {
> -               failure |=3D error_errno("unable to create leading direct=
ories of %s",
> +               failure |=3D error_errno(_("unable to create leading dire=
ctories of %s"),
>                                        export_marks_file);
>                 return;
>         }
>
>         if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) <=
 0) {
> -               failure |=3D error_errno("Unable to write marks file %s",
> +               failure |=3D error_errno(_("unable to write marks file %s=
"),
>                                        export_marks_file);
>                 return;
>         }
> @@ -1744,14 +1744,14 @@ static void dump_marks(void)
>         if (!f) {
>                 int saved_errno =3D errno;
>                 rollback_lock_file(&mark_lock);
> -               failure |=3D error("Unable to write marks file %s: %s",
> +               failure |=3D error(_("unable to write marks file %s: %s")=
,
>                         export_marks_file, strerror(saved_errno));
>                 return;
>         }
>
>         for_each_mark(marks, 0, dump_marks_fn, f);
>         if (commit_lock_file(&mark_lock)) {
> -               failure |=3D error_errno("Unable to write file %s",
> +               failure |=3D error_errno(_("unable to write file %s"),
>                                        export_marks_file);
>                 return;
>         }
> @@ -1765,7 +1765,7 @@ static void insert_object_entry(struct mark_set **s=
, struct object_id *oid, uint
>                 enum object_type type =3D odb_read_object_info(the_reposi=
tory->objects,
>                                                              oid, NULL);
>                 if (type < 0)
> -                       die("object not found: %s", oid_to_hex(oid));
> +                       die(_("object not found: %s"), oid_to_hex(oid));
>                 e =3D insert_object(oid);
>                 e->type =3D type;
>                 e->pack_id =3D MAX_PACK_ID;
> @@ -1792,13 +1792,13 @@ static void read_mark_file(struct mark_set **s, F=
ILE *f, mark_set_inserter_t ins
>
>                 end =3D strchr(line, '\n');
>                 if (line[0] !=3D ':' || !end)
> -                       die("corrupt mark line: %s", line);
> +                       die(_("corrupt mark line: %s"), line);
>                 *end =3D 0;
>                 mark =3D strtoumax(line + 1, &end, 10);
>                 if (!mark || end =3D=3D line + 1
>                         || *end !=3D ' '
>                         || get_oid_hex_any(end + 1, &oid) =3D=3D GIT_HASH=
_UNKNOWN)
> -                       die("corrupt mark line: %s", line);
> +                       die(_("corrupt mark line: %s"), line);
>                 inserter(s, &oid, mark);
>         }
>  }
> @@ -1811,7 +1811,7 @@ static void read_marks(void)
>         else if (import_marks_file_ignore_missing && errno =3D=3D ENOENT)
>                 goto done; /* Marks file does not exist */
>         else
> -               die_errno("cannot read '%s'", import_marks_file);
> +               die_errno(_("cannot read '%s'"), import_marks_file);
>         read_mark_file(&marks, f, insert_object_entry);
>         fclose(f);
>  done:
> @@ -1897,7 +1897,7 @@ static int parse_data(struct strbuf *sb, uintmax_t =
limit, uintmax_t *len_res)
>         strbuf_reset(sb);
>
>         if (!skip_prefix(command_buf.buf, "data ", &data))
> -               die("Expected 'data n' command, found: %s", command_buf.b=
uf);
> +               die(_("expected 'data n' command, found: %s"), command_bu=
f.buf);
>
>         if (skip_prefix(data, "<<", &data)) {
>                 char *term =3D xstrdup(data);
> @@ -1905,7 +1905,7 @@ static int parse_data(struct strbuf *sb, uintmax_t =
limit, uintmax_t *len_res)
>
>                 for (;;) {
>                         if (strbuf_getline_lf(&command_buf, stdin) =3D=3D=
 EOF)
> -                               die("EOF in data (terminator '%s' not fou=
nd)", term);
> +                               die(_("EOF in data (terminator '%s' not f=
ound)"), term);
>                         if (term_len =3D=3D command_buf.len
>                                 && !strcmp(term, command_buf.buf))
>                                 break;
> @@ -1923,12 +1923,12 @@ static int parse_data(struct strbuf *sb, uintmax_=
t limit, uintmax_t *len_res)
>                         return 0;
>                 }
>                 if (length < len)
> -                       die("data is too large to use in this context");
> +                       die(_("data is too large to use in this context")=
);
>
>                 while (n < length) {
>                         size_t s =3D strbuf_fread(sb, length - n, stdin);
>                         if (!s && feof(stdin))
> -                               die("EOF in data (%lu bytes remaining)",
> +                               die(_("EOF in data (%lu bytes remaining)"=
),
>                                         (unsigned long)(length - n));
>                         n +=3D s;
>                 }
> @@ -1985,15 +1985,15 @@ static char *parse_ident(const char *buf)
>
>         ltgt =3D buf + strcspn(buf, "<>");
>         if (*ltgt !=3D '<')
> -               die("Missing < in ident string: %s", buf);
> +               die(_("missing < in ident string: %s"), buf);
>         if (ltgt !=3D buf && ltgt[-1] !=3D ' ')
> -               die("Missing space before < in ident string: %s", buf);
> +               die(_("missing space before < in ident string: %s"), buf)=
;
>         ltgt =3D ltgt + 1 + strcspn(ltgt + 1, "<>");
>         if (*ltgt !=3D '>')
> -               die("Missing > in ident string: %s", buf);
> +               die(_("missing > in ident string: %s"), buf);
>         ltgt++;
>         if (*ltgt !=3D ' ')
> -               die("Missing space after > in ident string: %s", buf);
> +               die(_("missing space after > in ident string: %s"), buf);
>         ltgt++;
>         name_len =3D ltgt - buf;
>         strbuf_add(&ident, buf, name_len);
> @@ -2001,19 +2001,19 @@ static char *parse_ident(const char *buf)
>         switch (whenspec) {
>         case WHENSPEC_RAW:
>                 if (validate_raw_date(ltgt, &ident, 1) < 0)
> -                       die("Invalid raw date \"%s\" in ident: %s", ltgt,=
 buf);
> +                       die(_("invalid raw date \"%s\" in ident: %s"), lt=
gt, buf);
>                 break;
>         case WHENSPEC_RAW_PERMISSIVE:
>                 if (validate_raw_date(ltgt, &ident, 0) < 0)
> -                       die("Invalid raw date \"%s\" in ident: %s", ltgt,=
 buf);
> +                       die(_("invalid raw date \"%s\" in ident: %s"), lt=
gt, buf);
>                 break;
>         case WHENSPEC_RFC2822:
>                 if (parse_date(ltgt, &ident) < 0)
> -                       die("Invalid rfc2822 date \"%s\" in ident: %s", l=
tgt, buf);
> +                       die(_("invalid rfc2822 date \"%s\" in ident: %s")=
, ltgt, buf);
>                 break;
>         case WHENSPEC_NOW:
>                 if (strcmp("now", ltgt))
> -                       die("Date in ident must be 'now': %s", buf);
> +                       die(_("date in ident must be 'now': %s"), buf);
>                 datestamp(&ident);
>                 break;
>         }
> @@ -2107,7 +2107,7 @@ static void construct_path_with_fanout(const char *=
hex_sha1,
>  {
>         unsigned int i =3D 0, j =3D 0;
>         if (fanout >=3D the_hash_algo->rawsz)
> -               die("Too large fanout (%u)", fanout);
> +               die(_("too large fanout (%u)"), fanout);
>         while (fanout) {
>                 path[i++] =3D hex_sha1[j++];
>                 path[i++] =3D hex_sha1[j++];
> @@ -2181,7 +2181,7 @@ static uintmax_t do_change_note_fanout(
>
>                         /* Rename fullpath to realpath */
>                         if (!tree_content_remove(orig_root, fullpath, &le=
af, 0))
> -                               die("Failed to remove path %s", fullpath)=
;
> +                               die(_("failed to remove path %s"), fullpa=
th);
>                         tree_content_set(orig_root, realpath,
>                                 &leaf.versions[1].oid,
>                                 leaf.versions[1].mode,
> @@ -2254,7 +2254,7 @@ static uintmax_t parse_mark_ref(const char *p, char=
 **endptr)
>         p++;
>         mark =3D strtoumax(p, endptr, 10);
>         if (*endptr =3D=3D p)
> -               die("No value after ':' in mark: %s", command_buf.buf);
> +               die(_("no value after ':' in mark: %s"), command_buf.buf)=
;
>         return mark;
>  }
>
> @@ -2269,7 +2269,7 @@ static uintmax_t parse_mark_ref_eol(const char *p)
>
>         mark =3D parse_mark_ref(p, &end);
>         if (*end !=3D '\0')
> -               die("Garbage after mark: %s", command_buf.buf);
> +               die(_("garbage after mark: %s"), command_buf.buf);
>         return mark;
>  }
>
> @@ -2284,7 +2284,7 @@ static uintmax_t parse_mark_ref_space(const char **=
p)
>
>         mark =3D parse_mark_ref(*p, &end);
>         if (*end++ !=3D ' ')
> -               die("Missing space after mark: %s", command_buf.buf);
> +               die(_("missing space after mark: %s"), command_buf.buf);
>         *p =3D end;
>         return mark;
>  }
> @@ -2300,9 +2300,9 @@ static void parse_path(struct strbuf *sb, const cha=
r *p, const char **endp,
>  {
>         if (*p =3D=3D '"') {
>                 if (unquote_c_style(sb, p, endp))
> -                       die("Invalid %s: %s", field, command_buf.buf);
> +                       die(_("invalid %s: %s"), field, command_buf.buf);
>                 if (strlen(sb->buf) !=3D sb->len)
> -                       die("NUL in %s: %s", field, command_buf.buf);
> +                       die(_("NUL in %s: %s"), field, command_buf.buf);
>         } else {
>                 /*
>                  * Unless we are parsing the last field of a line,
> @@ -2325,7 +2325,7 @@ static void parse_path_eol(struct strbuf *sb, const=
 char *p, const char *field)
>
>         parse_path(sb, p, &end, 1, field);
>         if (*end)
> -               die("Garbage after %s: %s", field, command_buf.buf);
> +               die(_("garbage after %s: %s"), field, command_buf.buf);
>  }
>
>  /*
> @@ -2338,7 +2338,7 @@ static void parse_path_space(struct strbuf *sb, con=
st char *p,
>  {
>         parse_path(sb, p, endp, 0, field);
>         if (**endp !=3D ' ')
> -               die("Missing space after %s: %s", field, command_buf.buf)=
;
> +               die(_("missing space after %s: %s"), field, command_buf.b=
uf);
>         (*endp)++;
>  }
>
> @@ -2351,7 +2351,7 @@ static void file_change_m(const char *p, struct bra=
nch *b)
>
>         p =3D parse_mode(p, &mode);
>         if (!p)
> -               die("Corrupt mode: %s", command_buf.buf);
> +               die(_("corrupt mode: %s"), command_buf.buf);
>         switch (mode) {
>         case 0644:
>         case 0755:
> @@ -2364,7 +2364,7 @@ static void file_change_m(const char *p, struct bra=
nch *b)
>                 /* ok */
>                 break;
>         default:
> -               die("Corrupt mode: %s", command_buf.buf);
> +               die(_("corrupt mode: %s"), command_buf.buf);
>         }
>
>         if (*p =3D=3D ':') {
> @@ -2375,10 +2375,10 @@ static void file_change_m(const char *p, struct b=
ranch *b)
>                 oe =3D NULL; /* not used with inline_data, but makes gcc =
happy */
>         } else {
>                 if (parse_mapped_oid_hex(p, &oid, &p))
> -                       die("Invalid dataref: %s", command_buf.buf);
> +                       die(_("invalid dataref: %s"), command_buf.buf);
>                 oe =3D find_object(&oid);
>                 if (*p++ !=3D ' ')
> -                       die("Missing space after SHA1: %s", command_buf.b=
uf);
> +                       die(_("missing space after SHA1: %s"), command_bu=
f.buf);
>         }
>
>         strbuf_reset(&path);
> @@ -2394,11 +2394,11 @@ static void file_change_m(const char *p, struct b=
ranch *b)
>
>         if (S_ISGITLINK(mode)) {
>                 if (inline_data)
> -                       die("Git links cannot be specified 'inline': %s",
> +                       die(_("Git links cannot be specified 'inline': %s=
"),
>                                 command_buf.buf);
>                 else if (oe) {
>                         if (oe->type !=3D OBJ_COMMIT)
> -                               die("Not a commit (actually a %s): %s",
> +                               die(_("not a commit (actually a %s): %s")=
,
>                                         type_name(oe->type), command_buf.=
buf);
>                 }
>                 /*
> @@ -2407,7 +2407,7 @@ static void file_change_m(const char *p, struct bra=
nch *b)
>                  */
>         } else if (inline_data) {
>                 if (S_ISDIR(mode))
> -                       die("Directories cannot be specified 'inline': %s=
",
> +                       die(_("directories cannot be specified 'inline': =
%s"),
>                                 command_buf.buf);
>                 while (read_next_command() !=3D EOF) {
>                         const char *v;
> @@ -2425,11 +2425,11 @@ static void file_change_m(const char *p, struct b=
ranch *b)
>                                         odb_read_object_info(the_reposito=
ry->objects,
>                                                              &oid, NULL);
>                 if (type < 0)
> -                       die("%s not found: %s",
> -                                       S_ISDIR(mode) ?  "Tree" : "Blob",
> -                                       command_buf.buf);
> +                       die(_("%s not found: %s"),
> +                           S_ISDIR(mode) ?  _("tree") : _("blob"),
> +                           command_buf.buf);
>                 if (type !=3D expected)
> -                       die("Not a %s (actually a %s): %s",
> +                       die(_("not a %s (actually a %s): %s"),
>                                 type_name(expected), type_name(type),
>                                 command_buf.buf);
>         }
> @@ -2440,7 +2440,7 @@ static void file_change_m(const char *p, struct bra=
nch *b)
>         }
>
>         if (!verify_path(path.buf, mode))
> -               die("invalid path '%s'", path.buf);
> +               die(_("invalid path '%s'"), path.buf);
>         tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
>  }
>
> @@ -2470,7 +2470,7 @@ static void file_change_cr(const char *p, struct br=
anch *b, int rename)
>         else
>                 tree_content_get(&b->branch_tree, source.buf, &leaf, 1);
>         if (!leaf.versions[1].mode)
> -               die("Path %s not in branch", source.buf);
> +               die(_("path %s not in branch"), source.buf);
>         if (!*dest.buf) {       /* C "path/to/subdir" "" */
>                 tree_content_replace(&b->branch_tree,
>                         &leaf.versions[1].oid,
> @@ -2479,7 +2479,7 @@ static void file_change_cr(const char *p, struct br=
anch *b, int rename)
>                 return;
>         }
>         if (!verify_path(dest.buf, leaf.versions[1].mode))
> -               die("invalid path '%s'", dest.buf);
> +               die(_("invalid path '%s'"), dest.buf);
>         tree_content_set(&b->branch_tree, dest.buf,
>                 &leaf.versions[1].oid,
>                 leaf.versions[1].mode,
> @@ -2521,23 +2521,23 @@ static void note_change_n(const char *p, struct b=
ranch *b, unsigned char *old_fa
>                 oe =3D NULL; /* not used with inline_data, but makes gcc =
happy */
>         } else {
>                 if (parse_mapped_oid_hex(p, &oid, &p))
> -                       die("Invalid dataref: %s", command_buf.buf);
> +                       die(_("invalid dataref: %s"), command_buf.buf);
>                 oe =3D find_object(&oid);
>                 if (*p++ !=3D ' ')
> -                       die("Missing space after SHA1: %s", command_buf.b=
uf);
> +                       die(_("missing space after SHA1: %s"), command_bu=
f.buf);
>         }
>
>         /* <commit-ish> */
>         s =3D lookup_branch(p);
>         if (s) {
>                 if (is_null_oid(&s->oid))
> -                       die("Can't add a note on empty branch.");
> +                       die(_("can't add a note on empty branch."));
>                 oidcpy(&commit_oid, &s->oid);
>         } else if (*p =3D=3D ':') {
>                 uintmax_t commit_mark =3D parse_mark_ref_eol(p);
>                 struct object_entry *commit_oe =3D find_mark(marks, commi=
t_mark);
>                 if (commit_oe->type !=3D OBJ_COMMIT)
> -                       die("Mark :%" PRIuMAX " not a commit", commit_mar=
k);
> +                       die(_("mark :%" PRIuMAX " not a commit"), commit_=
mark);
>                 oidcpy(&commit_oid, &commit_oe->idx.oid);
>         } else if (!repo_get_oid(the_repository, p, &commit_oid)) {
>                 unsigned long size;
> @@ -2545,25 +2545,25 @@ static void note_change_n(const char *p, struct b=
ranch *b, unsigned char *old_fa
>                                                    &commit_oid, OBJ_COMMI=
T, &size,
>                                                    &commit_oid);
>                 if (!buf || size < the_hash_algo->hexsz + 6)
> -                       die("Not a valid commit: %s", p);
> +                       die(_("not a valid commit: %s"), p);
>                 free(buf);
>         } else
> -               die("Invalid ref name or SHA1 expression: %s", p);
> +               die(_("invalid ref name or SHA1 expression: %s"), p);
>
>         if (inline_data) {
>                 read_next_command();
>                 parse_and_store_blob(&last_blob, &oid, 0);
>         } else if (oe) {
>                 if (oe->type !=3D OBJ_BLOB)
> -                       die("Not a blob (actually a %s): %s",
> +                       die(_("not a blob (actually a %s): %s"),
>                                 type_name(oe->type), command_buf.buf);
>         } else if (!is_null_oid(&oid)) {
>                 enum object_type type =3D odb_read_object_info(the_reposi=
tory->objects, &oid,
>                                                         NULL);
>                 if (type < 0)
> -                       die("Blob not found: %s", command_buf.buf);
> +                       die(_("blob not found: %s"), command_buf.buf);
>                 if (type !=3D OBJ_BLOB)
> -                       die("Not a blob (actually a %s): %s",
> +                       die(_("not a blob (actually a %s): %s"),
>                             type_name(type), command_buf.buf);
>         }
>
> @@ -2592,10 +2592,10 @@ static void file_change_deleteall(struct branch *=
b)
>  static void parse_from_commit(struct branch *b, char *buf, unsigned long=
 size)
>  {
>         if (!buf || size < the_hash_algo->hexsz + 6)
> -               die("Not a valid commit: %s", oid_to_hex(&b->oid));
> +               die(_("not a valid commit: %s"), oid_to_hex(&b->oid));
>         if (memcmp("tree ", buf, 5)
>                 || get_oid_hex(buf + 5, &b->branch_tree.versions[1].oid))
> -               die("The commit %s is corrupt", oid_to_hex(&b->oid));
> +               die(_("the commit %s is corrupt"), oid_to_hex(&b->oid));
>         oidcpy(&b->branch_tree.versions[0].oid,
>                &b->branch_tree.versions[1].oid);
>  }
> @@ -2625,7 +2625,7 @@ static int parse_objectish(struct branch *b, const =
char *objectish)
>
>         s =3D lookup_branch(objectish);
>         if (b =3D=3D s)
> -               die("Can't create a branch from itself: %s", b->name);
> +               die(_("can't create a branch from itself: %s"), b->name);
>         else if (s) {
>                 struct object_id *t =3D &s->branch_tree.versions[1].oid;
>                 oidcpy(&b->oid, &s->oid);
> @@ -2635,7 +2635,7 @@ static int parse_objectish(struct branch *b, const =
char *objectish)
>                 uintmax_t idnum =3D parse_mark_ref_eol(objectish);
>                 struct object_entry *oe =3D find_mark(marks, idnum);
>                 if (oe->type !=3D OBJ_COMMIT)
> -                       die("Mark :%" PRIuMAX " not a commit", idnum);
> +                       die(_("mark :%" PRIuMAX " not a commit"), idnum);
>                 if (!oideq(&b->oid, &oe->idx.oid)) {
>                         oidcpy(&b->oid, &oe->idx.oid);
>                         if (oe->pack_id !=3D MAX_PACK_ID) {
> @@ -2652,7 +2652,7 @@ static int parse_objectish(struct branch *b, const =
char *objectish)
>                         b->delete =3D 1;
>         }
>         else
> -               die("Invalid ref name or SHA1 expression: %s", objectish)=
;
> +               die(_("invalid ref name or SHA1 expression: %s"), objecti=
sh);
>
>         if (b->branch_tree.tree && !oideq(&oid, &b->branch_tree.versions[=
1].oid)) {
>                 release_tree_content_recursive(b->branch_tree.tree);
> @@ -2699,7 +2699,7 @@ static struct hash_list *parse_merge(unsigned int *=
count)
>                         uintmax_t idnum =3D parse_mark_ref_eol(from);
>                         struct object_entry *oe =3D find_mark(marks, idnu=
m);
>                         if (oe->type !=3D OBJ_COMMIT)
> -                               die("Mark :%" PRIuMAX " not a commit", id=
num);
> +                               die(_("mark :%" PRIuMAX " not a commit"),=
 idnum);
>                         oidcpy(&n->oid, &oe->idx.oid);
>                 } else if (!repo_get_oid(the_repository, from, &n->oid)) =
{
>                         unsigned long size;
> @@ -2707,10 +2707,10 @@ static struct hash_list *parse_merge(unsigned int=
 *count)
>                                                            &n->oid, OBJ_C=
OMMIT,
>                                                            &size, &n->oid=
);
>                         if (!buf || size < the_hash_algo->hexsz + 6)
> -                               die("Not a valid commit: %s", from);
> +                               die(_("not a valid commit: %s"), from);
>                         free(buf);
>                 } else
> -                       die("Invalid ref name or SHA1 expression: %s", fr=
om);
> +                       die(_("invalid ref name or SHA1 expression: %s"),=
 from);
>
>                 n->next =3D NULL;
>                 *tail =3D n;
> @@ -2734,8 +2734,8 @@ static void parse_one_signature(struct signature_da=
ta *sig, const char *v)
>         char *space =3D strchr(args, ' ');
>
>         if (!space)
> -               die("Expected gpgsig format: 'gpgsig <hash-algo> <signatu=
re-format>', "
> -                   "got 'gpgsig %s'", args);
> +               die(_("expected gpgsig format: 'gpgsig <hash-algo> <signa=
ture-format>', "
> +                     "got 'gpgsig %s'"), args);
>         *space =3D '\0';
>
>         sig->hash_algo =3D args;
> @@ -2744,13 +2744,13 @@ static void parse_one_signature(struct signature_=
data *sig, const char *v)
>         /* Validate hash algorithm */
>         if (strcmp(sig->hash_algo, "sha1") &&
>             strcmp(sig->hash_algo, "sha256"))
> -               die("Unknown git hash algorithm in gpgsig: '%s'", sig->ha=
sh_algo);
> +               die(_("unknown git hash algorithm in gpgsig: '%s'"), sig-=
>hash_algo);
>
>         /* Validate signature format */
>         if (!valid_signature_format(sig->sig_format))
> -               die("Invalid signature format in gpgsig: '%s'", sig->sig_=
format);
> +               die(_("invalid signature format in gpgsig: '%s'"), sig->s=
ig_format);
>         if (!strcmp(sig->sig_format, "unknown"))
> -               warning("'unknown' signature format in gpgsig");
> +               warning(_("'unknown' signature format in gpgsig"));
>
>         /* Read signature data */
>         read_next_command();
> @@ -2789,8 +2789,8 @@ static void store_signature(struct signature_data *=
stored_sig,
>                             const char *hash_type)
>  {
>         if (stored_sig->hash_algo) {
> -               warning("multiple %s signatures found, "
> -                       "ignoring additional signature",
> +               warning(_("multiple %s signatures found, "
> +                         "ignoring additional signature"),
>                         hash_type);
>                 strbuf_release(&new_sig->data);
>                 free(new_sig->hash_algo);
> @@ -2845,15 +2845,15 @@ static void parse_new_commit(const char *arg)
>                 read_next_command();
>         }
>         if (!committer)
> -               die("Expected committer but didn't get one");
> +               die(_("expected committer but didn't get one"));
>
>         while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
>                 switch (signed_commit_mode) {
>
>                 /* First, modes that don't need the signature to be parse=
d */
>                 case SIGN_ABORT:
> -                       die("encountered signed commit; use "
> -                           "--signed-commits=3D<mode> to handle it");
> +                       die(_("encountered signed commit; use "
> +                             "--signed-commits=3D<mode> to handle it"));
>                 case SIGN_WARN_STRIP:
>                         warning(_("stripping a commit signature"));
>                         /* fallthru */
> @@ -3025,11 +3025,11 @@ static void parse_new_tag(const char *arg)
>
>         /* from ... */
>         if (!skip_prefix(command_buf.buf, "from ", &from))
> -               die("Expected from command, got %s", command_buf.buf);
> +               die(_("expected 'from' command, got '%s'"), command_buf.b=
uf);
>         s =3D lookup_branch(from);
>         if (s) {
>                 if (is_null_oid(&s->oid))
> -                       die("Can't tag an empty branch.");
> +                       die(_("can't tag an empty branch."));
>                 oidcpy(&oid, &s->oid);
>                 type =3D OBJ_COMMIT;
>         } else if (*from =3D=3D ':') {
> @@ -3044,11 +3044,11 @@ static void parse_new_tag(const char *arg)
>                         type =3D odb_read_object_info(the_repository->obj=
ects,
>                                                     &oid, NULL);
>                         if (type < 0)
> -                               die("Not a valid object: %s", from);
> +                               die(_("not a valid object: %s"), from);
>                 } else
>                         type =3D oe->type;
>         } else
> -               die("Invalid ref name or SHA1 expression: %s", from);
> +               die(_("invalid ref name or SHA1 expression: %s"), from);
>         read_next_command();
>
>         /* original-oid ... */
> @@ -3139,7 +3139,7 @@ static void parse_reset_branch(const char *arg)
>  static void cat_blob_write(const char *buf, unsigned long size)
>  {
>         if (write_in_full(cat_blob_fd, buf, size) < 0)
> -               die_errno("Write to frontend failed");
> +               die_errno(_("write to frontend failed"));
>  }
>
>  static void cat_blob(struct object_entry *oe, struct object_id *oid)
> @@ -3168,9 +3168,9 @@ static void cat_blob(struct object_entry *oe, struc=
t object_id *oid)
>                 return;
>         }
>         if (!buf)
> -               die("Can't read object %s", oid_to_hex(oid));
> +               die(_("can't read object %s"), oid_to_hex(oid));
>         if (type !=3D OBJ_BLOB)
> -               die("Object %s is a %s but a blob was expected.",
> +               die(_("object %s is a %s but a blob was expected."),
>                     oid_to_hex(oid), type_name(type));
>         strbuf_reset(&line);
>         strbuf_addf(&line, "%s %s %"PRIuMAX"\n", oid_to_hex(oid),
> @@ -3194,11 +3194,11 @@ static void parse_get_mark(const char *p)
>
>         /* get-mark SP <object> LF */
>         if (*p !=3D ':')
> -               die("Not a mark: %s", p);
> +               die(_("not a mark: %s"), p);
>
>         oe =3D find_mark(marks, parse_mark_ref_eol(p));
>         if (!oe)
> -               die("Unknown mark: %s", command_buf.buf);
> +               die(_("unknown mark: %s"), command_buf.buf);
>
>         xsnprintf(output, sizeof(output), "%s\n", oid_to_hex(&oe->idx.oid=
));
>         cat_blob_write(output, the_hash_algo->hexsz + 1);
> @@ -3213,13 +3213,13 @@ static void parse_cat_blob(const char *p)
>         if (*p =3D=3D ':') {
>                 oe =3D find_mark(marks, parse_mark_ref_eol(p));
>                 if (!oe)
> -                       die("Unknown mark: %s", command_buf.buf);
> +                       die(_("unknown mark: %s"), command_buf.buf);
>                 oidcpy(&oid, &oe->idx.oid);
>         } else {
>                 if (parse_mapped_oid_hex(p, &oid, &p))
> -                       die("Invalid dataref: %s", command_buf.buf);
> +                       die(_("invalid dataref: %s"), command_buf.buf);
>                 if (*p)
> -                       die("Garbage after SHA1: %s", command_buf.buf);
> +                       die(_("garbage after SHA1: %s"), command_buf.buf)=
;
>                 oe =3D find_object(&oid);
>         }
>
> @@ -3237,7 +3237,7 @@ static struct object_entry *dereference(struct obje=
ct_entry *oe,
>                 enum object_type type =3D odb_read_object_info(the_reposi=
tory->objects,
>                                                              oid, NULL);
>                 if (type < 0)
> -                       die("object not found: %s", oid_to_hex(oid));
> +                       die(_("object not found: %s"), oid_to_hex(oid));
>                 /* cache it! */
>                 oe =3D insert_object(oid);
>                 oe->type =3D type;
> @@ -3251,7 +3251,7 @@ static struct object_entry *dereference(struct obje=
ct_entry *oe,
>         case OBJ_TAG:
>                 break;
>         default:
> -               die("Not a tree-ish: %s", command_buf.buf);
> +               die(_("not a tree-ish: %s"), command_buf.buf);
>         }
>
>         if (oe->pack_id !=3D MAX_PACK_ID) {       /* in a pack being writ=
ten */
> @@ -3262,19 +3262,19 @@ static struct object_entry *dereference(struct ob=
ject_entry *oe,
>                                       &unused, &size);
>         }
>         if (!buf)
> -               die("Can't load object %s", oid_to_hex(oid));
> +               die(_("can't load object %s"), oid_to_hex(oid));
>
>         /* Peel one layer. */
>         switch (oe->type) {
>         case OBJ_TAG:
>                 if (size < hexsz + strlen("object ") ||
>                     get_oid_hex(buf + strlen("object "), oid))
> -                       die("Invalid SHA1 in tag: %s", command_buf.buf);
> +                       die(_("invalid SHA1 in tag: %s"), command_buf.buf=
);
>                 break;
>         case OBJ_COMMIT:
>                 if (size < hexsz + strlen("tree ") ||
>                     get_oid_hex(buf + strlen("tree "), oid))
> -                       die("Invalid SHA1 in commit: %s", command_buf.buf=
);
> +                       die(_("invalid SHA1 in commit: %s"), command_buf.=
buf);
>         }
>
>         free(buf);
> @@ -3309,9 +3309,9 @@ static void build_mark_map(struct string_list *from=
, struct string_list *to)
>         for_each_string_list_item(fromp, from) {
>                 top =3D string_list_lookup(to, fromp->string);
>                 if (!fromp->util) {
> -                       die(_("Missing from marks for submodule '%s'"), f=
romp->string);
> +                       die(_("missing from marks for submodule '%s'"), f=
romp->string);
>                 } else if (!top || !top->util) {
> -                       die(_("Missing to marks for submodule '%s'"), fro=
mp->string);
> +                       die(_("missing to marks for submodule '%s'"), fro=
mp->string);
>                 }
>                 build_mark_map_one(fromp->util, top->util);
>         }
> @@ -3325,14 +3325,14 @@ static struct object_entry *parse_treeish_dataref=
(const char **p)
>         if (**p =3D=3D ':') {       /* <mark> */
>                 e =3D find_mark(marks, parse_mark_ref_space(p));
>                 if (!e)
> -                       die("Unknown mark: %s", command_buf.buf);
> +                       die(_("unknown mark: %s"), command_buf.buf);
>                 oidcpy(&oid, &e->idx.oid);
>         } else {        /* <sha1> */
>                 if (parse_mapped_oid_hex(*p, &oid, p))
> -                       die("Invalid dataref: %s", command_buf.buf);
> +                       die(_("invalid dataref: %s"), command_buf.buf);
>                 e =3D find_object(&oid);
>                 if (*(*p)++ !=3D ' ')
> -                       die("Missing space after tree-ish: %s", command_b=
uf.buf);
> +                       die(_("missing space after tree-ish: %s"), comman=
d_buf.buf);
>         }
>
>         while (!e || e->type !=3D OBJ_TREE)
> @@ -3376,7 +3376,7 @@ static void parse_ls(const char *p, struct branch *=
b)
>         /* ls SP (<tree-ish> SP)? <path> */
>         if (*p =3D=3D '"') {
>                 if (!b)
> -                       die("Not in a commit: %s", command_buf.buf);
> +                       die(_("not in a commit: %s"), command_buf.buf);
>                 root =3D &b->branch_tree;
>         } else {
>                 struct object_entry *e =3D parse_treeish_dataref(&p);
> @@ -3439,12 +3439,12 @@ static void parse_alias(void)
>         /* mark ... */
>         parse_mark();
>         if (!next_mark)
> -               die(_("Expected 'mark' command, got %s"), command_buf.buf=
);
> +               die(_("expected 'mark' command, got %s"), command_buf.buf=
);
>
>         /* to ... */
>         memset(&b, 0, sizeof(b));
>         if (!parse_objectish_with_prefix(&b, "to "))
> -               die(_("Expected 'to' command, got %s"), command_buf.buf);
> +               die(_("expected 'to' command, got %s"), command_buf.buf);
>         e =3D find_object(&b.oid);
>         assert(e);
>         insert_mark(&marks, next_mark, e);
> @@ -3462,7 +3462,7 @@ static void option_import_marks(const char *marks,
>  {
>         if (import_marks_file) {
>                 if (from_stream)
> -                       die("Only one import-marks command allowed per st=
ream");
> +                       die(_("only one import-marks command allowed per =
stream"));
>
>                 /* read previous mark file */
>                 if(!import_marks_file_from_stream)
> @@ -3486,7 +3486,7 @@ static void option_date_format(const char *fmt)
>         else if (!strcmp(fmt, "now"))
>                 whenspec =3D WHENSPEC_NOW;
>         else
> -               die("unknown --date-format argument %s", fmt);
> +               die(_("unknown --date-format argument %s"), fmt);
>  }
>
>  static unsigned long ulong_arg(const char *option, const char *arg)
> @@ -3494,7 +3494,7 @@ static unsigned long ulong_arg(const char *option, =
const char *arg)
>         char *endptr;
>         unsigned long rv =3D strtoul(arg, &endptr, 0);
>         if (strchr(arg, '-') || endptr =3D=3D arg || *endptr)
> -               die("%s: argument must be a non-negative integer", option=
);
> +               die(_("%s: argument must be a non-negative integer"), opt=
ion);
>         return rv;
>  }
>
> @@ -3502,7 +3502,7 @@ static void option_depth(const char *depth)
>  {
>         max_depth =3D ulong_arg("--depth", depth);
>         if (max_depth > MAX_DEPTH)
> -               die("--depth cannot exceed %u", MAX_DEPTH);
> +               die(_("--depth cannot exceed %u"), MAX_DEPTH);
>  }
>
>  static void option_active_branches(const char *branches)
> @@ -3520,7 +3520,7 @@ static void option_cat_blob_fd(const char *fd)
>  {
>         unsigned long n =3D ulong_arg("--cat-blob-fd", fd);
>         if (n > (unsigned long) INT_MAX)
> -               die("--cat-blob-fd cannot exceed %d", INT_MAX);
> +               die(_("--cat-blob-fd cannot exceed %d"), INT_MAX);
>         cat_blob_fd =3D (int) n;
>  }
>
> @@ -3540,7 +3540,7 @@ static void option_rewrite_submodules(const char *a=
rg, struct string_list *list)
>         char *s =3D xstrdup(arg);
>         char *f =3D strchr(s, ':');
>         if (!f)
> -               die(_("Expected format name:filename for submodule rewrit=
e option"));
> +               die(_("expected format name:filename for submodule rewrit=
e option"));
>         *f =3D '\0';
>         f++;
>         CALLOC_ARRAY(ms, 1);
> @@ -3548,7 +3548,7 @@ static void option_rewrite_submodules(const char *a=
rg, struct string_list *list)
>         f =3D prefix_filename(global_prefix, f);
>         fp =3D fopen(f, "r");
>         if (!fp)
> -               die_errno("cannot read '%s'", f);
> +               die_errno(_("cannot read '%s'"), f);
>         read_mark_file(&ms, fp, insert_oid_entry);
>         fclose(fp);
>         free(f);
> @@ -3565,10 +3565,10 @@ static int parse_one_option(const char *option)
>                 if (!git_parse_ulong(option, &v))
>                         return 0;
>                 if (v < 8192) {
> -                       warning("max-pack-size is now in bytes, assuming =
--max-pack-size=3D%lum", v);
> +                       warning(_("max-pack-size is now in bytes, assumin=
g --max-pack-size=3D%lum"), v);
>                         v *=3D 1024 * 1024;
>                 } else if (v < 1024 * 1024) {
> -                       warning("minimum max-pack-size is 1 MiB");
> +                       warning(_("minimum max-pack-size is 1 MiB"));
>                         v =3D 1024 * 1024;
>                 }
>                 max_packsize =3D v;
> @@ -3655,23 +3655,23 @@ static int parse_one_feature(const char *feature,=
 int from_stream)
>  static void parse_feature(const char *feature)
>  {
>         if (seen_data_command)
> -               die("Got feature command '%s' after data command", featur=
e);
> +               die(_("got feature command '%s' after data command"), fea=
ture);
>
>         if (parse_one_feature(feature, 1))
>                 return;
>
> -       die("This version of fast-import does not support feature %s.", f=
eature);
> +       die(_("this version of fast-import does not support feature %s.")=
, feature);
>  }
>
>  static void parse_option(const char *option)
>  {
>         if (seen_data_command)
> -               die("Got option command '%s' after data command", option)=
;
> +               die(_("got option command '%s' after data command"), opti=
on);
>
>         if (parse_one_option(option))
>                 return;
>
> -       die("This version of fast-import does not support option: %s", op=
tion);
> +       die(_("this version of fast-import does not support option: %s"),=
 option);
>  }
>
>  static void git_pack_config(void)
> @@ -3715,7 +3715,7 @@ static void parse_argv(void)
>                         break;
>
>                 if (!skip_prefix(a, "--", &a))
> -                       die("unknown option %s", a);
> +                       die(_("unknown option %s"), a);
>
>                 if (parse_one_option(a))
>                         continue;
> @@ -3728,7 +3728,7 @@ static void parse_argv(void)
>                         continue;
>                 }
>
> -               die("unknown option --%s", a);
> +               die(_("unknown option --%s"), a);
>         }
>         if (i !=3D global_argc)
>                 usage(fast_import_usage);
> @@ -3817,7 +3817,7 @@ int cmd_fast_import(int argc,
>                 else if (starts_with(command_buf.buf, "option "))
>                         /* ignore non-git options*/;
>                 else
> -                       die("Unsupported command: %s", command_buf.buf);
> +                       die(_("unsupported command: %s"), command_buf.buf=
);
>
>                 if (checkpoint_requested)
>                         checkpoint();
> @@ -3828,7 +3828,7 @@ int cmd_fast_import(int argc,
>                 parse_argv();
>
>         if (require_explicit_termination && feof(stdin))
> -               die("stream ends early");
> +               die(_("stream ends early"));
>
>         end_packfile();
>
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 4dc3d645bf..5685cce6fe 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -2927,16 +2927,16 @@ test_expect_success 'R: blob appears only once' '
>  # The error message when a space is missing not at the
>  # end of the line is:
>  #
> -#   Missing space after ..
> +#   missing space after ..
>  #
>  # or when extra characters come after the mark at the end
>  # of the line:
>  #
> -#   Garbage after ..
> +#   garbage after ..
>  #
>  # or when the dataref is neither "inline " or a known SHA1,
>  #
> -#   Invalid dataref ..
> +#   invalid dataref ..
>  #
>  test_expect_success 'S: initialize for S tests' '
>         test_tick &&
> @@ -3405,15 +3405,15 @@ test_path_fail () {
>
>  test_path_base_fail () {
>         local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
> -       test_path_fail "$change" 'unclosed " in '"$field"          "$pref=
ix" '"hello.c'    "$suffix" "Invalid $field"
> -       test_path_fail "$change" "invalid escape in quoted $field" "$pref=
ix" '"hello\xff"' "$suffix" "Invalid $field"
> +       test_path_fail "$change" 'unclosed " in '"$field"          "$pref=
ix" '"hello.c'    "$suffix" "invalid $field"
> +       test_path_fail "$change" "invalid escape in quoted $field" "$pref=
ix" '"hello\xff"' "$suffix" "invalid $field"
>         test_path_fail "$change" "escaped NUL in quoted $field"    "$pref=
ix" '"hello\000"' "$suffix" "NUL in $field"
>  }
>  test_path_eol_quoted_fail () {
>         local change=3D"$1" prefix=3D"$2" field=3D"$3"
>         test_path_base_fail "$change" "$prefix" "$field" ''
> -       test_path_fail "$change" "garbage after quoted $field" "$prefix" =
'"hello.c"' 'x' "Garbage after $field"
> -       test_path_fail "$change" "space after quoted $field"   "$prefix" =
'"hello.c"' ' ' "Garbage after $field"
> +       test_path_fail "$change" "garbage after quoted $field" "$prefix" =
'"hello.c"' 'x' "garbage after $field"
> +       test_path_fail "$change" "space after quoted $field"   "$prefix" =
'"hello.c"' ' ' "garbage after $field"
>  }
>  test_path_eol_fail () {
>         local change=3D"$1" prefix=3D"$2" field=3D"$3"
> @@ -3422,8 +3422,8 @@ test_path_eol_fail () {
>  test_path_space_fail () {
>         local change=3D"$1" prefix=3D"$2" field=3D"$3"
>         test_path_base_fail "$change" "$prefix" "$field" ' world.c'
> -       test_path_fail "$change" "missing space after quoted $field"   "$=
prefix" '"hello.c"' 'x world.c' "Missing space after $field"
> -       test_path_fail "$change" "missing space after unquoted $field" "$=
prefix" 'hello.c'   ''          "Missing space after $field"
> +       test_path_fail "$change" "missing space after quoted $field"   "$=
prefix" '"hello.c"' 'x world.c' "missing space after $field"
> +       test_path_fail "$change" "missing space after unquoted $field" "$=
prefix" 'hello.c'   ''          "missing space after $field"
>  }
>
>  test_path_eol_fail   filemodify       'M 100644 :1 ' path
> @@ -3820,7 +3820,7 @@ test_expect_success 'X: replace ref that becomes us=
eless is removed' '
>                 sed -e s/othername/somename/ tmp >tmp2 &&
>                 git fast-import --force <tmp2 2>msgs &&
>
> -               grep "Dropping.*since it would point to itself" msgs &&
> +               grep "dropping.*since it would point to itself" msgs &&
>                 git show-ref >refs &&
>                 ! grep refs/replace refs
>         )
> --
> 2.51.2.617.g2aaa867cd1
>
