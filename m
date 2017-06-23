Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5495E2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 04:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbdFWEJo (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 00:09:44 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36153 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFWEJn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 00:09:43 -0400
Received: by mail-pf0-f177.google.com with SMTP id q86so18183467pfl.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 21:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EjHl6AbmJMdVRTLIHliF0s2ZQKgfujDS2CyCRmptt7U=;
        b=EATibcYPHdxTAe0lbMrz4NWnpOXaSouU1Y24fr+8LqaZ4tEoW76qYVQTpTp5lp6EgK
         DWnHwY8HCTVqrucYIBTRdh6EOLPWnuSlwA9spgTmin+40nNKPcdvwarMpqQOxOFxsHpA
         eZBXBwsfzwFYbAK9alj4tqQCx2joMqM3cUgf09l0uFcJtKq8r3fMo9zCITKeYoRnkxc3
         j6R4lPbeqA0koHbR8zGq9ACV9EuI024BPDYbYb7Vl60rMa24NRyTmaau06PDaU78K7c/
         l1SLiqtO5JdKABK/aPaKCJd++XkYqJvHZ//fhd3eURMaKado/WWZb8AzISE1vWQFaJ74
         IZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EjHl6AbmJMdVRTLIHliF0s2ZQKgfujDS2CyCRmptt7U=;
        b=OAGVNDAYatGzaAl2NYBC8muxHdqjDmDDQdUO+G5ciYLploEj2LpS27hKlXzlWN99ej
         aDbrQ2j7XHF6jDldd1WQOk/DctA+qgklFc5T5YFLf2eW4hhxTd0bCaQFG4LRPZeJPXd5
         fFfBR5ZWLtaiHlpiNWGB4rlWDCQm5gKFT3oK/C1Q6C1OpYG07+iS9pxUDlvZ2T6hXB94
         C3qULW11wmYcp+XgYZbCT3+/BNfmwnD7AC2Bd6D34Wgf6F93TTeXIBs7EXN3oVyipqmh
         WoMQEMGNR4oMo2Y3Bn40fobxeKGnKHGpNBgk4Ow1Pd80kev5NdNovBXr3BZ3gNcgnfFf
         XVTQ==
X-Gm-Message-State: AKS2vOwORWoBAmjVDluPAMNmZ/sg1XsqdAdq9tr/mXWDQRl5lVEUJwkU
        BEJLwlXOpWrOQA==
X-Received: by 10.99.104.136 with SMTP id d130mr6011822pgc.236.1498190982391;
        Thu, 22 Jun 2017 21:09:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id s64sm7766655pfd.77.2017.06.22.21.09.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 21:09:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Xie <emilyxxie@gmail.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>
Subject: Re: [PATCH] pathspec: die on empty strings as pathspec
References: <20170607033308.33550-1-emilyxxie@gmail.com>
        <xmqqfuf82xr5.fsf@gitster.mtv.corp.google.com>
        <CAAin2ARfUCYM95L_k3fSQ--reQD3uMG72ah=Xg1xvvgKcU+QkQ@mail.gmail.com>
Date:   Thu, 22 Jun 2017 21:09:40 -0700
In-Reply-To: <CAAin2ARfUCYM95L_k3fSQ--reQD3uMG72ah=Xg1xvvgKcU+QkQ@mail.gmail.com>
        (Emily Xie's message of "Thu, 22 Jun 2017 22:34:31 -0400")
Message-ID: <xmqqefubgxa3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Xie <emilyxxie@gmail.com> writes:

> I ran the tests and none of them failed. 

This is not about a test you touched, but applied to or merged to
any of the recent integration branches (like 'master' or 'maint')

    $ make
    $ cd t
    $ GIT_TEST_LONG=YesPlease sh ./t0027-*.sh

fails at the very beginning.  I do not know if 0027 is the only one
that triggers this failure, though.

THanks.

