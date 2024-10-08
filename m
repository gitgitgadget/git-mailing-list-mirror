Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64B215024
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423682; cv=none; b=GrK24ZNPLjw4xf2tqDgXkV4AqvcKRKA38Sq8Uswny7bCA6eSnxNvj0W4z4pCsiDs34OFZfTHTxd3HZzhzlp3oWiBdx92QwsvaEYWWEwBfLDy+g6DDsl0sOjCGV0Z/Jykz/VV2slIo1B6uYCgCNoS/BMvVyU7y5kf7UA7AmmsqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423682; c=relaxed/simple;
	bh=7oB70tfDI3ssAQsHUszH1uk6Ce6aVsdpbapwiGXsTmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rpe6Fo35vUN33Enpr5rHAcH1Tg0HDCMa+ASibBfnpBvPT2e047kN3pgN6oR8SNW39hh2ItR1bUXhpTLwC7Iv/X8s1CnCqRbDqTxdhA5m77ROUFSo08OR+iYZJThG76t3XYvUPAKy+oXPnOVeLedk0b0IqFiCvfl/0bvVr6OdkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Osa5gu1R; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Osa5gu1R"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb1dd2886so92935e9.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728423676; x=1729028476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtG1s/PtEOi+3FxFvS7615HzvesaTB8jgjBY7bn8JsM=;
        b=Osa5gu1R29LYKnepSCzkVimUWBzpJk0hZpPD7yZ3TzvLujWN10Tg0ysdMLCemHB0zK
         7Fy4Cp1my7lLRP7DJ/OP9X+UeUdSufPTCpsmDvPykrpeT0UXqw4YWNCt6UObvycsSx+o
         bdrS4mv/LHsyqdoKSrJxyeBa/M83lGH9ykakuD1S27gAGBTYcZ5lGaZyx6M1LQ3yZ67p
         2QRTJ8u5X0tu83HbH343slYf6l6M3uu3MWHFhpdB/skzmWh/qex3zg5zuRabwjE0+zdD
         bjFoDdbvke1t9s9gAtv5i3tvfVFHgkdXoW0EVEUsNXVHHZfSW4o3XlVW/O0csiPJmkBO
         N5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728423676; x=1729028476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtG1s/PtEOi+3FxFvS7615HzvesaTB8jgjBY7bn8JsM=;
        b=XoMbo+CBW+EvqyODYpXNaA+f2ObMsDqLojVxkwowPbPvUZ2cRCGYOgispMj70qA3RX
         iau7bvaXGXaJvwuJKiUEvZMbYr7lKA5xyNn/WnaJZZXBCJI9swU0OXWBwXB01yC0OpRS
         bJquyXLCJiRcDQdbSgM7etqgLXEpSfZNqF/EuTOZuIV929RY2v/YjA/JHUwRHd3gEmIf
         4kFNovVOxwyVE6xq5jVBgUYPByqUtFQ+BBjCNG4FRrALk82v3QMIJmJHHnssUdfcn3/g
         A5PQFlmG0pwWnNJx77BDDz9qXuSBoTAiaEOxuct2vuU/GzksSZW+5VcVv1frpL3pSTr1
         OXXg==
X-Gm-Message-State: AOJu0YyILUFgkI4Wwn+DNNiGQF3af40ZiVKVdtbqGRDpXspstM8/kbNJ
	yW1FHldCfh+n5llTSppn777RGkYC7DAF/TLk1N8ik6Cg42Q36TEyDjIBY0s3BRK080ct1pHPlIA
	cr+pRDXpGP2FOQfFxF72kADa0XOwyHznv4ZqO
X-Google-Smtp-Source: AGHT+IEV/Plmx0t0njDF1LVjvlTAzH8zHwe1mwjLS4mIQb8oD5twjUCqRLi4b7Qf/bGD/DG2ZWHX33gXtUW9HZ+irko=
X-Received: by 2002:a05:600c:3d07:b0:42c:acba:2011 with SMTP id
 5b1f17b1804b1-430c3a9a3c8mr423835e9.1.1728423675306; Tue, 08 Oct 2024
 14:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20241008081350.8950-1-hanyang.tony@bytedance.com> <20241008081350.8950-2-hanyang.tony@bytedance.com>
In-Reply-To: <20241008081350.8950-2-hanyang.tony@bytedance.com>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 8 Oct 2024 14:41:04 -0700
Message-ID: <CAFySSZDjbWdYKRSdSkpd8XzxwOskZ-8tp0tZWxrYBgC6eCED4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] repack: pack everything into packfile
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org, jonathantanmy@google.com, sokcevic@google.com, 
	gitster@pobox.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:14=E2=80=AFAM Han Young <hanyang.tony@bytedance.co=
