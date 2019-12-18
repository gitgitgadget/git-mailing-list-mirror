Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A5AC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4D3206D7
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f8fko05n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfLRSBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:01:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55360 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfLRSBe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 13:01:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69DC0A480D;
        Wed, 18 Dec 2019 13:01:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rO+WE0Jqvxpkje2Tf7DiHZIG9Is=; b=f8fko0
        5nYuflVcvY3hLpBF+o6YZR3eX4sav/YrgHguHSU8tfcNFKfeX3KO2OnqwJraZfG5
        ovhgz0yu8TIbrVP/jD5qjTerIwv6X7iLFaqERy89DDGxkViuEBsCwowoaZsXw0Ko
        LbG2xVFK/7IJJBgrz2JbPWJmQZHncoEo3W8fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YAR3o7B+qaPgWfSyEKhJljQO33yYZvBB
        j8O4Zy7MnKD0/gugJYgqqOmcGFOrgTk5d3cu1ndilitaj7n0OeOtgjouplTTexVm
        ydccNsj/3LVhBhE8ARH2WVL0KUEGjAjFcOh/J+3oa076cFIAiQVRpJkGbYh8+EbC
        A9kgJ5SidNw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6312CA480C;
        Wed, 18 Dec 2019 13:01:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88DF2A480B;
        Wed, 18 Dec 2019 13:01:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2019, #04; Tue, 17)
References: <xmqqa77qfw99.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGRjewgHtFQ7F_isrqnC25EQyWoPbpdyVJeDzfVEysiCg@mail.gmail.com>
Date:   Wed, 18 Dec 2019 10:01:28 -0800
In-Reply-To: <CABPp-BGRjewgHtFQ7F_isrqnC25EQyWoPbpdyVJeDzfVEysiCg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 18 Dec 2019 09:15:35 -0800")
Message-ID: <xmqqsglhecnb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B4B6FCA-21C0-11EA-9F9B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Dec 17, 2019 at 2:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>> * en/fill-directory-fixes (2019-12-11) 8 commits
>>  - dir: consolidate similar code in treat_directory()
>>  - dir: synchronize treat_leading_path() and read_directory_recursive()
>>  - dir: fix checks on common prefix directory
>>  - dir: break part of read_directory_recursive() out for reuse
>>  - dir: exit before wildcard fall-through if there is no wildcard
>>  - dir: remove stray quote character in comment
>>  - Revert "dir.c: make 'git-status --ignored' work within leading directories"
>>  - t3011: demonstrate directory traversal failures
>>
>>  Assorted fixes to the directory traversal API.
>>
>>  Will merge to 'next'.
>
> Please hold; even if you are willing to accept a manufactured dirent,
> the discussion did highlight two bugs in this series:
>
> 1) I shouldn't assume dirent has a d_type member; my one access to it
> should be guarded with a !defined(NO_D_TYPE_IN_DIRENT).

Thanks, yes, that should be done.

>
> 2) I should allocate my dirent on the heap (with some extra buffer
> space) rather than the stack, because if dirent has a "char d_name[]"
> rather than a "char d_name[BIG_ENOUGH]" declaration, then my
> stack-based allocation followed by writing to d_name will smash the
> stack.

Yes, or BIG_ENOUGH may not be long enough for the name you are
creating.

> I'll submit a re-roll with those two things fixed.

Thanks.
