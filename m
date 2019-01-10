Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103E81F803
	for <e@80x24.org>; Thu, 10 Jan 2019 18:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfAJSGB (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 13:06:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38981 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfAJSGA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 13:06:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so2349200wmi.4
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=s44dXuJ9bXVGUwUoWA0iTrYc5+f5TuEa3hMDnG80h/o=;
        b=m1wAzjqzr37R0n+6mB3HN3AgwfQfFn16mURr7lYhftVA5veiH96dLUmsTTE46jRZyK
         VMQCvfqd0bk/ywWo3Cnqqtanvb6KluSCpTeQJej6ewUu78HmOdOfgcU3ItIqSR559Vr1
         vbVNmAFazoK7kVM8LUW0MONdglXRPOm0kIi9artWgiBvKQs3juwQrQJbEhfcGvqkZey3
         Hc/eQpP3Fcy+vkUOryecnizD+mefIO64dUg3XEfdTSEkoNinZeynIRXu3PoanvY2kbuw
         PcYcV29BA3YFFM9Rql9jXOJMxX6bpCrQ8qZcj64HMmAX3Fwu4o/wOeARIW7PH3OEWTXt
         uYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=s44dXuJ9bXVGUwUoWA0iTrYc5+f5TuEa3hMDnG80h/o=;
        b=WXHvEuVYO8g0EboJI/J7+KWxx8gbkqDsAn25pBkCzUP0lQNW1AlQL+lG5H4++FOm1P
         GJcmqJfUuiIX43DRDlsQLpgWljKcsca7AMgWWAbkTi+d8rTGXJnh7G65x6FDd1vNVo+1
         uJTUaRPaeEm/Yy+lJZPSw+nXKjf8izdObWvLxTTHX6BRPfNBCS0lqEYrmklpW6lLV7Oj
         UaaCm8foaLGRbCpyMmCbPIVlQP2qHnppolG2PCrT5UWThwKLuW3TmEYmr2iNEJZku37i
         sBRBqXogMTSOpMV6qTh6EjUJvXBFgXmRT273fnSaqgm25Jsjy2bRrib+xXUnhrE37tMZ
         FQmw==
X-Gm-Message-State: AJcUukc9HYe+UL4sYBc7HsY+90GwKFbtWSqSdlUvXBId9I9CcMQUz5SP
        Ux8sx1DI04FzdQgkOXoDqZI=
X-Google-Smtp-Source: ALg8bN5TvAkK9tA2ZQ/5+mOc4dVzcFWnkqsVkdK89LHHgCocghGAgy643fytNNUDwJlEa6dAx79j6Q==
X-Received: by 2002:a1c:c58d:: with SMTP id v135mr11199540wmf.88.1547143558972;
        Thu, 10 Jan 2019 10:05:58 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j8sm41181434wmd.0.2019.01.10.10.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:05:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 6/9] multi-pack-index: implement 'expire' verb
References: <pull.92.v2.git.gitgitgadget@gmail.com>
        <pull.92.v3.git.gitgitgadget@gmail.com>
        <4dbff40e7ad653d9c5c3b19dd63a345a21a73dbd.1547047269.git.gitgitgadget@gmail.com>
        <20190109155441.GH4673@szeder.dev>
Date:   Thu, 10 Jan 2019 10:05:57 -0800
In-Reply-To: <20190109155441.GH4673@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Wed, 9 Jan 2019 16:54:41 +0100")
Message-ID: <xmqqtvig2xru.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Wed, Jan 09, 2019 at 07:21:16AM -0800, Derrick Stolee via GitGitGadget wrote:
>> The 'git multi-pack-index expire' command ...
>
> The subject line could use a s/verb/subcommand/.

Yeah, that probably is more in line with the existing terminology
for other Git commands.
