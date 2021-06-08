Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D773C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B31161184
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhFHTCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 15:02:36 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40657 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbhFHS7a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 14:59:30 -0400
Received: by mail-ot1-f48.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso21353278otu.7
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRa6wX1MVldIA8Fa+LtawSGl9YE6EAr/FlUB+aSsiYE=;
        b=jYtZ/ygySROlu3CXd+BdSJkMIf/IvsECDPoM2VqihMFMiXji5JlLQ4I33aImz5nogp
         XMXMvu7BRsAMWEz7zksjD7CAr9PYAbfHEdziCwxCwY/MEXQSDPlJQ4btrpGzhRuth6e5
         fAEKARN1klvYOPJlWtvW5KPrEVRbHLxai26ZQQVXFVvJo9qhtilEQaPZntJnkTTgBN42
         xB3BlpLciETohX8uj/pRaJLisIMzy3zJP2gNJkjk9ezCifeZfFAmgloKQwjd9Ty2bXde
         kwCNRKonaDFhs9i0bS9m3B1Qli+peLbcdF869DzON3pxmBKHLwIrfjl453coTn6FAarf
         nQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRa6wX1MVldIA8Fa+LtawSGl9YE6EAr/FlUB+aSsiYE=;
        b=RIHcnknPoDQRGWKgl1e25rfJjmbXhkVxStSk3fI6YB0dIPZuVmrp8/FgAjNpK+/Zwe
         vVEXLP3s4WokItj5FBPLzwTr99wYolXD0R6gEbIysZcwq/tUrFH4v5h6X+jNcQcJm10I
         mDhQI720ebJKFj13vqgh4u5I80oS1q3geFehFzSMqsa6Cye+if6aFu3w8O6gW7OhoGRg
         mkNCeTFRL5ClxrrYbbtoRMReM79j8G3G10nvWWWo0Ozs9pAivP3miaHGsf5ijL1Mg7DE
         oGbkBaHmZkK6o6ncMHNGUzTTn0EWETOhWuB8lQ+wZkxL7U3YcdvqMqLQMof9UOTaoIiY
         kuTg==
X-Gm-Message-State: AOAM531nUdKr3xnsYFh17ib6C1HBKaaBViXgGuGLPqPBoiW39+mqKZKd
        Zx7pyuhqCnPq3JSZ2TQt/26TIS3fTEnMIGnObXLJrD4+8V+riQ==
X-Google-Smtp-Source: ABdhPJz602Ty2OL0i5kjIkAVLDijXdXvHk1b+SVOGvJpg2edXKTmgqtUSViPebVaO0QLc5FUs6ZhwKGWKXXOmkXcQ4o=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr5373950otn.345.1623178580273;
 Tue, 08 Jun 2021 11:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com> <8aa41e749471df3bd9d593b8f55db6506eafea12.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <8aa41e749471df3bd9d593b8f55db6506eafea12.1623069252.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Jun 2021 11:56:09 -0700
Message-ID: <CABPp-BGrAU==rEjtX5DNXs05_pcSVzAZBTFxGgGEA+xUO1oS1Q@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] sparse-index: include EXTENDED flag when expanding
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 7, 2021 at 5:34 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When creating a full index from a sparse one, we create cache entries
> for every blob within a given sparse directory entry. These are
> correctly marked with the CE_SKIP_WORKTREE flag, but they must also be
> marked with the CE_EXTENDED flag to ensure that the skip-worktree bit is
> correctly written to disk in the case that the index is not converted
> back down to a sparse-index.

In our previous discussion on this patch from v3
(https://lore.kernel.org/git/cb9161ca-dc6e-b77b-1a41-385ed8920bb2@gmail.com/),
you said you'd explain the reason for this change in a bit more
detail, but the commit message has not changed.

Could this be corrected?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  sparse-index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index 1b49898d0cb7..b2b3fbd75050 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -222,7 +222,7 @@ static int add_path_to_index(const struct object_id *oid,
>         strbuf_addstr(base, path);
>
>         ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
> -       ce->ce_flags |= CE_SKIP_WORKTREE;
> +       ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
>         set_index_entry(istate, istate->cache_nr++, ce);
>
>         strbuf_setlen(base, len);
> --
> gitgitgadget
