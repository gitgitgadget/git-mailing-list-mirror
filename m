Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70FC202BB
	for <e@80x24.org>; Thu, 28 Mar 2019 18:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfC1SlV (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 14:41:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35401 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfC1SlV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 14:41:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so24254191wrp.2
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 11:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdHOZE3/fDcdNhFQKXPpFD7CAzi5bcxT1Xl999ad0pg=;
        b=dBiVbgt9J0oXdnKS2col8yu/EFA6qvr32PL2ofX1TLFmjpB/KfPy7GGXvPlDqqLvxg
         cBxYHP2mIHpqW0yxW2FJYCpLZBVYbKyVWbHWyjpv9TAbRIftDcjrmuLFXC/aS/rhobYd
         VL9xxFVkrwZQ91UXlbW32Jyk1Th+1uYmWDWlnqv46SB+ZeH9Vp0cMzhLF2H36wXLYyim
         wMoSQipZZKyuim7OhsHVtrUvFvWQm7pkXCghyrMo+cK+n4KBxbssHQmPF4T6+bylO/KP
         HR7GNp5PdITmXo0s287+B84nUIgl8XmG0qLjuRF0izkFoadDCZg3xdZ1dAEWYN3VsKdt
         6PBg==
X-Gm-Message-State: APjAAAUJdB0gajJqWIx3nEOACL2AZh23rwnJwwZHDs2vsvaCgnODiF06
        BmJHoIo1R2hCkc/dVdsNtMNhmoX8431oFUaJy+k=
X-Google-Smtp-Source: APXvYqzND1rz24oxC32bC0OuvHOj4dl86gXvGZNnY4Nf6HW6z+HLzM/LJYaVse+w6Yqk+FZj6UAPORluXN11c4EgO/k=
X-Received: by 2002:adf:deca:: with SMTP id i10mr3295974wrn.88.1553798479479;
 Thu, 28 Mar 2019 11:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190328171722.9753-1-chriscool@tuxfamily.org> <20190328171722.9753-2-chriscool@tuxfamily.org>
In-Reply-To: <20190328171722.9753-2-chriscool@tuxfamily.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 28 Mar 2019 14:41:08 -0400
Message-ID: <CAPig+cSj5WZeGy4nwgafGtBbz7y921M8H57eFbBXwRy2Bm-C+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] t6050: redirect expected error output to /dev/null
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 28, 2019 at 1:17 PM Christian Couder
<christian.couder@gmail.com> wrote:
> Otherwise the error from `git rev-parse` is uselessly
> polluting the debug output.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> @@ -40,7 +40,7 @@ commit_peeling_shows_parents ()
> -    test_must_fail git rev-parse --verify $_commit^$_parent_number
> +    test_must_fail git rev-parse --verify $_commit^$_parent_number 2>/dev/null

When I'm debugging test failures, I find it very helpful to see that a
command which was expected to fail did indeed fail with the expected
error message, so I don't consider such a message as "uselessly
polluting the debug output". Consequently, I'm rather negative on this
change.
