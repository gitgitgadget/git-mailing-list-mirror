Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B111C4321E
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 08:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1BD60273
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 08:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238722AbhJMI3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbhJMI3D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 04:29:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF082C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 01:27:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g8so6819453edt.7
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NRg8zDSPZNjg9VkRM/KH88oaQznPFv2vZ68wPIBDTjs=;
        b=Fqf+k8fV3vy8LYSCcE7Cx/oJvcnNnpBzVc2CaTKPcN8SpKpoaSzfereWotQHWPeOl5
         FXGKFpChEYFi5wmc+UsfjIYBghZOhkUNBH7L0vBt12RxmDXFZA9t/eYosv2d6JiA6rFP
         5PIj5J06rZmG6WnjkVNRUa+e6gqa12UtbAn/lDXOhy8l1OFQwVhb0w1KExTkxnbaOlGZ
         tG8T7WuK6FOYMUNWfR72SmssoWYOkrrl/MyX0sv7D51gGB27pj6RUC9wLv+hI4bLlurl
         X7c1TA95D3QQ4Vg2/vXC6f67J1mNKowHk2V/vuCBok3VLbRL03n1puzlprSEKRkj/roi
         dM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NRg8zDSPZNjg9VkRM/KH88oaQznPFv2vZ68wPIBDTjs=;
        b=bJ+E4gukK5Ju06jcG33uQcpTyKLzEFMpu2ERtNhfwsEanKLIzv9Zv+gGGDKPd8F73q
         e2LaOnAYYKLkbm7PSuxJgm4+/i1WZr4KLzm8Hw9dh8nooIbbRwsHAdJZ3I8z9nFvSQO6
         ARam3S772lMmp7THYQPzLc8xvyt9G3o61QLqriaqngfFFOREX7/UFRNmCJoqRaLtOT5R
         rrmS2IdutSTm1C4tcAnIWEl5/3E7lgJtOGwYWCiiIodeoKB9hkUiLCi3p4aU0VbxZIxy
         NFxmo25rU3eTklIuCn7Pl3tgySLupq+tiNEeC/O04yqqQhk8dxGvWpjI3zi3xDsKuctz
         tMtg==
X-Gm-Message-State: AOAM532cozxrPP4r/3J0pE9mlHvLVK17u4LPhhdXZ6S8XEheUnA0XW5T
        ilfZyWXUj77RvR+npnEq/G5yi08B2JOtPg==
X-Google-Smtp-Source: ABdhPJxeadKq+ZYR7eJc6SsLuiptzRsdq7YSDtiC1/7tJqlVjopXa6+JvP5asyo38qwOmLQmd9MzdA==
X-Received: by 2002:a17:906:a28e:: with SMTP id i14mr38896305ejz.263.1634113619149;
        Wed, 13 Oct 2021 01:26:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 6sm6268074ejx.82.2021.10.13.01.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 01:26:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] config: make git_config_include() static
Date:   Wed, 13 Oct 2021 10:26:11 +0200
References: <cover.1634077795.git.jonathantanmy@google.com>
 <179df6d6adfe460de7413e1fb1dff6bce185ae0e.1634077795.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <179df6d6adfe460de7413e1fb1dff6bce185ae0e.1634077795.git.jonathantanmy@google.com>
Message-ID: <87sfx5ib3h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 12 2021, Jonathan Tan wrote:

> It is not used from outside the file in which it is declared.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  config.c | 12 +++++++++++-
>  config.h | 37 ++++---------------------------------
>  2 files changed, 15 insertions(+), 34 deletions(-)
>
> diff --git a/config.c b/config.c
> index 2edf835262..365d57833b 100644
> --- a/config.c
> +++ b/config.c
> @@ -120,6 +120,16 @@ static long config_buf_ftell(struct config_source *conf)
>  	return conf->u.buf.pos;
>  }
>  
> +struct config_include_data {
> +	int depth;
> +	config_fn_t fn;
> +	void *data;
> +	const struct config_options *opts;
> +};
> +#define CONFIG_INCLUDE_INIT { 0 }
> +
> +static int git_config_include(const char *var, const char *value, void *data);

Can't we just move the function here?

>  #define MAX_INCLUDE_DEPTH 10
>  static const char include_depth_advice[] = N_(
>  "exceeded maximum include depth (%d) while including\n"
> @@ -306,7 +316,7 @@ static int include_condition_is_true(const struct config_options *opts,
>  	return 0;
>  }
>  
> -int git_config_include(const char *var, const char *value, void *data)
> +static int git_config_include(const char *var, const char *value, void *data)

...and avoid the forward declaration?

I've seen that in a few places, making the diff smaller here doesn't
seem worth it v.s. maintaining the definition in two places.
