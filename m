Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019CCC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 13:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiLLN7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 08:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiLLN7o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 08:59:44 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3AABC4
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 05:59:43 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id fu10so8989248qtb.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 05:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmtI+cgrSU4cJmc+oGono9tlgm4hoqEM6QXKM4pOGZY=;
        b=cDy4p2RdfJjnFzXhvVo2zhFIckF6kjTLr63FGbbmZTIrC6Vjclt+szR27uQmkVUwRc
         u0QpXuAfHpW0oOE0BLOwaC72+y/eEPBwf5VCO3GxyaiGxU8qR+zYGXruHBrQtW0CGSsT
         RacZCMes1wZY+VOKmJ/7pxaXHW6prXK7wwhfAT3y74tuX5OG22x35+BhSDpqfc1vf/aA
         LZNPO1mM3YT5CRVujaUftUGjPpBeOKMJjHYGJU4zzkFRWd9PLWmt8ZU8VwlIJ5xfUJOs
         CCvqlXnZttAqpNzwKBr9r9B6cXLh/gfGx+kp2/w7QRn+4lmvNGPNbMKPLnrCyhZjhdsz
         CRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmtI+cgrSU4cJmc+oGono9tlgm4hoqEM6QXKM4pOGZY=;
        b=0OBCS4Pdf0tMof6Dhkb6uhlijW5/lTkgyF7BBCOQaa+I9/Yz5Ct8ZZwfWbf+AtY9Wn
         x84e3KBsPCDMBYALy60Z/jkF6qpjCnxEqW6T+bqdyK0Ai0Ro3RXzQBoTjsr47kbYsqMs
         qwLduhSxWwj70viElOqnq+Oa17oU0PB1/UuoOQ8WC46eJKUrU5ytoKMXzFybQDVl0hLM
         TXK/LhflEdopg903nHCPZCgZmSJhBOl2oO6TQMcOQEkSwtXpmZqsTInu2DU4RjINoZlO
         dIgk5Q80DbmuvUJLpDAT+DrvWY2dUoMhrIrULR4x2E+2QYtTqA4xDj+ivFUDSlIJrCt+
         uoFA==
X-Gm-Message-State: ANoB5pke0/r9smkonM67v4rZ+aHrW07zRsPvlVvqkLU8ZjYidK9vIW3y
        EgxhxyaGDcnDV/4PqB2sh2hP
X-Google-Smtp-Source: AA0mqf5/uePB+bx8skGfZND0kiuK0E4MwGaKLrbRmJot2lb2bfjagZXM7VniH18Tz/VyRcaK9Ik88g==
X-Received: by 2002:a05:622a:1e8d:b0:3a5:50c6:bdce with SMTP id bz13-20020a05622a1e8d00b003a550c6bdcemr22771739qtb.47.1670853582782;
        Mon, 12 Dec 2022 05:59:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:84c8:9ef9:1297:e16e? ([2600:1700:e72:80a0:84c8:9ef9:1297:e16e])
        by smtp.gmail.com with ESMTPSA id g8-20020ac84b68000000b003a4c3c4d2d4sm5793440qts.49.2022.12.12.05.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:59:42 -0800 (PST)
Message-ID: <37efcfcd-fea1-c1d7-65f7-ae5f2d2a12e6@github.com>
Date:   Mon, 12 Dec 2022 08:59:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] read-cache: add index.skipHash config option
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        avarab@gmail.com, newren@gmail.com
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
 <CAPig+cRSY+c-fOQBeC5ff0-s3+_kzFEjcBOSHP6C8ca9t7zr+w@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPig+cRSY+c-fOQBeC5ff0-s3+_kzFEjcBOSHP6C8ca9t7zr+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2022 1:59 PM, Eric Sunshine wrote:
> On Wed, Dec 7, 2022 at 12:27 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +If you enable `index.skipHash`, then older Git clients may report that
>> +your index is corrupt during `git fsck`.
> 
> This documentation is rather minimal. Given this description, are
> readers going to understand the purpose of the option, when they
> should use it, what the impact will be, when and why they should avoid
> it, etc.?

I will expand this with explicit version numbers for older Git versions.

>> diff --git a/t/t1600-index.sh b/t/t1600-index.sh
>> @@ -65,6 +65,14 @@ test_expect_success 'out of bounds index.version issues warning' '
>> +test_expect_success 'index.skipHash config option' '
>> +       (
>> +               rm -f .git/index &&
>> +               git -c index.skipHash=true add a &&
>> +               git fsck
>> +       )
>> +'
> 
> What is the purpose of the subshell here?

I was matching the style of the nearby tests, but they are all
modifying GIT_INDEX_VERSION, which isn't necessary here.

Thanks,
-Stolee
