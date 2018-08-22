Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3EE1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 18:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeHVV1z (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 17:27:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45210 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeHVV1z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 17:27:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so2326890wrb.12
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=8t0HD094bGLIJu6pJ3cCOFxCpxlV0da6AYANKF1Xb10=;
        b=bOMbDtgyEq7jtQ8Z1RhR29dQJmlgEhmrdDwr0gfJ1rxj/ZvBMsTA6shr3vuHOkAPAs
         F/H2g01Aj1QqKpRAvE+/7lqA8UhZvBPB+AluS65mX5l0cAsfjHVKa6ovfD0g7ik9axO6
         NG2tlO+kuO6yscT4Ec8erLs3RHoG/cM135ZA9Kc4XzIpU9pWLq/54hoVP1BboBQVca/0
         8G8+HWjM0+ZoyDAUunUiZBopN92rBWPK3xYX1RwvixKGbmsYnuxYmkcEFVJCo0HJIzOl
         EOjjv+k116XvgZ79zDX4z//zX1+/8VDYGmjq3p2W8SeJR9JT1ydt3BzsbZJpJY65yomm
         2RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=8t0HD094bGLIJu6pJ3cCOFxCpxlV0da6AYANKF1Xb10=;
        b=Lp99wjD+EdApFPBr4bSyYeTuHODTG8AAPPlbY5qd3mpcaHdeu7IITO8WoPurn/04YQ
         ve3ff7ghE2SCViymBTufcGhbGpq8RXSRcXHn2uYPILYI1Bh1spR8HrJrHmLFq+9V2Cly
         6Z9mTHyCC6ggOnmqLra/DqcodCnLmR+Nu9sgmOcyYkeGcI0MnaK58ixBSjfKlF2iF3wT
         4FVT0OAJ1ARQ6ayv6X+FTZDng/gjGpsH1Lwuwuy4DMVtlwLTLkLWvcR9xjV9bFv94AF4
         MkPNhtkr1q6Qeu1+bHtB3uaB0xMuCORhVM/SSYhaFTYlxx0RtxkqFiSUoG3oEtR1zJ3J
         0dUA==
X-Gm-Message-State: APzg51Ca4o8QF8/XKVX+twbMey17fPSSlzFa8ffeaA4sRxEICnOJ3AUT
        T1umjlGsnGBvxmkONuV0bgXzYUrA
X-Google-Smtp-Source: ANB0VdZMxt8m59fc7XuYF8tru9RfFw/enQTZBI3W1Nr+pM7E/wfk5ViIpZaPevdu5cQ4uLyR0SvPuQ==
X-Received: by 2002:a5d:5344:: with SMTP id t4-v6mr8047722wrv.257.1534960920284;
        Wed, 22 Aug 2018 11:02:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e133-v6sm3062736wma.33.2018.08.22.11.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 11:01:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t6018-rev-list-glob: fix 'empty stdin' test
References: <20180727174811.27360-1-avarab@gmail.com>
        <20180822174820.12909-1-szeder.dev@gmail.com>
Date:   Wed, 22 Aug 2018 11:01:58 -0700
In-Reply-To: <20180822174820.12909-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 22 Aug 2018 19:48:20 +0200")
Message-ID: <xmqqk1oimga1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Prior to d3c6751b18 (tests: make use of the test_must_be_empty
> function, 2018-07-27), in the test 'rev-list should succeed with empty
> output on empty stdin' in 't6018-rev-list-glob' the empty 'expect'
> file served dual purpose: besides specifying the expected output, as
> usual, it also served as empty input for 'git rev-list --stdin'.

Thanks for a correction to a breakage on 'master' that was
introduced during this cycle.
