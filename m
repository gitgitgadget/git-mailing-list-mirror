Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8031DA11B
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394076; cv=none; b=hWy0/QRKupBEt/dXXa5Eq6nyn/IZSmM0p/4bTtthbNj0zH2/KeXtbpQ+0O3w6ZFDMeJ/0L+RzENrAw2buuI9/JSFr6IK+ZN9cufYgx7ZSVV5QpnL3fR3bcGF2Pxe9CaH6NbNJekBgEsCDNtXYppQcSNcfNc8WI8qZFUqePqozzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394076; c=relaxed/simple;
	bh=KXWQD6uPtYR5RjxTkDUAh/lv3Vs9ajWWgK/RWtN1Jng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUbnQZHCBLCAnc264BpbRR/oLaddKUDyeRPGZB85nvT8vk6OTIr8ar+P+c5aBgHHbFD0qLBrQuh49gb/R/vuDu/GobKydn3XykViS9tLbD2G7OTMOCgJ2ilHPuaZCdr362QqFoUYPFaFgWStCezCmGswhpPLAk6sNLhc6k0RXXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZmJ282t; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZmJ282t"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85e15dc8035so16364239f.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742394073; x=1742998873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8486DTfCbEPpTucFiGsvk/FDu2IlHki78+HAM0SsYo=;
        b=CZmJ282tn6tKj9Ys5RSliM0tLRohOHIioFwcs0fqdK654vsycvciIw3peF8TvWZrXh
         L7jBkXIZaMq/ddez34dgEJzNnPjPCvchYBYNVyOKbjhbJquv7F8PNuXN9ts5niFyc4AM
         G1nh+olThv0QLXK0TrpCH8hvJyp4wHaSgHBpIIf/SJtDaAVPUmM2t6+lb/KEK2keWfU+
         tRTKdPszLaW4gArYWBHh1zLi5cs77/6bGIYuL8Dv4gJu2XdPs+qL75uOY9AB+jFsqaIo
         4tRhxO7C+Qpth47pQ0ylyZFsDoIf5JEQ7qHF1qcDfR1feUOONYeW7FNZbfjRoqRrkGtH
         d1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742394073; x=1742998873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8486DTfCbEPpTucFiGsvk/FDu2IlHki78+HAM0SsYo=;
        b=fDfoLPnUMJCPDV7gbtCQixmY7moHSBVA21UDX7PYRmS0C4Uu8v67VCpKUd2HuECqgB
         DSLUsjLrO/usW89HPMvVDw1e+BwTDyZtxJIF0HoG2p+l3qoFQHLoRlkCirXmKNaLwXDQ
         jNhqvLkONJ0nD/NDyZG9wTgehSbrf7Mn8CATPBH5HGzy8ygR7h1ztYmZwFjKPnmnKayJ
         FMP5bofrovbEIZWJMYAQqD2rpygCnG1H7XipRtT47wPuYr1ptts65gArtjI6Gx99Lzrx
         +irBN9mF8kwup8/DyVPtPNVNLhJOI1xsIvCIaym4Mbg28q3ZYHS5Ig8jysf3zKABLFG7
         iv0g==
X-Gm-Message-State: AOJu0YzrD2HTw0V7xIWtYBW6rq94nPsVZ8BWNtOzEdy+lzfTYdpsolOr
	AxUKCitpNcukX+fan0BIERudrd35DswViahwjL0YMM5BlL4Jp6h0V3XUTUdk0olrKfzswccilLP
	FWOjahUR9BBY1zWBcWxwppgqc7SU=
X-Gm-Gg: ASbGncvU9q27YIEfubKy3f8pFsb4jkHqXAhpOZGGx+PNJe3gKGm9Fy/opgY/ZUnGJXc
	Em1yZ2rUQDQN0PbbdvXEaCrOmYC5GlPZ4fJ5DV2tFjDw6m3iWGOekgiTmcSUgUQr7pyjkICDiKN
	0/OFCtGtEqDeUVTcy5NLwhxUpSNfMP
