Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730011F404
	for <e@80x24.org>; Tue, 10 Apr 2018 20:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbeDJUSD (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 16:18:03 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:43582 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeDJUSC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 16:18:02 -0400
Received: by mail-qt0-f178.google.com with SMTP id s48so14785793qtb.10
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 13:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=o9KX3C2HYh6S2XPQ3rMBQQFTp70IWUxbMoGOE7Mc6lU=;
        b=u84NrRJyLFHj19wLb9/XBH4y5d0F6UZKUooxKUMAl3n3UdCVHCz2JVzT2IoI7ij59e
         UkUd9/IjL46iSgT1c6kevjPOe/Pf4BGJP/dSHSJ6JH30yRySqY+86EgueyLX3WFRUJRg
         ESAdxlSzgklnhbpDRM5gr0AgyZp4sux2ZSJebRF24ExPh/Wjtbjv7qeVb8WNQ7GSwJp+
         MuxpwfL3mNvVEGskgq7AecC83fqIZTPBXA88htmdWKEBEcr6DjC3M2ECekPod2+0GTcp
         PQndFWe0F45M5saYAy3Nzauuzrmiykxl6i/aCzQZRqMIh6jnyZC2+79dr/QARtseBAdh
         RfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=o9KX3C2HYh6S2XPQ3rMBQQFTp70IWUxbMoGOE7Mc6lU=;
        b=d6m2eYE+und0HO8kUr/8/PtFc4jpB5/A+eyJkjBK7bfYDVyzapZaTGWn4oodrQBtZB
         hlwfuiRjSaXDFHCd2VsCTlTJoozIx8phWAq2E/rqWpEFo12nXY4Q2g9AGg8ocQdPVjVz
         vU8d9t3P0ZS3Giun+5wsOgc3L5MdDPBrvDR2QAisrCgqUirKN+c+z12wljTAJ/DuHHcR
         Sj+Z1ZxmQ5OYtcchX3l/lK0Muw9ZrbvD2cYAPSo2Bmkl1YZm8+gsSxGt4U0T+ORSLuhd
         oc3a+pn1elLiizj4KlSmEjZMWgt+S2y1L4ngdKH0aCoim2OhINzx9dci1Hbj6e1patNU
         jnMQ==
X-Gm-Message-State: ALQs6tDF15NEJstGlCilOeMmUGT/MYQWWqupogN8hLE/R8lB0pgFfgy8
        mWz8kH/vSeEBtiUXZOxxJQlbb/zSeDTcSkxv5Bo=
X-Google-Smtp-Source: AIpwx4/OOATcE8BndCi/kdYCIZHbu8lai14473XB5P0TAg1ki+A5TmIv09fMeeRpFC93hZOf39Vc8U0F9RFeAo+QrxE=
X-Received: by 10.237.49.195 with SMTP id 61mr2940182qth.77.1523391480214;
 Tue, 10 Apr 2018 13:18:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 10 Apr 2018 13:17:59 -0700 (PDT)
In-Reply-To: <20180410184327.13896-1-benpeart@microsoft.com>
References: <20180410184327.13896-1-benpeart@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 10 Apr 2018 16:17:59 -0400
X-Google-Sender-Auth: 6Gsj2NC618Yemvel81SYGK0fxEo
Message-ID: <CAPig+cRvujJ2RmH62qnjS8asRn0wc+f-O+KA01NfFXuJDk3fog@mail.gmail.com>
Subject: Re: [PATCH v1] fsmonitor: fix incorrect buffer size when printing
 version number
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 2:43 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> This is a trivial bug fix for passing the incorrect size to snprintf() when
> outputing the version.  It should be passing the size of the destination buffer

s/outputing/outputting/

> rather than the size of the value being printed.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
