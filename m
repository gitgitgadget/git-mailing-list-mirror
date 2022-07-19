Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF2C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 16:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiGSQT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiGSQTt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 12:19:49 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131BC50042
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 09:19:48 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p81so12246733iod.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lbFg13oJYiV0QAeGQLO13KyuFJfLbcHKvdc+jYwb0TA=;
        b=fpjdG/BArUU2mfSaTvt/qVdVhYHxykvqbRfwkOb5s4E+/ywRfjFrFROh1SHNMExU5r
         jKHjLO6MLHAqHzNxKUXZ5jXr/jw7TXu+Hn658SU4YxSNNLIz+ocw3yOwciIPcysyJGTK
         qtv8V0RApRg1P7qrXIOvF4p7Ab6rC8Er2LjqYdObogM4NWye7rvWSGyRLx2DUXtDET5X
         p2GDpjsXcJnNxPCfRRm/+C2gsMi/xp5kpxBJJwnX17r3vJriySBdsQ7xC6Cic698Rncc
         mrm+b9+AyywlCzY8Zq8bUtuQ/r6BlzCCUYTSaOcnrCVafY6Z/oXpq4Flpy2ibhMN48Bb
         QKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lbFg13oJYiV0QAeGQLO13KyuFJfLbcHKvdc+jYwb0TA=;
        b=1kE/INg0Q6iHmrpahJN9HLykJKpS2X+ISww1Yi7AWdgpt1vpoqwo9zkaF14Xz+tmW4
         d+grqHzsJyPJMLVYPrgW+5SDXdxgmCagYEv2xLBLL4sG6pDcEgNfzv3+LnQVGOB1+c0Y
         S7nDDDBRbQ0EvZELNVY7WDWowUC2bswaKOnIDX028QBVH82NUMSesikr5uyCuPGMg+4r
         pDscobD95aXtRHcGAUelBrtl6OwcFVirj7XNWDY7FqT8C9cYXmtrNpyBuM6DW3a5NuLj
         F8vCIzejaqq9WQASsNjDZlvdqhtYAgvePlrMcdoODJdRl5/Z5MXnEeHoNib935GBndCs
         6qFg==
X-Gm-Message-State: AJIora+VKdWVkjh7yp7HRXBMtuU98v63Gj6zuWkj0DXkGbLg1Yn7RxBA
        QFLlUI8W9s6IIIP4rScvKuK5Gx94RCGn1Ulyarz34zpXSbeotg==
X-Google-Smtp-Source: AGRyM1s15Kfj+75OCEAcyPsB5lfy/jPfcH3S7sB+BTCW+UiIm6EdeSAUWYSHWOpDngmK2CNr+ZcfShlBtdAKQKL+USs=
X-Received: by 2002:a6b:f302:0:b0:67b:e1c3:7cb5 with SMTP id
 m2-20020a6bf302000000b0067be1c37cb5mr9830244ioh.206.1658247587394; Tue, 19
 Jul 2022 09:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v6.git.1657558435532.gitgitgadget@gmail.com>
 <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com> <220718.86pmi2ygbt.gmgdl@evledraar.gmail.com>
In-Reply-To: <220718.86pmi2ygbt.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 20 Jul 2022 00:19:36 +0800
Message-ID: <CAOLTT8R_=hmwDab1Tq+qy1vXUZ4C1z6+9xTyR8WSzQ=JOBnhjg@mail.gmail.com>
Subject: Re: [PATCH v7] ls-files: introduce "--format" option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B47=E6=9C=8818=E6=97=A5=E5=91=A8=E4=B8=80 16:29=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> On Wed, Jul 13 2022, ZheNing Hu via GitGitGadget wrote:
>
> > +test_expect_success 'setup' '
> > +     printf "LINEONE\nLINETWO\nLINETHREE\n" >o1.txt &&
> > +     printf "LINEONE\r\nLINETWO\r\nLINETHREE\r\n" >o2.txt &&
> > +     printf "LINEONE\r\nLINETWO\nLINETHREE\n" >o3.txt &&
>
> If you want to do this sort of thing in general this pattern is better:
>
>         x=3D"a b c" &&
>         printf "%s\n" $x
>         printf "%s\r\n" $x
>

Let see what's these cmd output:

x=3D"a b c" &&
printf "%s\n" $x &&
printf "%s\r\n" $x

a b c
a b c

I guess what we expect is:

a
b
c
a
b
c

test_write_lines() can do this:

test_write_lines a b c
test_write_lines a b c

yeah, maybe printf do this too:

# x=3D"a b c" we don't use a variable
printf "%s\n" a b c &&
printf "%s\r\n" a b c

> I.e. you can use printf's auto-repeating, or test_write_lines[1]. But in
> this case I tried:
>
>         diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format=
.sh
>         index e62bce70f3b..e4c3a788acb 100755
>         --- a/t/t3013-ls-files-format.sh
>         +++ b/t/t3013-ls-files-format.sh
>         @@ -13,9 +13,11 @@ do
>          done
>
>          test_expect_success 'setup' '
>         -       printf "LINEONE\nLINETWO\nLINETHREE\n" >o1.txt &&
>         -       printf "LINEONE\r\nLINETWO\r\nLINETHREE\r\n" >o2.txt &&
>         -       printf "LINEONE\r\nLINETWO\nLINETHREE\n" >o3.txt &&
>         +       lines=3D"LO LINETWO LINETHREE" &&
>         +       test_write_lines $lines >o1.txt &&
>         +       # Even this passes!
>         +       #>o1.txt &&
>         +
>                 ln -s o3.txt o4.txt &&
>                 git add "*.txt" &&
>                 git add --chmod +x o1.txt &&
>
> I.e. all tests pass if we don't write o2.txt and o3.txt, and continue to
> pass if you uncomment that and make o1.txt an empty file.
>
> So is this some incomplete test setup code that was never used & we
> could drop?

