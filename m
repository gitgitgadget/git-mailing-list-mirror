Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689851F462
	for <e@80x24.org>; Fri, 26 Jul 2019 13:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbfGZNuX (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 09:50:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36818 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388269AbfGZNuX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 09:50:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so53363952edq.3
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=F0WyjhwfCp+aG5SBunkQuEd+WvyBCh13VeJqnqnaVNw=;
        b=VtUa3VGnp3poHhv9/knK0fEEEkjHhGsAQQjDHfveGVComYV6DVje186QcfCTDBI7oa
         3CEZ9ONtI7Qkpb6wwtZXl4FJqT2zyRcOISASemp7KRHFDt2Q34m6UUhSBlOyZgUjol9W
         /VRpqYDOGrE92Vh3uryQJO27HNA0nEH/KEwsAuY+A/tl1ju6/GJcng7LYR6ANrpbjGHL
         rzt0UVnSJnQmsH5Rsw05jJs7AHb9pegxy9QoFL7MlPZw2fBJA8EE+KaV4Oo42ROVqzar
         6QEdYMelsiEKRx8IeQi/55NrTHQjiWZwMVLGLL3Z83iZ7gzfatSIv6CwQ7H2ooR49+46
         PKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=F0WyjhwfCp+aG5SBunkQuEd+WvyBCh13VeJqnqnaVNw=;
        b=jWjpM/Xf/Dw4Cuy9jyaqh/pEm3vHefoEGSfZzJKb9BMQc96ZJDc3ecAFiTtjfhZvlf
         8XyrS0tsJWn4Uv5Q8bItdGUc5Hnx2kReKvFPJz/bc9MSZDYJD11/hdYT4tT0UH56qk82
         kkqAh4MimzUSYy6bPu8+Rs55WNsxG3hUwGD8G3xBLmaEvOFjaft3Hz4nL8VLZ3HiWz3L
         Np4w7P1aXwmsvV6wCGNI8zggzt0lLbqSyPCwC3fuOOF+OgcsXWjZNcGsRe1nUzYk0KCa
         v5tcZiZ8VZF1KJjS6hBDt6kMfdSOxBCnHC6y4OjYezhUTTTDUe5JZvNBja0HuUvtIaHI
         772Q==
X-Gm-Message-State: APjAAAXRXGNRjXQuq0MwGzKkiMsFaiAO/GRK/8QJdENiAXd+sFIKvNt1
        553pZc4WtGOITDRBYqfl/AE=
X-Google-Smtp-Source: APXvYqw3wJ+4K7/ORLyJSFOvRvn7rlLyXIgW6IxqdeJemZ8qGLottJjvNhNcCXNO4ktqqXYHx/arJg==
X-Received: by 2002:a50:a942:: with SMTP id m2mr82804411edc.73.1564149021252;
        Fri, 26 Jul 2019 06:50:21 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id b25sm14100989eda.38.2019.07.26.06.50.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 06:50:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] grep: stop using a custom JIT stack with PCRE v1
References: <20190721194052.15440-1-carenas@gmail.com> <20190724151415.3698-4-avarab@gmail.com> <CAPUEspiCFup4wvNwOA+egiAjkUEPgU+YnU8x2DfKhdbqTdOV3w@mail.gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAPUEspiCFup4wvNwOA+egiAjkUEPgU+YnU8x2DfKhdbqTdOV3w@mail.gmail.com>
Date:   Fri, 26 Jul 2019 15:50:18 +0200
Message-ID: <87h8787vmt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 26 2019, Carlo Arenas wrote:

> since this moves PCRE1 out of the JIT fast path,

I think you're mostly replying to the wrong thread. None of the patches
I've sent disable PCRE v1 JIT, as the performance numbers show. The JIT
stack is resized, and for v2 some dead code removed.

> introduces the regression where git grep will abort if there is binary
> data or non UTF-8 text in the repository/log and should be IMHO hold
> out until a fix for that can be merged.

You're talking about the kwset series, not this cleanup series.

> this also needs additional changes to better support NO_LIBPCRE1_JIT,
> patch to follow

Looking forward to it, thanks!
