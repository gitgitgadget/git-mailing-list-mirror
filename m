Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09949C2BB1D
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 11:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33062073C
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 11:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9sP2ykr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgCQLtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:49:12 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41351 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgCQLtL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 07:49:11 -0400
Received: by mail-ot1-f46.google.com with SMTP id s15so21281383otq.8
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 04:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ReJvJcQzwLyXvZXTKHpSMEb26Djwg/K4/v10MWvJMJ8=;
        b=S9sP2ykrgmkV1dDdFreyXlZUx9fMPAGll9wyyKF89jMsz8YnyIcA78UqK8RP7M56YJ
         967u0fvFkHN0J1Vkn/RzQxRvhrvWHfblrKEnF9EL+UtuUHVYMuzKmTAw2I0sMjBotYxE
         wACrS6rzezu79pVq2DuNzkK3NL4W+GPkP1VfTkDo+U865bh56ydSV7a5rdcT2L6F4tow
         yDMl18alGixgIt6ipWgy8uWu3rYfAM2QK1yWfoP3SwVO9Mva3Auo4/rNH2faufpwe8hH
         shqWQZNjF7wMiQ8Kzodvg4uSg2bfHybxu+LhJsMQlrWNIrCqr/qZdDVO+iCn3KYlCEpB
         DNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ReJvJcQzwLyXvZXTKHpSMEb26Djwg/K4/v10MWvJMJ8=;
        b=HseQpheXEsggXOUbynYdRiohlCxL02Hdthl9JxLKYmNPlJdSSMDSprEGwPWgu3l77K
         jOcOpDPPGBCnDLGUt7Q0IiqEDrTrKTdIy00GrDemziseDR+kwwFEdCRnWpCOArD6lIZQ
         s2a+loxyOPUU0kA2RXaTSWHvTjz+Sh82OEh/ZfeBc6vVOv5XKn8U0jO4H8Gbqw/B424v
         fu1Ha+hpT7LKl1kTMfZH0frCci2mCUaVJw7x+CrpV52+p32kgaPZE008mNVhp0UcnLiN
         QjqcTx81kX1kiL9yu71HNAgu/Tph7nKlc3n7UjqpEiJpP4D9NmAok27vp4N283imsbRb
         RPQQ==
X-Gm-Message-State: ANhLgQ3mj7/qBz1FVzfd4cpAS3T1djB8bVgDaRmty2BoALXTzTql4BqK
        Xx5QhW2kQgybQLFoy4VdJdQ=
X-Google-Smtp-Source: ADFU+vsYQMl7KUOV8bsBydM5QEUK6ccfTaLlxAQ3gXXA6lBJAydt7aD8k4DU32gTqP+OKQNlVSF9Ug==
X-Received: by 2002:a05:6830:456:: with SMTP id d22mr3203091otc.138.1584445751009;
        Tue, 17 Mar 2020 04:49:11 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id c21sm973727oiy.11.2020.03.17.04.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 04:49:10 -0700 (PDT)
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     Christian Couder <christian.couder@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>
Cc:     git <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <86mu8o8dsf.fsf@gmail.com>
 <7d6a84c7-6b16-c2a9-11a1-3397422064d1@gmail.com> <86d09b7jx6.fsf@gmail.com>
 <CAP8UFD3BeS8bj8OGKJmVyKeDTCvqhCpBxLhTwuQ3zffejQkj7g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d1572a9f-e665-f417-c6ee-28bc8d88d60c@gmail.com>
Date:   Tue, 17 Mar 2020 07:49:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3BeS8bj8OGKJmVyKeDTCvqhCpBxLhTwuQ3zffejQkj7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2020 3:24 AM, Christian Couder wrote:
> On Tue, Mar 17, 2020 at 4:13 AM Jakub Narebski <jnareb@gmail.com> wrote:
> It could be part of your research project though, to check if that
> approach is better or good enough compared to what you suggest in the
> current version of your project.
> 
>> Would you agree, Stolee, to be a _possible_ mentor or co-mentor for
>> "Generation number v2" project?
> 
> At this point I think it might be best if you are both willing to
> co-mentor a "moonshot" / research project to find what is the best way
> forward by bench-marking the different approaches that you both
> suggest for different commands/use cases.
 
If a student wants to take this on with the full expectation that they
will mostly be doing research and gathering data which _might_ result
in an acceptable patch, then I could co-mentor.

With that expectation in mind, this project becomes closer to an REU
(Research Experience for Undergraduates) than a software engineering
internship. Are we sure that fits into GSoC?

Thanks,
-Stolee
