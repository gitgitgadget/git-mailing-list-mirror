Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F575201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 18:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754827AbdDRSpb (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 14:45:31 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34355 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbdDRSp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 14:45:28 -0400
Received: by mail-pg0-f54.google.com with SMTP id s64so527881pgb.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QFNy7JfjeXsCzkm1oo7BknQ6KYJhC3tWidIH2/jOuh4=;
        b=XurA8mc2bV/s84klaSgbvIuszOGOkLZMnzAs0I+yB4dpWDtQY6yeCq9bablB51vUVO
         1l3ideMYIE6b0HIpd5FtUq8DYbQZtv3eErVph1B/5xLCC3fQT2AL1EOz1G5wBLARz2mN
         UD97b16QOBuT+ONLArZJ+omkqf2LqV3SPH4IUlVbXbFqt0o8zlQhvZgoJkUlGHu5YrPM
         HgDX0u11dLxsmNODwgjLoRroYNqHDim7YvgVFgxzT6PFonChC2DWYyjQ9YK/OYL9joRu
         cc9a0pZ0SvdAJtT2rF9CEEsNbprQbGe4/YMM7ZZ4xlVQikDYqBx/DwbSc7heZ81WxsiR
         bLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QFNy7JfjeXsCzkm1oo7BknQ6KYJhC3tWidIH2/jOuh4=;
        b=M4nsUSefeNM/5F6UPIm6mTDaJg5CFH77H+DVWtb8ccaL9oBj+KwEnxryxZw/n5MzSp
         Z7/R9E18NVZmq3d7933b4u/IXAOj0+jFjsQaK0qfFvO5KdMj+ht88NPhzzxc0MxwrVwG
         CMpPmYpwabwIEuuMhyDtHBIFcJDmSEwr63XTc9VM3TsDeysDwhYJ3slUCLPOY8lLPhMx
         /EpwqtOfsAnkKBN8WajXm5HMaJPwguvyiYaLhWBGav3w4/BWzjhWaXAEJ3CAOTtgm0Tw
         3oRlx3ogY4v8Ryg/PkFefXw3bO661FEEGTQ3f0aaNF196QVorEyDFexb9TKG0JJtOqyu
         +CHw==
X-Gm-Message-State: AN3rC/5G6yYE6wrKCLtSCnj604hlNEFBYbQwMmSEv4EKZm5PdqFvuXGH
        vMNXL+z0mep135+AvMxCdL/yARY1FJ75
X-Received: by 10.84.236.4 with SMTP id q4mr23771126plk.12.1492541126808; Tue,
 18 Apr 2017 11:45:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Tue, 18 Apr 2017 11:45:26 -0700 (PDT)
In-Reply-To: <xmqqmvbefjar.fsf@gitster.mtv.corp.google.com>
References: <1492462296-4990-1-git-send-email-bnmvco@gmail.com> <xmqqmvbefjar.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Apr 2017 11:45:26 -0700
Message-ID: <CAGZ79kaBRS0SFAvrV4mN7-mVk+8QmPKPJMD55zPQ+A14ZzYFYA@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] [GSoC] remove_subtree(): reimplement using iterators
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Daniel Ferreira <bnmvco@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 9:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Daniel Ferreira <bnmvco@gmail.com> writes:
>
>> I think this is the closest to a final version we've ever gotten. I
>> followed all of Michael and Stefan's suggestions on top of v8, and with
>> Michael's endorsement made dir_iterator_begin() return NULL and set
>> errno appropriately in case of an error.
>>
>> On second thought, maybe the extra code complexity required from
>> dir_iterator_begin()'s callers might be actually an advantage as
>> dir_iterator grows to tackle more complex dir traversing challenges on
>> Git. After all, we might want some special behavior depending on what
>> the given `path` is instead of always considering it valid and later
>> behaving as if it was an empty directory.
>>
>> Thanks again for the reviews.
>
> I had a bit of trouble with phrasing here and there, but other than
> that the series was a pleasant read overall.
>
> Will queue, anticipating "Yeah, this is good as the final version"
> comments from reviewers.

yeah, it is.

Thanks,
Stefan
