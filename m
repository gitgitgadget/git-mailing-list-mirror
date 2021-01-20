Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87847C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C46C22473
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbhATRdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbhATR1g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 12:27:36 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B3C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:26:51 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id x23so5969165oop.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01RfTKv+5nprwLlepLYdtSmosshbsMMNQMkDq68+whA=;
        b=ltvuKE3SS7lmwF9EM7ZC3jv68nUvZRhL0nsNSozS8ZQunnuebkVk4h2Owf5r4hRgSv
         9tnrh3A2Hqj6hJXPjJdbmWYJkfxgo08ZEFArYRwWFIbtufHIV5BdAAZyIeVQ953eex3j
         jJpdX20MbDejE8mCTseJ/jH6Rwmb94LPni09xASFdxWccGzQkT8c6HKOle1Q6rZBWt8+
         z/uXZrtv3fyvX4n3XYcMNOsguCHqExgAUFnYVGwMln2DjPFw0YsnMTe284qo0Q6LIorY
         1L30aQqhOVOxFeQh3xTsUKSAzqAPNSNdLevnWes5NCDCTSn2BRv7m0nihVkhJOsoMCGQ
         HTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01RfTKv+5nprwLlepLYdtSmosshbsMMNQMkDq68+whA=;
        b=kJFqm3ozBMN/sONlD/BYXC3rCcn5b+4MZ05BMu8nrgcWr9VSi9bynZhUFACnW/zz3e
         Boa7CGvnW8d8yWiih8HV0n0EUtFKhzZ22FW9czpOYpCocVQgELfll7N7YTMZPIuyCGAL
         xCCR6bkTAVKayn0U3C7w/tE670CJ6LQmaxNldUOdXiao1xwRAankeJHf7vwsy076/aFM
         rFWpup1n8AuRaCBKuwn1M+wJl3bqWUMbl7IG17850ok5AiefhyjVUsL7EccABXOwwarh
         7K6pEVrBS5bZMydHtEtOdMN8is7jnn5eCGnaQfrPhTga2oAg0LVJfkKXkKRTtyc5O7Wd
         unbg==
X-Gm-Message-State: AOAM530iOE/cWyRmudJfthn+UxMfTasgobKgAE6mW79TeAEnv4lkqOj+
        J5afj8W5prULDO7gFwVMioO5DwqtIvRR1aloyhZM2tDMZDc=
X-Google-Smtp-Source: ABdhPJzHrvtD+YmfA39cSAz7VDxF/5xGUFJbIy32NX13CJECKDGVcY2FyyzQc2eWdR+XM0yzd7Q7qq3i1oRd4k/K0qA=
X-Received: by 2002:a4a:b2c6:: with SMTP id l6mr6775865ooo.7.1611163610450;
 Wed, 20 Jan 2021 09:26:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com> <838922de2e9756c00f4a159b2b8722ae4d28b011.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <838922de2e9756c00f4a159b2b8722ae4d28b011.1611161639.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jan 2021 09:26:38 -0800
Message-ID: <CABPp-BEL=tjCx_x1z0NpNTmt3q9_CHtufwWg9FtqKBWWub00UQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] fsmonitor: de-duplicate BUG()s around dirty bits
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The index has an fsmonitor_dirty bitmap that records which index entries
> are "dirty" based on the response from the FSMonitor. If this bitmap
> ever grows larger than the index, then there was an error in how it was
> constructed, and it was probably a developer's bug.
>
> There are several BUG() statements that are very similar, so replace
> these uses with a simpler assert_index_minimum(). Since there is one
> caller that uses a custom 'pos' value instead of the bit_size member, we
> cannot simplify it too much. However, the error string is identical in
> each, so this simplifies things.
>
> The end result is that the code is simpler to read while also preserving
> these assertions for developers in the FSMonitor space.

Indeed, looking through the patch, the end result is simpler to read.
Nice cleanup.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  fsmonitor.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/fsmonitor.c b/fsmonitor.c
> index ca031c3abb8..52a50a9545a 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -13,14 +13,19 @@
>
>  struct trace_key trace_fsmonitor = TRACE_KEY_INIT(FSMONITOR);
>
> +static void assert_index_minimum(struct index_state *istate, size_t pos)
> +{
> +       if (pos > istate->cache_nr)
> +               BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
> +                   (uintmax_t)pos, istate->cache_nr);
> +}
> +
>  static void fsmonitor_ewah_callback(size_t pos, void *is)
>  {
>         struct index_state *istate = (struct index_state *)is;
>         struct cache_entry *ce;
>
> -       if (pos >= istate->cache_nr)
> -               BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
> -                   (uintmax_t)pos, istate->cache_nr);
> +       assert_index_minimum(istate, pos);
>
>         ce = istate->cache[pos];
>         ce->ce_flags &= ~CE_FSMONITOR_VALID;
> @@ -82,10 +87,8 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
>         }
>         istate->fsmonitor_dirty = fsmonitor_dirty;
>
> -       if (!istate->split_index &&
> -           istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> -               BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
> -                   (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
> +       if (!istate->split_index)
> +               assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
>
>         trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
>         return 0;
> @@ -110,10 +113,8 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
>         uint32_t ewah_size = 0;
>         int fixup = 0;
>
> -       if (!istate->split_index &&
> -           istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> -               BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
> -                   (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
> +       if (!istate->split_index)
> +               assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
>
>         put_be32(&hdr_version, INDEX_EXTENSION_VERSION2);
>         strbuf_add(sb, &hdr_version, sizeof(uint32_t));
> @@ -335,9 +336,7 @@ void tweak_fsmonitor(struct index_state *istate)
>                         }
>
>                         /* Mark all previously saved entries as dirty */
> -                       if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> -                               BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
> -                                   (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
> +                       assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
>                         ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
>
>                         refresh_fsmonitor(istate);
> --
> gitgitgadget
>
