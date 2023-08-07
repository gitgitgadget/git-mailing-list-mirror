Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0398EC001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 23:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjHGXpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 19:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHGXpr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 19:45:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CE6183
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 16:45:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d47d125f5afso1629843276.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691451945; x=1692056745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CApSMTx1G1x/V2bAF4ZcAHpFh/e2FYLkoMQFe+EVDyw=;
        b=0hVi+WcijYjjPpvtKY7+JE4j7wj3FjKwkT7BUvT4tClXJ3TYs1aXFlSaph+fiOXItP
         i9BDcyU013ck9vin31mO6oDxUmKP9Zj70/Lgj3nC4Cx6sWnJ59LyI1is6DGOY37GwLW4
         evr521yiGA10qARg8SJtyrq5SC+cxlYZDj6c0hKTNSpyOYHAAIkJ/KhclL07U851OEBB
         kmHiTaxo3hiUpj93VvhWgBHMFB+Iu4Llq5v1TVxCSJu8lJFdKvdHdBzY1cVBBEGiaKWH
         bhvMnLWTNpeuoeZnbwQ38fC51cxYeohlKQ4X/bXKYT5O4k7enHQibs3LrhH7UMcR5Yom
         EgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691451945; x=1692056745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CApSMTx1G1x/V2bAF4ZcAHpFh/e2FYLkoMQFe+EVDyw=;
        b=J1jp6J0ssxCf7+YYrFZGtltABlYL/rOxUp3T0KVE3uHiTSL7Tn5QWKGfcLGpnYOw92
         6QxGnX+L0S5FuC/b3KmHfo52newxgXwbWKz/gCsN/LjShSPmN9nzAtho0NBC9+UjpJov
         UHonIDqJEbU1XSda6YVv/FjarhIZp8oCBxRK+yBKKY4+/RhiIHKYfAyOGz7u+00W6T0x
         8G0PVnRSuaHFfoFwit2U4x0okd89W3ia/z6gcqoOo9P+B+ZneF5hgPdLMB4QpniUOXfx
         hVbsKjPVOnH+966f8PJ7kZ2maRTHzW9/Fo+oaEm/jbINt0k7U/R8TmAQgikD9yVKdg+/
         ZKMw==
X-Gm-Message-State: AOJu0Yy8zdxKy0hzuM3ofykIuMm6JJ9yZ0f1a5El06ydW1TOdnYa6f+W
        FFpKNsfyy7Kwrljkzet++h/n0PoL7VdWIw==
X-Google-Smtp-Source: AGHT+IEmsIUub8yevvB+SWm+KQZa+L8SoSXvZjsyG8Lu9FzsQifq+I9eWjLyGiTr6oI8q685mVz4DeaiE8c67w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:2490:0:b0:d08:8cf5:c5d8 with SMTP id
 k138-20020a252490000000b00d088cf5c5d8mr63983ybk.5.1691451945659; Mon, 07 Aug
 2023 16:45:45 -0700 (PDT)
Date:   Mon, 07 Aug 2023 16:45:43 -0700
In-Reply-To: <7c9b63c26164b037272fde689bb3150b30aa7528.1691211879.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com> <7c9b63c26164b037272fde689bb3150b30aa7528.1691211879.git.gitgitgadget@gmail.com>
Message-ID: <kl6lv8dq8li0.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 5/5] trailer: rename *_DEFAULT enums to *_UNSPECIFIED
From:   Glen Choo <chooglen@google.com>
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> (2) "Default" can also mean the "trailer.*" configurations themselves,
>     because these configurations are used by "default" (ahead of the
>     hardcoded defaults in (1)) if no command line arguments are
>     provided.

Interesting, I would have never thought of config as 'default'. In fact,
I would have thought that this de facto behavior (which you also
clarified in [1]) is a bug if not for the fact that in an internal
version of this series, you cited a commit message that describes this
as expected behavior. That context would be very welcome in the ML, I
think.

[1] https://lore.kernel.org/git/6b427b4b1e82b1f01640f1f49fe8d1c2fd02111e.1691210737.git.gitgitgadget@gmail.com

> In addition, the corresponding *_DEFAULT values are chosen when the user
> provides the "--no-where", "--no-if-exists", or "--no-if-missing" flags
> on the command line. These "--no-*" flags are used to clear previously
> provided flags of the form "--where", "--if-exists", and "--if-missing".
> Using these "--no-*" flags undoes the specifying of these flags (if
> any), so using the word "UNSPECIFIED" is more natural here.
>
> So instead of using "*_DEFAULT", use "*_UNSPECIFIED" because this
> signals to the reader that the *_UNSPECIFIED value by itself carries no
> meaning (it's a zero value and by itself does not "default" to anything,
> necessitating the need to have some other way of getting to a useful
> value).

Makse sense. This seems like a good change.

> @@ -586,7 +586,10 @@ static void ensure_configured(void)
>  	if (configured)
>  		return;
>  
> -	/* Default config must be setup first */
> +	/*
> +	 * Default config must be setup first. These defaults are used if there
> +	 * are no "trailer.*" or "trailer.<token>.*" options configured.
> +	 */
>  	default_conf_info.where = WHERE_END;
>  	default_conf_info.if_exists = EXISTS_ADD_IF_DIFFERENT_NEIGHBOR;
>  	default_conf_info.if_missing = MISSING_ADD;

As mentioned earlier, I find it a bit odd that we're calling config
'default' (and also that we're calling CLI args config), but
renaming default_conf_info to config_conf_info sounds worse, so let's
leave it as-is.
