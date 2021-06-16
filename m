Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229B5C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058DB61351
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhFPFBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 01:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhFPFBS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 01:01:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FA3C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 21:59:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h12so498731plf.4
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 21:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iy3JdpAxbWLA0O/vWxQePZoiXqY4iy2Hd25DSlLKjzM=;
        b=dqdM+4ieFUV5WrToNrzDTGGQjplsJXdUDDhWDUq2MSYbUtZZ1QBTysFXrN2ndUsoRD
         KZKAsiP3V5n93GtlA4vvPZBDbDe1zwvjXT/FZ/lqxwn9OSEhWxJ4S7XRj+ESVfp1lhvx
         26WstshuoBUaVXhQImGJYFgwAGzShKU0pohnew3YYNZfnghEEFQ8gppjC3WKIo3Gfm7P
         0omNs8c3k18ziHCp9bfdSEaLWub6v0NH+qoLcd0Sfs8UjmtmX81uaxwClTadqdpCpUEt
         aym9x3Rb2Pzhe/1M9Zd+jfBEcNgukIieginhKERpnFie59FqSl/Ce5uRU8sJp40Zqydm
         Q8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iy3JdpAxbWLA0O/vWxQePZoiXqY4iy2Hd25DSlLKjzM=;
        b=g03VqcdxK4b1ea5uRYsjmYfTwMO3WswXOLuQ4o02jT0+VXWEh3DdG0oBfcty4mognp
         UEinszpSPg59V13PlTw0527CRkcqI0jUf2giqmlHdyCvREyTLlJm8Ci7E0Yk5xtGi+vm
         HlkSCTsET+Fat4fg6kee27AxXX+WwgtsMo38mOXNtBW7JIddMnJn+hLFXps+fBCJiHKA
         FL9xf+X0YtaKMwTEvlHKgHICZ9XBqHjkXmj8RHL9/EMXGEZvYmaCbI0Zvk3AkXs4JNZs
         DBCVq4CN3FatR5iVpbwIxFpQnQSBHN5vIT2n4qaXYJoPPcWYyQ0qDC+L5gSI0fLCDvwY
         2OuA==
X-Gm-Message-State: AOAM532x3AGZiBCX/mweP6dkmRFuEAAUU1NayKZDNLGi9QDmargr026d
        2dOA9vEudcF8NLyerJFBt4SaA+aAJORn9zOpbuv5EQ==
X-Google-Smtp-Source: ABdhPJwd7+kyfBRaiUFrxMo6lkjIg9ZPWJGkt4yFxa3s27zlncPilyPK+WDz/3uz9TVYhYbYLRRA6Sy6riHesdWmtw4=
X-Received: by 2002:a17:902:d50e:b029:11e:a837:7106 with SMTP id
 b14-20020a170902d50eb029011ea8377106mr1638052plg.70.1623819551950; Tue, 15
 Jun 2021 21:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <65b4040c-2a9c-7d49-43ce-dad7d5a9c62d@gmail.com>
In-Reply-To: <65b4040c-2a9c-7d49-43ce-dad7d5a9c62d@gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 15 Jun 2021 21:59:00 -0700
Message-ID: <CAGyf7-HyUHJacvpwx6R+_hCVsK_t3F1mQ++2_4-NeJWB9uUjdA@mail.gmail.com>
Subject: Re: Simulating network throttling
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 9:56 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Hi,
>
> I would like to test my Git repository in case the network is throttled
> (that is the network speed is reduced from its full speed). For example,
> I would like to test git clone under maximum download speed of 9.6 KB/s
> (GPRS speed).
>
> I know how to test for throttling in browser, but since Git is
> command-line application, is there any way to simulate network throttling?

I've had some luck using toxiproxy[1] to MITM the connection, at least
over plain HTTP. It's worth noting a warning brian m. carlson has
given others in the past about this sort of thing, though, which is
that many MITM solutions are not fully transparent, which can result
in protocol errors and other abnormal behaviors from Git. Your mileage
may vary.

[1] https://github.com/shopify/toxiproxy
