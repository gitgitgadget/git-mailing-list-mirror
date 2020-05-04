Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC8AC47257
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F87B21835
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvzqvRiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgEDRLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730344AbgEDRLq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 13:11:46 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6D5C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 10:11:46 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o24so7308429oic.0
        for <git@vger.kernel.org>; Mon, 04 May 2020 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zumafxGA4jehSk85DD0P9S+0wRpvlbk8kjPnf9dKIQ=;
        b=nvzqvRiGs/ohf2/cKHepHrL2uPkdJu2lVtZkdmHrqKYmsW6yCM44c6BVNmJefoQedF
         9qbwhkxg67ViOTrfkRySOafYWXoPTnzuErFA5RJR+0iwhfjm8IaaMZ06wzmOoqJjRN5Z
         IqrDjfbGalcNoGd8jwkiAlfRb+GugRfbHMKtJ+42cc4T+HibYCgnZhSQXqrG9yoDm/lt
         tPvyR7cCQsE9OVJ3BgKWvvaX46ewvfI6gpH1EiZtYZT+VhNtVxcnbCPa8a2VBEjodtfY
         NKJnO4xcp/TqzCw5jSqMd6FQfloii+PmV8BaG7ychAv6tOGcA8R1P1qxtIzF0gdlFUwE
         ZdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zumafxGA4jehSk85DD0P9S+0wRpvlbk8kjPnf9dKIQ=;
        b=tNrk7b5DEzD8T+yn3oe8kNqTitLuqQ18tRva9NrHLIrbFbTNQaXSl/XhC6Z5Sf8yn4
         2VWQzZbmfONHjYmHdt3mX1uJt8N6IIp25CVtcros1K7t9ba74A3SKG45SpH/h4MA1fe1
         mjr4vB/yksMlQq+2itwr7S4Rf9Xp+e7w/uXVzXBPga1Jt221r/yAuHZag0YTOXblxXsw
         JmesbrIjuMnjR7Zt51+SXd95m5Bp5cCRZQU8DAsHGErCNkwakPuKTv56lE6TXC3uPC31
         m134Kv7e88i62TZgly/r8/TF5n6tbabnT6HR1r+x8iorOLbZT6uqSpWdQvDklVU0JLGH
         dqxQ==
X-Gm-Message-State: AGi0PuYswswmtMdbYGLd9OtG1P9fBySZyrkdSQHFTdxBlUSk9HU5xeTa
        K/TKXF4QhQlM7s6VUhJoSQiB53vrYXgKa9hX+6o=
X-Google-Smtp-Source: APiQypLPA9TwUXvoxP9KhKHWJG5pa3OjnpvfGanHZHiqs2Wo2/8/Q1/gO6+4AdVCOnnqaCfTAHvlrru55aPl1b24fIo=
X-Received: by 2002:aca:5513:: with SMTP id j19mr9261313oib.31.1588612305715;
 Mon, 04 May 2020 10:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200504054223.11125-1-shouryashukla.oo@gmail.com> <20200504054223.11125-3-shouryashukla.oo@gmail.com>
In-Reply-To: <20200504054223.11125-3-shouryashukla.oo@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 May 2020 10:11:34 -0700
Message-ID: <CABPp-BGYh7-kq+J3TZNhfraouNfkj6u_YLaEwD_zUihBae0DUw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] gitfaq: shallow cloning a repository
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 3, 2020 at 10:42 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
> Subject: [PATCH v5 3/4] gitfaq: shallow cloning a repository

Shouldn't the subject be updated as well, since we're talking about
partial clones rather than shallow clones?

> Add issue in 'Common issue' section which covers issues with cloning
> large repositories. Use partial cloning to selectively clone the
> repository.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> I fixed the heading of this section and improved it overall though,
> as pointed out by Junio, there is a bit confusion as to what URL I
> am trying to point to:
> https://git-scm.com/docs/partial-clone
> This is the URL I want to point to.
>
>  Documentation/gitfaq.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 875cfa0acd..5dfbb32089 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -244,6 +244,17 @@ I want to change the remote of my repository. How do I do that?::
>  One can list the remotes of a repository using `git remote -v` command.
>  The default name of a remote is 'origin'.
>
> +[[partial-cloning]]
> +The repository I am trying to clone is too big.  Is there an alternative
> +way of cloning it in lesser space?::
> +       A good way to save space when cloning a repository is by using
> +       `partial clones`.  A partial clone will clone the full history of
> +       the repository but will skip out the entities specified by the
> +       `--filter` option one uses in `git clone`.  Any entity which has
> +       not been cloned to save space can be cloned     on-demand (hence this
> +       presumes that the user has an always-on network connection to the
> +       original repository).  See linkgit:partial-clone[1].
> +
>  Hooks
>  -----
>
> --
> 2.26.2
>
