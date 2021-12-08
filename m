Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9CFC433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 15:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhLHPt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbhLHPt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:49:57 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5A7C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 07:46:25 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id t19so4677330oij.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 07:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8QHiN0hb7XziWCW76BnIzDQr/1LzA0z1fplOfdMNk0A=;
        b=G+1SXN5uBTEglkngtb4rtGlIlCP2KRfJ/p3rzNCAGO9BnZk8RA3X0YUDfoYzgqezCk
         yH0FfbJEENTLbv1Yar54fYprTPgg00LXZgs3gbhnFdzCXmTaBK/GVQZ40jidfl/PhSiG
         ffPZ7XC9O1WCXQSIBCmJCci8OoFxnwXXC0PTihMFRXv/W9xGCPHU+LHGl/OT9kt+wBW/
         4UakCPXaFJ/2t+/jmT6MomgHtt2yvOqOlZT+glsi69GgbaprpAEKd/bUnDifhbu9ysEH
         /WDy96ybMN40izrt+VtveBeL0mJ1M00UeZU11zL5q4XgMbl+L69OXzyV2Vyfn1zweUM1
         dBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8QHiN0hb7XziWCW76BnIzDQr/1LzA0z1fplOfdMNk0A=;
        b=615yYF+/2j4mb1E1EaOUCFFzNNDXO8wZqb0QPUpZlBiyXbEmsRZ84gw41La7RErLcY
         +AmxY9GifNAL4fVOGbDEZ7QY0OZk+PwayHH1plR1WUGQ9OJiaNfpUDrqYdeSBll1vTXA
         J80nds9divpYPWGUDC7tEIjy9ImPhGZdkwU4gEOAry681/n9Gn5KNnH7cQQaTs1NArVN
         k2zQLG4nXB5hPD8jvlAoV0Flr8dgNMbKBYmEXX8+zeN7PLIeM5xTM4xvtqgQcvn8QWuG
         XR1xsTE64xMW+uXTypPOwsf8HSSOSqpEkbzXu8V2hVoKEsniA4NkEzkYP3ocd7wAzZBG
         fKtA==
X-Gm-Message-State: AOAM532cmexnTOLR74NvESF4iMwHxwZOd6mExFoqSX2yrI0fJh5ZzuY1
        mvB/8aVTA97/nkRdwaosj90=
X-Google-Smtp-Source: ABdhPJyBcmPmKrtbVpTz+ACpdXYn9KOJIganF3u1lNjKaAHHhKy3eYUPl4L7QcdsqNkLDBxF0Zl3nA==
X-Received: by 2002:a05:6808:1389:: with SMTP id c9mr140522oiw.55.1638978384650;
        Wed, 08 Dec 2021 07:46:24 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id j187sm648743oih.5.2021.12.08.07.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 07:46:24 -0800 (PST)
Message-ID: <53695770-68b8-ab92-1c35-268953160076@gmail.com>
Date:   Wed, 8 Dec 2021 09:46:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v5 4/7] repo-settings: prepare_repo_settings only in git
 repos
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com, Taylor Blau <me@ttaylorr.com>
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
 <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
 <4d8d58c473b51cac6645a7d71336e995c1f3d28b.1638566165.git.gitgitgadget@gmail.com>
 <211207.86r1apow9f.gmgdl@evledraar.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <211207.86r1apow9f.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/6/21 8:43 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Dec 03 2021, Lessley Dennington via GitGitGadget wrote:
> 
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Check whether git directory exists before adding any repo settings. If it
>> does not exist, BUG with the message that one cannot add settings for an
>> uninitialized repository. If it does exist, proceed with adding repo
>> settings.
>>
>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>> ---
>>   repo-settings.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/repo-settings.c b/repo-settings.c
>> index b93e91a212e..00ca5571a1a 100644
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -17,6 +17,9 @@ void prepare_repo_settings(struct repository *r)
>>   	char *strval;
>>   	int manyfiles;
>>   
>> +	if (!r->gitdir)
>> +		BUG("Cannot add settings for uninitialized repository");
> 
> nit: start BUG(), error() etc. messages with lower-case.
> 
Thanks for catching this. Instead of re-sending the whole series for a
one-letter change, I've included a patch with the fix at the end of this
message.
>> +
>>   	if (r->settings.initialized++)
>>   		return;
> 
> Our config doesn't require us to have a repo, and most of what
> prepare_repo_settings() is doing is reading global config.
> 
> I think that *currently* this won't break things, but e.g. if we ever
> want to have "feature.experimental" or whatever change the behavior of a
> a command that doesn't require a repository we'd need to untangle this
> (currently everything it changes requires a repo AFAICT).
> 
> Perhaps this is fine, and if we ever need such a "global config" point
> we should stick it closer to common-main.c...
> 
Agreed, let's keep the change for now and address updates in the future if
the need arises.
-----------
 From 2764ca684320f488006093505deb074217ac7b31 Mon Sep 17 00:00:00 2001
From: Lessley Dennington <lessleydennington@gmail.com>
Date: Wed, 8 Dec 2021 09:29:56 -0600
Subject: [PATCH] fixup! repo-settings: prepare_repo_settings only in git repos

Update the BUG() message in prepare_repo_settings to begin with a
lower-case letter.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
  repo-settings.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/repo-settings.c b/repo-settings.c
index 00ca5571a1..2644ac3353 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -18,7 +18,7 @@ void prepare_repo_settings(struct repository *r)
         int manyfiles;

         if (!r->gitdir)
-               BUG("Cannot add settings for uninitialized repository");
+               BUG("cannot add settings for uninitialized repository");

         if (r->settings.initialized++)
                 return;
--
2.34.0.vfs.0.0
