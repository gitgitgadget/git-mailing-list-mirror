Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 811C11F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935953AbeFRTZK (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:25:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36347 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935692AbeFRTZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:25:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id v131-v6so17695634wma.1
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pDn+sS1BHqHi6rTPpJ7WR4BqeAAk2mmtWfxfo4w2QWo=;
        b=W/5MVByCaplWIKOgubV3E3qk2ze1ROhZWyrs8l2pnNv6HtEOLoZbnpmjB7bBwjXqUW
         qU4C58oSK6c8JnIl0pvx8gBZHMpvVbkK6RuMQFuDJvWd94HCG61Z6c7VsZK1uuzKgbXR
         OYSebNMDEh+Tmg21qF3XPs1crq+84Mkj/vp2P8lPpLQvzhg6f7MKNSCD1oHAdDbqKpiQ
         5RHi/MvQzxCmUVtj5fdY8UrPhmAwTipdhFBCyATscxbXjrtif5T1APp0QNHPtB5DLiWa
         hpFqNmT67VLl7RiMfVt6X52yu/gL9zLREBoN4PsYUjk9OdnZtXBpYyZ3PWl14xcvSS5e
         KAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pDn+sS1BHqHi6rTPpJ7WR4BqeAAk2mmtWfxfo4w2QWo=;
        b=qS0EIdYGR0gHikeJ+6r9Z3YSgEZhAm2+Qi9hPpRe1yL2ypkqO/KT9vVI+q5FzQANTD
         MMHZhPOxGHB1wQZbGIUoiAIf4QS2j8LFoxdE+LGPffU+iOiCysPnssOEjByvzUxJM2iF
         7z4tFBsO5hLZGb4VUII8DS9+Oyb6WqronGre0JDtjDov3weysOFj93u33tpoY5bc2sxY
         uWqwabzqCSqitiC3NfOYxtj5A++0JMTGR/+v83TgIFakDrqu08hqRkCvuRT1d2ko5jke
         PLdLdXviUp84xTMtFbr5capYX0mOp7IENtxdOzLPUd5LgbolK+XHkcLlxGHXpfYu5OG8
         ASdg==
X-Gm-Message-State: APt69E3nB8FnQvCsIPYjtuDStWS1KqJcf+FHEmd5do7P6a1m2ua2GZPk
        C9HwaK+kst6CHntNTskpd7U=
X-Google-Smtp-Source: ADUXVKJ4kZOn4nJQgbizcsOjal6+70zAFm4M5tuThQAg/oovUoPij7+rIdQzyTm09qMb5Yoi5rJi0A==
X-Received: by 2002:a1c:2d15:: with SMTP id t21-v6mr9206057wmt.42.1529349908032;
        Mon, 18 Jun 2018 12:25:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p10-v6sm7177460wmc.17.2018.06.18.12.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 12:25:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] rebase --root: fix `reword` on a root commit
References: <pull.3.git.gitgitgadget@gmail.com>
        <20180616201143.GH11827@zaya.teonanacatl.net>
        <xmqqd0woxdz9.fsf@gitster-ct.c.googlers.com>
        <20180618164140.GN11827@zaya.teonanacatl.net>
Date:   Mon, 18 Jun 2018 12:25:06 -0700
In-Reply-To: <20180618164140.GN11827@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Mon, 18 Jun 2018 12:41:40 -0400")
Message-ID: <xmqq8t7byk19.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

>> Offhand it is not clear from the proposed log message where the
>> original breakage happened, but if this is to fix a regression
>> between v2.17.0 and v2.18.0, then let's have it.  As -rc2 slipped
>> for a few days, it is reasonable to delay the final by a couple of
>> days as well, if only to give the last minute fixes and translators
>> reasonable time to breathe.
>
> Perhaps replacing the first paragraph with this would make
> it clearer?
>
>     Since 21d0764c82 ("rebase -i --root: let the sequencer handle even the
>     initial part", 2018-05-04), when splitting a repository, running `git
>     rebase -i --root` to reword the initial commit, Git dies with
>
> Alternately, a similar note could be added at the end.
>
>     This regression was recently introduced in 21d0764c82 ("rebase -i 
>     --root: let the sequencer handle even the initial part", 2018-05-04).

These certainly are ways to require one less hop to the readers than
the original ;-)  Having said that, I've already merged it down to
'next' and want to have these in 'master' before final, so no need
to further fix-up the log message anymore.

Thanks.
