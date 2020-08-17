Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A42C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15CD20738
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7uWBS4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbgHQRdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388272AbgHQQ4K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 12:56:10 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F874C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 09:56:09 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u24so14248649oic.7
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbL3eD1msGGtHoPJJGPTPs2CYN8xzp/AAFRe1ZEOYHU=;
        b=G7uWBS4kPDO5/4XticvhMrdCuwduycSTRg5YlBgosz6mlC7OhRdYzx+xnN3hY6sQzS
         n4aM/COPM5ZZ+v7dSHLc1OENIsnZ9/yqp2ll5koNNvE9BYL/pw+e6HXryvkMAsJJHQzJ
         h98Ebl93HDYyL8OsRl9JAwdPGKOHc6lTHsoeM9dXoSQALQHmkAEPkburPpbWGArn58ay
         muWkfEO+wPGJX/8Ji/ihhSE3/nH2Ae9n+eEf+Y39yVu+Iq9sWpKDYtl8CUIgJca5MRqU
         OXBjRJDhW/v+8Z1YwhR4+qzdCpIoZO0PW655z82lgtL806kvxYnfKL9LVhKOHSKhpgkL
         t+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbL3eD1msGGtHoPJJGPTPs2CYN8xzp/AAFRe1ZEOYHU=;
        b=RzENaLgRCiJwehsOfNeFwFUFOx4w1hynobwjU0HYNFdI9C3ejr0Nw9dQSRyceh4eSP
         ztuEngYsItpIhqxFBB995MmAyeUWGum2ntmCjF+xo3bsPCPD4azHt55VW8iAa6aXkqFC
         c7wJcQR/8yZeSikgTf288ufcINwRiT9p4esyqpVKkyg+M5yluv6E2hHRFGM1QvqT+jIa
         poE6gyc699QfzIESWdi3dThmIp6ehK2Kw1mzABSPxNSEI0ptDawO8YxvEIYEBbm3Hryu
         ja5phJPH5Q+jSB3dUscXN3W3DTwL+uDKZ8+65iNEgLM/oJoH0hRwtzZuhnHHbvnRAk+Z
         UWAg==
X-Gm-Message-State: AOAM533Z4j/WHexpGnzMMLuW/wpc4Cq/gn5gKNZTWWgW4ULLEaFcI0MW
        OvmWdWQihPltENJHzyveGAdqIcRuIPV1mQ4z2QHSleJk7BPaGA==
X-Google-Smtp-Source: ABdhPJy57is9RhdTVvY5qpKZfEjOtIyF8/AZE3vHL7k6NptN1AcSlENCZEhCeOUfRjNFpSNeSFcEbCHcODJjTjfeRsQ=
X-Received: by 2002:aca:b705:: with SMTP id h5mr9651056oif.31.1597683367780;
 Mon, 17 Aug 2020 09:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200814111049.GA4101811@coredump.intra.peff.net>
In-Reply-To: <20200814111049.GA4101811@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Aug 2020 09:55:56 -0700
Message-ID: <CABPp-BGrxaY-ObzuJ60TDMfQD+crq+TTnYE03T=KVmG5mEf-5A@mail.gmail.com>
Subject: Re: [PATCH] clear_pattern_list(): clear embedded hashmaps
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Aug 14, 2020 at 5:23 AM Jeff King <peff@peff.net> wrote:
>
> Commit 96cc8ab531 (sparse-checkout: use hashmaps for cone patterns,
> 2019-11-21) added some auxiliary hashmaps to the pattern_list struct,
> but they're leaked when clear_pattern_list() is called.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I have no idea how often this leak triggers in practice. I just noticed
> it while poking at LSan output (which we remain depressingly far
> from getting a clean run on).
>
>  dir.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/dir.c b/dir.c
> index fe64be30ed..9411b94e9b 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -916,6 +916,8 @@ void clear_pattern_list(struct pattern_list *pl)
>                 free(pl->patterns[i]);
>         free(pl->patterns);
>         free(pl->filebuf);
> +       hashmap_free_entries(&pl->recursive_hashmap, struct pattern_entry, ent);
> +       hashmap_free_entries(&pl->parent_hashmap, struct pattern_entry, ent);

This clears up the hash entries, but continues to leak the hash table.
Since you submitted first, can you fix this to use hashmap_free_()
instead, as per
https://lore.kernel.org/git/932741d7598ca2934dbca40f715ba2d3819fcc51.1597561152.git.gitgitgadget@gmail.com/?
 Then I'll rebase my series on yours and drop my first patch (since
it'll then be identical).

Thanks,
Elijah
