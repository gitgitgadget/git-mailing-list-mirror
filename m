Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DCF41F403
	for <e@80x24.org>; Mon,  4 Jun 2018 02:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeFDCTi (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 22:19:38 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38201 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeFDCTh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 22:19:37 -0400
Received: by mail-wm0-f41.google.com with SMTP id m129-v6so11766818wmb.3
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 19:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+a+tsoRvGw+VKahPvSUhwoXQWm+LL+oPWzxmXfmhn14=;
        b=rWKgFmwpu1EI297pHsIAyheRmKgL/SqrlR3+IB3sX6jGirUm1OdmTSYXJbVZ1aB/wA
         iyjBp4Ro1XHXDc9hIUYnLl2Gy5vLXCJ2EI74Bh6jWVxVxGmyrpPV2epcZIz5cDUzHxHE
         cn2v/pWd0mCRyTUjMudIKTT3ftbZBCnU+lNosz/i+01i1udrYufDG65TSz+iHv2EeE1z
         TXgqcgwgmCWS5DEihqStZkmf1IgTlea0qUf7tuEaWu1M5Uqqg1JxlU8l+Y5ONPuqzX7r
         17RuakvPyFz8SnrOunhv7FEokpiCu8qiL37EtoK7NgyIQRejtQlLuMUm9hA8zdz9WcXI
         YYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+a+tsoRvGw+VKahPvSUhwoXQWm+LL+oPWzxmXfmhn14=;
        b=e0wAcraK0Brpv6ZwO2iS/nnNPw7VsrDJITi5JhslQBjg+D3W3z2dH7uDtaRVjNllfu
         wiX9LDCtfgj7CErFH0tcwI94EjqPPyhrlvJkA2sF1oNFJC1B2owOyN4k+cGWeGfSJ48Y
         KKok5fyjV5dC0JzcBUZL0b/aeJsSnp1EcAYWQmbN1E47ckOaD1PXqKp62oOzIBDAOmX0
         Ig731LulQV/EB4xzq2sl3pNWkhgtYqCZY3+8698B0x9bqjhdY7ZL86nPdCfglll3yInG
         HgesfLavtlcsgL2Tgd+BhIhTTJjTCUcoYDYe/Bz7aQtDXG1R29TzW6cAeJ8J/WFNFOST
         9jOQ==
X-Gm-Message-State: ALKqPwf95lB0qGBatw8VaxoOcm1fhIn3MADJLacoZMqFhsPMSn81EDmp
        hWeHLKhxC6VuTBQwOArVzZ8=
X-Google-Smtp-Source: ADUXVKLFliPnaOamBz+a7wZWAhnXz7vkliNXSlOqXXiYwpf/CIjK7Kc+79Hw0KPEQBTHUjdNTgMeAw==
X-Received: by 2002:a1c:988d:: with SMTP id a135-v6mr8489494wme.79.1528078776246;
        Sun, 03 Jun 2018 19:19:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r2-v6sm7856738wrq.55.2018.06.03.19.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 19:19:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller\@google.com" <sbeller@google.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>
Subject: Re: [RFC PATCH 4/6] commit-graph: avoid writing when repo is shallow
References: <20180531174024.124488-1-dstolee@microsoft.com>
        <20180531174024.124488-5-dstolee@microsoft.com>
        <xmqqd0xb9r1k.fsf@gitster-ct.c.googlers.com>
        <95354da4-7590-4fa6-de83-30f883d77188@gmail.com>
Date:   Mon, 04 Jun 2018 11:19:35 +0900
In-Reply-To: <95354da4-7590-4fa6-de83-30f883d77188@gmail.com> (Derrick
        Stolee's message of "Fri, 1 Jun 2018 07:46:08 -0400")
Message-ID: <xmqqd0x770p4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>> several reasons. Instead of doing the hard thing to fix those
>>> interactions, instead prevent reading or writing a commit-graph file for
>>> shallow repositories.
>> The latter instead would want to vanish, I would guess.
>
> Do you mean that we should call destroy_commit_graph() if we detect a
> shallow repository during write_commit_graph(), then I can make that
> change.
>

No, I was just having trouble with reading "Instead of doing X,
instead do Y".
