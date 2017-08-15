Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5630208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbdHORLZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:11:25 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34401 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbdHORLY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:11:24 -0400
Received: by mail-yw0-f180.google.com with SMTP id s143so8429743ywg.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vnJj2dKwHuQHMaK41/eICkI/u5WOCi+9qqyQ24xYIyo=;
        b=ce/dYLlzQ09kqiMOyA5UacKRUjeiNdc3kdLqVvbkxQNLZbVUdbTzFr+z6kcDM9RrrE
         Yo2XyUTIDLK7VQbH6mGgIYWLUjLHDPZWYfPq1PiUG7eeX9bQet8xzQW5E/mw7hXAd/nV
         Zz2B2DVHPmMh0ztU97FhNmKR8X7oRZNGfDoQssBLwMCq4ffMIO9K6cLU5Xfr44B6lrgR
         aJXVFZf/co77RKDN8L5MsxR3z8Kgxv6w9qgONcwE7zyflKersXgVFjGz/xi9WE0c6ink
         HiVv6SwspMtBihptzE3uLTZ7cZqHQSpf0Ms/P7x+vEO2k0Ja2ZPQY1Z7GW3Zm55WqPhR
         bJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vnJj2dKwHuQHMaK41/eICkI/u5WOCi+9qqyQ24xYIyo=;
        b=L8zBmcD21p2OfhqrLvjHFQQWZwQQcZKgXJ6/rzdHDGVvF9KhsxyRItKuFLvaqGkyiY
         lcUz5e/oVGNWK3Aj8y6zIlBPKZ4IXUP/0vhqOJqPkYe9ZY6fRPN4fbRYJO+QzJdkhib7
         FXk/aiXaJO1A4cthLeHf6F4R0MXa7TvwULaZNAypoQS2iKHiuyrfvIuNYPaw4PYKmq4+
         goNZogAWucASuNMyLqetL6TKSQ5Cx+e3mQ4pKobamGJqfH9E889SsO298rHM7aHp6Yvx
         +py5pEuyGAkG9LSDjdDjyxCuQi2YP57nAmYEd9mNvRHa/obsKZX+1xyYFTJUxpxaGulr
         SByQ==
X-Gm-Message-State: AHYfb5hGHjFgR34F816yVVWMRdPTuxKhtnL/Vxnzv5nyFvf/FfN5gARF
        /QgjZAd/59gYR3xe8avfRXWIGyJEwqAH
X-Received: by 10.129.93.194 with SMTP id r185mr16879395ywb.33.1502817083921;
 Tue, 15 Aug 2017 10:11:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 10:11:23 -0700 (PDT)
In-Reply-To: <ee8edaf08864d5983ff1a5150077d29a4ee17796.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com> <ee8edaf08864d5983ff1a5150077d29a4ee17796.1502796628.git.patryk.obara@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 10:11:23 -0700
Message-ID: <CAGZ79kbsKLOiLvr8NxRzBDkU44SPtVozUoV7fYUyt3vC=QxWyQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] commit: rewrite read_graft_line
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 4:49 AM, Patryk Obara <patryk.obara@gmail.com> wrote:
> The previous implementation of read_graft_line used calculations based
> on GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ to determine the number of commit
> ids in a single graft line.  New implementation does not depend on these
> constants, so it adapts to any object_id buffer size.
>
> To make this possible, FLEX_ARRAY of object_id in struct was replaced
> by an oid_array.
>
> Code allocating graft now needs to use memset to zero the memory before
> use to start with oid_array in a consistent state.
>
> Updates free_graft function implemented in the previous patch to
> properly cleanup an oid_array storing parents.
>
> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
> ---
>  commit.c  | 39 +++++++++++++++++++++------------------
>  commit.h  |  2 +-
>  shallow.c |  1 +
>  3 files changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 6a145f1..75dd45d 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -111,6 +111,7 @@ static int commit_graft_pos(const unsigned char *sha1)
>
>  void free_commit_graft(struct commit_graft *graft)
>  {
> +       oid_array_clear(&graft->parents);

Oh patch 4/5 could just say it's in preparation of this patch.
Nevermind the comment on patch 4.
