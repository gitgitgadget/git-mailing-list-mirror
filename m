Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366EEC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 14:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbiAZOND (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbiAZONC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 09:13:02 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F582C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 06:13:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so69343504edn.0
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 06:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=QWOKVAWuVzBoMuYqr9aJDp7x3YdffLYPSb/WqcuLzc8=;
        b=pcm6XuSHHRP87uB5KNtsxLCPPsQuAVG3qw49XLBH7mmuRW/rsXTWS+UYlg59yTzv17
         z0PZ7il4Kbz4AyUP/HUvBID185mA3mLUVhHDqffbC/AExODIzRQWH64R90YNL9xsspXC
         RyFwq3tQDeEvjey99f8kAK/4/INUMpuP/qbf4CcXYvcppxA6yimq2cXmC4lQYP3L4izG
         wTNeieJxYjag76xQXpn8nNeqw4petRbuzGkHZlmQe6RUzwWGDvsIvgOV5QMj4bmlLnze
         HsIHzm6RiGw9AJSgc7inR17zPKizudrD1wyeSVSU4Vr1w2VHzHGuPflb6TEi3FQ+Cbee
         zDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=QWOKVAWuVzBoMuYqr9aJDp7x3YdffLYPSb/WqcuLzc8=;
        b=Wq72tByBXICrv+ab8LShS+Ejsz0Qd+yWNDuFMOVzVjX8I02j9NUSCoCkoOIteGJ7Ac
         66hNkd46lepZWslspd5fQ9N3PwkK2cCw9mhkY9tFEoWv6TISwc+oathUair4vRGc94B/
         ZNDYtuNKHTVuvXfV+hzsk2bilshD0adVWnmegIAMj0m4/YvvLZ3zZIMZAyUhovICYyqd
         qBkPT1l0PfnUNd78qZGCUItB6q7ZPTbU9tIlgAXH928c60En9kny1DoWNxE7+JlSP7Oh
         kb9ZKuTWs19l0s2isHFQGVr+N63IifqLlocqYRmFrEU07+xdodklDflCMCzgHRpMaRT7
         TbQQ==
X-Gm-Message-State: AOAM533/hSQYoTfOfkWbbkFAFiJLlxYZ5qqqc2cZqd+n9C/BeW8/Fhce
        vE7jNMn8YxXjHIX5me5hT/GIOXtdEdU=
X-Google-Smtp-Source: ABdhPJzF7b8R8HzgiX+Sr2NugbQgCBy7mAkzI2zZO7xAP1ZY8+FDBfe+zN4uYd5B56n7X7Vvd796hA==
X-Received: by 2002:aa7:d3c2:: with SMTP id o2mr25668888edr.207.1643206380810;
        Wed, 26 Jan 2022 06:13:00 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h19sm3512114edv.90.2022.01.26.06.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 06:13:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCj2h-0038r6-Je;
        Wed, 26 Jan 2022 15:12:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        gitscale@google.com
Subject: Re: Submodule UX overhaul update (was: What's cooking in git.git
 (Jan 2022, #07; Mon, 24))
Date:   Wed, 26 Jan 2022 15:09:19 +0100
References: <xmqq35lc53e9.fsf@gitster.g> <YfBTRuPrGGjepe+D@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YfBTRuPrGGjepe+D@google.com>
Message-ID: <220126.867damfuvo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 25 2022, Emily Shaffer wrote:

>> * ab/config-based-hooks-2 (2022-01-07) 17 commits
>>   (merged to 'next' on 2022-01-19 at 594b6da22c)
>>  + run-command: remove old run_hook_{le,ve}() hook API
>>  + receive-pack: convert push-to-checkout hook to hook.h
>>  + read-cache: convert post-index-change to use hook.h
>>  + commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>>  + git-p4: use 'git hook' to run hooks
>>  + send-email: use 'git hook run' for 'sendemail-validate'
>>  + git hook run: add an --ignore-missing flag
>>  + hooks: convert worktree 'post-checkout' hook to hook library
>>  + hooks: convert non-worktree 'post-checkout' hook to hook library
>>  + merge: convert post-merge to use hook.h
>>  + am: convert applypatch-msg to use hook.h
>>  + rebase: convert pre-rebase to use hook.h
>>  + hook API: add a run_hooks_l() wrapper
>>  + am: convert {pre,post}-applypatch to use hook.h
>>  + gc: use hook library for pre-auto-gc hook
>>  + hook API: add a run_hooks() wrapper
>>  + hook: add 'run' subcommand
>> 
>>  More "config-based hooks".
>> 
>>  Will cook in 'next'.
>>  source: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
>> 
>
> Very excited to see this one go in and looking forward to the next set!
> By the way, this reduced the number of patches Google is carrying
> internally on top of 'next' from 46 to 29. :) (All but 7 of those are
> the rest of config-based-hooks.)

Good to hear, I'm waiting on Junio to merge this down, and will then
submit the next step in the config-based hook conversion.

> It might seem slightly selfish for me to include config-based-hooks in
> the "submodules update" letter, but this is actually very important for
> submodules too - without config-based hooks, we don't have a good way to
> distribute a hook across an entire Git superproject-and-submodules
> codebase. With config-based hooks + "config.superproject" shared between
> the submodules and superproject, this becomes a very easy story :)

I'm probably missing something, not that config-based hooks aren't great
& all that, but for this specific use-case wouldn't core.hooksPath work?
I.e. to simply set that in the submodules to the superproject's
.git/hooks directory?

That could even be done with the includeIf + include.path mechanism to
apply to all projects below a certain path, which presumably is similar
to how it would work with config-based hooks.

Obviously the full config-based hook mechanism is much nicer, I just
wonder if it's something you can use as a transitory mechanism until
then.

