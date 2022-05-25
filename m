Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B9C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 13:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbiEYNj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 09:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244446AbiEYNj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 09:39:58 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB6634BBA
        for <git@vger.kernel.org>; Wed, 25 May 2022 06:39:55 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 14so11156139qkl.6
        for <git@vger.kernel.org>; Wed, 25 May 2022 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XxMk4vICnCJX/ECGpcsknYu54ungyywFHmln/uN4ZFQ=;
        b=aCASRzO/sU75cD4oYdPI+WWRS+xYVTbwBmrFdUj1H/Ynkmnem2LnpN0Q2UxtmMV/we
         JPK+qCJLmX8oQ0320W7v1vOlkvsuEy1AkpDrKdsY9LH8v3LO6RDb1ghFQbDr4lJdwi0o
         FermfDlXFeuNLVLxvBxsSQNsnJvz4jdqhsMAW4ex0OK3fkhfVw9nOfQNjdfdknEkt4SP
         sK6S2AfXcvQsJ4pSlhussbP/yXfQvKZ54ijLF52ZZ3TusYk1cOMEuCm10h3Z+pmutVO2
         hoAOx1DAn5nEsE8a6eBWxeVxBJpUIPXGIfLkANGRIzV8bXMWZ7sgO8XJFiKFbmVT1vxf
         +arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XxMk4vICnCJX/ECGpcsknYu54ungyywFHmln/uN4ZFQ=;
        b=U4GE0CpHFzXgaXZGEN5EpN293qQNu/yMO2ki/4QbbXkivL3DWCPTJB1eIRuiFNHgue
         C4+++LCDFJCl+uO0StzafhooFdF4Aa26T/1fqk0mHNddz1s9TVgM8z58QExM/nKdPXyk
         EGZvIdMLj4C88b6JROGDU87tFP5LakUXcvWjX57EEyxYJzL1niAe5E0OSgkOTxysJRmc
         5EtzjlYiSuZhNJuOzhddQ6qp2MoiQDzB3/gcH+wVLvVCedhZLQD73j3cBg/pA8Ons+9+
         ylTYEgin2SrG5ltrkp7bBVkUGN+vz0AagOklmLEWQEUTALi111+qpUKZCj21vDoYSLv3
         ZOIQ==
X-Gm-Message-State: AOAM531ANY/4L7G4ck/MF4cPcuL4jjQWt2DvycBfS281TQxoKoxM3Hh+
        M+9raIQHA3AVq64Mhj0dcRs4
X-Google-Smtp-Source: ABdhPJxPckF5BEKbIWm4IsQMUePHOe0ATguOwgcbu/NQBhwEDNvk/nTHYr7T25DVvtNWW5C6E/ur6A==
X-Received: by 2002:a05:620a:38c:b0:6a3:6039:cd72 with SMTP id q12-20020a05620a038c00b006a36039cd72mr14935147qkm.349.1653485994361;
        Wed, 25 May 2022 06:39:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b144:5f1c:7ca1:15fd? ([2600:1700:e72:80a0:b144:5f1c:7ca1:15fd])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a12bb00b0069fc13ce209sm1256551qki.58.2022.05.25.06.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 06:39:53 -0700 (PDT)
Message-ID: <d7ee0bf0-22bc-d494-2699-7075fc92f28a@github.com>
Date:   Wed, 25 May 2022 09:39:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/4] dir.c: avoid "exceeds maximum object size" error with
 GCC v12.x
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
 <365889ee96e37dc9dcbe60d98880eb256dae90ee.1653351786.git.gitgitgadget@gmail.com>
 <220524.86k0abxyqa.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2205242302020.352@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <nycvar.QRO.7.76.6.2205242302020.352@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/24/2022 5:05 PM, Johannes Schindelin wrote:> On Tue, 24 May 2022, Ævar Arnfjörð Bjarmason wrote:
>> On Tue, May 24 2022, Johannes Schindelin via GitGitGadget wrote:
>>> +	/*
>>> +	 * It should not be possible to overflow `ptrdiff_t` by passing in an
>>> +	 * insanely long URL, but GCC does not know that and will complain
>>> +	 * without this check.
>>> +	 */
>>> +	if (end - start < 0)
>>> +		die(_("No directory name could be guessed.\n"
>>
>> This should start with a lower-case letter, see CodingGuidelines.
> 
> This message is copied from existing code later in the same function.
> Since it is a translateable message, I do not want to edit it because that
> would cause unnecessary work of the translators. Especially given that we
> do not even expect this message to be shown, ever, but we only add this
> hunk for GCC's benefit.

Perhaps this should be a BUG() statement, then? Without any
translation?

Thanks,
-Stolee
