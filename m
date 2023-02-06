Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B68C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 17:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBFRs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 12:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBFRsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 12:48:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE549EC5
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 09:48:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so9151163pjw.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 09:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oI4Iw1By8B4HUKm4Ksn7kD0Qfus72sCnFJMyhd+SAKs=;
        b=dXwZKjD33S2ysBP/IPCn8ZcSEi9U6aHl0kFpyHFO6JKiuuHQ3ssum/hMOWzhWgSg9g
         oFOhnROFQMbcTve/NmJEEGQeb3GTrSiR6asotRjflAza3mZ6BXltOKjyvjVJ6sqhKqK+
         O53zSbkiQU2/corscFk2IX9wVozPUkA6KaRVKygrryoS3p9QM8Qg3TKDQZjVkRGylU1m
         9a9B5iu0vei0b6rqsc5ambn0jpWmk6Qt1AkMZ5ePNr/vVHd16C0asc+OHi8mN7zX18EA
         vqhIA68cilkd2CSVhUevzWhk1QtkDU4OT8Itvq1npExHPN0+YRD9VyOfJt9NLAYFe37W
         Tr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oI4Iw1By8B4HUKm4Ksn7kD0Qfus72sCnFJMyhd+SAKs=;
        b=lKGJZbKdoX8/o8zC6FKaikOV0oyL00nlRmJstWRvzaWV1C09vMGOlXLV9QEpcYkMyf
         VssRXNEHGaaVY2aXY84hnDABOCGbkLPHJGkiwb0FgwJQceYTvsYIspjJPblymR/UrNW3
         ETdF4B2st7hYe6D5DeZia+5XAh4KMvpl4Y2UQS2Bd3ZZhdknUnABfw9hd3hLFKzYWaG0
         34ePMeNskQ72vqwsqiZTds8b91KmvJZ+TeoXs6BoCyD11PbGy2gBRgB9tFNNc42WdNdi
         4sKdbhHr23ROhydz2sbpZypnHcu7sX/eiKq1Pz/KdyAxuGNfBKzCVnN+PKF+5rMeb30o
         +zhQ==
X-Gm-Message-State: AO0yUKXW5WugPCDhNEna4jJvGkB7YhcvpaB7aAyKRpM1H2rKJQ+TyJ8m
        A39105Y1Qm0AIPbrf/MhYKw=
X-Google-Smtp-Source: AK7set8Yz/sled47O552fWQAuGgILmOTpWsE71RlmPJBbVd7nWQbGlqCj9OemaOwoH3PLCOWLkO9ig==
X-Received: by 2002:a05:6a20:8b9e:b0:b8:bc13:c838 with SMTP id m30-20020a056a208b9e00b000b8bc13c838mr19394537pzh.53.1675705702732;
        Mon, 06 Feb 2023 09:48:22 -0800 (PST)
Received: from [192.168.208.87] ([49.204.138.58])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902848500b001989fd048e4sm7185866plo.192.2023.02.06.09.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 09:48:22 -0800 (PST)
Message-ID: <38932e46-e00a-ec79-a1ff-72b7f257af98@gmail.com>
Date:   Mon, 6 Feb 2023 23:18:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: GSoC 2023
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
 <d8ce0159-c9dc-25c2-4180-70518bb31bfc@gmail.com>
 <CAP8UFD32nDLR8BrhmeTpyraX3QBrc=U1ody+qgyMVY+_-HrASA@mail.gmail.com>
 <b8f90d73-8c49-554c-1109-92d8713d1c29@github.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <b8f90d73-8c49-554c-1109-92d8713d1c29@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria and Taylor,

On 06/02/23 22:28, Victoria Dye wrote:
> Christian Couder wrote:
>> I removed the "Reachability bitmap improvements" idea but left the 2 others:
>>
>>    - More Sparse Index Integrations (I removed `git mv` in the list of
>> commands that need to be improved though)
>>    - Unify ref-filter formats with other pretty formats
>>
>> On both of them I removed all possible mentors except me though. They
>> are welcome to tell me that they should be added back.
>>
> 
> After mulling it over, I'd like to sign up as a mentor again this year for
> "More Sparse Index Integrations" - feel free to add me back to the
> application. AFAIK I'd be solo-mentoring for this project (although I'm
> happy to work with a co-mentor if anyone's interested!).
> 

Thank your for volunteering, Victoria! I've added you as a possible 
mentor for the project.

Taylor,
Since you expressed interest to be a co-mentor, would you be willing to 
co-mentor the project with Victoria ?

-- 
Sivaraam
