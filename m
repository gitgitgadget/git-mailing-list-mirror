Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369951F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbeHMWUK (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:20:10 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44656 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbeHMWUK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:20:10 -0400
Received: by mail-yw1-f67.google.com with SMTP id l9-v6so14446386ywc.11
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJ+XnyI0tU7kHLE6av/dHkKlkjI5L9PnBUonZendcWo=;
        b=pZcBeO8n5jAYiT9/DPFQYnyGLdb7W6IbeJJsZtOYd7X664e0Vl0ZP5jPd3QJJf09Xv
         MnuBtueBSy0YCF9LdJ9rXAJwhNZKjtuMNYzo7ppIVK/f0iaI5FhXt314btqni/n8v7Dh
         r2oCPZV1Zk4MTObntZ/kZrqhbIE5JtvENjuRSy4tn4F02AAtgPQsTh34bXjgzj8Ubd4z
         +6kDn+OJA/LGvXp7KDolGoNzH/eKFrMJKFrIxyR6JeTXZtaE0K+pA9SnvG3DIEbRQ1Un
         GH2ReisPch1EQ1sHgrPgV+l5H2A0D0wj+PRnVFQBRckqSdqK0kMNdb+UU3MghIIHdZSf
         jCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJ+XnyI0tU7kHLE6av/dHkKlkjI5L9PnBUonZendcWo=;
        b=NvPkPG7Jjh1iyPpIYHZy7nBDLZTTLAYjvWfE22tnUkLt/Sk8C444isG2RuIOKiPnCu
         g5Su/wBuOCejF/cecZU7YAP9XeHI5qjKgIY5+M7Nhm2aYK1+gx1aI5+RK5ATO+ZBH1KK
         iWnCBdvktHzJ1GciwEJ0ur3b6j0GYrk6pGGehxzUPjUTuAzyeufpJ3umOB/GikZspC2v
         Ol/8Sc4d5iWs2/ODtmwJW5WxGWG8cdQcPcahTFXVlADjKo1Nps77FvDEcnot9Olf7MRI
         nIm7bOXgeOl2I3HtpxhMa1mn+fLn//R/SXeWPUO2o1bKW/KSF4bR+7NPYdOylYbpcRxC
         jeyA==
X-Gm-Message-State: AOUpUlHAjWTxVF4+PzLIHQlSF0ig9PQCFVJX/xKptgsFYh+E6qWGlTO3
        dlgiJxNusVSwm4BHWTFYAPSFIjMDkgBvt5TLmUiw5Q==
X-Google-Smtp-Source: AA+uWPy2OA0YnrYte5xuH5SjpxZ6153990TC3dPvQYvb6U+KXKMdi38fUAHbwqKPbl8UKZXqviZZNid3ZUPX4eBX9WI=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr10807225ybm.307.1534188992802;
 Mon, 13 Aug 2018 12:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180804053723.4695-1-pclouds@gmail.com> <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com> <20180813192526.GC10013@sigill.intra.peff.net>
In-Reply-To: <20180813192526.GC10013@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Aug 2018 12:36:21 -0700
Message-ID: <CAGZ79kYLpCZ=JNO7eun3mrhui+rymzr3i-VMLyFvKCxOaFNe-A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 12:25 PM Jeff King <peff@peff.net> wrote:

> I can buy the argument that it's nice to have some form of profiling
> that works everywhere, even if it's lowest-common-denominator. I just
> wonder if we could be investing effort into tooling around existing
> solutions that will end up more powerful and flexible in the long run.

The issue AFAICT is that running perf is done by $YOU, the specialist,
whereas the performance framework put into place here can be
"turned on for the whole fleet" and the ability to collect data from
non-specialists is there. (Note: At GitHub you do the serving side,
whereas Google, MS also control the shipped binary on the client
side; asking a random engineer to run perf on their Git thing only
helps their special case and is unstructured; what helps is colorful
dashboards aggregating all the results from all the people).

So it really is "works everywhere," but not as you envisioned
(cross platform vs more machines) ;-)
