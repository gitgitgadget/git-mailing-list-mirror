Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A444D1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeA3Vyi (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:54:38 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45702 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbeA3Vyh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:54:37 -0500
Received: by mail-wr0-f195.google.com with SMTP id 16so12804211wry.12
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0kifu/wKxzoUchza3mPNQD6+7u2s7S3dd6tTdehhptc=;
        b=BybVd3e4i/6rrkY/q8tA60AK/P3XTvTNGocNsXDwzbp8rpE2ttNN0QqOZ4dVvjDjMp
         Jm42Ujznj2PiBbBywkMqT/Xpuskvt4Cvf20APwT355wYjJt3jcO5BF8umBnYFHuoqTDC
         V2HxkZISCT6cy6kr2/CBHviOigfnS9wW5kniScRJc46bLTi3FTjxKh23Oc33xGZVgfxE
         TT9VYovbvHPDbT7O/KWz52sKkw29LP96CJzjRAocmi4xwojL3U7FjwIYr68HW7gx4f+G
         CAYrkctRhoIMgzH2uvw5W2RDMhtaE3JGZcFptHopkdcspqCmNoxcwFN2osIXZlFVGrbb
         smvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0kifu/wKxzoUchza3mPNQD6+7u2s7S3dd6tTdehhptc=;
        b=j99f6tbg3WHbuRPCWVEm/4HkRlAsc7oM/3bYSKF3WJd1btExQzg5JMk+lZMy0mh7/T
         4N4sS+ejIVCcBvHm1HUq4TnFYR3wvgVrfGdLPi0iGWYjKH88bpLOQCQKzE1JuB18c18k
         u9psIMmbWw68PB3TsMplBJgJ+GmOxmtCbvxypl5IIveQCPnE4hO0d2gwO56lp5mX9Dxt
         RWXsh6EMCG3hjgluw5pCJmBNftq3QK6IVt0zYA9HWLckvcPIpJKxWuyOXjk0Vdoy7tQI
         rE/44nz5DPEIpWWVwvHDBPDwka8nDVZVSpAWl0RmvkICLzNqa3NkQ6VvKrYlg0O6cyT7
         sSGg==
X-Gm-Message-State: AKwxytf/BCdD5cUxwjHK+MeQbQewERuMSNAdOT6VwomZ5HcO5fse6TKq
        ASDKlFzFGnIgOdXxH541fJE=
X-Google-Smtp-Source: AH8x2260FvncwujYrKYdl5htfkQLrWajKnV6YmT58vCJYnrLNJ4lVot1/17HMu2DsRl22yK3AaF6Yw==
X-Received: by 10.223.190.18 with SMTP id n18mr6264479wrh.102.1517349275944;
        Tue, 30 Jan 2018 13:54:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k125sm30803694wmd.48.2018.01.30.13.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 13:54:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 4/7] utf8: add function to detect a missing UTF-16/32 BOM
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
        <20180129201905.9355-1-tboegi@web.de>
        <xmqq4ln3upiv.fsf@gitster-ct.c.googlers.com>
        <BEE9E5DB-AB1A-4119-90E6-700186739C59@gmail.com>
Date:   Tue, 30 Jan 2018 13:54:34 -0800
In-Reply-To: <BEE9E5DB-AB1A-4119-90E6-700186739C59@gmail.com> (Lars
        Schneider's message of "Tue, 30 Jan 2018 21:58:55 +0100")
Message-ID: <xmqqk1vzrp0l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> "false". Therefore, "is_missing_required_utf_bom()" might be 
> lengthy but should fit.

Thanks, sounds understandable a lot better than the original ;-)
