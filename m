Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9143C55186
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F1D20736
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KhOgPYho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDUUoQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:44:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54497 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDUUoP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 16:44:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4DA07BAF44;
        Tue, 21 Apr 2020 16:44:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KNuA4mt96du6EojZ9Vtb8HMC/7Y=; b=KhOgPY
        hoGbhaoHvVQzXzE75lZ69HurvrB3XIRYQcWx2JX8UqwB6JwDZpY3YxpZijMCX+7M
        OKJR10Ncc3t2J8oDd+0E+OOEELsBUHyAzV8zs9aPCQlYydD6fMcmyIhcrbVsk6mt
        H+JAeae9rpNZENmlUe8xOxOZrjkasAcOKSkmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xi9KfF++Zf8QW9o1l8LtJBjkmuIZJERc
        0L1urokr/4SHapf9UH61RouWTwahb/MRZWor4xo0IsJgBB/E+zmvP/VYMUA/WTPK
        uyJyKW8VBt484BKAYZAyujpwSZx4wdYpUt95qK6VQpHLgPn4vA6OkUoIKxs7H047
        wKeIi0Jwv7I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46A7EBAF43;
        Tue, 21 Apr 2020 16:44:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 90912BAF3E;
        Tue, 21 Apr 2020 16:44:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] t9164: don't use `test_must_fail test_cmp`
References: <cover.1587372771.git.liu.denton@gmail.com>
        <dfccb04e2d03656e18286bcca2c558e19d748ffd.1587372771.git.liu.denton@gmail.com>
        <CAPig+cQ6XS=ZDhAKGuDiGM4zcoxUhnghMY250qYLjuT8YZaoMg@mail.gmail.com>
        <xmqqr1whrkaa.fsf@gitster.c.googlers.com>
        <20200421201627.GA9357@generichostname>
Date:   Tue, 21 Apr 2020 13:44:08 -0700
In-Reply-To: <20200421201627.GA9357@generichostname> (Denton Liu's message of
        "Tue, 21 Apr 2020 16:16:27 -0400")
Message-ID: <xmqqa734muw7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA5C56D8-8410-11EA-9508-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Mon, Apr 20, 2020 at 01:09:49PM -0700, Junio C Hamano wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> 
>> > On Mon, Apr 20, 2020 at 4:55 AM Denton Liu <liu.denton@gmail.com> wrote:
>> >> The test_must_fail function should only be used for git commands since
>> >> we assume that external commands work sanely. Since test_cmp() just
>> >> wraps an external command, replace `test_must_fail test_cmp` with
>> >> `! test_cmp`.
>> >>
>> >> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> >> ---
>> >> diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
>> >> @@ -103,7 +103,7 @@ test_expect_success 'check if pre-commit hook fails' '
>> >> -               test_must_fail svn_cmd commit -m "this commit should fail" &&
>> >> +               ! svn_cmd commit -m "this commit should fail" &&
>> >
>> > Hmm, this doesn't look like 'test_cmp' mentioned in the commit message.
>> 
>> Yeah, the other hunk is about test_cmp and this hunk is about
>> svn_cmd.  The stated rationale applies to both wrappers, I think.
>> 
>>     Subject: [PATCH 6/8] t9164: use test_must_fail only on git
>> 
>>     The `test_must_fail` function should only be used for git commands;
>>     we are not in the business of catching segmentation fault by external
>>     commands.  Shell helper functions test_cmp and svn_cmd used in this
>>     script are wrappers around external commands, so just use `! cmd`
>>     instead of `test_must_fail cmd`
>> 
>> perhaps, without any change to the code?
>
> Thanks, this looks good to me too.

Thanks.  

So the 4-patch test-must-fail-fix series is now complete?  Whee.


