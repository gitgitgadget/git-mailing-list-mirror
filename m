Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A635420248
	for <e@80x24.org>; Thu,  4 Apr 2019 08:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfDDIAF (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 04:00:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40704 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDIAF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 04:00:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id h22so1291552edw.7
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBTUihq0Ksfl2PgRTZkH4PGTut+Jj+KTu78cy/RO60g=;
        b=AQ8tryCJrCtdOhu4ihlMNRsLo9Uotni/KdTYYzrAMcobMfPvj8PL5nJG6D1fsKZQTv
         uBqBM7LCDGdiqBO3jJKqkaRq8RJxVNjnu41/lnC4qJMdL2JbFavDD353Dp6FfS3ntRRl
         BwQXVaB6qkQpHoxD4cRwTW//qHyve4UwrzoED6MrzhrHL+/Kd6ZwncWxKTfpSXQQxBma
         wt7Pim5hQKHowYgqv54ToB6JsO8pn/CZevgABqf9XZrsWTM1EwTQ02O1zk+vXm3cAlpe
         wkOD8y3ACm0N5JzojWDC7H6vlUDltkREytcgu2Vmr4sQGfqstiLGuyDJgthYjsBENdUI
         Y6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBTUihq0Ksfl2PgRTZkH4PGTut+Jj+KTu78cy/RO60g=;
        b=rgHrGpmoK4S8C6juAZh4rx/cmSQ+bw1YTFgKRYCgTY1r2H9pvbLfQf52bj+nh7BGEH
         XoN7+dyL1NhCTsq22QvcQW3UV9jjBdG22qAwjruahJhto95rTGooDD6sgawk4E/9OYVy
         nvvDkg2xqhSSAwIBZcsxt8sn79BV2U4xWf21l6vKirIG3wEtg1rPI/bijqslDn5TKO97
         a7ypolepgzkl5a8dwE3gu38qT65mcj7hToydybhOktn7D1MlJcHJ7nePpq0nqatp0r6n
         DGHFtg0tVvv+Sa1C1hO4+TnSCU7iHWJ7ABheD6DTcsDl7nijN4SceB2BKuXP4DDIYG+G
         hrJw==
X-Gm-Message-State: APjAAAVFni+r0UXkAbTXkvVe+gMeHTeXgDXKpRD/uyQ0Dw8HByj9p8u4
        Efz3O0j+BuX7dypoUTzMe4DpQssxND+Jmc4d7kg=
X-Google-Smtp-Source: APXvYqy6JYwHSQOdEQfIiKPYy7f+xM77Q9Wwxzc/yKdQwYKwRf+J1SvHbt4Ty57oMPwzkLxAs50ruuF2AfAYeyBoR3k=
X-Received: by 2002:a17:906:1182:: with SMTP id n2mr2713499eja.35.1554364803139;
 Thu, 04 Apr 2019 01:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190401164045.17328-1-chriscool@tuxfamily.org> <xmqq36mygrn7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36mygrn7.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 4 Apr 2019 09:59:51 +0200
Message-ID: <CAP8UFD2xpD=R6mK7bO9NrPbRKct+=OmMnXwM9+b4R2v0sR0+nQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Many promisor remotes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 4, 2019 at 9:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > This path series is a follow up from the "remote odb" patch series
> > that I sent last year, which were a follow up from previous
> > series. See the links section for more information.
>
> When this topic gets merged with the "diff: batch fetching of missing
> blobs" topic, the result seems to break t4067.

Ok, I will take a look. Thanks!
