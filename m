Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BE9C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 20:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiKDUR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 16:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiKDUR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 16:17:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5F545EEC
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 13:17:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l14so8557558wrw.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0EJrPqAXp0QzoLwcqpWxGNtK93JIf0aUUQBtH92SrE=;
        b=UOWxLw/3iC92NWq+E9OCOMim/Tqy50Xjw7yv1GbSF6nHYmRuHsYzLyyqJdUS6rvnwP
         X2Ml08o162vuX17o3gp/rSA9nx5LxzNCANmZ9tg6lsBpEzbtjqv5PRXnmkQUe/IE/+CM
         MyYrasg1mh9HDCO8LYmFEVhQsgHwKlej/+uBiWKyCBRZQkyq95bKsYXfKEIEIdwMV0X8
         T59u9cEI0+vjfQ+MYH47X9Ko7H4Q01alTKQMhEB0bYDlxadErki7P8dPOkoRlkh5z7T+
         J2Vo9xhZuuOs78TRl5RXMlQEZ0/Fi0SPelJcLQNI5LxzX+iLXT5VJy7K2/NoljGL/xad
         Kivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0EJrPqAXp0QzoLwcqpWxGNtK93JIf0aUUQBtH92SrE=;
        b=EO96QWg8QwNyJE9G7xUfPRuSa7B0MKJfCy5uBB9+Ns+B2bOnAyrrHNE9CY3TTBkRrY
         ifVgC9phgJ3PrbHYb7TbVcHH9SmyxLJixAhvmQjV4/UPjSIHCI7h+Xt0HJGigINgmbPa
         Z6LHXz6YjHj1OzZ4h4yKydSfiIATWwhFeQUiX7owYJsAxL3tKOKKe7nM4eIfVMxhq47e
         tj8cHyPLLF4zYUEXpV6XptF916/+rWb0daQvzbZvzATW+/YR2yGfJ7g79X8vsr2+qnUA
         1Qv0d+h9BaN5/88jT6iiK2RALpbuvNGHwpwaMPypKKHCweJGvMazWEfaVnxqUgo4ixeQ
         2RWw==
X-Gm-Message-State: ACrzQf3ZmehpGE3wx0Un9zOQr3L1xdKFqduwwnOepfcGDK8dhWhgJb+B
        eP7VdQdh6LcIeIa3S59HRg0=
X-Google-Smtp-Source: AMsMyM6psZT6JTINAFqIAMJ/d4dBuU5W6A79opPdlaijOLRmUxmGhbafwdo9K1JbpOi2Lq/eClI+NQ==
X-Received: by 2002:adf:f781:0:b0:236:5559:215b with SMTP id q1-20020adff781000000b002365559215bmr24051053wrp.16.1667593075051;
        Fri, 04 Nov 2022 13:17:55 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id o34-20020a05600c512200b003cf894dbc4fsm355649wms.25.2022.11.04.13.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 13:17:54 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <1ad5f905-f9f1-5a06-e419-476032a0d237@dunelm.org.uk>
Date:   Fri, 4 Nov 2022 20:17:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase --update-refs: avoid unintended ref deletion
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        "herr . kaste" <herr.kaste@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <bf5bc739-cb88-61ff-ed6b-09b1316f2f35@github.com>
 <20221104165735.68899-1-vdye@github.com> <Y2VrhR6b0SzG1HEA@nand.local>
In-Reply-To: <Y2VrhR6b0SzG1HEA@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 04/11/2022 19:44, Taylor Blau wrote:
> On Fri, Nov 04, 2022 at 09:57:36AM -0700, Victoria Dye wrote:
>> However, because 'write_update_refs_state()' will not update the state if
>> the 'refs_to_oids' list was empty, removing *all* 'update-ref' lines will
>> result in the state remaining unchanged from how it was initialized (with
>> all refs' "after" OID being null). Then, when the ref update is applied, all
>> refs will be updated to null and consequently deleted.
> 
> Good catch.
> 
> I wonder, though: should we only add pending ref updates to the
> update-refs state after we reach that point in the sequence?

If I remember correctly the aim of the current behavior is to detect if 
another process also updates the ref while we're rebasing. To do that we 
need to record all the branch heads that have update-ref commands at the 
start of the rebase.

Best Wishes

Phillip

> IOW: there is no world where deleting an update-refs command means to
> drop the affected branch, right? So the initial state would be an empty
> list, which would cause us to not update any references.
> 
> Then as we proceed through the rebase, we accumulate update-refs
> commands, and know their after_oid immediately. Then when we're done, we
> can process the update-refs commands for the branches that we do have.
> 
> The more I think about this, the more that I am convinced that the bug
> is in how we initialize the pending list, not our treatment of it later
> on.
> 
> The bug fix works as-is, but I can't help wonder if the above approach
> might be more direct.
> 
> Thanks,
> Taylor
