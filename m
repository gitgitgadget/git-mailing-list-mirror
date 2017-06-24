Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A63020401
	for <e@80x24.org>; Sat, 24 Jun 2017 18:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbdFXSNb (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 14:13:31 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35933 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbdFXSNa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 14:13:30 -0400
Received: by mail-pf0-f174.google.com with SMTP id q86so37015408pfl.3
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+ccvBaUP8CU2skRGICMLNpnMf0OXiF46IvRzjCF+Xhs=;
        b=LiUxD48wD8A/cXR+eJknGy7TJked1OMZHXvpfUgHwYD9yFWUpMe56nZy8/JMpW35Zz
         4iUDxDhP0iYCYEGu3hpmelyCWI90uEb5YxhxvnyxjU65q7Wyk2HH9G6UwAwtiNNjNzDT
         H50ru6YIbT6ZJkzZfrr3Dxy5WpdAyWwzYHSUtsZcnMMnJ4X1t7DlbQi/VsKRRk+AzuJ9
         s0c83JKGbMtQ12VjeQjBLsRQVQJ0lnHmrUvHuTYYdD0n/QemrS3F4VhDC4lpbvpAfBss
         GxA28Rwh0RzhyyicVHhQPdr+IM5A4dzm0zPnouJ93YQhz2DuVSIeKPl1+Wl/Wa0vk3fH
         O1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+ccvBaUP8CU2skRGICMLNpnMf0OXiF46IvRzjCF+Xhs=;
        b=aiAU6KjDerOYqUZswH53Ko9sKTYThhI4LO6tLOwcOCqqysuHHfdVYkqv/Iwmv1EbWn
         wgmBV1zck1a/yl6cVa8ho+EZv6rkEtKpVtxFC+JM7YJ5b0ee3fF7duQ5/Bvt7R5BZ6K1
         Je0VMNOQnFlM6lkaKnYUGCDg48MNXArkBELIaiI3daENs8MNZOvyRhSlqmchu+PsFuBB
         l617mqdZMyvY4dWkvVjRkdFRrMOmq/dXlT3SPPL54yTI997CXyI/9GR78Y1e2K0V+2II
         HbcRZ5yFeY8jbjF5r26Ixfe3gL1TOkAJb6X82ARUKo8Ou+lei7DZgYtLEZFd8FM+efJK
         db9w==
X-Gm-Message-State: AKS2vOy8YoMXHtlg/zNM3kf2uWS0wyDT4yz2j4i5IMqC3ZftsM5h3wTj
        moxS10khOjVUQg==
X-Received: by 10.99.233.83 with SMTP id q19mr2485142pgj.205.1498328009212;
        Sat, 24 Jun 2017 11:13:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:c3f:f54c:5646:5c2e])
        by smtp.gmail.com with ESMTPSA id 66sm17504427pfm.82.2017.06.24.11.13.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 11:13:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC/PATCH 2/3] wildmatch: add interface for precompiling wildmatch() patterns
References: <20170622213810.14785-1-avarab@gmail.com>
        <20170622213810.14785-3-avarab@gmail.com>
        <xmqqshiq9naq.fsf@gitster.mtv.corp.google.com>
        <87zicx1wig.fsf@gmail.com>
Date:   Sat, 24 Jun 2017 11:13:25 -0700
In-Reply-To: <87zicx1wig.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Sat, 24 Jun 2017 12:59:51 +0200")
Message-ID: <xmqqo9td9rui.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Sat, Jun 24 2017, Junio C. Hamano jotted:
>
>> Is the far-in-the-future vision to make this the other way around?
>> That is, this being scaffolding, wildmatch_match() which is supposed
>> to be precompiled match actually uses wildmatch() as its underlying
>> engine, but when a viable compilation machinery is plugged in, the
>> wildmatch_match() that takes a precompiled pattern will call into
>> the machinery to execute the compiled pattern, and wildmatch() will
>> be reimplemented as "compile, call wildmatch_match() once and
>> discard" sequence?
>
> Exactly there would be no functional difference in the results, only
> fixed overhead.

OK, good!

Thanks.

