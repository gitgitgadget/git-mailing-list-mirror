Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE0CC352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 23:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D4E206E5
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 23:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPk/ZjfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgBLXxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:53:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41621 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbgBLXxL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 18:53:11 -0500
Received: by mail-pl1-f193.google.com with SMTP id t14so1558906plr.8
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 15:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sCbcg0efXalXWucqM5IXpbjxQXHCEZ0CK7sZ1GvxnEk=;
        b=SPk/ZjfGqCqHrWvXLdR7wzI5+8NWjOsZZChk4V3jvJPY3je2QVHo3ZO7Jga5slGUum
         psWXHuGlCDP6mNDjBzqvMux+rTAIsSyuOpqNUqisHAhukpACGxOW3BzvwYh6uEVtMeTm
         okEKPgjy24+hS+RXTsw9o6fTTN4gZAJzSXGK6io3Mwao9lqSlv+GT/DHYIdpeieVgy2N
         Djab7ZzUAiSnlLAZSv+l1RlG6wF+zoZ8dCiPheE4sYS8oRcoX92LqgxiP2qXKx9rej5C
         AjGGeRCSjBMBz4esaZiBNwhB4nyU+nuKX3am9WbzQ3DTIU9hJD+0PfwgHRv0BmqhLEhd
         wUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sCbcg0efXalXWucqM5IXpbjxQXHCEZ0CK7sZ1GvxnEk=;
        b=EoVh6/eSExfWvaVcN19tRSQ7VwF3HJWrke2zP2W2txN7CjVZgQiGLZheWqImqu2vIj
         7KO6z57IOaJ4KijTLGl72R1twwr8Pmdl6I+vNHQQAtAv0SMkBW7F/kJZHe+onSds6hFq
         PR8THK9Z3dmSVdurVnUu4vrmLJCThwbiMCVaOjrI0jmcAqdOjVYQM5eXH/Vs+/g0l4pb
         ulOVI86TNHT0EEdaoddg2iA3OjG5kgHxCLRHXsdgP+4vpZQD5l3dE1kTJ6T3P+2LvQnW
         wbserNc0o+qJKfNn97YdkigqMKtoM372WnZfdcB4mKuUePK2wmtV9hEil0RLcl532rdR
         ITlQ==
X-Gm-Message-State: APjAAAXM5+scZcXJ5pfTMtZQqPCtMiRFvzFnOab1OghF5PsDcwHmsGKF
        VnFkmtGH/wiTR+ZAiljFtdSg8bKiEK0ZlT0Jnx9Wobki
X-Google-Smtp-Source: APXvYqyDHKuijxL5J8i+P3vH96SYaEQvAYKHHqjHaO+scSmhzo7LQ5io51K3A9aMqJwiDgsKtHXkbbvTHAjiMsyYMCU=
X-Received: by 2002:a17:902:7004:: with SMTP id y4mr10778188plk.263.1581551590188;
 Wed, 12 Feb 2020 15:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20200212235033.782656-1-eantoranz@gmail.com>
In-Reply-To: <20200212235033.782656-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 12 Feb 2020 17:52:59 -0600
Message-ID: <CAOc6etbkMJf9qSNMU4fD4KeHE6NuMRUuQf_cBos_oxuYwaaeAA@mail.gmail.com>
Subject: Re: [PATCH] [RFC PATCH] stash save/push: add --index-only option
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 5:50 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> Allow git-stash to save only the content of what's in staging area.
> No working tree files (unstaged or untracked) will be added
> to the stash nor will be modified then the opreration finishes.
>

Sorry for the double tag. This is not fully completed code. Wanted to
know if the community thinks it's something worth developing and if
I'm heading in the right direction in terms of the code that I'm
hitting.

Thanks!
