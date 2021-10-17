Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316A5C433EF
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 16:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106B261054
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 16:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbhJQQSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhJQQSO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 12:18:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F3C06161C
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 09:16:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y12so62253440eda.4
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=e7QTwb8Sa2PUtQE8nnpvgbm7PNAaFIxTVPQFMSC42wQ=;
        b=APkfHXHfupUXvXTSKLLybpbhLpTcpcNziGq08bl+zNVUZlgeEQp2POgT8M9JSVjEB7
         siRKLK6nAjqwR3LemP7qYNfwOvvJ3m97Ak626Ez9pN83joF5vokQjfdN9UeckUxyeb2z
         gfBMicLLjemubVZyivuB0bYoeP9Lrou8zqL3uAAeagtj02IWewBY7hxqiEkdR28XDXWJ
         BTqwN4F4P+/g8CmNw1TIWhi1Yd30N2xZTtZglh4LFgEAXSCG2vUlFeS5OTl253xxzhBY
         62IXAuJhd83qkZckU9SjmiTSNQyc6FEPWNbmAvDhGoFYmDMpzvECQlqSEX9CbY5OItHo
         tutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=e7QTwb8Sa2PUtQE8nnpvgbm7PNAaFIxTVPQFMSC42wQ=;
        b=a+rx8iUiFqcHEHHKfBckKE9bMT6vDTu3eZDT+p4foZSjLO1QoCnDEIe+AbAtDDtFJi
         w/vIzSGcH/6ZeGLGLz4numVDAq16OP3BvNJ/W0fFld5rBKne1Eml53rr6VjU/wV7jM3o
         lXKrfFxVvYynsr50uLOeZnxaya5G7vlOTF0Bf/2MFfltBkRRhrFwPDgk2ziKJYCGJ02m
         no2EnpjL7rNJy/+8Y2oMecf7Uw6UlQLPbgiDxDkhWAEjJVV1bls8gb50/Cy2Hu0cnTA5
         qUTqCbCFT0D68g0SaQNzNDMmrFTC6/A7h/SDpq0UPnynJjCN3yRNReWfLxs+omRCZXdH
         Niuw==
X-Gm-Message-State: AOAM530V4nVo9DqrW8BBs4JtVIGGmOu+AdzSMQ3Etjm/WfqRRc27mvj3
        4AOIV/1BAGUf/Wiatgf2Kr1Hg4ciQSo=
X-Google-Smtp-Source: ABdhPJyrYb5Ui33+j0O5GqUvEtBB6wGyv+6XgNp0C0n8Jp4UmoPckru27EI+ik1kdVN0Tcqik4ZsTw==
X-Received: by 2002:a17:906:6c83:: with SMTP id s3mr23738039ejr.13.1634487362896;
        Sun, 17 Oct 2021 09:16:02 -0700 (PDT)
Received: from evledraar (2a02-a450-3911-1-baca-8adf-a579-e89c.fixed6.kpn.net. [2a02:a450:3911:1:baca:8adf:a579:e89c])
        by smtp.gmail.com with ESMTPSA id e15sm7724403ejr.58.2021.10.17.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 09:16:02 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mc8pN-000BWf-EY;
        Sun, 17 Oct 2021 18:16:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     milan hauth <milahu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: force deterministic trees on git push - exact sort-order of
 filenames
Date:   Sun, 17 Oct 2021 18:10:27 +0200
References: <CAGiEHCtdjA+cVXjN43NPbSZfrDtr-kDtPMN4x_VTGSJuPZ8bcg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAGiEHCtdjA+cVXjN43NPbSZfrDtr-kDtPMN4x_VTGSJuPZ8bcg@mail.gmail.com>
Message-ID: <87ilxvd3uw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 15 2021, milan hauth wrote:

> backward compatibility:
> rewriting git history is usually not desired.
> so this new rule would apply only to new commits
> after a certain 'deadline', set by the git server

Others have commented on the status quo, but just on this: "git fsck"
will report these, and if it doesn't that's a bug. Grep for
"TREE_NOT_SORTED" in git.git for the code.

But in general this sort of plan for disallowing "bad" data doesn't
really work all that well. People want to e.g. switch hosting providers,
and will need to re-push old bad data with a new push.

I suppose there could be more strictures in the fsck code to allow for
that use-case, but still make some things that are mere warnings now
hard errors (or "fatal").

E.g. allowing it based on a more thorough inspection of the history, or
treat commits differently if their envelope timestamp is past some
cut-off (which right now we don't care about).

For a self-hosted installation with some specific old bad data I was
also able to turn on tighter strictures and whitelist specific OIDs with
fsck.skipList, I don't know if any of the big providers use that.
