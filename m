Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C83C01F453
	for <e@80x24.org>; Sun, 27 Jan 2019 22:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfA0Wum (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 17:50:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51813 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfA0Wum (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 17:50:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so12059277wmj.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 14:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=idCnN+zm3ZOG6owKSMDv6IguVTtSK/aPaQyMtEva+0E=;
        b=FPjg5ZEkwEBSLIhYhKSArxj1/ZfZcdlkkwF5kv1IHIp3sV8klUGOk081lZtSkPRojU
         YRr/HPyXx1aGFmrNi4UahBThuzO/rHGoPBam4iMhWMLZoQBRmJ0QZAF+n8UTdim+zJf0
         d/zmhUrrdDspp1Tz+7OgKzvMzILmv/JoKPcsl55mKYGpYggk9uxueT5naFsIHHxR567X
         XnyKi0USiiRtvlUp+5ukZFhAa+oL4dEC2pAoLZ8WuWtGTnouR+np/egAxbGKFOqKRHkJ
         ZyHF41OfzPHYLUcxjftTgtVNEq+7vMtqPXSqBjg3oGR9hf5wa1zhwkfBCwxRDT83rBeB
         3nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=idCnN+zm3ZOG6owKSMDv6IguVTtSK/aPaQyMtEva+0E=;
        b=DhInlKDJ/ISeYPCnvsG9hvg/IBij0fy0uXmoMmtRD2U6jJI9lCiUiODyL4Ywwc9Ytn
         OEfhzQYlzM5EVC17VN6q32t8fgLpPpfVOXwiBK4n3IIjhXkw0hbYqAJuU9mLuEYBON9/
         g96oMLsIBJXFfyWdTI0uedCnPfJIO/b6jJ+9wd5bwlsKagWhkB7fuqIfF+fNlrAspILq
         ME2z7hPvQG/TQGIMltyByL2H/Fn2zqP7TFNqA5Big/08dHrSL76y9sfCEwqZslsRKlBH
         eOKURqhCjCirFZuRLnWdPUROiCxYz3zhgSU3Kbfih+nFOBViC7nzeUibWidD5pTZYa2r
         grMA==
X-Gm-Message-State: AJcUukdct1o4yp2zHyPfXyXlQbQHz/9AtKEA2x/rfFix3S7Miw0OMRli
        32XXQg8nVsq3qiRYKJXar9o=
X-Google-Smtp-Source: ALg8bN75nhNmEc5VBXhWxM78S1E5Zxj9LUNERw7HNxjYdEMnh0tu67EGLzBbw4lWXDUPOGZbW2GsOQ==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr14570986wmf.22.1548629441022;
        Sun, 27 Jan 2019 14:50:41 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l20sm241665550wrb.93.2019.01.27.14.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 14:50:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v4 08/10] midx: implement midx_repack()
References: <pull.92.v3.git.gitgitgadget@gmail.com>
        <pull.92.v4.git.gitgitgadget@gmail.com>
        <ba1a1c7bbbdbd8f3b82187763df4ec21b7032fb5.1548366713.git.gitgitgadget@gmail.com>
        <2970aa83-40cd-e721-af4c-a27798995eab@gmail.com>
Date:   Sun, 27 Jan 2019 14:50:39 -0800
In-Reply-To: <2970aa83-40cd-e721-af4c-a27798995eab@gmail.com> (Derrick
        Stolee's message of "Sat, 26 Jan 2019 12:10:01 -0500")
Message-ID: <xmqqwompemv4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 1/24/2019 4:52 PM, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>> index acc5e65ecc..d6c1353514 100755
>> --- a/t/t5319-multi-pack-index.sh
>> +++ b/t/t5319-multi-pack-index.sh
>> @@ -383,7 +383,8 @@ test_expect_success 'setup expire tests' '
>>   		git pack-objects --revs .git/objects/pack/pack-E <<-EOF &&
>>   		refs/heads/E
>>   		EOF
>> -		git multi-pack-index write
>> +		git multi-pack-index write &&
>> +		cp -r .git/objects/pack .git/objects/pack-backup
>>   	)
>>   '
>
> Josh: Thanks for catching the failure in PATCH 7. It's due to this
> line that should be part of that commit, not this one.

Will move the hunk while queuing.  Thanks, both.
