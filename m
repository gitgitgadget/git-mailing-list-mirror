Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CAAC6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiI0QUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiI0QUt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:20:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E1EAE873
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:20:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lc7so21910309ejb.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=jAhURmnhTYmEIJDuvGXoRZYmIs2V0EgQI4nYnG3/csQ=;
        b=cUyPXqsjmUYssWLSGl+AMlQssjwrmXctXLFn1yqop23ilWrw0P6xEmGtY4fgPzz/ao
         mtA/QSvCVgEA/pvoVowfZdgz/bUSmZioZOMNeS2t0Mrhd6j7IWm5JW29+SXqToPff21e
         chSVU/p2AJBltwo4ybJnzuZjvIrzzVl0hsU7EpA/gzGCz7Afika4BscCVkjYtBZyBFZ4
         uCkH/Af7YvAaOMfQwMrxl3djo0gMUkyIOH5Fs79UbJgHHF5SZ09BjrrfYbAH8Gj5Wi4H
         NXKg17fyAeYiLLdTRLnpgZuh/zd/y3En6j1TFJxmfDFm4+uUStb9Y4F8COtrJdxmQ8yY
         4cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jAhURmnhTYmEIJDuvGXoRZYmIs2V0EgQI4nYnG3/csQ=;
        b=fMOV2dXG4MsDcvcEbnYb+8tToizk3hWivN5wrCX4PLV3bSY70TsK8THHn9DaKe1XQT
         oFz7kTSmcU2+HFepfhTMEnjMm5NiIH1A72Y3aF3a9UHKmmkmGpC/lv7dztL8I8xTUTX5
         BYm9rE/i/PQYTiAkB52V7UwegrJYQqW5pU4PeulO5rh8Sn+CA/kxf4fSIZykzaszTISe
         xP+8KLcqGJ1H0IUsuDz2MzjdZpJ75ev3WwqtxJT6NheYKNqk2Z5NdrhJQgrltKqbC2YQ
         bwBSd70I46A834teIyTJdmDiWNHKT/NRv8tlFM2/NwykCKKK0Mv4l7NwjFFHYP3evNVH
         qJyw==
X-Gm-Message-State: ACrzQf3aRfKdNaKR8gpK8xCDURhrMkoa+8pgArQgby8RZVpGzHsL5Oop
        wjKCpUItrdWDO436PG8er8g=
X-Google-Smtp-Source: AMsMyM6WCVeKgQM4SMhlWGKQ9Vo2IGyoXuy/Iv6JnG8RiNGf8mnIIS0MO8gJf57f8IiXfaE0mwxE7w==
X-Received: by 2002:a17:907:75f7:b0:77b:4579:2aee with SMTP id jz23-20020a17090775f700b0077b45792aeemr23229352ejc.529.1664295646931;
        Tue, 27 Sep 2022 09:20:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i28-20020a0564020f1c00b0044e7d69091asm1534084eda.85.2022.09.27.09.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:20:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odDK9-000SEC-1f;
        Tue, 27 Sep 2022 18:20:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/5] config: add BUG() statement instead of possible
 segfault
Date:   Tue, 27 Sep 2022 18:17:40 +0200
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
 <f277a7a429db8f54fa06dd1965d62ec491e6d84b.1664287711.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <f277a7a429db8f54fa06dd1965d62ec491e6d84b.1664287711.git.gitgitgadget@gmail.com>
Message-ID: <220927.86wn9oyejm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 27 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The git_die_config() method calls git_config_get_value_multi() but
> immediately navigates to its first value without checking if the result
> is NULL or empty. Callers should only call git_die_config() if there is
> at least one value for the given 'key', but such a mistaken use might
> slip through. It would be better to show a BUG() statement than a
> possible segfault.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  config.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index bf89afbdab0..0c41606c7d4 100644
> --- a/config.c
> +++ b/config.c
> @@ -2833,8 +2833,13 @@ void git_die_config(const char *key, const char *err, ...)
>  		va_end(params);
>  	}
>  	values = git_config_get_value_multi(key);
> -	kv_info = values->items[values->nr - 1].util;
> -	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
> +
> +	if (values && values->nr) {
> +		kv_info = values->items[values->nr - 1].util;
> +		git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
> +	} else {
> +		BUG("expected a non-empty list of values");
> +	}
>  }
>  
>  /*

AFAIKT the intent of the current code on "master" is that this will only
get called if the likes of git_configset_get_string() returns < 0, not
if it returns > 0.

So isn't the combination of your 1/5 and this 3/5 now conflating these
two conditions? See e.g. repo_config_get_string_tmp() and when it would
call git_die_config().

I.e. isn't the whole point of git_die_config() to print an error message
about a configuration *value* that we've parsed out of the config?

If e.g. the key itself is bad we'll get a -1, but in this case it seems
we would have a BUG(), but it's not that we "expected a non-empty list
of values", but that the state of the world changed between our previous
configset invocation, no?
