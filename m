Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1263CC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF83D20771
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHr0dW+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgDGSSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:18:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51498 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgDGSSX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 14:18:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id z7so2700706wmk.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wv/6sXxpj1zSh4IOvX9j8r0T4VgBZN3BULrm6Hv2cJY=;
        b=RHr0dW+mDGO/fx+dOc/KqVGiqR7A/a08kuJoEpKKnb6pkGhl1hIIZPcnHWvQLUmu80
         NPBXnIbBA902El02KsBR4LtcbgqiP4OZNETzYjgmP2nyOH8tMZd7NZ+CZIm82MfjzHIO
         wY0syMzmCjRifDF5UqsMTEFHQ/mSmFGgdQdMhBmmN+7mKK1PR62BFSdqaBsLkwpl9mSJ
         u03TeKfEJkHbWpUsPsJqDFlh0JEwfrSA6JTsiHoN27zhFmopzl/U9eA++Hy+FqWfIaOX
         YulYlK8OE2R1lHOaSlOwyVRkXvtDMqX3/isV+IzxGMYvzEn1csUvxpQ018DO9bze1FRx
         091Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wv/6sXxpj1zSh4IOvX9j8r0T4VgBZN3BULrm6Hv2cJY=;
        b=R90FkUe+z/2rzPXfke//3X1UmobwG1Va4g7+kvt4kk35JsIbmJveaMCLbgVx5UdCj1
         r1ck/0Fr6+fl7/+fVzKS1w9vTDQRHtD/0nR8QuDPz0YSmW+cWG2m0pOirHUUcwZQGdpv
         TOlOW13sisSZhNy71eABV6rVip45y+jMqGoF0fkr2sZd+E66CAl+6fwyZfsU6SRG2bUv
         VZeiIdbFSvKhf90z/ZQt08IMzuGS6gSUOakh5Ccxf6LYmrFVT5uREc7vPgR6sCVDD0ie
         yYHEoNGQV0tIL7SstHixSukjJJymmCN/sGLRPO/+Efk4qFelHFVhnLIBF6zwyKsiYqEb
         z6Kg==
X-Gm-Message-State: AGi0PuZFLlDMaHwti96ceo+nmAI/tuKreu2iHgRy5cOlapNUuifULYYc
        rSZltmrQi5bOIRjZyoIi5/y9SxG7
X-Google-Smtp-Source: APiQypLw2PmnyGXtlF4N0Amlopb89/+wnGmn+u6QraKGSRYQEEcISmVl/VSWUfIlLPUGQLgFW+7nrw==
X-Received: by 2002:a7b:c012:: with SMTP id c18mr574371wmb.22.1586283501981;
        Tue, 07 Apr 2020 11:18:21 -0700 (PDT)
Received: from [192.168.1.201] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.googlemail.com with ESMTPSA id a18sm11320291wrw.82.2020.04.07.11.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 11:18:21 -0700 (PDT)
Subject: Re: [PATCH 0/6] fixup ra/rebase-i-more-options
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <CABPp-BF5Z8zJLZ3e4G8bDUJjheP4D4-aLoLcpqWuJC+OqLTpDg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0ad67315-21e6-48a6-0903-626c9a0e4b04@gmail.com>
Date:   Tue, 7 Apr 2020 19:18:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF5Z8zJLZ3e4G8bDUJjheP4D4-aLoLcpqWuJC+OqLTpDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/04/2020 16:17, Elijah Newren wrote:
> Hi Phillip,
> 
> On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The tests for ra/rebase-i-more-options were not as comprehensive as
>> they could have been and some of the tests that we did have didn't do
>> a good job of testing what they purported to. This series cleans up
>> the tests and fixes a couple of bugs (thanks to Jonathan Nieder for
>> reporting one of them). The bug fix reworks the code to try and make
>> it clearer.
>>
>> I've opted to add some cleanup commits on top of Rohit's work rather
>> than reworking his patches. These are based on top of 4d924528d8
>> ("Revert "Merge branch 'ra/rebase-i-more-options'"", 2020-01-12) there
>> are some conflicts when merging into pu. I had a quick look at the
>> conflicts and they appeared to be relatively straight forward to
>> resolve. If that impression is wrong let me know and I can rebase onto
>> master or try doing the merge myself and pushing it to github.
>>
>> Phillip Wood (6):
>>   Revert "Revert "Merge branch 'ra/rebase-i-more-options'""
>>   t3433: remove loops from tests
>>   t3433: only compare commit dates
>>   rebase -i: fix --committer-date-is-author-date
>>   Revert "sequencer: allow callers of read_author_script() to ignore
>>     fields"
>>   t3433: improve coverage
>>
>>  Documentation/git-rebase.txt            |  27 +++-
>>  builtin/rebase.c                        |  49 ++++--
>>  sequencer.c                             | 109 ++++++++++++-
>>  sequencer.h                             |   2 +
>>  t/t3422-rebase-incompatible-options.sh  |   2 -
>>  t/t3433-rebase-options-compatibility.sh | 201 ++++++++++++++++++++++++
>>  7 files changed, 368 insertions(+), 25 deletions(-)
>>  create mode 100755 t/t3433-rebase-options-compatibility.sh
>>
>> --
>> 2.26.0
> 
> Thanks for working on this!  I took a look over the series and noted a
> few minor issues and questions, but it mostly looked good to me.

Thanks for looking at them and for your suggestions. I think I've got
reasonable test coverage now - lets see if Stolee's coverage script agrees

Best Wishes

Phillip


> Elijah
> 

