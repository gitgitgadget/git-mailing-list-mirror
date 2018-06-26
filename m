Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC761F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754773AbeFZUGv (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:06:51 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:45430 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752909AbeFZUGv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:06:51 -0400
Received: by mail-yw0-f193.google.com with SMTP id v190-v6so6514859ywa.12
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxuQRzGPiz+1doCXX46C5U0AhvamxjiYh0yyamJllRk=;
        b=ug56T3h0vMVHMEsMS4FtkJwkwiRaUfMdL4zSO3mKdkcEPs01QVybe+qsNO2qGEk3KJ
         eM1jSEzc7cJPgg8KTcZFmPYvAZOjx28ctcPrIhuFhx228AApXqm0g3WVLftJ3xfrcsYE
         s/Slteo3QaJIPfwPXwIdFy7RQUGHBYYCqTPFDfeQ6ybqBJmnNGAWDKC0LCTKepM10luU
         7ARxeJotDXwl4wvdEPaYrweHwKf50qQnDfMSHRznL3BBOnj6ppLS8kHmBfdJAU0TaOBj
         iYwrG9ifhA+eNUtcDzODgpFP8+SVH4bl34FZUnoqONRwZHpZwwBxaLoi6ayEivKYWLv6
         vdrw==
X-Gm-Message-State: APt69E30Ys1eMJYUr1ahWyz/ZYICeHMDjU/OpI82CqMkaESfHfWt7Xnz
        yQ7UxZsczBpBtTyGSCuVWHWtT7hhV/JrWFqRknM=
X-Google-Smtp-Source: AAOMgpdZIysWDwzUvlYJMthxd5DXEQvbwUZ/BiyBLrgcml9Gk+mwnPM7R+tWtHb4XAZOdQCAVPrjp3cvA3oK4z3Nw6A=
X-Received: by 2002:a81:7b42:: with SMTP id w63-v6mr1523609ywc.70.1530043610336;
 Tue, 26 Jun 2018 13:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-15-sunshine@sunshineco.com> <xmqqsh59jqea.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsh59jqea.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Jun 2018 16:06:39 -0400
Message-ID: <CAPig+cSJe+bHK+P6_8Q7u_t65bFhVk9zEyQY7L_yVL7g0J-j3w@mail.gmail.com>
Subject: Re: [PATCH 14/29] t: drop subshell with missing &&-chain in favor of
 simpler construct
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 3:31 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > These tests employ a noisy subshell (with missing &&-chain) to feed
> > input into Git commands:
> >
> >     (echo a; echo b; echo c) | git some-command ...
> >
> > Drop the subshell in favor of a simple 'printf':
> >
> >     printf "%s\n" a b c | git some-command ...
>
> That's called test_write_lines, I think.

Yep, that's better. Thanks.
