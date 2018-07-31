Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F372C1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbeGaTHJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:07:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40332 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbeGaTHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:07:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id y9-v6so4017943wma.5
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cBvNtBkV/Wa5kVS2xj7zNb4wnhsEndG0H8FZUyxF2f4=;
        b=HcD+81rs26LdyNCi7nnGscy325aTvckfXRG0NDqT2zdx69HpWK02/7vFrDg6I5GBzx
         lXdPjWa+kz3j0XlAl6f+tQjRIw3rUDbk7JPP0Y5azQDCCrPygSZy69sNJ8dKFAwpWkWv
         8CYFeGzU9O58CEXy8sHfMOp2+EIAknOJOtFxY5yfH/6ORsV5dpbfm+Z3xWLwjnwdbJey
         RgvBKujbWeIgVecTn3K+lC+I2k4CUAOGw7pmC2B0YTJGAiaSC/XXwZ263q75NQDdJSNZ
         p2slz4NzuEOW5K2ql/rWOYQZB6jb4sJ2c2sKj3RUd7ZvY4igaIKm6TEh1YmZGvkl29yu
         Hyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cBvNtBkV/Wa5kVS2xj7zNb4wnhsEndG0H8FZUyxF2f4=;
        b=q3Fs7QG8pO+ettxCOWiIv++QewzSIUftyGA5Y0/N8E3Gvv38yhL5CbqtW08o9ccfto
         qwR/KPKU8Dpsxx2Ou5L1zIAVfA0kPQVPwZa5iwrqdsu84jFUPdgspTd8Wf7ikmFct4w/
         xalhUJl7IgaH5KuYYZ7UfLAQLgrZGEhiy8Fl12ZpsbWI0kqtpfibv8y4Vs8X4yCO1A93
         qPquHiVYYrHAMYHwrQl7PWWkFJ3wyShx7uAiGuQUYSs04CqbbZvTknldjLrg6SjEVYeP
         sm+LMSDP0oSAV/vIw3X6tc6QDyONtua1xtosdv9xFAlbKwWVPTwHHEl+v4/NCsbysJa3
         w6mw==
X-Gm-Message-State: AOUpUlG1bm9JRjeST+VIJ7VZQuWdzTitk5+GNp7Jf3yDfNQwRMCUwPED
        PRD82GwQm5V5Or1TbyRCin0=
X-Google-Smtp-Source: AAOMgpd/PCtDN+OSNCM1deZJ86tAS//9huwukB8kZUzRSgSKCIky8OqcjR08ul5KS0uP3gvOoHD8xA==
X-Received: by 2002:a1c:14c3:: with SMTP id 186-v6mr372410wmu.21.1533057948610;
        Tue, 31 Jul 2018 10:25:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f6-v6sm27750579wrw.78.2018.07.31.10.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 10:25:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [GSoC][PATCH v4] fixup! rebase -i: rewrite write_basic_state() in C
References: <20180730182516.32644-1-szeder.dev@gmail.com>
        <20180731121115.12296-1-alban.gruin@gmail.com>
        <xmqqy3drctu4.fsf@gitster-ct.c.googlers.com>
        <ad8fe398-6e7b-b50f-df96-35ac06049020@gmail.com>
        <xmqqpnz3cry6.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 31 Jul 2018 10:25:47 -0700
In-Reply-To: <xmqqpnz3cry6.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 31 Jul 2018 09:04:17 -0700")
Message-ID: <xmqqd0v3co6c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As the number of his or her own topics each contributor needs to
> keep track of by definition is the number of all topics I need to

s/is the/is smaller than the/;

Sorry for the noise X-<.

> take care of, I do not want to have to keep track of things myself
> more than necessary, which would result in missed fixups and delayed
> updates.
