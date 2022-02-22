Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6FBC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 13:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiBVNnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBVNnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 08:43:46 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C7410EC5D
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:43:21 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id d3so42032967qvb.5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1wlaSsSJuGkD7aDe56JpTBcoTwgXnhthWsdYjp1fPCw=;
        b=RPFjQ54Iwot5UVyIXQoUszkEJYzVsc0L2dwOoA2Yrk6RzLmnW5SFDVVYZfa5VQccsy
         6ltGdKspuHGXhMaAqNLEzeBsgplp67IaSDoGxLUvW8xmN67jwDwj9BuCqlc16Mw3zLgf
         vwzkShtA+NRU3Ws9QECXgWicP2vAREfiEtMxAMVtsSF0SnVxWv6uoN/HP7GChyNS/8lU
         GxgJi09+w56VI8EbYiXFgs0rkH5/shsq6YeJGc+4/1218etLypQgDfBH1OSF8mCTmuQm
         9oWXDedQBjcr0lRaxjw+ARQhDkkQINZWZ8Oday7dbJQ47KN/c16MQvnrSEBRG/RwNSjZ
         t96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1wlaSsSJuGkD7aDe56JpTBcoTwgXnhthWsdYjp1fPCw=;
        b=jj9WagCUQm+TsHw1xGkXtIA9mdFEOH9VCBAzWUdMHHSVRE0rcmMrN3LW0nqXSXg2dM
         cV0eg5TfiRxK+xjOEK8yDdNfhbT5U1lDeHHb5UxHc4BoLAD1R228GM/AqgddZ5eh9RBl
         Xh2iXe7pXBYr8wLzq4EbmjT0U263CGphOrhuO2RWomG7D2Cvxht+NUMZfu88Py65M7cm
         +CUqo4pejwvrDZon8sfXiJ2wAgUNJaVxfpsTchXNNqx0OA4YrzmVKXGgq57jQ96BHXlA
         395ESZTFGzU5hv2Q+ESyGlDlZdi8IlzFcao+GeCJ8gjD7EA7fgtMF4f7ubF8N2XLvLtm
         D4uA==
X-Gm-Message-State: AOAM531CBZmK1pNDaDQ7JKiaRze8CATJeLekF9sLbCOhjuDQw1jox/0o
        r/hUKvv6TQo2T+Le9qF9LRLL
X-Google-Smtp-Source: ABdhPJxunNQ1Ymy6YOFOJWU3Gu+GhXHYBQnLKY5NID1r5MSLuvDKgg7ALReYfMIb3yS8oH7BNbobfA==
X-Received: by 2002:a05:622a:1654:b0:2d1:83d6:ea64 with SMTP id y20-20020a05622a165400b002d183d6ea64mr22026065qtj.599.1645537400814;
        Tue, 22 Feb 2022 05:43:20 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bk23sm28222992qkb.3.2022.02.22.05.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 05:43:20 -0800 (PST)
Message-ID: <f65462bf-eed7-f8b9-6255-249e5128172f@github.com>
Date:   Tue, 22 Feb 2022 08:43:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
 <54a0aa74-57c2-ee65-ae07-cb1b0daf947f@github.com>
 <CABPp-BGz0Y+Gk0uLy7K-pqBY955=rN-E2SJFofDaje60b-XZuw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202221313400.11118@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <nycvar.QRO.7.76.6.2202221313400.11118@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/22/2022 7:28 AM, Johannes Schindelin wrote:
> Hi Elijah,
> 
> On Mon, 21 Feb 2022, Elijah Newren wrote:
> 
>> On Sun, Feb 20, 2022 at 11:41 AM Derrick Stolee
>> <derrickstolee@github.com> wrote:
>>
>>> The only concern here really is if we want to be picky about the "VFS
>>> for Git" references instead of "vfsd" references in the commit
>>> message.
>>
>> I'm not sure I'm understanding the distinction.  Was "VFS for Git"
>> renamed to "vfsd"?  Is "vfsd" Google's modified version?  Something
>> else?
> 
> VFS for Git is the existing project at
> https://github.com/microsoft/VFSforGit which is pretty much in maintenance
> mode.
> 
> vfsd was mentioned by Jonathan Tan in
> https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.com/.
> From what I gather, it is a completely separate implementation of the same
> ideas of VFS for Git, but from what I see it does not share any code with
> it (and it is unclear how much vfsd tries/tried to learn from VFS for Git,
> it looks like it's being done from scratch but that impression could be
> incorrect).

Elijah is correct that "vfsd" is not publicly visible outside of this
message, so that makes it difficult for us to verify that these patches
being made for it actually work as we intend.

> 	Side note: VFS for Git itself requires the Microsoft fork of Git
> 	to work, therefore this patch would only be needed in that fork,
> 	as far as VFS for Git is concerned.

I would drop this side note, since a big reason for the microsoft/git
fork is so we can create custom patches that handle these issues. We
would probably have created a similar patch during release integration,
but we are grateful to use this patch as a base for making these
integrations simpler in the future.

Thanks,
-Stolee
