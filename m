Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B474C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB12B6101E
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 08:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbhI1ICn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239194AbhI1ICc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 04:02:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C8BC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:00:53 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id bd28so18415494edb.9
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RLSQY/2PJYiml3vo+XgtO7geNWq5i3rrUwhmMjGiRcI=;
        b=opKIqwZ9GTZUt6Wrlikeoni7QjQO9bXMIANunTL+c+C+M2/jKzE1pQJXuhk2IvaKew
         VeQiHEQIdX2gYzfG1JVWXBviJo5Gj8VlLqVGjNusrqtW23qpo/+ub0h9p/O90+k0TCDY
         16DkU/+7Ju3nGPrkV0O1KcbGzGzd0hL7P8ymUxUY8u1R7j3rXKPHs5t0/2MgowD9XUxY
         QmzQwG9A9ZqSNCcliknAtWBxTw8AhriKsggIf2u7XR6aieiYop1INDchqFcseZRgvSMr
         nIYSjCnZpEnHkVikhrM4Qjlpwqle7rGO7LHt3B2Y+gju8hG3qmmf+fzxMLyXeB0gP/tL
         IkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RLSQY/2PJYiml3vo+XgtO7geNWq5i3rrUwhmMjGiRcI=;
        b=G1UBSoy6HGE0o5LFFHC41p1ESEXFvg4QJfQIbCTDBP58Px76K5rIuJVFgiqtOB5nnT
         5vHAOU+S/TIju49Kp6tKjl9Ue2/nGlp/OUDpSxv3va0gvRCHJOaAwcPk1m8/WI9Xf+UW
         7gjORxWxvKNjtCI3MkJXLTRmrRHZU4cznSGMl6KsN4QKtvc3UZSUPsiimx/+YeBxvWqp
         wTWhEjvFTApWsyQa2OcauMWUEhzDT0rLa161mgQwTds+xKon38hZlmxad8vQE5EK/eEh
         FCCeSdMBF5ZWjFjggQ/01sREkhAs8KAFIQjkwFzrRYy231qX+Smk/HBmEKkR8vvjde9o
         TQUw==
X-Gm-Message-State: AOAM533z76vhQ/BJKxLk6+4WOaTB/x33vb3yQvxvX7MYtyZS6p0wGoKk
        fm9VNQs7ADddIsV29NuJFI5H7ZfEBLo2Gw==
X-Google-Smtp-Source: ABdhPJzddWHOo1NvIXHuR/1Vyh06HBfcza0he0z3ZM117lIPTioZOf0Hq6SKR2FAhs9py0fndWHWaA==
X-Received: by 2002:a17:907:2651:: with SMTP id ar17mr5161404ejc.15.1632816051423;
        Tue, 28 Sep 2021 01:00:51 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k21sm9628168ejj.55.2021.09.28.01.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:00:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing
 primary object dirs
Date:   Tue, 28 Sep 2021 09:55:11 +0200
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
Message-ID: <87r1d9xh71.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 31 2021, Elijah Newren via GitGitGadget wrote:

I commented just now on how this API is duplicated between here &
another in-flight series in
https://lore.kernel.org/git/87v92lxhh4.fsf@evledraar.gmail.com/; Just
comments on this patch here:

> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index b8d880e3626..9f75a75d1c0 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -288,7 +288,36 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
>  	return t->env.v;
>  }
>  
> +const char *tmp_objdir_path(struct tmp_objdir *t)
> +{
> +	return t->path.buf;
> +}

Not your fault & this pre-dates your patch, but FWIW I prefer our APIs
that don't have these "hidden struct" shenanigans (like say "struct
string_list") so a caller could just access this, we can just declare it
"const" appropriately.

We're also all in-tree friends here, so having various accessors for no
reason other than to access struct members seems a bit too much.

All of which is to say if you + Neeraj come up with some common API I
for one wouldn't mind moving the struct deceleration to tmp-objdir.h,
but it looks like in his version it can stay "private" more easily.

In this particular case I hadn't understood on a previous reading of
tmp-objdir.c why this "path" isn't a statically allocated "char
path[PATH_MAX]", or a least we that hardcoded "1024" should be a
PATH_MAX, as it is in some other cases.

But I digress :)
