Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E754BC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 18:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbiCWSOA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbiCWSN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 14:13:57 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6EB88B16
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1648059142;
    s=strato-dkim-0002; d=pdev.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ge9YQ7vNZsuInGklzzprb8beM7S/Smm3b424JNzVMjM=;
    b=E052hpDyQTod0PFrEC7jEN7+4vb8hldx6rfK7NmjNEP+lD5+QBuDJ3TtbRZk8aErSv
    jRZ0f4LydZ02ERITwFYUkP1YzYc9LgZBWpqK1VE58HViTjQmV4NyvmguITnK0L+jLVc7
    WXG4D3lwXThC1xJu0I9xhGlTUjxYuSvu+f1jLoYOil1qgoK6dnWw8s7tMSXQ/T/iEx6j
    c4uXVZ9SMxL1VD8Z7XOBIIBbQAgU3RUq5yfVTfuu5+2Yhz4Ih61HhsBtSyrYBLV6wHkN
    INAVmGOwvd140LhbPnrqf7TTJCCe6Jgm3chQ4PgLnXee0Ho1wnP53YPzZEGLPnRAtStx
    hSvw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":Pm0UfUGtd9+G9p9stmxCE5ta4sApnuCD/i3TNd+y2/o2oXSBVgRMI6humKUuom7dOiNficpg2psNppH8spxVzVy/NoI102aC"
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2003:c8:d70d:6f00:6600:6aff:fe94:255]
    by smtp.strato.de (RZmta 47.41.1 AUTH)
    with ESMTPSA id k060dey2NICM1WL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 23 Mar 2022 19:12:22 +0100 (CET)
Message-ID: <e8417ad5-f9f2-c1de-75f6-45be49f0011b@pdev.de>
Date:   Wed, 23 Mar 2022 19:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: BUG: %+ format placeholder and colors
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
References: <6f0d1c12-4cf8-bbdd-96d4-eae99317e2e4@pdev.de>
 <600744a4-8d5a-0ef3-6e75-e3637e7070aa@pdev.de>
 <220323.86wnglnzrq.gmgdl@evledraar.gmail.com>
From:   Raphael <raphael@pdev.de>
In-Reply-To: <220323.86wnglnzrq.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 > At least for me a screenshot & a link to a repo you expect to run this
 > on would really help, since the output is very different depending on
 > branch topology, ref names etc.

I believe the branch topology is not relevant to reproduce this bug, it 
happens in my small demo repo with two commits as well as big repos.

I uploaded a screenshot at https://qu.ax/Mzuv.png
The key is that lines starting with the pipe symbol should have their 
text printed in red, which does not happen.

The general idea is to highlight when a commit has refnames, which I 
want to print in an optional second line and colorized. The latter seems 
not possible currently.

The exact command used was:
git log --pretty=format:'%h %s%Cred%+d test' --graph
