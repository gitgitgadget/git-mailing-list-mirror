Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 746981F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeGPT0x (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:26:53 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:45423 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeGPT0x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:26:53 -0400
Received: by mail-yb0-f193.google.com with SMTP id h127-v6so15828771ybg.12
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hkje60QK2CFkHb2vEdyNe5DDl9+wa2UG7EfbXiMHpJc=;
        b=s2/ypDksrvRNd/awtw6mABC9tY3UOgforFvPl8gqkyWWEhIJKO2n+WWLVOgM0t90sG
         Xc0ueoXZ+gDJVngWQ/yaTIsTZsqJghXGapB930J67Nzl0LqmhcSF9Di2YhlkUg3smi2y
         R0RKHZh3O+Ou1xzBXoSS8WkHlH/CRyCG4NvtVEXfnfi1nyuqpp9uCjwLSkdK0KPSXHOV
         zyRTbz+PALd7QhRcD47JiFpwv/uXgVTgMh85yI/BFRKp5lR9C6Ozp847gUAG7qbIoxma
         1E20lJb1HNjuZC9oNXmv4TYBPUJ11MBKnWIf0iNk19mRNvpmPy8iBYzkq0PPExmslDRB
         mn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hkje60QK2CFkHb2vEdyNe5DDl9+wa2UG7EfbXiMHpJc=;
        b=UzBjTmI7OHM4+4ZnysqIQ7CzqnVY6CSrPinfcoMy+bWOybRnjrDqiEbME27XD2JV56
         Ho7kV5jTD0tbME5IjVt3frkQkhrGmOO8Y8bdi4xkXkm8ZfYvglSpfc2yzRolpAM9nsFq
         0uvqGIRmN/sxCBAFjea8xIEVyXFz5GGm2a9f/IQu5TajhO48Pi6GDd08QtJraHPZAXCR
         XeZSwlnegQQ4w6QHskTT6eoSuGMK8pnnbEGgfuwaXg6PHPwuPMUOvnTiUK6sFnP999OZ
         bJVBpDtk8LzcCmDkijGIP6+aw4j8HLvKkbqxe3txvOAnfE+Xqx3J22Zd6zr/kRQU2p/n
         tsYw==
X-Gm-Message-State: AOUpUlEfbsEzmtrNpkzMXJ9SQOfS8YLixN3IojSSL5jSVVxOUetCcoVt
        vQMDLs/6XZZ+z94WfdAOC6WwuFFOevte0c7rwd6dkw==
X-Google-Smtp-Source: AAOMgpdxs4kvRk7M4mq9D2h+x76myrTTYn/4B48hnDzONiD2Bj2Dlq4pzYSc/S/s66hX8XwtBBzic8oSyGXf2UDoCXI=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr9459099ybi.247.1531767488631;
 Mon, 16 Jul 2018 11:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <01bef3d654845236e9115ebc33d80673b7b4a5a2.1531746009.git.gitgitgadget@gmail.com>
In-Reply-To: <01bef3d654845236e9115ebc33d80673b7b4a5a2.1531746009.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 11:57:57 -0700
Message-ID: <CAGZ79kYjshSeZFoxqn9eY8A6X5p+WSrpwV-YSj2kZ9MX2K2Yqg@mail.gmail.com>
Subject: Re: [PATCH 01/16] commit-reach: move walk methods from commit.c
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 6:00 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

This looks good, apart from nits below.

Thanks,
Stefan

> diff --git a/commit-reach.c b/commit-reach.c
> new file mode 100644
> index 000000000..f2e2f7461
> --- /dev/null
> +++ b/commit-reach.c
> @@ -0,0 +1,359 @@
> +#include "cache.h"
> +#include "prio-queue.h"
> +#include "commit-reach.h"

and commit.h (see discussion below) ?

> diff --git a/commit-reach.h b/commit-reach.h
> new file mode 100644
> index 000000000..244f48c5f
> --- /dev/null
> +++ b/commit-reach.h
> @@ -0,0 +1,41 @@
> +#ifndef __COMMIT_REACH_H__
> +#define __COMMIT_REACH_H__
> +
> +#include "commit.h"

Do we really need to include the header file in another header file?
I'd think forward declarations would work fine here?
(The benefit of forward declaring the structs commits, commit_list
is purely for the poor saps of developers that we are, as then touching
commit.h would not trigger a compilation of files that only include this
header but not commit.h. That are not many in this particular case,
but I consider it good practice that we should follow)

> +
> +struct commit_list *get_merge_bases_many(struct commit *one,
> +                                        int n,
> +                                        struct commit **twos);
> +struct commit_list *get_merge_bases_many_dirty(struct commit *one,
> +                                              int n,
> +                                              struct commit **twos);
> +struct commit_list *get_merge_bases(struct commit *one, struct commit *two);
> +struct commit_list *get_octopus_merge_bases(struct commit_list *in);
> +
> +/* To be used only when object flags after this call no longer matter */
> +struct commit_list *get_merge_bases_many_dirty(struct commit *one, int n, struct commit **twos);
> +
> +int is_descendant_of(struct commit *commit, struct commit_list *with_commit);
> +int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit **reference);
> +int in_merge_bases(struct commit *commit, struct commit *reference);
> +
> +
> +/*
> + * Takes a list of commits and returns a new list where those
> + * have been removed that can be reached from other commits in
> + * the list. It is useful for, e.g., reducing the commits
> + * randomly thrown at the git-merge command and removing
> + * redundant commits that the user shouldn't have given to it.
> + *
> + * This function destroys the STALE bit of the commit objects'
> + * flags.
> + */
> +struct commit_list *reduce_heads(struct commit_list *heads);
> +
> +/*
> + * Like `reduce_heads()`, except it replaces the list. Use this
> + * instead of `foo = reduce_heads(foo);` to avoid memory leaks.
> + */
> +void reduce_heads_replace(struct commit_list **heads);

Thanks for the docs! Bonus points for also documenting the
other functions (is_descendant_of etc. For example is
is_descendant_of destroying some bit state?)

> +#endif
> diff --git a/commit.c b/commit.c
> index 39b80bd21..32d1234bd 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -843,364 +843,6 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
>                 clear_author_date_slab(&author_date);
>  }
>
> -/* merge-base stuff */

This is the only line that did not make it to the other file. :-)
I don't think it is needed in commit-reach.c
