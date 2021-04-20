Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766EEC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 20:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C69613D5
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 20:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhDTURu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 16:17:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50252 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhDTURp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 16:17:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0303D0626;
        Tue, 20 Apr 2021 16:17:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QEOBL6kr5ApS14YPFdxAsxpjc4E=; b=XbnKSZ
        sw9VaM58csQM4vzPIHDMtlCwfCBMHxSNdNBc9Mbui6tnar4sM/za8uTEh7kqnaZ3
        EAqfH2aopaoa/oEHmDd8AJPEz5G4NmXOlE1b2ulIx+sta2oLNwMKARweQvGYRhwr
        ojyRgvPFeQVn/scxtpDa2cIKUr+TvW1XFFV/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cWXj/4wN3p4uMOFds7PC7Wjl9o84DoIg
        snXNGI3lT7MxzKv2OkMvflXx3G4Nki/dRHlT0s1Z/6J1QCOj31UGwjDrUgPI9otv
        6BO/aAFASfEdW+tot3la1jWbd2Dfuu5tH5FIIoXZS6hlt4ZNxtIOWece8M0qXgW5
        WC7xRmzwdkE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7FBED0625;
        Tue, 20 Apr 2021 16:17:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55366D0624;
        Tue, 20 Apr 2021 16:17:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Son Luong Ngoc <sluongng@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Pain points in PRs [was: Re: RFC: Moving git-gui development to
 GitHub]
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
        <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
        <86k18rbbyz.fsf@gmail.com>
        <CABPp-BG2SkH0GrRYpHLfp2Wey91ThwQoTgf9UmPa9f5Szn+v3Q@mail.gmail.com>
        <CAGr--=LKBq17XSLpe=uJbEPSfCp5Fpi_uw4d87DgJ8-S4Md0kQ@mail.gmail.com>
        <CABPp-BEcpasV4vBTm0uxQ4Vzm88MQAX-ArDG4e9QU8tEoNsZWw@mail.gmail.com>
        <20210419203327.GV2947267@szeder.dev> <xmqqsg3m7xin.fsf@gitster.g>
        <YH6Hj2/fGimrLuZ+@C02YX140LVDN.corpad.adbkng.com>
Date:   Tue, 20 Apr 2021 13:17:11 -0700
In-Reply-To: <YH6Hj2/fGimrLuZ+@C02YX140LVDN.corpad.adbkng.com> (Son Luong
        Ngoc's message of "Tue, 20 Apr 2021 09:49:35 +0200")
Message-ID: <xmqqa6ps6794.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 642E6A36-A215-11EB-B7D2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Son Luong Ngoc <sluongng@gmail.com> writes:

> On Mon, Apr 19, 2021 at 02:52:16PM -0700, Junio C Hamano wrote:
>> 
>> Interesting.
>> 
>> I recently had a similar experience with Gerrit, where a patch I
>> have seen quite a few times on Gerrit at $WORK had an embarrassing
>> syntactic issues I did not discover until it hit the public mailing
>> list.  It may be different from reviewer to reviewer, but at least
>> to me, e-mailed workflow forces me to apply the patch to my tree
>> before I can say anything non-trivially intelligent about it and
>> once applied to the tree, it actually let's me play with the code
>> (like, say, asking the compiler to give its opinion on it).
>> 
>
> I think this is very much the point of having a good CI pipeline:
>   - Apply patches into tree
>   - Compile
>   - Run relevant tests

It is true that CI can spot -Wdecl-after-stmt, but CI only covers
just one part of what is needed while I do my reviews.  It would
also be doable with web interface to look at all the places that
functions modified by the patch are referred to, and to check if the
change makes sense in the context of the entire tree.  It would also
be doable with web interface to looking at the evolution of the code
being changed.  There are some things, like building and using for
everyday life, running the built binary under debuggers, etc., that
may be harder to do with web interface, but I am sure many things
would become doable given enough time and effort.  However.

> Yes, having context beyond the diff is very important for Code Review.
> This is why I strongly recommend SourceGraph usages to folks I know.
> ...
> So I guess mordern toolings are available for these usecases, but
> fragmented and subjective to personal workflow.

My point in the message you are responding to was that I can do all
what is necessary locally, with my favorite toolset, once I apply a
patch to my tree.  The only thing that Gerrit allowed me to skip in
my recent adventure was to download the patch and apply to a newly
created topic branch locally to my tree, before I can start doing
some of the things (e.g. "look at the patch, examine with larger
context as needed", "grep for the symbols at the same revision in
paths that are not touched by the patch") that was needed to review.
And while I know I shouldn't blame the tool for this, but it did
mislead me to false sense of "I've reviewed this change well enough",
when I haven't.

By the way, I've been playing with "b4 am" and it's been a pleasant
experience so far.

Thanks.
