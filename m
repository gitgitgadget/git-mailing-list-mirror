Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79C8C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 05:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBHFRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 00:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHFRD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 00:17:03 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFC515C91
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 21:17:01 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z1so18048253plg.6
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 21:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qwoc6+q71Zy3urrKs7ZPu5UUuSlXtVv7E5j4IBFWS00=;
        b=eIs9KlqrJPKXC2EIRMA1n4GhVJDOdCIo6bX3LT843gLHT2bbFef2JxOMVpAn8XQThI
         KABsLSHYev4KvVdidzys0sRzgGGMOD1VFPhNdS9yPE1ZZjXVQRrO1pIwrxnALJ+djd6m
         bpGNvHFcF+OXDEDn9RV8rpS7Z0UA+1MlxzPyB9NmxNTG9MwtoCJcLgGMceCKtRLR8ruz
         nkBphWFY8xY2678pXroEN5eDiDTdAM4SDNmiQUz4cCcI6pG+ypvughsxUMmmhqUgN2Ew
         hOmC7pv2Uh+7zNvGMsNq4czzeTyAMtHVe0qqhmV9mSXiKKZsnfgdAVlDT1n7VpjUgRfq
         aoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qwoc6+q71Zy3urrKs7ZPu5UUuSlXtVv7E5j4IBFWS00=;
        b=QZMTZePFOz1MkkxDN7p0v4Nc2rapptPBFGzgS11g+UCQQ1CR/16deO/HJvvflZzWKk
         C/V1e1LLutwUdoSJYz/Z87GyIT8AypxstjycfvO5637JZU8S6GJoZDLQ1GJMT7zCGSZj
         V0ZhmY1oOFwvzNzdgIlPGrtwf8czk8G0IhKKzSdpCPKkYTz/jyc3nQWwpmaIgi/CASqj
         FKNnOQKgGQxl2n5foUgb5WY95W3uc/GUqyZ6pMtYmg4wF613th0+1XexFl8uHiruPkh3
         sRX/Uq177cMo+tehLRsrBhFK70rT2NqSo4RctZWhM5knSNnoP2CzY0MS6Ag2NFlQxHsP
         AMCA==
X-Gm-Message-State: AO0yUKUObyxx1uqUws6yBWvQWysLEFh5Rl6r1U/kk98BkW4iPvXrA6zX
        2LTgz12HbtV/Q1l8I/h4Y1w=
X-Google-Smtp-Source: AK7set/dGg01BnAb/ewc0jiOtkGuX4nqk30PX7A1k/V753dD6HBK2pV4ufAgV0UqEUEXuLGXsnhZow==
X-Received: by 2002:a17:90b:380e:b0:22b:e5b9:43e9 with SMTP id mq14-20020a17090b380e00b0022be5b943e9mr7057357pjb.25.1675833420583;
        Tue, 07 Feb 2023 21:17:00 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090a34ce00b002311c4596f6sm39105pjf.54.2023.02.07.21.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 21:16:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] bisect: fix "reset" when branch is checked out
 elsewhere
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
        <ada28944-6e9e-d4e7-74c9-ffadaf406e1f@gmail.com>
        <xmqqwn4u2ztc.fsf@gitster.g>
        <eb086063-9e47-9fdb-3644-77a843733dcf@gmail.com>
Date:   Tue, 07 Feb 2023 21:16:59 -0800
In-Reply-To: <eb086063-9e47-9fdb-3644-77a843733dcf@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Wed, 8 Feb 2023 01:30:28 +0100")
Message-ID: <xmqqo7q4vir8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> No problem.  I am sorry because I don't understand what's worrying you.
>
>> that the phrasing of this paragraph is misleading), but isn't it a
>> good thing if in this sequence:
>> 
>>  - I checkout 'main' and start bisecting (BISECT_HEAD says 'main');
>> 
>>  - I then checkout 'main' in another worktree; I may even make a
>>    commit or two, or even rename 'main' to 'master'.
>> 
>>  - I finish bisection and "bisect reset" tries to take me back to
>>    'main', which may notice that 'main' is checked out in the other
>>    worktree, and fail.
>> 
>> the last one failed?  After the above sequence, I now have two
>> worktrees, both checking out 'main', and it is exactly the situation
>> the safety valve tries to prevent from occuring, no?
>
> We are considering the initial branch (BISECT_START) as a branch checked
> out _implicitly_ in the worktree that is bisecting.  Doesn't that
> provide us and the user enough safety?

If that is a question, then the answer is no.  If that is
rhetorical, then I just do not see how it gives us any safety.

In the end, if you allow "bisect reset" to check out 'main' in the
worktree you used to run bisection, the 'main' branch is checked out
twice, once there, and another checkout in the other worktree.  That
is exactly what "git checkout 'main'" in one worktree while 'main'
is already checked out in another would prevent from happening, no?
