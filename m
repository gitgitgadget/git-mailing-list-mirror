Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC1F1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 18:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932200AbeCLScb (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 14:32:31 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:54399 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeCLSca (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 14:32:30 -0400
Received: by mail-wm0-f50.google.com with SMTP id z81so18561123wmb.4
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 11:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=v6SGqdg9PCGI5pHKyyntGRU5ciMpNzFd8ZGvhS/rVD4=;
        b=GvDOWtIRYy3NC5XYcRktBUZ9btzHyZg5TS2CefhZJvgVdorqHzU5XGNAJ38zUHiItu
         xWtrdPlsEOAufUrVTqLx8E4lIJr1zNquSNHA58c7wzR49XR+CV6A+n/yjGJrExWDopZ7
         C6yOpoSk/joe0XmxcERbSqdVUjOFbKflA+lNGhWM3awFWXU2H2p13GSOewLNQytIGf7+
         CBFl1Jhc5WldCQkqv38FqhKw3Cc5DfjE3frEU/9vP9YAifo4qaVr217OOWgi4k4lOTa3
         qNDaDGLYw0e6WlZ5r8Iuwav7tDRkY1VWgsbjidg80JYWh2Ge1fevDp1kN6SJx+425TP7
         Js8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=v6SGqdg9PCGI5pHKyyntGRU5ciMpNzFd8ZGvhS/rVD4=;
        b=V3+fTCwlZLxoq5KjWttDYXACORODVfiduxs1G75X3Hz8pyrlMjDiXUBofGzl6DgqNr
         6y2uQ3EVjXH5PC1nTbU0GuhXqv5nNd8cvtzmPj8V60mR0McCqkWspCnNn7RCC/WSNaWc
         YvTTX9jUKX+4D9Bq9irgG0C1GTEXkKFpefiytdAafUsnEn/JDIfDubnGxcEpEZXVMGib
         6VkjiHQ/NzE6R/oNkxCmjPsw42CNfaPdzmvTq2vH328P3SSN8CuLlg0aZzjbxQRAC6hm
         ZYKH9Gmdju76MJJsURwCGdf2Wh6njDDIgCLtT+ugyE4JABOWOE2cc0J7Yg0sivf9SxvB
         8Lvw==
X-Gm-Message-State: AElRT7E7q8wQlqgb8VEzNqFrabcuY4s+H2AHVRMNaBcROctGHiErAs3j
        BJ7LWH93HEZcqXi5Nw5EsEI=
X-Google-Smtp-Source: AG47ELtFu83FtbutJOx3HotKmp4OgReA0Atubg330HddCcS5HvorAbneV/anj0+oIv/OpCJuEsucxg==
X-Received: by 10.28.93.82 with SMTP id r79mr6028087wmb.73.1520879549107;
        Mon, 12 Mar 2018 11:32:29 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id c5sm1766692wrb.47.2018.03.12.11.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 11:32:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] pack-objects: show some progress when counting kept objects
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com> <20180306104158.6541-5-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180306104158.6541-5-pclouds@gmail.com>
Date:   Mon, 12 Mar 2018 19:32:26 +0100
Message-ID: <87d109qh51.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 06 2018, Nguyễn Thái Ngọc Duy jotted:

> We only show progress when there are new objects to be packed. But
> when --keep-pack is specified on the base pack, we will exclude most
> of objects. This makes 'pack-objects' stay silent for a long time
> while the counting phase is going.
>
> Let's show some progress whenever we visit an object instead. The
> number of packed objects will be shown after if it's not the same as
> the number of visited objects.
>
> Since the meaning of this number has changed, use another word instead
> of "Counting" to hint about the change.

Can you elaborate on how the meaning has changed? With/without this on
linux.git I get:

With:

    Enumerating objects: 5901144, done.
    Getting object details: 100% (5901145/5901145), done.
    Delta compression using up to 8 threads.

Without:

    Counting objects: 5901145, done.
    Delta compression using up to 8 threads.

So now we're seemingly off-by-one but otherwise doing the same thing?

As for as user feedback goes we might as well have said "Reticulating
splines", but I have some bias towards keeping the current "Counting
objects..." phrasing. We ourselves have other docs referring to it that
aren't changed by this patch, and there's
e.g. https://githubengineering.com/counting-objects/ and lots of other
3rd party docs that refer to this.
