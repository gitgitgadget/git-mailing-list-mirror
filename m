Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1379CC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 13:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70892071A
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 13:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S59Ud5s+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgCaNhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:37:04 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33331 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgCaNhD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 09:37:03 -0400
Received: by mail-wr1-f45.google.com with SMTP id a25so26037926wrd.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K/llh/xdSFr4wec5ABQwwjVlX58hUqvjCEKQMJZiZFQ=;
        b=S59Ud5s+xVqXvE6ca3dmzjp3pa8zc84EwLG4LznGWI84M7T76h0iCzArd2ZPH7yxUd
         b5pgw9x4khOplPBhFfVldDWaRARzhFaNfRy1HpnlhETcoKvWBCUzh0YjWaCOZHPRoRUS
         nCX1NDfKefk4uAHHjvb5TEUr7Bvnnagpbi8U50nE+nMYGlc81feGCg0ZI5I3O6VrYnhZ
         y+gii2rvM7l009H7DqtNDJEjUYYbTSNhLnQTzBxskhV+ZWo0tWlBKxaTpxiSIwUkZWOV
         pup/vJHrlf+yBYX7sekmqD8PDe/eYh0C219ThPDc9tdT0RT8UwfikMioqATqvnXYK/0k
         dosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K/llh/xdSFr4wec5ABQwwjVlX58hUqvjCEKQMJZiZFQ=;
        b=VcTphh1BuMLw2hxs0IlNAV5KpLlpnrcK4covunO4qnDsVrPEr9zNw/dkX8AZXSNfBJ
         A6oYMYCDBSoxEHH6LtYhRmdTL1B3GjdQ35QN6waxQ0HD+n84ICf/ylhpvkbiyfiscySw
         4Vz7bmSs7nAQLsTmL/SfSR+CQgvTddVvzFsGnd06PvJLJBOvZfG5SP4e694HF2l17txD
         Y3Y5MruE4fxi7AjGV/LYn2Q8c8FDxarMo+frOHa9HoTrWaOawsHQj7HQaLTTNXst/R84
         MMy9nJjQSCEN3DYENFOp4VmTa1nYYk+/fCNAatKt2QFsjzo59f7N7VJpBc0+dgSMH47F
         bSUg==
X-Gm-Message-State: ANhLgQ0uW7bubVURBwIyX0VK/4rjweh/LImlzSxGxtMiCbFCuHP7cxNw
        C/5peBHenm8SP0fNSyTdKxPmkzGa
X-Google-Smtp-Source: ADFU+vtV31Ansd0EWkRHap7LWx3jDEFNT9dZ/G9Hln9rVRy8kJCmnmv7I1URItZecd0UDoggKTK6+A==
X-Received: by 2002:a5d:4305:: with SMTP id h5mr19829580wrq.69.1585661822044;
        Tue, 31 Mar 2020 06:37:02 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id w7sm26436176wrr.60.2020.03.31.06.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 06:37:00 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Feature request: rebase -i inside of rebase -i
To:     Philip Oakley <philipoakley@iee.email>,
        George Spelvin <lkml@SDF.ORG>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com> <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <20200328163024.GA26885@SDF.ORG> <20200331000018.GD9199@SDF.ORG>
 <7fbe0ddc-74a3-b6b5-09b1-bff171382d0e@iee.email>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ef1a1475-45b3-8696-ed1e-b28f7b655ece@gmail.com>
Date:   Tue, 31 Mar 2020 14:36:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7fbe0ddc-74a3-b6b5-09b1-bff171382d0e@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip, George and Johannes

I really like the idea of being able to extend or rewind an existing 
rebase to reedit commits.

On 31/03/2020 11:57, Philip Oakley wrote:
> Hi george,
> 
> On 31/03/2020 01:00, George Spelvin wrote:
>> Thinking about Philip Oakley's suggestion, it dawned on me that
>> we can *already* do a nested rebase manually, and having a less
>> manual alias for the procedure would be reasonable.
>>
>> Suppose the last four commits are O-A-B-C, and whether they were created
>> by this rebase or existed before is irrelevant.
>>
>> If I want to rebase --nested -i O, then I --edit-todo and
> 
> Maybe `--rework` as a possible alternate option name, if the concept of
> it being truly nested process does not work out?

or `--rewind` ?

>> prepend the following four lines:
>> reset O
>> pick A
>> pick B
>> pick C
>>
>> If a nested rebase command does just that, I think it would cover my
>> use case.  If it adds a comment saying "nested rebase ends here",
>> it's easy to cancel the nested rebase if there was a mistake.
>>
>> A slightly fancier thing a nestrd rebase could do is see if any of the
>> newly created picks are also used in merges that were already in the todo
>> list.  In that case, follow the pick by a label command and update the
>> later merge to refer to the label.

If we're going to support rewinding a rebase that creates merges then 
this is a prerequisite otherwise it wont work properly. It will also 
need to update any existing labels that refer to a commits that get 
rewritten when rewinding.

When cancelling the nested rebase we need to take care to restore any 
labels to their previous value if they have been updated by the nested 
rebase. We also need to restore the list or rewritten commits so that we 
don't report that we've rewritten the commits from the nested rebase 
that we're aborting. These two requirements unfortunately make it 
difficult to implement the nested rebase just by updating the todo list. 
It needs to save the current labels (and reference the commits somewhere 
so they don't get gc'd) and the rewritten-list. `git rebase --abort` (or 
whatever we end up using to abort the nested part of the rebase) needs 
to restore the labels and rewritten-list. I think it should probably 
restore the todo list as well - if the original part of the todo list 
gets edited during the nested rebase should we drop those changes to the 
list or keep them when the nested rebase is aborted?

Best Wishes

Phillip
