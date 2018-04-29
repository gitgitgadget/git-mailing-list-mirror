Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257411F428
	for <e@80x24.org>; Sun, 29 Apr 2018 18:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbeD2SGO (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 14:06:14 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:43153 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753782AbeD2SGN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 14:06:13 -0400
Received: by mail-oi0-f53.google.com with SMTP id p62-v6so5721855oie.10
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=npVeluz8L+2HmtD/dIeF79Ogrklbjf8lBf9FzlWqOiw=;
        b=FmJFeO+m0bXK4gN3yIgh9e3b2mFW1ZNK95mkbzk3W8/Vb3UX2UC5vimclYbmo19b3X
         oLyU7edIL+NR1oySd91eDPHa/GYHw1mNPog/lr9QA3ABMoZ87ntZmK2Gr5rupyRVoStO
         tmrOaCQYFXrHvLVhk5/5lUwxSQo3+n4nzSMWbZxCACTbdHHlSTK9y4AWpSMuEIM6MzXH
         VnWa+V6zHqK0XAeKxSfXd6onVELQhcKeJiWWdVFCGJEUfj0Muo2R80wJHtRSntLzISvL
         eRj0LnrrjSZ8ybq+Mp0ypqimFNvY12x5hzcMxztmuAhjAPJiEMy8OO61Lp/cHmnyiND5
         PZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=npVeluz8L+2HmtD/dIeF79Ogrklbjf8lBf9FzlWqOiw=;
        b=hyRFTdxZp4K1v0py+quFlwbrJs819eoCP9bVNN9OCNPumDLJ6cfkQk9aWUSmz6KLa1
         CN5N1XWqzICyQdX/XDh6L7sG1ZiNCBfruky0FpZLoCF7mvGRR37NnyAX4NETMG/jiS9t
         JOol2k5SU/fuuVe/vuibYnkFLUh+dPKX8Xko242V7egC6uzEDcpVO4rwXboNfyezA22/
         6J9x4kXbVLVVTasc2dhuqOqQXNgLQqB8rLT1bBCzQNk2HRs+R0eHyT40D5CaP55BHfkg
         xnxuhwAfY7CL22tFq4aMEZPkSj5eNep+zcXP57eQyGdHCWRIsUakY5QFKiO/CyX002n1
         NnZw==
X-Gm-Message-State: ALQs6tAyz+dYgdvwxNEGVTTK1CjWIpLirVfDnIZ4RKc6oYJjHu4bqGGJ
        cpzRQLBkmCmKSCYfqmooe2+UaFtPDsebjSF2Wyc=
X-Google-Smtp-Source: AB8JxZpNZLtryLX1GS3e8jHSaaZMqGHNGMkkiCuIv8gwe1m6F4Do6tYPIh7RAkS3EiBV5WSrKFRzLAjruwqi4gxwh3Y=
X-Received: by 2002:aca:1904:: with SMTP id l4-v6mr5845715oii.216.1525025172484;
 Sun, 29 Apr 2018 11:06:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sun, 29 Apr 2018 11:05:42 -0700 (PDT)
In-Reply-To: <20180424065045.13905-1-newren@gmail.com>
References: <xmqq604h717y.fsf@gitster-ct.c.googlers.com> <20180424065045.13905-1-newren@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 29 Apr 2018 20:05:42 +0200
Message-ID: <CACsJy8DyP_mXXJKn52Jzqe63N3GLpXePCr8ha97Lv9hr6u-M0w@mail.gmail.com>
Subject: Re: [PATCH v3] unpack_trees: fix breakage when o->src_index != o->dst_index
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 8:50 AM, Elijah Newren <newren@gmail.com> wrote:
> Currently, all callers of unpack_trees() set o->src_index == o->dst_index.
> The code in unpack_trees() does not correctly handle them being different.
> There are two separate issues:
>
> First, there is the possibility of memory corruption.  Since
> unpack_trees() creates a temporary index in o->result and then discards
> o->dst_index and overwrites it with o->result, in the special case that
> o->src_index == o->dst_index, it is safe to just reuse o->src_index's
> split_index for o->result.  However, when src and dst are different,
> reusing o->src_index's split_index for o->result will cause the
> split_index to be shared.  If either index then has entries replaced or
> removed, it will result in the other index referring to free()'d memory.
>
> Second, we can drop the index extensions.  Previously, we were moving
> index extensions from o->dst_index to o->result.  Since o->src_index is
> the one that will have the necessary extensions (o->dst_index is likely to
> be a new index temporary index created to store the results), we should be
> moving the index extensions from there.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>
> Differences from v2:
>   - Don't NULLify src_index until we're done using it
>   - Actually built and tested[1]
>
> But it now passes the testsuite on both linux and mac[2], and I even re-merged
> all 53288 merge commits in linux.git (with a merge of this patch together with
> the directory rename detection series) for good measure.  [Only 7 commits
> showed a difference, all due to directory rename detection kicking in.]
>
> [1] Turns out that getting all fancy with an m4.10xlarge and nice levels of
> parallelization are great until you realize that your new setup omitted a
> critical step, leaving you running a slightly stale version of git instead...
> :-(
>
> [2] Actually, I get two test failures on mac from t0050-filesystem.sh, both
> with unicode normalization tests, but those two tests fail before my changes
> too.  All the other tests pass.
>
>  unpack-trees.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index e73745051e..49526d70aa 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1284,9 +1284,20 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>         o->result.timestamp.sec = o->src_index->timestamp.sec;
>         o->result.timestamp.nsec = o->src_index->timestamp.nsec;
>         o->result.version = o->src_index->version;
> -       o->result.split_index = o->src_index->split_index;
> -       if (o->result.split_index)
> +       if (!o->src_index->split_index) {
> +               o->result.split_index = NULL;
> +       } else if (o->src_index == o->dst_index) {
> +               /*
> +                * o->dst_index (and thus o->src_index) will be discarded
> +                * and overwritten with o->result at the end of this function,
> +                * so just use src_index's split_index to avoid having to
> +                * create a new one.
> +                */
> +               o->result.split_index = o->src_index->split_index;
>                 o->result.split_index->refcount++;
> +       } else {
> +               o->result.split_index = init_split_index(&o->result);
> +       }
>         hashcpy(o->result.sha1, o->src_index->sha1);
>         o->merge_size = len;
>         mark_all_ce_unused(o->src_index);
> @@ -1401,7 +1412,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>                 }
>         }
>
> -       o->src_index = NULL;
>         ret = check_updates(o) ? (-2) : 0;
>         if (o->dst_index) {
>                 if (!ret) {
> @@ -1412,12 +1422,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>                                                   WRITE_TREE_SILENT |
>                                                   WRITE_TREE_REPAIR);
>                 }
> -               move_index_extensions(&o->result, o->dst_index);
> +               move_index_extensions(&o->result, o->src_index);

While this looks like the right thing to do on paper, I believe it's
actually broken for a specific case of untracked cache. In short,
please do not touch this line. I will send a patch to revert
edf3b90553 (unpack-trees: preserve index extensions - 2017-05-08),
which essentially deletes this line, with proper explanation and
perhaps a test if I could come up with one.

When we update the index, we depend on the fact that all updates must
invalidate the right untracked cache correctly. In this unpack
operations, we start copying entries over from src to result. Since
'result' (at least from the beginning) does not have an untracked
cache, it has nothing to invalidate when we copy entries over. By the
time we have done preparing 'result', what's recorded in src's (or
dst's for that matter) untracked cache may or may not apply to
'result'  index anymore. This copying only leads to more problems when
untracked cache is used.

Sorry I didn't notice this earlier :(

>                 discard_index(o->dst_index);
>                 *o->dst_index = o->result;
>         } else {
>                 discard_index(&o->result);
>         }
> +       o->src_index = NULL;
>
>  done:
>         clear_exclude_list(&el);
> --
> 2.17.0.253.g32393f1d0a
>
-- 
Duy
