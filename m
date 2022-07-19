Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1E7C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 16:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiGSQro (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiGSQrm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 12:47:42 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF72B5725D
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 09:47:37 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id o21so11641355qkm.10
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EZ6RYKRqDx6IpMDINcY7lZeOLQT+wo/jIKqIIF/VwG8=;
        b=TdNwfzolsKKEHQ7wRc0iQuyeJ41SOM76oiVy9DLaB8xTDRJD2vrfkFeWoQ4QMVgBdj
         HErdWw2hU1CbgyyB5QtagULXTJWR5h9yMHJrwmcE3sXAQI2YsbZ5L+hQO/oWfJWqTLrb
         v0RfdZ5BClHLnbt63RrYnubCJx4atSBxvsK1oaUhEnXxhao/DmyzIY+GG0C/y2FosKhH
         OqdSFAyN9HXnA09cY1MCMDtBGhU+DeGaVxPTaJLWvdfGyx/FWP/h/ItBrq7QmtJNY1jO
         8Qx/AtFujpSO0CqfPe9KZvCEysDXNj5Qtu8/0ku2x4WLnGPHpOhl/bAMs5bHhNScORaV
         v6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EZ6RYKRqDx6IpMDINcY7lZeOLQT+wo/jIKqIIF/VwG8=;
        b=BjDtrvpr0eTMSphEzJbgeBH0kQvtHkGiq5bb7L64QHF4WRNMPnVFv2WpPHjqtnku1E
         WD7tvingW6mxub9R3syd4h+fBb4exLlOauLb2IlT8MK/69cAwYYHhS5KKgh2w/8NQ8Gu
         ZQrNqCL2KQkpk01yEeWojbKuxJPPCmnHtBCxOph1CAzkpV6urpIo+hKBuZXH4W62dBB1
         j5wnQeqzsDzaQP7r8IJPG+CbbDkj69E0gLaE28B5FqEMwRMX5ogHU3XJ0zDTwe5RbLLm
         TCdnXW5i85oTAQCxzsu5rYxl8MliJVP/VsyDzQQazt3y9tMfuit7HsAGhKbOauEJirb8
         GJUg==
X-Gm-Message-State: AJIora/FnpkkSvsPsLmaIC6JYCMpvf1SXeUezNQ8j5mUh2h5UyhdLv7z
        d8Kat0cr5quVhmv+rWV0XzZS
X-Google-Smtp-Source: AGRyM1v1blaetIlcB24XSWFyKYpu++4bnzFF/FyK3jvLoWiW+XTZtXEqoBIRBe93AAiIX/mCnzW1Kg==
X-Received: by 2002:a05:620a:424d:b0:6a7:9714:9443 with SMTP id w13-20020a05620a424d00b006a797149443mr21004332qko.544.1658249257048;
        Tue, 19 Jul 2022 09:47:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id j8-20020a05620a410800b006b5e533e954sm7619676qko.5.2022.07.19.09.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 09:47:36 -0700 (PDT)
Message-ID: <106a3a5c-ab47-69b2-1432-43b12baf20e6@github.com>
Date:   Tue, 19 Jul 2022 12:47:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 07/12] rebase: add --update-refs option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <3ec2cc922f971af4e4a558188cf139cc0c0150d6.1657631226.git.gitgitgadget@gmail.com>
 <20220718090557.GA5616@szeder.dev>
 <11aa9b43-adea-4e90-9c70-ab3579aa445f@github.com>
 <xmqq4jzefc3e.fsf@gitster.g>
 <6b6746cb-2456-0733-32ed-c0a7a3f57087@github.com>
 <xmqqo7xlaw7z.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqo7xlaw7z.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 12:44 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> On 7/18/2022 3:35 PM, Junio C Hamano wrote:
>>> Derrick Stolee <derrickstolee@github.com> writes:
>>>
>>>> ... I think I should use "branches" here, but
>>>> keep the name "--update-refs". The biggest reason is that it provides
>>>> a nice parallel with the "update-ref" sequencer command. This command
>>>> allows updating _any_ ref, such as lightweight tags in refs/tags/*
>>>> or even refs in refs/my/namespace/*.
>>>>
>>>> The --update-refs option doesn't create the commands to update tags
>>>> or refs in places other than refs/heads/*.
>>>
>>> I guess it would make the choice of "branch" the most appropriate.
>>>
>>> I was hoping that we can repoint refs in private namespaces that are
>>> not branches with the option.  But as long as the underlying
>>> "update-ref" instruction can be used by advanced users, that is OK.
>>
>> I would like to keep the --update-refs name for a couple reasons:
> 
> I do not think anybody proposed to change the name of that option.
> 
> I was reacting to your "I should use branches here", with the
> understanding that "here" is this place where you used "local refs".
> 
>>> +		OPT_BOOL(0, "update-refs", &options.update_refs,
>>> +			 N_("update local refs that point to commits "
> 
> If "rebase --update-refs" uses "update-ref" insn (which is capable
> of repointing non-branch refs) only for local branches, then the
> help text for the "--update-refs" option can safely say "update
> local branches" without being inaccurate.  That is where my "branch
> is the most appropriate" comes from.

Thanks for the clarification. Sorry for misunderstanding.

Thanks,
-Stolee
