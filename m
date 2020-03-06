Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D3DC10DCE
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 22:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D96206E2
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 22:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCFWmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:42:47 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:57667 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgCFWmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Mar 2020 17:42:46 -0500
Received: from [84.175.189.84] (helo=[192.168.2.6])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1jALg2-0005bO-S5; Fri, 06 Mar 2020 23:42:42 +0100
Subject: Re: [PATCH 1/4] set_git_dir: fix crash when used with real_path()
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
 <f7afcb4cc83a955b04283475facc02349207557c.1583521396.git.gitgitgadget@gmail.com>
 <xmqqa74t2lpr.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <8cfa5434-4f67-fa1a-7de0-2c4d12653488@syntevo.com>
Date:   Fri, 6 Mar 2020 23:42:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqa74t2lpr.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06.03.2020 22:54, Junio C Hamano wrote:
> With this detailed explanation, I expected to see a test or two that
> demonstrates a breakage, but reading a stale value may not
> reproducibly give the same wrong result or crash the program,
> perhaps?

Let's put it this way: one of the tests hits the bug every single time,
yet still the bug has gone unnoticed for years. So yes, it's not super
reliable. I think I could make a test that crashes often enough, but
the effort will probably not be justified. The problem here is rather
apparent when a finger is pointed to it.
