Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D142CC433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 22:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiBIWWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:22:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiBIWWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 17:22:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD830C0F869C
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 14:22:18 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b13so8012484edn.0
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 14:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=/xaQmH5Oyqe0Z/xQpMswn9MiWDbJkhpFJMw0/yWDoT8=;
        b=d/dZIPV+e98Of5E0t99hDRaIJvRMayUFADFpFL/t6QPZRCc5lB4M/UJb4NuB4dakKr
         HqEoIUjb0YD3/RtPYejflc1uhlCDGBhTEcksJ5volr54ylfUTq6vzk25jNTl2mziVLBd
         3tiQqSEiH3H0a49ZJszaXkQJSzOOwJicRI1ReTyDMTCCwP7CS1v3qt6gwDwxDIGRWZ+v
         Rn2AjNiCNTMaeYbwAO7yEughr5qP3nQPqT5IPDiXFDj0P8i0rFxy/S4R7scPR9pBEMgy
         magaDsSumBXwoMABvMRoJQCK8jUlQyUXMvZOxzb3Xwd5YYVa2KQYeNy/qqaJKvIP5+jZ
         wycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=/xaQmH5Oyqe0Z/xQpMswn9MiWDbJkhpFJMw0/yWDoT8=;
        b=Bff4t1cpvLf1IpenaggAdmkvlhztIPPP8bPTemdkEU7I3u6hq6q+FzaOPyCgP9tcI4
         Y2KcZvxAsBs0XlzkItsJQIxWNZEbb4V+MtLznW53DYkFiffYPTMGk0UaGCgyf+O3HbNo
         fYk7QHbkml9mcwF4OcQGe89lenHcnoBYw8TFNACJoNhaFB3xEQURXCgGX3Q85FNObWck
         sSaG3mTv/iPydJkeAaZtUypvCYqwqQOit0b61aYLlZn/0AI2LC71q+naQnnCj9uNZ/Lb
         k4FWED/l9HjTTMuF4hhfm2BQ4nG5N/WYUCrg7+7GOxmldgVdkUWA7E2aH3WLzrEsWhh8
         5Dfg==
X-Gm-Message-State: AOAM532ThuiyE0eMJPEk0mVUX0h1pcwynor4C4Gpvql3m4e/woRXFTup
        y5guL8uo3yVANoLwpOYUCL8dNa4POpI=
X-Google-Smtp-Source: ABdhPJz6r/pTXARnn3nKzGap63wp1friapzKWTcKc5LShjE6Ytp2xrG7cxc+5CI4PPpCMJXVYHVgvg==
X-Received: by 2002:aa7:d7da:: with SMTP id e26mr5230419eds.70.1644445337235;
        Wed, 09 Feb 2022 14:22:17 -0800 (PST)
Received: from [10.200.48.220] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id dn23sm4196747edb.87.2022.02.09.14.22.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 14:22:16 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/3] Add cat-file --batch-command flag
Date:   Wed, 09 Feb 2022 17:22:12 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <691561CD-A3CF-457F-ACD0-E45153EBB829@gmail.com>
In-Reply-To: <xmqqa6ez7m6t.fsf@gitster.g>
References: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
 <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
 <xmqqa6ez7m6t.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 9 Feb 2022, at 16:40, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> John Cai (3):
>>   cat-file: rename cmdmode to transform_mode
>>   cat-file: introduce batch_command enum to replace print_contents
>>   cat-file: add --batch-command mode
>>
>>  Documentation/git-cat-file.txt |  24 ++++
>>  builtin/cat-file.c             | 154 ++++++++++++++++++++++--
>>  t/t1006-cat-file.sh            | 207 ++++++++++++++++++++++++++++++++-
>>  3 files changed, 373 insertions(+), 12 deletions(-)
>
> Does t1006-cat-file.sh pass the --stress test?  I have no time to
> test it for you but I've seen "make test" got stuck and this is the
> only cat-file related change in flight.

Yes it looks like there are some failures. Thanks for pointing this out. It
looks like the flush test is getting stuck. I can actually reproduce it on my
end when I do a make clean in t/ and then run the test. Will investigate.

thanks!
