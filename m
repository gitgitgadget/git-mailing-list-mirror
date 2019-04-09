Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A43220248
	for <e@80x24.org>; Tue,  9 Apr 2019 11:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfDILBq (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 07:01:46 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50660 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDILBq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 07:01:46 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so4166554itk.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 04:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ntZ453/tl8nY3gTvdaXt58QXG5M7FCy7cFScUrB5s2U=;
        b=kuAjckANmySobB48z2BwVlqYrnZmTGK/dBXQreZ0SmyXDsbCezkrr6qYqTm90VDsno
         G8dx6we+zYsMXVwjaMOb7fvljAelPGlkWz5WoV62Yp+7MyTJUT/y4ftygnRrotCbRzpt
         B4eY4cxU5UlP+5AuWKr51k4Bc2g10FALNj7KxeK57BM76Ra9aO7HmeQjVu0xnienWv4N
         IGduCTT0mUoN1vYvdPIpYCaY3HzGJpf1KaGIRo2rjrqmxaEYdh+Ha20kSsVS94XnNbeF
         YEUA+TM1Mq7Gg8dJyVqfmZZE1fGnFwHmoQq0sJfYsD2zQATTHJmFkVOHUTZOU8VqY3kj
         zUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ntZ453/tl8nY3gTvdaXt58QXG5M7FCy7cFScUrB5s2U=;
        b=O5Schi0q6qdNgsQTXz1DOwWAUMzxB04PyqpsKWiSp8kPjKpXvRkKAzmeYeTQf3Wkyn
         Wyj0eNxLkRc9bgu+jzfMTkAoizqS0bB+CxcrPu5RP/69ziAQGmI9qyGZKK/i0wATEOsI
         Yx0oGAg82efIjJl2D/2HSUoNuvGTU2yUk5WzU1t2jnxgQWgszY0YtsW39v+eVuF2M4a7
         R1niBwbUFO5W2mI8nZlJjvXnBmmC9eY4FgIC2nnw6nfRfza7UUFQa3ftGvQwUZRbPvQp
         Nx9xRLaGSdVvdKI/R4kIFWEaf4xNU2EMaC0uuMqXZSGKhaKunO0Mhjxv8bHGdqQBcoiU
         jRsw==
X-Gm-Message-State: APjAAAXAl8I7OBqJmys18uiaKp0tmx6jZ7eoCqDAxWuTmRUbMX+3lx2N
        aeHztwmrjHcYp1jlAO8xHb7m6xjqjJ+2FWl/1Bg=
X-Google-Smtp-Source: APXvYqxQjUidT6DmBJWG1IUWvsu0dQFuQBvdm9vk+Czc2oC/9j9eHgd16+pKD7vNKTohXuL7XNtCFN/VmiBAc8/8IyM=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr22513718itb.107.1554807705525;
 Tue, 09 Apr 2019 04:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEMQ6K7j2M1CSv9uCF8aDQK6+PmTJi-XgFNy+McE9f7OsQ@mail.gmail.com>
In-Reply-To: <CAMknYEMQ6K7j2M1CSv9uCF8aDQK6+PmTJi-XgFNy+McE9f7OsQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 9 Apr 2019 18:01:19 +0700
Message-ID: <CACsJy8AwS0De_xjkTpcU=Crpgen3+OfQRh=CPwZAc6YxCUUc=g@mail.gmail.com>
Subject: Re: [GSoC] [RFC] stashing unmerged index entries
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 9, 2019 at 3:16 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
>
> Reference: https://git.github.io/SoC-2019-Ideas/#teach-git-stash-to-handle-unmerged-index-entries
>
> "When the index is unmerged, git stash refuses to do anything. That is
> unnecessary, though, as it could easily craft e.g. an octopus merge of
> the various stages. A subsequent git stash apply can detect that
> octopus and re-generate the unmerged index."
>
> according to it we take the unmerged entries (caused by conflicted
> merge) in index from all stages, and do an octopus merge. how does
> this solve the problem, i mean where do those entries go after octopus
> merge ?

I'm not even into git-stash, but it does sound like it solves the
problem, which is _restoring_ the conflict after you unstash. Since
you have all the unmerged entries in the merge (which is stored in
some stash ref), you can safely destroy all conflicts in worktree and
put it back to a clean state. When people want to apply the stash, you
re-generate the unmerged index from the octopus merge.

> a conflicted merge is still there,

yes, but because you can restore it later now, you can remove the
conflict safely. That's what git-stash is for.

> do we store the merge separately ?
-- 
Duy
