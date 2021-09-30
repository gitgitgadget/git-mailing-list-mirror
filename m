Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A91C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 06:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CFF6615E1
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 06:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348431AbhI3G7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 02:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348428AbhI3G7m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 02:59:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446F2C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 23:58:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 17so5282781pgp.4
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 23:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fL8nY4VDzxY6NNE7mHPkRVm2g3UWCNyKLQo2E3QAov4=;
        b=YhbCHsmJ+4JNL1igZe95K5+vH9klfVnLNDPm8WyMUWCbKJlX8VqX5ZR+HvSS5A3k93
         ueOQ7g4O/rmj8CTJg7t9pdTIQCtzq95sEU6/0E1UabTf3CHUtsgazFbP2nuk5OmgtLgp
         TuxYY/9ew/52h8x0jG1ulCq+/ogrOsdVgsjkCyg/e4IFVDys1RWenmqT+UVfL9GkWyqH
         ZznVdt8Qjm03W69cLjphMwrARr7ixHyelyUMC+PyhtMCn2xg5VK6Ow7L7/ySArLjl9BP
         HIXEzeyJv6SBPfkdn3gne9Vhx1DAkEqLjyO7AmthoLMuGgoTi8mAo2PMGrYH0THWDwvM
         +w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fL8nY4VDzxY6NNE7mHPkRVm2g3UWCNyKLQo2E3QAov4=;
        b=de5lfaT1DnOKZSdAaE/fFTWQh65olXY+3J9MHzTht2FXxakTMLriwI+KmBbJKut+c8
         fiG59apzseifu2VbJ/+w1jx73sjVENhhpDBb/PRFLZjuKZLLo0CzcBxgqkISngs5HJcO
         vq7YW7QRbQBN8vqC8aHAB6MdPbSm4IJfGMZDtVXS5oH4rp+pyzS7KfLtpENVcA47bg80
         3cxuUzZkMLdRNuwryywWgKjyAInHSf6Ps8aoueujgJRhgpAh/Y+MbweLt114ysHuIj1k
         VAhfGDpZSHOrsiraPJhce8Xp+Oj7ME3yt+d2PZ6eGrF/vExRCgqzMFDD6F7zE86Zz4AF
         qeCw==
X-Gm-Message-State: AOAM531na9vJp7MPDcNsWx/+ChjDd5lqKA4nefkXctg1Fm670u4MCnPB
        zMxgZnoogp5FrsVzHOeVe6ebJVuvwrydp/XFSVEGpZdDBNM=
X-Google-Smtp-Source: ABdhPJyevm6vAXQ5M0zs2L0abcQkB1F0ugp/309Mjl9SeKtLn5NAMNtSgX6MccJ9ZJ7RLxLxDX7/Y/0lArLDFrZYFGA=
X-Received: by 2002:aa7:9dc6:0:b0:440:b629:6e57 with SMTP id
 g6-20020aa79dc6000000b00440b6296e57mr3891664pfq.69.1632985079625; Wed, 29 Sep
 2021 23:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <CANgfOPtz9JqCs-7z1DJnOqxnsGiQS6BBPD6tKTWnTpC0K3qZ9Q@mail.gmail.com>
 <CABPp-BGv=+R1trGZq7r+-VneVUSoH_nOhS9sh3P7WSCiSVZksQ@mail.gmail.com>
In-Reply-To: <CABPp-BGv=+R1trGZq7r+-VneVUSoH_nOhS9sh3P7WSCiSVZksQ@mail.gmail.com>
From:   Ariel Man <arielman22@gmail.com>
Date:   Thu, 30 Sep 2021 09:57:48 +0300
Message-ID: <CANgfOPvBy+v4hMDt7uNjawvEC5F-daSm2TTvk=3oBJPrj2KNYA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Question_about_git_merge_=2Ds_ort_command=E2=80=8F=E2=80=8F?=
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Thanks for the detailed answer, but just to clarify, my main question
is regarding ORT strategy, and not recursive.
Mainly in this case, where ORT didn't behave as I expected:
https://stackoverflow.com/questions/69150777/git-mv-doesnt-work-as-expected=
-wrong-files-location#:~:text=3Dtest3.py%0A%E2%94%82%20%20%20%E2%94%94%E2%9=
4%80%E2%94%80%20dir3-,UPDATE,-I%27m%20adding%20one

