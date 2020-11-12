Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3705BC2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0C022201
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juJ9zxtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgKLSXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 13:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKLSXO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 13:23:14 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26CCC0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 10:23:13 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id r11so1537210oos.12
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vplwxc+GBhvsESbSCF9+mx2a9qzuHRzA2dbEvW9Z9Bo=;
        b=juJ9zxtYPia+9+1i0BP+VTjzZUu5I7sCXmi9y7C7c5Aa2ov2Q4W0ojE1ff9Wb9Nl6W
         QuMFQOzpvbhP3NWwACnBrXZfJ4P4yGbCK3QM9BDakWf70P8Pv7lOF//ZZc4CwJ43NFPS
         wJmhDruoBR5dBv65cVe13NMptuhJUkKCA33wKaKGnQIe5pnck9bQDa5GFfRj94kUW8c7
         1AzauMxMi0JisQX04DiZOQekvshSPyMH15C1T3+o9m2z81n2BCAY7w4XY3chBVhE2Gtr
         7O9jvOj0rH1TktMa0xysXPPqgY4y0YIrVZrtaUsPOcERanlcmWT/m6T4oJasFJf9wTP7
         LdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vplwxc+GBhvsESbSCF9+mx2a9qzuHRzA2dbEvW9Z9Bo=;
        b=ujq1IFr6xMgPiFEDFD0USaOoEFQd6nvmzmt4GUHfBnlrZ3X6NGcpZ+knpOwO8ukUwl
         UnB/5ikxvW/JMoHKC0WUpyaSC9THrqUnBIjms7YQZZIMPaJuYh3z9/d6PR8zkfobbViQ
         TyIa0RtAs5izdOtb6fnhb1TUeMTwpl4k6h+sFBrOP5axNFV5gPahZ3qJp9FlV33SjS8F
         b6wTIXniA56G4F8J808qLqavMBddTU5yV0MltZvIoQ5DZd4qUwphv74yjbHKINU21sAK
         OeeTL2I6xNnrxn9XeLoJE8mWJqmGZoukyS8Vpo1ZfXPHELx7ZC4UMLv12TSTLx52+Sqx
         LZzg==
X-Gm-Message-State: AOAM532cNlHBkLs6QspOODZUP5uZDWKmknFg0peg9THVjSEIF6EEm3Zl
        q8yNKD7+jpzF05vbWbX1NU+qRjrmT/GXBg==
X-Google-Smtp-Source: ABdhPJyBxjCHNoNDF1kXk9Kp03qutPi31YpSGKI/CaNbWy5kLV8Z0o3DU97wHzTJsnl4n2f3wfSFmQ==
X-Received: by 2002:a4a:ddd7:: with SMTP id i23mr424099oov.73.1605205392727;
        Thu, 12 Nov 2020 10:23:12 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:30c9:afaa:d787:e592? ([2600:1700:e72:80a0:30c9:afaa:d787:e592])
        by smtp.gmail.com with UTF8SMTPSA id g18sm1391442otp.23.2020.11.12.10.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 10:23:11 -0800 (PST)
Subject: Re: [PATCH v2 09/20] merge-ort: record stage and auxiliary info for
 every path
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20201102204344.342633-1-newren@gmail.com>
 <20201102204344.342633-10-newren@gmail.com>
 <94bf9b69-5d13-c914-fb1a-bce912018a63@gmail.com>
 <CABPp-BFRPuxLYz_n6jbr=j7Gu1GhsV95nKPE1=HxUcsvimrz0g@mail.gmail.com>
 <CABPp-BHCqD8yS_4t7ztL2+FxjPCZ9Meq97VfRhnDRwCjLpdSzg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dbc8eddf-a6ef-b087-7714-0dc03f5b32a7@gmail.com>
Date:   Thu, 12 Nov 2020 13:23:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHCqD8yS_4t7ztL2+FxjPCZ9Meq97VfRhnDRwCjLpdSzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/11/2020 5:06 PM, Elijah Newren wrote:
> On Wed, Nov 11, 2020 at 10:16 AM Elijah Newren <newren@gmail.com> wrote:
>> This was the whole point of the strmap API[1] I recently added --
>> provide a hashmap specialized for the case where the key is a string.
>> That way I get fast lookup, and relatively fast resize as the hash
>> only contains pointers to the values, not a copy of the values.
>>
>> Is your concern that allocating many small structs is more expensive
>> than allocating a huge block of them?  If so, yes that matters, but
>> see the mem_pool related patches of the strmap API[1].
>>
>> [1] https://lore.kernel.org/git/pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com/
> 
> 
> I just re-read what I wrote, here and below...and I need to apologize.
> I tend to write, edit, revise, and repeat while composing emails and
> the end result of my emails doesn't tend to reflect the path to get
> there; I looped through that cycle more times than most on this email.
> But, even worse, I added in a sentence or two that just shouldn't be
> included regardless.  I think in particular this one sounds extremely
> aggressive and dismissive which was not at all my intent.
> 
> I find your reviews to be very helpful, and I don't want to discourage
> them.  Hopefully my comments didn't come across anywhere near as
> strongly as they did to me on a second reading, but if they did, I'm
> sorry.

I did not feel any animosity. Your response was just so involved that
I didn't have time to respond in kind. I hope to do so later today.

The short version of my reply is "You know more about this than me,
and I appreciate the additional detail."

Thanks,
-Stolee
