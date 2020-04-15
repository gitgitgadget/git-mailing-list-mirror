Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECBCC2BB1D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 03:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5572076C
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 03:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOJJzZOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389498AbgDODOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389496AbgDODOc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 23:14:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B48C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 20:14:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ng8so6190403pjb.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 20:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sndFjya0/gBPeKKhKFLFqnZ8axna7fHIVAg/e/QEas4=;
        b=UOJJzZOYpSFf590OiMy453P2/PjPET7LcMKzc+ikSLIv+EN9iZznJU8x4DTJAoTM+k
         pPpgIZ3hsG6cSA1Gn50CDr5b8MC09ZCZNxrvnA2NfNpT3sQOfQBlyExlWXVwwJnW7+x7
         lriMnbUDVOzbcAJ/6E4Qc0fbmqAVpjzi3DF46um6LNQo9RzXbY6jQPn3Ziv7zknAoMXQ
         WHnmC+c/NGQNaLaRqZ4o8fblfW+zj/UNvjbN10xSq4YuoF+NEY4FwRqp5YWfJQkCos5e
         SAnAk9fNDas8iJfq3h3QwmbGYUF/L6gHgapFXl1vtzwgamhGcO1uvWkhgCcbycRSBB7K
         zOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sndFjya0/gBPeKKhKFLFqnZ8axna7fHIVAg/e/QEas4=;
        b=FNnqCAvcOmUHIQFL55YqZCu3B7KkAgf0Kdxo+ja2n9iax15fmB1Qd6sXcPV0nn2dym
         Pm+JzW+Rl9ZFT9bOTCek+1Up4aszaSVv/8lcLfaJfps88/yzZhBBL9R5HYCiB6NBd92C
         g+uH1hH3aIkejSoBmyCYc4/42D2Ce2i+S5Vie1jK4QgdTZkXFoHrecAXmB7InpQo9BM8
         ATN04HTAjCG0Ny/ORCh7Cfzyk6oI4H3skP3N04nCmVLvSgYoJWYjdwqGthBOTWP6zmE0
         uRLMXoDN6UNws68clVciC4B2gDVC2+OQhocWN7CH5Kjt+OaGyt7D+hQIKtiBTJTbDUNM
         dRzA==
X-Gm-Message-State: AGi0PuaDVhe3UcnzQ9WT9fuySQpJL/z6XviseAMk7QVBiUhSJgNkKexf
        POCimElniMBBXu4sa0XpnNI=
X-Google-Smtp-Source: APiQypINwl/2gTGOb8Z9H7jlH4BhDS9wUgiflZT460jN89ONZcHrln4XGvGy9zP1o7jOj+ao1jEqng==
X-Received: by 2002:a17:90a:d154:: with SMTP id t20mr3628852pjw.133.1586920471973;
        Tue, 14 Apr 2020 20:14:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id ih15sm13086123pjb.27.2020.04.14.20.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 20:14:31 -0700 (PDT)
Date:   Tue, 14 Apr 2020 20:14:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kazuo Yagi via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kazuo Yagi <kazuo.yagi@gmail.com>,
        emilyshaffer@google.com
Subject: Re: [PATCH] doc: fix the stale link to api-builtin.txt
Message-ID: <20200415031429.GA36683@google.com>
References: <pull.647.git.git.1586882575822.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.647.git.git.1586882575822.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+Emily Shaffer, author of the related MyFirstContribution tutorial)
Hi,

Kazuo Yagi wrote:

> From: Kazuo Yagi <kazuo.yagi@gmail.com>
> Subject: doc: fix the stale link to api-builtin.txt
>
> ec14d4e had moved documentation from api-builtin.txt to builtin.h.

Micronits:
- use "git log -1 --format=reference"
- changes due to previous commits go in the simple past tense, like
  "Commit ec14d4e moved [...]"

> This patch updates new-command.txt to reflect that change.

nit: describe what your patch does as though you are giving orders
to the codebase to change. Focus on what benefit you are trying to
bring about.

> Signed-off-by: Kazuo Yagi <kazuo.yagi@gmail.com>
> ---
[...]
> along with the changeset history.

This part didn't make it into the commit message, but I think you
intended it to do so.  Putting that all together would make

	new-command doc: fix stale link to api-builtin.txt

	ec14d4ecb55 (builtin.h: take over documentation from api-builtin.txt,
	2017-08-02) moved the documentation for Git's builtin API to the
	header file. Update the "new command" how-to doc to reflect that
	change.

	While we're here, add a historical note to builtin.h.

[...]
> --- a/Documentation/howto/new-command.txt
> +++ b/Documentation/howto/new-command.txt
> @@ -1,13 +1,13 @@
>  From: Eric S. Raymond <esr@thyrsus.com>
>  Abstract: This is how-to documentation for people who want to add extension
> - commands to Git.  It should be read alongside api-builtin.txt.
> + commands to Git.  It should be read alongside builtin.h.

Makes sense.

[...]
>  How to integrate new subcommands
>  ================================
>  
>  This is how-to documentation for people who want to add extension
> -commands to Git.  It should be read alongside api-builtin.txt.
> +commands to Git.  It should be read alongside builtin.h.

Likewise.  It's probably worth pointing to Documentation/MyFirstContribution
as well, which is a tutorial covering this subject in more detail.

(Actually, would it make sense to incorporate the information from
howto/new-command.txt into that page and then to retire the old
new-command doc?)

[...]
> @@ -48,7 +48,7 @@ binary); this organization makes it easy for people reading the code
>  to find things.
>  
>  See the CodingGuidelines document for other guidance on what we consider
> -good practice in C and shell, and api-builtin.txt for the support
> +good practice in C and shell, and builtin.h for the support
>  functions available to built-in commands written in C.

Most support functions are part of other APIs, so this was a strange
pointer in the first place.  But the change makes sense.

It's also a bit odd that this doc doesn't mention SubmittingPatches.

[...]
> --- a/builtin.h
> +++ b/builtin.h
> @@ -92,6 +92,31 @@
>   *
>   * The return value from `cmd_foo()` becomes the exit status of the
>   * command.
> + *
> + * Changeset History
> + * -----------------
> + *
> + * The following describes how the documentation has finally been placed
> + * in this file, over the related changesets.

*puzzled* Why is this information being added to the builtin.h file?
What is the reader trying to do when they read it?

Thanks and hope that helps,
Jonathan

> + *
> + * +-----------------+ *OLD LINK*  +-----------------+
> + * | api-builtin.txt | <~~~~~~~~~~ | api-command.txt |
> + * +-----------------+             +-----------------+
> + *    |                               ~  *  |
> + *    | deleted,                     ~  N   | moved and renamed from
> + *    | contents is taken over      ~  E    | Documentation/technical/
> + *    | by builtin.h               ~  W     | to
> + *    | (this file)               ~         | Documentation/howto/
> + *    |                          ~ L        |
> + *    |                         ~ I         |
> + *    v                        ~ N          v
> + * +-----------+              ~ K  +-----------------+
> + * | builtin.h | <~~~~~~~~~~~~ *   | new-command.txt |
> + * +-----------+                   +-----------------+
> + *
> + * ---> moved to(or renamed to)
> + * ~~~> refers to
> + *
>   */
>  
>  #define DEFAULT_MERGE_LOG_LEN 20
