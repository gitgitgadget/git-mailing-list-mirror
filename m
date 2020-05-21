Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04FFC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 06:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8691520829
	for <git@archiver.kernel.org>; Thu, 21 May 2020 06:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRAbp8bI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgEUGPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 02:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgEUGPD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 02:15:03 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F872C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 23:15:03 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z3so4659983otp.9
        for <git@vger.kernel.org>; Wed, 20 May 2020 23:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O2Xj0RkbOS8/4FeozNkE0icb6OjUYxLHMkSMl9oZtOA=;
        b=JRAbp8bIgsFt7HbxjdildAWsZp4oTqGMEO4/hAdRmMCa3IfGCduMWNhtgNxRnaSDCY
         GE7OI4ZgaypYr5qMG63MOUCTQlBI57z1z8wHothfpylQZzbz+mMsQiC0REj/c8Oj/p2r
         f/FVXUKIvAUKc8CR6QAJCkWPRycsXg2zwNeqXpTEfx3VWvucYk6PYapWp5J3lUrRA+QO
         jG3P7M5kWBpkaYxRyU0JrHGoOkngA7AE4/ODqLMtxu7mXfYlsGfCAzVoI18+QH/507qv
         AHzVysBzntTsUx8Zud4c6No16ehbC+lvVM8xb0FhivVJ3JfkA9mlUHPR+4YINFPjlTSh
         exuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O2Xj0RkbOS8/4FeozNkE0icb6OjUYxLHMkSMl9oZtOA=;
        b=FEAdCjrLFqPvA5bR5cVV62C2BNYIacZpTf0C0wRDASFccmEAS3eTP964PqtyS8WH28
         /VmMkzEqCWnTuyYXh3xQ2L+yvaEfAg9rjqSCbq+6qjZAemjRbjj7/b2xfQTSDBeCkhLW
         bWQMJDjzNQlwVX4wCHG/sG93xnVHmDHQ5pn6qJIlCuGu8FD4R4I8Uxopvw0P+P0qCUTd
         /Twf9idsBQThUs+2L183a+H1BK4sIWyMAGZg98TYg4KmjU1V71azWEZ2Bs0CpLSWGbsm
         /GP8Sn+qasrIIAsWKff73YHBMU2ApOqYHqgtll3sXIuwtXf31EMn53Dl2j3FQboq7uyH
         S+Vg==
X-Gm-Message-State: AOAM530mckxAP9PvYIp9hcs4YPzAz2jNobiMBYNpR8XAzBnMpfHTFyB0
        0Nn5Me8iI0pG4ApKjtb61wyTd6HKYjrcFJbHzUD73fTIynQ=
X-Google-Smtp-Source: ABdhPJwaz+yjr+D1VimzE8v9Lsi1+cHV48xIneaLI14qZSuto1MmtzO/61CAbTi6XYBNmoOHIz4BoRWa3Lp2B/94a3k=
X-Received: by 2002:a9d:24e5:: with SMTP id z92mr6114188ota.345.1590041701887;
 Wed, 20 May 2020 23:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.641.git.1590041164665.gitgitgadget@gmail.com>
In-Reply-To: <pull.641.git.1590041164665.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 May 2020 23:14:50 -0700
Message-ID: <CABPp-BG30_bxNwFWNMMEJDbCrExOaAs5vvaGcydLB1gMxSHXzw@mail.gmail.com>
Subject: Re: [PATCH] doc: sparse-checkout: fix mismatched sq
To:     starlord via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        starlord <bojun.cbj@gmail.com>,
        "bojun.cbj" <bojun.cbj@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 11:06 PM starlord via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: "bojun.cbj" <bojun.cbj@alibaba-inc.com>
>
> Signed-off-by: bojun.cbj <bojun.cbj@alibaba-inc.com>
> ---
>     doc: sparse-checkout: fix mismatched sq
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-641%2FB=
erger7%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-641/Berger=
7/master-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/641
>
>  Documentation/git-sparse-checkout.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sp=
arse-checkout.txt
> index 1a3ace60820..7c8943af7af 100644
> --- a/Documentation/git-sparse-checkout.txt
> +++ b/Documentation/git-sparse-checkout.txt
> @@ -70,7 +70,7 @@ C-style quoted strings.
>         `core.sparseCheckoutCone` is enabled, the given patterns are inte=
rpreted
>         as directory names as in the 'set' subcommand.
>
> -'reapply::
> +'reapply'::
>         Reapply the sparsity pattern rules to paths in the working tree.
>         Commands like merge or rebase can materialize paths to do their
>         work (e.g. in order to show you a conflict), and other
>
> base-commit: 87680d32efb6d14f162e54ad3bda4e3d6c908559

Thanks for the patch!  It turns out that this one was already
submitted by Martin =C3=85gren over here:
https://lore.kernel.org/git/69faf4d317547143f455321c5a70575cb7b0b0ad.158973=
9920.git.martin.agren@gmail.com/

Glad you all are fixing up my mistakes.  :-)
