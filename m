Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04245C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 11:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjALLC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjALLBY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 06:01:24 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB6150E54
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:53:53 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-14455716674so18494244fac.7
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 02:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw6NlxRRZj3ZgVDqIbPWsRSEPIKskWbUiSDVB122Aec=;
        b=AE+Iblex25jeMJK0br4OGZZC5M74pJiyX8DTS2ZqDFBNC30nAClBGQzXy6mtTEfzd3
         XecrekB0ufkogz1xqx6kz2H5pEyzYhyNqJA6Xd5VZikO2lLU+SDFyi/qh4G3DruRieLh
         a4uchj+ucOk3+EFlbv4/OzR5GW/F1w/F0SXQBQAZbm3E8HoejaQmqSYs7Ldg66gHIvTi
         O5DToGVG3dimVEog4pB9pYIuWwBYhM3JKRwuEWG6WJ4k2ZS8iXaqMihpQubeXnr9cjfC
         rO9Mbxg8RP0uhDe0RLI+vRPR95ZHxM/lZ9X7UIyKxZvB9lvdXfIcrRTdiESOwVeCWHiu
         Y4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tw6NlxRRZj3ZgVDqIbPWsRSEPIKskWbUiSDVB122Aec=;
        b=G5MHKUF9gH1mftAjQ+NF5kjDNTkp+2D5mIoFrssBvsUrx6URfEQIeAH6/vroP+ZUhd
         ZEheWBSgSmmvJuc3pVrZ8sbtegedTDO12KdEVL+c06WCj262n9J8f0rvo+/8KA26/L83
         gMalk3i3v4GoeP3w+Qwbx6tOaGSP8+bjL7rdxvaX9ec5d/+o36svbWWEagBLclw1Wd9K
         ht3mVEN+Px7BZEz4eJlxTsarmlbOPmKuKNfBYLZ9u3mwnmlwDh3J+ZJAY65qk2Vxe65v
         BWaXYNHGFulCut/kme9tyYItEvEGnShQC/SRPf2H+0RMBYxxIUDI41ndv7AZou5pDe/h
         v8Zg==
X-Gm-Message-State: AFqh2kqf9Hs4Pf5igemhCOPY88UEsAnCRnJov8vPMpi3Myf5/0/Z1pKI
        tcbujkGWaKUzQHt32KXhw/GiWjScD20/eUReZnpXh/FT
X-Google-Smtp-Source: AMrXdXvZn0axvuRmPeTvEGzy/hVT0sD9IsaUwKHhuT0cuHnDUi0zXEy/QL3kizHMSTHi6jQRudrvL/AkEdvz/TfksA4=
X-Received: by 2002:a05:6870:ad0a:b0:15b:5577:8428 with SMTP id
 nt10-20020a056870ad0a00b0015b55778428mr1092747oab.232.1673520832476; Thu, 12
 Jan 2023 02:53:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671793109.git.karthik.188@gmail.com> <23813496fc73b7e5cb9f09b166e05c9a02bac43c.1671793109.git.karthik.188@gmail.com>
 <4fc57003-3f29-2f1c-fe18-94b5f9f1bf2b@dunelm.org.uk>
In-Reply-To: <4fc57003-3f29-2f1c-fe18-94b5f9f1bf2b@dunelm.org.uk>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Thu, 12 Jan 2023 11:53:25 +0100
Message-ID: <CAOLa=ZREB8dSALk96DgHqQnLvyXZieA-k33b30miypB8SemavQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] attr: add flag `--source` to work with tree-ish
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 12:30 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Karthik
>

Hello Philip!

> On 02/01/2023 11:04, Karthik Nayak wrote:
> > The contents of the .gitattributes files may evolve over time, but "git
> > check-attr" always checks attributes against them in the working tree
> > and/or in the index. It may be beneficial to optionally allow the users
> > to check attributes taken from a commit other than HEAD against paths.
> >
> > Add a new flag `--source` which will allow users to check the
> > attributes against a commit (actually any tree-ish would do). When the
> > user uses this flag, we go through the stack of .gitattributes files but
> > instead of checking the current working tree and/or in the index, we
> > check the blobs from the provided tree-ish object. This allows the
> > command to also be used in bare repositories.
> >
> > Since we use a tree-ish object, the user can pass "--source
> > HEAD:subdirectory" and all the attributes will be looked up as if
> > subdirectory was the root directory of the repository.
>
> I think changing to --source is a good idea. I've left a few comments
> below - the tests are broken at the moment. I didn't look very closely
> at the implementation beyond scanning the range-diff as it looks like
> there are not any significant changes there.
>

