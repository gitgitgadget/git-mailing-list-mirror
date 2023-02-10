Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF0C636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 13:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjBJNUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 08:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjBJNUE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 08:20:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0018756ED2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 05:20:02 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lu11so15808829ejb.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 05:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2BLQForcP9lrvofgpnMK/xW2OezP8GMnHgYgzA2JE0=;
        b=Ohdh7z4MyqxtMNGinh/PS/Or2uw6YyZjVFBLSjUNzY/0OfCjSGvR6il4sCYMXW4pH0
         YqynvAwkefUMhv6ZjMKzda7y0fNnwSsu0zzN1HJsNpyA7TEuMq9wwx31XYC8ytjcHqpj
         Oj3uGsPDDwVdC0BYlA+wqL0xrha1yoJlaZQo5ciSEDzSAfVSqR7xIMjM7esy367PoWO2
         xMc6kn2gEqIorxnwgQ1lOnazSACL+OjWsKISsgDziMWT0f53yLl18VFtLAol73WILW3w
         PCF8HzxiTGOh2MwsmV3TTz9Yv6+THnzNxeL+1mBLBvlgt66Qk5KjSEdWRihKoGupouXx
         1rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2BLQForcP9lrvofgpnMK/xW2OezP8GMnHgYgzA2JE0=;
        b=K5Pz4fIRShcj5ckLWwvkhoQ+Hq/MB7S3KRes4sx91dHmV+7iGaHw/+MS/j4YDOSXKS
         80DQlJYmRf/X4vvrVsVdmxTLslyA5TFIGaMBPUDsaAUmgVqvgwe90me7XNNCDLLm70yO
         8QFEqJdvFVvDOP1+mW8bu4jcJMR0lvXWE3jV1x9CRlLg8v8gXoswBTvfKVMt1HbjCot0
         FF5nMDN+RyibNFHRF03w/RDbrQonQZIetkpT/a3Qpbs7nX2SeJ1OHgQWOUIC90O67zJn
         nMpHnGtU+bKOS6+ldotYcyOZIqLubMBTSJlJVZMeKgQ5uiOYlhGbYfkbBKJrQ2RMXCkq
         IqHw==
X-Gm-Message-State: AO0yUKXL/DpUktlYHc42ry+JEHmpUBb0EInPrIhVXeUT+3J3nm+ZT8Pl
        QjO11uaSMO7B96kP9iqS6SI=
X-Google-Smtp-Source: AK7set9+EguEqFLb6G7pIrTyFaYanyBPvXAjfrJDb7mZcZ5iWiUx27gKkav8Xn+35o9tH7dGRs9anw==
X-Received: by 2002:a17:907:7e8f:b0:8aa:be5d:f858 with SMTP id qb15-20020a1709077e8f00b008aabe5df858mr15883231ejc.60.1676035201572;
        Fri, 10 Feb 2023 05:20:01 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906970e00b008806a3c22c5sm2349141ejx.25.2023.02.10.05.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 05:20:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pQTJo-001vjs-1Y;
        Fri, 10 Feb 2023 14:20:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/5] git-compat-util: add isblank() and isgraph()
Date:   Fri, 10 Feb 2023 14:16:24 +0100
References: <20230210075939.44949-1-masahiroy@kernel.org>
 <20230210075939.44949-2-masahiroy@kernel.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230210075939.44949-2-masahiroy@kernel.org>
Message-ID: <230210.861qmxwtbz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 10 2023, Masahiro Yamada wrote:

> git-compat-util.h implements most of is*() macros.
>
> Add isblank() and isgraph(), which are useful to clean up wildmatch.c
> in a consistent way (in this and later commits).

You are on a journey to fix wildmatch.c, so...

> The same issue already exists for isspace().
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> [...]
> -#ifdef isblank
> -# define ISBLANK(c) (ISASCII(c) && isblank(c))
> -#else
> -# define ISBLANK(c) ((c) == ' ' || (c) == '\t')
> -#endif
> -
> -#ifdef isgraph
> -# define ISGRAPH(c) (ISASCII(c) && isgraph(c))
> -#else
> -# define ISGRAPH(c) (ISASCII(c) && isprint(c) && !isspace(c))
> -#endif
> -
> +#define ISBLANK(c) (ISASCII(c) && isblank(c))
> +#define ISGRAPH(c) (ISASCII(c) && isgraph(c))
>  #define ISPRINT(c) (ISASCII(c) && isprint(c))
>  #define ISDIGIT(c) (ISASCII(c) && isdigit(c))
>  #define ISALNUM(c) (ISASCII(c) && isalnum(c))

You make this change, but not others in tree.

Personally I wouldn't mind seeing this expanded to fix the various other
trivially convertable cases in-tree, e.g.:
	
	$ git -P grep -n "(' '|'\\\t').*\|\|.*(' '|'\\\t')"
	builtin/am.c:602:               if (*sb.buf == '\t' || *sb.buf == ' ')
	compat/regex/regex_internal.h:60:# define isblank(ch) ((ch) == ' ' || (ch) == '\t')
	compat/regex/regex_internal.h:73:   return (c == ' ' || c == '\t');
	config.c:893:   while (c == ' ' || c == '\t')
	fsck.c:837:     while (*p == ' ' || *p == '\t')
	mailinfo.c:749:     (line->buf[0] == ' ' || line->buf[0] == '\t')) {
	sequencer.c:2476:                (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p) &&
	sequencer.c:2536:                  (*bol == ' ' || *bol == '\t')) {
	sequencer.c:2540:                                 (*bol == ' ' || *bol == '\t')) {
	sequencer.c:2594:       if (is_command(TODO_PICK, &bol) && (*bol == ' ' || *bol == '\t'))
	sequencer.c:2597:                (*bol == ' ' || *bol == '\t'))
	t/helper/test-json-writer.c:443:                if (c == '\n' || c == '\r' || c == ' ' || c == '\t')
	t/helper/test-json-writer.c:449:        while (*buf == ' ' || *buf == '\t')
	t/t4256/1/mailinfo.c:737:           (line->buf[0] == ' ' || line->buf[0] == '\t')) {
	t/t4256/1/mailinfo.c.orig:726:      (line->buf[0] == ' ' || line->buf[0] == '\t')) {
	trailer.c:630:          if (c != line && (*c == ' ' || *c == '\t')) {
	wildmatch.c:34:# define ISBLANK(c) ((c) == ' ' || (c) == '\t')

Some of those are false positves, but most are not.
