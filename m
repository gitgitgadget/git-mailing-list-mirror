Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840061F516
	for <e@80x24.org>; Fri, 29 Jun 2018 16:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935485AbeF2Qzh (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 12:55:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35433 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933883AbeF2Qzg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 12:55:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id z137-v6so2771534wmc.0
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Z22EarwefY9ctJaLYfoCvFE5XK7mYFw4iQTZt+ILMNE=;
        b=SuKe3a0UbCJtNIjyWNU6m7LyYl7P/fijeJYabeDqVXYOydSBwMBKSu2zWxZVUhyMG7
         VnLYb2rAk3Eklm3Cs/h2xoyuY03hhVELKVN9IzSrCnK2VILGheQz9Y/hN/JYcyFEqdrv
         iYE9iZsKMa8FaOt02vlGFVJKskJvVoGhljQlhCo3yDeH5I+8KjYK6ulrHdb8+b0rmtVK
         cwI2CcVaUC/QPBJPo/JDYLMeq7NHvcRXeY4s8ObbhI/BgRDykzGdxvJ/Bta6zDMzsY0B
         DFmlsFuksSUIk5Qj4QLnDqSHXjoVvHTWXQIaNGAGegZYUmE4u7VWTYZN57r3oMrw2vWA
         gLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Z22EarwefY9ctJaLYfoCvFE5XK7mYFw4iQTZt+ILMNE=;
        b=tXZ+dOdbSNZEbFhmuFGQRY+4ELZT9y4Sh0H17JMvvgDB4D8+6Hw08wW2aJR4F4iqB4
         O9AWBKs+F9YOpZSOpkEUnetMdvs4HOKaUANn+Et98jpxqHXKRlYteWIg32j4gBDKcA0J
         +HDo26frx5jkvOL5hsXtCgdpN2xZQKxtn0mJ/dVAhV0Ohw9BZfNt2tFuv8e7SaqKuS8F
         D/9zr5kAl8+QA1zmZLLc/yMhHuEdnK84GYo9aXqkz969HThFYK+lZmYfPGwgnGzKncRz
         +hA3/GCTP2P9tjL+xDJygNXo6rSHp1I6OoHJFWN64syFl2en9PMzjfdzhwgXB8hn8Nkj
         kBnw==
X-Gm-Message-State: APt69E1lZh2pMK/OCBfqAgyn1GiYXVkPV1QKXrFSez9l/oXBg+OSECN6
        rIXVQdfn3+CBTdUoHfGwOw4VV9AR
X-Google-Smtp-Source: AAOMgpfePEaLGxtsl4go70k2bF6xwSox/m+1skMx875kix38/N92aRiv29ZuFglMwpycXFkv1BnW2Q==
X-Received: by 2002:a1c:9403:: with SMTP id w3-v6mr2177102wmd.105.1530291335096;
        Fri, 29 Jun 2018 09:55:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b16-v6sm14847100wrm.15.2018.06.29.09.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 09:55:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 0/3] rebase -i: rewrite reflog operations in C
References: <20180625134419.18435-1-alban.gruin@gmail.com>
        <20180629151435.31868-1-alban.gruin@gmail.com>
Date:   Fri, 29 Jun 2018 09:55:34 -0700
In-Reply-To: <20180629151435.31868-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Fri, 29 Jun 2018 17:14:32 +0200")
Message-ID: <xmqqr2kpv8ft.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This patch series rewrites the reflog operations from shell to C.  This
> is part of the effort to rewrite interactive rebase in C.
>
> The first commit is dedicated to creating a function to silence a
> command, as the sequencer will do in several places with these patches.
>
> This branch is based on ag/rebase-i-rewrite-todo, and does not conflict
> with pu (as of 2018-06-29).

Let's aggregate these topics into a single topic, and perhaps call
it ag/rebase-i-in-c or something like that.  Pretending as if they
are separately replaceable does not make much sense, as you are not
rerolling the earlier one and keep going forward with producing more
parts that depends on the parts that have been submitted earlier.

These three patches looked more-or-less good; I may have spotted a
few nits and suggested improvements, though.

Thanks.
