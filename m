Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8AFC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 18:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbhLJSs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 13:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbhLJSs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 13:48:58 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31BEC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 10:45:22 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o20so33167830eds.10
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 10:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VJ96rRhqvfmybyMvYEwgUSDTKdOx7wTYqlscXRQiUek=;
        b=HA6POyhN4sWqRU73lL3U/MtETNTUDg33qm/5qHUlXj2IrMHZBY5HbNBCarEmm+deKc
         4m7+QmMhjl51+bGaC9e3I5ent4zoi6GNK++fubIBQYtkyNUpz8izxB1GlHRf8e2nR/S7
         chlaWMNhhmiHck2lZrAhEiiSpfGPBB9TN+aurbuuPiK1JdPFTPkVeW3GdHei3ZR08gqU
         ZfjVOA3UVFTnRhS0tl6AncztQs/le/qeprJigO1Lqk42CCBJ498A1Xir4QXPIs//V48K
         kyy0Q/UsiULoaa/KUfYCBMq9aLQ2vgnOgnf1zdVB64xxB5HIe258l4AZ0ROSy4sy0DaR
         TnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VJ96rRhqvfmybyMvYEwgUSDTKdOx7wTYqlscXRQiUek=;
        b=pRti2PCRZDsMnA9kpjAoyzF1QZ1AHdQY5Y38SESesU6kCGNWWPEPIxLtg94Dp/6TKl
         epqTIVF7PeQspUt4EMSQA8lD+LsXmeam6q/SPdZyCboPp7Dch2aRrE4iKR0U4ZUjqqpA
         DoRKANPDwpLxQQGnA3FrPid3HikeVDB1SSpdC/iuDcqpLByzTlR59/aDZ0IG+q5O7aLR
         M+l3deF6z2vi/X2vhr7DpdKjlkS1gI3Cucf6nVd72pv/csLkLTI+Xv5LHsJx2b3iFMkB
         dk9sraEQfZKx/+4zzvsTUS9aN8JP2ZuFMwpnPL8jwsUO17mF/N4gR3fCLspEAjbNZGl8
         HNBQ==
X-Gm-Message-State: AOAM533roaje51Y9AE2uhL6lraXugseIOaFJ0sVMOaZu6Oo0Fg6Ngqo2
        ExpEC4496Qspf/oE23bxI3bPzJF89WRTKWWzAf4=
X-Google-Smtp-Source: ABdhPJxkKfZ/aeJA7jextPBhSvvqJZVcbQMm0gUy0CAglVSKIzC8FQB2sz8isLJ4Efzfut3FJxeTLa1Ypks/H4nNmmk=
X-Received: by 2002:a50:c38c:: with SMTP id h12mr41987783edf.72.1639161921359;
 Fri, 10 Dec 2021 10:45:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
 <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com> <211210.86v8zwbev9.gmgdl@evledraar.gmail.com>
In-Reply-To: <211210.86v8zwbev9.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Dec 2021 10:45:10 -0800
Message-ID: <CABPp-BHLRUQmjEoO_eEvZWTrVFK_xdMoQH5Q9DAj7y=JrKDzig@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Sparse index: fetch, pull, ls-files
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 8:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Dec 10 2021, Derrick Stolee via GitGitGadget wrote:
>
> > Updates in v3
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  * Fixed typo in commit message.
> >  * Added comments around doing strange things in an ls-files test.
> >  * Fixed adjacent typo in a test comment.
>
> Yay, I'm happy to see 5/5. Not because I didn't like the helper, but
> that sparse is getting mature enough that we're getting ls-files to emit
> information about it. Thanks.
>
> There's the small "diff -u" portability issue noted in my just-sent
> <211210.86zgp8bi48.gmgdl@evledraar.gmail.com>.

Yeah, that one is an important point.

> Other than that 2/5 adds this documentation about ls-files --sparse:
>
>         If the index is sparse, show the sparse directories without expan=
ding
>         to the contained files.
>
> Shouldn't we at least add:
>
>         Sparse directories will be shown with a trailing slash,
>         e.g. "x/" for a sparse directory "x".q

Makes sense.  Except I don't understand the trailing 'q' -- typo?

>
> In addition to that I think this may have a buggy/unexpected interaction
> with the --eol option:
>
>     040000 aaff74984cccd156a469afa7d9ab10e4777beb24 0       i/      w/   =
   attr/                   x/
>
> I.e. should we be saying anything about the EOL state of these? OTOHO I
> tried adding a submodule and it says the same, which seems similarly
> odd, so maybe it's either correct, or this isn't updated for those
> either.

If it matches what we do for submodules, for which eol values are also
non-sensical, then I think we're good enough for this series.  Perhaps
we just shouldn't print anything eol related for directories with
--eol, but that sounds like an orthogonal series rather than something
that should go in this one.

> Is the behavior of:
>
>     $ git -C sparse-index ls-files --stage --sparse -- 'folder2/a'
>     $ echo $?
>     0
>
> Expected? I.e. accepting /a when we'd just print "folder2/" and not
> e.g. erroring (probably, just asking)?

Fair question.  I think it's fine; by way of comparison:

$ git rm --cached removed-and-no-longer-tracked-file
$ git ls-files --stage -- non-existent-file
removed-and-no-longer-tracked-file untracked-file
$ echo $?
0

So it also shows nothing and displays nothing when asked for file(s)
that are not in the index.

Yes, there is a slight semantic difference in that in your example we
have a "folder2/" entry which *could be* expanded, but I am quite
happy with the literal interpretation of the command that there is no
"folder2/a" in the index.  Said another way, I'm happy with ls-files
showing what is in the index right now, rather than what could be in
it, or listing things that HEAD contains that we don't for whatever
reason.

> How about:
>
>     $ ls -l sparse-index/x
>     ls: cannot access 'sparse-index/x': No such file or directory
>     $ git -C sparse-index ls-files --stage 'x/*'
>     100644 78981922613b2afb6025042ff6bd878ac1994e85 0       x/a
>     $ git -C sparse-index ls-files --stage --no-empty-directory 'x/*'
>     100644 78981922613b2afb6025042ff6bd878ac1994e85 0       x/a
>     $ git -C sparse-index ls-files --stage --no-empty-directory --sparse =
'x/*'
>     040000 aaff74984cccd156a469afa7d9ab10e4777beb24 0       x/
>
> The answer is probably "yes that's fine" because I've got no idea how
> sparse really works, but just checking..

You should read the docs for this option you are trying: "Do not list
empty directories. Has no effect without --directory."    (Also,
--directory only takes effect with --other, which you are also
missing.)

So yeah, that flag is irrelevant.  Perhaps ls-files should print a
warning when flags are passed but ignored due to other flags not being
passed, but that would belong in an orthogonal series rather than this
one.

> So it's very nice to have the new diff test in 2/5, but would be much
> nicer/assuring to have that split into a trivial function followed by
> seeing how the diff looked in combination with each of the other option
> that "ls-files" accepts.

There's no point testing in combination with flags that only affect
untracked files.  And I'm very dubious of adding testing for a case
where we would need to add an explicit disclaimer that "We have no
idea what the output should be but we are testing it anyway".  So the
options you suggest at least are things I'd rather not see us trying
to add to the testing here.
