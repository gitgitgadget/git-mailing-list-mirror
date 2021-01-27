Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E13C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB982070A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhA0Fmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 00:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbhA0EoT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 23:44:19 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03E9C0613ED
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 20:43:38 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id g69so846146oib.12
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 20:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ur3JRyXsVKUsWrRWVxzxSteB7mAQk+mwhVvdIT5ygHM=;
        b=hGNYiiDLHQDxikEMQ0lBPzQFo+ofAwVRhgKMuUcCgCLbWHkTAXfbo+UlNp5jMvm8Su
         nOsY5bqoDEadqvv9hBgw881Z/5/OOQHhiiOt8rZIejkepxTr5fSEXjea9PhmxcAWfeKn
         KDstB1dyple5NNgiVv8eI6sQ25WVSrMPc9y5fg3DUYYRNUtIDpCc3iEiBKboTmKlFH8h
         wQu3JkWxFC1bc1YJTFnEq/lKjHnEl9BON8Z2LkxAJZnVyS06ogv2WDODeOxzBtbItk6d
         +vvO2+T7+ZcZMs7/qV8Q4KK+cbcAK5Qzg5guTaz7Wz52M+JPVSSaRG3Od7hB8HrysSj9
         Pqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ur3JRyXsVKUsWrRWVxzxSteB7mAQk+mwhVvdIT5ygHM=;
        b=ClR7lepdLNe0zlsRTlqE5qsQknFkqKrKDqoPBKnd6AA103K9SwPFI64QjSnX4E/zbX
         FItNzENqdI34KqNEfjoJWYPclnaG1cWXW8MQoUTvdf395cyb+WSYKgxIEKkfYiGx15GQ
         0tVeDjl+7oltbDFlsGh241ZoWovdH1B7V9q+cxrHlnNnsu0mBz5rojwcDgR/fQ4/1nyL
         bUsk0RQJuCx+kpwq0SLkoEtE7fdiZAddKObhm3pNP3ZnFx6aK6hSl+OXwkk2+bZkygDX
         lIYaEsTp4LUROVrM9BdFsV8rCYtPvEoRbAzXbeI3HUvRVU3VaPt+i5bSZwO/c6BASirQ
         rdMQ==
X-Gm-Message-State: AOAM531pqX3BDKzsL4vcaor/drz/qTGFVTzZPvM+9p5PWaUou5+ESzw4
        Br6mtdaXC5I04zBIYBRL9PRfKpzTdUWagF8rbe4=
X-Google-Smtp-Source: ABdhPJw8ZvDSn4vLatWpEQL7A/DvS50L8dNI4o51GkpLoePSyFcQ+9SFLDUs2rMGLHzP05ONX/lMU7MfBll5zjkESaI=
X-Received: by 2002:a54:4790:: with SMTP id o16mr1981055oic.39.1611722618018;
 Tue, 26 Jan 2021 20:43:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <175c3c62543f89144b03b3bdff750ad29d17ba03.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <175c3c62543f89144b03b3bdff750ad29d17ba03.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jan 2021 20:43:26 -0800
Message-ID: <CABPp-BE-eDAR8E538JD-zy3RP4MEc-pnrQwQOOWxsYD7D4BbtQ@mail.gmail.com>
Subject: Re: [PATCH 07/27] unpack-trees: ensure full index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The next change will translate full indexes into sparse indexes at write
> time. The existing logic provides a way for every sparse index to be
> expanded to a full index at read time. However, there are cases where an
> index is written and then continues to be used in-memory to perform
> further updates.
>
> unpack_trees() is frequently called after such a write. In particular,
> commands like 'git reset' do this double-update of the index.
>
> Ensure that we have a full index when entering unpack_trees(), but only
> when command_requires_full_index is true. This is always true at the
> moment, but we will later relax that after unpack_trees() is updated to
> handle sparse directory entries.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index f5f668f532d..4dd99219073 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1567,6 +1567,7 @@ static int verify_absent(const struct cache_entry *,
>   */
>  int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
>  {
> +       struct repository *repo = the_repository;
>         int i, ret;
>         static struct cache_entry *dfc;
>         struct pattern_list pl;
> @@ -1578,6 +1579,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>         trace_performance_enter();
>         trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
>
> +       prepare_repo_settings(repo);
> +       if (repo->settings.command_requires_full_index) {
> +               ensure_full_index(o->src_index);
> +               ensure_full_index(o->dst_index);

I was worried about o->result as well, since there is a
    memset(&o->result, 0, sizeof(o->result));
followed by manually initializing the relevant fields of the
index_state.  However, the relevant field here is your new
sparse_index bit, and you want that to be 0, i.e. full.

I also checked ensure_full_index() since it is often the case that
o->src_index == o->dst_index, but it'll be safe to be called twice on
the same index state -- at least as currently written.

So, this patch seems good.

> +       }
> +
>         if (!core_apply_sparse_checkout || !o->update)
>                 o->skip_sparse_checkout = 1;
>         if (!o->skip_sparse_checkout && !o->pl) {
> --
> gitgitgadget
