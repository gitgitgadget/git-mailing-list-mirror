Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A73BC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D821C60F91
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhGZTRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:17:08 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:53341 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhGZTRI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 15:17:08 -0400
Received: from [84.163.73.49] (helo=[192.168.2.202])
        by smtprelay03.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m86jl-0000Ma-61; Mon, 26 Jul 2021 21:58:05 +0200
Subject: Re: Files modified, even after: git reset --hard
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de>
 <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
 <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de>
 <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
 <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de>
 <CAPx1GvdM7CzsbT1SWW9+OPcG9FL7WXQ7YD6aM7P0krujp_OrkQ@mail.gmail.com>
From:   Martin <git@mfriebe.de>
Message-ID: <67f35be7-3317-6486-cdb6-62eb691eaf10@mfriebe.de>
Date:   Mon, 26 Jul 2021 21:57:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPx1GvdM7CzsbT1SWW9+OPcG9FL7WXQ7YD6aM7P0krujp_OrkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/2021 04:59, Chris Torek wrote:
> On Sun, Jul 25, 2021 at 6:34 PM Martin <git@mfriebe.de> wrote:
>> Actually there is something else.
>>
>> If a file has line-endings that will change, then
>>      git add --renormalize .
>>      git commit -m foo
>> will commit those files.
>>
>> But I am now also getting files, that show modified, but that can not be
>> committed renormalized (0 lines changed).
> 
> I believe (but can't demonstrate) that this is a temporary condition.
> 
> Git has a number of cheats to make `git status` and other ops fast.
> These cheats *assume* that the committed files, the index copies
> of files, and the working tree copies of files all agree in terms of
> line endings as coordinated through `core.autocrlf` and `.gitattributes`
> settings.
> 
> When they *don't* agree, you get phantom differences.  Running
> commands like `git diff` show no differences because of these
> phantom states.  Eventually this clears up on its own when the
> cheats really *do* agree with the settings.  Changing the settings
> is what disturbs the cheats.
> 

Is it possible that those cheats also look at the "replaced" (rather 
than the "replacement") commit(s)?

I am pretty sure I have "git replace"d all blobs for some of the files, 
and yet they do get phantoms.


