Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D0EC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 14:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiKUOKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 09:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKUOKM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 09:10:12 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7681CCB950
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 06:06:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gv23so28795120ejb.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 06:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ggVZ5S1lVaCDIqL5I8IdLODwTqd+lYthFaCpjywoFA=;
        b=n1oYi1JiNYuZSR2afdG6Ucmcv9OctUDW1DS58/kTnAld1kXdxORR3LIcd9SUuiKnXK
         9xzFUpSkSPuPs2LDhIfGbf1oYOpIFpbIcjUWjnRWbwLNAXYzqD8FxRt9UlocCA8v49cy
         adZOllomB2YVrPd53UJRhHOCYFtBoMVfQx/UWUurdIEuteNKCFGW1gD/ST82d6Zpyh8e
         ttcKkNoOcptx7mjs4hNjdPjPCmuuVyk6j/CpwDiFmSMp4Wx6sRzNcG+4lihqGs+YNHc4
         lUeWlXKoI4nDpnaYGmbg3f9KcJhxzhklFHHWEe87PgoAu7o1R3i8+WTuTUFXbCsoJ+Yx
         itug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ggVZ5S1lVaCDIqL5I8IdLODwTqd+lYthFaCpjywoFA=;
        b=4Ok4cYGAbqkWCs+xqrOXx66jsIA+Lax3eypQwcqv6Tc4nSOvxTfsjWK2MQz4FZLdw0
         SgGBLJInrL9i0uNxNeFJBRenyrIS2Jh0Jz/NAHRnA7B6B1GCWw2ulO/aoW+8MpICC/zm
         pH27dwWg2gZQ7IUNv0lEg/lElimpfnZ5xdL2qIGpKJfpSJrl18cglaDbDFVu1mH4GW8M
         83gjtgLzKj22rAFLRMVqRkOx7pvRdKOBOQwll3QKedOGH8vTlJmAByzqPHnGPo5v81zr
         nKXBhyyq242s5zCMA42VCi/rmCXTXMD0Pviie9R6vI+LD7aAyKxqSVrdZuMfy32LlhDQ
         hqLg==
X-Gm-Message-State: ANoB5pnP7gzdaB2g3njONBb9s+xZmBIOs9ZbKM3u6szQtcJ3IMTXMnH2
        XFhUQqNlezVDw/6Plsg+hDw=
X-Google-Smtp-Source: AA0mqf4nF/LyhILeZH6Kpb5F66QC9dsUxexyUswPNubJOCTdwo153LXblBrwM5CEYnyoRFFeSJw2Ng==
X-Received: by 2002:a17:906:e0d2:b0:7ad:b45c:dbe1 with SMTP id gl18-20020a170906e0d200b007adb45cdbe1mr16096530ejb.726.1669039590984;
        Mon, 21 Nov 2022 06:06:30 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id cw24-20020a056402229800b0046730154ccbsm5305133edb.42.2022.11.21.06.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:06:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ox7RN-000APE-36;
        Mon, 21 Nov 2022 15:06:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] config: introduce an Operating System-specific
 `includeIf` condition
Date:   Mon, 21 Nov 2022 14:51:22 +0100
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
Message-ID: <221121.86pmdgbdwa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 21 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is relatively common for users to maintain identical `~/.gitconfig`
> files across all of their setups, using the `includeIf` construct
> liberally to adjust the settings to the respective setup as needed.
>
> In case of Operating System-specific adjustments, Git currently offers
> no support to the users and they typically use a work-around like this:
>
> 	[includeIf "gitdir:/home/"]
> 		path = ~/.gitconfig-linux
> 	[includeIf "gitdir:/Users/"]
> 		path = ~/.gitconfig-mac
> 	[includeIf "gitdir:C:"]
> 		path = ~/.gitconfig-windows
>
> However, this is fragile, as it would not even allow to discern between
> Operating Systems that happen to host their home directories in
> `/home/`, such as Linux and the BSDs.

This looks like a really sensible thing to do, thanks.

> +`os`::
> +	The data that follows this keyword is taken as the name of an
> +	Operating System; If it matches the output of `uname -s`, the
> +	include condition is met.

Here yu say it "matches uname -s", but later in the test we can see
that's not the case. This is because compat/mingw.c is the source of
that "Windows" string, which we use for the uname() at the C level.

I don't think we've needed to document it before, but we should do so
here I'd think. Per
https://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
users would follow these docs, try MinGw, then be confused, no?

> +static int include_by_os(const char *cond, size_t cond_len)
> +{
> +	struct utsname uname_info;
> +
> +	return !uname(&uname_info) &&
> +		!strncasecmp(uname_info.sysname, cond, cond_len) &&

Our config.mak.uname doesn't to case-insensitive uname matching, and
AFAIK these don't change between platforms versions. So why do we need
to support LINUX, LiNuX etc. in addition to the canonical Linux?

I'm not opposed to it if there's a good reason, but as we have "gitdir"
and "gitdir/i" shouldn't we make that "os/i" for consistency, if it's
needed?

> +test_expect_success '[includeIf "os:..."]' '
> +	test_config x.y 0 &&
> +	echo "[x] y = z" >.git/xyz &&
> +
> +	if test_have_prereq MINGW
> +	then
> +		uname_s=Windows
> +	else
> +		uname_s="$(uname -s)"
> +	fi &&
> +	test_config "includeIf.os:not-$uname_s.path" xyz &&

Re above: If it is important to support LINUX etc. these tests should
check it, they pass if it's converted to strncmp().

> +	test 0 = "$(git  config x.y)" &&

Hides segfaults, use test_cmp or test_cmp_config?

> +	test_config "includeIf.os:$uname_s.path" xyz &&
> +	test z = "$(git config x.y)"

Ditto segfault-hiding.
