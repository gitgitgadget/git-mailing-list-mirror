Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D5C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 14:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F14222BB
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 14:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440151AbgLNOeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 09:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437759AbgLNOd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 09:33:58 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DCFC0613CF
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 06:33:18 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 143so15668889qke.10
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 06:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wsQdGatNeay0agB8EGOoLyjBxayryCVb2CY5gklzz+c=;
        b=XSX0aglP8N7aKGOI9II3ljtS7W04J/+z1n3gb4GslXgVvqFal4tTgUbVy8K0lgrv4S
         qZSLLknUJ5a8AkwBFi+gfSwp+VK11Hj4SXzXWoOKK7878op7bapf95N2lYS9/VoJtlKh
         5n2xSiLLW3Mz2L8nrZf6mIC1CkhiUetd4lGqvEyrsBnzSua59pI2EQeP+4HuV5liX/oj
         7NJPUY0rb3Ood9RF94/cuaNY1cZBaqUMfJVk4U62dLrDL0U5K0FEzjuvY44vY85ioNbv
         Tlw1Z8Z6ZG7KrvqXdQBURAR9N5uJFJueD0wdXPAVVC9GTRiam0vDjS88T64Zyg/mvZVq
         w3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wsQdGatNeay0agB8EGOoLyjBxayryCVb2CY5gklzz+c=;
        b=ddy7Ua74S1ZeyOMymH64Qp/WSswQXH3ei4/wm54ogA3yYNUQDrAjBzjeKCVJuujCqu
         PjJ4FqXRGydomd3vlp9SQP/I1mD3ALVMnp/2EBcCJeM5ba793xrdwwlrrQkxka4WZULy
         K/5evcdDX8XOEFaIzOt7dEALx0vw+I1lfbZcQwWFn+uMExM+RLN+XjGouZ0+p3mastmw
         79XMeo2i3xj2KUb5vHjGiwgkHiqL5YxfieCHNEt5Kgg+ZCgKk4mBbI5cpjbWS8NZ+IdL
         Oed9BkV+GHCi6zeKMUelX8OEKUc+sHW9+lt8NLPMZmz1gdPYPB64iFMemnnFbmB0FLRI
         dLCg==
X-Gm-Message-State: AOAM531EkeoVRcEkoubJa4pU5r750fym2xwQn/qjLJnjhUrnx3NmR47m
        SYD9OMb5pD5vEdoS2tATzp0JKvN788CeLA==
X-Google-Smtp-Source: ABdhPJzBEBlln4mjcbhFoup/ePzE2HnliWz9K0cA+0srTFNUaHZmpKeD7VIgz82M5zcNHIoxY4eUoA==
X-Received: by 2002:a37:e40a:: with SMTP id y10mr33212279qkf.144.1607956397277;
        Mon, 14 Dec 2020 06:33:17 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id v137sm15225479qka.110.2020.12.14.06.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 06:33:16 -0800 (PST)
Subject: Re: [PATCH 02/11] merge-ort: add initial outline for basic rename
 detection
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <b9e0e1a60b92a6a220193bf9fe80796df91126a7.1607542887.git.gitgitgadget@gmail.com>
 <84a4d97b-8496-4c83-5d32-19f57e17a871@gmail.com>
 <CABPp-BHa0zehQd-axmb4bF6fR4PTWwGu9uLjOzgTW8_Gu12iZA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7b0aafae-cd57-d4f7-ac85-238471428d24@gmail.com>
Date:   Mon, 14 Dec 2020 09:33:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHa0zehQd-axmb4bF6fR4PTWwGu9uLjOzgTW8_Gu12iZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13/2020 2:47 AM, Elijah Newren wrote:
> Hi,
> 
> Sorry for two different email responses to the same email...
> 
> Addressing the comments on this patchset mean re-submitting
> en/merge-ort-impl, and causing conflicts in en/merge-ort-2 and this
> series en/merge-ort-3.  Since gitgitgadget will not allow me to submit
> patches against a series that isn't published by Junio, I'll need to
> ask Junio to temporarily drop both of these series, then later
> resubmit en/merge-ort-2 after he publishes my updates to
> en/merge-ort-impl.  Then when he publishes my updates to
> en/merge-ort-2, I'll be able to submit my already-rebased patches for
> en/merge-ort-3.

Let's chat privately about perhaps creatin
 
> A couple extra comments below...


>>> +     int s, clean = 1;
>>> +
>>> +     memset(&combined, 0, sizeof(combined));
>>> +
>>> +     detect_regular_renames(opt, merge_base, side1, 1);
>>> +     detect_regular_renames(opt, merge_base, side2, 2);
>>
>> Find the renames in each side's diff.
>>
>> I think the use of "1" and "2" here might be better situated
>> for an enum. Perhaps:
>>
>> enum merge_side {
>>         MERGE_SIDE1 = 0,
>>         MERGE_SIDE2 = 1,
>> };
>>
>> (Note, I shift these values to 0 and 1, respectively, allowing
>> us to truncate the pairs array to two entries while still
>> being mentally clear.)
> 
> So, after mulling it over for a while, I created a
> 
> enum merge_side {
>     MERGE_BASE = 0,
>     MERGE_SIDE1 = 1,
>     MERGE_SIDE2 = 2
> };
> 
> and I made use of it in several places.  I just avoided going to an
> extreme with it (e.g. adding another enum for masks or changing all
> possibly relevant variables from ints to enum merge_side), and used it
> more as a document-when-values-are-meant-to-refer-to-sides-of-the-merge
> kind of thing.  Of course, this affects two previous patchsets and not
> just this one, so I'll have to post a _lot_ of new patches...   :-)

I appreciate using names for the meaning behind a numerical constant.
You mentioned in the other thread that this will eventually expand to
a list of 10 entries, which is particularly frightening if we don't
get some control over it now.

I generally prefer using types to convey meaning as well, but I'm
willing to relax on this because I believe C won't complain if you
pass a literal int into an enum-typed parameter, so the compiler
doesn't help enough in that sense.

> Something I missed in my reply yesterday...
> 
> Note that mi->clean is NOT from struct merge_result.  It is from
> struct merged_info, and in that struct it IS defined as "unsigned
> clean:1", i.e. it is a true boolean.  The merged_info.clean field is
> used to determine whether a specific path merged cleanly.
> 
> "clean" from struct merge_result is whether the entirety of the merge
> was clean or not.  It's almost a boolean, but allows for a
> "catastrophic problem encountered" value.  I added the following
> comment:
> /*
> * Whether the merge is clean; possible values:
> *    1: clean
> *    0: not clean (merge conflicts)
> *   <0: operation aborted prematurely.  (object database
> *       unreadable, disk full, etc.)  Worktree may be left in an
> *       inconsistent state if operation failed near the end.
> */
> 
> This also means that I either abort and return a negative value, or I
> can continue treating merge_result's "clean" field as a boolean.

Having this comment helps a lot!
 
> But again, this isn't new to this patchset; it affects the patchset
> before the patchset before this one.

Right, when I had the current change checked out, I don't see the
patch that introduced the 'clean' member (though, I _could_ have
blamed to find out). Instead, I just got confused and thought it
worth a question. Your comment prevents this question in the future.

Thanks,
-Stolee
