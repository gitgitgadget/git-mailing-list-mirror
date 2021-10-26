Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575FBC433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F0760F9B
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhJZV4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhJZV4h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:56:37 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C58C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:54:13 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id c3so470840qvh.7
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 14:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8TaR7vzls8Rfzf8Rw3SVCrEZQCcass363/vs6f81v3M=;
        b=QRu5pbOpC3zYVRAb5q2vksrgLHIehHl0LR4CXnjOabWWXbzmSmDl1zQfwHhMwaMWd6
         zWbCLoJ9gL4a+qhzxs8QJo+M7QJH1QnWLE/x+VIP7M4rnsUK3GeIEXEyyYqnkRexVMb3
         sIkYl3Jk0Wsyh8xIKOuTsqvhShHTAI4kHJZ3TPZ23caWehaXtjUD8Ygrgr/O3zwMilVp
         V4HQ+XnBdNVGJTpdjuKsQ3gQmAMWAkFc94C/DdGP4nHCzXPBaA3mATTqgI2cLh9ybL68
         60BU7PUVNh300/X9N9t+0XF1CZ9s3/1CRI/mTpeT0lg4ge+G7/utE6yOLHYBF4KdTppc
         nnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8TaR7vzls8Rfzf8Rw3SVCrEZQCcass363/vs6f81v3M=;
        b=f7SdHS3Oyy8EgjEfD97Rj2JebjVqONW9nEaTLN1myDwQm1X5coqkMpAGgGY0bjms1i
         GFvEbBlhRfkM7jAgfZEpsrneMuK5aDLnsTrWDLrD9Rc8PbxgJNixvKKF23qaSGEew0zh
         QXFwBmgDXorfbidoFkYTNQHHXxBLx5dyrJhsiN3FpRYi69RDe4ZZ0YnUkxLZ1pqVPgvQ
         5sD9bdMzU9ea/QS1am8fuC6elyiGrEui/aseZrhh0V5LxXyN6F+F7EAJtt0bONUnuzGz
         ZRIROO1tFyBqnOoZOiGdZzeHGV7mfVu+vF3twuaOKFSU0uRIUUYindEXFbOz8fNuinWF
         rB8g==
X-Gm-Message-State: AOAM532hE3SA7nVNauxWm8b8cKVFTTA2DIStU71s41ElHH4U874O2D3a
        DrmqCthWcdFK6QDlRfOw3es=
X-Google-Smtp-Source: ABdhPJziJnQiORahltV5vpdZMxfwsGjtXnUDkAGOkAQmmw8t9aUp7jr5ylLrhgu1Usij2qOiaDyuKQ==
X-Received: by 2002:a05:6214:d88:: with SMTP id e8mr12452815qve.14.1635285252622;
        Tue, 26 Oct 2021 14:54:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:86f:cede:45bc:10f6? ([2600:1700:e72:80a0:86f:cede:45bc:10f6])
        by smtp.gmail.com with ESMTPSA id t26sm11169965qkg.40.2021.10.26.14.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 14:54:12 -0700 (PDT)
Message-ID: <0abd483a-e7f8-9070-0d77-cbedb7f225fc@gmail.com>
Date:   Tue, 26 Oct 2021 17:54:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <xmqq5ytkzbt7.fsf@gitster.g>
 <e9bc367e-ae51-da1c-558e-6836922b0d0d@gmail.com> <xmqqv91jxyqe.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqv91jxyqe.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/26/2021 5:28 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>>  Various operating modes of "git reset" have been made to work
>>>  better with the sparse index.
>>>
>>>  Needs review.
>>
>> This topic had good review in its first three versions, and the
>> current v4 has had one response that doesn't seem to have actionable
>> changes. Could you re-evaluate if the "needs review" label is still
>> appropriate?
> 
> The label indeed does not read well.  I know there was a lot of
> dicussions on v3 but in the list traffic, but I do not see anybody
> looked at v4 and said that the issues they pointed out in v3 are now
> covered to their satisfaction.  Probably "Needs ack" may have shown
> what I meant better?

That makes sense. I think I've also seen labels such as "Is this ready?"
before, which has a similar call to action.

And I'm sorry that I missed there was something to change in the test.

Thanks,
-Stolee
