Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31522C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC2620759
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzH1YI/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbgIHQlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732027AbgIHQhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 12:37:25 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C64C061370
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 05:43:32 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cy2so7704869qvb.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=luTBGl+BaKZjOAy4Oj5DAmvDn/YGTMfg5RwEnb6iEnQ=;
        b=bzH1YI/bq75ecRqJFiitS7NHkYcSGyNTYz/mmMUzQ+0+misu8XpSW8TfmiAey1ZqrE
         CWAxO4MO0D7X4WXldeQQscLU7sOCNMsC2UkjHiyh/XkeTSdRcDG2zm3nxo2br0OP8hru
         sxfWmZOkfyOTSozF9F9QWpwD30aLUPFhD4Rl+/acAAtaZsolf0Jo5g4gVffPjGtZB82j
         OWIgs5LJWMwzCu1PyQaKRd79mlSU8VpKoCRzDtEq8SIIiGdbCcNxoTaJ4EOMEB2Iz5KV
         VZ7PPsHfZiLSlw94NCA6qkYq/YrUxDLh/stCDSvpMEGRqNaiEovbm6VbiGZw2HiC65sF
         Vhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=luTBGl+BaKZjOAy4Oj5DAmvDn/YGTMfg5RwEnb6iEnQ=;
        b=WWR0ZWM8wsTK9geZVR3zJaYV/I3Z0Bwoo7JQAqH5Nde7pHeQtmajaASJdrCsdZY1Js
         oONUfD82RSn0LRHZc4SwHsmh4MNbGyfc/fr7Ql0X//2uMBbHpFS4K8Ppagnj9gj5rSdD
         Py2gS/6+EC+/zgFBIcWVNB33Gz1bla22KheGR9dS6hEWLtAH+QLxwQ7AnHKzQ9HR2+Vm
         JJIauYU+LYYBGz96QOWkNwDOiVNFkJDHsLEWkF1L3qaJCA9iyGUiuuUUjqKjHCB+v07a
         mdEBdQfedgfZ2R7tCa15DGI1wmp9LJug+97BWaJlGMtRqHCpPfCNAeTd5Zm3HW25Ms/X
         HTMw==
X-Gm-Message-State: AOAM532sCm++Vn1gkGOwW53oD2UUb0plBe6Du+IQOz1KpbqZWyYa6LCf
        7Jfj5sh8SevnHFgoAOVSXXA=
X-Google-Smtp-Source: ABdhPJxu5sZ6a8wg0+Ov3sR9tHhbRAjwe0AoN4oTDOP1qTrvbaXvx2rGRbiF0y/rQIGsFrqLZptCQA==
X-Received: by 2002:a0c:db8d:: with SMTP id m13mr24564460qvk.88.1599569011537;
        Tue, 08 Sep 2020 05:43:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3c51:b843:8beb:d4da? ([2600:1700:e72:80a0:3c51:b843:8beb:d4da])
        by smtp.gmail.com with ESMTPSA id f8sm10558225qtx.81.2020.09.08.05.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 05:43:30 -0700 (PDT)
Subject: Re: [PATCH 5/7] maintenance: add start/stop subcommands
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Todd Zullinger <tmz@pobox.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <e02641881d998d1e6a31e941b61eb6f89d0519f7.1599234127.git.gitgitgadget@gmail.com>
 <20200908062914.GC6209@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <50ae1298-b551-8a49-6821-0659012119ee@gmail.com>
Date:   Tue, 8 Sep 2020 08:43:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200908062914.GC6209@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2020 2:29 AM, SZEDER Gábor wrote:
> On Fri, Sep 04, 2020 at 03:42:04PM +0000, Derrick Stolee via GitGitGadget wrote:
>> +test_expect_success 'start from empty cron table' '
>> +	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
> 
> This command hangs when run on Travis CI's s390x arch.  Now, Travis
> CI's multi-arch support is labelled as an alpha feature and isn't
> exactly bug free, so Cc-ing Adrian and Todd, who reported and tested
> big-endian issues and fixes in the past, in the hope that they can
> confirm.

Sounds like you have found the issue below.

>> diff --git a/t/helper/test-crontab.c b/t/helper/test-crontab.c
>> new file mode 100644
>> index 0000000000..f5db6319c6
>> --- /dev/null
>> +++ b/t/helper/test-crontab.c
>> @@ -0,0 +1,35 @@
>> +#include "test-tool.h"
>> +#include "cache.h"
>> +
>> +/*
>> + * Usage: test-tool cron <file> [-l]
>> + *
>> + * If -l is specified, then write the contents of <file> to stdou.
> 
> s/stdou/stdout/

Thanks.

>> + * Otherwise, write from stdin into <file>.
>> + */
>> +int cmd__crontab(int argc, const char **argv)
>> +{
>> +	char a;
> 
> So 'a' is a char...
> 
>> +	FILE *from, *to;
>> +
>> +	if (argc == 3 && !strcmp(argv[2], "-l")) {
>> +		from = fopen(argv[1], "r");
>> +		if (!from)
>> +			return 0;
>> +		to = stdout;
>> +	} else if (argc == 2) {
>> +		from = stdin;
>> +		to = fopen(argv[1], "w");
>> +	} else
>> +		return error("unknown arguments");
>> +
>> +	while ((a = fgetc(from)) != EOF)
> 
> fgetc() returns an int, which is assigned to a char, which is then
> compared to whatever EOF might be on the platform.  Apparently this
> casting and comparison doesn't work as expected on s390x (I haven't
> even tried to think it through...), and instead of detecting EOF and
> exiting we end up in an endless loop writing 0xff bytes to 'cron.txt',
> while 'git maintenance start' in vain waits for 'test-crontab' to
> exit.
> 
> Changing the type of 'a' to int fixes this issue, and all these tests
> pass.

Thanks for the help here. I'll fix this in the next version.

-Stolee
