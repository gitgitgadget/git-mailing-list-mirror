Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5FCC76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 21:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjDGVfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDGVfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 17:35:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A2E2715
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 14:35:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so44301280pjz.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680903310; x=1683495310;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtaH8KfOAOB463i9AJCLzOHG2S604eKCzMxoMb1J0Lo=;
        b=mOf2xLa6NOOxLeFGPYoa7TB5R+gK9RY28IIUOOE1aR318fRVOZWJ+uGdaHl3uhHg9g
         sb5EJAZFjStHktejIb/8tUYNGggcfTnSPEFYmjIemqCYvIzgYJ8fpsOXMw9YvO33jYje
         F4hPWaZ/booUG3AuVPUD2hjE1t5Q0uJx44WqwL59INU7Fcu4uvRzE5t9qtGFEzbvIhHS
         yLk9S/1e9tIAxYYpFG9UGXAdkhokygL6R0BJfu7kDjVcHWq2WU3dJjggN4ChcRGaRTIx
         bqkMPbGaiyF/k5iUebMjFeelj0oZcqRkKfJ5sj/r91calEv8xuyuCmehCVLO8ATWCnMA
         rBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680903310; x=1683495310;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mtaH8KfOAOB463i9AJCLzOHG2S604eKCzMxoMb1J0Lo=;
        b=kf9MQWhCPM3mD9e1FDAXF2O/F7EoZx+4iEbkmAe4pQCPTlcr4NKHJGcDSsB1lcJkVi
         kxuTw3DEiysgvsuo69quOcPg4WGht2FWS9aq2ZpONdsW+4Lu7z2pUX4VrKEZkzu9Tsn3
         p2xPUTLShyRuCX+Wa6rdAIY7CiIivAJyjTAj9EpO4GegKeLEVVxy27TZqB3HNtKx4cef
         LHV/jgUECtXraeiOjkzHYTePM3i3YpgJSLsY07ZUUsB+EPLBEjdG5/jSZk1QG1Fi3QUh
         YPKQAsg1SyIVOu03lRqjOQRwgTA9x6oohtqFyPkBOGR6crebfTAB+auQJwUkAXq5Kl9s
         wGjQ==
X-Gm-Message-State: AAQBX9dZ2K0c5j+FZYtEN2zCPG/No98UsInQQhCZ2Yf5EkjLsSvycoZN
        8IU5KrM0HdMCWjE+c5zKI9LI7GZrOo0=
X-Google-Smtp-Source: AKy350ZJbr6jw9ipC7tO9VaM0kxWeQ04PyrBEBr1LunnYzm1m+2vIAVdhPJJ9CN+gmlwMLrTtd2VlQ==
X-Received: by 2002:a17:903:234c:b0:1a5:2540:6ff with SMTP id c12-20020a170903234c00b001a5254006ffmr812378plh.68.1680903310295;
        Fri, 07 Apr 2023 14:35:10 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id x8-20020a1709028ec800b001a514d75d16sm1503071plo.13.2023.04.07.14.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 14:35:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] mailmap: change primary address for Emily Shaffer
References: <20230407212249.1541509-1-nasamuffin@google.com>
Date:   Fri, 07 Apr 2023 14:35:09 -0700
In-Reply-To: <20230407212249.1541509-1-nasamuffin@google.com>
        (emilyshaffer@google.com's message of "Fri, 7 Apr 2023 14:22:49
        -0700")
Message-ID: <xmqq5ya7jrzm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

emilyshaffer@google.com writes:

> From:   emilyshaffer@google.com
> Subject: [PATCH] mailmap: change primary address for Emily Shaffer
>
> Emily finally figured out how to set up their alias at DayJob, and would
> prefer to use nasamuffin@google.com, partially to reduce confusion
> between IRC and list, and partially because they just like the alias a
> lot more.
>
> Signed-off-by: Emily Shaffer <nasamuffin@google.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

Cute.  By telling the machinery to map "<emilyshaffer@google.com>"
(with any name) to "Emily Shaffer <nasamuffin@google.com>", and
using a nameless <emilyshaffer@google.com> as the sender for the
mail to add such a mailmap entry, the result of applying such a
patch, even though the underlying commit object created lacks the
human-readable name, like so:

    $ git cat-file commit HEAD
    tree cec72ed0d4fb9faa44cd8d23008f90da3239808b
    parent 0607f793cbe0af16aee6d2480056d891835884bd
    author emilyshaffer@google.com <emilyshaffer@google.com> 1680902569 -0700
    committer Junio C Hamano <gitster@pobox.com> 1680902794 -0700

    mailmap: change primary address for Emily Shaffer
    ...

would show with a substituted author:

    $ git show HEAD
    commit 2485a52e4b4419020286e98dd04c0e5ebb218f06
    Author: Emily Shaffer <nasamuffin@google.com>
    Date:   Fri Apr 7 14:22:49 2023 -0700

        mailmap: change primary address for Emily Shaffer
        ...    

I'll amend the commit to record the nasammuffin name instead,
though.


