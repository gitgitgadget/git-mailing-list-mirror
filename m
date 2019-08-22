Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550581F461
	for <e@80x24.org>; Thu, 22 Aug 2019 13:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfHVNpG (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 09:45:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46959 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfHVNpF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 09:45:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id j15so7647253qtl.13
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yW9U3OJJetRujHShdoumJsJRxsfJFZWry4Rwu6rn41k=;
        b=dtgh4FtsHaR2mRY8+e84O6fblQlpEo9QayCeNkUAGMi9ICYOfdr51U8u4YQ/Mvy5ss
         IIhypjltq1Cpg4RGvhyrZWpNV0kR/cS8OKKUIAWlywWKg0MqvZrbL6HJqeVbZZrmbziN
         Pa641NRSsq0nanDik6/GE3ABK7FTf28jOGkU4eQuQsKinxKaC56T/R7rcckHAI3pIKrh
         H0EwNRMe6awAcUCQrT+iq74B9xIzByoVM3OZlBLYwrFvdnHbCiTbnaBy4lI43r9r4bPf
         qcfSgalx6Z0c5roq+YX7/kUPd9omsCjgOOYs3xbn9MrIxXJRTNUk0zubMsGCwmgt9X4F
         o5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yW9U3OJJetRujHShdoumJsJRxsfJFZWry4Rwu6rn41k=;
        b=ZmzCj/WEnh7xlwo5nWug8tTZREYNOX+QXt5ZiOlOjPPWQb75KnNHWZmblXRJI4Z074
         oc52VJBh9LrTGTc3TqSIN3HpmKALI13aoxtxZHAQ7DOzM5FUB78bKnuG8klxYEbD8ym4
         cmQduOVG2iEeAfgwB4h7GOwMYmio6Su5fpfKni83SVMZJVKYRvCN5TvRGFwlvFW+trme
         q2160HFgyGP8oN6iv1Q1kavkieswjKbyyIEUPE64boFT85lrDNwokIQwPvSRsTOYHqAi
         QFZyAP+PRtsG02ybfFeLHhOPrNwC8YFiB0dSqCjXWjNijTQ07PuFk30QDv6iWwSLxtlk
         /c6w==
X-Gm-Message-State: APjAAAVzfLwWVkCfmMXoRp/eeCvO4+3HTyxehlquJxO60LiGqsMdaFta
        XmDAyyFLxzW2/wDs8SxyJWjSv7iGd3g=
X-Google-Smtp-Source: APXvYqzVk1+1hjWGnO0N89UO02z1jGn0iyZvi+XA2TQANc+Tf80XhA1pZfog9XTrBYwkSIItG2eoSw==
X-Received: by 2002:ac8:524a:: with SMTP id y10mr7399838qtn.100.1566481504590;
        Thu, 22 Aug 2019 06:45:04 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7dcd:416c:c779:cf77? ([2001:4898:a800:1012:2f01:416c:c779:cf77])
        by smtp.gmail.com with ESMTPSA id 6sm12557811qkp.82.2019.08.22.06.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 06:45:03 -0700 (PDT)
Subject: Re: [PATCH 0/2] [RFC] Revert/delay performance regression in 'git
 checkout -b'
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.317.git.gitgitgadget@gmail.com>
 <CABPp-BEN7TaMvtjoyqRa+_YxLDe8h8NYD9piu86-vWgwiKfbjQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <37d35cf9-6387-2549-4b29-aadd40cb15ce@gmail.com>
Date:   Thu, 22 Aug 2019 09:45:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEN7TaMvtjoyqRa+_YxLDe8h8NYD9piu86-vWgwiKfbjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2019 11:16 PM, Elijah Newren wrote:
> Hi,
> 
> On Wed, Aug 21, 2019 at 12:21 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> As we were integrating Git 2.23.0 into VFS for Git, we discovered that "git
>> checkout -b new-branch" went from 0.3s to 10+s on the Windows OS repo. This
>> was an intentional change when writing the "git switch" builtin. Here is the
>> commit message for 65f099b ("switch: no worktree status unless real branch
>> switch happens" 2019-03-29):
>>
>> When we switch from one branch to another, it makes sense to show a
>> summary of local changes since there could be conflicts, or some files
>> left modified.... When switch is used solely for creating a new
>> branch (and "switch" to the same commit) or detaching, we don't really
>> need to show anything.
>>
>> "git checkout" does it anyway for historical reasons. But we can start
>> with a clean slate with switch and don't have to.
>>
>> This essentially reverts fa655d8411 (checkout: optimize "git checkout
>> -b <new_branch>" - 2018-08-16) and make it default for switch,
>> but also for -B and --detach. Users of big repos are encouraged to
>> move to switch.
>>
>> I was considering doing a full, long-term revert of this change to get the
>> performance back to normal, but I also saw this feedback on the list for
>> this patch:
>>
>> I like this last bit. The skip_merge_working_tree() function which
>> this removes was ugly, difficult to maintain, and difficult to get
>> just right (and easy to break -- even by changing parts of the system
>> which one might not expect to impact it).
> 
> Instead of restoring this easy-to-break code, could we instead
> simplify it and make it more robust?  As per the original commit
> message, the whole point of the patch is that when you have a huge
> index, operations take a while.  But in the special case of "git
> checkout -b <new_branch>", there's no need to even check the index.
> So, we could:
> 
>   * Check if the user is running "git checkout -b <new_branch>"
>   * If so, use the performance hack to skip touching the index at all.
> 
> This would be much better than what the patch currently does:
> 
>   * Check if the user has specified -m, if so they clearly didn't just
> specify "git checkout -b <new_branch>"
>   * Check if the user has specified -f, if so they clearly didn't just
> specify "git checkout -b <new_branch>"
>   * Check if the user has specified --detach, if so they clearly
> didn't just specify "git checkout -b <new_branch>"
>   * ...<lots of other similar steps>...
>   * If we got here, since we've checked all other cases (assuming
> other people who have touched checkout remembered to add the necessary
> checks for each and every new flag), then by deduction the user must
> have specified "git checkout -b <new_branch>", so...
>   * Use the performance hack to skip touching the index at all.

I can look into a simpler implementation of this direction. I'm
getting the feeling that this immediate recommendation of "git switch -c"
is too hasty, so the best thing to do is to create a simpler way
to detect "git checkout -b" and use the fast method.

Thanks,
-Stolee
