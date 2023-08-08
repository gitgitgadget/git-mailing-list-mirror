Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A8C04E69
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 17:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbjHHRAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjHHQ7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 12:59:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC0655933
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:00:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317744867a6so4476983f8f.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510395; x=1692115195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zQjhacm5t03WLMXQs9SiC5Hcd1NR6LQRdzZbTxOnkw=;
        b=A49G96AizqAOs7TssT2L74b+Dt+CL44rpgYrPNUEwLRnoxoOpdoIutBFabr6tgMapt
         QeZSwGxRXwxtIojEdWLV8N4wt9eV6Qa+GBQJCxZQJxeoIgGraS2e95/HZ0Qyzgt1Tevm
         JwrKqHaXC9HwEO9Ki8L2VsnXlaGpMsXg3FyMLcLlEASm6U9gx05uOrhyboy5qeSxyMBZ
         HkR9E9lR7koPxZqePaYZGrftvpTyVrJr0TAtsI7YkkNokxn1o8lmsk9uQp/YarkgN04n
         pO1bFXcyUcAbkhha3sdj1o4GynCc6Iw0UWWiXyyN71Y2AbauoL/1+eHwZmNYzztMe+U3
         9c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510395; x=1692115195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zQjhacm5t03WLMXQs9SiC5Hcd1NR6LQRdzZbTxOnkw=;
        b=QBEdKqB/ZCGYI+srtv5N8gXX2vtdbVngA/XVFs+EWN7QRCyHinFiJQ0Tny9xdDD7AV
         sPdyXKaVwhkJPly7qIkY/Ueoko+CzbrjRPeRsg2OkugahHEQ5/ezi11v8zwA115KiPw+
         d7VdZhST83FNqBeIbmZev4MJvnf1D3vvkLrm6pbgUxBvO+Q1rnUVuhwe4kQJ6bj+VWqy
         XACvfEMQ6792+Z1zDez/9B+FbfdgcSkALhj1KeISz9mAxIDdRBU9o3rU6WiLfdrs9Spj
         +MeCd8LZQCMjGryrxlN4Jll44tKxt4gSdWNTNnwPG4PLRDNM8zuxKVcjKKWZcIKIh0fu
         12ag==
X-Gm-Message-State: AOJu0YxfNrF5K++LavKgoLPc0GnHZAGniKrueluvjv1ahJFXWLaqU09S
        O9ksFgPDSu9XZ/uYJzPvBvSgbpCaEzCSR0Nn1z9jFI9MPQM=
X-Google-Smtp-Source: AGHT+IE18CoV+TII+ssrNJsmhUJUZ396pUI13Tum66oftgwkoIqJvuBZGvIo8tOPDsAXgqjB2VYw2cnoBaEOnmRW7RA=
X-Received: by 2002:a05:6512:4894:b0:4f8:711b:18b0 with SMTP id
 eq20-20020a056512489400b004f8711b18b0mr6966963lfb.3.1691483677632; Tue, 08
 Aug 2023 01:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com> <20230724085909.3831831-6-christian.couder@gmail.com>
 <ZMBU+SALVQthOgC7@nand.local>
In-Reply-To: <ZMBU+SALVQthOgC7@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 8 Aug 2023 10:34:25 +0200
Message-ID: <CAP8UFD3BiZQ4-M91sc6p2wBFrzPQQfja_xKpT26BcBS7OVA4MA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] repack: add `--filter=<filter-spec>` option
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2023 at 1:04=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Mon, Jul 24, 2023 at 10:59:06AM +0200, Christian Couder wrote:

> > +     /*
> > +      * names has a confusing double use: it both provides the list
> > +      * of just-written new packs, and accepts the name of the
> > +      * filtered pack we are writing.
> > +      *
> > +      * By the time it is read here, it contains only the pack(s)
> > +      * that were just written, which is exactly the set of packs we
> > +      * want to consider kept.
> > +      */
>
> I think that this comment partially comes from the cruft pack code,
> where we use the `names` string list both to reference existing packs at
> the start of the repack, and to keep track of the pack we just wrote (to
> exclude its contents from the cruft pack).
>
> But I think we only write into "names" via finish_pack_objects_cmd() to
> record the name of the pack we just wrote containing objects which
> didn't meet the filter's conditions.
>
> So I think that leaving this comment in is OK, but TBH I was on the
> fence when I wrote that back in f9825d1cf75 (builtin/repack.c: support
> generating a cruft pack, 2022-05-20), so I would just as soon drop it.

I made the comment smaller in version 4.

> > +     in =3D xfdopen(cmd.in, "w");
> > +     for_each_string_list_item(item, names)
> > +             fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
> > +     for_each_string_list_item(item, existing_packs)
> > +             fprintf(in, "%s.pack\n", item->string);
>
> > +     for_each_string_list_item(item, existing_kept_packs)
> > +             fprintf(in, "^%s.pack\n", item->string);
>
> I think we may only want to do this if `honor_pack_keep` is zero.
> Otherwise we'd avoid packing objects that appear in kept packs, even if
> the caller told us to include objects found in kept packs.

In version 4 I have made changes to better support kept packfiles and
related options, including adding tests.

