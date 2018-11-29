Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05EF211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeK3BPR (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 20:15:17 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32910 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbeK3BPR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 20:15:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so2081133qtp.0
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 06:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aStQi+tpKnHJvToInhdV7OA5+dmaiQbvzmFXj7I09JE=;
        b=gSVbCACbe5hxPS9ngUYxplYKxveKHPv1Miab7eodlw5On3TF2amFMpy55OF6B/qNBz
         nck6uhlp7Bqz+y37PaOtZNce77ELyymtC9tyJWSxa3md629LSgVlFPe1ZjSb0Z5YSv3z
         6SuO+x8AoRO2PUptuNt60iHfidoqwM+OxA0EAFI9bycl+LVGXkBeqI2ujnXsQz3AlACK
         puT65XFIMyvNPLHfyUuKVa7mUG+4QLTxEkqTUnwbLq4eire0S9useIkkHpmlrLzp3fsF
         ZcyL/bqmUco8kUq3Vmv76Ei3p8U8ct0dCXQTnlbzua/15kjShUw5Kiq1dfTEXZVusHIP
         /KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aStQi+tpKnHJvToInhdV7OA5+dmaiQbvzmFXj7I09JE=;
        b=CKQQ9jRZ5xrpznnuTkIK/v9BLu3oQX6kHUwvT/Xlw+EVjvO8bq2lCXMLRlYsZ8Xb4E
         2+wWvt8bRAXcf/WLNw/il2MOI8kH3putTeU8Y7Pz+NRT7LcepEIWJVjyCi+/QHEWwMqC
         uY9BfRFUUkn9YbxLGw4hseXdFk4KWHVxLVXNJpLU0LAkT9zkDw0BksZi/2F46qFSIBoQ
         Hq5W0hd0zo65roopr3Mdu+DcLsYdU60O/ck+qzYUPgDWuQ9wOtPy3oR8gxA9HCqz8sjp
         9d5nM4ahgE5BxvNSIMUdiw32LWIA5qfCgb6sfb0Uyrpo4jIDYb1nAy5VTQD9rEEFEHmC
         2s6A==
X-Gm-Message-State: AA+aEWaq69oBLa4+KzTwyA16PfNvxyBBqFRz6qcqXUluPgdZGe+hEJac
        bMwTHjEs9hdmiXcxj4dX8Bc=
X-Google-Smtp-Source: AFSGD/WmY5796L1i0CaG4JSOfjqjmI3jVEORLWi8QI7JHft04y5FccQFLxJ42NFGG/jVDCCf7Ygf6w==
X-Received: by 2002:a0c:8286:: with SMTP id i6mr1498688qva.65.1543500587664;
        Thu, 29 Nov 2018 06:09:47 -0800 (PST)
Received: from ?IPv6:2001:4898:4070:37:c8c1:fce7:80c6:13be? ([2001:4898:8010:3:8955:fce7:80c6:13be])
        by smtp.gmail.com with ESMTPSA id y32sm1658360qth.3.2018.11.29.06.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:09:46 -0800 (PST)
Subject: Re: [PATCH v1] teach git to support a virtual (partially populated)
 work directory
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        sandals@crustytoothpaste.net, avarab@gmail.com,
        Johannes.Schindelin@gmx.de
References: <20181030191608.18716-1-peartben@gmail.com>
 <20181127195057.19724-1-peartben@gmail.com>
 <20181128133114.GF30222@szeder.dev>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <26e0b60c-c343-6ade-1e96-228c7d1b9418@gmail.com>
Date:   Thu, 29 Nov 2018 09:09:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181128133114.GF30222@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11/28/2018 8:31 AM, SZEDER Gábor wrote:
> On Tue, Nov 27, 2018 at 02:50:57PM -0500, Ben Peart wrote:
>
>> diff --git a/t/t1092-virtualworkdir.sh b/t/t1092-virtualworkdir.sh
>> new file mode 100755
>> index 0000000000..0cdfe9b362
>> --- /dev/null
>> +++ b/t/t1092-virtualworkdir.sh
>> @@ -0,0 +1,393 @@
>> +#!/bin/sh
>> +
>> +test_description='virtual work directory tests'
>> +
>> +. ./test-lib.sh
>> +
>> +# We need total control of the virtual work directory hook
>> +sane_unset GIT_TEST_VIRTUALWORKDIR
>> +
>> +clean_repo () {
>> +	rm .git/index &&
>> +	git -c core.virtualworkdir=false reset --hard HEAD &&
>> +	git -c core.virtualworkdir=false clean -fd &&
>> +	touch untracked.txt &&
> We would usually run '>untracked.txt' instead, sparing the external
> process.
>
> A further nit is that a function called 'clean_repo' creates new
> untracked files...

Thanks, all good suggestions I've incorporated for the next iteration.

>
>> +	touch dir1/untracked.txt &&
>> +	touch dir2/untracked.txt
>> +}
>> +
>> +test_expect_success 'setup' '
>> +	mkdir -p .git/hooks/ &&
>> +	cat > .gitignore <<-\EOF &&
> CodingGuidelines suggest no space between redirection operator and
> filename.
>
>> +		.gitignore
>> +		expect*
>> +		actual*
>> +	EOF
>> +	touch file1.txt &&
>> +	touch file2.txt &&
>> +	mkdir -p dir1 &&
>> +	touch dir1/file1.txt &&
>> +	touch dir1/file2.txt &&
>> +	mkdir -p dir2 &&
>> +	touch dir2/file1.txt &&
>> +	touch dir2/file2.txt &&
>> +	git add . &&
>> +	git commit -m "initial" &&
>> +	git config --local core.virtualworkdir true
>> +'
>
>> +test_expect_success 'verify files not listed are ignored by git clean -f -x' '
>> +	clean_repo &&
> I find it odd to clean the repo right after setting it up; but then
> again, 'clean_repo' not only cleans, but also creates new files.
> Perhaps rename it to 'reset_repo'?  Dunno.
>
>> +	write_script .git/hooks/virtual-work-dir <<-\EOF &&
>> +		printf "untracked.txt\0"
>> +		printf "dir1/\0"
>> +	EOF
>> +	mkdir -p dir3 &&
>> +	touch dir3/untracked.txt &&
>> +	git clean -f -x &&
>> +	test -f file1.txt &&
> Please use the 'test_path_is_file', ...
>
>> +	test -f file2.txt &&
>> +	test ! -f untracked.txt &&
> ... 'test_path_is_missing', and ...
>
>> +	test -d dir1 &&
> ... 'test_path_is_dir' helpers, respectively, because they print
> informative error messages on failure.
>
>> +	test -f dir1/file1.txt &&
>> +	test -f dir1/file2.txt &&
>> +	test ! -f dir1/untracked.txt &&
>> +	test -f dir2/file1.txt &&
>> +	test -f dir2/file2.txt &&
>> +	test -f dir2/untracked.txt &&
>> +	test -d dir3 &&
>> +	test -f dir3/untracked.txt
>> +'
