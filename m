Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E565D1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 18:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeGISYh (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 14:24:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35227 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932797AbeGISYh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 14:24:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id v3-v6so18133067wmh.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RpureiZKCUTgVnpTzbn3xd8gWsla3HKPAuyRt1pAOcQ=;
        b=hvaR3D5earrrpRQbMqAsP6nyBGJOAmB9UphzkCxipAcvhoH9uMl56x2Q3R/7UXbREf
         GFx2T+Tz1BCU3gFggvcJqR2/CNjTfGx9ZsmetqigW6tdBzIlp7SwRqIIRTQhVAdUfUaE
         U/B27ywnfXK4cLW8LoQXUmfmC1Xrb7IL8Y0rqzI3WywJNhhfNza+ZBY4nHEZLN2zYPYm
         kQccVe79yzz38vMbvxekUKY8GEGauD4qA/UwGZ+yxR4VjpOxohjPKYRJBvsc8oWtP3el
         wITFX+9HlZbAWszldUFvR6J90SafDWuxTBycRE9wgI40mmBP2IUdzfYoZcIOAsSCBznE
         mArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RpureiZKCUTgVnpTzbn3xd8gWsla3HKPAuyRt1pAOcQ=;
        b=HSAk6hGSFgDgcHK2lYPxiy40RzcfvCwZdURQdgMsPNi5YPZGN9+lfP5f+ScPwK1Mae
         9q2ZPyc/PAbKiguAlqI/HTp3EB6Ah3EMxEaR478+5qVCzZZrAgVVERccrrm13t+z3Y9x
         BMPA5/yYYB6LsI43XFevH59L4B7nUC3I0cOoqBs9ady1MELoZ5FbzGPSGA36/PU5bNyn
         NMQtzyab47K5gKrA/6D+NV7Zn1IbnUXr6KVha3PLIAEBLqzqRml2DSdd0BGs18V9TiOp
         1bh/MLms4pQ0QAZDAsj5lEGBu4AMOSqVvvZ9OmbMBZenWMBWM3HZIkgupl0Io2u8GVW4
         zctw==
X-Gm-Message-State: APt69E1TY4Y8xQDTtON+4ZclHmHbyL5IkFunL2drlIUUyKQF29T+AB0Q
        iTMAUfIHkSbLr4U4p/WXhvW9SjLp
X-Google-Smtp-Source: AAOMgpcFqLtna0FbON0onGLbPHRuEZ2fQfo13bI5loR7AWb9R6fHMOAvqFJcfp9aLIM/kKRxiyct8A==
X-Received: by 2002:a1c:d942:: with SMTP id q63-v6mr8288280wmg.78.1531160675715;
        Mon, 09 Jul 2018 11:24:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 64-v6sm6611500wrj.50.2018.07.09.11.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 11:24:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
References: <cover.1528233146.git.jonathantanmy@google.com>
        <cover.1528234587.git.jonathantanmy@google.com>
        <c6910161aab1f383b5721bdc91969baad8c10a66.1528234587.git.jonathantanmy@google.com>
        <20180709173813.GA14196@aiede.svl.corp.google.com>
        <20180709175939.GC81741@google.com>
Date:   Mon, 09 Jul 2018 11:24:34 -0700
In-Reply-To: <20180709175939.GC81741@google.com> (Brandon Williams's message
        of "Mon, 9 Jul 2018 10:59:39 -0700")
Message-ID: <xmqq8t6ke07x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> I agree with this observation, though I'm a bit sad about it.  I think
> that having tag auto-following the default is a little confusing (and
> hurts perf[1] when using proto v2) but since thats the way its always been
> we'll have to live with it for now.  I think exploring changing the
> defaults might be a good thing to do in the future.  But for now we've
> had enough people comment on this lacking functionality that we should
> fix it.
>
> [1] Thankfully it doesn't completely undo what protocol v2 did, as we
> still are able to eliminate refs/changes or refs/pull or other various
> refs which significantly add to the number of refs advertised during
> fetch.

I thought JTan's <20180618231642.174650-1-jonathantanmy@google.com>
showed us a way forward to reduce the overhead even further without
having to be sad ;-).  Am I mistaken?



