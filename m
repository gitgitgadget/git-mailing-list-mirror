Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529F91F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeBWW2l (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:28:41 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46685 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbeBWW2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 17:28:38 -0500
Received: by mail-wr0-f194.google.com with SMTP id 34so15555489wre.13
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 14:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OrJPVW/dwXe0Swu7ezxJ88lUKpzhtHvQaXzjcCUkfU8=;
        b=W5poAf5vRmdQ6+G3iGCXFMq+jfuuyS0xaaGQ66N9sOWnH0rn6GHsWrJpB/qswXZ5P3
         coI7cmmPOtuophaFe7mSMQf87tmyuALhSa0EAvGye6PlXJBTZK/CaGu5SsgXcHSNYuzc
         axdqzozP9xsdThamwS92gHJIIgh26kGxHkpaL1gT/zaWTCt8a51V9ZKrGJQKuZpZoTK+
         vg+LQGhZHdFN1hS02Wf6BoVYbwrw3HtSAl0aNjtaQURWWw5Hf+hJqvMjrfHhQi5IJ/58
         F+cf2SjP/TA1rubl8s0lV/3Ynd4X2l8IQnGTag7QZU2ps09v5X7GOBZ4yFf4moY6BKc7
         OFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OrJPVW/dwXe0Swu7ezxJ88lUKpzhtHvQaXzjcCUkfU8=;
        b=Baa8S93vJtyRHenV7PEfnVpntBzECS7mgVr7eGyZY8UZ3XIWv5r5e1KCNLTyYfhiJg
         XC5u9CRt+M5b80enzOtUODMBuQg+ILzKrWI0i2DY869usklCIvrAi2DXbzDnhmofm0ey
         ZpgKQzP07/V2aQvM7Df57tg84ASczoiDqV2cNFtIpYAEgfZF62RRJ7EapNspiCEt3NZd
         c2SNW2+kBiQXlip/0uyqZBFzSdAZr15Uhz5jLxBvSGGvSNhFE7uFP84ppTn1W1/mV2CO
         evo3DWigHoWUr2i3vNv79FPAVsHf70kt94/InHWEKvU1BMRzY4XecdcDaLz21H9w2w69
         xZRw==
X-Gm-Message-State: APf1xPCdOM7eQw4R7co9RgXqnslj4yhdsgfKJqnsZN8bq25mLWW+X+Hu
        2ZG8JCkBAP8z0TY+o4GqMl4=
X-Google-Smtp-Source: AG47ELtmR/RcOamlUJqLaGf1WMDUCnIHBUyVk+xf6MbzcxzwlWC1fna2ivwyfH92fVPmtT9I9mxbvg==
X-Received: by 10.223.171.6 with SMTP id q6mr207449wrc.267.1519424916694;
        Fri, 23 Feb 2018 14:28:36 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y64sm6829634wrb.56.2018.02.23.14.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 14:28:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Cc:     git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Ryuichi Kokubo <ryu1kkb@gmail.com>
Subject: Re: [PATCH] Call timegm and timelocal with 4-digit year
References: <20180223172045.32090-1-bwiedemann@suse.de>
Date:   Fri, 23 Feb 2018 14:28:35 -0800
In-Reply-To: <20180223172045.32090-1-bwiedemann@suse.de> (Bernhard
        M. Wiedemann's message of "Fri, 23 Feb 2018 18:20:45 +0100")
Message-ID: <xmqqbmgfs5m4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Bernhard M. Wiedemann" <bwiedemann@suse.de> writes:

> amazingly timegm(gmtime(0)) is only 0 before 2020
> because perl's timegm deviates from GNU timegm(3) in how it handles years.
>
> man Time::Local says
>
>  Whenever possible, use an absolute four digit year instead.
>
> with a detailed explanation about ambiguity of 2-digit years above that.

That's amusing.  Will queue; thanks.
