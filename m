Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CFEC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 21:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbjDZVMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 17:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239436AbjDZVMa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 17:12:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76A6E51
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:12:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso6368485b3a.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682543549; x=1685135549;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WfJD+82y6CVZ+x8XPR8dEsKccj5QVR3prsHbdOU2kc=;
        b=lhACu/NzW2+Yo5cvdWrT5YsJe2aQStn4SV7L1x11kUsndPf0yKatZ0W0aJISPXkHe6
         efBULHAK2grjHtCq4JF8oLpN2Rha2L3+uKI2D36Gej+a7GCKJIh6qj90FB7U4yXhuLbi
         XVK+WZHfGTU2UOOcSRDfrTzXdhmsGB0NLqyLjDlvsPHYxlXgNsn4fMjjHx9PT8hisipx
         V58Bux5WlEtNEuICWFyGT1v+puxA2LRcvX4WrNZ+6hM7PmHT6sookYzubNQoQ3ktK1pY
         xTw4GTOGwaYZ8kq+NOR3x6PYQbKx+yrUPWAYx3KkHgGIZ7RjvdJZyOulW91G8eSmxEAY
         gypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682543549; x=1685135549;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7WfJD+82y6CVZ+x8XPR8dEsKccj5QVR3prsHbdOU2kc=;
        b=JTThHNesIlFxQyFT12PzqSMD/88XPUL0aLU3V5bJsbAEuoy1cRn50xShkm555vR0uh
         byTi0UZFaI+utQ9rRHWIiaiT1DZMVp7MqSx0KJ9JCOm8/L+TwxzAIU31WhXQi9Qc2X4v
         ymgKQ0FdOGXq1lRLkQu3TdKfJZOkb9pPcPaPBkrM7xW6Lvdpg8u9OfAKRVwrYSNhxHBm
         61lv99Ik09kiw2YeqvC29jnRW6aTN8f/Zyaa42m4ZVhgdhmovpaBlXKnCDYU/rSSOvk1
         CRGAZGNPUek5HHq2MYSgZMAaDVHBsJcxKJRnZvM2RcAD1Mt6+Gw62kkr8muPbEbEjr9I
         aQ1w==
X-Gm-Message-State: AAQBX9cKqndCSWrtrvLRnHEwT4eb4MKZvKug/9PkwtTBiOnMm0+EfRfY
        XiXeehzj2EWx61N4hmbOo6f6GNXVKB0=
X-Google-Smtp-Source: AKy350Z/qJ26sSc5rfAiODsHOG6XLzCxrxjPXLkLCC1NNZGbGFJR4I1mtk1UfxzP5jwxTa+QpnCZMw==
X-Received: by 2002:a05:6a00:2d20:b0:634:7ba3:d142 with SMTP id fa32-20020a056a002d2000b006347ba3d142mr32029179pfb.10.1682543549153;
        Wed, 26 Apr 2023 14:12:29 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c14-20020a62f84e000000b0063b6d68f4bcsm11616265pfm.41.2023.04.26.14.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 14:12:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH 0/2] Fix empty SHA-256 clones with v0 and v1
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
        <20230426205324.326501-1-sandals@crustytoothpaste.net>
Date:   Wed, 26 Apr 2023 14:12:28 -0700
In-Reply-To: <20230426205324.326501-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 26 Apr 2023 20:53:22 +0000")
Message-ID: <xmqqsfcmqrer.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The second introduces some backwards compatibility to avoid regressing
> the old behaviour of using GIT_DEFAULT_HASH to initialize the proper
> hash in this case.  We add a flag to see if we explicitly obtained a
> hash algorithm from the remote side, and if not, we honour
> GIT_DEFAULT_HASH, as before.

I am fairly negative on this half of the series.  The first one is
excellent, though.

THanks.
