Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B2C2BB55
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 14:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE7D20732
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 14:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0wKTPbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633794AbgDOOO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636464AbgDOOOR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 10:14:17 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7C0C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 07:14:17 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id d7so8505838oif.9
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 07:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EgA0pu2RDHc9LfjKXYKUnF0y5Jk0tPnHl3cohH1J+JA=;
        b=B0wKTPbWfFadDiHG3zeQrNbQfNdN2q9gKlxuG/yzLNZ3Z2M0kNth2d721XRV9Jbejx
         33l1oVDWH02in2HydGX5kZKpPwfKEW7Vr8jaX3RV9c5Cn0x6XyNYPcw7Fk6eZDPoyN3I
         SB5ZKQyxuPR885edNtWUWFXGjm8WQAQGIAk+tNAiaURDlRxbOYhVz7JZoCuNq7dRflZR
         FEFPneKoD/lVzPPu41y96idNocpMAAy2rjMaE87dGc1CgO8Qvm7YBbVhUULjaEzrZUti
         VSmJrMkjYb6PKn7DkQ0x2IoUgwIy8zqIWRjFtDE/wUcKrgzmCzYRrqoBjv3817eNI9Ay
         JfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EgA0pu2RDHc9LfjKXYKUnF0y5Jk0tPnHl3cohH1J+JA=;
        b=jKTu7FdMCS29Nz2reeHj0Xe06+Z/sGU61mAexkoTNVvSGO7qYBEfvyaTVv3OISMZLv
         Q1jQxguhfDHP5cibyO8+HHx1XQ8mcPQeyJ3SYNYWmmk2H+ddZWoFSWvwiOPOFxtRQxWW
         FGbbWbTmsv4fQf/Ib0X5pjaKwcPxZzVu5FXmIaDxxgHs23MJ2jmc1juQm+wOsTj9CIRu
         BGfNk1z5g0vgzSl4SdPwdx1fqmLxarVfskuTnnGLFT/MiHz6L0DWtJmh79MvPYMRfGx6
         u3Z1PR50AK1OUcTOiaPAlU6aFxEu1fZzIbk1B6wOXl1Ujs+KU6hnNP1HzfbYmWq9kWjY
         X6CQ==
X-Gm-Message-State: AGi0Puapl5tthz2ZSvXmletPWeVU+qU3BPKp/OGOYgQuyVpZzIDGgZgK
        Doqldb5Va/1q54oZMCoDa4w=
X-Google-Smtp-Source: APiQypKGQfU+eMu9HU1C19Qw7L7jfiyKYHDC7kB21YGEtnWOpUAYJvwwQ8cCFvCWgoKEHf8iQ2o76Q==
X-Received: by 2002:aca:4542:: with SMTP id s63mr18283979oia.84.1586960056611;
        Wed, 15 Apr 2020 07:14:16 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q12sm6272869otn.43.2020.04.15.07.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 07:14:15 -0700 (PDT)
Subject: Re: [PATCH] log: add log.excludeDecoration config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sluongng@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.610.git.1586791720114.gitgitgadget@gmail.com>
 <xmqqeesq9e8p.fsf@gitster.c.googlers.com>
 <5c8cd2dc-f1e2-5c93-094c-e15e45e8543e@gmail.com>
 <xmqqtv1m7xc5.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <707d61f5-02fe-73a9-0719-d7eece4669b4@gmail.com>
Date:   Wed, 15 Apr 2020 10:14:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqtv1m7xc5.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2020 2:10 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>>  * Given that we have command line options to specify what patterns
>>>    to include as well as to exclude, it feels somewhat asymmetric to
>>>    have only the configuration to exclude.  Should we also have a
>>>    configuration for including?
>>
>> I left the other side out for simplicity and because I didn't know
>> the use case. It seems all refs are included by default.
> 
> It is a bit more subtle than that.  
> 
> Once you have an inclusion pattern, nothing is included by default.
> Only the ones that match an inclusion pattern would be considered.
> When there is no inclusion pattern, we behave as if there is a
> match-all inclusion pattern.

I did a quick check to verify how things currently work with
this diff:

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index b5de449e51..e9c9e59461 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -742,8 +742,24 @@ test_expect_success 'decorate-refs with glob' '
        octopus-a (octopus-a)
        reach
        EOF
+       cat >expect.no-decorate <<-\EOF &&
+       Merge-tag-reach
+       Merge-tags-octopus-a-and-octopus-b
+       seventh
+       octopus-b
+       octopus-a
+       reach
+       EOF
        git log -n6 --decorate=short --pretty="tformat:%f%d" \
                --decorate-refs="heads/octopus*" >actual &&
+       test_cmp expect.decorate actual &&
+       git log -n6 --decorate=short --pretty="tformat:%f%d" \
+               --decorate-refs-exclude="heads/octopus*" \
+               --decorate-refs="heads/octopus*" >actual &&
+       test_cmp expect.no-decorate actual &&
+       git -c log.excludeDecoration="heads/octopus*" log \
+               -n6 --decorate=short --pretty="tformat:%f%d" \
+               --decorate-refs="heads/octopus*" >actual &&
        test_cmp expect.decorate actual
 '

This test fails at the last test_cmp with the current
patch.

Note that if we have both --decorate-refs-exclude=X and
--decorate-refs=X, then the exclusion wins. This means that
we will need to split the "configured" exclusions from the
"command-line" exclusions and give them different priority.

But, I believe that if we can get this test to pass, then
we will have the correct inclusion/exclusion logic. I will
get started on this right now.

Thanks,
-Stolee
