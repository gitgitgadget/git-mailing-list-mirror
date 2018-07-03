Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA76F1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 18:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934381AbeGCSPH (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 14:15:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33434 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934295AbeGCSPG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 14:15:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id k7-v6so2903665wrq.0
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zodI3psApLz34eWBp7n/O6N1zlSP7HXZCUclSRsJvEw=;
        b=AtjLeRPLCf0BJYouEj3KWyrslgxN1CNUc3qb+8MMv4wpTfwzlf6dOMzV8c48HM383S
         Bxn9IWD2M+XdiEsrDznTLuhs9pxmVeRgPFKM6M8Hg/kTTt1+MyukHQhx7XXvqJZY3UmL
         e7OlS1whMTS/CJb7r216BA72wJf78Kk5BqUeLeIlVwVwcgYps/QHDKcfepemTTUtvSRI
         j8cay839sJBoh6bhOKADG/x0fZ5DS7L1m4Kv7WTfrlRdqiczwnOq+o5SXA/6iUtpSRT2
         hpHfkLK1a5u0AzQAzQQu2D4ey9GbwxSTMxSVxWlhd45jo6mHwZRHIbNR6Kh0RGBglXkP
         EkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zodI3psApLz34eWBp7n/O6N1zlSP7HXZCUclSRsJvEw=;
        b=RC6xRIwvcXCCk+EQM+zu2kI9LtgWpkYvP212dGtpHPCyJD4Um658EvCnRw94Uo1K01
         G192lpeMm1sVyKdGDcK8j3AB7YuqdhiyQ/RwHdxxHfQIZpVeY9EsxDqa7O6BwrjmE1FS
         yZ6wEJ27aZNsKakEa4K8agDKj5Pt34vDRRubbgIiwJxd4A+TKJfDNvcyHk06PSIK209v
         TenwZHuowBW5d+YI5ReNP71uKoPuOUB1HJytlBgUt0PyRINzYfz4iX6ync2j3lhVinSW
         rM1QJsrtADDn0Gt0cooYRKi1D04bhCGIzo+AG0xBLtDOOy8m3HUM6YXsGZx+GT84HvcP
         Xf9g==
X-Gm-Message-State: APt69E2JRTVOegBv9esBbygh62Iyibj5Fr7Y7r0+JRE1u1nI4MCoYr0K
        hvM39G5jx8SllKFRllbXwL8=
X-Google-Smtp-Source: AAOMgpcOWohAfJmbeXjFlDKXFeAcsx/nACDQRBogSduZOhJnAKtm+0w0wtIrZhp9cugB2Omtd7BJEA==
X-Received: by 2002:adf:b964:: with SMTP id b33-v6mr24814019wrg.265.1530641704029;
        Tue, 03 Jul 2018 11:15:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 39-v6sm3534340wrv.79.2018.07.03.11.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 11:15:03 -0700 (PDT)
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
        <xmqqr2kpv8ft.fsf@gitster-ct.c.googlers.com>
        <xmqqzhzdtpt4.fsf@gitster-ct.c.googlers.com>
        <e703f571-4966-f3aa-da81-fae1962c8906@gmail.com>
Date:   Tue, 03 Jul 2018 11:15:02 -0700
In-Reply-To: <e703f571-4966-f3aa-da81-fae1962c8906@gmail.com> (Alban Gruin's
        message of "Mon, 2 Jul 2018 12:36:21 +0200")
Message-ID: <xmqqwoucqj89.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> The patches about append_todo_help() and edit-todo are not up to date,
> so I’ll resend them in a few minutes

Good.
