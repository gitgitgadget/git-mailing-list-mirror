Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74EF71F454
	for <e@80x24.org>; Mon, 11 Nov 2019 14:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKKOKB (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 09:10:01 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:33055 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfKKOKB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 09:10:01 -0500
Received: by mail-wr1-f46.google.com with SMTP id w9so7992788wrr.0
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 06:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ptQDOGGEWwCl50eTFwRV4dGRbS+VsGGYfk1z4leA7wI=;
        b=Fum+FwXSZYGe75QPxq9f9rTwrehq9ybCOcXfhyNsobSyb20izReEJKJmzdogE9iicx
         pyEQmAnq9iAt2FUVJDcOM9qktywhsVTBcYrkYKUsM5sOL16AizrLc0bWuIC63zZ6T8JG
         2SnPRhcyz2J+sTmJESOs9cEBP1cVEEtYr1PNgiIiBXnv7Gw5lTpj1osQ/SRunkwEXoSD
         Crhe4bFJCFuyPiDDIufdlsmsJEM4P8h8VVjj1Q7i/F2R6blUibqhb8W5N8UqADsu2emH
         EW4JSbpIPn0EDR2xzZD5GA2VXfDAozhIm6xqxSoxatW5awW4TMfbPtB4JgbaxEl2AVTy
         W01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptQDOGGEWwCl50eTFwRV4dGRbS+VsGGYfk1z4leA7wI=;
        b=Z2uXqiNKYrAqp1PRmm+5otIrPH9p1Obqu1CfPGmJ143vMcyxv5NJTSphCWTugkKmB+
         GJKBV2OI7LMS3VyMSNRxobKCkttSJy+W9FY7igwH3DqkZJyWfQS10+M5fWn8VeChxFbO
         A/iNZpBz6OBBH0OCa69XputJG6DoevDt/lE2uzeS6dssZFIZzu/PN4fIihUYZ0jCc/lK
         r6wJ2MAs7pCZti+IAwd9wqk8x4/xuIGVdFzWbF08CrwghYwcfkeSgcuwUYuUjDqAoqGJ
         nqjfjanWESbF1y02/4ePm1wvLG6IqkOcg1mHoFlLq2qbeVclfHGPoFN+iW2AC7RU9vYi
         wPLQ==
X-Gm-Message-State: APjAAAWfO9fCIYiuB1r0801NuhlMSY/ZhVKqouwi1B2iRhPbaH2CB2Vm
        Z5g9+T8Z4Jzevwmqxn8RqYjlozOc
X-Google-Smtp-Source: APXvYqzN678ppWdJAz2v4v7Fke1fXFTYlDFAdlPQAVhLo2ShTRNMBb3axzLM8Rj4LDK07zxIs/zgaw==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr20441754wrv.164.1573481399315;
        Mon, 11 Nov 2019 06:09:59 -0800 (PST)
Received: from szeder.dev (x4db606e5.dyn.telefonica.de. [77.182.6.229])
        by smtp.gmail.com with ESMTPSA id g184sm23929137wma.8.2019.11.11.06.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 06:09:58 -0800 (PST)
Date:   Mon, 11 Nov 2019 15:09:56 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Sebastiaan Dammann <triadsebas@gmail.com>, git@vger.kernel.org
Subject: Re: git name-rev looks at refs/notes, refs/svn/map: stack overflow
Message-ID: <20191111140956.GJ4348@szeder.dev>
References: <CAE7Eq9jJzftkP9JWFpstS96SiCd+jO_adSQ-HruyYYNi3gWe7w@mail.gmail.com>
 <20191111042149.GE6379@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191111042149.GE6379@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 10, 2019 at 11:21:49PM -0500, Jeff King wrote:
> On Sat, Nov 09, 2019 at 12:31:31PM +0100, Sebastiaan Dammann wrote:

> All of that's obviously a workaround, though. The real issue is the
> stack exhaustion.
> 
> > I hope to hear your view on this. Is this an (confirmed) issue with
> > git? Are there beside the workaround I mentioned, any other
> > workarounds?
> 
> Yes, this is well known. It's covered in the test suite (unfortunately
> still failing, of course) since 31625b34c0 (t6120: test describe and
> name-rev with deep repos, 2017-09-07).
> 
> There was a proposed fix recently in:
> 
>   https://public-inbox.org/git/20190919214712.7348-1-szeder.dev@gmail.com/
> 
> but it doesn't seem to have been picked up. I'm not sure what the
> current status is.

It's getting along, being polished, clarified and fine-tuned ever so
slowly.

E.g. it turned out that the performance penalty from eliminating the
recursion is basically entirely caused by using a 'commit-list' to
store interesting parents (the overhead of a malloc() on each insert
and a free() on each pop).  Switching to a LIFO 'prio-queue' doesn't
cause any measurable slowdown.

