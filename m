Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82A9A1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 14:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393683AbfAPOjV (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 09:39:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33236 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393563AbfAPOjU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 09:39:20 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so7415667qtp.0
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FYvmwIwQvjr2td0liCZUeDIdUh9AK/lONR7nDHoq3hA=;
        b=DRTga1QqJikf5CgyaAgljAObpR2DP+pdldaT5l+/vABjHBYSCUO0zsKW5QKg/scLFX
         1u2RtxAeB0w4RvJT+HJc0Sj5l4xhze/HSufbqvxuShLGeEOhZ8g6qCG5rz4uE6Qtdwwb
         BZOlE7Emt2uwuLtUV/KvJa3weVdXodmq2n042aA7+uqUJK2ZuDtECLvdCA1q8l6LhpLN
         tZKecO06rYiqWgEAy08Isxh3ZgsueZBUTuxK0IPIlEpX0ILb8JOWfdneQDD5akRwteYE
         3l+H2W6dPMyHjASp7ZF2gzoTTdXrAEEa6uO1z63xjZXCSg+ZFRnAAYg3x7vQ5vPm4u/F
         IrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FYvmwIwQvjr2td0liCZUeDIdUh9AK/lONR7nDHoq3hA=;
        b=kkBkqTbVoiHQk7Te47FUj3aLF6pQvWzr81Ii+lgl0AuvXrYBvXCRoQLgqp+do47XOA
         uO84yiUjjWOmF1BiNd8Z6O3CCUo++2flHDM7YsCNIYesExWurVXbZhUMlESLDMqX4pz4
         UgjtLtqHFJFEsj9W9CRNL7lYz8z/C+iO0RyrqN/nUrLF4gmuVict2+czJAHs5oCczezn
         rm4wNUviNrIhybxr5Roc8Dy2aGvQhdoGxs5Wl4njgA8DnqVgDPSqMXkMcI8hMjqKx8g1
         J0zoSy5posla012JjjMFnI8pzif2iTxFrjv1NUzaVjDv7s5MNqxZRpYAP+FF04p7JZvk
         eg+A==
X-Gm-Message-State: AJcUukf7tmvHTkp4yprRRzAEujLrub2ZQ0pRW2vfuqUYpmaZzJXf1/4q
        X1yLtdw3ShPI5mG1CiNr6vKWHuFCZMZD9A==
X-Google-Smtp-Source: ALg8bN7m9kWCqP/QIGEhb5qBOMO77bqUt/JmF0sJq5jUGLNGMDaUrDkNkkV7JC8nY2cggo+nEIMtbA==
X-Received: by 2002:aed:202e:: with SMTP id 43mr7394571qta.27.1547649558653;
        Wed, 16 Jan 2019 06:39:18 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id g19sm20919575qke.2.2019.01.16.06.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 06:39:17 -0800 (PST)
Subject: Re: Regression `git checkout $rev -b branch` while in a
 `--no-checkout` clone does not check out files
To:     Anthony Sottile <asottile@umich.edu>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
 <CACsJy8B=-V7XY+=5pwwSzg8B6Goa55DPPU3ErgjOEsSJVni18Q@mail.gmail.com>
 <CA+dzEB=TPxng4YBC4Vfh=ZcctAzRQ+drJ3y2sXwP=JXf+UweSA@mail.gmail.com>
 <CACsJy8C=O=ZDvD0ReSJOyAsNDEb5Yz-iFvs7oV5zAXaFf-dw5g@mail.gmail.com>
 <xmqqef9th4iy.fsf@gitster-ct.c.googlers.com>
 <CA+dzEB=+ROLVjp36SQjucouc8YUWTvYBrN4QyS5fsStMPtbw_w@mail.gmail.com>
 <xmqqwonlfm0g.fsf@gitster-ct.c.googlers.com>
 <CA+dzEB=oeL2oByqiH4FeCHc29yGL2TwhmO1DKmRTDx8Xdhh=NQ@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <e9284bc1-0db2-6f90-6e8e-3a7682c03dd0@gmail.com>
Date:   Wed, 16 Jan 2019 09:39:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CA+dzEB=oeL2oByqiH4FeCHc29yGL2TwhmO1DKmRTDx8Xdhh=NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/3/2019 5:05 PM, Anthony Sottile wrote:
> On Thu, Jan 3, 2019 at 1:51 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Anthony Sottile <asottile@umich.edu> writes:
>>
>>> On Thu, Jan 3, 2019 at 12:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>> A "fix" to Ben's optimization for this particular case should be
>>>> fairly straight-forward.  I think we have a special case in the
>>>> checkout codepath for an initial checkout and disable "carry forward
>>>> the fact that the user wanted all the paths removed", so it would be
>>>> the matter of adding yet another condition (is_cache_unborn(), which
>>>> is used to set topts.initial_checkout) to the large collection of
>>>> conditions in skip_merge_working_tree().
>>>
>>> I think it might be simpler than that even -- the optimization treats
>>> the following as equivalent when the current checked out revision is
>>> deadbeef (even if the index / worktree differ), when before they were
>>> not:
>>>
>>> - git checkout -b newbranch
>>> - git checkout deadbeef -b newbranch
>>>
>>> If a revision is specified on the commandline it should be checked out.
>>
>> If it were to be a "fix", the exact same command line as people used
>> to be able to use, i.e. "git checkout -b newbranch", should be made
>> to do what it used to do.
>>
>> Forcing users to use a different command to workaround the bug is
>> not a usable "fix".  If we want a working workaround, you can tell
>> your users to use
>>
>>      git reset --hard HEAD && git checkout -b newbranch
>>
>> and that would already work without any code change ;-).
>>
>>

Just noticed this thread.  I agree that the behavior of `git clone 
--no-checkout` is a little odd in that it shows everything as deleted 
but the goal of the `checkout -b` optimization was to not change 
behavior (unless the user opt-ed in to the changed behavior via 
checkout.optimizeNewBranch).  I'll work on a patch to detect this case 
and ensure the default behavior doesn't change.

> 
> oh wow, I didn't realize `git checkout -b newbranch` also used to
> reset the `--no-checkout` state, yeah you're right the optimization is
> way more problematic than I had considered.
> 
> I'm working around by not using `--no-checkout` personally
> 
> Anthony
> 
