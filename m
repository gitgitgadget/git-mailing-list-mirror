Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9EAC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C27F230F9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbhAGGLQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 7 Jan 2021 01:11:16 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:38126 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAGGLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 01:11:15 -0500
Received: by mail-ej1-f52.google.com with SMTP id 6so8203449ejz.5
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 22:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QUEc5Yv/wNB8hShyrB898FYGasVnMv8+rGeHgECcmgk=;
        b=lcH6inPLULAtCbPPfFjR3+uB1y5lyy3GIWnrsW1Nf7oWDoX/ySj4x3e95Az+sa/QD3
         rUYVbKNymaUJ1ysudPdaHJ/DmSb9p9SKvlq3/qZenNclp5OG8sQ0JBdE2mJncpII5jcw
         VNmXitW/GH9ANkYwGJrwcnwN2A48s4mY/WS7+6A7DVuE6lABjldsmAXQEt8j9Rrch4au
         qhxbTeVYViW4jS7QXehgCPQDridhx8CqFGPR7qMr4jEOaONG1pHc0Fs9v6d26RxCuYN5
         yytezzYJxw0NqM+XPotn0aCMBcwW8qMOhw70AVB0Exygw/Wfs9CGsnSPaRM2Ixr2Yevr
         RaZA==
X-Gm-Message-State: AOAM5337nZE57pcHVY5BCKT0UYizXsI0+78jqV7V0nY5H5EXcSOoXcgC
        aam5dHxLmHXms323TdNGmDurv3Ic3cxISFvzavk8s6qjVTAuTw==
X-Google-Smtp-Source: ABdhPJxMAO1bpIVF5eaHE2OHZ+zcjldA8qENM0YZ8S3WDIaOz4OOEMVSJTBb/jOsrxYlxsaQuwb70gHlQI5lUZ7N3UE=
X-Received: by 2002:a17:906:d8dc:: with SMTP id re28mr5277723ejb.168.1609999833395;
 Wed, 06 Jan 2021 22:10:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.git.1609923182451.gitgitgadget@gmail.com>
In-Reply-To: <pull.832.git.1609923182451.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Jan 2021 01:10:22 -0500
Message-ID: <CAPig+cTY0qGkYZ_OjvFUhopoioCPzaWEk=AX1mNgcOsF60hwAg@mail.gmail.com>
Subject: Re: [PATCH] builtin/ls-files.c:add git ls-file --dedup option
To:     =?UTF-8?B?6Zi/5b6354OIIHZpYSBHaXRHaXRHYWRnZXQ=?= 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 6, 2021 at 3:54 AM 阿德烈 via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> Therefore, I added the --dedup option to git ls-files.
> 1. It can be achieved that only the deleted file name
> is displayed when using -m, -d, and --dedup at the same time.
> 2. Add --dedup when merging branches to remove duplicate file
>  names. (unless -s, -u are used)

I'm just pointing out a few minor style issues below; I'm not properly
reviewing the patch...

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  builtin/ls-files.c | 43 ++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 38 insertions(+), 5 deletions(-)

This change adds a new command-line option, so the documentation
(Documentation/git-ls-files.txt) should be updated and at least one
new test should be added (in one of the t/t30??-ls-files-*.sh scripts
probably).

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> @@ -301,6 +302,7 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>         struct strbuf fullname = STRBUF_INIT;
> +       const struct cache_entry *last_stage=NULL;

Add spaces around `=` similar to the preceding line:

    const struct cache_entry *last_stage = NULL;

> @@ -315,7 +317,20 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>                 for (i = 0; i < repo->index->cache_nr; i++) {
>                         const struct cache_entry *ce = repo->index->cache[i];
> -

This patch deletes the blank line but this project usually prefers to
have a blank line after declarations.

> +                       if(show_cached && delete_dup){

Add space after `if` and before `{`:

    if (show_cached && delete_dup) {

> @@ -336,7 +351,20 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
> +                       if(delete_dup){

Style: if (delete_dup) {

> @@ -347,10 +375,14 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
> -                       if (show_deleted && err)
> +                       if(delete_dup && show_deleted && show_modified && err)

Style: if (delete_dup && ...

> -                       if (show_modified && ie_modified(repo->index, ce, &st, 0))
> -                               show_ce(repo, dir, ce, fullname.buf, tag_modified);
> +                       else{

Style: else {

> +                               if (show_deleted && err)/* you can't find it,so it's actually removed at all! */

Add space before `/* comment */`.
Add space in "...it, so...".

> @@ -578,6 +610,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
> +               OPT_BOOL(0, "dedup", &delete_dup, N_("delete duplicate entry in index")),

The short help makes it seem like it's modifying the index. Perhaps instead:

    N_("suppress duplicate entries")