> > @@ -858,6 +912,8 @@ int cmd_repack(int argc, const char **argv, const c=
har *prefix)
> >                               N_("limits the maximum number of threads"=
)),
> >               OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_=
("bytes"),
> >                               N_("maximum size of each packfile")),
> > +             OPT_STRING(0, "filter", &po_args.filter, N_("args"),
> > +                             N_("object filtering")),
>
> I suppose we're storing the filter as a string here because we're just
> going to pass it down to pack-objects directly. That part makes sense,
> but I think we are producing subtly inconsistent behavior when
> specifying multiple --filter options.
>
> IIRC, passing --filter more than once down to pack-objects produces a
> filter whose objects match all of the individually specified
> sub-filters. But IIUC, using OPT_STRING here means that later
> `--filter`'s override earlier ones.
>
> So I think at minimum we'd want to store the filter arguments in a
> strvec. But I would probably just as soon parse them into a bona-fide
> list_objects_filter_options struct, and then reconstruct the arguments
> to pack-objects based on that.

In version 4 a `list_objects_filter_options` struct is now used, and
there is a test to check that more than one `--filter=3D<filter-spec>`
option is supported.

> > +     git -C bare.git -c repack.writebitmaps=3Dfalse repack -a -d --fil=
ter=3Dblob:none &&
> > +     test_stdout_line_count =3D 2 ls bare.git/objects/pack/*.pack &&
> > +     commit_pack=3D$(test-tool -C bare.git find-pack HEAD) &&
> > +     test -n "$commit_pack" &&
>
> I wonder if the test-tool itself should exit with a non-zero code if it
> can't find the given object in any pack. It would at least allow us to
> drop the "test -n $foo" after every invocation of the test-helper in
> this test.
>
> Arguably callers may want to ensure that an object doesn't exist in any
> pack, and this would be inconvenient for them, since they'd have to
> write something like:
>
>     test_must_fail test-tool find-pack $obj
>
> but I think a more direct test like
>
>     test_must_fail git cat-file -t $obj
>
> would do just as well.

Thanks for these suggestions, but I prefered to add the `--check-count
<n>` option to `test-tool find-pack` in version 4.

This way `--check-count 0` or `-c 0` for short can be used to check
that an object is in no packfile, though it could be for example in a
promisor remote or a loose object file. It's also nice to be able to
check that an object is in exactly 2 packfiles in some cases.

> > +     blob_pack=3D$(test-tool -C bare.git find-pack HEAD:file1) &&
> > +     test -n "$blob_pack" &&
> > +     test "$commit_pack" !=3D "$blob_pack" &&
> > +     tree_pack=3D$(test-tool -C bare.git find-pack HEAD^{tree}) &&
> > +     test "$tree_pack" =3D "$commit_pack" &&
> > +     blob_pack2=3D$(test-tool -C bare.git find-pack HEAD:file2) &&
> > +     test "$blob_pack2" =3D "$blob_pack"
> > +'
>
> This all looks good, but I think there are a couple of more things that
> we'd want to test for here:
>
>   - That the list of all objects appears the same before and after all
>     of the repacking. I think that this is tested implicitly already in
>     your test, but having it written down explicitly would harden this
>     against regressions that cause us to inadvertently delete an object
>     we shouldn't have.

I don't think we need to test this. `git pack-objects
--filter=3D<filter-spec>` already existed before this series and is
tested elsewhere. We can trust that command and its tests, and just
check that we used it correctly by checking that only a few objects
are in the right packfiles.

>     (FWIW, I think this would be limited to running something like "git
>     cat-file --batch-check=3D'%(objectname)' --batch-all-objects" before
>     and after all of the repacking, and ensuring that the two test_cmp
>     without failure).

I agree that it would not be difficult to do. I just think it's not necessa=
ry.

>   - Another thing that I don't think we're testing here is that objects
>     that *don't* match the filter don't appear in one of the filtered
>     packs.

In version 4 we do test that for some objects, as `test-tool find-pack
-c 1 $object` would error out if the object is in more than one
packfile.

> I think we'd probably want to assert on the exact contents of
>     the pack by dumping the list of objects into a file like "expect",
>     and then dumping the actual set of objects with "git show-index
>     <$idx | cut -d' ' -f2" or something.
>
> Another thought from the OPT_STRING business above is that we probably
> want to test this with non-trivial filter arguments. There are probably
> a handful of interesting cases here, like passing `--no-filter`, passing
> `--filter` multiple times, passing invalid values for `--filter`, etc.

In version 4 there is one test passing `--filter=3D...` multiple times.
I think this is enough, as the `list_objects_filter_options` struct
and related functions and mechanisms are tested elsewhere already.

> > +test_expect_success '--filter fails with --write-bitmap-index' '
> > +     test_must_fail git -C bare.git repack -a -d --write-bitmap-index =
\
> > +             --filter=3Dblob:none &&
>
> Do we want to ensure that we get the exit code corresponding with
> showing the usage text? I could go either way, but I do think that we
> should grep through the output on stderr to ensure that we get the
> appropriate error message.

I am not sure that testing the exit code and the stderr output is
always needed. Here I think that this test is more for documentation
purposes than really enforcing something important. In fact if the
behavior would change and `--write-bitmap-index` would understand that
it should write an MIDX instead of a regular index, that behavior
change could be considered in some ways as an improvement and we would
only need to remove 'test_must_fail' here.

> > +     git -C bare.git repack -a -d --no-write-bitmap-index \
> > +             --filter=3Dblob:none
>
> I don't think that this test is adding anything that the above
> "repacking with a filter works" test isn't covering already.

Ok, I have removed it in version 4.

Thanks!
