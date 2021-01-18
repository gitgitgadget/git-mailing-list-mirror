Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4F1C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 04:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB52E2222D
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 04:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbhAREJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 23:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730993AbhAREJE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 23:09:04 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9CFC061574
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 20:08:24 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 36so3515231otp.2
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 20:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+FUyJOqMbCKBNIobnc1rjBA6QRbq7lqxQ/kev/OTzRM=;
        b=BW5OTQaBZC3XEsxBC73lN4ch4leRYFPTki1JcDyNMMZ6BCBRxhNSUn1BNuTXbwMnhS
         nYrIrhWqJjmqNM1Hq/Ew4K00t7wDIcSLgaiCmCc55JktcVE82H4LEnGJt3pzg0X9lW2l
         g/YKhHtwvGzDh3pF8x0OqrcOslnQFGvq9ogS2Ogw3KPhVbbG5D2Iy+wukRWgcVF5OaaW
         JUAuYcrDBhujMDa/pZ02G4O+oBizButrKmyImJp9qG9zuRZJv4z7i6jx347zUocAVp+a
         Dg9pLxKMELa3v75XOmykvAS3qJ6qB73kzLFh7OeV63lwBd2Z77gLQ/3Vvw1TfkMExWej
         Jw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+FUyJOqMbCKBNIobnc1rjBA6QRbq7lqxQ/kev/OTzRM=;
        b=A65MhvBeLlwmeB3BFacVT3xFsXIqV96gXr0OB5vr8IfO9MMOffZNLntcZPk/E5Z8OA
         2ewn7DGV4zfopSe8HPPjjgtGZVI5hoGGXaalEglTwkLn/d96w8saJbT0oEehPt7O9nOH
         2NLE/ibFCGD9/l5IZE87h/T5SYH4Qskkjumcm17XD+/S9A0QIeiuZRFfEu4bdwcij4IR
         6mQsptUD8EviE2DVy8/nTVgl+B9lA01VFF4KMF5HhgXsxgZH/C2jUdSszLrjYm6+rsNx
         8fdDTowH2i7jxBHprUWjEYuMTNejxMhMY1NaGglT/esr8+7TsGluelZ5iv89MCHHwARc
         KlKQ==
X-Gm-Message-State: AOAM531k3r6dUiuDJmePXs5C/VXxQooXXzW+zy8UzmCB2YmJVDgAKadW
        pf4arbDzTsKwQcNP5nz2kKu2q/q70bVKZXDpYHQWdYv4gQLJI9k7
X-Google-Smtp-Source: ABdhPJyi6hdomGa32R7iwe2urohICSvpW7397qjIZlRxDZDpvCi0qXfu2jrdZ1gCEb031qD/b/ktZY/Q1bzkMXzT7V8=
X-Received: by 2002:a9d:816:: with SMTP id 22mr16228166oty.164.1610942903441;
 Sun, 17 Jan 2021 20:08:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
 <pull.832.v4.git.1610856136.gitgitgadget@gmail.com> <0c7830d07db0aa1ec055b97de52bd873d05e3ab1.1610856136.git.gitgitgadget@gmail.com>
 <xmqqbldnkuja.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqbldnkuja.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Mon, 18 Jan 2021 12:09:51 +0800
