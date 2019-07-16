Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3D51F461
	for <e@80x24.org>; Tue, 16 Jul 2019 07:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfGPHKa (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 03:10:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37668 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfGPHKa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 03:10:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so9619935plr.4
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 00:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzgMZNd991HW05KxOk3Ws7f7DpwYoSv8f3Q3WRF12As=;
        b=lGCxGfpY36ZmdreLh+qCd57jChu+6+tezIWvzbhdxX8K6L5FEZk/+lNUetzQb74wqg
         rayWh6Gnsn8kln90aWJlZY1jiMDlqI5Fd62ZySPf/BFDVg8jDAoDIvAMOAVS/SdXdDJk
         cZIuV75she4EDcvFXnaNdGbOzL7KiF3Xz0PkTXciIBGDHpWH0UIk6wR5/XnalkvvM2TM
         CTAqRqGZ+WQsvWcwrUHX6QJEco524rT5PW/M/on0XljhsPrtNC+XW9voldchxH3lDP9U
         DxS5IIY3qslgCaIc5ne+HHYSYMf15q8CDVlzWAqTb5wkWItA3/DPeMCWN/iHqKzLLbfj
         VzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzgMZNd991HW05KxOk3Ws7f7DpwYoSv8f3Q3WRF12As=;
        b=ImKeZhqhWp3XSC6aPyw6hE++MBrjdFhuCxAlpXnl8RkcsnShEUcwb+2EErbagevKyt
         YArA6DrtKniXNm/7Ur6W+JrX5xilf00vYC6NCjaRZRHZti6rb9Uc5QM231EOPCB3zRGY
         1CitRVPjBZiqvijuQJJA5ejYiDi8LSTgqqNhK/f48dRrI4jsPTQv9K9x4ryqz2jcYzmG
         vXRDmW338MbGK8LKvQJVXZ6ZRwS8nMWd9iONXmVckSZVccmfVG+r5ktS1lv8skz6jYm+
         oYFwKOydfhIrla3HW+CoaPMbVqx0vMe2DC5EI9IWooagARkTupt3NFtYuI97VJdB64fB
         CkVg==
X-Gm-Message-State: APjAAAUJvXPQrilkLHja6DCSnflvb1BjV7Ueo6b8budgfntWggI3r5dr
        zl2H2/EIcQW/hi++rle3iFyAvs5mCvMFfosjiZQ=
X-Google-Smtp-Source: APXvYqyEDFvybQsCr0FBHKmMWQcafF+cI0+Wo6Ktb2J9fCbb8ql3f4Mxc+clsdHKblJ8Tdjti4dDF5Z+TGeuSV0fANU=
X-Received: by 2002:a17:902:aa41:: with SMTP id c1mr33071669plr.201.1563261029336;
 Tue, 16 Jul 2019 00:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005340.66615-1-emilyshaffer@google.com> <20190709211043.48597-1-emilyshaffer@google.com>
In-Reply-To: <20190709211043.48597-1-emilyshaffer@google.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 16 Jul 2019 00:10:16 -0700
Message-ID: <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in push_refs_with_push
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 9, 2019 at 2:16 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> diff --git a/transport.c b/transport.c
> index f1fcd2c4b0..d768bc275e 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1226,6 +1226,19 @@ int transport_push(struct repository *r,
>                 err = push_had_errors(remote_refs);
>                 ret = push_ret | err;
>
> +               if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
> +                       for (struct ref *it = remote_refs; it; it = it->next)

moving "struct ref it" out of the loop, allows for building with ancient
compilers that don't support C90 (even if only by default) as I found
out while building pu in a Centos 6 box

Carlo
