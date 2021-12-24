Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EA6C433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbhLXRKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhLXRKo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:10:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603D7C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:10:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o20so35350199eds.10
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=37pHjeCjIunvehGq1VrZXUEdzkYG1YkHe/3ugvTa/AQ=;
        b=QxbEEB+OAZtgd4yPf7kCCzeWg5q6LiK8LUI1J1o9WcGsTSzQUJFxHfV8cjd/tHotWs
         2Gxrxta4sWIrApdkO6a1QfDDZN/hR3NS7bKIPsMGlhSIV4hmSfI8ZlowF6iXyqe97en+
         mS0LGMynmAJkJY6/5kfTsf2v7qSvtKAf03N3g3g1tRHDKChzRf6NVAGMNcf2ZfyxG7Rd
         Lu1AlMHNg3tm23eKBI/dQNKtiT/3m+poNSvzkMYjrtitlTtEtk7K72TQV5FUkIgEudRx
         DVrQhkhzfGWqWDFLf97D0SQ9WhwY3ObAtUASYfYOAdXuqKsBVb177F8iQ88KnbGjRgm7
         H1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=37pHjeCjIunvehGq1VrZXUEdzkYG1YkHe/3ugvTa/AQ=;
        b=LVaO4h4hHcLHwTnNvl0uPI/A8t/U0NFggP/ToSiiwC3mE1JcJbavDs+oYM99uxt47r
         XSPiR89d8KgPAhRU7bKYctwGvIy80kkjbjUAFeXb5GH5OkQbpMJL5458X7cGC6Rgzc08
         /x1gb4yyskVRv0Q3PaLNAoCe1IGMUS88OJInnrjIhseXekpq2OF9+szgEWM8OrvAM21B
         L6i9HeebRiUIZsYPZxUP9/vHoi31wZKQEDgANpiXjlMQS7CaycjhWPSETkQMWfFYsVcH
         3E9Vynk9uyZPoV36PtvqGGdQa5zUDNlkVPz8wB8g0LriMZX0OJdfscspvkwMWa+o10HD
         1iSw==
X-Gm-Message-State: AOAM532053pUgvei9BlJ1gKfGpsUaQcjattST4k8c/fAWgD3WwKrrJTe
        8Cqs1bVKHJasNhlnM8N/axoxJ1NAS6/S+Q==
X-Google-Smtp-Source: ABdhPJwHqv+ddgWVHpXlg/j0EOXKK7uBx2R5dvOCYHQEp8AK5jtOUUFq4qJih6RE5LehnHQEHhDmyQ==
X-Received: by 2002:a17:907:e86:: with SMTP id ho6mr5862352ejc.126.1640365842744;
        Fri, 24 Dec 2021 09:10:42 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id a3sm2848814ejd.16.2021.12.24.09.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:10:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n0o5Z-0002nT-LV;
        Fri, 24 Dec 2021 18:10:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Daniel Vicarel <shundra8820@gmail.com>, git@vger.kernel.org
Subject: Re: Why does "merge --continue" expect no arguments?
Date:   Fri, 24 Dec 2021 18:08:32 +0100
References: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
 <xmqqlf0dq3t3.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqlf0dq3t3.fsf@gitster.g>
Message-ID: <211224.86mtkqgc8e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Junio C Hamano wrote:

> Or we could throw in another
>
>  * document more clearly that "merge --continue" is a mere synonym
>    for, and hint that there is no reason to favor it over, "git
>    commit".

But it's not:

    $ git add foo
    $ git commit -v
    hint: Waiting for your editor to close the file.[...]
    ^C
    $ git merge --continue
    fatal: There is no merge in progress (MERGE_HEAD missing).

FWIW I prefer and use it for that reason, i.e. it's useful for scripting
to use these "stateful" commands when we're in some sort of rebase/merge
"sequence" since it's an extra layer of sanity checking.