Message-ID: <CAOLTT8Syp2ZeTXW-m+e=dn2W773nScB_kwZLS3MjLTcFQ_bctw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ls-files: add --deduplicate option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8818=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=887:34=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
> > new file mode 100755
> > index 00000000000..75877255c2c
> > --- /dev/null
> > +++ b/t/t3012-ls-files-dedup.sh
> > @@ -0,0 +1,57 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'git ls-files --deduplicate test'
> > +
> > +. ./test-lib.sh
>
> We should already have a ls-files test so that we can add a handful
> new tests to it, instead of dedicating a whole new test script.
>
Fine,It might be easier for me to write a test file myself for the time bei=
ng.
But I will learn slowly.
> Also, don't do everything in a single 'setup'.  There are various
> scenarios you want to make sure ls-files to work (grep for ls-files
> in the following you added---I count 4 of them), and when a future
> developer touches the code, he or she may break one but not other
> three.  The purpose you write tests is to protect your new feature
> from such a developer *AND* help such a developer to debug and fix
> his or her changes.  For that, it would be a lot more sensible to
> have one set-up that is common, and then four separate tests.
>
> > +test_expect_success 'setup' '
> > +     >a.txt &&
> > +     >b.txt &&
> > +     >delete.txt &&
> > +     git add a.txt b.txt delete.txt &&
> > +     git commit -m master:1 &&
>
> Needless use of the word "master".  Observe what is going on in the
> project around you and avoid stepping other peoples' toes.  One of
> the ongoing effort is to grep for the phrase master in t/ directory
> and examine what happens when the default initial branch name
> becomes something other than 'master', so adding a needless hit like
> this is most unwelcome.
>
Well, I will try my best to use less "master".
> > +     echo a >a.txt &&
> > +     echo b >b.txt &&
> > +     echo delete >delete.txt &&
> > +     git add a.txt b.txt delete.txt &&
> > +     git commit -m master:2 &&
>
> > +     git checkout HEAD~ &&
> > +     git switch -c dev &&
>
> Needless mixture of checkout/switch.  If you switch branches using
> "git checkout", for example, consistently do so, i.e.
>
>         git checkout -b dev HEAD~1
>
> It's not like these new tests are to test checkout and switch; your
> mission is to protect "ls-files --dedup" feature here.
>
> > +     test_when_finished "git switch master" &&
> > +     echo change >a.txt &&
> > +     git add a.txt &&
> > +     git commit -m dev:1 &&
>
> I'd consider all of the above to be 'setup' that is common for
> subsequent tests.  It may make sense to actually do everything
> on the initial branch, i.e. after creating two commits, do
>
I understand it now...setup is for serve as a basis for other tests.
>         git tag tip &&
>         git reset --hard HEAD^ &&
>         echo change >a.txt &&
>         git commit -a -m side &&
>         git tag side
>
> You are always on the initial branch without ever switching, so
> there is no need for the when_finished stuff.
>
> Then the first of your test is to show the index with conflicts.
>
> > +     test_must_fail git merge master &&
>
> This will become "git merge tip" instead of 'master'.
>
use tag instead of use branch name...
> > +     git ls-files --deduplicate >actual &&
> > +     cat >expect <<-\EOF &&
> > +     a.txt
> > +     b.txt
> > +     delete.txt
> > +     EOF
> > +     test_cmp expect actual &&
>
> And up to this point is the first test after 'setup'.
>
> The next test should begin with:
>
>         git reset --hard side &&
>         test_must_fail git merge tip &&
>
> so that even when the first test is skipped, or left unmerged,
> you'll begin with a known state.
>
Well,I understand now that the a test_success should allow other
programmers to skip this test,so that we should reset to a known
state at the beginning of each test.
> > +     rm delete.txt &&
> > +     git ls-files -d -m --deduplicate >actual &&
> > +     cat >expect <<-\EOF &&
> > +     a.txt
> > +     delete.txt
> > +     EOF
> > +     test_cmp expect actual &&
> > +     git ls-files -d -m -t  --deduplicate >actual &&
> > +     cat >expect <<-\EOF &&
> > +     C a.txt
> > +     C a.txt
> > +     C a.txt
> > +     R delete.txt
> > +     C delete.txt
> > +     EOF
> > +     test_cmp expect actual &&
> > +     git ls-files -d -m -c  --deduplicate >actual &&
> > +     cat >expect <<-\EOF &&
> > +     a.txt
> > +     b.txt
> > +     delete.txt
> > +     EOF
> > +     test_cmp expect actual &&
>
> These three can be kept in the same test_expect_success, as they are
> exercising read-only operation on the same state but with different
> display options.
>
indeed so.
> But in this case, the preparation is not too tedious (just a failed
> merge plus a deletion), so you probably would prefer to split it
> into 3 independent tests---that may make it more helpful to future
> developers.
>
Thanks:)
> > +     git merge --abort
> > +'
> > +test_done
