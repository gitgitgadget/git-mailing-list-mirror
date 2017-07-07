Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87C22035A
	for <e@80x24.org>; Fri,  7 Jul 2017 18:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbdGGSfG (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 14:35:06 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36711 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbdGGSfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 14:35:05 -0400
Received: by mail-pg0-f68.google.com with SMTP id u36so4957863pgn.3
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 11:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uDJU8VNgaoXtJSLjSc6wCxFmvBszpjIsqv+6U30bbsw=;
        b=ROqa2HKWAE2bsqsmc6f85iDLW7KBeYCbGJMrq6Wf68dDeNnE+jzRgpGTWZ/nnPbOC4
         fLZcM8XtzbJ+x9s6bN1GQrAUW+EI4BPPEWwU9ZJjgfH2E5krHRiIcQxI7FkFE4AQDJwN
         baxalTMsVn2mJfUi1YsP8sMqN26ijIeNq+oZOyw+TXDOz3aNXHqPYCRS5ljvbRxxrnKy
         R8tlB+Kh9YUtDgZ5wvPzuwCxFxvRel4lRjzN5shrrgXsF2EAXJ44FsYGgBOh/oyAXjkd
         itdobeUd4jf5MGMfs6STyhH+qEmzz6hvfCN5lg+PlVlMwRUpuqkkK2WwNXj8Zr5Pmu7q
         DcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uDJU8VNgaoXtJSLjSc6wCxFmvBszpjIsqv+6U30bbsw=;
        b=qBk/tH3Qn4xfdUk48kgCwl2Q8G1/FDMCKUuAHL5iZfMhZnwDtJOdxWIW406dhBIZ+Q
         t49NBIq3XD7TiAeqTABuyab9oKXUMwoNRF3tcig4BkTv55jsssHjKfL2XubaqKKA30pF
         I2L8rgq0KkCMN9pSDC8OC4oL6pN4GIdlj/DBgfVM8Qbrldqr2k0Cre/14ia3IUv7it/o
         2tYKA8e/98Uy1XP8YVVMfO/8IN8cgLcH71mUfmOUdQpSn+PdRUto+512x5FeQzA8b8Sj
         rWI0H0aElhykfzHMozqP8Ky3EB24C4isygtDiNTuu3F6RKsNR6JeX7bnUYR4O7nAM3Bs
         SqaQ==
X-Gm-Message-State: AIVw110kQA650T4wm+bYJc5DugIP4O8UWP3RSctpNF1ukDmvNPX0H7JP
        1q+6XNI1S2wQIDJYDaY=
X-Received: by 10.99.42.141 with SMTP id q135mr2760745pgq.175.1499452504891;
        Fri, 07 Jul 2017 11:35:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id y11sm9486581pfi.42.2017.07.07.11.35.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 11:35:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v5 7/7] fsmonitor: add a performance test
References: <20170610134026.104552-1-benpeart@microsoft.com>
        <20170610134026.104552-8-benpeart@microsoft.com>
        <xmqqo9tsn9qg.fsf@gitster.mtv.corp.google.com>
        <9c1ed8d4-6bdb-e709-758d-4b010525e9e3@gmail.com>
        <xmqqvany2z84.fsf@gitster.mtv.corp.google.com>
        <7ec36d90-7fbc-c30f-e15e-f06d39e1f206@gmail.com>
Date:   Fri, 07 Jul 2017 11:35:03 -0700
In-Reply-To: <7ec36d90-7fbc-c30f-e15e-f06d39e1f206@gmail.com> (Ben Peart's
        message of "Fri, 7 Jul 2017 14:14:20 -0400")
Message-ID: <xmqqeftsayeg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> On 6/14/2017 2:36 PM, Junio C Hamano wrote:
>> Ben Peart <peartben@gmail.com> writes:
>>
>>>> Having said all that, I think you are using this ONLY on windows;
>>>> perhaps it is better to drop #ifdef GIT_WINDOWS_NATIVE from all of
>>>> the above and arrange Makefile to build test-drop-cache only on that
>>>> platform, or something?
>>>
>>> I didn't find any other examples of Windows only tools.  I'll update
>>> the #ifdef to properly dump the file system cache on Linux as well and
>>> only error out on other platforms.
>>
>> If this will become Windows-only, then I have no problem with
>> platform specfic typedef ;-) I have no problem with CamelCase,
>> either, as that follows the local convention on the platform
>> (similar to those in compat/* that are only for Windows).
>>
>> Having said all that.
>>
>> Another approach is to build this helper on all platforms, ...

... and having said all that, I think it is perfectly fine to do
such a clean-up long after the series gets more exposure to wider
audiences as a follow-up patch.  Let's get the primary part that
affects people's everyday use of Git right and then worry about the
test details later.

A quick show of hands to the list audiences.  How many of you guys
actually tried this series on 'pu' and checked to see its
performance (and correctness ;-) characteristics?  

Do you folks like it?  Rather not have such complexity in the core
part of the system?  A good first step to start adding more
performance improvements?  No opinion?


