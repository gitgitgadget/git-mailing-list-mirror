Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EECFD1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 20:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfAIUOj (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 15:14:39 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40613 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfAIUOj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 15:14:39 -0500
Received: by mail-ed1-f46.google.com with SMTP id g22so8338688edr.7
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 12:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfmrsMU3322TBZtFOqZ0F81qEkU7FwM1Y0eXu1F21Ys=;
        b=tUNkgFhhOSFW3flU6aVNTlO4UJCwuHinuXvEX74DF+ju5deHC+F356JzKl+J1Q78If
         ddrB46kLNSicZwnRWsSqQLDmUYZBN8HrInKLRNRZ58co63GMNpdYu/TqEu2QhigzKG2O
         W0P6VtPTK4VPupS6P9fwOkr0edzQGf8uZkkpXMKeBvq20NSaPWFQKP+Ok3RcyUmyyaEG
         tb4G2NOm8t0O1Q2nmEtGJIwv1Vj0ZKC9CZfDbRSoFMVjVnFeoQe1mrTlh4uxDAUIHOC7
         mfZj6u2EjK0X2214kQan4cY4K6SCLatQ8p6RPy3kjYIttf40O6MhnJsza+loK46xnVM9
         Y2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfmrsMU3322TBZtFOqZ0F81qEkU7FwM1Y0eXu1F21Ys=;
        b=t9cXus6XLzIYEjdL/dJBj6kZm6JQWTNpKoZbi17h3q56Yz/OOf9pR6rHdxP/S4Fno0
         K7mGv76oM6GP8HSU0zHOvWMXMMTNPKycUBMjrcvPHHTP0G2cXS7LEVSic6575P0dgTuU
         RRKYdR2YMRenDcfvZjhlaQHKL+Vm4uOQ1cxyvPmEP2FE/TOqa+w9QrY0BkiVMnAlhLSq
         nMeL1MHqgTTr7BHmc76VKhHMPW1kHQqKqN/hT1vwvv/PfZ55jxw2PHwVWuXRdCIu/YZy
         xA+yF0ZMaU5ze/pzUg1O3/jmHlb+nljhSXioi/ltoTJ3yJH36IxHWpW72D1fOcRKso7Z
         Rdwg==
X-Gm-Message-State: AJcUuke3LekrK5SZLNkIcdDV+rek28bbwoeVLWhdLVPQprkIojxH4PnK
        sqCSYt2hz0e5TKXBIAkSMXt73QT6yIRuDTEwIWIhQw==
X-Google-Smtp-Source: ALg8bN5yUaydQrRsewTn+FNFOXHfGYu9Peh8axMxaUJWLSTkE9poh901ZH87Dm6yZ0qA8QWzt1Ze3IhvBnt7Y+TI0Sw=
X-Received: by 2002:a05:6402:1816:: with SMTP id g22mr7372695edy.191.1547064877020;
 Wed, 09 Jan 2019 12:14:37 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg0NUNFjZumgC-9f=kmU3L4T+qOAgXwiDAfPaNtuFfvFg@mail.gmail.com>
 <20190109195428.GA12645@sigill.intra.peff.net>
In-Reply-To: <20190109195428.GA12645@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Jan 2019 12:14:26 -0800
Message-ID: <CAGZ79kan3yavtQOPAHUdkjTXeHpCGPb-igtNMPXjS6GCxOCS+Q@mail.gmail.com>
Subject: Re: Make "git log --count" work like "git rev-list"
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio Hamano C <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Unfortunately I'm not sure of an easy fix. We'd have to tell the log
> code "figure out if you're going to show the commit, but don't actually
> show anything", which means respecting the count flag virtually
> everywhere that would produce output.

This is (partially) solved for commit parts already,
e6e045f803 (diff.c: buffer all output if asked to, 2017-06-29)
but we'd have to extend that to revision walking?
