Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038811F954
	for <e@80x24.org>; Wed, 22 Aug 2018 21:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeHWBQq (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 21:16:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35334 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeHWBQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 21:16:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so3695654wmc.0
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rtvHWTTN/LeZCBNQBu4D8/KW16NR+WS3q+2RDNazYYo=;
        b=f8n6YS5fzca6+GUylqBm5eymK2dFRVXKSUo9f5lyV9PZONv2ndPei9KPvVyqPPnTQN
         dTaSClqnTl50rYJpTTmM3zZpS4CN8D2aiTnH1oBfLvZNy5AI5nRo9rEcuc/4uREZ6t28
         m4kKf9MPEA/KFoTEHFJ/T8mousKb6l6wy5xv/17CpJP62LuUMyobVEsavEpPuUl0JyNM
         R0oImtt8S5msxs5HiiDSSNXso9igJJujTeH599+syGBJhNu7ppPkcOYAYeOFWQpXujH2
         9FbkMWYpqlmnci0yk2wRv3WbCm6hfofQOx2oltL8qwNxQvthrIi7/2BbT+bryupuMHuH
         7H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rtvHWTTN/LeZCBNQBu4D8/KW16NR+WS3q+2RDNazYYo=;
        b=WdS47vtd6drYNqz18PBO25WfQp6ZMsWZRki60HYdx0eI8QF4aOFKWG0ZnPDpNTW+5A
         kZPdZKHEAWVLj8HEiHsEnRg0Cmj4KLpWJVEN/D8baPfchuq028xrBAJ24BvG1bn1MTIO
         xgPP9vLAu1OCwhSM1DrgU/diugR7Qt1MaWAWjg3P6pDELsEtVMgHVvQiw22LLERb3JBX
         qUCTvLiqFpPrrH826ihM4Acg/EbxGR/MReprxFQfzNU3zZDaFZGz8nvkT3Vr9tfGuK/X
         1im8ZKxQHXeg+sdt5B+BFL5WlDiKvgW+qcFwWN7mNdBV15Vz95wQvXM810ol4UGixAjc
         x9/Q==
X-Gm-Message-State: APzg51BQla5ZDvky5bqfrV/tbu5ccz+bNUrDWWNPUincBk7Lz+n7DlB2
        lrqg1JMyqnbu7IIhi7oMa/A=
X-Google-Smtp-Source: ANB0VdY9MXCWjm0OkVRcjYwdTaqipLkRukcBQBjckBVKNdc+xsGvrNO+mH27hf+aXksX3KYmywYMMQ==
X-Received: by 2002:a1c:1004:: with SMTP id 4-v6mr3441170wmq.68.1534974606103;
        Wed, 22 Aug 2018 14:50:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n17-v6sm1963306wmc.13.2018.08.22.14.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 14:50:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] rev-list: make empty --stdin not an error
References: <20180727174811.27360-1-avarab@gmail.com>
        <20180822174820.12909-1-szeder.dev@gmail.com>
        <xmqqefeqme0p.fsf@gitster-ct.c.googlers.com>
        <20180822192308.GB19730@sigill.intra.peff.net>
        <20180822195045.GC19730@sigill.intra.peff.net>
        <xmqqa7pem8ul.fsf@gitster-ct.c.googlers.com>
        <20180822213722.GA25180@sigill.intra.peff.net>
Date:   Wed, 22 Aug 2018 14:50:05 -0700
In-Reply-To: <20180822213722.GA25180@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 22 Aug 2018 17:37:23 -0400")
Message-ID: <xmqqr2iqkr5e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes. I was thinking it had more purpose than this, but it really is just
> a flag to check "did we do this already?". Which is one of the main
> purposes I claimed for the new flag in my commit message. :)

OK.  

The reason I was on the fence was primarily because read_from_stdin
field in the structure observable from outside can be a boolean
(that is, "unsigned :1"), but internally this may want to count up
to two.

Or with "unsigned read_from_stdin:1", would this 

	if (revs->read_from_stdin++)
		die("twice???");

still be usable?  As the value of post-increment would be 1 even
when the resulting field would have wrapped-around already, it
should be OK, but it just felt strange to me.

But that is something we do not have to worry about until somebody
tries to shrink the structure by making these flags into bitfields.

Thanks for an updated patch.
