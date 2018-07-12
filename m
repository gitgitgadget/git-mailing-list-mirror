Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 709AE1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 18:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeGLTBU (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:01:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38164 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeGLTBU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:01:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id m1-v6so9992306wrg.5
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 11:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WSuf1WOPV111S+gLgYSD45xz8Hz6WbkAn83XYGL0MlI=;
        b=Po+qQAhaqb6pXax3kNd2lRs8uMMVO/eBBZdqgi0PnZXhFVnd507SWOiGHTGAVxuE5N
         /FKdTW3lyoKDRDKURanyeDVG9mikOFWFbc9MfKenthVgTg/v8qKtMnfhdnpvAwmP3xG4
         4FSfaa9uLqh8P3goZvLSjpEeLPntV/ekk4qg/QZzvNqdqpxBNEeVzHxidC2jX2RTg8+Z
         YYfL2tbXyoXU1wqFPZB8DbEly8n4j/PMyfQyZ2MJzicTbpjIbLzftPBWUw9YT6lPfoh9
         maEnO+ln6HW8ty5nQeqh+MUeK86rTCQEjA2mN1c9B0kjKwPkxem0QOuMChtCpfQH/FFB
         s+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WSuf1WOPV111S+gLgYSD45xz8Hz6WbkAn83XYGL0MlI=;
        b=b+MED9Psdm8OTYRG4YIUVDNYr1K9R8y/6xTkraW90S/r+o8haJ7kqNpegNHy/qjfFh
         jM83okmukCE2KmJIMz2s2zLIes9CG9em7u0MCYO4swe6blBbEuyhia7FmbAlNWYwGtsn
         TaQqVqA/ZvC7p3Cdgf0ghZYKL5QNO+Wj69e9XxVX4nhsMBKyD3bwxBMmGLkSxbK0Db0q
         06TVcxKqbhwhw7SjC0nMG4p9muPuMWfB41qo/bZanM5RPrRBMFg/zxwtmwr+k9t0sYmZ
         YgIqSelQf+dCaYLzmzAOLqY5qR04pU1FPA801QmdpBhmOJpeA9jGKENY1tP4i42d8Gjb
         HcQQ==
X-Gm-Message-State: AOUpUlHt4G1zIOqV4TZc16MhQ2Py9AnsR8hfJOli3rZlT85m8Jg3eOL1
        Io7+o0LAw0GYHTbisL0Z0dE=
X-Google-Smtp-Source: AAOMgpfe9Ll/L91Er/0WX+EiuLAAhVPxn0I2MSLxQhk52qlbE8EhC80IJk1w0xR53vqUzmG/qIFoBw==
X-Received: by 2002:adf:c383:: with SMTP id p3-v6mr2638802wrf.68.1531421431000;
        Thu, 12 Jul 2018 11:50:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 64-v6sm14648979wrj.50.2018.07.12.11.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:50:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 21/25] t5000-t5999: fix broken &&-chains
References: <20180702002405.3042-1-sunshine@sunshineco.com>
        <20180702002405.3042-22-sunshine@sunshineco.com>
        <20180712123729.17861-1-szeder.dev@gmail.com>
        <CAPig+cRYNo_KL02LN1LOa79Zm2oYZqbnBHJ=KDA3oaF4pVfjcA@mail.gmail.com>
        <xmqqd0vsxq47.fsf@gitster-ct.c.googlers.com>
        <xmqq8t6gxpxb.fsf@gitster-ct.c.googlers.com>
        <CAPig+cRZmx5_3-a0C=WdWnmcrh4J_1YHY_0FmXZh5LzcDq+6Uw@mail.gmail.com>
Date:   Thu, 12 Jul 2018 11:50:29 -0700
In-Reply-To: <CAPig+cRZmx5_3-a0C=WdWnmcrh4J_1YHY_0FmXZh5LzcDq+6Uw@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 12 Jul 2018 14:46:19 -0400")
Message-ID: <xmqqzhywwaoa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jul 12, 2018 at 2:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> Oops, sent before completing the message.
>>
>>         For that to happen, we need a sign-off ;-)
>>
>> I guess this one would have been caught with the "sed script on
>> subshell" linter that does not execute?
>
> Yes, this is correctly caught when the prerequisite is met.
>
>> -- >8 --
>> Subject: t5608: fix broken &&-chain
>>
>> This is inside a loop that is run inside a subshell, in a test that
>> is protected with CLONE_2GB prerequisite, one or more which is quite
>> likely reason why it wasn't caught durin the previous clean-up.
>
> s/durin/during/
>
> The exact reason is that the prerequisite was not met (indeed, I
> wasn't even aware of that prerequisite), so the commit message can be
> more direct:
>
>     This was missed by the previous clean-ups due to an unmet
>     CLONE_2GB prerequisite.
>
> Thanks for saving a round-trip.
>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>

There still need a sign-off, so ... ;-)
