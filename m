Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7FE1FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 18:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751014AbdBKSvt (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 13:51:49 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34401 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdBKSvs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 13:51:48 -0500
Received: by mail-pf0-f195.google.com with SMTP id o64so3243669pfb.1
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 10:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fCNa9y6++GoEfVVBM7YVQ8djr/UZ87Xke7jm/ZG9o8Y=;
        b=eEZIYoFDmJQylRdTwKCUfwYhAJJDo1zyfVJj+E3b70uzNrB7cFh/TDuPQxyT46egga
         qdvuRLy4Hv+zHNj5cnBEUv+cYTxdrsaE6eavHZ9hd+T4rsXYmgR7s7v4AXQWApj/i+zW
         qC5LqvwqB5OC7aItOKpfihJXDTesk/SceZJAg8mq2z9a5QCb5kumhIGJ7H+5UJq8j76J
         OfzN6yTrYEa5HmFPVdlVKse3wPczEZ7Bdlb7KUH7/wEacJ01XENlZ5h7zpMzRLIGDQZX
         8SL3ukf4cwCHOvkrLkouDXLwJh1XUqe8Cxq1iSD+9ppQNkXpKPGmU5cx7/9c8W4wzzvJ
         nSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fCNa9y6++GoEfVVBM7YVQ8djr/UZ87Xke7jm/ZG9o8Y=;
        b=WFbuHurNDNEz+ihhoFJfx/9Sy2cjWpoZJzdc/5EFN0yoZFYI6l1+OpzEZbTl0TrcKK
         WgCoHjW3ISm2K6crH9HiyrV045TWq8TJOIaVdDoxxvnjQZ62erU6I8BGHCoEVE+6rLSH
         AMb+m8xOY+KhHODu/M+dnXrCtpOVIhTGo+P926FlLIMFnWvvAC6G32ZzbAmVS8hwqB06
         biuoOKIjxpDWYE5fsPPRpwVKNlYqVcoSJ1NKgypcvD+6ttMM9BqBnqxKJvhYONgL+MrM
         O2gJDhgMVOwsU7d5jJne63pwTX1A2yDNLU0M+Wf+jBdtWSN+8GyConrXZQmS5iK0FVoX
         lOzA==
X-Gm-Message-State: AMke39m2gi48he7N7su3rfx3/Tm+wsNU0FKyif8QgTf1PVbPJpglyaXON6eidnjD8pG8Rg==
X-Received: by 10.84.169.67 with SMTP id g61mr19543275plb.137.1486839107844;
        Sat, 11 Feb 2017 10:51:47 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d4bf:82d:ab5d:5a31])
        by smtp.gmail.com with ESMTPSA id s3sm6054686pgn.55.2017.02.11.10.51.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 11 Feb 2017 10:51:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
        <xmqqbmublyo0.fsf@gitster.mtv.corp.google.com>
        <31bb0b9f-d498-24b3-57d5-9f34cb8e3914@kdbg.org>
Date:   Sat, 11 Feb 2017 10:51:44 -0800
In-Reply-To: <31bb0b9f-d498-24b3-57d5-9f34cb8e3914@kdbg.org> (Johannes Sixt's
        message of "Sat, 11 Feb 2017 09:01:23 +0100")
Message-ID: <xmqqzihsh873.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 10.02.2017 um 00:41 schrieb Junio C Hamano:
>> ...
>> Nice.  Will queue as jh/mingw-openssl-sha1 topic; it is a bit too
>> late for today's integration cycle to be merged to 'next', but let's
>> have this by the end of the week in 'master'.
>
> Please don't rush this through. I didn't have a chance to cross-check
> the patch; it will have to wait for Monday. I would like to address
> Peff's concerns about additional runtime dependencies.

OK.  Will mark it as "Will cook in 'next'" for now.
