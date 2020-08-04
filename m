Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5C6C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E26207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1HWK52T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgHDNMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgHDNMa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 09:12:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93130C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 06:12:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 77so5971316qkm.5
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OGB4aWoTdGqnMjLyudyNKN/X5Ql35YnEZne08FQlCtg=;
        b=i1HWK52TSYnt0c7UslR/piQ6bW1iDj2r3GeO5wBBbCKXLaAZHEjJy9YwkQ00JTfKvH
         i8N9XPf5VshOr+zhI1aDcNtxDxi9kTr9i9go9XQylC7oWZZhHcqGThW9dXpi0FNij8Zd
         ZGbXEQKyremHuBLCZrMTmwxlLtjx19UCaVuQBlvS4cDtVkg8Q+eiPB+4ZXtBW46Dgg1Z
         DIeCu/hl5FtmJ0i5oY4OezlvpYh3FZyy0q3Uud3U8C03pJGIGBO7j+RnrmmRUyI5SwO3
         ZkEycAiIstJfA3GkVKqKZYXWNaenTDYT21IJ2V4nGHezlOeooLTua15UFgS0al1FH6F1
         0tiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OGB4aWoTdGqnMjLyudyNKN/X5Ql35YnEZne08FQlCtg=;
        b=RZJUycGGA9pRkFHnp5eykzOU2rbRS/4voH6BX5xaqwJug98Fwf37ROFn8eXiQqkw7U
         h+NiL3g4+eZbPwQZD6n2W0GehDdLZZNcSrZRofFsD3jc/1kZIWtlgPAMoeDCELTdgPO8
         xkJF7SIE0Be8MLNwl3DFNnnGKIfvkzrYAewsVhz3pmw2Xz5obPfVF57JXfqoS2rlev3c
         PcX/i7Fuqth+NUfhVpsnMWccr3+VoPt/x9t6iM6JTyO2chQtJ19HjlmUgPVepZ9SQ6uv
         SbnZcqZOEoG1F6GNj/jDQXSBbcNAMNueFSvCTsucLfKoOni2jwB+O8Cj5bnclDAu4Gjp
         gc/g==
X-Gm-Message-State: AOAM532V+yrgRT3hOzBVaPjne1DFdA57RMNwzFHVRePAMP9WSFRmJNar
        OqpjMOfkyMgG0PF5Bm572NyajOuJiy4=
X-Google-Smtp-Source: ABdhPJz9wGspy74nG2e9w1vY4jJB9u7wBcnnmLiKrCr+7gPi8M9nNF9zP8uVFSm1PueRC1c2ycAILA==
X-Received: by 2002:a05:620a:21c6:: with SMTP id h6mr21118484qka.20.1596546749773;
        Tue, 04 Aug 2020 06:12:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:359e:33e7:c1bc:799? ([2600:1700:e72:80a0:359e:33e7:c1bc:799])
        by smtp.gmail.com with ESMTPSA id t69sm1057062qka.73.2020.08.04.06.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 06:12:29 -0700 (PDT)
Subject: Re: [PATCH] Revert "contrib: subtree: adjust test to change in
 fmt-merge-msg"
To:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20200803185749.1441344-1-emilyshaffer@google.com>
 <xmqqlfivv7ky.fsf@gitster.c.googlers.com>
 <20200803223945.GF2965447@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5cb1c0f8-53c4-f7c5-d1aa-a9241c511fd0@gmail.com>
Date:   Tue, 4 Aug 2020 09:12:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200803223945.GF2965447@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/3/2020 6:39 PM, Emily Shaffer wrote:
> On Mon, Aug 03, 2020 at 12:43:25PM -0700, Junio C Hamano wrote:
>>
>> Emily Shaffer <emilyshaffer@google.com> writes:
>> I wonder if it makes more sense to move this (or other tests in
>> contrib/ if any) in the normal test suite so that we'd notice its
>> breakage, though.
> 
> I'd welcome that change. We have some scripted step during our release
> process to run those specially, and it'd be nice not to have to.

I support that addition of contrib/ tests in the normal test suite,
or even just part of the CI builds. Anything to help catch these things
earlier.

Thanks,
-Stolee
