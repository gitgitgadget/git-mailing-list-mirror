Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0733AC76196
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 14:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjCXOPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjCXOPv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 10:15:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867F91D931
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:15:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l27so1957661wrb.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679667349;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UzExrJ3r+BMDTgfKgdzVWo/gro4Jsxf1PeIG0DEl7mA=;
        b=CoJ1tl3KSSY1wcc8C74WeqRyY/4/5OgMrhesX5oihBjr40LARuG7nHtUPm6bpppNzv
         Q4N/jI8IoTESmRADYmkurTAFGTxQQMTmf2QAcAuFgzgLQRHi0vUm2VIwEBfAjyAlbjBS
         FsIV/WSzhS+idctzg1ZeF+MLefjDh3n12JQiYer2grsNDpEN7BgxzpC0nEBcQt87v6mu
         cjf4N0Iu8sIABf/gvVDER1jh5IPklqPx4WkSCwbtsBuIcoW+NFtB3fBtvhIBk9MiPXcR
         9GA3tjQk6gEtj04B63vNY33mXU2W180YNvkKwQCCVge32N9O/mgw7kljf34SixhQKVCT
         jwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679667349;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzExrJ3r+BMDTgfKgdzVWo/gro4Jsxf1PeIG0DEl7mA=;
        b=RIx4BhhudT24n9lzwCR0+EBA8pus3Lt5nVQ7Th1qSoHS8M0df00mk6CjzNJAggKYfD
         IEuF8cvDrOOcJF4PuN3aX5DzM0LKyG/5ukuobPCwR4iJnsmWheHY/ar2P10Rt3keyK37
         aZRPu2QUgwG2Kb2xH7gs+cWKu1taFgPGEVQl73tGi2UB3BmjsuSk0RGMrC/7T0SU8Wv+
         r9HILgNRSpPvfuAcy4FkFsQ6cXpbtZ/yqLJmQ05wdMIjrUj+BkRUI+b3DIz11Pzu9Vyo
         PrdtKwvr5pUOrJWamyFfE7i3QHIB5S4hRe+C50tUR2ONasUB8ZyQ5NQkp22yTUTafttX
         oEJg==
X-Gm-Message-State: AAQBX9eZuJ0fkB/uayMTnPmkuf34mJLr4MMMZH4NMK7Qhgl0KZau3OAT
        nyPzUKxmiDl5wxbCgy+FFeGfZHQsd24=
X-Google-Smtp-Source: AKy350YKWhAtg+Nm6Tk8R/lhyG+++CR/Fjtt/2DvAazWRXdH7sXMqm/I0aOHq8rEIGFeZB/Mo9pj7Q==
X-Received: by 2002:a5d:46d1:0:b0:2d2:2a9e:2312 with SMTP id g17-20020a5d46d1000000b002d22a9e2312mr2335164wrs.59.1679667348805;
        Fri, 24 Mar 2023 07:15:48 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id z6-20020a056000110600b002c557f82e27sm18422922wrw.99.2023.03.24.07.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 07:15:48 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <55ee99fc-69e6-7635-10fb-56de9d3b17b6@dunelm.org.uk>
Date:   Fri, 24 Mar 2023 14:15:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/8] rebase: preserve interactive todo file on checkout
 failure
Content-Language: en-US
To:     git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-6-oswald.buddenhagen@gmx.de>
 <47558c14-ba2c-18ec-0532-b21fdfd223f8@dunelm.org.uk> <ZBzU5lzZBtI8/Q7+@ugly>
In-Reply-To: <ZBzU5lzZBtI8/Q7+@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 23/03/2023 22:38, Oswald Buddenhagen wrote:
> On Thu, Mar 23, 2023 at 07:31:04PM +0000, Phillip Wood wrote:
>> On 23/03/2023 16:22, Oswald Buddenhagen wrote:
>>> Creating a suitable todo file is a potentially labor-intensive process,
>>> so be less cavalier about discarding it when something goes wrong (e.g.,
>>> the user messed with the repo while editing the todo).
>>
>> I was thinking about this problem the other day in the context of 
>> rescheduling commands when they cannot be executed because they would 
>> overwrite an untracked file. My thought was that we should prepend a 
>> "reset" command to the todo list so that the checkout happened when 
>> the user continued the rebase.
>>
> so you basically want to convert the magic `onto` into an explicit todo 
> command? i'm not sure what the advantage would be, and i certainly can 
> think of disadvantages re. usability and backwards compat.

If the initial checkout of "onto" fails I want the rebase to stop so the 
user can try and fix the problem (usually remove an untracked file) and 
then run "git rebase --continue" to continue the rebase including the 
initial checkout. Adding a "reset" command to the beginning of the todo 
list when the initial checkout fails is one way of achieving that.

>> How does this patch ensure the checkout happens when the user 
>> continues the rebase?
>>
> the idea was never that the user --continue's. we're talking about a 
> fatal error,

If it is a fatal error what is stopping the user from running "rebase 
--continue" and wreaking havoc? You seem to be expecting the user to 
know that they need to

  (1) run "git rebase --edit-todo" to save the todo list somewhere safe
  (2) run "git rebase --abort" to abort the rebase and restore any
      autostash. (Have you checked that --abort is safe to run when
      HEAD is not detached?)
  (3) fix whatever prevented the checkout from working
  (4) re-run "git rebase" and restore the saved todo list when prompted
      to edit it

It would be much more user friendly to simply allow them to fix the 
problem with the checkout and run "git rebase --continue"

Best Wishes

Phillip

> and the patch's purpose is only to allow the user to 
> salvage their work manually.
> it's an interesting question, though, esp. in light of patch 8/8 of this 
> series.
