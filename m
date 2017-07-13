Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6FAD202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbdGMTag (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:30:36 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33299 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbdGMTaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:30:35 -0400
Received: by mail-pf0-f179.google.com with SMTP id e7so34071762pfk.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Y4TU3Un9CqPjEqQG0kMqtQkTcpQEPGCvtzeQdEWdjXE=;
        b=oSWiIqzoGIPi6kOjQ3D2YFnfBMm7wuY6YvPFhKhLcUDNuj2UPEY6d5pWXcqdRuPLJK
         4/xSdIVtW8E6QeVDS5GTm9QYydq0Tb5IWc4yxjk8bjYq79UNRCsPUc9hYfvzuayDuPWf
         vpROtxZZe34Q8THUC77M2EZgoNOqCT8m/Jubf7PO5e4x7Mkr7BykETRyNRIcRFoh9YQJ
         m4jwbUlbpqKrTQ5+jeEMJmEW7GwP4HnGkIHV9CW3YUMMJ1nEwgwNQ1wmWBuEvWFYF4nk
         qh675sraxFOra0+xypXIVgEkfYtPnHF6BgqMcaTM8rzzENiLKEv/L0lI2PxiKZIN8idu
         aZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Y4TU3Un9CqPjEqQG0kMqtQkTcpQEPGCvtzeQdEWdjXE=;
        b=bWhxK4UOIeriO4+6UBn+iftrTfdcA2gl+d3dUbF7B8LTyuUlJAozluzXOLopOsF4J9
         KA6VydSIP0jsaBlwglHHowK7vTqw3Y5P6QeoBLa/Tzk1U3IIZxzL2WgbFWY1FLmRXvju
         sIym96oYht1mpknCC6s9zDTgYn0agCRJzA8UaFOymbUwPqnPjukSRU4gf21dIi7mZIqD
         SUi8toFZn/ADFEf+GY1nnqTN12CXKDw7frJzwTZeNammw68nDLLyUSZkOaBvByaiGV/Z
         kGpOB5N+pr6oLnG9ZJuuCyhGPoEjP/XUVTNEWv+GoGpkG01dJsooVyJsgqYET+q0UxKn
         Drrg==
X-Gm-Message-State: AIVw111+lm9EwUwcMIvViwTj5Xu7DV6Tofkr9m7d0mllDZWCDyciMV2p
        KrkPa/ZwMzx9+Q==
X-Received: by 10.99.127.11 with SMTP id a11mr10873474pgd.213.1499974234852;
        Thu, 13 Jul 2017 12:30:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id x14sm13836111pfe.83.2017.07.13.12.30.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 12:30:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miguel Torroja <miguel.torroja@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
References: <CAE5ih7-Sy9YmGbLs=wzfxXCSFLkEotqLRuu_xNz9x=7BhvrvnA@mail.gmail.com>
        <20170711225316.10608-1-miguel.torroja@gmail.com>
        <CAE5ih78mrTz1sfJbRSuPTNojxWyH_1JFDY2pe7GMAZdPhzcvpA@mail.gmail.com>
        <CAKYtbVb8T=edPG5539=uwDjHnCerLO2Oejy8bWK+giSS8nNGig@mail.gmail.com>
        <xmqqr2xl1suy.fsf@gitster.mtv.corp.google.com>
        <CAKYtbVaxR0sdL_k=vy-aT5wEzvCTzDcM6Q-i0hO6jLMzjEUwmA@mail.gmail.com>
Date:   Thu, 13 Jul 2017 12:30:33 -0700
In-Reply-To: <CAKYtbVaxR0sdL_k=vy-aT5wEzvCTzDcM6Q-i0hO6jLMzjEUwmA@mail.gmail.com>
        (Miguel Torroja's message of "Thu, 13 Jul 2017 09:12:32 +0200")
Message-ID: <xmqqa848w2w6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miguel Torroja <miguel.torroja@gmail.com> writes:

> I've just sent in reply to your previous e-mail three different patches.
>
> * The first patch is just to show some broken tests,
> * Second patch is to fix the original issue I had (the one that
> initiated this thread)
> * Third patch is the one that filters out "info" messages in p4CmdList
> (this time default is reversed and set to False, what is the original
> behaviour). The two test cases that are cured with this change have to
> set explicitely skip_info=True.

The approach looks reasonable.  By having tests that expect failure
upfront, the series clearly shows how the code changes in later
steps make things better.

Thanks.  Will replace.
