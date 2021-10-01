Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263FEC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 08:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0980B61A7F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 08:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352667AbhJAIGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 04:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352633AbhJAIGx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 04:06:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85DCC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 01:05:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id dj4so32685823edb.5
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/+oleqwYmz74B9KQPaniLb06VXF7afLYR99Uc9148ig=;
        b=hcStiE2TUgAUPeXAVAuRA4fZOxS8W/GdEl/UPeByEse52hJsuAOct3Zd+JZlytG4wQ
         zZghnWFx/LDr/TdwqrkS28+t/97yoGmFu9uvF8k9vmnJvwjhwOgjfl5bhKdbxpSGA1Xj
         zRrYKe3bOqvmK9HlcBxF09609V096edUivrc1UiPaMydWan22+Z1NcusDYL4Q1b644ni
         pi4Q7mHgOabTxUrXUx5GM5lGoJOynU4rmJkUockGyIvbhvzLuyWlJIgCkIrEsH4ijpMj
         cvG0zHNOjIyzU4+E5fIL5UmQzDOJiVtWbgEQjxfg2JaYICYJ3ptR83IQwNXyRjf2guGs
         vFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/+oleqwYmz74B9KQPaniLb06VXF7afLYR99Uc9148ig=;
        b=yWO0jEsV0c2TfOM4/eNquCb1SVuV8WN5Jmfy4KaacDI6Wr/CMJdsSvxSJf5hiIfOvg
         jQxTCBHdHepnk/Po3O5OaNJdPLdokJnyXPUceedmUqaAdtcuFu+DCkGtbNooH+AxZmI2
         +1KGf2jl0cLJ/zc+7ZpbPvLkX4gM8AJKcxw4gjjA//Gb/48LFyZvm6sDJRCusVm4Jmxf
         ebGtUkNHwy+7w2TEtkOT3ExMc7Wlzi3s7JrI4JHlRR0ayDWWaFRFIEayOq2wDOxZ5U3R
         hRyiOm3sHHToBOFmJtQlVxNIRWzeRuFaZhDcWW7MjTCbaqWuLfzs9rARWswufBmw9b3A
         h8FQ==
X-Gm-Message-State: AOAM533LaBweZ4N31FqsoKrwgs/bRezg6v98pa7/u0EcefNfF78RnaSA
        1gVubQ1Rpozw5azydbTx0EvRSlmdgEdg6sr1Cy/dXWoZRi8=
X-Google-Smtp-Source: ABdhPJxDsPuOh0nQ5b+VWxsd4tlwjuATP4ThuKwG+I3nye+UgAatbzRHWUqX/R0qD0fQq/qvIIczTEbqtiM6bc9YI7E=
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr4736684ejp.520.1633075508206;
 Fri, 01 Oct 2021 01:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <CANgfOPtz9JqCs-7z1DJnOqxnsGiQS6BBPD6tKTWnTpC0K3qZ9Q@mail.gmail.com>
 <CABPp-BGv=+R1trGZq7r+-VneVUSoH_nOhS9sh3P7WSCiSVZksQ@mail.gmail.com> <CANgfOPvBy+v4hMDt7uNjawvEC5F-daSm2TTvk=3oBJPrj2KNYA@mail.gmail.com>
In-Reply-To: <CANgfOPvBy+v4hMDt7uNjawvEC5F-daSm2TTvk=3oBJPrj2KNYA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Oct 2021 01:04:55 -0700
Message-ID: <CABPp-BFFbt_1v9P7bpkP5tZ3KJDOaTTSBC+hFCyw08FSSWOwhA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Question_about_git_merge_=2Ds_ort_command=E2=80=8F=E2=80=8F?=
To:     Ariel Man <arielman22@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Please do not top-post on this mailing list.

On Wed, Sep 29, 2021 at 11:58 PM Ariel Man <arielman22@gmail.com> wrote:
>
> Hi,
> Thanks for the detailed answer, but just to clarify, my main question
> is regarding ORT strategy, and not recursive.

Since you simply linked to three posts in your original email, and the
first showed a segfault, this wasn't at all clear.