As I wrote, this specific case is where new folder and files were
created after the consolidation (and not new files under the existing
folder). As you can see, when only new files were added to the
existing folder, the git ORT recognized it and moved the folder
python1 with its files test1.py and test4.py to the right place
(dir2). But when new folder was created on the target (new_test with
the file test5.py), when I ran the ORT command, the GIT didn't
recognized it and created again the folder python1 on the old path
(dir1-->python1-->new_test-->test5.py).
I believe you can reproduce it yourself on your repository and see the
behaviour.
Ariel

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=94=D7=
=B3, 30 =D7=91=D7=A1=D7=A4=D7=98=D7=B3 2021 =D7=91-8:27 =D7=9E=D7=90=D7=AA =
=E2=80=AAElijah Newren=E2=80=AC=E2=80=8F
<=E2=80=AAnewren@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Sun, Sep 19, 2021 at 8:12 PM Ariel Man <arielman22@gmail.com> wrote:
> >
> > Hi,
> > following the below thread, led me to do some tests:
> > https://stackoverflow.com/a/69114710/11705021
> >
> > One of the test can be seen here, in the last example in my question:
> > https://stackoverflow.com/questions/69150777/git-mv-doesnt-work-as-expe=
cted-wrong-files-location
> >
> > I wanted to get confirmation for my case:
> > Does `git merge -s ort` command, doesn't know to detect new folder
> > location when merging it? It did worked for folders and files
> > renaming, and new files under existing folders (as describe here:
> > https://stackoverflow.com/a/52227201/6309)
>
> I mean, if you have a testcase and want to see how it works, you can
> just try it.  merge-ort has been released and is part of git already.
>
> But I'll take a stab...
>
> Your testcase with new folders sounds like testcase 12f from t6423 in
> our testsuite (from commit 902c521a35 ("t6423: more involved directory
> rename test", 2020-10-15)), a case that works with the `ort` merge
> strategy but not with `recursive`.  So, the `ort` strategy is likely
> to be better for your usecase than `recursive`, but it's hard for me
> to definitively state that it'll solve all your usecase(s) since you
> didn't fully describe them.  This is especially important since you
> appear to have discovered a segfault (in the first post); I was not
> aware of any circumstances when the old merge machinery would do so.
> I'd be interested to know if the same issue repeats with the `ort`
> strategy, and, if so, whether you can get a stack trace, or find an
> example that reproduces the problem, or provide us with access to your
> repository.  Also, in your second link, you allude to problems in a
> case that does not include new folders, in situations where I'd expect
> `recursive` and `ort` to behave the same.  But it's hard to know the
> expected behavior since you didn't provide that many details about the
> setup -- e.g. you didn't cover the contents of any of the files (so
> it's hard to know if files are more similar to ones with different
> names than what you expected to be matched up), it's unclear if there
> are other files involved (e.g. if you have multiple copies of some
> library and the rename detection is detecting a different copy than
> you expected, or if there are lots of additional files besides those
> you are listing in your example and they are being renamed
> differently, etc.), whether you have lots of large files also being
> renamed (perhaps the VDI files you allude to somewhere?), etc., etc.
> If you can provide access to a repository and the commands you
> reported and what you expected vs. what you saw, I'd try to find some
> time to take a look.
>
> I hope that helps, though I'm not sure I've got enough details to
> answer all your questions.  I guess if I were to summarize, I'd say:
>   * the `ort` strategy would be better than `recursive` for you, for
> one particular type of issue, but probably behave the same on other
> areas
>   * you seem to have useful testcases that might be different than
> ones we have in our testsuite or that I know about
>   * you haven't provided enough information for me to investigate or
> answer any further, though.
>
> You have gotten me really curious about this segfaulting testcase --
> whether it's just in the recursive backend or also afflicts merge-ort,
> and how to duplicate it.
