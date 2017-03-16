Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E27120951
	for <e@80x24.org>; Thu, 16 Mar 2017 10:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdCPK2Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 06:28:25 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33151 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdCPK2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 06:28:25 -0400
Received: by mail-lf0-f46.google.com with SMTP id a6so18165862lfa.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aBz/8VlA46pwNmKEArzIo5gvmnUvGUcBPgwva64oCxk=;
        b=II/5jAKGJRNmtMgZCe3ArsMReRQ50kqqvjQFWZFe8pDkUDw28+/zXg1Wku3p2SaCfw
         YWNox9jpqcAq/47UV8l7QfGnh271j4Ai3izBR5Uz3kCcD8W9EN7vmmavNcVlgzWHyt+u
         PZb5E9/3flsIR6w5CkvFW33y/HdQaXKtfYC1AXk/mcA2Envu2LePIlF4+cPLhQExD5k5
         3GUD9nj7br7un/b6m5aNaVkrdcZ3owfvi1W32cC4X7bNAGo6h4H6R2k6oc6V7gGhjo7m
         WQ55wJ3c/v2oyPD4MtS65wXJt3RtvIHvNtbWT24KGcZ8LTulWKH5XxRZhaujyGZ2E+Wc
         Zf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aBz/8VlA46pwNmKEArzIo5gvmnUvGUcBPgwva64oCxk=;
        b=bzxc83nWKmrrkKTOOQdG378kjnG2RGoK/neRt/3FgpnZT6iYX/9Hy58vKQvRWrcsZw
         dvpF4D3VmrRikh9ELBiQGeYo4/58aryhmYN80uOYlX0cgmxYotKx+Yer4rGwfz3IhKXb
         QLka/2ZipXTBmPpXEBXduVxbEykyIKqVQfkf48QN1M2imA6tgT1a0+YqpyOvimax2u8g
         xW6/fice6wq0Y8fjVwFpqjyyf48n3cQYTR4HifAdztU9rkcgTi6POVNt6zvTXa7O8tmX
         YtBUL9QYXFA06imgNDBO0DBLfrcpZSSgG5Rbyfoa7v0Z+y8mOYTWBKfqObFRT3GF5ja3
         Pnjg==
X-Gm-Message-State: AFeK/H20nvMyzwiAdvSeftU+RsNlHEQh8DmSKMNjFi8xDD3mYIqazsdLtmMOx1oPlYEHsRJ0iMKjBPnvkFEbvQ==
X-Received: by 10.46.15.9 with SMTP id 9mr2790820ljp.108.1489660102787; Thu,
 16 Mar 2017 03:28:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Thu, 16 Mar 2017 03:28:02 -0700 (PDT)
In-Reply-To: <20170315225045.15788-1-gitster@pobox.com>
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com> <20170315225045.15788-1-gitster@pobox.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Mar 2017 03:28:02 -0700
Message-ID: <CA+P7+xqa4Ku7M5ZjrHNpeetnAguZpjz920L=Q5+7mb2A0rFywQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Teach name-rev to pay more attention to lightweight tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 3:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here is a reroll of what I did in
>
>     http://public-inbox.org/git/xmqqd1die00j.fsf@gitster.mtv.corp.google.com/
>
> Junio C Hamano (2):
>   name-rev: refactor logic to see if a new candidate is a better name
>   name-rev: favor describing with tags and use committer date to tiebreak
>
>  builtin/name-rev.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++------
>  t/t4202-log.sh     |  2 +-
>  2 files changed, 57 insertions(+), 8 deletions(-)
>
> --
> 2.12.0-306-g4a9b9b32d4
>

This looks like an improvement to me. It may be that someone comes up
with a better definition for is_better_name() but it's definitely much
easier to do so now as it's easier to understand what the logic is
when it's separated out.

Thanks,
Jake
