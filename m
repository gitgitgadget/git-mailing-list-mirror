Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0414CC2BB1D
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 12:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE995206EC
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 12:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HODLEG//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQMZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:25:23 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41273 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgCQMZX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 08:25:23 -0400
Received: by mail-pf1-f180.google.com with SMTP id z65so11861519pfz.8
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wJS9z5nLWMVfxVNY8ue4FUvM3prTe+G+2Zjdfs1oUkw=;
        b=HODLEG//BdPerhCLW1RhX/YjsXczuM+kIZfYUJLo1eMDiSEXFqvwD0aXUyoJ505m91
         ukE3OOMJS/KTjg+y88E48ZhhFpODVk0d0ErOnlmp8e7DTjkPAe1bPMVqNu+e3cHf3kzt
         uOalIGX1CjHE7mAvx2uMADaRz3EwCEzxpHnMfP1eDYlU6kpYr1JBW+NTxKm08GHnfPIo
         mZZI9pHRcXpNDvOJ9k0QcZof6XafFg7QtVO6BR/hZfzdJcRRqX0+aYrkzuG7FqmSKXfN
         jJjUw3KLrU398/CnzQxRfYNxWnmNMRrFFpPKpna69HZt/11c6nKZBTBpE8IWYHh33wi4
         qqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wJS9z5nLWMVfxVNY8ue4FUvM3prTe+G+2Zjdfs1oUkw=;
        b=fw6zCzhc/sl1qk8TC7wo6X0FZ7UgcDgzJw0n5KIOrLGtckLvbNtkFViDY3YEJuTbTX
         C2gBJ8P3GsGwYsl5WxG8rUd26s6B/UIZitYObz+NEltQho1J9nu+taBQm9MPYcYMEKvq
         NpgPQSRNEYosA+M7kAz1tjZYIYZBDhBTHjeu5w5nUDppMTgGZxZAhWvORDrEzvHfte3c
         KbOCWJyVFwqVb7xw6FCFElHyCsnq6Tq/C/BEcuKdLqfyMp0rfv36HGJtBToniG4/6+TQ
         zB6yZcpq3VR249409DM3PDc0S+FdK7LdHx8P59MmlQdATprj8wlYq/5Bw0Xk5mCFQ3f9
         rnQA==
X-Gm-Message-State: ANhLgQ2AOvra6qVyWu19huvKhQ9oKmmfmhc/6ZgWPZqDq7X6aBgSD0+4
        hroSdj3/r2KHrj7xKTL6pbk=
X-Google-Smtp-Source: ADFU+vsMwuF67SeesDFNdRK+HmGTYxJSNb2e9rYtSyj9qSlJtzvRXVUa57nnrREtzHogY61QyFr3BA==
X-Received: by 2002:aa7:94a5:: with SMTP id a5mr5024318pfl.67.1584447922220;
        Tue, 17 Mar 2020 05:25:22 -0700 (PDT)
Received: from [192.168.43.191] ([223.181.211.23])
        by smtp.gmail.com with ESMTPSA id g5sm3131671pfo.192.2020.03.17.05.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 05:25:21 -0700 (PDT)
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     Jakub Narebski <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <86mu8o8dsf.fsf@gmail.com>
 <xmqqo8t2hfxj.fsf@gitster.c.googlers.com> <86tv2s34lo.fsf@gmail.com>
 <86zhch7kyz.fsf@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <d1a4998d-039f-65da-f18b-12ec714ec532@gmail.com>
Date:   Tue, 17 Mar 2020 17:54:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <86zhch7kyz.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jakub,

On 15-03-2020 19:56, Jakub Narebski wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>>
>> I have prepared slides for "Graph operations in Git version control
>> system" (PDF), mainly describing what was already done to improve their
>> performance, but they also include a few thoughts about the future (like
>> additional graph reachability labelings)... unfortunately the slides are
>> in Polish, not in English.
>>
>> If there is interest, I could translate them, and put the result
>> somewhere accessible.
> 
> Here it is, traanslated into English, but otherwise almost exactly as I
> have presented it on December 2019.  Those slides includes much of
> introductory information, so one would be interested probably in few
> last slides (the "Future work" section).
> 
>    https://drive.google.com/file/d/1psMBVfcRHcZeJ7AewGpdoymrEfFVdXoK/view?usp=sharing
> 
> I will be extending those slides with more information about interval
> labeling, and then I will update the file, and I can post it also on
> SlideShare (or other site, if one can recommend it).
>

Just wanted to note that Speaker deck[1] is a nice alternative to 
SlideShare. I've not uploaded slides to it but have seen people sharing 
slides using Speaker deck. I find the user interface to be more neat and 
minimalistic than SlideShare. FWIW, their mobile interface a lot better 
than the SlideShare's interface.

[1]: https://speakerdeck.com/

-- 
Sivaraam
