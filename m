Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E0CC433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 13:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiCRNHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiCRNHo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 09:07:44 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5679A2986D2
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 06:06:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d15so5647961qty.8
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 06:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MgLNH4XDJVqTadbJC0EggaX2Iacz1gmfJctWx4IOC0s=;
        b=ith3E09wha/z/34l4VlVvr1mlgIxAg0jQnWqEtPBwXeFKU2uoqSLZGTsGsxE0WtIv6
         GqCKqcBK6oz7/VSW9zxt7XGKb9i6viRwM4NVz11LAjpKB5UWE76Ai1NnInY07xVVzXm8
         rHGQ63DY7UWFQ3DJhGk8hTJ7taoVYoEeWLV2Z//ekME/Nq1zv4g7WYnwafD3mgIJNx/Y
         3RwivAJQNBo43KsZqTO/yWtc4sNpz6v5wTOp8smLx2Phyv7cId4RV0HQX0BGM1G1rT8g
         L9elmwuGwXfmZsdFCjsHXDXyAcGTpiBnJyKAHBZwBYygsE9hFY8GaNhAb7uq/8BKqZrd
         g4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MgLNH4XDJVqTadbJC0EggaX2Iacz1gmfJctWx4IOC0s=;
        b=j2rwPftHiQgvRRqxRbTLdNL6lntzE0NsVoMl7vLwfSeQVuFOURQ+YdvB7kGjz1Tg5G
         nkjaWc/50LRoK6LbiJBKaaBHF/1NzDlrhH4V527mK3wPrTMxcmq6sgejEROJ5mS3p9LH
         DXG58xV7b0ERJepSofC257WAjSC5Y83la//LbhBAhfuu54Gh3aMAVdeB7UXW5EFLYJvx
         3dTh6+RTMf41MoryoKLxg9PPApqUzHlNMI+kC2Oj5Nio9pD2i8wEq9InIreOFLcg87X4
         YLIU9++v3rfYPBY8oNIxJIWURtTX1T8zbKRy9/yiklQ/kAo2cyIscJjgBxJN+U23Y0Yx
         xFuQ==
X-Gm-Message-State: AOAM531oEsMwuOER1FyGDxdyQYvkkOukkK7PDpCV39332S3IlxMAWWpW
        GRCWMaK0Uix4NV85KB3Q20A=
X-Google-Smtp-Source: ABdhPJzT+HsnQiGXH10bZlmlGkw9MZD7KABjrXSLsidplxR/aWVuCuqubhFEZkPRaS43gkzIADcBnA==
X-Received: by 2002:a05:622a:c:b0:2e1:c5fc:c8d9 with SMTP id x12-20020a05622a000c00b002e1c5fcc8d9mr7292276qtw.587.1647608785327;
        Fri, 18 Mar 2022 06:06:25 -0700 (PDT)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id d2-20020ac85ac2000000b002e1cc2d363asm5596763qtd.24.2022.03.18.06.06.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:06:24 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 2/3] rebase: use test_commit helper in setup
Date:   Fri, 18 Mar 2022 09:06:23 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <11678816-1524-401C-9AFB-813866BB94F2@gmail.com>
In-Reply-To: <7f76e3e3-20d5-d249-c376-962dcc73869f@gmail.com>
References: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
 <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
 <5c40e116eba00b5b1a64191c6adf211d326e7f96.1647546828.git.gitgitgadget@gmail.com>
 <7f76e3e3-20d5-d249-c376-962dcc73869f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 18 Mar 2022, at 7:14, Phillip Wood wrote:

> Hi John
>
> On 17/03/2022 19:53, John Cai via GitGitGadget wrote:
>> From: John Cai <johncai86@gmail.com>
>>
>> To prepare for the next commit that will test rebase with oids instead=

>> of branch names, update the rebase setup test to add a couple of tags =
we
>> can use. This uses the test_commit helper so we can replace some lines=

>> that add a commit manually.
>>
>> Setting logAllRefUpdates is not necessary because it's on by default f=
or
>> repositories with a working tree.
>>
>> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>   t/t3400-rebase.sh | 18 ++++--------------
>>   1 file changed, 4 insertions(+), 14 deletions(-)
>>
>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index 5c4073f06d6..2fb3fabe60e 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -18,10 +18,7 @@ GIT_AUTHOR_EMAIL=3Dbogus@email@address
>>   export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
>>    test_expect_success 'prepare repository with topic branches' '
>> -	git config core.logAllRefUpdates true &&
>> -	echo First >A &&
>> -	git update-index --add A &&
>> -	git commit -m "Add A." &&
>> +	test_commit "Add A." A First First &&
>>   	git checkout -b force-3way &&
>>   	echo Dummy >Y &&
>>   	git update-index --add Y &&
>> @@ -32,17 +29,13 @@ test_expect_success 'prepare repository with topic=
 branches' '
>>   	git mv A D/A &&
>>   	git commit -m "Move A." &&
>>   	git checkout -b my-topic-branch main &&
>> -	echo Second >B &&
>> -	git update-index --add B &&
>> -	git commit -m "Add B." &&
>> +	test_commit "Add B." B Second Second &&
>>   	git checkout -f main &&
>>   	echo Third >>A &&
>>   	git update-index A &&
>>   	git commit -m "Modify A." &&
>>   	git checkout -b side my-topic-branch &&
>
> This version has added some more conversions that are not mentioned it =
the commit message. If you want to covert the whole setup to use test_com=
mit then that's great but I think you need to do the whole thing and say =
in the commit message that you're modernizing everything. As it stands a =
reader is left wondering why some of the setup that is not used in the ne=
xt commit  has been converted but other bits such as the "Modify A." abov=
e are left as is. I think the two possibilities that make sense are (a) c=
onvert only what we need for the next commit, or (b) modernize the test a=
nd convert everything.

I see your point. Then for the sake of a smaller series for the patch, I'=
ll opt
to only update the parts we need. Then maybe we can have a separate serie=
s to
modernize this suite.

I'll re-roll this series with the clarifications to the commit message th=
at
Junio made.

>
> Best Wishes
>
> Phillip

Thanks!
John

>
>> -	echo Side >>C &&
>> -	git add C &&
>> -	git commit -m "Add C" &&
>> +	test_commit --no-tag "Add C" C Side &&
>>   	git checkout -f my-topic-branch &&
>>   	git tag topic
>>   '
>> @@ -119,10 +112,7 @@ test_expect_success 'rebase off of the previous b=
ranch using "-"' '
>>   test_expect_success 'rebase a single mode change' '
>>   	git checkout main &&
>>   	git branch -D topic &&
>> -	echo 1 >X &&
>> -	git add X &&
>> -	test_tick &&
>> -	git commit -m prepare &&
>> +	test_commit prepare X 1 &&
>>   	git checkout -b modechange HEAD^ &&
>>   	echo 1 >X &&
>>   	git add X &&
