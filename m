Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D28E1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 14:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeBXOMw (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 09:12:52 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52360 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeBXOMv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 09:12:51 -0500
Received: by mail-wm0-f65.google.com with SMTP id t3so9651362wmc.2
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 06:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YgEpG0PADUsHLiw4H/HMI4zk6YycsrPZg7ereweXFnY=;
        b=il04RIwc7xsdrIUTs3AkLkjaC5v948kCxeBx0I1Ph9lJ9KbWX1GcT9a3O0HiesSafZ
         IRSngLd2ozfiezGXTJyT1+WUuXIY9t3/LyIM25jA89g+CK1tkKSh/jlSbl6R/yBpGgkB
         WSeVDtuUjWG498ANVCwwW66zwMfaHLM5uSypCN5f9kIbYHO91bcWT8ywDzjTNWUN0wCr
         CaG4zqRK2R6s4MUjfIOA5gju7ct7HL8yBiZi/sug+l09YbVUs62MREPyD0SuQzrzCkpZ
         OgzDDyr30vtXLUFgyYtSS1fX64EQ84578m940v5DaFBT0WcCrPF4BccD/4Zfy5maD4YC
         X7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YgEpG0PADUsHLiw4H/HMI4zk6YycsrPZg7ereweXFnY=;
        b=CN7DqUKLFuH/wiPSTR9pAF7CJZsOuj9vR7Dww/9PtbJyClf4W3YBF8Ayoicqdn5W+x
         DhHMLn5DM0fwr7EuztpnFiI1tjRuPtvNtVOCXNuSuZpIZt4NEnur1UozWaz0KMqGFK4w
         5NR6z2Y5M2B2GNVseYnEmJbI6Jy5ZHe/gW1qc6NTKDAsPyrSOtAY8kzOdIrzEnWUKIS8
         sRU58+AurdCkT45JlMUATb2BDkVOw7UCOYyIArNB3oE8yaKXoajmnc0QZNGbHYK1EEnv
         7pe23xEoPE8dyzGvIrZRbLjhP23z6LKDqvwxYWog0KfQRR6hp15fRHPcMYOnUIcnxgRx
         5IlA==
X-Gm-Message-State: APf1xPCCM+9huVN6wmG2zz16GFF3yIHNqViXIbIdatxd9yHcK82jSgHq
        v4JouIF1+6ulD9qntefIqLg=
X-Google-Smtp-Source: AG47ELslQLFxuOisuEnufXkO8ZH4ol6+0+H62bzWIKG18j61VxTSoZ5/LZzXs+JfwVB+yp5RD4Ei8Q==
X-Received: by 10.28.111.28 with SMTP id k28mr4071359wmc.54.1519481569935;
        Sat, 24 Feb 2018 06:12:49 -0800 (PST)
Received: from sebi-laptop ([92.55.154.23])
        by smtp.googlemail.com with ESMTPSA id b9sm3200986wrh.68.2018.02.24.06.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Feb 2018 06:12:49 -0800 (PST)
Message-ID: <1519481568.32160.3.camel@gmail.com>
Subject: Re: [GSoC][PATCH v2] ref-filter: Make "--contains <id>" less chatty
 if <id> is invalid
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sat, 24 Feb 2018 16:12:48 +0200
In-Reply-To: <xmqq371rs23z.fsf@gitster-ct.c.googlers.com>
References: <20180223162557.31477-1-ungureanupaulsebastian@gmail.com>
         <xmqqwoz3s9s2.fsf@gitster-ct.c.googlers.com>
         <xmqq371rs23z.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Your proposed solution makes a lot more sense. I have actually
considered a solution similar to this (the third solution from [1]),
but found it more complicated. I did not account for the fact that
once a callback is called, the user is already aware of the available
options and the user only supplied an invalid argument value.

I also have to make sure that all parsers (all callbacks and standard
ones, for integer, filename, etc.) are already printing errors
appropriately. Otherwise, some commands may fail and the user will not
be aware of it because nothing will be shown (no usage is shown and no
errors either).

I will be implementing this solution and come back with another patch.

Thank you for your review. I really appreciate it!

[1] https://public-inbox.org/git/20160118215433.GB24136@sigill.intra.pe
ff.net/

Best regards,
Paul Ungureanu
