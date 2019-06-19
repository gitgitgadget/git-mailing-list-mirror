Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2971F462
	for <e@80x24.org>; Wed, 19 Jun 2019 19:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfFSTbl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 15:31:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44824 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfFSTbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 15:31:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so166846pfe.11
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KK9LS1IVvBWQYOVum+VwXvCsttCkz78Z84xEdrRaj2c=;
        b=VHhSRxZTDsU6W4RTi3ynw/gJiwdBZqhsZe9mnH5SZQt0TXuwBJnRavzgLN9iDaDwya
         EJYIfMYNGObwIvi6/l1TCTNU1vaKP+MqRrIfoack3mWc/rZsfLVed46hWlJQ/arxFPhs
         g26fJgVVEzx7s50k3tR7cPJ29SR3Mhc3sksjXz7NFp4L3XEXi+wKo/TPMDpdLMx61XlO
         QL6U8WiYWleh+n2jWdsWkscDzX+NXhXLA2CCkpLZPCYTzqFrtSgLZtsYoOyzeB13jnkv
         KnlKBCQUDSulfGZRSzKC62s8lny82nt3CnMvt1/HR9COMU1Kh6MXxGKHN9cvCmq+7q3H
         v2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KK9LS1IVvBWQYOVum+VwXvCsttCkz78Z84xEdrRaj2c=;
        b=CKzvM1VjcqZzuxqaaOLtyrc3K6ReYNDuQNJj/x6baxllkJqQNWjEHInmse+ljEHSlk
         8EMdp/1wJSvUx1fVZuRhYjKEkit5EqXwVHEjCSyTXCWy8yGc/hSH4DLMvwoet/ngNZg2
         KaHn1dwznvKR7xnHKhngOg8KplEoqov0KL5zatLjPyNXIOHAFIXqHxYPmpyG3axcsEcZ
         ceH+O4Gt8KVajxkB3DjFfPulZJvg9r9jrmU8ntoiFiY56vEnsOJ3hAX+QQXUoTeR98t3
         YHodEECTfvBr5v4QzmoymYvKW+OR74d4kg9mAr8T8az/rl0zhVMa/TtV8CEVyRRu8azx
         lXQQ==
X-Gm-Message-State: APjAAAXyDfytjiMKUL3Sv1JWdewJ6mNrg9gLDOTEM50Xp9aqPxI05ycA
        dLqFZDlRUYzbPByJvsWbQx/FhQ==
X-Google-Smtp-Source: APXvYqxOv+RYlm6BvYQ1UTWAXD6GjctwCAbfuFcyy3x9eX6gHnHwdtEIo/9G3UrxcG30kic/V+toKg==
X-Received: by 2002:a63:df46:: with SMTP id h6mr9016628pgj.181.1560972699484;
        Wed, 19 Jun 2019 12:31:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id d9sm20262617pgj.34.2019.06.19.12.31.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 12:31:38 -0700 (PDT)
Date:   Wed, 19 Jun 2019 12:31:34 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] rev-list: teach --no-object-names to enable piping
Message-ID: <20190619193134.GF100487@google.com>
References: <20190618222917.261701-1-emilyshaffer@google.com>
 <xmqq1rzpsm5t.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rzpsm5t.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 07:08:14AM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Since v3, added a corresponding "--object-names" arg to pair with
> > "--no-object-names", and "last-one-wins" logic. Also added a test to
> > validate this new arg and the logic.
> 
> Thanks for a quick turnaround (unfortunately, I was OOO yesterday
> and I am half-sick today, so please expect slow responses---sorry
> about that).
> 
> > In adding the test, I noticed that I had left in a test about --oid-only
> > that doesn't apply after the changes from v2->v3; that test is removed.
> 
> I noticed in range-diff, too.  So now --object-names can be used
> with --pretty (not that "rev-list --pretty --objects" makes much
> sense in the first place, so no point in testing that it works).

Yeah, it works. It looks weird, but it works pretty much as you'd
expect:

emilyshaffer@podkayne:~/git-second [stray-whitespace]$ tg2 rev-list
--object-names --objects --pretty=short --max-count=1 HEAD | head -n 20
commit 701c66d5f2fafe163892fa0968ce8bca041dbc92
Author: Emily Shaffer <emilyshaffer@google.com>

    rev-list: teach --no-object-names to enable piping

    d4b1d372d16aaff35b221afce017f90542fd9293 
    41d4cd23fd97f599053a19555a173894da71e560 .clang-format
    42cdc4bbfb05934bb9c3ed2fe0e0d45212c32d7a .editorconfig

emilyshaffer@podkayne:~/git-second [stray-whitespace]$ tg2 rev-list
--no-object-names --objects --pretty=short --max-count=1 HEAD | head -n
20
commit 701c66d5f2fafe163892fa0968ce8bca041dbc92
Author: Emily Shaffer <emilyshaffer@google.com>

    rev-list: teach --no-object-names to enable piping

    d4b1d372d16aaff35b221afce017f90542fd9293
    41d4cd23fd97f599053a19555a173894da71e560
    42cdc4bbfb05934bb9c3ed2fe0e0d45212c32d7a

Ah, but when I was grabbing these samples, I noticed that I didn't
update the manpage for rev-list. So please wait while I reroll again...
sorry!

 - Emily
