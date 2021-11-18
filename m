Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C29C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E76261458
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhKRWNE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhKRWNC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 17:13:02 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C941DC061748
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 14:10:01 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id m6so17492280oim.2
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 14:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6WwZSxRe2789xs5QuQRKpuuYxRRENDmkPzINo876PSw=;
        b=XS98Z/2+W04+jq1JfQb2wttC4QRefq5lVA5arN0ITJnEziCtRZtZ4jaRWd5DJY67L9
         etaoCyyynWSlnhjRYWSo/n5eAXl9myxVNMubElVRPhVPnH4XfVF/Sh4ZOeD1mEha1Y5+
         ZuXym9Ru3e9p/4nA6d6CvJQ8V1mTJ5vglVZ/9jEcUMAzpUrLzu2r3vAi5HKg+v60GvkS
         JcNpxsnJGv1Y0htTUhaI7O43k2K6RNK+UJ8NKNjxKQ1kPUnK82fHC2/vFI55hIALUj9V
         SEDNGay1uTa3M6kSalJYb/jIsMSnVT63SKl43Q2RNUfnv86zOaZUhlrzXrc8NflR6y9g
         8YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6WwZSxRe2789xs5QuQRKpuuYxRRENDmkPzINo876PSw=;
        b=6+I9CeV5Xv1FrtjQu7os1Z8QJe7Vg/AukCGSI/dBScEk0ByS5h4PHpLT52+DUZ8LxC
         +qxqRwfiip4mBscHYbraPsn9Jenia08PeltxrI/gSk3PkC5+VEcegna9aaH8IBpCj7DQ
         N1yv7h8j1ij09STgELPBBLutKGLIdgI7p1AUW65ylrLWCKFgWBtnG1KKKeLT00r7uENb
         9+KPTJz4YuSYKLATKuhNbDiU8+AzqmssxUWpWhjQJU+42F52N1vyufr1U9E/VZ8tmqgq
         JTbFELHu3dVDBhniEau+fPIswaPq6h0q5xEo4pfDuGv1mNIdRpl6SH1Fg9IyWoL8UKv3
         PoRQ==
X-Gm-Message-State: AOAM531TAiVagPOkw29ANpR1hlMOWACc+96ZP7AIP1g2ytjg3JK7cd30
        Thd70rYTm47AG1vbLAZJ4mw=
X-Google-Smtp-Source: ABdhPJziTW7elwBfyg8O4vy2ucxFj+M5yELcghxQHuNVakekhKYRmMPIQAIkYdrQiCc2fTnX/f48rA==
X-Received: by 2002:a05:6808:1a01:: with SMTP id bk1mr369064oib.46.1637273401103;
        Thu, 18 Nov 2021 14:10:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5dd4:8108:e3bb:dda9? ([2600:1700:e72:80a0:5dd4:8108:e3bb:dda9])
        by smtp.gmail.com with ESMTPSA id g5sm206660ooe.15.2021.11.18.14.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 14:10:00 -0800 (PST)
Message-ID: <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
Date:   Thu, 18 Nov 2021 17:09:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Danial Alihosseini <danial.alihosseini@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
 <YZaHpJKeyDEY8qKW@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YZaHpJKeyDEY8qKW@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2021 12:04 PM, Jeff King wrote:
> On Thu, Nov 18, 2021 at 08:11:04PM +0330, Danial Alihosseini wrote:
> 
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> Consider the following project structure
>> - data
>>   - data1
>>     - file1
>>     - file1.txt
>>   - data2
>>     - file2
>>     - file2.txt
>> - .gitignore
>>
>>
>> `.gitignore` is as follows:
>> ```
>> data/**
>> !data/**/
>> !data/**/*.txt
>> ```
>> What did you expect to happen? (Expected behavior)
>>
>> I expect all files in `data` folder to be ignored except `.txt` files.
>>
>> What happened instead? (Actual behavior)
>>
>> `file1` and `file2` are not ignored.
>> Here is the `check-ignore` output:
>> ```
>> $ git check-ignore -v data/data1/file1
>> .gitignore:2:!/data/**/ data/data1/file1
>> ```
> 
> Thanks for an easy reproduction. It looks like this changed in
> f6526728f9 (dir: select directories correctly, 2021-09-24). Author cc'd.

Thanks for the bisect and CC.

> The key thing seems to be that the second line of your .gitignore should
> match only directories (because of the trailing slash), but no longer
> does.

Doesn't "matching only directories" mean it would match everything
within that directory? (It also means that "data/file" is not matched,
which is still correct.)

My interpretation of these patterns is that everything in data/data1/
and data/data2/ should not be ignored, making it seem like the change
fixed a bug (it definitely changed behavior).

Just for extra clarity, this test currently passes:

test_expect_success 'directories and ** matches' '
	cat >.gitignore <<-\EOF &&
	data/**
	!data/**/
	!data/**/*.txt
	EOF
	git check-ignore file \
		data/file data/data1/file1 data/data1/file1.txt \
		data/data2/file2 data/data2/file2.txt >actual &&
	cat >expect <<-\EOF &&
	data/file
	EOF
	test_cmp expect actual
'

but the previous behavior would have passed this test:

test_expect_success 'directories and ** matches' '
	cat >.gitignore <<-\EOF &&
	data/**
	!data/**/
	!data/**/*.txt
	EOF
	git check-ignore file \
		data/file data/data1/file1.txt \
		data/data2/file2.txt >actual &&
	cat >expect <<-\EOF &&
	data/file
	EOF
	test_cmp expect actual
'

I seek more clarity on this. Specifically: if we match a directory
then should we not also match the contents within?

Thanks,
-Stolee
