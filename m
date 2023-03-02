Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE48C6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 20:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCBUBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 15:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCBUBw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 15:01:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C42851FBB
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 12:01:16 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso122708pjs.3
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 12:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPfK7h9qkSZneeVkaZGVKKgfAwByPdqVh0hMLMtXRmU=;
        b=Lrt+Xna6cq9TU2B3xy+rHBIFbUiqjPb7+MPGVK62Oh+3BAXBgFBvjosZ8u/vXafqzX
         roBohnFEFDjH6RzO+kds7WifNMzxbeJWTdVqvup3EVL9DyD6jWvBFfplI9x7SHNdCnXw
         05Vp/MTFVYQTNvOmd4m0p8eA4JOieYAqn2iTka8+JgrVXMUkaQgMN/TUE9GjdZsQY61P
         ES8XvkPwGGg35QSSikhMCvbLJZ0c7/J1IunFpKIfZXaJzCXzSuzrB6FcE55ZW1C3EIw8
         tXBUPaLV9ppHWX63/ie8OeJUbntE0K88e8ALXucq/j2BLbm5WNrwiWGQl/LjYD8oiync
         NU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wPfK7h9qkSZneeVkaZGVKKgfAwByPdqVh0hMLMtXRmU=;
        b=kKASLM4gdS3BL+Tt0YNq8XddLxoDD7SujMRBzB2YU1CWfBLbkErSRv5uDRunsjTuwE
         z4SCKHNJ/p1aOd8DiUYiMnsEfwq4MgTCuzCtJLH2a6lhLLi81RkmZldAfjYnXTzR8zek
         7NBqBhYcAMcbOWSgQlORZetmWa1hz0tefC2ArOii1oyrNsHNPJCLV+qlDn6gx0p/AzTF
         JURffmkK9cnw9ZmJUkk4K2meZmvy74tsJs59V/1SipaGUn2YcMaRydxH2FvgUfylnsRV
         TMy5HejSUscmx0TWzkNn7Ri8ELU1W+I5yaB4tS6oo10KGfc6h8iHqi1PCn5IREWuiGSG
         2klw==
X-Gm-Message-State: AO0yUKU4hZnlTDl3DC0h9eMF6NH8lFijknvG29lbj1QSOWUVJJxq0bSQ
        IoaQ0kR4oWmgsbBKQiEdwIA=
X-Google-Smtp-Source: AK7set/G0RHevguMziOAC4q4d/zfkBiYl91MGRONzUtBu2mNW56HXOLrRJIzc8JkTJZdVnVReS07cQ==
X-Received: by 2002:a17:903:40c6:b0:196:11b1:101d with SMTP id t6-20020a17090340c600b0019611b1101dmr10233122pld.28.1677787211570;
        Thu, 02 Mar 2023 12:00:11 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902900800b0019a70a42b0asm77341plp.169.2023.03.02.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:00:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Git List'" <git@vger.kernel.org>
Subject: Re: [Failure] Re: git 2.40.0-rc1
References: <000001d94d26$1e52a910$5af7fb30$@nexbridge.com>
        <xmqqh6v3j8n1.fsf@gitster.g>
        <001a01d94d3f$04c2e460$0e48ad20$@nexbridge.com>
Date:   Thu, 02 Mar 2023 12:00:10 -0800
In-Reply-To: <001a01d94d3f$04c2e460$0e48ad20$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Thu, 2 Mar 2023 14:41:38 -0500")
Message-ID: <xmqq356mkjp1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On Thursday, March 2, 2023 1:44 PM, Junio C Hamano wrote:
>><rsbecker@nexbridge.com> writes:
>>
>>> Git 2.40.0-rc2 was a regression from rc1. The following new tests failed:

I think you are reporting -rc1 relative to -rc0.

>>> t3206 - virtually all subtests failed. An example of this failure is a
>>> results comparison in subtest 1 (seemingly relating to abbreviation):
>>> + test_cmp expect actual
>>> --- expect      2023-03-02 16:39:23 +0000
>>> +++ actual      2023-03-02 16:39:23 +0000
>>> @@ -1,4 +1,4 @@
>>> -1:  4de457d = 1:  35b9b25 s/5/A/
>>> -2:  fccce22 = 2:  de345ab s/4/A/
>>> -3:  147e64e = 3:  9af6654 s/11/B/
>>> -4:  a63e992 = 4:  2901f77 s/12/B/
>>> +1:  4de457d2c0d218f48d66f45f9b30f3aa62562105 = 1:
>>> 35b9b25f76d404d09a23e6c8efa96c3ce19e19aa s/5/A/
>>
>>Are any big endian machines involved?
>>
>>cf. https://lore.kernel.org/git/Y%2F+paI8WGSmEbv%2Fw@pobox.com/
>
> Oh yes. All NonStop variants are big-endian. That hasn't changed the SHA-1
> signatures though.

There is a stupid sequence that slipped through the review

	char c = structPtr->intMember;

	if (c < 0)
		... do something ...

and where "char" is "unsigned char", the compiler thinks "do
something" will never trigger and from there everything goes
haywire.

The tip of 'master' already has a fix (and no other changes as of
this writing), and will be part of -rc2.

Thanks.


