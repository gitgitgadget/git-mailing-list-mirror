Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5A3C6FA86
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 14:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiIVOZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiIVOZA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 10:25:00 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E295300A
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 07:24:59 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y141so7826798iof.5
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Ej5txBSoknWJVbGlvR4gqS8eOmlNJbFvkTgoGw0yoow=;
        b=CtsIrT9WwoI9N9q3IhkrJma6osGE1mtV1KVXeHnNX4dom7ky9BRxfpXKoVvLLzuIqb
         VxisBz/pJe2rYvWRdSoUje3KKQJktwmEa0pVheHgZLD1tFmcZnxqx7LEjM46PxCck8SH
         H+BtETjRPtUWs3/1KyU/FzdXl3+C7f/RhtfTyif4kXSDwZOYL2D5NipBeWLWThxrlSW2
         11UhaItDLkfDM4qfWVvlaSFuVHXqnigUe+9rH9JzC2RJNfFNEJnvhSVkTeb739IEXWTR
         uofB1lwUPXEV3KTI9q1FeFTfXw45gg3Nd+s+ji6E9geO/FXC4v7CKE4GirH3trla63NW
         cQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ej5txBSoknWJVbGlvR4gqS8eOmlNJbFvkTgoGw0yoow=;
        b=6+DkPlMJcv6BRpeetAzAHkW5NjdOLLcvV6TWImwM5A0EREkZi9lI/lx8oScs3nEjI5
         hcSR4jYEMRBFceStce4rl2GJwFU5ifoLDF/W61XtzykRBrJjNDz6RlBjSDtX/FaEkEnx
         +oM5XlQQsoFPnpo9p7rf2k1aiE5X++KTJMS1EhkP19J8LBqlYXwhigDLUmADlffOsD51
         5gVDos3RVsc7JF22nn/KJHQo06PpAU+D4+U+SmH4myp1gbqiznY8vbUtRUyI2y+gJXRT
         M/MdNhqybbK6OVkZJr+V39uj3VjCasl0E/QdZjg3+mekexTp5WGxbVgtEqnO4PDP3IDT
         JwvA==
X-Gm-Message-State: ACrzQf0HRp79Erp4qEiT8U/0YIFIvp4/QXQgV+DSvo0RgBrxeikdBB1i
        vevO9DeTU6LtYMs5TAp00iv21i+Mjb9J
X-Google-Smtp-Source: AMsMyM5bS4FgVnUgiI6OpRne+v55Qq+XGc735fGN3yfoC6M2X6fbIwI1GfWDtXnL7YJNzy4BTuq2ig==
X-Received: by 2002:a05:6638:3042:b0:349:f737:176e with SMTP id u2-20020a056638304200b00349f737176emr2028357jak.17.1663856698478;
        Thu, 22 Sep 2022 07:24:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e4c7:912a:7017:ed79? ([2600:1700:e72:80a0:e4c7:912a:7017:ed79])
        by smtp.gmail.com with ESMTPSA id j18-20020a0566022cd200b0067fb21ad9c3sm2365314iow.22.2022.09.22.07.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:24:58 -0700 (PDT)
Message-ID: <1c2f6cfe-a6db-c06e-5313-f5b31be42c8d@github.com>
Date:   Thu, 22 Sep 2022 10:24:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Question relate to collaboration on git monorepo
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
References: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
 <CAJoAoZnm8jE9rT+rrze-zP7KZNW=oCZjcrFWqjDssW3LzxrKPg@mail.gmail.com>
 <CAOLTT8TwdwfHCCv+x51++Aanf3tipMegfZiTKFbQtfh7b_EY0A@mail.gmail.com>
 <CABPp-BEBB1oqdVcXrWwMAdtb0TwHZvr-6KDa210j5ncw54Di_g@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BEBB1oqdVcXrWwMAdtb0TwHZvr-6KDa210j5ncw54Di_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2022 7:36 PM, Elijah Newren wrote:
> On Wed, Sep 21, 2022 at 8:22 AM ZheNing Hu <adlternative@gmail.com> wrote:

> Here, we do have an object download, which occurred after the merge
> completed, so there must be something happening after the merge which
> needs the extra blob; if we keep reading...
> 
>>  project1/file1 | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
> 
> Ah, the 'helpful' diffstat.  It downloads blobs from a promisor remote
> just so we can see what has changed, including in the area of the
> project we don't care about.
> 
> (This is yet another reason it'd be nice to have a --restrict mode for
> grep/diff/log/etc. for sparse-checkout uses, and an ability to make it
> the default in some repo, so you could get just the diffstat within
> the region of the project that you care about.  We're discussing such
> an idea, but it isn't implemented yet.)
> 
>> warning: This repository uses promisor remotes. Some objects may not be loaded.
>> blob_count1=11
>> blob_count2=11
>> blob_count3=12
>>
>> The result shows that blob count doesn't change in git fetch, but in git merge.
> 
> If you add --no-stat to your merge command (or set merge.stat to
> false), the extra blob will not be downloaded.

This is an interesting find! I wonder how many people are hitting this
in the wild. Perhaps merge.stat should be added to the optional, but
recommended config options in scalar.c.

Thanks,
-Stolee
