Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D53BC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 14:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1478261DB3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 14:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhF2OOD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 29 Jun 2021 10:14:03 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:37686 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhF2OOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 10:14:00 -0400
Received: by mail-ej1-f54.google.com with SMTP id o11so23460022ejd.4
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 07:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+u5jNPfIW+jrpKfpypowOj/fbFiv7dmioMdanR2r+Xk=;
        b=qKFfNsgTK2c/ONf6/IOJ2i8MB2xxWHO0C8sRv5cj2n0v5nkWPlUgas/w+1juFsYUW6
         KQtULIpWg4h63ogmKVjzrXILOhGDRsJWe71o8jR0Q6UHQ2rTuQHTV2f7eYseCCKfkhxr
         yb7cDa98TtkJUooMOu+lAe8KXSNBWhuuPX62E9zezxBvEXhcZaHlWWVM+N5rkuh5C695
         iaRuYe66s9JAQVzWy0yYmZvfn3flFSpeyX4CL1j6KJs5krEAuD2WfQKL4jJLkxtllxhY
         ajeoQ9+X0t4aW5u+0JOuIy7eRVv0GLwtXmC8krHxz/+vFxbPI4TP/qkX1obIVWcE88zg
         sb/Q==
X-Gm-Message-State: AOAM532NU6K0nTXnXznLG/tiG8yFXAdClD1W7vLfwQJP08J7WuCB3Lcz
        wX5V7cCV8ZDjORCDQ/wRnzGVjPJufGFbc7VVuqM=
X-Google-Smtp-Source: ABdhPJx+C+cmZjDFasuMaStqPmRdFWMry4eZjepBZ8GQm+1VBX9aL+1LVjuTvcqwiXxbXyY0LLIrsHfBfhRv+IDTQa8=
X-Received: by 2002:a17:907:a064:: with SMTP id ia4mr30506322ejc.482.1624975891524;
 Tue, 29 Jun 2021 07:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210615172038.28917-1-congdanhqx@gmail.com> <cover.1624974969.git.congdanhqx@gmail.com>
 <49104273b8b801fc61811347120c5f4c42a3700b.1624974969.git.congdanhqx@gmail.com>
In-Reply-To: <49104273b8b801fc61811347120c5f4c42a3700b.1624974969.git.congdanhqx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 29 Jun 2021 10:11:20 -0400
Message-ID: <CAPig+cSKOzebGRyoytUGORhq56P0rijYrKO6uu7q7fWnzwiQkw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t6400: preserve git ls-files exit status code
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 29, 2021 at 9:57 AM Đoàn Trần Công Danh
<congdanhqx@gmail.com> wrote:
> In t6400, we're checking number of files in the index and the working
> tree by piping the output of "git ls-files" to "wc -l", thus losing the
> exit status code of git.
>
> Let's write the output of "git ls-files" to a temporary file, in order
> to check exit status code of "git ls-files" properly.

Thanks, the simplicity of this version over the previous attempts is appealing.

Just a few extremely minor style nits below; don't know if any of them
are worth a re-roll.

> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
> diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
> @@ -9,6 +9,20 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
>  . ./test-lib.sh
>
> +check_ls_files_count() {

style: funcname () {

> +       local ops val
> +       if test "$#" -le 2

I also &&-chain the `local` declaration:

    local ops val &&
    if test "$#" -le 2

By making it easy to see the `&&` upfront, when new code is inserted,
there is a better chance that the &&-chain will be kept intact:

    local ops val &&
    my new code &&
    if test "$#" -le 2

> +       then
> +               BUG "Expect 2 or more arguments"
> +       fi &&

A quick grep of the tests indicates that they are consistent about
using lowercase for the first word in a BUG():

    BUG "expect 2 or more arguments"

> +       ops="$1" &&
> +       val="$2" &&
> +       shift 2 &&
> +       mkdir -p .git/trash &&
> +       git ls-files "$@" >.git/trash/output &&
> +       test_line_count "$ops" "$val" .git/trash/output
> +}
