Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8699DC433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 14:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiCEO11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 09:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCEO1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 09:27:25 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA80A94FB
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 06:26:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a8so23066016ejc.8
        for <git@vger.kernel.org>; Sat, 05 Mar 2022 06:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jT2PVNPWRjO1thEVZf/zk6cz2MJm1v8chlXhVtuavgk=;
        b=FnDrAKCpgrPpCNwZ7I0Tp14AJQChz/r7fBzLBL/zb3ReZI0MBTg+P36g8NbpKciTzM
         Fgcno5xEQqi3Mt0ePVWXKPRXfFbJig0ymBvN3syooOt7ZNZ/WOtNexpRHVeenZDXFQBU
         w+nF1a6g1h/mo9D1Dl+pcQpzOklAum+fRixphEoi2bXHBz1kxkyltG5Tj0CUdMRiRh7E
         yJKIKWGitTfo6jbRXITix/JZ4NfSX7qS03tEVlipJTlAJtnOM5aHZ0glb5Kczjc83KQE
         nmho3FKoNOjt01OjBowgJmF+jLM4HTWO2epBAHeuS5m9qviY4yKirQyegDzNKvRhnU7Y
         vC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jT2PVNPWRjO1thEVZf/zk6cz2MJm1v8chlXhVtuavgk=;
        b=lkBoyimf5T54PiLqCEzN5BGqSmMR/paBKe6diAwYudT4DiTW2695vMJY5tupFCeXrE
         cSNdTUdipZd4yw6/0UhMJx3nuiWJ2THtnQbjK/25+jzY28WurlJp3LVPxy8BucJZhpEg
         PSrkx674EEiRS3rAr8aPvuCkBENPp5JKUamcptkU4//ZLdH5fDpgXFo2tGM76irLW9Ic
         CpGRXWgJj9WSR2DJRP7nCC8JQ8JnUhYwRMS1Ia8BCuC+LMNURQXnCrzX8qQLUe+HAISr
         ZZdH4ooO1LABJhdufOFw5ywUi1Pc29cH9kBHyR70eSmPjzrsyzK+4lSgCMjJSmObEXQU
         uN6A==
X-Gm-Message-State: AOAM532EKrmDe/1DlEitaxYtGq7mo+WQb9pxKcf8/ARPsmTj8gOYAlsp
        maY0keL9riZMWKMANzYfC7i04jcKOUGH4g==
X-Google-Smtp-Source: ABdhPJxF15TCJ84yfCvCj3q+we2yh+nZIDi4dY1+nryDkBY5Zu34/dCmqj7wfNVvz35G69Nhh0ppqQ==
X-Received: by 2002:a17:906:6547:b0:6bd:e2ad:8c82 with SMTP id u7-20020a170906654700b006bde2ad8c82mr2900183ejn.693.1646490393799;
        Sat, 05 Mar 2022 06:26:33 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm2954151ejz.199.2022.03.05.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 06:26:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQVMe-000XD1-Hs;
        Sat, 05 Mar 2022 15:26:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: jc/stash-drop (was: What's cooking in git.git (Mar 2022, #01; Thu, 3))
Date:   Sat, 05 Mar 2022 15:25:19 +0100
References: <xmqqv8wu2vag.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqv8wu2vag.fsf@gitster.g>
Message-ID: <220305.86y21o327b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Junio C Hamano wrote:

> * jc/stash-drop (2022-03-02) 3 commits
>  - stash: call reflog_delete() in reflog.c
>  - reflog: libify delete reflog function and helpers
>  - stash: add tests to ensure reflog --rewrite --updatref behavior
>
>  "git stash drop" is reimplemented as an internal call to
>  reflog_delete() function, instead of invoking "git reflog delete"
>  via run_command() API.
>
>  Will merge to 'next'?
>  source: <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>

I've been reviewing this closely & it looks good to me, all feedback has
been addressed, and there's nothing outstanding (there's one sub-thread
on v4 answering a question from Phillip Wood asking if the new test
needs REFFILES, it does).
