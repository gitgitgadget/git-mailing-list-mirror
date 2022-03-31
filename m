Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18A5C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 23:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243180AbiCaX72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 19:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiCaX71 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 19:59:27 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7E1238D17
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 16:57:39 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b7-20020aa79507000000b004fa88200f15so544452pfp.14
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fVzGS9FlpRr421KsLaAq2p7kry7vMVt2HMUrFVu01cw=;
        b=H0xMuvF3brUFUkFc9KXGyVAqm1Nzcvu61TZliNIB6N56gMKXixJOs2jgpMN2DEDdJT
         NmNg0XdRrOiVd1EH0Yn4EWARRg+JDG7c3GIGVdS3M0CHB35iavcCNgchFtMcnCSv9nc3
         9jHV4ca/5WxeLtUwXzi2YzAGKSOcse8hPXGCwg7c+w6MySatKSNKcG1+sFtz381xmVU+
         9v0T56ntOq80H5CPMUMVD6FMcrHAvsvk8NtbGloNa/8CkXlCblOl0M0zOBMX4l15qbmJ
         Vfxf/kJsJp/beGO5sj/TJXNtPTmxRl8ANsjGqUxXd6MqPcsuzJ/SNWacz+gsmYZetlwX
         9uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fVzGS9FlpRr421KsLaAq2p7kry7vMVt2HMUrFVu01cw=;
        b=4mcHBfcBrvZg9yYGTYOQWiN44uJMa9aJ2ZDvpEE8oJLFejXLDSK+dhdtlDoEbfuz4F
         kthXl4/N5ZLkZawwGV1H3n80Tt7vYotp2RjR2HqWRElQuBa63e5SaDmpBWhT8nO3Rw0q
         0DPIN4AuuHrcTEthvjJzUC6QHGxyXrOqwzIc5EyfelRBdg7m0nweDRR0ukFWLEC3/rSa
         dapXFkeUmJMihAErdpBuuFqMp8R95kZ0YcBGOFw6QJKZSoViItS8ZcoDY/TOpVE5f2Cu
         Boo2ZoSaJp+SbG+8/CtGGoyUYD2QZ5wuBm0xdyAybeSmQfnrjo2ESqI2RL3lO8stHvCA
         00VQ==
X-Gm-Message-State: AOAM533nqAqZhHWUAZ6zPxtd8jw2h9SDBEav+ne5VascFHpUS4nRFiwo
        UOZSOH72J3Br8njQdML3cXZterlXBAGRXg==
X-Google-Smtp-Source: ABdhPJxyDgbNEMua0wJZ/NZX0oKi/PhkqCQ4J8RA8ayQOb5wVXjrjRKh920J1KGa8qEyn3ztFr5X2uI3us6aJw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:a15:b0:4fb:4112:870e with SMTP
 id p21-20020a056a000a1500b004fb4112870emr7897241pfh.11.1648771058758; Thu, 31
 Mar 2022 16:57:38 -0700 (PDT)
Date:   Thu, 31 Mar 2022 16:57:36 -0700
In-Reply-To: <xmqqpmm13okb.fsf@gitster.g>
Message-Id: <kl6lsfqxsmj3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
 <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com> <xmqqpmm13okb.fsf@gitster.g>
Subject: Re: [PATCH v6] tracking branches: add advice to ambiguous refspec error
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  	if (!remote_find_tracking(remote, &tracking->spec)) {
>> -		if (++tracking->matches == 1) {
>> +		switch (++tracking->matches) {
>> +		case 1:
>>  			string_list_append(tracking->srcs, tracking->spec.src);
>>  			tracking->remote = remote->name;
>> -		} else {
>> +			break;
>> +		case 2:
>> +			/* there are at least two remotes; backfill the first one */
>> +			string_list_append(&ftb->ambiguous_remotes, tracking->spec.src);
>> +			/* fall through */
>> +		default:
>> +			string_list_append(&ftb->ambiguous_remotes, remote->name);
>>  			free(tracking->spec.src);
>>  			string_list_clear(tracking->srcs, 0);
>> +		break;
>
> Just to sanity check this part,
>
>  - During the first iteration, we append tracking->spec.src to
>    tracking->srcs, and set tracking->remote to remote->name;
>
>  - In later iterations, we do not want to touch tracking->srcs, and
>    want to collect remote->name.
>
> And "backfill" assumes that tracking->spec.src at that point in the
> second iteration is the same as what we got in remote->name in the
> first round.  If that were a correct assumption, then it is curious
> that the first iteration uses tracking->spec.src and remote->name
> separately for different purposes, which makes me want to double
> check if the assumption is indeed correct.
>
> If it were tracking->remote (which was assigned the value of
> remote->name during the first iteration) that is used to backfill
> before we append remote->name in the second iteration, I wouldn't
> find it "curious", but the use of tracking->spec.src there makes me
> feel confused.
>
> Thanks.

Thanks for bringing this up, I also found this unusual when I was
reading v5.
