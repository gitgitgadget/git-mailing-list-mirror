Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B802C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 20:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D3C20736
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 20:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D8kSm77q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgDTUJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:09:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56117 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgDTUJw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 16:09:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 851B7491E5;
        Mon, 20 Apr 2020 16:09:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=klXQQuwdkgxWmeJGkxdEBVEvs1U=; b=D8kSm7
        7qxP7+Tosm5shxulNDpEJd+4wkUd1dgMa0/qmFXwHFVUwEbglemEafifvTrqfqB0
        PwESvRAOES11NyqBR+3FTk28xCcEJohoO4zJi0lF4t6ZL6j2npMMxTjALmzsfJP5
        13hlY3oNDdSTbD0IPHq9hXlnMsfHg+rJ47Nxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gVLxkxsLH/WEHP5pgrEhlmDVBOrvvC1A
        tFzrg6i6/GTxOJPuDiBHv6fNWbxYfcKm9COaL3VwLgnXqGTmqpDl5wEMgOjImnRa
        rw33/EsbnfrqDN/82jgKL+HrdIcXL+eNYr4qwhdj2gp78Clvq2Oj3w0o12AOIz3p
        PU52FmXVyX8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D025491E4;
        Mon, 20 Apr 2020 16:09:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F33D8491E2;
        Mon, 20 Apr 2020 16:09:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] t9164: don't use `test_must_fail test_cmp`
References: <cover.1587372771.git.liu.denton@gmail.com>
        <dfccb04e2d03656e18286bcca2c558e19d748ffd.1587372771.git.liu.denton@gmail.com>
        <CAPig+cQ6XS=ZDhAKGuDiGM4zcoxUhnghMY250qYLjuT8YZaoMg@mail.gmail.com>
Date:   Mon, 20 Apr 2020 13:09:49 -0700
In-Reply-To: <CAPig+cQ6XS=ZDhAKGuDiGM4zcoxUhnghMY250qYLjuT8YZaoMg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 20 Apr 2020 12:21:37 -0400")
Message-ID: <xmqqr1whrkaa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3BDE382-8342-11EA-994F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Apr 20, 2020 at 4:55 AM Denton Liu <liu.denton@gmail.com> wrote:
>> The test_must_fail function should only be used for git commands since
>> we assume that external commands work sanely. Since test_cmp() just
>> wraps an external command, replace `test_must_fail test_cmp` with
>> `! test_cmp`.
>>
>> Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> ---
>> diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
>> @@ -103,7 +103,7 @@ test_expect_success 'check if pre-commit hook fails' '
>> -               test_must_fail svn_cmd commit -m "this commit should fail" &&
>> +               ! svn_cmd commit -m "this commit should fail" &&
>
> Hmm, this doesn't look like 'test_cmp' mentioned in the commit message.

Yeah, the other hunk is about test_cmp and this hunk is about
svn_cmd.  The stated rationale applies to both wrappers, I think.

    Subject: [PATCH 6/8] t9164: use test_must_fail only on git

    The `test_must_fail` function should only be used for git commands;
    we are not in the business of catching segmentation fault by external
    commands.  Shell helper functions test_cmp and svn_cmd used in this
    script are wrappers around external commands, so just use `! cmd`
    instead of `test_must_fail cmd`

perhaps, without any change to the code?

