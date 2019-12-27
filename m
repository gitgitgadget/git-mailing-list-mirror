Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8EEC2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE54420CC7
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 21:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqeAiUxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL0VqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 16:46:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46413 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0VqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 16:46:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id k8so20620857otl.13
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 13:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SA4u0ow7Zcouw3yb1ieZGg6eDnkC24Z7xfgCa7RfCTI=;
        b=ZqeAiUxGW+pT3umlq++bKuQzNH+RgoeCRRd7TLTzO8jkx5evhVA6CwXyDZniaHY4It
         2ssqhzwX5UDTWOwT/dm/9rBe7w9QPn2FBke/+V9pfu9B5aipFxncrvyqSXxDf2dJh3Cv
         c7Lni0NcXGgDrjGk7x6mthl+VXYMkXQAKoFoG8dqYZRMPLwK+m+3XZXWFXXGwpNXzCet
         oVk690NuMCmYlkFNOqVR+UYYpt7BG3iGCWyvoW6YcSu3Hrhj5AElsh/G/m2OZxYSdW/W
         6Es9Xmv/8CfM7KhSIABd09hZRdo3JksG2QESDMJd23mK9tGj/72vwe0978kv8VB8+XT2
         GyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SA4u0ow7Zcouw3yb1ieZGg6eDnkC24Z7xfgCa7RfCTI=;
        b=jUwEDRd1j5LxYZWtaaGu8KK8etaDFFlSICJMoa15p5r8Bgrok+czVHrWFJkANu6YvL
         zoFeQAJlLClL/25hOH14bVsHHDeXgUG7WNXc4nX3VeTcZdtsGBO0BWd2jo2lqymnsuXL
         8eYGmKiwa+GCuejlGQow0METUpWRkRUliwNeQLUd97XlB3ZmQXMwknUz009mmxzvJA2x
         kpbqrHpJme67GRSk0DrfoW28zN1VfUp5yyIdipes1fjIjVj+vVVU6yKJCM5R7ElIy7Ng
         kVHXdqQkLan8MmXlirJsL/D7lfnFvDugVvMfZydmx6WNXkg2rNWwpqmZgYJR2ZPDtRd+
         C+nw==
X-Gm-Message-State: APjAAAVLZpKSoJTcWic3DS31O4NgkKcyZUGu9CnBZICuFc5p8aXuOxnt
        tSnwLjeGQb1CVE5QdHPO6GADdhuDmlMf+g5Jcsk=
X-Google-Smtp-Source: APXvYqwgYZWtB10ZZaOuioK5LHnbGn+73yqYQoKeB+J+aiNZ9xrQcspMLctlzyJGXi+0yz+q7f3umMDPairNVBHlb7Y=
X-Received: by 2002:a05:6830:681:: with SMTP id q1mr60832526otr.162.1577483175816;
 Fri, 27 Dec 2019 13:46:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.500.git.1577393347.gitgitgadget@gmail.com>
 <pull.500.v2.git.1577472469.gitgitgadget@gmail.com> <331bb7d6fbec6f2f429feb36cf32e0931307ae0b.1577472469.git.gitgitgadget@gmail.com>
In-Reply-To: <331bb7d6fbec6f2f429feb36cf32e0931307ae0b.1577472469.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Dec 2019 13:46:09 -0800
Message-ID: <CABPp-BHnTyYJ=RgQhnrRvcwSRd=kGHR=j5uvuVRYZjDNYAdX8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sparse-checkout: document interactions with submodules
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        jon@jonsimons.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 27, 2019 at 10:47 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Junio asked what the behavior is between the sparse-checkout feature
> and the submodule feature.

Does this first sentence help future readers?  It is what spurred you
to write the documentation, but it seems like something that could
just be left out.

> The sparse-checkout builtin has not changed
> the way these features interact, but we may as well document it in
> the builtin docs.
>
> Using 'git submodule (init|deinit)' a user can select a subset of
> submodules to populate. This behaves very similar to the sparse-checkout
> feature, but those directories contain their own .git directory
> including an object database and ref space. To have the sparse-checkout
> file also determine if those files should exist would easily cause
> problems. Therefore, keeping these features independent in this way
> is the best way forward.
>
> Also create a test that demonstrates this behavior to make sure
> it doesn't change as the sparse-checkout feature evolves.
>
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-sparse-checkout.txt | 10 ++++++++++
>  t/t1091-sparse-checkout-builtin.sh    | 28 +++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
> index dcca9ee826..2b7aaa0310 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -164,6 +164,16 @@ case-insensitive check. This corrects for case mismatched filenames in the
>  'git sparse-checkout set' command to reflect the expected cone in the working
>  directory.
>
> +
> +SUBMODULES
> +----------
> +
> +If your repository contains one or more submodules, then those submodules will
> +appear based on which you initialized with the `git submodule` command. If
> +your sparse-checkout patterns exclude an initialized submodule, then that
> +submodule will still appear in your working directory.
> +
> +
>  SEE ALSO
>  --------
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 37f6d8fa90..5572beeeca 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -340,4 +340,32 @@ test_expect_success 'cone mode: set with core.ignoreCase=true' '
>         test_cmp expect dir
>  '
>
> +test_expect_success 'interaction with submodules' '
> +       git clone repo super &&
> +       (
> +               cd super &&
> +               mkdir modules &&
> +               git submodule add ../repo modules/child &&
> +               git add . &&
> +               git commit -m "add submodule" &&
> +               git sparse-checkout init --cone &&
> +               git sparse-checkout set folder1
> +       ) &&
> +       list_files super >dir &&
> +       cat >expect <<-EOF &&
> +               a
> +               folder1
> +               modules
> +       EOF
> +       test_cmp expect dir &&
> +       list_files super/modules/child >dir &&
> +       cat >expect <<-EOF &&
> +               a
> +               deep
> +               folder1
> +               folder2
> +       EOF
> +       test_cmp expect dir
> +'
> +
>  test_done
> --

I read over the rest, and not being a submodule user I'm not sure what
I'd expect.  But it certainly seems reasonable to document how these
features interact and that you haven't made any modifications in the
area.