> Mainly in this case, where ORT didn't behave as I expected:
> https://stackoverflow.com/questions/69150777/git-mv-doesnt-work-as-expect=
ed-wrong-files-location#:~:text=3Dtest3.py%0A%E2%94%82%20%20%20%E2%94%94%E2=
%94%80%E2%94%80%20dir3-,UPDATE,-I%27m%20adding%20one
>
> As I wrote, this specific case is where new folder and files were
> created after the consolidation (and not new files under the existing
> folder). As you can see, when only new files were added to the
> existing folder, the git ORT recognized it and moved the folder
> python1 with its files test1.py and test4.py to the right place
> (dir2). But when new folder was created on the target (new_test with
> the file test5.py), when I ran the ORT command, the GIT didn't
> recognized it and created again the folder python1 on the old path
> (dir1-->python1-->new_test-->test5.py).

Yes, I read through that and pointed out your examples weren't fully
specified.  You haven't stated what else exists in all these
directories, what kind of contents files had, if there were big
binaries, etc.

> I believe you can reproduce it yourself on your repository and see the
> behaviour.

Nope, I can't.  I went through the trouble of setting up the testcases
as close as I could from your diagrams.  When using the recursive
strategy, I do see that test4.py and test5.py are left behind in dir1,
but when using the ort strategy, it behaves exactly as you said you
wanted (with *both* test4.py and test5.py appearing somewhere under
dir2 rather than dir1).

Here's the output from my script showing all the files that exist in
each of the relevant commits:

=3D=3D=3D Original =3D=3D=3D
dir1/otherfile
dir1/python1/test1.py
dir2/otherfile
dir2/python2/test2.py
dir3/otherfile
dir3/python3/test3.py

=3D=3D=3D Consolidated =3D=3D=3D
dir1/otherfile
dir2/otherfile
dir2/python1/test1.py
dir2/python2/test2.py
dir2/python3/test3.py
dir3/otherfile

=3D=3D=3D New files =3D=3D=3D
dir1/otherfile
dir1/python1/new_test/test5.py
dir1/python1/test1.py
dir1/python1/test4.py
dir2/otherfile
dir2/python2/test2.py
dir3/otherfile
dir3/python3/test3.py

=3D=3D=3D Merged result =3D=3D=3D
dir1/otherfile
dir2/otherfile
dir2/python1/new_test/test5.py
dir2/python1/test1.py
dir2/python1/test4.py
dir2/python2/test2.py
dir2/python3/test3.py
dir3/otherfile


and here's the script I used to run this testcase and generate the above ou=
tput:

#!/bin/bash

git init -b main nukeme
cd nukeme

echo '''
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 dir1
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 python1
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 test1.py
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 dir2
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 python2
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 test2.py
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 dir3
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 python3
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 test3.py
''' >/dev/null
for i in $(seq 1 3); do
    mkdir -p dir$i/python$i
    echo $i >dir$i/python$i/test$i.py
    >dir$i/otherfile
done

git add .
git commit -qm "Initial"

git branch consolidated
git branch newfiles

git checkout consolidated
echo '''
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 dir1
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 dir2
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 python1
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 test1.py
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 python2
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 test2.py
=E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 python3
=E2=94=82   =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 test3.py
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 dir3
''' >/dev/null
git mv dir1/python1 dir2/
git mv dir3/python3 dir2/
git commit -qm consolidated

git checkout newfiles
echo 4 >dir1/python1/test4.py
git add dir1/python1/test4.py
mkdir dir1/python1/new_test
echo 5 >dir1/python1/new_test/test5.py
git add dir1/python1/new_test/test5.py
git commit -qm newfiles

git checkout -qb merged consolidated
git merge --no-edit -s ort newfiles

echo
echo "=3D=3D=3D Original =3D=3D=3D"
git ls-tree -r --name-only main
echo
echo "=3D=3D=3D Consolidated =3D=3D=3D"
git ls-tree -r --name-only consolidated
echo
echo "=3D=3D=3D New files =3D=3D=3D"
git ls-tree -r --name-only newfiles
echo
echo "=3D=3D=3D Merged result =3D=3D=3D"
git ls-tree -r --name-only merged