No, o2.txt, o3.txt just for test some file with different
eolinfo/eolattr, so if we just
keep o1,txt and no o2.txt, o3.txt, it can certainly work with this test cas=
e:
'git ls-files --format v.s. --eol'. Other cases don't really need
o2.txt, o3.txt.

By the way: this part of code was copied from t/t0025-crlf-renormalize.sh.
it want to test for three kind file, end with "\n", "\r\n", or mix
with "\n", "\r\n".

>
>
> > +     ln -s o3.txt o4.txt &&
> > +     git add "*.txt" &&
> > +     git add --chmod +x o1.txt &&
> > +     git update-index --add --cacheinfo 160000 $(git hash-object o1.tx=
t) o5.txt &&
>
> Do:
>
>         oid=3D$(git hash-object ..) &&
>         git update-index ... "$(oid)"
>
> Otherwise we hide the exit code of "git-hash-object", e.g. if it returns
> the hash and then segfaults.
>

Thanks. I will keep this in my mind.

> > +     git commit -m base
> > +'
> > +
> > +test_expect_success 'git ls-files --format objectmode v.s. -s' '
> > +     git ls-files -s | awk "{print \$1}" >expect &&
>
> Same in this case and below, i.e. let's not hide "git" on the lhs of a
> pipe. So:
>
>         git ls-files >files &&
>         awk ... <files >expect
>
> In this case all your awk-ing can be replaced with (continued)...
>
> > +     git ls-files --format=3D"%(objectmode)" >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git ls-files --format objectname v.s. -s' '
> > +     git ls-files -s | awk "{print \$2}" >expect &&
>
> ...
>
>         cut -d" " -f2
>
> ...
>
> > +     git ls-files --format=3D"%(objectname)" >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git ls-files --format v.s. --eol' '
> > +     git ls-files --eol >tmp &&
> > +     sed -e "s/      / /g" -e "s/  */ /g" tmp >expect 2>err &&
> > +     test_must_be_empty err &&
> > +     git ls-files --format=3D"i/%(eolinfo:index) w/%(eolinfo:worktree)=
 attr/%(eolattr) %(path)" >actual 2>err &&
> > +     test_must_be_empty err &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git ls-files --format path v.s. -s' '
> > +     git ls-files -s | awk "{print \$4}" >expect &&
>
> ...
>
>         cut -f2
>
> I.e. instead of the 4th whitespace field ask for the 2nd \t-delimited
> field. There's nothing wrong with using awk per-se, but let's use the
> simpler "cut" for such a simple use-case.
>
> > +     git ls-files --format=3D"%(path)" >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git ls-files --format with -m' '
> > +     echo change >o1.txt &&
> > +     cat >expect <<-\EOF &&
> > +     o1.txt
> > +     o5.txt
> > +     EOF
> > +     git ls-files --format=3D"%(path)" -m >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git ls-files --format with -d' '
> > +     echo o6 >o6.txt &&
> > +     git add o6.txt &&
> > +     rm o6.txt &&
> > +     cat >expect <<-\EOF &&
> > +     o5.txt
> > +     o6.txt
> > +     EOF
> > +     git ls-files --format=3D"%(path)" -d >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git ls-files --format imitate --stage' '
> > +     git ls-files --stage >expect &&
> > +     git ls-files --format=3D"%(objectmode) %(objectname) %(stage)%x09=
%(path)" >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'git ls-files --format with --debug' '
> > +     git ls-files --debug >expect &&
> > +     git ls-files --format=3D"%(path)" --debug >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> > +test_done
>
> The rest of this (and especially the C code) all looks good to me at
> this point, thanks!
>
> 1. Aside: I've found the test_write_lines helper to be rather strange
>    for us to carry. I.e. most helpers provide a briefer or less
>    buggy/tricky way to do something, but in that case:
>
>         test_write_lines
>         printf "%s\n"
>
>    So we have it to write something in a more verbose way than we need,
>    as we can see experimentally from all tests passing with:
>
>         perl -pi -e 's[test_write_lines ][printf "%s\\n" ]g' t/t[0-9]*.sh
>
>    It seems to me that per
>    https://lore.kernel.org/git/xmqqioqu5fr3.fsf@gitster.dls.corp.google.c=
om/
>    and
>    https://lore.kernel.org/git/1398255277-26303-2-git-send-email-mst@redh=
at.com/
>    it was suggested without knowing that we could use printf to do the
>    same.
>
>    The implementation that landed in ac9afcc31cd (test: add
>    test_write_lines helper, 2014-04-27) was fixed up to use printf,
>    without re-visiting why we were carrying a helper when an even
>    shorter printf would do...

I guess it's just for letting contributers use the same way output multiple
line, otherwise contributers (like me) want to use echo or other commands
sometimes?

But in my test case here, I need a file mixed with "r\n", "\n" instread of
only "\n", so I think maybe we should keep it.

ZheNing Hu
