Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718D0C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 12:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5EF64E75
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 12:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhBIM7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 07:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhBIM7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 07:59:53 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC7C061786
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 04:59:12 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id q85so5454960qke.8
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OoPOI4AefDkckPw2tbAJFm3MSUekd03kjOlawZx+rXo=;
        b=CUXlBZsymrQYfNsgrkA17PKbT5SQCTm5LnEqIJwT7FcflyBngP1RPUh0QxSWKHht/F
         5w1FOeG5WNejs/GgrufDqVpKvyh8jEnPofla/Qryhna3sDzDlI9uHHABztfy0Ph2DlIe
         XDYA99E0pR4kthcyAtBVN9LVbeFpby+D0vwMDhwkraiJSlknyd06Qy9Yr24bXQynMMbJ
         RbaMN9xw0DYfu0PYZ7xoR7lT51MUCM7QaauCIrP0YFTBl1wMgOtIwb7qtHKngGfPMqLJ
         Au4tEPuXFO6Ox+7fjMLcmDvEo734SzHbh47OTO6ZTADpDgffoEwaRqs07OroOu6eVuaX
         C0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OoPOI4AefDkckPw2tbAJFm3MSUekd03kjOlawZx+rXo=;
        b=T17wv0KFZFGHBVXzOCowEU+yKSwszSTTh8ji75G0DrLHi10UrRoqRGKZQHng91o6So
         hg//GOLHTqCyHyzG95T9A9lg08wd2mhWTT1ICLfiR4L7n7bGCmqmva9bdumrHMuvKGoh
         L4N6SWdubrxR01YyFRMqLxVvC4dD0OQouPnAJe1HU/CGNAQ3YxLrC66CVKo6zNvcDGsZ
         +NB2GRvcfIaoqYbcw0NgFv/T9J88cxBLLC2NYAHNo8YO3hlN6jQy3hufv1OXspEk6Zzj
         Eq45HkmSiwwbc0oUAxucy2l/US3LlZI7iP+LgzXSA/A2ULlqOKfWJfH2vaKaB2NLHs0i
         OSbQ==
X-Gm-Message-State: AOAM533Mzvp1Ynd83qarF4ZxY1oJBRij1/DE01YVc7PcHlVZmMKITgDt
        xjX2NonDlbaoydIlWmBUk9tj2z2VLdT45jJV
X-Google-Smtp-Source: ABdhPJxcKjR7QYnzuvMjnv8yDeBCcC5qI40SbdyK/ieqSUGETBgoxUJZFi9sJBQ44sBc8d8yUrMXlA==
X-Received: by 2002:a37:8c6:: with SMTP id 189mr5816575qki.470.1612875551154;
        Tue, 09 Feb 2021 04:59:11 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7c18:1f04:a165:5ea0? ([2600:1700:e72:80a0:7c18:1f04:a165:5ea0])
        by smtp.gmail.com with UTF8SMTPSA id q15sm5472448qti.9.2021.02.09.04.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 04:59:10 -0800 (PST)
Message-ID: <6aa32f94-9c8c-ad26-09ab-4c2028ef1d67@gmail.com>
Date:   Tue, 9 Feb 2021 07:59:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 4/4] gitdiffcore doc: mention new preliminary step for
 rename detection
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <a0e75d8cd6bd32fb1ab2a209bc2079c30995b257.1612870326.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a0e75d8cd6bd32fb1ab2a209bc2079c30995b257.1612870326.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2021 6:32 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The last few patches have introduced a new preliminary step when rename
> detection is on but both break detection and copy detection are off.
> Document this new step.  While we're at it, add a testcase that checks
> the new behavior as well.

Thanks for adding this documentation and test.

> +Note that when rename detection is on but both copy and break
> +detection are off, rename detection adds a preliminary step that first
> +checks files with the same basename.  If files with the same basename

I find myself wanting a definition of 'basename' here, but perhaps I'm
just being pedantic. A quick search clarifies this as a standard term [1]
of which I was just ignorant.

[1] https://man7.org/linux/man-pages/man3/basename.3.html

> +are sufficiently similar, it will mark them as renames and exclude
> +them from the later quadratic step (the one that pairwise compares all
> +unmatched files to find the "best" matches, determined by the highest
> +content similarity).  So, for example, if docs/extensions.txt and
> +docs/config/extensions.txt have similar content, then they will be
> +marked as a rename even if it turns out that docs/extensions.txt was
> +more similar to src/extension-checks.c.  At most, one comparison is
> +done per file in this preliminary pass; so if there are several
> +extensions.txt files throughout the directory hierarchy that were
> +added and deleted, this preliminary step will be skipped for those
> +files.

> +test_expect_success 'basename similarity vs best similarity' '
> +	mkdir subdir &&
> +	test_write_lines line1 line2 line3 line4 line5 \
> +			 line6 line7 line8 line9 line10 >subdir/file.txt &&
> +	git add subdir/file.txt &&
> +	git commit -m "base txt" &&
> +
> +	git rm subdir/file.txt &&
> +	test_write_lines line1 line2 line3 line4 line5 \
> +			  line6 line7 line8 >file.txt &&
> +	test_write_lines line1 line2 line3 line4 line5 \
> +			  line6 line7 line8 line9 >file.md &&
> +	git add file.txt file.md &&
> +	git commit -a -m "rename" &&
> +	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
> +	# subdir/file.txt is 89% similar to file.md, 78% similar to file.txt,
> +	# but since same basenames are checked first...
> +	cat >expected <<-\EOF &&
> +	A	file.md
> +	R078	subdir/file.txt	file.txt
> +	EOF
> +	test_cmp expected actual
> +'
> +

I appreciate the additional comments in this test to make it clear
what you are testing. A minor nit is that the test could have been
added at the start of the series to document the _old_ behavior.
The 'expected' file would have this content:

+	cat >expected <<-\EOF &&
+	A	file.txt
+	R078	subdir/file.txt	file.md
+	EOF

Then, this test case would change the expected output in the same
patch that introduces the behavior change.

Thanks,
-Stolee

