Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33CA71F453
	for <e@80x24.org>; Wed,  3 Oct 2018 09:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeJCQmu (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 12:42:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34133 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeJCQmu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 12:42:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so1448936pfi.1
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FoRJtzrK6ZI2jygIaM1hQJ5/Z3EgNkn6jMRPT0To64k=;
        b=DAn0yteTOlNU6/SsljmmRiQ/jy32ZJ/9rXEolRbOtE5qFSLsG3pS+Ke7X10LlF+Dbb
         5hV7ZNsuRHo9wpSmHFVvFctWzXLgvyZ1o5Qki/wsEtxKa/jFFKKf6paL48NQ8/E/cyui
         j6F174Sd6DMaATeFPqwFdNBmXVH9P6HF0kEAK9ZTHuyb8X66+yw2JOu8pbtjcxC4XEiq
         mneh2WJVibCe8aC5Sd6OZBgKQJHsOUdWskaJm131llLufvR7onMACBB//tRQ4HnQvEPV
         yNASC5IKHmkgY9SfUvKvfO93loEGRdmDrLT7I3nbv0fBvx/PH/nqERabjlquA1E3W+Ha
         IheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FoRJtzrK6ZI2jygIaM1hQJ5/Z3EgNkn6jMRPT0To64k=;
        b=Uo9yeAbpVtU8GlzKn4uOqUYZ/jfKswW/upXsSceGg7+bpDb0tAFN/gwP+2KWM+jbrC
         oCkNlk1/N914K0y+STtPJTXKdtr7WhkAjf2bdK/wMwS7ATCVleQwJbUk3mCtR9/85uGi
         j0o7r75bssq7YUr9DSFMuzlSQ5ArJcyGAbLbqmiuqq9s07DwvTXr1OfnI7PWmY9UTWhJ
         iSegw3lXkgnGIkTB6pSmhWbzK9fALBvoQavuqsfFJDnx3KP7oK/kEuAG0Wmm3QS8km6c
         EQzze3Bde9dw0TkSfRYNnUI/oWm3taTmdDQJQ57Gaa9L7bfTuYe++3GO9gr2L8tqUC7s
         4SgQ==
X-Gm-Message-State: ABuFfoggkbokW+vQGah5AahNbnG862BxIBGN6+Mk3L5TqgIbFgSKCYo4
        ULV2ilVBtO5KkzqDngYuJt5tpyocT1JYOtEnF4k=
X-Google-Smtp-Source: ACcGV61C6wDAknEtvIx8ybp/Jsv5WHk8dv2T71Azh1t4tk8aoJoqs0c1zEDNgJ9DXC2KmnxLSjv3/RJGirceDMarTho=
X-Received: by 2002:a62:71c4:: with SMTP id m187-v6mr763888pfc.232.1538560510143;
 Wed, 03 Oct 2018 02:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181002175514.31495-1-phillip.wood@talktalk.net> <20181002175514.31495-3-phillip.wood@talktalk.net>
In-Reply-To: <20181002175514.31495-3-phillip.wood@talktalk.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 3 Oct 2018 11:54:52 +0200
Message-ID: <CAN0heSpF_5WSHWWwFYnQYWhwMopjOSB8JvKh2DYhRORjDN_jdA@mail.gmail.com>
Subject: Re: [PATCH 3/5] diff --color-moved-ws: fix a memory leak
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Oct 2018 at 20:04, Phillip Wood <phillip.wood@talktalk.net> wrote:
>         const struct emitted_diff_symbol *longer =  a->len > b->len ? a : b;
>         const struct emitted_diff_symbol *shorter = a->len > b->len ? b : a;
>         int d = longer->len - shorter->len;
> +       int ret = !strncmp(longer->line + d, shorter->line, shorter->len);
> +
> +       if (!ret)
> +               return ret;
>
>         out->string = xmemdupz(longer->line, d);
>         out->current_longer = (a == longer);
>
> -       return !strncmp(longer->line + d, shorter->line, shorter->len);
> +       return ret;
>  }

The caller only cares about 0 vs non-0, so this would also work:

   if (strncmp(...))
           return 0;

   ...

   return 1;

Just a thought, to avoid some "!"s and the new variable `ret`.

Martin
