Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8F11F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeCPVC4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:02:56 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:43083 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCPVCz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:02:55 -0400
Received: by mail-wr0-f171.google.com with SMTP id o1so12861831wro.10
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ncYPe7YqDPcYFYTdEyYkPD5Qq6mqogC8BN8R1o4SNl4=;
        b=pX9L3KN0vQp3TRzxzYlJISwJIrZ9EPBxME8ahU3N7y5PubSUh/H3ZgnJZ8xdd4apa7
         70druxYP2Lk9Wd+9xcmJRT/53n8EHtwx9F2NZQzQ46dHPW3/ALUk7bSkgblFu0yCyXVj
         RLDfetmVNCQw2t1tZV55+b8nBwsUeDfkRIteW8bKJjYmebqjx1ZBzjN/nULtLi8BcCLD
         z4j9MZ0xCcMQhcoV/05XrgVqXjyBYAjuPU/LoFFAkoQO1xwJCzyrFARunsn3fzx01zPT
         jpPiEpL04Y5x9F887NJ7zb5NiYhKDNV3BOtEhF1kvKTQoOykxsLELnOKXeW8smidpKT9
         xvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ncYPe7YqDPcYFYTdEyYkPD5Qq6mqogC8BN8R1o4SNl4=;
        b=hvS9get4prfnBuOmJh5zB+lp9bvtMHief4ThIehKVJ6zTmiF8pIwM4Bi69s1tBZXeq
         +u0L24Jk6zBkSJ/hnoBC5fD2pigAz5wPdXlkUv5FLaGtIbfqi7vuwFPjjs3MTP430FJ+
         StlfZTwGQ0ljPLNn+kr7WDfajRI8mPqrF/udcFf6mniJYxRVXhqzQPVrgTuRnX49i7yN
         38XCNlCYGvHOIHKBJCcgsbi2JSPdO8V6DZewzKnko/289xPnpH3WG5z9f7wZA/9ixpmO
         X+Ecr+C0HYttMAuNiPrVb8hOc3tjy+af2KtR/Ozwjlb8+QPfOyfBtleRjQ3LxolLiKY9
         xx6A==
X-Gm-Message-State: AElRT7H+KVnW215fVh++hrwcjZ+jiHbfSmuU0OhoarX+igA+M1npW4Ue
        HVgunP/Gx4fsAM5pCGK7I4Y=
X-Google-Smtp-Source: AG47ELvetZf16xJK3T93NYEKFMICItBxw31iiHiwmTqLR/z6JHW1bozGUNdSM1gA0pXj0yZuwNkzsw==
X-Received: by 10.223.139.68 with SMTP id v4mr2923926wra.23.1521234174663;
        Fri, 16 Mar 2018 14:02:54 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o2sm7964229wro.31.2018.03.16.14.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:02:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v3 3/7] gc: detect base packs based on gc.bigPackThreshold config
References: <20180306104158.6541-1-pclouds@gmail.com> <20180316192745.19557-1-pclouds@gmail.com> <20180316192745.19557-4-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180316192745.19557-4-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 22:02:48 +0100
Message-ID: <871sgjent3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 16 2018, Nguyễn Thái Ngọc Duy jotted:

Awesome, thanks for making this support N large packs.

> +gc.bigPackThreshold::
> +	If non-zero, all packs larger than this limit are kept when
> +	`git gc` is run. This is very similar to `--keep-base-pack`
> +	except that all packs that meet the threshold are kept, not
> +	just the base pack. Defaults to zero.
> +

We should add:

    +
    Common unit suffixes of 'k', 'm', or 'g' are supported.

Since this now supports those suffixes (yay!), see existing copy/pasting
of that phrase in "git help config".
