Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132C920248
	for <e@80x24.org>; Wed, 20 Mar 2019 00:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCTAlU (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 20:41:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36475 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCTAlU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 20:41:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so839749wrd.3
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 17:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Rojx8XvUmKQQCXKWCFwjG57V8R2DOCA+O6D7zvsp2NQ=;
        b=Vg3lBg1cs7GspJN6P+rXC2QnXyG2fkuNOrn128XAe7A+JUc+0eXI7yr3VLZfPS94ZN
         jf+X7+FUfBxwR+1xhgVXfGcA6y4hIqzLqbbhHyP5+6CN0zzFPehlwhGVv2CLhy9tOLuG
         Ja3u4k6jI29WDfUy+I2rDVgbqQgB+71ZY5kAl8ZLeI2YaWd+UW/p+vlV1+mOWc7X18f3
         m72sLTPK3XxahjraRiK83EcS5dWnfMvr7Cykk0Mba9Ev4XRPuvOeaK2Pqt8lgmtFPu9v
         uZo7FpcexRxAFxVRSd8h4uyp/EItJDxTKJKQM/A0T0qIpnm90HNagodr0Ji9Adf9kumY
         4crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Rojx8XvUmKQQCXKWCFwjG57V8R2DOCA+O6D7zvsp2NQ=;
        b=eX4vMFTMsGWZgShiltLF5K5IRQa+bsBvQ8Ky2d3Cl0AoMYAKr5+bXwXGQsaP7658XR
         auBwQCizNRklJ40wqX5+wrai71ADqMjiOE/lUEsTA1hFfdbdgpMaKy7T1lPhXCOm4/Ox
         ElX1HoF9Da7qMKBRtnnRQnwjdYonaMqpjFqj4yFCRlSH+4VHMzrtR4ofvvBAqv8aAo1/
         uUZqrCKKvO7nRIUXuo3+vrkE6l84rrcBPsiM83qv23LSCwrESx4iKQn+39hagi0LedNn
         p9X4/xIS9LJ8oCXfoxKzZsmibjUEqKCs5MGgVH7RoByib7kGbFaxnjGqVc3u4AbgeYu/
         PUsw==
X-Gm-Message-State: APjAAAWdz2kAiRWSbUGflaugX69IHcl7K2oaaMJ107eot1a7T0QVTRgi
        K6yuV7rSLEBou72Toq7lUpc=
X-Google-Smtp-Source: APXvYqy1WCcjBY6T9Kukoq1sk1Shlvr5Hdq+S1IW2qKEdww7ofLEDodV5uVSNuPp36mqXEwd5Fw9JA==
X-Received: by 2002:adf:e9c1:: with SMTP id l1mr9120582wrn.270.1553042478647;
        Tue, 19 Mar 2019 17:41:18 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v6sm922850wme.24.2019.03.19.17.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 17:41:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, martin.agren@gmail.com, newren@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2] unpack-trees: fix oneway_merge accidentally carry over stage index
References: <20190317060023.3651-1-pclouds@gmail.com>
        <20190318113822.6195-1-pclouds@gmail.com>
        <228d681e-4cfd-7e2e-8bb9-1624cc244a9f@gmail.com>
Date:   Wed, 20 Mar 2019 09:41:17 +0900
In-Reply-To: <228d681e-4cfd-7e2e-8bb9-1624cc244a9f@gmail.com> (Phillip Wood's
        message of "Tue, 19 Mar 2019 14:06:44 +0000")
Message-ID: <xmqq5zsextqq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for doing this, one minor comment - I try to use
> phillip.wood@dunelm.org.uk for git as it wont change if I change my
> email provider.

You mean something like this?

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 82cd0569d5..6e137576ec 100644
--- a/.mailmap
+++ b/.mailmap
@@ -212,6 +212,7 @@ Phil Hord <hordp@cisco.com> <phil.hord@gmail.com>
 Philip Jägenstedt <philip@foolip.org> <philip.jagenstedt@gmail.com>
 Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
 Philippe Bruhat <book@cpan.org>
+Phillip Wood <phillip.wood@dunelm.org.uk> <phillip.wood123@gmail.com>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
 Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co.uk>
 Randall S. Becker <randall.becker@nexbridge.ca> <rsbecker@nexbridge.com>