X-Google-Smtp-Source: AGHT+IEOaYaAWJs3GVlarOlUEL5H+LbmIUKumr3ufkL/i9SHRmklb4QVtZ8gUXvQHfILXyfTY08WcdG1gG8bSsVniQc=
X-Received: by 2002:a5d:928f:0:b0:85e:181e:1bd3 with SMTP id
 ca18e2360f4ac-85e181e1d5cmr143525439f.1.1742394073125; Wed, 19 Mar 2025
 07:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742252411.git.me@ttaylorr.com> <7f120c35e95dcf41282c87dc2d1b2640ecdc5d84.1742252411.git.me@ttaylorr.com>
In-Reply-To: <7f120c35e95dcf41282c87dc2d1b2640ecdc5d84.1742252411.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Mar 2025 07:21:01 -0700
X-Gm-Features: AQ5f1JpayOIFpP9JNB9JKmuzJLVkL6r-akoSB6shVOvT30bLsxsCe7lNYVoTwbY
Message-ID: <CABPp-BFhZ1JGR_qWSgmcZm=Pix2n6z1AQ+-R-mw9Q_fWFi=_Ew@mail.gmail.com>
Subject: Re: [PATCH 5/5] repack: begin combining cruft packs with `--combine-cruft-below-size`
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 4:00=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> The previous commit changed the behavior of repack's '--max-cruft-size'
> to specify a cruft pack-specific override for '--max-pack-size'.
>
> Introduce a new flag, '--combine-cruft-below-size' which is a
> replacement for the old behavior of '--max-cruft-size'. This new flag
> does explicitly what it says: it combines together cruft packs which are
> smaller than a given threshold, and prohibits repacking ones which are
> larger.

To me "prohibits" suggests some kind of stronger action that
potentially persists beyond the end of this operation. Perhaps this
could be reworded to something like
s/prohibits repacking ones/leaves alone packs/ ?

> This accomplishes the original intent of '--max-cruft-size', which was
> to avoid repacking cruft packs larger than the given threshold.
>
> The new behavior is slightly different. Instead of building up small
> packs together until the threshold is met, '--combine-cruft-below-size'
> packs up *all* cruft packs smaller than the threshold. This means that
> we may make a pack much larger than the given threshold (e.g., if you
> aggregate 5 packs which are each 99 MiB in size with a threshold of 100
> MiB).
>
> But that's OK: the point isn't to restrict the size of the cruft packs
> we generate, it's to avoid working with ones that have already grown too
> large. If repositories still want to limit the size of the generated
> cruft pack(s), they may use '--max-cruft-size' instead.

...but then they wouldn't get any cruft packs being combined.  Did you
mean s/instead/together with --combine-cruft-below-size/ ?

> There's some minor test fallout as a result of the slight differences in
> behavior between the old meaning of '--max-cruft-size' and the behavior
> of '--combine-cruft-below-size'. In the test which is now called
> "--combine-cruft-below-size combines packs", we need to use the new flag
> over the old one to exercise that test's intended behavior. The
> remainder of the changes there are to improve the clarity of the
> comments.
>
> Suggested-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-repack.adoc |  8 ++++++++
>  builtin/repack.c              | 38 +++++++++++++++++++++++------------
>  t/t7704-repack-cruft.sh       | 22 +++++++++++---------
>  3 files changed, 46 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.ado=
c
> index 11db43b1c5..8e6d61aa2f 100644
> --- a/Documentation/git-repack.adoc
> +++ b/Documentation/git-repack.adoc
> @@ -81,6 +81,14 @@ to the new separate pack will be written.
>         `--max-pack-size` (if any) by default. See the documentation for
>         `--max-pack-size` for more details.
>
> +--combine-cruft-below-size=3D<n>::
> +       When generating cruft packs without pruning, only repack
> +       existing cruft packs whose size is strictly less than `<n>`.
> +       Cruft packs whose size is greater than or equal to `<n>` are
> +       left as-is and not repacked. Useful when you want to avoid
> +       repacking large cruft pack(s) in repositories that have many
> +       and/or large unreachable objects.
> +

