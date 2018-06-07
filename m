Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A427C1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 18:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934835AbeFGSbh (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 14:31:37 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:42703 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934029AbeFGSbg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 14:31:36 -0400
Received: by mail-oi0-f52.google.com with SMTP id k190-v6so9516174oib.9
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tW+Em0ZeMAR9J5n5a2EVYOZjbSxvgHmxPq0FJltIL5Q=;
        b=RhMeUOtdEV3Feyyrwdp1MHkRkaIPrIc6xbX0k+qVgKYzgZCNLTkeZhA10W50VweaFs
         ZjwFS67cd3JNNNipXt20bDsPH2mctOX12EcZRZxwsHUZUk3jDn6R7eWyx0aGexG3/dJP
         YOwYlMUQKWMO0fHi37roz79XbgmLZGCnTf03JV599nySWQ7js/+L9b/CPGvCbBqnfTZQ
         CeZxxuwLN/jsCXTHoc0BnNtiSvBE3V2U26wTWpYLEaQ3Mo7gVn7pkIpWr8D+4knob/rc
         NnNhlQZf4wM6k9fM5V91bdUXV+m2AGENukQ6vrg7apk9WYK3uaI5DBMUU3uIhOZAahSF
         7QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tW+Em0ZeMAR9J5n5a2EVYOZjbSxvgHmxPq0FJltIL5Q=;
        b=nRBbQJtY8n3xXaCcucreDpBH8euUtK80ro8fDBSqjgsxU/hr+vwcdgWBpxQu+GVN+J
         j5J7D11JZtm9H4uxAykwztJOh3SNbBgOZNyRh539GF50jGJrnKRoKGypRRqsL34hjGax
         QSl2xJNUCmv8Au7MZb1j50X215yyDxu3hj1OcMlgGR/kBEaUwlcdQ2V5qFqRain+KVKz
         pOQPQ1sS6UmveZZNXXnNza49yFlazLoGuk2AOj80RhIirAfhKMcWY5pHJU2lT6E+oF7F
         H7hVH4xNcGTQ5EWNyi/3VXvziLp7CmaAJ7K4A0QARcN5pRhq5DLiNiox7ttmT6kBQkjT
         44mg==
X-Gm-Message-State: APt69E1e8Mvf/pXlwwQ1RKlbtjvpEFXD8TS+3IhCgtC4BcZAKXtH3Hzi
        hCCTVN9oQ7D9wrNEWV2mEQ9pmazRR9sIqgIkYpk=
X-Google-Smtp-Source: ADUXVKJz9lLpUCQmipKOrBxr5Lnt17kwlAczJttEYedkr0k/eByn8CZ13WaSIX961yj2uFL5qtC1XRzjle63gl7MXHs=
X-Received: by 2002:aca:f594:: with SMTP id t142-v6mr1594702oih.56.1528396296372;
 Thu, 07 Jun 2018 11:31:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 11:31:05 -0700 (PDT)
In-Reply-To: <20180607140338.32440-7-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-7-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Jun 2018 20:31:05 +0200
Message-ID: <CACsJy8DG1-YTSBSFkpM8BPcnKmvC-BjjK0W0+EckkdENPC7Ohg@mail.gmail.com>
Subject: Re: [PATCH 06/23] midx: struct midxed_git and 'read' subcommand
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
> diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
> index dcaeb1a91b..919283fdd8 100644
> --- a/Documentation/git-midx.txt
> +++ b/Documentation/git-midx.txt
> @@ -23,6 +23,11 @@ OPTIONS
>         <dir>/packs/multi-pack-index for the current MIDX file, and
>         <dir>/packs for the pack-files to index.
>
> +read::
> +       When given as the verb, read the current MIDX file and output
> +       basic information about its contents. Used for debugging
> +       purposes only.

On second thought. If you just need a temporary debugging interface,
adding a program in t/helper may be a better option. In the end we
might still need 'read' to dump a file out, but we should have some
stable output format (and json might be a good choice).

That's it I'm done for today. I will continue on the rest some day, hopefully.
-- 
Duy
