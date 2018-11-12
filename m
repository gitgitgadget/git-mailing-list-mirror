Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415B61F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 18:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeKMERg (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 23:17:36 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38641 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeKMERg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 23:17:36 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2-v6so8186874edi.5
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gU94avoTKzV0+hkVMepm1vJS3UIdBlP3QUQXOiJmV0M=;
        b=Ols/tYDZeFiUr5IcZRtsaVCjE9fzBgqoa0yHZTPLIPOuWR3/L+eDgB6miWxOjaUmMg
         8RcBStCSdt4s8/XkjuokCOq79XUv9si1pRZzltnGZxnX9rVpbR0MYAV9ftBBC9HJ1hwQ
         rkZtoOHbkYUY8/aHcoUIwBXvA/Pbvbn29Txd3Q30oruv00kkYpvVXyrdGCCpllsepfL7
         aV8ml2QDf/7+WucPLSmOVumdkNIsYz5jI2ubfnkP5IpdnCneQcvgA/6/VDZAmyRLxD1v
         7B4z+ebcOvbVDH6liKgc34+nurpWz6xVR2Mf4ohL1wLG809Sm04VOw+jjszGkK/cJylK
         iznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gU94avoTKzV0+hkVMepm1vJS3UIdBlP3QUQXOiJmV0M=;
        b=KE6aic609MyAsjG/cmSYB27uP/Lo1jW8k7ytUeFS22yaFBndnwAmEUXctMcGmX18fl
         JvVKBh2K2HdxlQNGsRTsZVKWInzvq0aHwiQo0tiL03IEwqp8zdUCswrxdkvPyOQyBgn5
         fzsc9kf3AvaxfYVgtr0aPbxlB29ViDoZyPtOioTZWBWyMz0mJ98Lyh7cq6GMVJOmjB5F
         FNgY45KeAViCn18ZY9JptksJSX38Rbyjolvb9Omf0SR4wfpydtHh/6eDTcfD1A0zCsFV
         /EYqOy8bE7HVru7AvV9G6UxxqEOjL3TKowb37oiUHfW+gIOtp3F5+8sDbD6mz6vrE+Z+
         V0Lg==
X-Gm-Message-State: AGRZ1gIqfBAFSXxx7MbcC5suoJ1pYZdRO7UhHoN9GMesftU6G9QFeRCy
        aB7j7uVFHU9aJz2BZF4H0FLoVkrwg0fr6WOAx2gaEA==
X-Google-Smtp-Source: AJdET5d5OuiAAB+ExUYrwic7rAtLFUCMEQlbXg4aUIUE9vnHfUzgPILLkLSr8e2N+DqSFBItAC/WWEyMnB5oaAQ8ZTo=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr13603867edh.154.1542046991615;
 Mon, 12 Nov 2018 10:23:11 -0800 (PST)
MIME-Version: 1.0
References: <20181112144627.GA2478@sigill.intra.peff.net> <20181112144703.GB7400@sigill.intra.peff.net>
In-Reply-To: <20181112144703.GB7400@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Nov 2018 10:23:00 -0800
Message-ID: <CAGZ79kb7MtM8iQ1b-t-NGOa_s7v1ZoaM4xHcHQZ0dyMrNWdw0A@mail.gmail.com>
Subject: Re: [PATCH 2/9] submodule--helper: prefer strip_suffix() to ends_with()
To:     Jeff King <peff@peff.net>
Cc:     gerardu@amazon.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, tikuta@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 6:47 AM Jeff King <peff@peff.net> wrote:
>
> Using strip_suffix() lets us avoid repeating ourselves. It also makes
> the handling of "/" a bit less subtle (we strip one less character than
> we matched in order to leave it in place, but we can just as easily
> include the "/" when we add more path components).
>
> Signed-off-by: Jeff King <peff@peff.net>

This makes sense. Thanks!

(This patch caught my attention as it's a submodule thing,
but now looking at the rest of the series)