Does it make sense to modify the documentation for either the
--max-cruft-szie or --combine-cruft-below-size options to suggest that
if both are used, it is recommended to make --max-cruft-size twice (or
more) the value of --combine-cruft-below-size ?

>  --expire-to=3D<dir>::
>         Write a cruft pack containing pruned objects (if any) to the
>         directory `<dir>`. This option is useful for keeping a copy of
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 9658f6b354..f3330ade7b 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1022,20 +1022,13 @@ static int write_filtered_pack(const struct pack_=
objects_args *args,
>         return finish_pack_objects_cmd(&cmd, names, local);
>  }
>
> -static void collapse_small_cruft_packs(FILE *in, size_t max_size UNUSED,
> -                                      struct existing_packs *existing)
> +static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_bel=
ow_size,
> +                                     struct existing_packs *existing)
>  {
>         struct packed_git *p;
>         struct strbuf buf =3D STRBUF_INIT;
>         size_t i;
>
> -       /*
> -        * Squelch a -Wunused-function warning while we rationalize
> -        * the behavior of --max-cruft-size. This function will become
> -        * used again in a future commit.
> -        */
> -       (void)retain_cruft_pack;
> -
>         for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
>                 if (!(p->is_cruft && p->pack_local))
>                         continue;
> @@ -1047,7 +1040,12 @@ static void collapse_small_cruft_packs(FILE *in, s=
ize_t max_size UNUSED,
>                 if (!string_list_has_string(&existing->cruft_packs, buf.b=
uf))
>                         continue;
>
> -               fprintf(in, "-%s.pack\n", buf.buf);
> +               if (p->pack_size < combine_cruft_below_size) {
> +                       fprintf(in, "-%s\n", pack_basename(p));
> +               } else {
> +                       retain_cruft_pack(existing, p);
> +                       fprintf(in, "%s\n", pack_basename(p));
> +               }
>         }
>
>         for (i =3D 0; i < existing->non_kept_packs.nr; i++)
> @@ -1061,6 +1059,7 @@ static int write_cruft_pack(const struct pack_objec=
ts_args *args,
>                             const char *destination,
>                             const char *pack_prefix,
>                             const char *cruft_expiration,
> +                           unsigned long combine_cruft_below_size,
>                             struct string_list *names,
>                             struct existing_packs *existing)
>  {
> @@ -1103,8 +1102,9 @@ static int write_cruft_pack(const struct pack_objec=
ts_args *args,
>         in =3D xfdopen(cmd.in, "w");
>         for_each_string_list_item(item, names)
>                 fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
> -       if (args->max_pack_size && !cruft_expiration) {
> -               collapse_small_cruft_packs(in, args->max_pack_size, exist=
ing);
> +       if (combine_cruft_below_size && !cruft_expiration) {
> +               combine_small_cruft_packs(in, combine_cruft_below_size,
> +                                         existing);
>         } else {
>                 for_each_string_list_item(item, &existing->non_kept_packs=
)
>                         fprintf(in, "-%s.pack\n", item->string);
> @@ -1158,6 +1158,7 @@ int cmd_repack(int argc,
>         const char *opt_window_memory =3D NULL;
>         const char *opt_depth =3D NULL;
>         const char *opt_threads =3D NULL;
> +       unsigned long combine_cruft_below_size =3D 0ul;
>
>         struct option builtin_repack_options[] =3D {
>                 OPT_BIT('a', NULL, &pack_everything,
> @@ -1170,6 +1171,9 @@ int cmd_repack(int argc,
>                                    PACK_CRUFT),
>                 OPT_STRING(0, "cruft-expiration", &cruft_expiration, N_("=
approxidate"),
>                                 N_("with --cruft, expire objects older th=
an this")),
> +               OPT_MAGNITUDE(0, "combine-cruft-below-size",
> +                             &combine_cruft_below_size,
> +                             N_("with --cruft, only repack cruft packs s=
maller than this")),
>                 OPT_MAGNITUDE(0, "max-cruft-size", &cruft_po_args.max_pac=
k_size,
>                                 N_("with --cruft, limit the size of new c=
ruft packs")),
>                 OPT_BOOL('d', NULL, &delete_redundant,
> @@ -1413,7 +1417,8 @@ int cmd_repack(int argc,
>                 cruft_po_args.quiet =3D po_args.quiet;
>
>                 ret =3D write_cruft_pack(&cruft_po_args, packtmp, pack_pr=
efix,
> -                                      cruft_expiration, &names,
> +                                      cruft_expiration,
> +                                      combine_cruft_below_size, &names,
>                                        &existing);
>                 if (ret)
>                         goto cleanup;
> @@ -1440,10 +1445,17 @@ int cmd_repack(int argc,
>                          * generate an empty pack (since every object not=
 in the
>                          * cruft pack generated above will have an mtime =
older
>                          * than the expiration).
> +                        *
> +                        * Pretend we don't have a `--combine-cruft-below=
-size`
> +                        * argument, since we're not selectively combinin=
g
> +                        * anything based on size to generate the limbo c=
ruft
> +                        * pack, but rather removing all cruft packs from=
 the
> +                        * main repository regardless of size.
>                          */
>                         ret =3D write_cruft_pack(&cruft_po_args, expire_t=
o,
>                                                pack_prefix,
>                                                NULL,
> +                                              0ul,
>                                                &names,
>                                                &existing);
>                         if (ret)
> diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
> index 6debad368d..8aebfb45f5 100755
> --- a/t/t7704-repack-cruft.sh
> +++ b/t/t7704-repack-cruft.sh
> @@ -194,10 +194,13 @@ test_expect_success '--max-cruft-size combines exis=
ting packs when not too large
>         )
>  '
>
> -test_expect_failure '--max-cruft-size combines smaller packs first' '
> -       git init max-cruft-size-consume-small &&
> +test_expect_success '--combine-cruft-below-size combines packs' '
> +       repo=3Dcombine-cruft-below-size &&
> +       test_when_finished "rm -fr $repo" &&
> +
> +       git init "$repo" &&
>         (
> -               cd max-cruft-size-consume-small &&
> +               cd "$repo" &&
>
>                 test_commit base &&
>                 git repack -ad &&
> @@ -211,11 +214,11 @@ test_expect_failure '--max-cruft-size combines smal=
ler packs first' '
>                 test-tool pack-mtimes "$(basename $cruft_bar)" >>expect.r=
aw &&
>                 sort expect.raw >expect.objects &&
>
> -               # repacking with `--max-cruft-size=3D2M` should combine
> -               # both 0.5 MiB packs together, instead of, say, one of
> -               # the 0.5 MiB packs with the 1.0 MiB pack
> +               # Repacking with `--combine-cruft-below-size=3D1M`
> +               # should combine both 0.5 MiB packs together, but
> +               # ignore the two packs which are >=3D 1.0 MiB.
>                 ls $packdir/pack-*.mtimes | sort >cruft.before &&
> -               git repack -d --cruft --max-cruft-size=3D2M &&
> +               git repack -d --cruft --combine-cruft-below-size=3D1M &&
>                 ls $packdir/pack-*.mtimes | sort >cruft.after &&
>
>                 comm -13 cruft.before cruft.after >cruft.new &&
> @@ -224,11 +227,12 @@ test_expect_failure '--max-cruft-size combines smal=
ler packs first' '
>                 test_line_count =3D 1 cruft.new &&
>                 test_line_count =3D 2 cruft.removed &&
>
> -               # the two smaller packs should be rolled up first
> +               # The two packs smaller than 1.0MiB should be repacked
> +               # together.
>                 printf "%s\n" $cruft_foo $cruft_bar | sort >expect.remove=
d &&
>                 test_cmp expect.removed cruft.removed &&
>
> -               # ...and contain the set of objects rolled up
> +               # ...and contain the set of objects rolled up.
>                 test-tool pack-mtimes "$(basename $(cat cruft.new))" >act=
ual.raw &&
>                 sort actual.raw >actual.objects &&
>
> --
> 2.49.0.rc0.6.g7f120c35e9

The rest looks good to me (although I reviewed a preview and you
addressed that feedback, so perhaps not so surprising...)
