Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B667720401
	for <e@80x24.org>; Sat, 24 Jun 2017 18:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbdFXS7a (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 14:59:30 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32817 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbdFXS73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 14:59:29 -0400
Received: by mail-pf0-f178.google.com with SMTP id e7so37340313pfk.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 11:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DXyZUKzYMb56iNtv5TrFVCg95QI1pVokUjxXa1uN2jA=;
        b=gmi1LaJXXqj7XwV1KZKIOM4nYOorZbOW3/TLNffhUWlnKwJySAQZMm2RHe9ywo6Y8O
         C7/wqBV3gn7g9CDretD5Fm4LunbGsi61pI87VdRQf7a40Gsbwe/RM2zVl5vSBclR39O3
         mEMU8OtiOpvFKk9Pvi0pZhKukpjJZddXGCg/TLFnD8wTYQ/FpbXtYpP/e5KOGpJzxLGc
         Bw1WgGB5X00Zvl5lTchNKJduv3HBqwVQ8LFG0RAU7lsUxMiviRQilcDRtCXQ0CEs3wNE
         gnWOTUk0nsm3xFovzCycFPI6U7eXaoWOlQBDDqXFyiu1Dk15cUa/Ih5FynKvpmcU76T4
         0Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DXyZUKzYMb56iNtv5TrFVCg95QI1pVokUjxXa1uN2jA=;
        b=tLDa/qBuxjqx1QxHpmVCyTIsb6giqVCFSdirGZw+6qP1xDJQcsxPLeIeUIQhfvLOJX
         Nt7rfpsOhtBTlzz5anqxzgAJ2nXJy1vK3HKfoy2JYghRG1lM0KyyljqbXGD7cJ7EjZdt
         v9Zw03E8M9PZNOBNgKqTK6Dv7DdfBLPml0V/ys1Z29ynId5GDY6tyYExvu1v6HULE13h
         jRErx6Zj9oM7EAuR5h5jkSlGWxXakzbEBhvQ4it2KQX+HUA8GCkabtK0QR24Au5RefWf
         fA1GnDGEus2tstbAHRoMnw9rAnjzTi1HVrocm+mSdtZ8DtRyHzfxl2nA4uQQ+4XJYed9
         Si2A==
X-Gm-Message-State: AKS2vOzG6JiOu/hWeNtIT1nx9Kso5MIIdgWTLi0n16UIreLWr4RlNsTL
        Wy31v7E160gZWzaJwSU=
X-Received: by 10.84.132.2 with SMTP id 2mr15345362ple.46.1498330769133;
        Sat, 24 Jun 2017 11:59:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:c3f:f54c:5646:5c2e])
        by smtp.gmail.com with ESMTPSA id c4sm16960330pfg.31.2017.06.24.11.59.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 11:59:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Crash in t3507-cherry-pick-conflict.sh with GIT_TEST_SPLIT_INDEX set
References: <CAP8UFD0bOfzY-_hBDKddOcJdPUpP2KEVaX_SrCgvAMYAHtseiQ@mail.gmail.com>
Date:   Sat, 24 Jun 2017 11:59:27 -0700
In-Reply-To: <CAP8UFD0bOfzY-_hBDKddOcJdPUpP2KEVaX_SrCgvAMYAHtseiQ@mail.gmail.com>
        (Christian Couder's message of "Sat, 24 Jun 2017 20:51:11 +0200")
Message-ID: <xmqqy3sh8b5c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> It bisects to f9d7abec2a (split-index: add and use
> unshare_split_index(), 2017-05-05) that is fixing memory leaks when
> discarding the index.
> It looks like we are freeing some cache entries that we shouldn't free.

Ouch.  Let's revert the merge for now so that we can figure out what
is exactly broken in 'pu'.

