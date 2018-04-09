Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764D51F404
	for <e@80x24.org>; Mon,  9 Apr 2018 00:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757133AbeDIAs6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 20:48:58 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:39908 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757128AbeDIAs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 20:48:56 -0400
Received: by mail-wm0-f49.google.com with SMTP id f125so12800041wme.4
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 17:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IP8Qs4qc+qIHNsm73E9GY2XFnvX0AQaId8kF3pRrkb0=;
        b=IetKAbK2M83RowKZECu6Zlmi9/dDDWTen58YbVWmg5gLfw9TKzFpiGkxGnIF+puv0E
         TW6jE/1eWsgpoYLDmTMwKLhUXJWIkYVna5mF7324uNJhrRiTublu2YETGwVxjxdZ/H40
         KOqQXekqf3RGTZw4wMDFeyRmOQLRwAifU21d+jJs9sKYzO+czsdJP7z27Fc7VwF85FNQ
         gu/kZRIuFaOCBfi6mnqUPoy1veHKP9smoeqP+X6NtcnvedCAtwg9cQQve71hQcb8ibD8
         Fj2hlanq45gZCjmM4l6l2KWpM+sxM5jBXLOpiK+sZLtpDSlMXuZx2uPW3kEwmQV77BVq
         u92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IP8Qs4qc+qIHNsm73E9GY2XFnvX0AQaId8kF3pRrkb0=;
        b=axhKjgXeMvTVQpz/FTyrhbuG7BUcMk8ufPT+sA+mHXQwHrMYPVxwirW9vUxylvgH9u
         M6xL9NpsU8RHLc23CYkWhk+8NkVhQ61Gy9xkO3/GHxDSjrBjyzK+i+Zj0HHvzNk/J0SQ
         Vm51MAHB6uWxAQup5eyfxXcrpiVnROGlHNRnpPoiadIrZjw/U1rmy5+jO5U7b05Ntd2/
         UNMiepY6TSw/X0WlmE9sFuQvxudRQKS404zvDKNV/ejEljnsnQey0mkQ89AjK9tAJoji
         Cv2kLk+tuVa6txl0FLNrz7WAswbFCH2UqTyl+NR8MIUUT+pAcyIBnClWR4Q1Hbpxxnar
         NyDQ==
X-Gm-Message-State: AElRT7GomVrTcsZRibj74fTzP+Hxt3RqJKHdFDJQ3KWybmiXDFHBSYfe
        t8xXhXGuxhciOrEbwC3Pb5Y=
X-Google-Smtp-Source: AIpwx49+TgbjXFmGHj75jW3EiZopSZNhh7is6TICFW5uq+ULR0X+5wx5aBWxWkY4ayXQNr9u3PRK8g==
X-Received: by 10.28.110.17 with SMTP id j17mr21179741wmc.65.1523234935305;
        Sun, 08 Apr 2018 17:48:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j4sm14994024wrd.53.2018.04.08.17.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 17:48:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 4/4] ls-remote: create '--sort' option
References: <20180408122832.65414-1-haraldnordgren@gmail.com>
        <20180402005248.52418-1-haraldnordgren@gmail.com>
        <20180408122832.65414-4-haraldnordgren@gmail.com>
        <xmqq7eph9wds.fsf@gitster-ct.c.googlers.com>
        <CAHwyqnWe=KmmdGJJ_DnCK+D_FoC0sAQG_8=_p+4+Yxmr8s8sPA@mail.gmail.com>
Date:   Mon, 09 Apr 2018 09:48:54 +0900
In-Reply-To: <CAHwyqnWe=KmmdGJJ_DnCK+D_FoC0sAQG_8=_p+4+Yxmr8s8sPA@mail.gmail.com>
        (Harald Nordgren's message of "Mon, 9 Apr 2018 02:09:15 +0200")
Message-ID: <xmqqmuyd6w7d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> It is not too big a deal, but I find that liberal sprinkling of
>> UNLEAK() is somewhat unsightly.  From the code we leave with this
>> change, it is clear what we'd need to do when we make the code fully
>> leak-proof (i.e. we'd have a several lines to free resources held by
>> these two variables here, and then UNLEAK() that appear earlier in
>> the function will become a "goto cleanup;" after setting appropriate
>> value to "status"), so let's not worry about it.
>
> Removed the "extra" unleak annotations within the if-return blocks,
> but kept them at the end.

I actually think that is worse.  The UNLEAK()s near early-return
serve to remind us: "here we are making early return and when we
properly plug the leak, here is one of the places we need to fix".
Please keep them, unless (and I do not recommend to do this) you are
plugging the leaks for real.
