Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13735C38159
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 05:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjATFf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 00:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjATFfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 00:35:09 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B2175A3B
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 21:31:08 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bp15so6432371lfb.13
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 21:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yym/Blh8UqrSQ4katCAyFFRQMRiFGDpKoUkoxAjH9dY=;
        b=Bpet6jTpU/rgfTNXg1SEWInrxMGNTLwM/8iviafZHJcjtKkWLxs5ttz5LBrdChtM0C
         kjzw6rrPpeP4blqMPytqLmIL2/mAijvbXK14rZ2EoA1pdT+f/RPKAfDxAbnltOulYTKj
         IjOxbuplNu1850DF+aIB2s8VwqEvse0Eqs5XNy/fV3ha3Qv1LgIm5PVSaLyYtYo9dWqh
         IhyVSVz2CS3jBtlyes9wYmqepgY0m+N7ac8RnqHTRvHpTEFc4WpH5pUJCHE6sOSEtIlH
         joM5lx48HIqUauvMSlRs7Aiufu5FmeX9ik06LN/J54v4jnrLNrnjwec9A9BlIvT0y+4P
         D9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yym/Blh8UqrSQ4katCAyFFRQMRiFGDpKoUkoxAjH9dY=;
        b=0eye+UBXVrSsweCBNoxtR2lR5kmV+ZKa8as5jXXBz4fNv0uG/rODjAX+zvjO5oRotb
         3CQmuhaLlgCrSmWR5satdKuuHdcb4paIv2AOnEr51mjwqhU+QCA+2mENmBZLPbAXFs0X
         3woQP7di1PbJBS2TMnyQFxasCo6RwvmREeJ2KTGIkmaTcc6b2Lq9GkSEOMmfZLuPxyZN
         Nagpr9+7JMuyXM5X14twLJvx9DFFqrcj/ToTBhfUDpKkoOD5fJ6OPNvlrH0NPlugqtAi
         nwQe1Id7RRK/mee3YeoxDQXq+WUMHAQn6KucEvy1kKSTmTmVhROFbNv96ZTAKJdAsds4
         ErLw==
X-Gm-Message-State: AFqh2kru8ZQAmslvFq8Jo8qSuEEOXFrK2hm1+Psyd35xTespgabv+Bw4
        yDmzX6yZFHTMP9R2Ecl97GPOEU396ixE035ENIXLvzRqiao=
X-Google-Smtp-Source: AMrXdXvqBBQIQm+zW8dYSU+UDR16ZWYFHfUzabkkGGz/h71BAME5keEgGxVPSbTSqtzrzSn7GiCv+AISannZXMpDpEg=
X-Received: by 2002:a05:6512:3e11:b0:4cb:d46:94b7 with SMTP id
 i17-20020a0565123e1100b004cb0d4694b7mr695084lfv.405.1674192632997; Thu, 19
 Jan 2023 21:30:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
 <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com> <9ebd6b77a69be414388a52a482912173f2a4e7d8.1674149666.git.gitgitgadget@gmail.com>
In-Reply-To: <9ebd6b77a69be414388a52a482912173f2a4e7d8.1674149666.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Jan 2023 21:30:19 -0800
Message-ID: <CABPp-BGLmhoHAcuLoz_yQ4TmNBvDU6Ehymy_3rh0wguSw0hjGw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ls-files: add %(skipworktree) atom to format option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2023 at 9:34 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Because sometimes we want to check if the files in the
> index match the sparse specification, so introduce
> "%(skipworktree)" atom to git ls-files `--format` option.
> When we use this option, if the file match the sparse
> specification, it will output "1", otherwise, output
> empty string "".

Why is that output format useful?  It seems like it'll just lead to
bugs, or someone re-implementing the same field with a different name
to make it useful in the future.  In particular, if there are multiple
boolean fields and someone specifies e.g.
   git ls-files --format="%(path) %(skipworktree) %(intentToAdd)"
and both boolean fields are displayed the same way (either a "1" or a
blank string), and we see something like:
   foo.c 1
   bar.c 1
Then how do we know if foo.c and bar.c are SKIP_WORKTREE or
INTENT_TO_ADD?  The "1" could have come from either field.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-ls-files.txt |  5 +++++
>  builtin/ls-files.c             |  3 +++
>  t/t3013-ls-files-format.sh     | 23 +++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 440043cdb8e..2540b404808 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -260,6 +260,11 @@ eolattr::
>         that applies to the path.
>  path::
>         The pathname of the file which is recorded in the index.
> +skipworktree::
> +       If the file in the index marked with SKIP_WORKTREE bit.
> +       It means the file do not match the sparse specification.
> +       See link:technical/sparse-checkout.txt[sparse-checkout]
> +       for more information.

minor nits: Missing an "is", and "do" should be "does".

I'm curious whether the second sentence is even necessary; we've
already got the link to the more technical docs.  Perhaps just:

skipworktree::
    Whether the file in the index has the SKIP_WORKTREE bit set.
    See link:technical/sparse-checkout.txt[sparse-checkout]
    for more information.

>  EXCLUDE PATTERNS
>  ----------------
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index a03b559ecaa..bbff868ae6b 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -280,6 +280,9 @@ static size_t expand_show_index(struct strbuf *sb, const char *start,
>                               data->pathname));
>         else if (skip_prefix(start, "(path)", &p))
>                 write_name_to_buf(sb, data->pathname);
> +       else if (skip_prefix(start, "(skipworktree)", &p))
> +               strbuf_addstr(sb, ce_skip_worktree(data->ce) ?
> +                             "1" : "");

As I mentioned in response to the commit message, I don't understand
why having an empty string would be desirable.

>         else
>                 die(_("bad ls-files format: %%%.*s"), (int)len, start);
>
> diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
> index efb7450bf1e..cd35dba5930 100755
> --- a/t/t3013-ls-files-format.sh
> +++ b/t/t3013-ls-files-format.sh
> @@ -92,4 +92,27 @@ test_expect_success 'git ls-files --format with --debug' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'git ls-files --format with skipworktree' '
> +       test_when_finished "git sparse-checkout disable" &&
> +       mkdir dir1 dir2 &&
> +       echo "file1" >dir1/file1.txt &&
> +       echo "file2" >dir2/file2.txt &&
> +       git add dir1 dir2 &&
> +       git commit -m skipworktree &&
> +       git sparse-checkout set dir1 &&
> +       git ls-files --format="%(path)%(skipworktree)" >actual &&
> +       cat >expect <<-\EOF &&
> +       dir1/file1.txt
> +       dir2/file2.txt1
> +       o1.txt
> +       o2.txt
> +       o3.txt
> +       o4.txt
> +       o5.txt
> +       o6.txt
> +       o7.txt
> +       EOF
> +       test_cmp expect actual
> +'

I find this test hard to read; it's just too easy to miss
"dir2/file2.txt1" vs "dir2/file2.txt".  I'd suggest at least adding a
space, and likely having the skipworktree attribute come first in the
format string.  It might also be useful to add "dir*" on the ls-files
command to limit which paths are shown, just because there's an awful
lot of files in the root directory and no variance between them, and
it's easier to notice the binary difference between two items than
having a full 9 and figuring out which are relevant.
