Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B34B20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 05:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeLMFrl (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 00:47:41 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40388 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMFrl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 00:47:41 -0500
Received: by mail-wm1-f42.google.com with SMTP id q26so1025329wmf.5
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 21:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HSQDmH52V3/bil+j5797iGW84hTV9StCQ8s3riz1sug=;
        b=gYrJ+paqej5DTXitIEGKe8oQrKS/2gFDtqGjwz2YcbNaONWJByq2UIrTdLi7xN5FbD
         oZwqno3soV9ldfNTGZz6DK/ycMoFMoJsHB4WyvE0VXFL53k3/NKp9h7vCC/bhvmzt8E8
         ClxrwDMV4FhT5VcwFX58Qz7ZaWJSVrWUoCNjP1WTnGVIUF4G3sXGcag5uSIzT6iAp+7S
         uIZ978lWhD6prcFpxnkTJeY99JhmEr7N4OER0wkgeXNYSnWN7Y64t2pWXrCkiBdvNqsw
         oIc0c8mvEA6t5i/s6NMxxMsYrHE24SfxVHUfZeXDLvTXVFOh3HkB6HS4KJn9NFQd2MFT
         CCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HSQDmH52V3/bil+j5797iGW84hTV9StCQ8s3riz1sug=;
        b=XiviuI5QnKq1eNBFjGRKdVGnLnwmaaXsz4nMOJO9ci5u6K8g6g4UxBNbRBIwq9BeYR
         Y3Y5jX4M3VrJVASYXYztzYbiP+Znp5PQa4Jq8WXTafzhvWVJYcliV7AfbMq9JxYiJuXo
         rlCZdnnXU7dECI0cDLlijr1k+6M14lHNXEhTCAX0VGeZIvaeVhvtjjpzviXIfPYZi9Mg
         13WSgmhfpqZO5eQXLiJ+mIXHYeBCwW6ZUHe6o997aMvbrjMfqrtvydfMluFXz1P9MRzq
         2cbS/WWZfxGrLJi2KUYK4aWnJuMaqzkhCNX4lUxwc25bB2JayVnCva3ub7WqPPaIbqdT
         rKGw==
X-Gm-Message-State: AA+aEWbKwxz7ZMnagU3DuGFuSUXuSp3MCXsakuoxbLClncTePMbaet4+
        /qhbYLIejojgQp/4Z1gNo2s=
X-Google-Smtp-Source: AFSGD/WOskIJ0fogLxsqCFblFg3P0HYmLHwtlzcpPHQgGNWyuaCRw7y1yts74KK6zKz1M2SqsnYnXw==
X-Received: by 2002:a1c:c343:: with SMTP id t64mr9196765wmf.88.1544680058871;
        Wed, 12 Dec 2018 21:47:38 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j129sm847110wmb.39.2018.12.12.21.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 21:47:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>, kernel-team@fb.com,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCHSET] git-reverse-trailer-xrefs: Reverse map cherry-picks and other cross-references
References: <20181211234909.2855638-1-tj@kernel.org>
        <xmqqo99rjjcu.fsf@gitster-ct.c.googlers.com>
        <20181212145456.GQ2509588@devbig004.ftw2.facebook.com>
        <xmqqefamgmey.fsf@gitster-ct.c.googlers.com>
        <20181213034041.GR2509588@devbig004.ftw2.facebook.com>
Date:   Thu, 13 Dec 2018 14:47:36 +0900
In-Reply-To: <20181213034041.GR2509588@devbig004.ftw2.facebook.com> (Tejun
        Heo's message of "Wed, 12 Dec 2018 19:40:41 -0800")
Message-ID: <xmqqftv2f05j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> Hmmm... I see.  I still have a bit of trouble seeing why doing it that
> way is better tho.  Wouldn't new-object-hook be simpler?  They'll
> achieve about the same thing but one would need to keep the states in
> two places.

The new-object-hook thing will not have keep the states.  Whenever
Git realizes that it created a new object, it must call that hook,
and at that point in time, without keeping any state, it knows which
objects are what it has just created.  So "in two places" is not a
problem at all.  There is only one place (i.e. the place the sweeper
would record what it just did to communicate with its future
invocation).

A new-object-hook that will always be called any time a new object
enters the picture would be a nightmare to maintain up-to-date.  One
missed codepath and your coverage will have holes.  Having a back-up
mechanism to sweep for new objects will give you a better chance of
staying correct as the system evolves, I'd think.

