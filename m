Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033FD1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 10:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeK0VvZ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 27 Nov 2018 16:51:25 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41408 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbeK0VvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 16:51:25 -0500
Received: by mail-qk1-f194.google.com with SMTP id 189so14222188qkj.8
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 02:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fZgQz2ZjulCoZIfK0/xxNdyIVankwNiGOeqkNNkhDD8=;
        b=gKkGIYcO9nkw8ZSMEaP3sNzprX01mIRThp8qgUB+Cjc5rDrp3RKM7Qv13ZKdHxDsuC
         3sYo40i5iPaaM42UIzSgq6AQqztFKEl02WAbnD31i794KkKkCYqUWn+0qMtI969NHIz3
         SwHXIfuoHfEtgoLNnXxPxztsXMebmyefo6gOqX6KsZVaxY/pXNWV5qpz58JeAMe2f1Ht
         FoAjuj2w6J7cBedzgdJgDCwOO/qYb0cSBABYjulE3gdI6Vqoh1ueZKNRpS79pDnuQmMV
         aYoahxQNilagOLkwQObpWIDhunMHXb1F4gg1OlucnfCNTkR0MvRA3OvlmgkJZZBsPH2G
         f0ig==
X-Gm-Message-State: AA+aEWYjNb07IL8q9r1XxtTvDQe/ZnEiFM7u8bfOBnT8PTIhwY9ipzf8
        eY3dP+bifZa3iGYy5sIczQVISYd3oDPqT2UxNT4vzXQv
X-Google-Smtp-Source: AFSGD/VE7eO7ZfT/mrqW2IjGVFArj95cZQw08HgoZATXELp84Xr4ZM2WkC0Ls+f4xxSQcw8vWkTO0b9VcmCqObWtMKI=
X-Received: by 2002:a37:66c1:: with SMTP id a184mr29099408qkc.314.1543316034309;
 Tue, 27 Nov 2018 02:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20181127100557.53891-1-carenas@gmail.com>
In-Reply-To: <20181127100557.53891-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Nov 2018 05:53:43 -0500
Message-ID: <CAPig+cT1ruGsd-7yXV3Oxs2_9zOh-d4HgZiQ-OVZzHc1buo4FQ@mail.gmail.com>
Subject: Re: [PATCH] config.mak.dev: enable -Wpedantic in clang
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 5:06 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> [...]
> -Wpedantic is only enabled for clang 10 or higher (only available in macOS
> with latest Xcode) but this restriction should be relaxed further as more
> environments are tested

We know from [1] that the clang version number "10" is an Apple
fiction/invention. Perhaps this commit message can be worded a bit
more carefully to avoid confusing readers who are not clued in to that
fact.

[1]: https://public-inbox.org/git/CAPig+cRQXQ_DowS2Dsc1x3TAGJjnWig7P4eYS4kQ+C2piAdSWA@mail.gmail.com/

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> +ifneq ($(filter clang10,$(COMPILER_FEATURES)),)
> +CFLAGS += -Wpedantic
> +endif

Should this condition be tightened to match only for OSX since there
is no such clang version number in the rest world outside of Apple?
