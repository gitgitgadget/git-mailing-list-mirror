Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5BAC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 09:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4EA610A3
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 09:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhJDJdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 05:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhJDJdl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 05:33:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEBFC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 02:31:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t2so6083579wrb.8
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nVVwUGS58XHun0pPtCrDcEJ4UlOsW6w73qjCAw50OZc=;
        b=IttRRMtjiVzRgS6uJxXa5GZr2mI6fXlAQlnrcDkWTzGBcTeiYAr9ogfo/tH9o8lvjs
         EIS8srx7+6Io2nKUCo2yJywqjXnnDdh+TGXB8TtLac16XrUi8OkSjMfqXIGENpPNLx4x
         HlP08BYiBFOoFWkKnO22MwxPPJWn84CZN2jyC9nVQfqNKmb0yCabt0nqiPX66JnTnYed
         7HSSvhXjO3XydcVsZR3KkXoJJdwPGqL6V6Lh/2C2yCgXeTtZpceGNhB4R2SAe5cRk/HU
         bmFPAfkp6QPdq/GpnVZtMj0xOjhSk9VxAcPbpB/ajjLbl4dOzSqHtEgquFAAG4/HIW8/
         2qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nVVwUGS58XHun0pPtCrDcEJ4UlOsW6w73qjCAw50OZc=;
        b=VZIEA/Dkiid8lF3GGtv5W4qnrD6UHmFAtdaj97IJqK6R05t3mr/2PNOgIRswwqQyRl
         oox7jlk9sVRazKXLtEFGgsnVB/UC6t5LWKu+cr8zKon4jafitE7HmV8Jh0VyLfD7BUe/
         ajCbbVMM25VsOocgWuONFWxWIb9GaLpmeXGvYsug1HLAnpZkD301CpefC0pvpcwK0Rmh
         Wl3L4E5NgCwMjETDTquKIpKMXmwtZPEI6SJxVTocAqGnITa1h4OP0o95MGiK12beuUt3
         KxK4f5YLHeVI9jqZedmNDDj6jS4lXUkK8NM0qU+b1x4TTYFWtWT/XFrAfre7zGkI4tcw
         H7zQ==
X-Gm-Message-State: AOAM531x0tkJjUYPYwT4dtkTA+/HpWbEF1ahfwXpLCdnvMCZcVeEY+wn
        NaTE1lHlPU9Zc0ITdyeUPnZtV13/kwI=
X-Google-Smtp-Source: ABdhPJz86dxU1kWOCvyQYuMDymuovTYD4MUzpaQO7+8wSgqzb7rrz4SXPdld7wr3QqWzGLXQ9gjTCA==
X-Received: by 2002:adf:fb44:: with SMTP id c4mr12810276wrs.179.1633339910622;
        Mon, 04 Oct 2021 02:31:50 -0700 (PDT)
Received: from [192.168.1.240] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.gmail.com with ESMTPSA id a25sm15575428wmj.34.2021.10.04.02.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 02:31:50 -0700 (PDT)
Message-ID: <f24733e9-8742-33b6-5fae-93d89698cc00@gmail.com>
Date:   Mon, 4 Oct 2021 10:31:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/10] unpack-trees API: don't have
 clear_unpack_trees_porcelain() reset
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
 <patch-04.10-9d62edd35bf-20211004T002226Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-04.10-9d62edd35bf-20211004T002226Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 04/10/2021 01:46, Ævar Arnfjörð Bjarmason wrote:
> Change the clear_unpack_trees_porcelain() to be like a *_release()
> function, not a *_reset() (in strbuf.c terms). Let's move the only API
> user that relied on the latter to doing its own
> unpack_trees_options_init(). See the commit that introduced
> unpack_trees_options_init() for details on the control flow involved
> here.

Before this change if there was a call to unpack_trees() after 
clear_unpack_trees_porcelain() then that caller would get the default 
error messages. After this change we end up with a use-after-free error 
in that situation. I found the subject line of this patch hard to 
understand, the commit message explains what it is doing but I'm still 
not sure what the motivation for this change is.

Best Wishes

Phillip

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   merge-recursive.c | 1 +
>   unpack-trees.c    | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d24a4903f1d..a77f66b006c 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -442,6 +442,7 @@ static void unpack_trees_finish(struct merge_options *opt)
>   {
>   	discard_index(&opt->priv->orig_index);
>   	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
> +	unpack_trees_options_init(&opt->priv->unpack_opts);
>   }
>   
>   static int save_files_dirs(const struct object_id *oid,
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 94767d3f96f..e7365322e82 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -197,7 +197,6 @@ void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
>   {
>   	strvec_clear(&opts->msgs_to_free);
>   	dir_clear(&opts->dir);
> -	memset(opts->msgs, 0, sizeof(opts->msgs));
>   }
>   
>   static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
> 
