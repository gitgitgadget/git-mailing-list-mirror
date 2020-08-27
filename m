Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B5AC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B142A20786
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNnkCH1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgH0TFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0TFI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:05:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF07C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 12:05:07 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t2so6171212wma.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNW2nAMCfU9SuA94gRQ+AxWcz9q5Vslqh8nTdoIf98k=;
        b=ZNnkCH1YSk2arKBv3vAvi7yDEXOydXBs8BA2DRT14p3EPV2LiuNtucITN1NkcyxYmK
         F0tSU6YMFZMT85zK4PhQiiwFAuQfJ2wdlRx6pHZa4qzT3OfTBBwt3IqxbhfeCRYtB9dB
         e2I86tllK626cCCyX9HdRDiNChGmsns9NfvMiq+b5GSCxhRGHXHUIT+y5l6PDSuVDMyu
         pry8tPkuUM10FNPrz9HPDkVSCTm9H/jJqFxfCIUCXvwxe5bIDI9x96yWpif+4s3nm5qj
         1alP2DdZ8ijRClmar69sqeC/tqeZjwmTS6xMhVec+hRyPJ95SQ2JDJgTY4HdOkijhFpd
         UASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNW2nAMCfU9SuA94gRQ+AxWcz9q5Vslqh8nTdoIf98k=;
        b=o+XS4+8G7h7JPDCZZQcNFJ1EfL5PC811VlO5hJu5SCqbDp9Txrf1GTUKyll65KZ57u
         NejAIfCsucR1M0/k9V9m4j3l495srHADE5THMHgbGsiAtFh4KtCXxrrEEggSRb6SUW2p
         DN3qbQkAgBVh+shpoxaGk5WIYcuL6+LIClaQ7Xk50HPwY6UYISF0mMbnRLIwULw/sFXT
         h4qPS7BUcoJRKkts6+zMvl71XpMh5k51JvL1MHdoK5tXBt5GtBjKu595HxwnraZDxC0A
         tK2K9NUpUI0hxQfhjVfcBJL/tCquMb1khpw3uUajg0pWMYEcjzWk4g6WgmX/YlqH63JU
         cj6Q==
X-Gm-Message-State: AOAM5300xaZPZe+I4vF93sczxL/C9LGgDKl0iFfJN3l4BYsmmSO76waA
        8+RZQnVaif4jZaSzQilSf5DgvpmMMeDxHET33oI=
X-Google-Smtp-Source: ABdhPJxW1XcOPEzGh+zFFqsW8esmo/YA/R+6u1yAhCG1RBFW4hPNvc7aDO05G5FN/BAGzvDkRKxSL0/zs7aevSvoy9I=
X-Received: by 2002:a1c:4685:: with SMTP id t127mr269325wma.119.1598555103585;
 Thu, 27 Aug 2020 12:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
 <xmqq7dtlt080.fsf@gitster.c.googlers.com> <xmqq3649szs8.fsf@gitster.c.googlers.com>
 <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com>
 <CAPx1GvfSt=s5VP9_+ZtndHWaBZ5W7nFxAf8bTF2tXnJkS95Dfg@mail.gmail.com> <xmqqzh6gqe7i.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh6gqe7i.fsf@gitster.c.googlers.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 27 Aug 2020 12:04:52 -0700
Message-ID: <CAPx1GvfXOMFDsXE74LiG_BG5Bqb+seHDWX69xGe49C240ORi6A@mail.gmail.com>
Subject: Re: post-checkout hook aborts rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tom Rutherford <tmrutherford@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 8:51 AM Junio C Hamano <gitster@pobox.com> wrote:
> I still suspect that the checkout run, merely as an implementation
> detail of rebase (or any other git subcommand), should not trigger
> any hook ...

The *last* checkout from the finished rebase perhaps *should*, but
other than that one, that seems logically correct.

> but before any such code change, at least let's update the
> documentation to clarify what we mean by "the outcome".
>
> Hopefully something like the below may be a good starting point?
>
>  Documentation/githooks.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 31b601e4bc..cf95d6d02b 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -193,7 +193,9 @@ worktree.  The hook is given three parameters: the ref of the previous HEAD,
>  the ref of the new HEAD (which may or may not have changed), and a flag
>  indicating whether the checkout was a branch checkout (changing branches,
>  flag=1) or a file checkout (retrieving a file from the index, flag=0).
> -This hook cannot affect the outcome of `git switch` or `git checkout`.
> +This hook cannot affect the outcome of `git switch` or `git checkout`,
> +other than that the hook's exit status becomes the exit status of
> +these two commands.
>
>  It is also run after linkgit:git-clone[1], unless the `--no-checkout` (`-n`) option is
>  used. The first parameter given to the hook is the null-ref, the second the

This looks good to me, and can either be independent of, or the first part of,
any rebase update.

Chris
