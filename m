Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2734208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 17:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbdHaRqr (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 13:46:47 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36802 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdHaRqq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 13:46:46 -0400
Received: by mail-oi0-f53.google.com with SMTP id t75so2796669oie.3
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iv9+n979lqo4Acg3RqNemw5ys5v4a5Ur/B8EWampklE=;
        b=Zc3yuyBGLPF+lHPT2G6SlS5kB7ICu4Ews3ZNHlTOVleExv+IXipDug7Q7CBrhxWfQa
         xjpUswLybqLu/VSqFaTxqgMXDA9r3gkwczLGRR84+D3n/4pYOVVnOrTGp1qD7xY0fp35
         Nlt65jjWmmtLUTO6rpYnQKZ+ywF9fyT03wpo/4e1Z+//oGOoEXDdwlV0f1HIR/GvMHl+
         8eVERPlFYE8r/l3/n+iKsmrGGM2spMWx+sJiOgUFFTl6ZY4fwUTA2mZECa1pD+xJNz8J
         EHkplKLwID3tYC/L3H0uEhQeut1IxDd332+Ml4rIc9bnmKpoPYZYOeru9s+Sb6ne0t/6
         b3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iv9+n979lqo4Acg3RqNemw5ys5v4a5Ur/B8EWampklE=;
        b=DDhhVotSPi3UI1BXugvSI4uJkSVYirXNnHldvdX61DgXCjIHhGrNMT+jpoYyjdXfVg
         c6gXhb+Emzjlq5NR0Is4KQ8YJ73CVbaAma1+9Snz3mMkSjphq28OtQWbonTqzWkCzrYF
         XTreg/ZPmGRCtlEOg7IZLZaIt2IQxSOiKnZI6k56agG2JKuzJ2IVrf5X1XWd7xwdw7gi
         PyyPtTysG8aUUYGQCSJd/+PCTl0nt79KCVPLdEAcWuYDio2sstA5OBh3+K3Fg7WpgvGE
         OCOZjZvQlmNUj33nRp8+zKt9HZJA+5H1SJoT6zSaeuofh/1ZeVA4n5fb+0EOBafesB48
         pRgQ==
X-Gm-Message-State: AHYfb5gQQOzxtG6L1y9JCeHk7Trp7S4G2+Zs0QtiITNxW1/r5xwG5Jth
        RkGGqKs81sdNKYzT7FIBuIIBFLC24jFd
X-Google-Smtp-Source: ADKCNb6m2v5OwyCsvxS/Evnl4t1Cvkoa6urvlmAZQACQNfy1Wc+KolDbhNLObY7GaAX8cAAP+a3OQl+TajPpIOkESCg=
X-Received: by 10.202.77.141 with SMTP id a135mr7211127oib.288.1504201605696;
 Thu, 31 Aug 2017 10:46:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.14.141 with HTTP; Thu, 31 Aug 2017 10:46:45 -0700 (PDT)
In-Reply-To: <20170830175005.20756-11-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de> <20170830175005.20756-11-l.s.r@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 Aug 2017 10:46:45 -0700
Message-ID: <CAGZ79kZLJcO=wH5gE+XCrbk-bGYVjp1G2RGcToX2sHTAywNFOw@mail.gmail.com>
Subject: Re: [PATCH 10/34] diff: release strbuf after use in diff_summary()
To:     Rene Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 10:49 AM, Rene Scharfe <l.s.r@web.de> wrote:
> Signed-off-by: Rene Scharfe <l.s.r@web.de>

This was careless programming in the recent 146fdb0dfe (diff.c:
emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY, 2017-06-29)
I missed the cleanup.

Thanks,
Stefan
