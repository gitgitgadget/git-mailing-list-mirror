Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92552C35242
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 15:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E212072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 15:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxO1Xytw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbgAXPlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:41:01 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:35170 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388413AbgAXPlB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 10:41:01 -0500
Received: by mail-qt1-f177.google.com with SMTP id e12so1832900qto.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 07:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vp44321uF44Soc/UM7dkh3LZfcndLI74Lb+5zwjOnJM=;
        b=sxO1Xytwuv4TFw7I/RxsyQV7oun15/96crdOZB0QMvLBBMUK29gnF9zeGJPBWsd33Q
         JSLijkTRwcS6wWxagJV9kNDkg2wa8NTlCkEdipEZ9/v7uoWxwJuhiVOHrYC4DhhW4CiZ
         Pf96dmWzs359inor9ZPJSjmoIcMNvu/rL9qw8PIEf0e3/OYszKH/2fuanqS3nJmc9GDV
         njcQ9YAG2B1/OsLxqi2chQokNWO8qns2WXuZIGJeD7NSb71/UlgbzTKPOsfHD0/ANqT+
         DtVI4Gvt9Dv17czFA6yLexonKrbeOII/z5InKRoDkBIfa4RbvApiP5IESnWi5K1t7XeI
         f8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vp44321uF44Soc/UM7dkh3LZfcndLI74Lb+5zwjOnJM=;
        b=rG4oFsoBszwGHpMNbycrcLLqnjmwJp1ydaPn+9qnaOLzfvbthNIBgYzm7lCkFpDUmt
         0ru9tjTbZ7QedpVoqtKmadoYkNrpy5oNvRahjRd2qHPCIxq1/g1ZaY/XKiqu4azkpRwk
         AoXCIKrxU23UsdTy4BkT/4XmKvGddhwQxfnhk17IuJQ/OJXm/JARZe0f39JzeLy5DbZb
         IzKua8Tt7le6nRAK15OCpnwQfPeqhhb1MgXXyCuh/rUHxiklvx5Mif7jMyB8NJosS/+Z
         3wWSVi9ZLuOLANNHLktm5wLMQmRMW3gHBJWb28A7alBeinBf8kQXUA+yscb8H4RM57rB
         WNEg==
X-Gm-Message-State: APjAAAUNAjtbYThMt17sUPc5ILCJRqHWfux4DbgMlBV4MorYKrdZrhFd
        b/zt21KqMtSS5XdcWbO3ygg=
X-Google-Smtp-Source: APXvYqxx+zrZCIDOW81oMvzVQ5hUpETkucJoQpr5ChCVGfu/Iiw7amZA4clsBVJu7u4Q0l0rmqyaPw==
X-Received: by 2002:ac8:3fa9:: with SMTP id d38mr2629255qtk.333.1579880460028;
        Fri, 24 Jan 2020 07:41:00 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:821:e5dd:2180:4c2a? ([2001:4898:a800:1010:b956:e5dd:2180:4c2a])
        by smtp.gmail.com with ESMTPSA id e13sm3387065qtq.26.2020.01.24.07.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 07:40:57 -0800 (PST)
Subject: Re: Sparse Checkout Trouble (2.5.0)
From:   Derrick Stolee <stolee@gmail.com>
To:     JunkYardMail1 <JunkYardMail1@Frontier.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
References: <062301d5d0bc$c3e17760$4ba46620$@Frontier.com>
 <d4056731-c13b-c89d-dfd2-e6235e29fed6@gmail.com>
Message-ID: <405d83bd-cd50-49c5-a068-6d3ce102f669@gmail.com>
Date:   Fri, 24 Jan 2020 10:40:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <d4056731-c13b-c89d-dfd2-e6235e29fed6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/21/2020 8:19 PM, Derrick Stolee wrote:
> On 1/21/2020 7:42 PM, JunkYardMail1 wrote:
>> Reverting back to the previous version (2.24.1) allowed to un-stage the
>> files and reset the changes.
> 
> This is definitely pointing to a regression, and the feature did get a
> bit of an overhaul. The goal was to not change how existing users
> interacted with it, though, so this is a bit alarming.
> 
> I did find a behavior change related to these paths in Git for Windows
> 2.25.0 versus 2.24.1:
> 
>   $ git clone https://github.com/derrickstolee/git-sparse-checkout-test
>   Cloning into 'git-sparse-checkout-test'...
>   remote: Enumerating objects: 6, done.
>   remote: Counting objects: 100% (6/6), done.
>   remote: Compressing objects: 100% (4/4), done.
>   remote: Total 6 (delta 0), reused 6 (delta 0), pack-reused 0
>   Receiving objects: 100% (6/6), done.
>   error: invalid path 'directory-1/prn/a'
>   fatal: unable to checkout working tree
>   warning: Clone succeeded, but checkout failed.
>   You can inspect what was checked out with 'git status'
>   and retry with 'git restore --source=HEAD :/'
>   
> The checkout here is _expected_ to fail, due to the protected
> filenames. What is troublesome is the following sparse-checkout
> commands fail, and the read-tree command fails in a way that
> 2.24.1 does not:
>  
>   $ git sparse-checkout init
>   error: invalid path 'directory-1/prn/a'
>   error: invalid path 'directory-1/prn/a'
>   
>   $ git sparse-checkout set "/*" "\!/*/"
>   error: invalid path 'directory-1/prn/a'
>   error: invalid path 'directory-1/prn/a'
>   
>   $ git read-tree -mu HEAD
>   error: invalid path 'directory-1/prn/a'
> 
> The double error messages are due to the "try with an in-memory
> pattern set, then roll back if there is a failure." The patterns
> we are trying to create do not include the directory that is failing.
> 
> I'll keep looking into this.

I am still struggling to find out exactly what goes wrong here.

I'm CC'ing Elijah because he also made changes to dir.c, and
perhaps he has some idea of what's going on.

Using GIT_TRACE2_PERF=1, I can see that the error appears during
the traverse_trees() which is after the sparse-checkout patterns
have applied the skip-worktree bit. 

Thanks,
-Stolee
