Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0652DC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 13:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhKWNKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 08:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhKWNKT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 08:10:19 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F7C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 05:07:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so91961907edb.8
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 05:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=XONr0/uRw7J42XB0ILKUKicfgqj4QUOPNDfPnce107Y=;
        b=ArzCtfQedbvGr3NpzgYeE/a2kHHKb7IpJJ5pktteVdpSioUZsWoFuN8GzOhUEZXOLv
         dYJiUg4OXYamXHVoh7G5SPBdjVmZyU0anli0u2q1+yXgi+IoFF2724kJK/AHB9xqp9cW
         ++XbyV0o2c5YAfkeJpe62Q0VnN8LB3fu5x9RHFkBzYcrrzUyNIcYJk4oNPgKIwBhQcdr
         uaKAeRTA1bcmSJhOz89WH8UScuQ8wjxx3abrt0xrUXMCZyFGlkUR+W1Yx/1S0eI2jA7e
         aNAxLbF/y6RIzYKrnbvSUBv7qG+pmtjxBVPbQ4puKfl1tC+6Rp30nqrca+/Rc76JGHj5
         DsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=XONr0/uRw7J42XB0ILKUKicfgqj4QUOPNDfPnce107Y=;
        b=LH9UMueDHn765/h+8bjd4u3hAITWJwasjKyQPLIvaIePxKfYv7kXX9afxRxj5kGxZC
         fVQUjPYXNM8/gmujk5w3BdJSycZn3k8xJ7ArJuITl5EQ2i/VqFmqruBhrQOSHQiiwEUw
         LCZohS6L8z5DOgNKdt6LdJBtJLI4g0TlDmVWZKRv7POkF2PJ1ccpsG/8jM/pEWF+DY2n
         j2NMw1C+k5eNM12QU1Sh4Uc18fSlAJDtQ7h8NJsVHg6cUfdAz9OmE/IfUPTZPDXGVoJa
         vQ7nAq+RtNr4jM38GpgSLAI7ea80OaUC+sCn45anU9UKXiQQdMaidL2f5Sh1zAkAJ7EI
         zqfA==
X-Gm-Message-State: AOAM531QJFLmHimdPLZLGDzYk4vPQ+88ncFbE/twDcWzg1PvT+al9G2c
        uTCmmL/w52fgayc49hs8KGM=
X-Google-Smtp-Source: ABdhPJzDsB1YA461lMwbHjTGR0CKQCkjiG1TZuMIxp9idkw84b3iOAPW8tV0s30nXy21JyMFMKSZYg==
X-Received: by 2002:a17:906:7009:: with SMTP id n9mr7455764ejj.431.1637672829663;
        Tue, 23 Nov 2021 05:07:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sd2sm5644258ejc.22.2021.11.23.05.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 05:07:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpVVs-001NDI-8W;
        Tue, 23 Nov 2021 14:07:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] Makefile: add deprecation message for strip target
Date:   Tue, 23 Nov 2021 14:00:43 +0100
References: <20211123122934.639428-1-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211123122934.639428-1-bagasdotme@gmail.com>
Message-ID: <211123.86a6hvuikj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 23 2021, Bagas Sanjaya wrote:

> Now that $INSTALL_STRIP variable can be defined since 3231f41009 (make:
> add INSTALL_STRIP option variable, 2021-09-05), deprecate 'strip' target
> to encourage users to move to $INSTALL_STRIP. The target will eventually
> be removed in Git 2.35+1.
>
> Only deprecation message is printed.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 12be39ac49..ee83860f7d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2159,6 +2159,8 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
>  shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
>  
>  strip: $(PROGRAMS) git$X
> +	@echo "The 'strip' target is deprecated, define INSTALL_STRIP if you want to"
> +	@echo "install Git with stripped binaries."
>  	$(STRIP) $(STRIP_OPTS) $^
>  
>  ### Flags affecting all rules
>
> base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc

This is a better way to do this:

diff --git a/Makefile b/Makefile
index 12be39ac497..fd4736dff2f 100644
--- a/Makefile
+++ b/Makefile
@@ -2159,6 +2159,8 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
 shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 
 strip: $(PROGRAMS) git$X
+       $(warning The 'strip' target is deprecated, define INSTALL_STRIP if you want to \
+install stripped binaries)
        $(STRIP) $(STRIP_OPTS) $^
 
 ### Flags affecting all rules

I.e. GNU make has a built-in way to do this which emits the line number.

The message also needs to be reworded, now it's telling me "do xyz to
..." do what I just did successfully? It should say something like

    you just did X, but doing that via Y will soon be deprecated, do Z instead
    to accomplish X"

See also:

    git log -p -G'\$\((warning|error)' -- Makefile

For some recent-ish ways of doing phase-in deprecation.

Personally I think just starting with $(error) would be fine here. If
someone needs to adjust their build system anyway they can just adjust
it the first time around, it's not like a missing feature in git itself
where the carpet is rudely swept from under you. You'll still be able to
build, you just need to tweak your recipe.

The real value of $(warning) (or the same with @echo) is IMO something
like 6cdccfce1e0 (i18n: make GETTEXT_POISON a runtime option,
2018-11-08), i.e. to give someone a hint that something works
differently now (although I'd probably just make that $(error) if I was
doing it now, with the same rationale).