m> wrote:
>
> In a partial repository, creating a local commit and then fetching
> causes the following state to occur:
>
> commit  tree  blob
>  C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
>  |
>  C2 ---- T2 -- B2 (created locally, in non-promisor pack)
>  |
>  C1 ---- T1 -- B1 (fetched from remote, in promisor pack)
>
> During garbage collection, parents of promisor objects are marked as
> UNINTERESTING and are subsequently garbage collected. In this case, C2
> would be deleted and attempts to access that commit would result in "bad
> object" errors (originally reported here[1]).
>
> For partial repos, repacking is done in two steps. We first repack all th=
e
> objects in promisor packfile, then repack all the non-promisor objects.
> It turns out C2, T2 and B2 are not repacked in either steps, ended up del=
eted.
> We can avoid this by packing everything into a promisor packfile, if the =
repo
> is partial cloned.
>
> [1] https://lore.kernel.org/git/20240802073143.56731-1-hanyang.tony@byted=
ance.com/
>
> Helped-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Han Young <hanyang.tony@bytedance.com>
> ---
>  builtin/repack.c | 257 ++++++++++++++++++++++++++---------------------
>  1 file changed, 143 insertions(+), 114 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index cb4420f085..e9e18a31fe 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -321,6 +321,23 @@ static int write_oid(const struct object_id *oid,
>         return 0;
>  }
>
> +static int write_loose_oid(const struct object_id *oid,
> +                                const char *path UNUSED,
> +                                void *data)
> +{
> +       struct child_process *cmd =3D data;
> +
> +       if (cmd->in =3D=3D -1) {
> +               if (start_command(cmd))
> +                       die(_("could not start pack-objects to repack pro=
misor objects"));
> +       }
> +
> +       if (write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz)=
 < 0 ||
> +           write_in_full(cmd->in, "\n", 1) < 0)
> +               die(_("failed to feed promisor objects to pack-objects"))=
;
> +       return 0;
> +}
> +
>  static struct {
>         const char *name;
>         unsigned optional:1;
> @@ -370,12 +387,15 @@ static int has_pack_ext(const struct generated_pack=
_data *data,
>         BUG("unknown pack extension: '%s'", ext);
>  }
>
> -static void repack_promisor_objects(const struct pack_objects_args *args=
,
> -                                   struct string_list *names)
> +static int repack_promisor_objects(const struct pack_objects_args *args,
> +                                   struct string_list *names,
> +                                   struct string_list *list,
> +                                   int pack_all)
>  {
>         struct child_process cmd =3D CHILD_PROCESS_INIT;
>         FILE *out;
>         struct strbuf line =3D STRBUF_INIT;
> +       struct string_list_item *item;
>
>         prepare_pack_objects(&cmd, args, packtmp);
>         cmd.in =3D -1;
> @@ -387,13 +407,19 @@ static void repack_promisor_objects(const struct pa=
ck_objects_args *args,
>          * {type -> existing pack order} ordering when computing deltas i=
nstead
>          * of a {type -> size} ordering, which may produce better deltas.
>          */
> -       for_each_packed_object(write_oid, &cmd,
> -                              FOR_EACH_OBJECT_PROMISOR_ONLY);
> +       if (pack_all)
> +               for_each_packed_object(write_oid, &cmd, 0);
> +       else
> +               for_each_string_list_item(item, list) {
> +                       pack_mark_retained(item);
> +               }
> +
> +       for_each_loose_object(write_loose_oid, &cmd, 0);
>
>         if (cmd.in =3D=3D -1) {
>                 /* No packed objects; cmd was never started */
>                 child_process_clear(&cmd);
> -               return;
> +               return 0;
>         }
>
>         close(cmd.in);
> @@ -431,6 +457,7 @@ static void repack_promisor_objects(const struct pack=
_objects_args *args,
>         if (finish_command(&cmd))
>                 die(_("could not finish pack-objects to repack promisor o=
bjects"));
>         strbuf_release(&line);
> +       return 0;
>  }
>
>  struct pack_geometry {
> @@ -1312,8 +1339,7 @@ int cmd_repack(int argc,
>                 strvec_push(&cmd.args, "--reflog");
>                 strvec_push(&cmd.args, "--indexed-objects");
>         }
> -       if (repo_has_promisor_remote(the_repository))
> -               strvec_push(&cmd.args, "--exclude-promisor-objects");
> +
>         if (!write_midx) {
>                 if (write_bitmaps > 0)
>                         strvec_push(&cmd.args, "--write-bitmap-index");
> @@ -1323,125 +1349,128 @@ int cmd_repack(int argc,
>         if (use_delta_islands)
>                 strvec_push(&cmd.args, "--delta-islands");
>
> -       if (pack_everything & ALL_INTO_ONE) {
> -               repack_promisor_objects(&po_args, &names);
> -
> -               if (has_existing_non_kept_packs(&existing) &&
> -                   delete_redundant &&
> -                   !(pack_everything & PACK_CRUFT)) {
> -                       for_each_string_list_item(item, &names) {
> -                               strvec_pushf(&cmd.args, "--keep-pack=3D%s=
-%s.pack",
> -                                            packtmp_name, item->string);
> -                       }
> -                       if (unpack_unreachable) {
> -                               strvec_pushf(&cmd.args,
> -                                            "--unpack-unreachable=3D%s",
> -                                            unpack_unreachable);
> -                       } else if (pack_everything & LOOSEN_UNREACHABLE) =
{
> -                               strvec_push(&cmd.args,
> -                                           "--unpack-unreachable");
> -                       } else if (keep_unreachable) {
> -                               strvec_push(&cmd.args, "--keep-unreachabl=
e");
> -                               strvec_push(&cmd.args, "--pack-loose-unre=
achable");
> +       if (repo_has_promisor_remote(the_repository)) {
> +               ret =3D repack_promisor_objects(&po_args, &names,
> +                       &existing.non_kept_packs, pack_everything & ALL_I=
NTO_ONE);

Using a goto jump would be easier to both read your patch and
remove the need to indent this entire code block.
