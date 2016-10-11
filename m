Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A081F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753514AbcJKV0M (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:26:12 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32861 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbcJKV0J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:26:09 -0400
Received: by mail-qk0-f171.google.com with SMTP id n189so8465730qke.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uMNN0P/nxrKw2XWc3vdFMzGirud/8d0Rl813zoIPjo4=;
        b=ejvc+BE9VFZaxKNBixYTwoNLkMZ2bJJzjeOZJeJf6MRxO3VN3FkgNRBosGdLWHSMEc
         43tiBjTlXeVGeWaLmno1fn3gXDaGqD6Ux8TZTJBoaLxwbEwi19ijdKCYA+CaFbg2Zzxv
         h1HdmNjuMhw8opXW0V9MvAof17EV8M9Nv7YmfTSZ18CDLgEcj3vqSJqEwuKC6MBnUt0q
         X0zVta90g2BQ0pYwvSWjgx52P10dDhNq6xGtBqEeBHTvpLHKr6jiIO7Ny2CRroO6v1QL
         pXj/ZgvarRGwqv8yhpJncfG7ZR4cjLhSjJnBm/UdTaAfV2iKuZ9JpTrZdjJQT9lNBvR5
         8l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uMNN0P/nxrKw2XWc3vdFMzGirud/8d0Rl813zoIPjo4=;
        b=Wq51KK329KAyczwYLQHS4usnTlbURx/UCPYzGMhaTGt+caOQmS6l7a/w8Yw7/xBCW7
         Mhc4ry6JlEFImM8uOa+xhgh8SnKLya19REA5+g71RXBRm5v3TnUC6xduuGcxxndL3ePX
         RK/tDtT6x4iR6wFyX2EQa2Dtu7phiFgB1zqVQNT/E7ThMIBMRWu9/llu+bkjfydmmA6D
         YyLZy70ydkPun3raSIq8ZPT5VgvMde/TB3NmCQvh5c6C1+MOGJB3TJ6hcwrtiWj/R0oR
         R2981telHh4ePoJfollo6vsZezua/ho3wpDH4FZDZ955an9+j7FGQ1LD+pVCddv0JMlD
         +kjA==
X-Gm-Message-State: AA6/9RkcVImA7N3TY4kh+gyxqJf7DgcYgwxQhM5oZ0Zg2pRftRIlpJxp8bumKVMscTNzu051RyV7BFYlB8L7Zd/s
X-Received: by 10.55.45.193 with SMTP id t184mr5004124qkh.58.1476221119875;
 Tue, 11 Oct 2016 14:25:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 14:25:19 -0700 (PDT)
In-Reply-To: <20161011190745.w2asu6eoromkrccu@droplet>
References: <20161011190745.w2asu6eoromkrccu@droplet>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 14:25:19 -0700
Message-ID: <CAGZ79kZSQx7aOCgQ2dwzJeCLX-k-+x1SKabEBG7CktNfeXAbvg@mail.gmail.com>
Subject: Re: interactive rebase should better highlight the not-applying commit
To:     Joshua N Pritikin <jpritikin@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 12:07 PM, Joshua N Pritikin <jpritikin@pobox.com> wrote:
> As of GIT 2.8.1, if you do an interactive rebase and get some conflict
> in the stack of patches then the commit with the conflict is buried in
> 4-5 lines of output. It is visually difficult to immediately pick out
> which commit did not apply cleanly. I suggest highlighting the 1 line
> commit summary in red or green or some color to help it stand out from
> all the other output.
>
> I decided to suggest this change after I realized that I probably
> skipped a commit during an interactive rebase instead of resolving the
> conflict. I knew I had to skip some commit so I assumed that I just need
> to skip without reading the commit summary carefully. Now it is 7-15
> days after I did the erroneous rebase. I had to spend a few hours today
> with GIT's archaeology tools to find the lost code.
>

Looking at the actual code, this is not as easy as one might assume,
because rebase is written in shell. (One of the last remaining large commands
in shell), and there is no color support in the die(..) function.

However IIUC currently rebase is completely rewritten/ported to C where it is
easier to add color support as we do have some color support in there already.
