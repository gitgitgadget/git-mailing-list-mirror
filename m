Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35411C43217
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiK2BK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiK2BKz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:10:55 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2923EBD
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:10:54 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d18so1112896pls.4
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCl2R7Quv09pALeKEnAPQuDZglyovDWA2DotXCk3EO8=;
        b=o/+Sua4F0tVJ5Mx2jbEFf4SbhlrAFxhqMjHaQLhaNqQURm6FEhtnkShKOxaQOznxVT
         GDRm7SGwga9GRD/L1OsEDJT5f92gAkZ9T/k6lfEpMei0WysK9V6M2DsaQQy0/J5S4xuU
         inoVwFVlmb9l5lYI5lmWDmJPPN+aBtWUf4JjjId8UyoNdoICmxFPS6Dll6pKnEYLkKJl
         4f+rlglCltCJJV6xyzrjASDN7YYP8sAHdfqUqiXzBIZGXbhRzZgLgy28P58uglDILEV4
         rqGQQofC9xLbUdQ/CIY8pBdtQAe2biJ/QiII5bv5vFF3oSKgQMS3ZucQjQuJgR7zS9S2
         gLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OCl2R7Quv09pALeKEnAPQuDZglyovDWA2DotXCk3EO8=;
        b=FxG8z99AoBAyJwYP3e7VmLBG8kHtkvLmDKwpYJGc0XJ9jx7k0HkiTsMh4NUYdWEU/r
         5QFfHIuE6NJ9UOOhmel/KWmn8QXMo2W7zF/I3eWLvrZupR6fevEwCg56SsRpwYX0lGjU
         kuzwSOb58v8jJZjI69SJptEe8YKaf3n6SaZUELiAQqjpPHzOsNwFR3WJEnWoWrn5UcUf
         yYIdggegk+shvBDVLn9h9uO7oIyN+52dujjNOT2PsMkZ5hdkMa1Q0gtIA+4qcpWV0ITR
         DX+jWFiMovEraRb7pBtAfMZG509bkrbPTHvqVYgAI0N8pKK79kU9Ke3gaAA3G+epbTpC
         5wRw==
X-Gm-Message-State: ANoB5pm1gNTVD/Ftw7u+dn4Nuxlk19YDh01bKDol6uf1R/kE8Q5L7SU9
        53qKkJnSvpsh9r4fsbYHCkw=
X-Google-Smtp-Source: AA0mqf47EIv0cXh+CJFp83CL7LrBkthqa+W9kfYJICAC22hxDNySbzyyPJqeQMYi7NvrB57uCUf8Bg==
X-Received: by 2002:a17:902:ce90:b0:186:ab02:664c with SMTP id f16-20020a170902ce9000b00186ab02664cmr36678891plg.49.1669684254292;
        Mon, 28 Nov 2022 17:10:54 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090a644a00b0020a7d076bfesm108857pjm.2.2022.11.28.17.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 17:10:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option
References: <cover.1667980450.git.dyroneteng@gmail.com>
        <20221128142032.71179-1-tenglong.tl@alibaba-inc.com>
Date:   Tue, 29 Nov 2022 10:10:52 +0900
In-Reply-To: <20221128142032.71179-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Mon, 28 Nov 2022 22:20:32 +0800")
Message-ID: <xmqqzgca4lb7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

>> Teng Long (5):
>>   notes.c: cleanup 'strbuf_grow' call in 'append_edit'
>>   notes.c: cleanup for "designated init" and "char ptr init"
>>   notes.c: drop unreachable code in 'append_edit()'
>>   notes.c: provide tips when target and append note are both empty
>>   notes.c: introduce "--no-blank-line" option
>
> I'm not sure if this patch series should continue, and if there are no
> updated comments it will be temporarily suspended.
>
> Thanks for the reviews on the past patches.

Taylor, This topic was marked to "expect" a reroll in the second
issue of November "What's cooking" report you did.  Do you recall
what remaining works there were?

I personally do not have much opinion on this topic, other than that
"--no-blank-link" would be a horrible name (i.e. uses concrete words
to pretend that it clearly describes what it does, but is utterly
unclear where these blank lines are etc.) for the feature to help
end-users discover it.
