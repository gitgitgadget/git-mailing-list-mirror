Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3320DC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 16:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjDAQ1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 12:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDAQ1N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 12:27:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B50E06D
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 09:27:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z19so24253834plo.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 09:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680366432;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmI52c3GkWAvOYARNhQsD1KwZFxDbMgxSNOiAPuTDAo=;
        b=WXG5FJJOAZp+Dj4HA4z85DGHA96H2fKn+dTAaI53xTqvAwbdpTEp6RyDYETnxTNnZg
         AjEJ2FJEkjH4zEIQ/BBmjUEXYwPmYNxZj6zkInMyucjMvr6fg3MwijHXN1MlEOLJH1Do
         PNqj8qWo5CaxWgsb0/oosY1owKuCwQ/HHtuKrrjkOOYSzb36RWsGgBquQoe/KNzjnflC
         yacgBDX2oBJszYMN/ao0v11KvCcTsEpSU0pXyW4wSahXugX29IkqA+VJM0fSFZf+Dnh9
         fcQRfckFK/v6asuYasW8jOcSnLmV+JEr1s/95ob6HmOb6TflM1X9lP2hpveAAOab4Xbo
         60WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680366432;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmI52c3GkWAvOYARNhQsD1KwZFxDbMgxSNOiAPuTDAo=;
        b=S+XNqrLb7Q8D63TjDuTYn4BcADf9irQNzBvUj8BPH1FrKjMw57moxeA1WkJkLhL9LU
         WQXtTv1nI0e35SwJGOw75vIf0ufu4yHQwz2k0p2KB83efdzyeWGUr+MfKIk0dzIzNU//
         EHxw/cifSci8UwljaUJ2OJ5iPIaQINbhN9OOwCvTkiXWBLSR+OS9yKdjcdoV4J/zMSc5
         qjrxjVQph6mTj3uK1hannlPILxQbi/DfEsfEPTxg45+n3aP4NJEwPP+1arySTfRdICrs
         8YGRyYVbCC2JN5w/XBlHbCUIXARwoIge72JSNU/h5EMHmDY1DVQALGoDa3Eu7h8CulRE
         cGgA==
X-Gm-Message-State: AO0yUKVr7+7Re30lOI2XZLi6SpvohcjRDtm+k2+Ie9BnEWQuK/CGxaqw
        keA6xeQJ0Pgoop5IagV43z8=
X-Google-Smtp-Source: AK7set+iukcCweftXXj6KAI/Im3DNkBxkXN8RMbxdLe53LkxEL1YgxcADNW1PsESd7JkPHaZ3+OU/g==
X-Received: by 2002:a05:6a20:c10f:b0:d9:84d2:7a9f with SMTP id bh15-20020a056a20c10f00b000d984d27a9fmr28468137pzb.24.1680366431653;
        Sat, 01 Apr 2023 09:27:11 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id t13-20020aa7938d000000b0062ddaa823bfsm3826209pfe.185.2023.04.01.09.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 09:27:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt Gardner <four712@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: macOS git grep change in required character classes
References: <CA+MNPvgceR3s30LaCS716NGw+8S47CQZTqFno=vE2XAuiBA7Kw@mail.gmail.com>
Date:   Sat, 01 Apr 2023 09:27:10 -0700
In-Reply-To: <CA+MNPvgceR3s30LaCS716NGw+8S47CQZTqFno=vE2XAuiBA7Kw@mail.gmail.com>
        (Matt Gardner's message of "Sat, 1 Apr 2023 11:50:28 -0400")
Message-ID: <xmqqa5zrbmap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt Gardner <four712@gmail.com> writes:

> My best guess is that
> https://github.com/git/git/commit/1819ad327b7a1f19540a819813b70a0e8a7f798f
> is causing git grep -E to require BSD style regular expression
> character classes.  I don't know if this is a bug or an unadvertised
> change in behavior.

I think you diagnosed it correctly.  The story is "Once upon a time,
we declared that the regex library of macOS is so broken and
unusable.  We used a fallback definition to work it around, but
unfortunately the fallback library did not support multi-byte
matching correctly, which made some folks on macOS unhappy.  So we
let Git built with the regex library shipped with macOS starting
that commit, with one side effect that patterns you would feed Git
on that platform would behave more like patterns you give to other
tools on the platform."

So, it is not a bug in Git, it is a deliberate change in behaviour
with unintended consequences X-<.

