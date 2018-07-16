Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED35208E9
	for <e@80x24.org>; Mon, 16 Jul 2018 18:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeGPSn2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 14:43:28 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39114 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeGPSn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 14:43:28 -0400
Received: by mail-wr1-f54.google.com with SMTP id h10-v6so32848495wre.6
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UxzaIf229qFniXVPNOHCOC3wwD/Ch3EvwOFNJvRbB+Y=;
        b=rUZMuenlfv5g+jM+G9dGCKhzT6NNyZ3iH48OkaE9uaLjpaxf/7GWQRgQXyLuNSSWeJ
         LvK+isLGR0ThNH3crYULZTV48O9YmHpOczryOY/PqMOfCpHU5hsng3tCSKSL+4K/UW4o
         GjQnhdnOyxIJFlIfLbASsIc/6zECxm5nWeXTN2ftkIcKjBFKGgSGDwmMOfNZT4M5Q0D9
         ufoxXKprWmRpWPm8QlM4nim6fnNr18hiYAqiO/iaFcMbJMEtvgrG28DswapEhSwqs3qx
         /gkUKmIDIsQWRS15f5RInBFx2XYeUJghSka/gSliCGdX7vaNhvRnjoyPNHxSiTRImZXW
         U6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UxzaIf229qFniXVPNOHCOC3wwD/Ch3EvwOFNJvRbB+Y=;
        b=KzOidStmy/b8DwUNdRgl+6ptkDha6H3fbwUzIvJzQxdmzgrh/OqoXv+b28yBR9VA17
         5jWbqcLLjWs53g9aSDVsNYR4mSBgO3sVwLERNOFR/KUmLplPsciPB6GMDtC26IdsTQ/9
         Amkh95/sHObLUXrEQnamP5z6JcBHN8KLUx1H/7HoUlHr8vWjb8d5HILemfwZM2rJZ/+W
         rw87ylquqaI04fG1dAWieeN6Rzdfeoxl9qQ46DL16UCkLQXJVdkHjLhFwuM0fvXk4fJt
         hUZPls5zsSaBaxk1Sl0RB1ToIdDoPPcKhgo/j1slf5VNlkh2b/f1cINV6mc4qjgHyxrF
         mEYg==
X-Gm-Message-State: AOUpUlFO89Vya0Es22bNYsVtHP0vlZ03SJIkKljxjHImMs3qr4Rc8W1d
        0dghsZA5+LEjwQOgV9ZwLbs=
X-Google-Smtp-Source: AAOMgpf5U8yyaCmIcwxN+oouYuAHoA4wy8xc8dUYZqwe90NEn2QD23XArkrnNocI5nfPuNlgoT7r9Q==
X-Received: by 2002:adf:92a5:: with SMTP id 34-v6mr13757089wrn.83.1531764892672;
        Mon, 16 Jul 2018 11:14:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w21-v6sm16033779wmw.29.2018.07.16.11.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 11:14:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vitali Lovich <vlovich@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
        <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com>
        <20180713184732.GC968742@genre.crustytoothpaste.net>
        <20180713201949.GA17670@sigill.intra.peff.net>
Date:   Mon, 16 Jul 2018 11:14:51 -0700
In-Reply-To: <20180713201949.GA17670@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 13 Jul 2018 16:19:49 -0400")
Message-ID: <xmqqsh4jt5d0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> None of which is too surprising. The root of the bug is in the
> conversion to rebase--helper, I think, when presumably we started
> setting GIT_DIR at all (but I didn't dig further). Then 09d7b6c6fa fixed
> _one_ fallout of that, which was relative paths, but didn't help the
> subdirectory case.
>
> Just reading over this thread, I suspect the simplest fix is to pass
> GIT_DIR and GIT_WORK_TREE together, which is almost always the right
> thing to do.

Perhaps.  Not exporting GIT_DIR (unless the end-user already did to
the environment before starting "git rebase"---it would be a bad
change to unexport it unconditionally) may probably be a way to make
rebase--helper conversion more faithful to the original scripted
Porcelain, but I suspect in practice always giving GIT_DIR and
GIT_WORK_TREE would work well for many existing hooks.