Thanks for the review!

> > We cannot simply use the `<rev>:<path>` syntax without the `--source`
> > flag, similar to how it is used in `git show` because any non-flag
> > parameter before `--` is treated as an attribute and any parameter after
> > `--` is treated as a pathname.
> >
> > The change involves creating a new function `read_attr_from_blob`, which
> > given the path reads the blob for the path against the provided source and
> > parses the attributes line by line. This function is plugged into
> > `read_attr()` function wherein we go through the stack of attributes
> > files.
> >
> > Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: Toon Claes <toon@iotcl.com>
> > Co-authored-by: toon@iotcl.com
> > ---
> > -'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
> > -'git check-attr' --stdin [-z] [-a | --all | <attr>...]
> > +'git check-attr' [--source <tree>] [-a | --all | <attr>...] [--] <pathname>...
> > +'git check-attr' --stdin [-z] [--source <tree>] [-a | --all | <attr>...]
>
> I think "<tree>" would be better as "<tree-ish>" (see my comments on the
> --source option implementation below)

Will change!

> >
> >   DESCRIPTION
> >   -----------
> > @@ -36,6 +36,12 @@ OPTIONS
> >       If `--stdin` is also given, input paths are separated
> >       with a NUL character instead of a linefeed character.
> >
> > +--source=<tree>::
> > +     Check attributes against the specified tree-ish. Paths provided as part
> > +     of the revision will be treated as the root directory. It is common to
> > +     specify the source tree by naming a commit, branch or tag associated
> > +     with it.
>
> I think it is confusing to keep the reference to "revision" here, we
> could just drop that sentence.
>

Will do!

> > -N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
> > -N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
> > +N_("git check-attr [--source <tree>] [-a | --all | <attr>...] [--] <pathname>..."),
> > +N_("git check-attr --stdin [-z] [--source <tree>] [-a | --all | <attr>...]"),
>
> I think we should use "<tree-ish>" rather than "<tree>" so it is clear
> one can specify a commit or tag. That's what "git restore" does.
>

Yeah sure!

> > diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> > index b3aabb8aa3..78e9f47dbf 100755
> > --- a/t/t0003-attributes.sh
> > +++ b/t/t0003-attributes.sh
> > @@ -25,7 +25,15 @@ attr_check_quote () {
> >       git check-attr test -- "$path" >actual &&
> >       echo "\"$quoted_path\": test: $expect" >expect &&
> >       test_cmp expect actual
> > +}
> > +
> > +attr_check_source () {
> > +     path="$1" expect="$2" source="$3" git_opts="$4" &&
> >
> > +     git $git_opts check-attr --source $source test -- "$path" >actual 2>err &&
> > +     echo "$path: test: $expect" >expect &&
> > +     test_cmp expect actual
>
> This is missing && which means we miss some test failures later
>

Good catch on this!

> > +     test_must_be_empty err
> >   }
> >
>
> > +test_expect_success 'setup branches' '
> > +     mkdir -p foo/bar &&
> > +     test_commit --printf "add .gitattributes" foo/bar/.gitattribute \
>
> The file should be foo/bar/.gitattributes (not .gitattribute). We're
> missing failures due to this because of the missing && above
>

Yup, this fixes the test. Thanks!

> > +             "f test=f\na/i test=n\n" tag-1 &&
> > +
> > +     mkdir -p foo/bar &&
>
> We don't need to make the directory again here
>
> > +     test_commit --printf "add .gitattributes" foo/bar/.gitattribute \
> > +             "g test=g\na/i test=m\n" tag-2
>
> I think it would be worth either removing foo/bar/.gitattributes or
> donig test_write_lines to change it. That way we can be sure all the
> --source tests are actually using the tree-ish we give it and not just
> reading from the filesystem.
>

Will do a `rm` on the file.
