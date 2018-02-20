Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A65F1FAE2
	for <e@80x24.org>; Tue, 20 Feb 2018 19:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeBTTzY (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:55:24 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38907 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBTTzX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:55:23 -0500
Received: by mail-wr0-f193.google.com with SMTP id n7so17804420wrn.5
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 11:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ATWSBtSH+wk49t/6HMSUpXvoXqHJ/5rn5nTkUAc5Vh4=;
        b=BrQZPlmzsp3ZJL/QPGwNbpIJIKQpruDr78MyCnAqtKMCdpa+M2/ewypPldPmC6Xxzl
         AZDzoDmYXz7G9OSxG38hEigVNqhqzncN+28NX4cFtp9JoCDIe2Sw8ng8wBcXoIAfCGcL
         rTkAKgEar2EK8Tu8S3D0MRUgLG/pay6gxh7Ad+0HziaCSZQ5y/a3YNBBFBllSi2tfQ9S
         iYUEa1lKZMc3323Co9MOufv0SXasrk9o0b8rtzybsJ4ivHJQ69lLmSl/fKiIw6ODY3Gp
         8qkMFTIYctsmslmgzYQldtigHeeHB5J4jXWWEOyCgrH1TCUdo6aVBe+K+NJ/6a8BiR8h
         54vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ATWSBtSH+wk49t/6HMSUpXvoXqHJ/5rn5nTkUAc5Vh4=;
        b=eeN13jPf2C/uBK2A4flMaKzbu+8nenUJejSH3S7mnmDk72VewcJFy0IP7inMK6nSgh
         GUqNAns8B8iM0fPZLLXHNXAB4DT60P8gQqtveFvW7hnB9n6n5eQGaVwXOIYb2jmUu7jn
         K/3qZmtRsrsp2+mV0AVPdTIq5llgZFnPrrqEi6dEqMAMqwlnijGIVsj/SekQyWhuaoUO
         FLMnYuVIzEly7qQKbmfD0k9YGSMPIvze+MyQSpxEmLjva4caXAZisz+GupNRunBZ64eE
         1vOK8+kHHTz6rU1UDtS+nPmTnMoARS3a0l82W84ubN/ugueQ1UyLcAVeTZNI/NJFOnCR
         czBA==
X-Gm-Message-State: APf1xPCl8AiCkdupri8z0f5ITeylxymXQ5O6gkufCVBi2Ip8s6rFY86w
        giWReglrYSTbF2/PoDP3n4IbTPpO
X-Google-Smtp-Source: AH8x224reYmVbhm2ZjR2CISANIL1ZbaA/dW6gAEDhk9s73zGsSJPdULUMQ5j/11J3iEnV3SnxMuULQ==
X-Received: by 10.28.131.66 with SMTP id f63mr133344wmd.12.1519156521894;
        Tue, 20 Feb 2018 11:55:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q14sm7931574wre.83.2018.02.20.11.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 11:55:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 00/16] Moving global state into the repository object (part 1)
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
        <20180216174626.24677-1-sbeller@google.com>
        <20180216223404.GD216564@aiede.svl.corp.google.com>
        <xmqq371v4h6u.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kaUYYqtaJ-S6WaQ9NmXDnf6_wY_fRCSxLR8=Do1qSLMug@mail.gmail.com>
Date:   Tue, 20 Feb 2018 11:55:20 -0800
In-Reply-To: <CAGZ79kaUYYqtaJ-S6WaQ9NmXDnf6_wY_fRCSxLR8=Do1qSLMug@mail.gmail.com>
        (Stefan Beller's message of "Tue, 20 Feb 2018 11:06:25 -0800")
Message-ID: <xmqqk1v7307r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The step to take an object store would just add expressiveness
> to the code, which may help in understanding what part of the code is
> related to what other part of the code, so it may be a readability gain
> on its own?

It certainly would allow you to have a standalone object store that
is not associated with *any* repository, but if we are not using
such a layout, I doubt it would be a readability gain to add excess
and unexercised expressiveness to the code.

