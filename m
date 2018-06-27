Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 206521F516
	for <e@80x24.org>; Wed, 27 Jun 2018 16:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934302AbeF0Q0G (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 12:26:06 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35162 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbeF0Q0F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 12:26:05 -0400
Received: by mail-wm0-f43.google.com with SMTP id z137-v6so6181491wmc.0
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0pp/tluiRS7k6QXq4g2YxPFun/JyM93DUOQq9pN3NSA=;
        b=bqZ1geOWFxjHqQ+07Vqfywjc+Tiktp/IILoEFAkj6zIpQzTLKu8GYuYhG6KCjpnFWJ
         tYeCk/rRAyCuyFCF+JclE5U3JbnaPyUjkKPT/mN3c9OwsBgWUv9A8OC+5vTfAeEJq6y8
         ekySZTFuzCGMyjd8qb2p4EYdUF5OM7JN7/sO3IqaNd/sNvCFBcuNQ+jEz7XixKMet2Ly
         YA7NdIxpnFSecGKUwDedGLxdf/q5YKRRAXg54kiMBlblu+sQh/SpNUT3xnKLKsZtUVWV
         MIZIAcRLLbFR65rrylSlj08XmkqQ+aDDQKq5VW1Ahuz3ulxPoGGzTGwhOTtG37PfnoSO
         z5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0pp/tluiRS7k6QXq4g2YxPFun/JyM93DUOQq9pN3NSA=;
        b=LeDzsm9FUz4CVJ91sLtw+BhibRf5PlizM1soEYjr5dusasPlqmKPIvxMGPqAxImhHH
         oDUZT+NPhlCq7kHEmp+q0wzSpzjOdt6P+kyn7S7KhS1FPNtcZggYpjs1Xuf/kN8YGuTS
         SaVmgp/Kjze/mdrQ5HsyKh1xo4qwDcfkkOK9//8C9eQ4xtlZ9WMw0AgdF9dUYKfeLcV4
         x0J6AGHeaHbS3GnWGsrwT6nBQr64n+Ox7HpwhmpQLq7CCwq2zxU5narHuKETKkVEmvbc
         MSybus5x2Vaz7GxCAv6uKQuYTZg7XkW1ye3/0UTV9DpfBR50gKVYytHTEKZSQ/CbrFCB
         8w+w==
X-Gm-Message-State: APt69E3cA10qZcEJO2aHadAeuOnh+kBAGnF20yDDx2UeiQk8FcO60+SN
        lrEfTCUF3rEEYKwgJpzBjO0=
X-Google-Smtp-Source: AAOMgpe4dEwBPkildDi0LB5Zca07PcruPzC1SXjjqXgv6IX9zYrhNUdhD1jVL2w6wgFqmFETBO3ELw==
X-Received: by 2002:a1c:3710:: with SMTP id e16-v6mr5614204wma.58.1530116763905;
        Wed, 27 Jun 2018 09:26:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m10-v6sm3134854wrj.35.2018.06.27.09.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 09:26:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Tiago Botelho <tiagonbotelho@gmail.com>,
        git <git@vger.kernel.org>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list --bisect
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com>
        <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
        <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com>
        <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1806271254210.21419@tvgsbejvaqbjf.bet>
Date:   Wed, 27 Jun 2018 09:26:02 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1806271254210.21419@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 27 Jun 2018 13:48:43 +0200
        (DST)")
Message-ID: <xmqqwoukgpr9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	git rev-list --bisect-all --first-parent F..E >revs &&
> 	# only E, e1..e8 should be listed, nothing else
> 	test_line_count = 9 revs &&
> 	for rev in E e1 e2 e3 e4 e5 e6 e7 e8
> 	do
> 		grep "^$(git rev-parse $rev) " revs || return
> 	done
>
> I am faster by... a lot. Like, seconds instead of minutes.

I'm fine either way.  I just thought you would not want 9 separate
invocations of grep ;-)
