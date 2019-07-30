Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571831F462
	for <e@80x24.org>; Tue, 30 Jul 2019 18:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfG3SgW (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 14:36:22 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45697 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfG3SgW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 14:36:22 -0400
Received: by mail-wr1-f53.google.com with SMTP id f9so66832996wre.12
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YnRHdltfxQcjl9FNzrKWJffOIb5a/9s0JXM1tamI/cY=;
        b=foizDwAD67Uoc9XOxrxuj3sHdr36R5G9WOt4M6iye6mkeV0QhEu3PnQfhx1K05JteO
         Fa16LsvBBeS2tXeAWERIbIcHGpp9O2314k2MsdLFm/7L6WRJ3glbAm8/RQDHXtHnd3dk
         aDp/iuqk21QicVf4g5lrexKJLp8BWrZQOvr9MQiPaAFKr+KIK0wKazD68Bo4S3ZsszGV
         neNaAfAdOrQP3nX8eDe7K6Yhm9JfGZhnYoGAH84O4fCL8H9dxK2lsaZ9kQ3OcHA/DC36
         Hp6wzM6hSOwqnNUyUpej4yYyP5wppqXEFNuDdbirMHTOnxslzQ9pvteY8bUEvliw0a8v
         uang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YnRHdltfxQcjl9FNzrKWJffOIb5a/9s0JXM1tamI/cY=;
        b=dlQse6XvKkZs2YKzn9ga/8Ox7ENGuCNG3+heRnS0rWzQk8edBFpHe4nhXspYfBgrkM
         jhPglnJhmvdMkWNc1Bl2t97N+8hijZxoZexmF9HZNrXCfsoBdfYgY3ZNwGT13tri3BiN
         7TzJ9SLlwhXT/m8sepvMGXouOol4N7lBNjuzP9oCLzulGFfhhX+mBLkzDwwezwoy/4Ag
         GjMUnt7Q0ocwi6W5HwVGzx21WhinSWsiAP1xL9TQcMM8W+bBKFrYgspJ6Nx7xfynA8aJ
         BE5wPZ7x6E3Dtt+nabIjK778FR42lrEV8pk45RkQKOCD7NfT8OKpIYUIS1XIewXM/FPt
         PbEQ==
X-Gm-Message-State: APjAAAVP6OrlV5ZCLCtnBSGDGUKeNipG9Ml7f6/iyM+8zZicJLKwlvCx
        Cwyzu7MMWQ3GFQuycKC2pnfZZBAr
X-Google-Smtp-Source: APXvYqweKB7+ebXYgBGorvglKIAbCyUcgWvc3I1NltYQHWw3u//BXNzv11rewtz+RYJsfOOfcAh5GQ==
X-Received: by 2002:adf:de90:: with SMTP id w16mr31976411wrl.217.1564511779268;
        Tue, 30 Jul 2019 11:36:19 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-23-226.as13285.net. [92.22.23.226])
        by smtp.gmail.com with ESMTPSA id g12sm96140119wrv.9.2019.07.30.11.36.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 11:36:18 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG]: Destructive behaviour of git revert
To:     Andreas Wiesinger <awiesing90@gmail.com>, git@vger.kernel.org
References: <CAP82knNJ7YH30R-Z61ake58qERp--6hdvgGasKpHQ2TbMPraiA@mail.gmail.com>
 <CAP82knOVE5RbcDbD-SqbkoZ_4qubi96n2p3M_vgc4xGFVwTpMw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <015916f3-9386-d541-0603-b361c44a7ae8@gmail.com>
Date:   Tue, 30 Jul 2019 19:36:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAP82knOVE5RbcDbD-SqbkoZ_4qubi96n2p3M_vgc4xGFVwTpMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas

On 30/07/2019 18:24, Andreas Wiesinger wrote:
> Hello,
> 
> git revert for merges will mark merged files as deleted and commit
> them as if they would have been deleted, but that is for sure never
> what anybody would expect and has deleted many files unintentionally
> and unrecognized in our repo shortly.
> 
> I have reproduced this issue in a very small example repo here:
> https://gitlab.com/electrocnic/git-revert-destructive-behaviour/tree/master
> 
> Expected behaviour would be:
> 
> A reverted merge should never mark any files or directories as
> "deleted", and merging the branch where the other merge has been
> reverted should not lead to the deletion of those files.

Thanks for creating an example. I've had a quick look at it and it 
appears that you have a merge that adds a new file from the branch being 
merged, then when you revert the merge that file is deleted. Could you 
explain what you want to happen when you revert that merge? The idea of 
revert is to undo the changes introduced by the commit that is being 
reverted, I'm struggling to understand why you think revert should not 
do this for files that are added.

Best Wishes

Phillip

> I classify this behaviour as really really destructive and clearly a
> bug, even if this behaviour is by intention. It should not be by
> intention then..
> 
> Best regards,
> Andreas
> 
