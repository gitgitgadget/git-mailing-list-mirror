Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A0B21F803
	for <e@80x24.org>; Thu, 10 Jan 2019 21:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfAJVBk (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 16:01:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36120 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfAJVBj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 16:01:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so400783wmc.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 13:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4mksZeKuvaSqM4gABSWP8djEbUAmOAUR8sjaa5pptM4=;
        b=OTdccxnN2a0RQy9gRoB8D1NYsTpA26ETbSx2ijdWNOmUACrT58l5K6CFJ2OOvXl9T5
         q4IhAL6VEjr6n3iU9EPNgd9cYJOfqsb4ARTU0/zxWm8gZi/BnxwkjEwsRsxEYYPIqWAJ
         7zZYi+xRIMT2A0aj8T/vo6aN4T+ZUbWPTBXnzFDQzMxv18dLz8DxG8vYSOp+YdddWmNR
         ykAnVk75F9N7fauwf1qjcX0lDnHvO5BxoONii3Guf/VzqOq6EJR24C7gRDxAPG3oa6pL
         8ZNihbxU9Eyhy62cO8FMpg7QEsKcmomlV1gGrKzpeOn0xThk0nfGzbcNmZ7O5bxxOcnx
         7yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4mksZeKuvaSqM4gABSWP8djEbUAmOAUR8sjaa5pptM4=;
        b=Fi0enllWEYGvjdJ7j18zKLOJU6P3sGIiYvsoHUaTT615OKsW0PrK6hWRRtuIQVr8t/
         hqkdXPrAXg9XfWPxxNMCnllS5aBlCGpYb39npi5mdSsJtMLeB2NFbgxVa70Dr52kwkq1
         mmyTT0m4b7aYvcw/v8KwGsNwaZrnHuSkQi2ZdHXBkr4THgIzub1UA556KWyMJRc01nEg
         TY0ihTEV1KaVBhokYLJX4npzKLqEuSayvMjFx9rMDlGWvHOMtZCC7krNPz+5mQevXxDt
         ShaJUHzuJrEk0LQwxU9A4U08rXyJl0Dsl+iDt1LMqU1NDHLdCx2lZsPYDMRUfR9rs9z4
         1oTQ==
X-Gm-Message-State: AJcUukeJynUZBetlxgYxIIHVlUU21jB9NnjQX2fhX4bXjTCsWUiWmjSi
        VGhgprU8MlrmOBWL63ZH+O0=
X-Google-Smtp-Source: ALg8bN4zaDCAu90csTf+L7E3jLsCpRyW2VrC5vckfufpuFRtZxN5SrHw8TCptTQBsqhCEoxaxCkajg==
X-Received: by 2002:a1c:ca15:: with SMTP id a21mr308619wmg.132.1547154097480;
        Thu, 10 Jan 2019 13:01:37 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c13sm64805340wrb.38.2019.01.10.13.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 13:01:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] gc/repack: release packs when needed
References: <pull.95.git.gitgitgadget@gmail.com>
        <7eee3d107927b30bd3e1ec422e833111627252ce.1544911438.git.gitgitgadget@gmail.com>
Date:   Thu, 10 Jan 2019 13:01:36 -0800
In-Reply-To: <7eee3d107927b30bd3e1ec422e833111627252ce.1544911438.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sat, 15 Dec 2018
        14:04:01 -0800 (PST)")
Message-ID: <xmqqmuo81b2n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On Windows, files cannot be removed nor renamed if there are still
> handles held by a process. To remedy that, we introduced the
> close_all_packs() function.
>
> Earlier, we made sure that the packs are released just before `git gc`
> is spawned, in case that gc wants to remove no-longer needed packs.
>
> But this developer forgot that gc itself also needs to let go of packs,
> e.g. when consolidating all packs via the --aggressive option.
>
> Likewise, `git repack -d` wants to delete obsolete packs and therefore
> needs to close all pack handles, too.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/gc.c     | 4 +++-
>  builtin/repack.c | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 871a56f1c5..df90fd7f51 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -659,8 +659,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  
>  	report_garbage = report_pack_garbage;
>  	reprepare_packed_git(the_repository);
> -	if (pack_garbage.nr > 0)
> +	if (pack_garbage.nr > 0) {
> +		close_all_packs(the_repository->objects);
>  		clean_pack_garbage();
> +	}

Closing before removing does make sense, but wouldn't we want to
move reprepare_packed_git() after clean_pack_garbage() while at it?
After all, the logical sequence is that we used the current set of
packs to figure out whihch ones are garbage, then now we are about
to discard.  We close the packs in the current set (i.e. the fix
made in this patch), discard the garbage packs.  It would make sense
to start using the new set (i.e. "reprepare") after all that is
done, no?  Especially, given that the next step (write-commit-graph)
still wants to read quite a lot of data from now the latest set of
packfiles...

>  	if (gc_write_commit_graph)
>  		write_commit_graph_reachable(get_object_directory(), 0,
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 45583683ee..f9319defe4 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -419,6 +419,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	if (!names.nr && !po_args.quiet)
>  		printf("Nothing new to pack.\n");
>  
> +	close_all_packs(the_repository->objects);
> +

On the other hand, This one is added to the ideal and perfect
location, I think.

Thanks.

>  	/*
>  	 * Ok we have prepared all new packfiles.
>  	 * First see if there are packs of the same name and if so
