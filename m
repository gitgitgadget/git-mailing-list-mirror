Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA0AC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 07:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155B264D9D
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 07:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhA2Hxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 02:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhA2Hxu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 02:53:50 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346F3C06174A
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 23:54:36 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hs11so11646420ejc.1
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 23:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXgPXxXQFfWGFdYmZqQg4MtyaXMWW/sO+Wxx3KuyjgU=;
        b=chx3wqhZmKwCDWL9WWkxHCp2cSzOgxh6IgigrqkV+kxI+tw099L5igqvnw5kIQYY8w
         mDZttTcAF8LI5GzF5qo0wa7rSDZ8RPltE/AW4omztPzFnrh+ZxiN6VZLFz1yycjtg+gT
         2mfLdW602gvUZua/T/71CXXJ+SB4s1wJbNYxlqkuHvH/yBpYbzzAz/IwUFIzRIHegoXS
         EcFAJz9c3rK/5DHdxBH6fiuYy5h4AsRN9V+HcClrW/rbB4x+MbwqCSFrEwzNcGIjq06O
         IBc8HDV0kUW2YDQkiXeqOcfQvrb4vtIRu7Wv7yGc7hOXeyA+rH2LHdtClczKIKibj2r/
         7C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXgPXxXQFfWGFdYmZqQg4MtyaXMWW/sO+Wxx3KuyjgU=;
        b=ONYaKPm3B35jzUzIzyZWz+t7QV2TtJmbOUbULcfoY2WZ1ZP0k3BJB9w96ezHilwt/2
         RH+sF4V7TmwscsyJJRS2nYVNOepfnBV1kZTWh5gIRi7vPL/eAP8I2/DYbVgsTwOwj77V
         19EyFvnvzADvI3OAD+I4tmA3d9hA8zCa/SWtnnLvoO0PeqUDTqKhMHcR77sz+0qGwA68
         GqQdzpTJle7IU+8eMT9H85Tjtk+DVJLCVwZ3XVBkRCkUPBxjSVloXfWM6klQOjd0b8ql
         xH2m8Pha6uuSVxppRosmIiJb4bfhzB4Tk7yqZ8ljqyicMtY5g4bPCUgj8DkKnHCgmbh9
         Wbkw==
X-Gm-Message-State: AOAM530JOqRu39yIwM4FvDtjzgA/SvJC99nbEctxO9HYWeNaJkC1GYOk
        3hctYvCKVC5bjo30rztKD5tNoemZf8Y9LPbXzzwWzqwNBoLwlQ==
X-Google-Smtp-Source: ABdhPJxCW1nSkf2lIyepp3cu4CYGObxTca0n7TqXA5TH+uqLj8QstsYQEgTaMdUil2e93ItPbC8wukn3CDbj57Yns+0=
X-Received: by 2002:a17:906:3883:: with SMTP id q3mr3283327ejd.160.1611906875031;
 Thu, 28 Jan 2021 23:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20210125191710.45161-1-mirucam@gmail.com> <20210125191710.45161-4-mirucam@gmail.com>
In-Reply-To: <20210125191710.45161-4-mirucam@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 29 Jan 2021 08:54:23 +0100
Message-ID: <CAP8UFD07Ajht9nj3ykYMGW6FnhrScKGBKuTpJMABVvVKuKx9gg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] bisect--helper: retire `--bisect-write` subcommand
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git <git@vger.kernel.org>, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 8:17 PM Miriam Rubio <mirucam@gmail.com> wrote:

> @@ -1048,11 +1044,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>                 if (argc > 1)
>                         return error(_("--bisect-reset requires either no argument or a commit"));
>                 return !!bisect_reset(argc ? argv[0] : NULL);

Here we are returning so we never fall back into the BISECT_WRITE case below...

> -       case BISECT_WRITE:
> -               if (argc != 4 && argc != 5)
> -                       return error(_("--bisect-write requires either 4 or 5 arguments"));
> -               set_terms(&terms, argv[3], argv[2]);
> -               res = bisect_write(argv[0], argv[1], &terms, nolog);
>                 break;

...so the above "break;" could be removed too.

>         case CHECK_AND_SET_TERMS:
>                 if (argc != 3)
