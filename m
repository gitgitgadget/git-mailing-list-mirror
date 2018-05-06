Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EAB200B9
	for <e@80x24.org>; Sun,  6 May 2018 17:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeEFR5G (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 13:57:06 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55142 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeEFR4q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 13:56:46 -0400
Received: by mail-wm0-f52.google.com with SMTP id f6so10694750wmc.4
        for <git@vger.kernel.org>; Sun, 06 May 2018 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=HUe7BhbejF0/6i/L8fL2nqZHSQ9nuhpHwsMMsrgNwOk=;
        b=RjtuJOYwdWEITEQVfNj3h4n/68ZK2yLczZ0zkKIDCM7wxOfRjBJHkXNRuMDU/Xv2LQ
         MfC0KVpBK6CznkuSF+YZ31X79NhYV7NduwqU6M9K6jIhlZio80mMawTQDJ8qQcOFafs9
         QUvsbAa4nLbJWoWO2Wor4APwTFcnW31nzET44myAufzVrV52iBKy89z+iKKvY58ktGjl
         PyPCN4/L0CppxpaF5m/+gi3g3AO2T577DsDj03bKvGu5JxVJtrq+uPO+FQ88CpZXFl4H
         ffiMGg0Sz5AgM7vt95yJiIjXLnrKFDJCj+LWPrLn+0QZ0eNDSxpG6OGZNhXiTxj7LUcD
         WR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=HUe7BhbejF0/6i/L8fL2nqZHSQ9nuhpHwsMMsrgNwOk=;
        b=fUl95TaGFXdocoJQrjvQMqh+AuXc7vCHTFFA0KwaiH9ff8TkvwW2LgFPjxWkK7vBzN
         m/fXvYIJZeBGuH5RvFocOYsdCBqUjVunteAis017FelV+pWLipWcFgpDuhoDh7urKomm
         vJy3FDe8I+oWbZd5e97EO9OI2TqTYSbTHCr7F5yEq+Pmz9n+WGVnK4r/ZCs9i5GqIKgk
         0tDjakd4TleLKLevBDE+iq4rR2sfhFwSXEpVbSzhLh46j5JKeqiEVuUBkqGe9FZoecCe
         E008NniXkilaQ9y16PEaFT2gCzlAazvXOW2t2cXmou0D0G2uNHHozGEiXDfzUg5+qh8u
         249A==
X-Gm-Message-State: ALQs6tAs3ptHN+WwmXcM1kUTEb65kD+8BKzNXusAqVUYMxmmEUHmytfp
        ozJp3XiV0JDBsertZVMbZFs=
X-Google-Smtp-Source: AB8JxZq6rgI3ETBWuACtEjUIca5X0rBFPQd5rPSfPsyyG5rigGT6hnFhR3r2ki35A1lWrjnORYqydg==
X-Received: by 2002:a50:9665:: with SMTP id y92-v6mr46102990eda.21.1525629405303;
        Sun, 06 May 2018 10:56:45 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id h64-v6sm11870522edc.19.2018.05.06.10.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 May 2018 10:56:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH v4 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
References: <20180421034530.GB24606@syl.local> <cover.1525488108.git.me@ttaylorr.com> <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <9a596d53d6b2523bc94e58678aa43e68068859b6.1525488108.git.me@ttaylorr.com>
Date:   Sun, 06 May 2018 19:56:42 +0200
Message-ID: <87efioy8f9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 05 2018, Taylor Blau wrote:


> +	test_expect_success "grep -w $L (with --{line,column}-number)" '

It's now --column in v4 but this still refers to v3 --column-number.
