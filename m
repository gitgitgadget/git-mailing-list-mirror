Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58051F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 18:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbeGLTER (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:04:17 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:32840 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732409AbeGLTEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:04:16 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so11807617ybb.0
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 11:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZtO+Yw3br3Rni30PwwL3aEcxtfiSwrTqtC36owV+UI=;
        b=WISMgn/5cDcTHPptwxvCJcitfzFiyCar7EfsmbRNyn4uL2lFN6xVIBkCqrTRfJR+Jq
         98otYWOYlgGi1aIZubw4YKEWugcOC+BqrFmNy+plE4MBAsujRFJFSSUdh5II9tckVh6L
         KWJ8jFpcgkFlSAPcbOkfzTZoH4uyJrWznUHo9REl9tl4tWTkVOuAJXaYo3WjazG5Rd/V
         XcVEsHkCPJMOTerKpnzDixAUvAmnVtuk/NlC9c1P2p/fu3L6ipU0MkZ6yuggyx4jxnt4
         S4zrTLPhu7pNOMvj6p+z9CqmEiyoMwQQBLj+uS3RRNFjZ4UWSxuGdfODPJ/bpSzeKwTp
         E5jA==
X-Gm-Message-State: AOUpUlFDgsBXKYJI1DcxzfNko71JeT6CCCMR4hCjqnaCBQOmvBCXqsjJ
        ZZ5mOUR/cApyash3Xw+jOfA19FY2vpTgr9rdxh8=
X-Google-Smtp-Source: AAOMgpf5XvIeuQ9SPAvmwPmDINmjBDQZqgBNM1MGvAIQN5r1Sed+l8p/tcjV4aKWrf3CKxjLWvBv+wgwJiB5ekYasyM=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr1785963ybq.295.1531421607742;
 Thu, 12 Jul 2018 11:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180702002405.3042-1-sunshine@sunshineco.com>
 <20180702002405.3042-22-sunshine@sunshineco.com> <20180712123729.17861-1-szeder.dev@gmail.com>
 <CAPig+cRYNo_KL02LN1LOa79Zm2oYZqbnBHJ=KDA3oaF4pVfjcA@mail.gmail.com>
 <xmqqd0vsxq47.fsf@gitster-ct.c.googlers.com> <xmqq8t6gxpxb.fsf@gitster-ct.c.googlers.com>
 <CAPig+cRZmx5_3-a0C=WdWnmcrh4J_1YHY_0FmXZh5LzcDq+6Uw@mail.gmail.com> <xmqqzhywwaoa.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhywwaoa.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Jul 2018 14:53:16 -0400
Message-ID: <CAPig+cTZ7oJ=96LY0TU1HuwuObAb-EJhKDT4KD9yhAM_iGA2EQ@mail.gmail.com>
Subject: Re: [PATCH 21/25] t5000-t5999: fix broken &&-chains
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 2:50 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > The exact reason is that the prerequisite was not met (indeed, I
> > wasn't even aware of that prerequisite), so the commit message can be
> > more direct:
> >
> >     This was missed by the previous clean-ups due to an unmet
> >     CLONE_2GB prerequisite.
> >
> > Thanks for saving a round-trip.
> >
> >> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> There still need a sign-off, so ... ;-)

For whose sign-off are you waiting, SZEDER's or mine? (I presume SZEDER's.)
