Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A38D1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 01:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeJ3Kfu (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 06:35:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42712 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeJ3Kfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 06:35:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15-v6so10755104wru.9
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 18:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=64szQO+vQ7D5teQnW6UZAb4q6XsnXpOYNXJ9SEQUFL8=;
        b=DJ5CRzw624x8+KEopJHBC97JFkNhvPraSdjsaT+yxoimaeQfzwdIibP5T1RPYtU4du
         im2+bH8MDOiQjrhK8omh77VAMg+ILiwab992aM2uxFhAmcdMFG2FWDeEbTuYeehGCXeJ
         EGr86LX5081JF2uK3krnzSzW5uwSnjFuVDdy+NGEh/CtRsV/WU+n7Thb3mZQyPjDzYht
         nKDCoH7x9ETgL+IY7lsfNneyr38XE1FrhubIkhKOftRb3ZOVq+E/MaurUqPQV7Y2XoJ8
         uR39JFxL5VWSjXaLvq5skyLLyzkI7WKHoc1MnI2YVeOElJZAMaPwvA+/g+tG0kH8wv3r
         KR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=64szQO+vQ7D5teQnW6UZAb4q6XsnXpOYNXJ9SEQUFL8=;
        b=ebEI5otrjRR8btnX5TRmbzpifZTKC3gk4McOIuobjBFXAZQ0A6PwkIcin3Hm49CxmZ
         C0+hYJbUGY+kk0ekBv8jkqjXeA5mEPu/cYcMTwyZ8AJy4sDv6KI47lVEsv/ud+K1spZk
         AFFi6qEPRS4gOjMqtyjQNPVNJd2ga6Z5FNDQE2Wv52apq+3yQZwqx/GUB1SFFqr7J3Ie
         MX2zCV7b+aYSjpTlAbxkDqEYaeULrtB97kuvoQCItkEPk5+NQuWbza2HzJgRq9Z2NPlx
         /KTBF3Tm37GxuhzhjEVy/sXlNC1ZdqbG60je2F0pp6OoR+nwOtexU9a0UU+27bRkF9G7
         NZig==
X-Gm-Message-State: AGRZ1gLX67HTnu+rw4y32RaGb6DALXMuxl0exUbRfpN5uzGQ+si7qQst
        tefBDshRY5DsGYRfrJAe190=
X-Google-Smtp-Source: AJdET5fR3lQYtkUQOEunlBqC1F0TgOFbwOMf8s8YU64Q48nh/F8Wjjdb8txUG6XxQ3hXqIlte/5Xaw==
X-Received: by 2002:adf:cd8c:: with SMTP id q12-v6mr16714464wrj.171.1540863866908;
        Mon, 29 Oct 2018 18:44:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b16-v6sm3162142wro.56.2018.10.29.18.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 18:44:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/10] read-cache.c: remove #ifdef NO_PTHREADS
References: <20181027071003.1347-1-pclouds@gmail.com>
        <20181027071003.1347-10-pclouds@gmail.com>
        <9e489011-36b9-a8b3-838d-de1a097f4854@gmail.com>
        <CACsJy8BD8nUfJoNjWCnaYgUn5+LaunOx74AgwPf5okG0OhwEXw@mail.gmail.com>
Date:   Tue, 30 Oct 2018 10:44:25 +0900
In-Reply-To: <CACsJy8BD8nUfJoNjWCnaYgUn5+LaunOx74AgwPf5okG0OhwEXw@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 29 Oct 2018 18:21:30 +0100")
Message-ID: <xmqqk1m02op2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> This shouldn't be needed either.  My assumption was that if someone
>> explicitly asked for multiple threads we're better off failing than
>> silently ignoring their request.  The default/automatic setting will
>> detect the number of cpus and behave correctly.
>
> No. I can have ~/.gitconfig shared between different machines. One
> with multithread support and one without. I should not have to fall
> back to conditional includes in order to use the same config file on
> the machine without multithread.

Our attitude has been to fail unsatisfyable requests from the
command line loudly to let the users' know, and tolerate having
elements from the future versions of Git in the configuration file
by ignoring them or tweaking them (silently or with a warning).

So this hunk is in line with the current practice, and we should
keep it this way.  It is a separate discussion if we want to rethink
that whole attitude, that discussion may be worth having, and I
think that discussion is wider than this single topic.
