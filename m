Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C7C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BEC206CA
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ4yjIB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKKRJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgKKRJD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 12:09:03 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2CEC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:09:01 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id l2so2372430qkf.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=anZofnQymEH6NSLchmbinsxmPdiOLkQomUz4CH+4i70=;
        b=KZ4yjIB7dyFfjcePjoWv0sy2NugyHX1LumXNJcrI5Of0fjrkYHQtcZcjKUOsXYt7sg
         Ql3QIIQCj0caSLk9gOYE0T6/7z+PiEmGIf4yW4HUWTmX1Ur/+Xifd2rGUeIpW5Fe6Omn
         ZCxpe5BL91iCRafzs1IrUo7lSfpHbpSlGrp0crs2znwuoqqAAQzEoVfRG3tHIDJJhRob
         fVrkYLdSt3WET1NMJgEnFEOYB/MIkm8d/o3LOmZpT7zrNf2SkHphjqjMb1vRhLFAuVkE
         SiSQlQu5/nRxbenyvQ+d1kt4ibWWSkCY/UhggKu5apC99K3D37I9dVx8SLpIt67J/Bk5
         d7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=anZofnQymEH6NSLchmbinsxmPdiOLkQomUz4CH+4i70=;
        b=MesR5F6W5W1jTREUAlF49MSmRVDat9jsxwrSr8re7fYAfrvQcDMQ+lhvEvuaaroNV4
         YLkyoh2V2JN6F6sLUYruWmlYBpVM3YcQDDZKVWtMrE7drKDMxVJg3WkHKfqJsRlDIKYB
         fAhmyfx0npoVwc10TRArPcjAKROEhcotHbBJNMboUOQNk+ErM61Fsb4kc3XNOwyYjaSW
         wduNDePwVuCluwQlSiVEYbwJBleO4w8cVZyy43RI2NWWglbVkSErjPb57r5JCrOFVWJu
         oFbrhAWY4evG2DxJI4wm2fmHIHRQA+54V3RKA4ra4obbN3a9OgLA39oaNyGsfRhN9TJq
         39Aw==
X-Gm-Message-State: AOAM531suMGYtr/1voMoNIS5xDigpa8lDGPfLt9b68YqwTZLRLvTE0Xs
        TjC3J3bcm74d0952nIhJ7v9nQ4NT1+L/vw==
X-Google-Smtp-Source: ABdhPJxxevEQ1YAKnpJqqI3oJF2unH9KewJ5ozdePiSsnz6TTjfysieXZOCaFsy2lPDpxoH8nwPmIA==
X-Received: by 2002:a37:58c1:: with SMTP id m184mr26406446qkb.305.1605114540536;
        Wed, 11 Nov 2020 09:09:00 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:c9d4:abc:8d:1568? ([2600:1700:e72:80a0:c9d4:abc:8d:1568])
        by smtp.gmail.com with UTF8SMTPSA id z125sm2654886qke.54.2020.11.11.09.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2020 09:08:59 -0800 (PST)
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <20201102204344.342633-1-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <75170ee7-525e-31fc-f6bd-6dfac12b00c8@gmail.com>
Date:   Wed, 11 Nov 2020 12:08:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 3:43 PM, Elijah Newren wrote:
> Elijah Newren (20):
>   merge-ort: setup basic internal data structures
>   merge-ort: add some high-level algorithm structure
>   merge-ort: port merge_start() from merge-recursive
>   merge-ort: use histogram diff
>   merge-ort: add an err() function similar to one from merge-recursive
>   merge-ort: implement a very basic collect_merge_info()
>   merge-ort: avoid repeating fill_tree_descriptor() on the same tree
>   merge-ort: compute a few more useful fields for collect_merge_info
>   merge-ort: record stage and auxiliary info for every path
>   merge-ort: avoid recursing into identical trees
>   merge-ort: add a preliminary simple process_entries() implementation
>   merge-ort: have process_entries operate in a defined order

I got this far before my attention to detail really started slipping.

>   merge-ort: step 1 of tree writing -- record basenames, modes, and oids
>   merge-ort: step 2 of tree writing -- function to create tree object
>   merge-ort: step 3 of tree writing -- handling subdirectories as we go
>   merge-ort: basic outline for merge_switch_to_result()
>   merge-ort: add implementation of checkout()
>   tree: enable cmp_cache_name_compare() to be used elsewhere
>   merge-ort: add implementation of record_unmerged_index_entries()
>   merge-ort: free data structures in merge_finalize()

I'll try to take another pass on these commits tomorrow.

For the series as a whole I'd love to see at least one test that
demonstrates that this code does something, if even only for a very
narrow case.

There's a lot of code being moved here, and it would be nice to have
even a very simple test case that can check that we didn't leave any
important die("not implemented") calls lying around or worse accessing
an uninitialized pointer or something.

Thanks,
-Stolee
