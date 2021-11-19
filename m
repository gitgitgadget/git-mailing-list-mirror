Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B80AC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 18:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0882B61A70
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 18:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhKSSdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 13:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhKSSdh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 13:33:37 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6C4C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 10:30:35 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id m9so14017854iop.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 10:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HBaTDJTrN44yskKQGTyR4x75HU0+zT4IiIR++Qn10II=;
        b=KewwO2zFjyirjZKQdl6IE/qRo5AV4Y6jWFdgr9kckRXgRCV//hRxmgO87q+yiaGdyZ
         Sjxj/0/lmWNxa009tCa5njDkv4k3rwgMbJvJP4DEFy025zINB9au9j18v6F77m7f88cA
         bcmpgWX/oKu/imrjzzcxyH9L5uQiieJtQf8VCtHF39bteyL4xEYdDt9GY2fPZLCfH3CF
         iqrzj8uut7NQk5SrNoY/ACMSxmlaCTMKg53jV7ZAo/vemE8YiLO324/93fY1Wxa+eB/E
         wouMp+DCqGQvQrj7uxPn27LfcnB5799wz7aV5NJ7xZsKyuxuClO29yMf2t43qXty6P59
         0ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HBaTDJTrN44yskKQGTyR4x75HU0+zT4IiIR++Qn10II=;
        b=gF0ccBC/Karqr15OEcBtiT1NdIbhM3AUeBCneP6NOaoSm/QEQRlpkimoiH/E3XxGUS
         B7iLXjj5ij3UwzLBPRi1TVX7Gn+gi8ucNEDaS5JDVdnZNCHxoBYOjOXe1NPZazGbCHIW
         ETmgvSEv6gdi2YtNMMQ1lMs3H7QkBwfVXzIXagHnJnW2POx/uyaLH9IBKe4NfwiET7OJ
         6KFjvUKOom/Xjf/pQUdj3kAFuKLdPpMIyGh742qFoC9wK3nbfqlWtqvroe7m7dYs/k+L
         i1Auz7CfUjpGoNMGvAaIcofAK9ntqHVikx8KzjCXRtfX6wxNOQuDRCBu+YqGtuyOJBeu
         fCRg==
X-Gm-Message-State: AOAM530LZfO39zyC/xRnhIFrlhccTr47Zc1yAiCaOirpeLu3sn7sY6HZ
        Mf58+WTLCOKeV9ogmtJo/L8=
X-Google-Smtp-Source: ABdhPJzXn9l3oS9UsryqPqz44JV6S7fDaabj1S5/xbi906dkSDhejsLQ0+/D3NRlkIMx1/Y8Ovv7+Q==
X-Received: by 2002:a05:6602:45d:: with SMTP id e29mr7316361iov.202.1637346634371;
        Fri, 19 Nov 2021 10:30:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3441:8b39:39a2:9208? ([2600:1700:e72:80a0:3441:8b39:39a2:9208])
        by smtp.gmail.com with ESMTPSA id t6sm378057iov.39.2021.11.19.10.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 10:30:33 -0800 (PST)
Message-ID: <e56b0227-14fc-26cf-7b98-fbf01f3c5cd7@gmail.com>
Date:   Fri, 19 Nov 2021 13:30:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [Question] Unicode weirdness breaking tests on ZFS?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
 <20211117161226.xcat77ewhf5inaif@tb-raspi4>
 <20211117170613.kyoe6ov2m5wi2i56@tb-raspi4>
 <20211117173924.maporsti5cz2ixsu@tb-raspi4>
 <8a3d0d0e-cc82-b696-00f4-b71e6452e1bd@gmail.com>
 <5d1b5ce6-d9ff-1b2a-2ff2-19813c957a24@gmail.com>
 <20211119154405.xhoqfh3vmljxbh5c@tb-raspi4> <xmqqmtm0qdqp.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqmtm0qdqp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2021 12:03 PM, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
>> Should we conclude that the underlying os/zfs is not stable ?
>> Things don't seem to be reproducable
>>
>> What Git needs here in t0050 is that stat("ä") behaves the same as stat("a¨"),
>> when either "ä" or "a¨" exist on disk.
>> The same for open() and all other file system functions.
> 
> We either need to see these two are treated as the same thing, or
> these two are treated as two distict filesystem entities, just like
> stat("a") and stat("b") are.  What we absolutely need is the
> unification either always happens or never happens consistently.
> 
> I wonder what readdir() is returning.  After creat("ä") in an empty
> directory, does readdir() in there return "ä" or "a¨?  And vice
> versa?  Is this also inconsistent?

Following this suggestion, I added a test helper with this code:

int cmd__create_and_read(int argc, const char **argv)
{
	DIR *dir;
	struct dirent *de;

	if (strcmp(argv[0], "--nfc"))
		creat("\303\244", 0766);
	else if (strcmp(argv[0], "--nfd"))
		creat("\141\314\210", 0766);
	else
		die("select --nfc or --nfd");

	dir = opendir(".");
	readdir(dir);

	while ((de = readdir(dir)) != NULL)
		printf("%s\n", de->d_name);

	return 0;
}

And then added this test:

test_expect_success 'unicode stuff' '
	mkdir nfc &&
	(
		cd nfc &&
		test-tool create-and-read --nfc >../nfc.txt
	) &&

	mkdir nfd &&
	(
		cd nfd &&
		test-tool create-and-read --nfd >../nfd.txt
	) &&

	test_cmp nfc.txt nfd.txt
'

This test always passes for me, and is essentially doing
a similar check that the prereq is doing, except that it
actually writes both names to files instead of writing
one and doing a read with the other.

After changing the "$test_unicode" instances to instances of
"test_expect_success", I ran t0050 under --stress and quickly
got a failure on the 'merge (silent unicode normalization)'
test:


expecting success of 0050.11 'merge (silent unicode normalization)': 
        git reset --hard initial &&
        git merge topic

+ git reset --hard initial
error: unable to unlink old 'ä': No such file or directory
fatal: Could not reset index file to revision 'initial'.
error: last command exited with $?=128
not ok 11 - merge (silent unicode normalization)


Deleting that test gave mostly-consistent results, although I once
got a failure on the "setup unicode normalization tests" tests with
a similar error message:

+ git checkout -f main
error: unable to unlink old 'ä': No such file or directory
Switched to branch 'main'
error: last command exited with $?=1
not ok 8 - setup unicode normalization tests
 
>> ("ä" is the precomposed form "a¨" is the decomposed form,
>>  typically both render to the same glyph on the screen,
>>  and a hex dump or xxd will show what we had.
>>  I just use this notation here for illustration)
>>
>> Should we contact the zfs developers ?

Hopefully someone has a good way to contact them, and I
can start a thread at the appropriate place. To optimize
for their time, what is our minimal reproduction steps?

1. Build Git at the v2.34.0 tag.
2. cd to t/
3. ./t0050-filesystem.sh --stress

Those instructions (given enough time) should get the
repro on test 8, 'setup unicode normalization tests'.

To get the faster stress, the same steps work except
use the 'zfs-minimal' branch at my fork [1] because it
changes the tests to expect success, and demonstrates
the unpredictable tests more quickly.

[1] https://github.com/derrickstolee/git/tree/zfs-minimal

Thanks,
-Stolee
