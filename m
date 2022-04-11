Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C54C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 13:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbiDKNmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 09:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346759AbiDKNmm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 09:42:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97907121
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:40:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p189so9925823wmp.3
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sWSYLELQj+6f4FTUu1tgX9wp+TlwBJnI3OU7q6GhLpo=;
        b=GdS+Zqfno8qTiuU8Pw+QHWsA1T3HR06HWETYwTFPV9XbSgNa6BtUf+NkhGq/OE6Ue+
         VmewbTvJ15e+kbJuUIH3dGt9Zsq56lt1r4KAW7LNZDKcUHZ5f572XxRG0t2GlpspGJdf
         WXDVRMmpr/7h7z7MRXd/U4bkT4YoCINzWvp3fhnn/XuRvcz/+IlxhJweQO1zPPLde4v+
         vqN0bgKDkrjukdJjQfF3qx5UVFjC9VYZtRHrQ1wkRIQtUCRizacTczgHKxtQaDe39Eqs
         ojGRW3/bQq0X7wgDmfKvKhPzaaqq48HFIAdY73zBeY159pO0lu1ka80HGw7tWO5jOrXW
         KwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sWSYLELQj+6f4FTUu1tgX9wp+TlwBJnI3OU7q6GhLpo=;
        b=rKlIrvPjIbH9Ae+oGxPa7YawL4DvoBwpwbGaPSyEC5dhARlcSoHR3jr615dCjauVNI
         HnxWv5KUHSpdxXCVyV7OsEAvtuqmy1/e4pQmt7ZHxQKtJ/Bj+s4zSYl3ekOyR0oWZz58
         2fKeD8d3/fVXhCwsqaaUzq1j5MHRY+qyT4k5x6BP5uu248trkCh9HBhFCaN/DCQhHdZz
         3CKgkcatEKdBeBdiFquw6apA6TuJaiXdtDWbB4h9RYOguyM13YkxL+i5Gb+3+t6ev1+q
         YuYhykXCoClIkL5Yw6CzufmN3vjfq+nyd1cd5fMebu0PTJ8XQbyyW9HhDL9qdxfiOVFU
         zeCg==
X-Gm-Message-State: AOAM533qOKSlfP6a/Rm7na9NqXVbwG6dedGs43bWHDwZoYt6kRs0V4Be
        4tl8k2Cis7Z3Dyb+6V2St4k=
X-Google-Smtp-Source: ABdhPJwiLmKe45C7c75q2alIF6Zt4urvrbl4FuQnFwu1tPh5U0Rq5gpK/yHCYsUskBIGwEoeAS3d4A==
X-Received: by 2002:a05:600c:4e87:b0:38e:ada5:5c6f with SMTP id f7-20020a05600c4e8700b0038eada55c6fmr11332772wmq.21.1649684426174;
        Mon, 11 Apr 2022 06:40:26 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6488000000b002051f1028f6sm31050186wri.111.2022.04.11.06.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:40:25 -0700 (PDT)
Message-ID: <9e5495d0-c117-2242-6718-46042e9664bf@gmail.com>
Date:   Mon, 11 Apr 2022 14:40:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 3/6] dir-iterator: refactor dir_iterator_advance()
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Plato Kiorpelidis <kioplato@gmail.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        mhagger@alum.mit.edu
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-4-kioplato@gmail.com>
 <220411.86o817j2dt.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220411.86o817j2dt.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04/2022 12:11, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Apr 10 2022, Plato Kiorpelidis wrote:
> 
>> +
>> +	errno = 0;
>> +	dir_entry = readdir(level->dir);
>>   
>> -		strbuf_setlen(&iter->base.path, level->prefix_len);
>> -		errno = 0;
>> -		de = readdir(level->dir);
>> -
>> -		if (!de) {
>> -			if (errno) {
>> -				warning_errno("error reading directory '%s'",
>> -					      iter->base.path.buf);
>> -				if (iter->flags & DIR_ITERATOR_PEDANTIC)
>> -					goto error_out;
>> -			} else if (pop_level(iter) == 0) {
>> +	if (dir_entry == NULL) {
> 
> Don't compare against NULL, use !dir_entry.
> 
> Also: Manually resetting "errno" before isn't needed. It will be (re)set
> if readdir() returns NULL().

That's not what the man page says

     If the end of the directory stream is reached, NULL is returned 

     and errno is not changed.  If an error occurs, NULL is returned 

     and errno is set to indicate the error.  To distinguish end of 

     stream from an error, set errno to zero before calling readdir() 

     and then check the value of errno if NULL is returned. 


Best Wishes

Phillip

