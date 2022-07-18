Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D663C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 10:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiGRKWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 06:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiGRKWc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 06:22:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3051D325
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 03:22:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x91so14611512ede.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/B6roQWNlwh+gD2vCA+voFXqgmcGeWtugI1ZuLjj8KU=;
        b=laSGA5U86HxcvMjP1PSocgD3jNUUa2/A64pqNxM8IHqqmIoyNR11tqDnPhGqaJvjCW
         7gfemNoki7HyWhs9NlFLYsk18SEx0wBb7NmaimFYmtbsBtd9Qg/P8NtJtF+kWOgsMqlp
         aWD4FjBnDRcGdiLzjACLtm3DGZNJXPKaz+Ud4j3GO0ciodF4eV30BRb9HPHctv6jWkwA
         JpyAJ4Hlk9YrkPgaCkBTr7Q63+SxpDzETh8+nIwV79wePyDtQgDNMW3Jbqz4pYdA1nUq
         OuMN+SIdbZc4FeUfj9P5/o01lvgGfJnsKMOsXVNoKDbY+OthaGVNvn6EUKOfQzH9kVO+
         k68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/B6roQWNlwh+gD2vCA+voFXqgmcGeWtugI1ZuLjj8KU=;
        b=qZ9OBzx+MSLlSg6C55aGnhEsBQW8DqQrf/NrJu1o8tiEcRAJdBJ5k6yrVymNbTccXk
         bwa9VDuAzEp5YAhMZw5ci7axoWmULeYLL+ttyM2ZFnBx7NnW3PIK4Ehaq7bdQd7Y7YP+
         SYheIF4kaa/UFOSx1bCB4V0aHshB8CQJv3Twe76zhzMXxVxQ9pSqI0ZK5qrGu6GIPN03
         N2LV84clpw2zWmzl9c7W0ToULKAI6eO9qu2rteNiEEuDSXyaeFROzuxMR6YFzTQrkafi
         wCLlUe1NqBSuMJWyVH99ks/h+ri4J1ymDyaEGzeaZjbifo12STOg7D/jIIR+QHr09kk2
         /7hg==
X-Gm-Message-State: AJIora/toFhfS1bAQzkZoEIviOfsIWGRVazL+pjPMeb/0/iw6hSeHsPn
        x+ApGzLvDnUBYcP3IZ2/v6vVJ/3y0ck=
X-Google-Smtp-Source: AGRyM1s0HYxUkBDQxrMIpLanlxKa+8mctJanM6KmJZiV+ai+hqHApC06Y4Ewm4YaGf4O7ibbJnJSWw==
X-Received: by 2002:a05:6402:194f:b0:43a:298f:f39c with SMTP id f15-20020a056402194f00b0043a298ff39cmr35698822edz.106.1658139747902;
        Mon, 18 Jul 2022 03:22:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ek9-20020a056402370900b0042de3d661d2sm8248948edb.1.2022.07.18.03.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 03:22:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDNtS-003392-Ht;
        Mon, 18 Jul 2022 12:22:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <jch@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>
Subject: jk/diff-files-cleanup-fix + related un-picked-up ab/* (was: What's
 cooking in git.git (Jul 2022, #05; Sun, 17))
Date:   Mon, 18 Jul 2022 12:15:00 +0200
References: <xmqq7d4bt8n4.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d4bt8n4.fsf@gitster.g>
Message-ID: <220718.86h73eyb31.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 17 2022, Junio C Hamano wrote:

> * jk/diff-files-cleanup-fix (2022-07-12) 1 commit
>   (merged to 'next' on 2022-07-13 at 9db5235d01)
>  + diff-files: move misplaced cleanup label
>
>  An earlier attempt to plug leaks placed a clean-up label to jump to
>  at a bogus place, which as been corrected.
>
>  Will merge to 'master'.
>  source: <Ys0c0ePxPOqZ/5ck@coredump.intra.peff.net>

(As noted before) that fix looks good, thanks Jeff!

But here's a gentle *poke* about picking up [1], which is a related
follow-up series (but applies directly on master).

It fixes some other minor issues in my earlier release_revisions()
series, and then goes on to fix other common memory leaks that didn't
make it into that initial series.

These in particular & somewhat tricky or non-obvious, and could use
careful review:

    https://lore.kernel.org/git/patch-4.6-9bff7b10197-20220713T130511Z-avarab@gmail.com/
    https://lore.kernel.org/git/patch-6.6-4a581a4a6ce-20220713T130511Z-avarab@gmail.com/

The latter of those proposes to fix what's a common leak pattern in the
codebase in a particular way, I'd be interested to know what people
think of that approach.

There was a related earlier discussion between me and Glen at:

	https://lore.kernel.org/git/220713.86o7xs3g76.gmgdl@evledraar.gmail.com/

I.e. whether we should do an xstrdup() (or equivalent) in those cases,
so we wouldn't have to mix up free()-able data (strvec etc) with
un-free() able (main()'s "argv") in various APIs.

There are more drastic ways to address it, but I think that 6/6 is the
best trade-off in terms of a narrow fix & fixing that class of leak.

1. https://lore.kernel.org/git/cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com/
