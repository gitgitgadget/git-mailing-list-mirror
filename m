Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2ECA1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 15:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeG3Qlz (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 12:41:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40239 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbeG3Qls (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 12:41:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id y9-v6so10609wma.5
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0p0+HaARWMokgw+QaJIJYq17MSNhdXcJy5CfumkMs6g=;
        b=clpTL3Uu8zFHhl36h7fBTj9fGyLPiQZ5i5nFv+3SSUXp3Qa+DfnaGKrDofVuE/sy0Y
         OxIVp85rOkIFAdf861lcJKiXWgH6qmBMo1bMh0NqwZLwMUdm9YwK2r3TWJJOXYLs7E9u
         9MGwFX7/olTNgHvSg5pCzENw5bxSCn5vZNVI5k/coGQtWUaT7OpxuMCoC5OxrdoTagx8
         EbbG9vAMc2BdYMvVHhmCYB1fynAPRkkPtiSwAald2ZJg4bxhw90lbj13GIDqOLhXH+cP
         HJ4F8fgQMFRy1h3/PmCb3+RuyE4s7rYjG0QLNeA+mwEjhZhwR7XESK/WmAQSCkom+dTV
         otbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0p0+HaARWMokgw+QaJIJYq17MSNhdXcJy5CfumkMs6g=;
        b=ocUgrcvLlvi1NFY7mai+r24oHpdeOL7cgtR4lWIcwW69PlNTYbaKK3zVqfq/qqPZML
         5dLMa51VcKoHm/Sjld2NMrA05RYlG+pyjWCEWubZUtqbDCKJyS4EZr58n6OQjTpeblzY
         Fg2CZWUxOwh8eLpaFVT04UBGDqiwaxS7y98AwptTnedUIXtmi7NvXsqFHnxJ7yH9uqq/
         inZ1PwUYQu2eE+T1T2JGnE3kMfYZSTN2I3EqRqvfFFdA8FOrJZCmTAtZzhqgaAZwYxGy
         1qFs0mvCAJwxqUqk9c5nvN/sku8bNEwTOk0eEUBwvoXybZl3sHwVseC8BnYqjj4PQ6nJ
         3gGQ==
X-Gm-Message-State: AOUpUlFE9KiuhsI/Eb1QaX7fGh+5Qq1CxrPyhug2XUlUPgt59AGKFKb8
        qVl9ozZ9q0wCTMLzwo64HYPdAodYspA=
X-Google-Smtp-Source: AAOMgpdSMakj4VvX1iwSRfUdvfeFYd9ln7SWnDjw0bgya+Xrc3HZj0FlTBw8DIWncCHKqKMSApzWgQ==
X-Received: by 2002:a1c:87c9:: with SMTP id j192-v6mr14612505wmd.71.1532963182166;
        Mon, 30 Jul 2018 08:06:22 -0700 (PDT)
Received: from evledraar ([5.57.20.50])
        by smtp.gmail.com with ESMTPSA id d14-v6sm17112155wrr.12.2018.07.30.08.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 08:06:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 07/10] fetch: implement fetch.fsck.*
References: <20180525192811.25680-1-avarab@gmail.com> <20180727143720.14948-8-avarab@gmail.com> <20180730145851.GA8074@duynguyen.home>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180730145851.GA8074@duynguyen.home>
Date:   Mon, 30 Jul 2018 17:06:20 +0200
Message-ID: <87va8wu5jn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 30 2018, Duy Nguyen wrote:

> On Fri, Jul 27, 2018 at 02:37:17PM +0000, Ævar Arnfjörð Bjarmason wrote:
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 7ff453c53b..8dace49daa 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1467,6 +1467,16 @@ fetch.fsckObjects::
>>  	checked. Defaults to false. If not set, the value of
>>  	`transfer.fsckObjects` is used instead.
>>  
>> +fetch.fsck.<msg-id>::
>> +	Acts like `fsck.<msg-id>`, but is used by
>> +	linkgit:git-fetch-pack[1] instead of linkgit:git-fsck[1]. See
>> +	the `fsck.<msg-id>` documentation for details.
>
> Could you squash this patch in? It would let us auto-complete "git
> config fetch.fsck" in bash/tcsh
>
> -- 8< --
> diff --git a/help.c b/help.c
> index 9c0b5a8de9..32fe466dbf 100644
> --- a/help.c
> +++ b/help.c
> @@ -427,6 +427,7 @@ void list_config_help(int for_human)
>  		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
>  		{ "color.status", "<slot>", list_config_color_status_slots },
>  		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
> +		{ "fetch.fsck", "<msg-id>", list_config_fsck_msg_ids },
>  		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
>  		{ NULL, NULL, NULL }
>  	};
> -- 8< --

Thanks! I missed that. Willdo.
