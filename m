Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88444C77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 17:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbjDZRnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjDZRnK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 13:43:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C24698
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:43:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b73203e0aso44937503b3a.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682530988; x=1685122988;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JufI3P+2sAP5kCVrjYOn5erwu9tZbCK3KNVvFa8Hqwo=;
        b=YUZ5NLwyFSKQOnPrN6VS+xY9JYlIrEtgycYunt29Oe+SZ4WRODQvaFWM4BZrVwHWax
         /MMTHp5+c5DN2M0FybsPK7IH5u2Cmds8y7q38owQY0I0XqEccQlkmiCJOpZNb8dGmJM3
         be8RVDwCCS4ptkh28L13sYhIE6pqye6Ck6bVMdtG87iHaI9qFR603+sBBaPhNjOKAS4m
         A0oabPvXiQTsvTmj9gbf+4anPEj+6U3gvZayhVcV/dtf6cJ7SRGs1e9ZgcUsu84SlXKQ
         e5zaAa0rmUPxdFJ/PsMDjEc9OWd3PdbS1+RS17MB6IYQcWAD5f/EzgaYv0IAhSf62Kxy
         5iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682530988; x=1685122988;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JufI3P+2sAP5kCVrjYOn5erwu9tZbCK3KNVvFa8Hqwo=;
        b=beWdl3QsuQlZCa5xRCi5CH8+/2yc6UjSKcEbcW+Lg/eZ5+hfPxgdaLoahVBrUGeysU
         RhjjSatGo0Rx7fj3/QXhiXjJHcm/E4xrDh6K6y45FEZhvP/XAdHV3S+f8gg7esGGaUzx
         xOVu6QdT8YYB8XXokAhY07L8CfgQkSk+lgNkVWB0jl9Ij9eFBJEch5xwuUQZlAMQ9wFC
         mZZsJTGq4CBLUB3HtuH2eS1UcyMO0vYT1GYCOHpOVhSSJe745i1YZaoRi9GJsd0pEM1f
         5J7dmfijomxIrkvR40LU6ZOM8J8LqNSboWij3V81Q3kzQ70WqHRL95FMSQpoqHyrwsJz
         J8aQ==
X-Gm-Message-State: AC+VfDz01OV9/N9FZ2k6TYZG9RlBHgeg5HrUUIzRtZnlTIK6S3Fpi/7J
        vlXdtUq5uPhI/ddRf4oVeCs=
X-Google-Smtp-Source: ACHHUZ7fmrjFelxIvI0Lf2puK6QoOti3UxGvOhp/bADPYuuEhkLqYf0P2xnV45Za9tiL/sh4KMY2ww==
X-Received: by 2002:a05:6a21:6da1:b0:ee:3ddf:9737 with SMTP id wl33-20020a056a216da100b000ee3ddf9737mr3742247pzb.28.1682530988157;
        Wed, 26 Apr 2023 10:43:08 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id z5-20020a62d105000000b00640ddad2e0dsm5248935pfg.47.2023.04.26.10.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 10:43:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Javier Mora <cousteaulecommandant@gmail.com>, git@vger.kernel.org
Subject: Re: Commit graph not using minimal number of columns
References: <CAH1-q0hReZoDWmXo7St10Dk6uc+6ZUQSxqvu1cJ7w3r7ftR9PQ@mail.gmail.com>
        <xmqq8refy114.fsf@gitster.g>
        <86188f31-f492-d195-d4d5-b0582906621a@github.com>
        <xmqq1qk6vd3v.fsf@gitster.g>
        <eb1c6c62-1081-a9d2-8504-db8bffc6c870@github.com>
Date:   Wed, 26 Apr 2023 10:43:07 -0700
In-Reply-To: <eb1c6c62-1081-a9d2-8504-db8bffc6c870@github.com> (Derrick
        Stolee's message of "Wed, 26 Apr 2023 13:35:32 -0400")
Message-ID: <xmqqwn1ysfo4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> To adapt this algorithm to a newer, dynamic ordering that cares about
> minimizing the rendered graph, I don't think changing the priority
> queue comparison would be sufficient. Something deeper would be
> required and would be quite messy.

Oh, I wasn't thinking about "graph-friendly" at all.  

I was wondering if we replaced --date-order implementation with
corrected commit date from the generation number work would give us
a better output order that users would expect in general (with or
without --graph).


