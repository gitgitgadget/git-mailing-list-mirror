Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B6D1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 01:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeDQBiA (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 21:38:00 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:37210 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeDQBh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 21:37:59 -0400
Received: by mail-wr0-f174.google.com with SMTP id l49so30901580wrl.4
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6ZsUht9zYKFuadM1mNJ4tH6S77CZiYof734LDlGnSJs=;
        b=bM5NbMHrXqdQayc1zgdiS1G4dWQs1YVCasYt8eRu8EitIxKK5D1uDCcTEpRhcG8K0m
         PDXAEX2IndF4tTnbdYc1eqQvyDI4DGKvw7Kp36u7Nd/LHAzKWGvcuFzf8y7MBI7fdw6o
         IrG+6bo8rKzh2zxSBwdptiGaotnV+SeZ5GEWwlQ101q/LGA0IjkGQV4nWQy5lIBHKn66
         ovBHlQMH6MCo3RZmtNeAfqez1mHIPI/coa9gt/5lqrIso1D1E+/eYccmWiBsTlakHu/U
         XJhkl63x6eEj5vMRuwmrZn8/bae5jqnDlG7xm3TF9WgnW7R9qgB1CY+2pOPjeWADsveQ
         //yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6ZsUht9zYKFuadM1mNJ4tH6S77CZiYof734LDlGnSJs=;
        b=dA4QyZzYRNI0IsCnBcR/v5HODm4SFvrGNjyeFR+r3rQyOAQUla/NpsJ2aiEKM/IEPO
         Zic1HjzIwKRKm0Da5Zo9hYTR4yep+sQ01kdYMhVq8VaNu7flPuNdOX70dh1r1/drxg4K
         S+4Vq4aZodgtFwb2tPV0CUGSaUHh3D+x+P99nOOJSGo/T8dsuyjZCsxCwNg/tPluLf0W
         F+Yav0Z6BZWkoQ1eYQwSdhPH2glAS2mfs7JtO4rqnJcjtRQAojZspo1zdskQXvwUF8kc
         kKl+L8NzN60YpHwe0Lr+OYumN73L/yCfrbx3+OO1Y2ai5MsFVJJDRMSPTCtGLl53iRFN
         Uf0g==
X-Gm-Message-State: ALQs6tD9S3CY8pVdv3rfA9dfzOJ0vGk1ktMhODErgyd5Ybbd5TnE2PZM
        urJPVjJ2qyrD8u0r0jkR+ZI=
X-Google-Smtp-Source: AIpwx4/wzHgBBq+if+NEx4Gq5zyGOW5M5eKBVglc+7v7MnqHSf/f71LA8Kjf+0ZpWqIIMu5y0S1i4A==
X-Received: by 10.28.109.80 with SMTP id i77mr293956wmc.46.1523929077896;
        Mon, 16 Apr 2018 18:37:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 11sm8330808wmr.16.2018.04.16.18.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 18:37:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: rebase -i creates committer time inversions on 'reword'
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
        <xmqq7ep817bq.fsf@gitster-ct.c.googlers.com>
        <06c5bd54-f1b0-7fe5-6aa8-870e0ae4487d@kdbg.org>
Date:   Tue, 17 Apr 2018 10:37:56 +0900
In-Reply-To: <06c5bd54-f1b0-7fe5-6aa8-870e0ae4487d@kdbg.org> (Johannes Sixt's
        message of "Mon, 16 Apr 2018 07:56:52 +0200")
Message-ID: <xmqqa7u2wr2j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 15.04.2018 um 23:35 schrieb Junio C Hamano:
>> Ah, do you mean we have an internal sequence like this, when "rebase
>> --continue" wants to conclude an edit/reword?
>
> Yes, it's only 'reword' that is affected, because then subsequent
> picks are processed by the original process.

Ah, OK, that is a good explanation.

