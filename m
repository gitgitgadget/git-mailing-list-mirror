Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE50C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 23:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDJXHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJXHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 19:07:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8487D1FF9
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:07:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a526499aa5so2757415ad.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 16:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681168061; x=1683760061;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfsR33I3jYFai1PVLdgGk3jw3+RMsLq+oh+mTF6e2J8=;
        b=LhRQV/1fdf8izHneSKUteG03nsDWEg+DE1cHlXvVbzkuNlHZMCcLvtCEYiUQZ7bOyi
         aMr2K7nyfUmF9ZaFzlfkyo6ZC/eSK0HHJ2xWkjHXE327UHHwblSTnJMKJGHEkHD2QTgr
         8w7aY1m3LH1Ke+ZxL/H2iN2ZHvQTywywqAtcJ1HWLw6T4+Mhj87HighYOOWC5WraIqbN
         o6YHurw3RpRV0h+Jjf/4VZ6L0pAOOuR6KYjP1kTyaTnNyCiuO+zrwSKGl8jD1F9KxRWa
         fFixuNh64VHSgoutfH9PVcRFkDTgzxWVSulfreAodPPJIKKkCiHGq0KK67RE0hAEzt9T
         8cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681168061; x=1683760061;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HfsR33I3jYFai1PVLdgGk3jw3+RMsLq+oh+mTF6e2J8=;
        b=aGJAhrDpsbX3qg+Zq0iK3RfG5djPMFw2M1ZzH4ikkSpMBa9OesrD1q8fOaYpquTS6h
         E6K0bWH9uBD57lnJHk2SszJEW8U+yWUWw3kPbCmU/AnVqFlRcLdRkMc34yt4UzCN0ctX
         1D9JuqhuOTBZuJAY9T3aNTLe5c5u8R4Xfr/ThVYRHcB2l6iT7ScsL04cn5l3zTTHm+ig
         JSnp8Owk5/XtBZ/faN3XoiAivxR6MK8SB9O0VlNEddoBIbPeTQoBakuD6J6BA3I+BM+V
         diizkAYT601jVj/8sBFyd12x33PpVC1XWHqL+PpWSooCW1295B0CIc1P2WkTHm5TQ4MJ
         eMbA==
X-Gm-Message-State: AAQBX9cZaYsu099ylWSUI5lsWAwXyYB+OYthvDC/MpHGB+q0sIuja/lO
        9uEHv/crna7SUj+F76aU628gEJCGO88=
X-Google-Smtp-Source: AKy350Yup9TPw74vucWa9PnyY1lhOYnLeaPOofOxC8ghVlhSZS3KkeMtzekyyVppswVYXwShQs90kg==
X-Received: by 2002:a62:1d86:0:b0:638:45f7:7130 with SMTP id d128-20020a621d86000000b0063845f77130mr5257242pfd.4.1681168060888;
        Mon, 10 Apr 2023 16:07:40 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79216000000b005ac419804d5sm8559571pfo.98.2023.04.10.16.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:07:40 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] usage: clarify --recurse-submodules as a boolean
References: <ZDCWrl4GhgYKYFYG@google.com> <xmqqcz4fi7bd.fsf@gitster.g>
        <ZDCwT3mhaGHyydng@google.com>
Date:   Mon, 10 Apr 2023 16:07:39 -0700
In-Reply-To: <ZDCwT3mhaGHyydng@google.com> (Emily Shaffer's message of "Fri, 7
        Apr 2023 17:07:43 -0700")
Message-ID: <xmqqpm8bcp50.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

> It was 'git checkout', if you must know ;) and in such a hurry that I
> also neglected to s/three/four/g. Will fix it with the reroll.

You fixed three-or-four but not the missing comma in v2, it seems.
I locally touched it up while queuing v2, but ...

>> This however is a breaking change.  Even though there is no hint
> ...
>> I am not
>> sure it is safe to change the behaviour right under them, like this
>> patch does, and I wonder if we should do this in two steps, with its
>> first step doing:
> ...
> I'd be happy to do so with a reroll, probably on Monday. It's true that
> while these are user-facing commands which we don't guarantee backwards
> compatibility for, there's not a reason to subject users to that kind of
> pain unnecessarily.

... I do not see how this part is addressed in v2.  You got too
excited by the idea of how to replace the awful abuse of parse
options callback interface with a more focused setter function in
the API and forgot to do other changes you meant to or something?

Thanks.

