Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68629C433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 10:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiAOKn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 05:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiAOKn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 05:43:26 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D5BC061574
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 02:43:24 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t32so4980756pgm.7
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 02:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:cc
         :references:from:in-reply-to:content-transfer-encoding;
        bh=EQ1fNtad23pm/rZJMjb9uzyHhhOyURY++RsCMSgIjaY=;
        b=mUhIUqfuS5WhsUQ/lP+AVyrkRxhrEG5d0iXAsKiMQW9ELLbbPcnPESAkRc7XCSIYYJ
         qIWAdgcjMeS1ElQMl2fvHuNyLaMUVIABKu23cEv0h+uNQa/KRSH62jWqSZQoiY+y6U0f
         NxWMtE6smWjW0HzM2IKOYP0P8GcrYj1bSBg3Cu586XXvxtplUZtv19U3LmhOu9+Kh7fg
         LcC7J3ykIW17BA9Py+hpWvQe/OsbLXqAN+HKewuk/GmsYVijZmGFoi6Rjg3p5VJ+I+D5
         T8DWQwTdLPezqnPXfuB5qkZEXSvYQs+UDczvQxhKrcLMRQDdq3vxxXi3DjH5AZs86cno
         d3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EQ1fNtad23pm/rZJMjb9uzyHhhOyURY++RsCMSgIjaY=;
        b=tpzUi7x6e1PqLubYMxqhk9wZhN4k2RwTp0IDuRehVuC7lrheOMpO7G1fjdAF6z//Od
         kaoepvYXovCzD5xacpKn5AaA3RRFASBYHQD2yiWDC6Ai/zj7RVgnsSVcpKfbssXB9Ld8
         oUxbNledthWjzyOBYPWxqyklOcLTMuV+iyvDfgnJvZbhY0dTGSPN9XWFygimOsDu0NKK
         lzAmE9TSIWio32VYjy0gA466AWEsGoiJDp6zmABWXEYQLAuSKNl2E9Y6KuZmqhJiK6EG
         nfdqTxdwBJOe5qNP+yCuBWP7kXhyzxj4xis1CJIA0T4Hs1Uadi1CJZ75lFAPJCjQuHBu
         vRCw==
X-Gm-Message-State: AOAM533btmnoJUFhtYI+kB1iDatpBc5nhzvaKipa+30GEtJdxkUDq04R
        bZXx4rocVIYyXze/Xpa6wJXXZ99QxSdjbA==
X-Google-Smtp-Source: ABdhPJwLcAGJuJzKxBeAIFOQD8WPo5NrSxywBkqOkjg+y4VOVV9VWVrb2W5CdDnQsDqDcjlymBnQ5A==
X-Received: by 2002:a63:170e:: with SMTP id x14mr4759079pgl.302.1642243403740;
        Sat, 15 Jan 2022 02:43:23 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4d75:7abc:9063:64b3:ac13? ([2405:201:a800:4d75:7abc:9063:64b3:ac13])
        by smtp.gmail.com with ESMTPSA id y4sm8247814pfi.83.2022.01.15.02.43.22
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 02:43:23 -0800 (PST)
Message-ID: <9a3837b4-8c67-e114-e977-f6c7b729ba45@gmail.com>
Date:   Sat, 15 Jan 2022 16:15:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: A new feature command request `cmd_ignore`
Content-Language: en-US
Cc:     Git Mailing List <git@vger.kernel.org>
References: <11860e44-beff-39e6-2efc-53324223caee@gmail.com>
 <CABPp-BFY2issEqOj1Oj71k=494vc8E563CndxPZfXYrteFoNhw@mail.gmail.com>
 <5f6f1dba-a923-4bb9-70a7-4936566f46e0@kdbg.org>
From:   Jaydeep Das <jaydeepjd.8914@gmail.com>
In-Reply-To: <5f6f1dba-a923-4bb9-70a7-4936566f46e0@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I think that is a paraphrase of the suggestion to

    git rm --cached settings
    echo settings >> .gitignore

> when changes to a file 'settings' that was already tracked (and often
> contains user-specific settings) should be ignored. This misguided and
> short-sighted "solution" is repeated numerous times on Stackoverflow.
> Not something that we should encourage.

So what should be done in this scenario? And why is it a discouraged and 
misguided thing?


On 1/15/22 14:33, Johannes Sixt wrote:
> Am 15.01.22 um 06:17 schrieb Elijah Newren:
>> On Fri, Jan 14, 2022 at 3:03 PM Jaydeep Das <jaydeepjd.8914@gmail.com> wrote:
>>> and other parameters like `--force`
>>> could be added which would delete that file cache if that
>>> file was already committed.
>> I don't understand what you mean by this.
> I think that is a paraphrase of the suggestion to
>
>     git rm --cached settings
>     echo settings >> .gitignore
>
> when changes to a file 'settings' that was already tracked (and often
> contains user-specific settings) should be ignored. This misguided and
> short-sighted "solution" is repeated numerous times on Stackoverflow.
> Not something that we should encourage.
>
> -- Hannes
