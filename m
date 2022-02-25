Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF95C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 02:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiBYC0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 21:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiBYC0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 21:26:38 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAEF1C664D
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 18:26:07 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id b7-20020a170902a9c700b0014fda723ad4so2172792plr.15
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 18:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VCrNH3SMr5MK/P1njEuinxkawix4w+8tdTBuuhsMqS4=;
        b=budgSoBVk/j18J9j5veywV8fFKxpnaVyshPBqCnRepmuR8GnrPHfAZAtiQjxFC7cuI
         EuZgxbSNnBZerirND10VlixlqkuNU2QJdYKBr32gB+WK/mZFx92+24v0FNhvdMz1OHyZ
         oZ/xAoyT/sQTTdatSuB+l1FUX8fVoRvEs4IC5pSPvHzIuyXP0i+shn1ttXSsc/g+U7of
         OaWAoUQqebunu8c7Gr1tVLDX2GpzDUZ65D1tKRcdyf98wi2eKYaEShnoklqcJKIXy6/+
         v+sf8O9GLLTWZJqXYl1xE0J8/ZrHwDzy7Ogmql89Jt/UtD0NN2D6FkaII/HOI13vLWI8
         amXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VCrNH3SMr5MK/P1njEuinxkawix4w+8tdTBuuhsMqS4=;
        b=Ssy/Rimaa1mfYadMLH4kIhkub50YZmL8h7kN8HdUK4EjKvEZOSZb6+9YAkuzsjle6F
         4UTlk+zEh50vaprQmbSLtSiH5kjXZwri+kKm3wYUEKRG59bzR/oOVQpNyf1peUcaYEww
         ur5W8NRbwf2dWuCbg+dapylaKIV5O66sS0ISJNoy52qUeFZqCsUX9K8/oRMobiQrjA17
         UoZGieDiX5vfZMzIqZwLdtpTKX8CuabDT8AFbPDo1eAkFCiKg9RKCx1Dz5NJZQz+Ua79
         L8zwS+Bv5osQJWvX6gcNDFxYBj2EY7VGNPAqZmUla8aIG5nSnJMze4Q448A7E4V+gIkD
         XEwQ==
X-Gm-Message-State: AOAM5303ET004tLXaJmvLpiuc8RRBPBJkJe1jRq1Ym4d48338MJB4Szs
        ZNM5zAqVA+5vEhI7slI3d2Lnm46u7AWQ5w==
X-Google-Smtp-Source: ABdhPJxMjo6LO/ed1JZhb9SNbTDQEsv2ITZCIxXIc3liTABDliveqRcngRpUNAporWYbGZGhtdoIoQ0A6KnTaw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4f43:b0:1bc:7e5c:e024 with SMTP
 id pj3-20020a17090b4f4300b001bc7e5ce024mr129020pjb.0.1645755966491; Thu, 24
 Feb 2022 18:26:06 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:26:04 +0800
In-Reply-To: <20220224230523.2877129-1-jonathantanmy@google.com>
Message-Id: <kl6lilt34r7n.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220224230523.2877129-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 02/10] t5526: stop asserting on stderr literally
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
>> index 0e93df1665..a3890e2f6c 100755
>> --- a/t/t5526-fetch-submodules.sh
>> +++ b/t/t5526-fetch-submodules.sh
>> @@ -13,6 +13,32 @@ export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
>>  
>>  pwd=$(pwd)
>>  
>> +check_sub() {
>> +	NEW_HEAD=$1 &&
>> +	cat <<-EOF >$pwd/expect.err.sub
>> +	Fetching submodule submodule
>> +	From $pwd/submodule
>> +	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
>> +	EOF
>> +}
>> +
>> +check_deep() {
>> +	NEW_HEAD=$1 &&
>> +	cat <<-EOF >$pwd/expect.err.deep
>> +	Fetching submodule submodule/subdir/deepsubmodule
>> +	From $pwd/deepsubmodule
>> +	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
>> +	EOF
>> +}
>> +
>> +check_super() {
>> +	NEW_HEAD=$1 &&
>> +	cat <<-EOF >$pwd/expect.err.super
>> +	From $pwd/.
>> +	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
>> +	EOF
>> +}
>
> These don't do any checking, but just write what's expected to a file.
> Could these be called something like write_sub_expected etc.?
>

Thanks for the suggestion! I was struggling with names.
