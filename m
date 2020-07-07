Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02A0C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 20:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E4D206F6
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 20:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c/ioZ2zT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgGGU56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:57:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63222 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgGGU56 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 16:57:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75E5F62469;
        Tue,  7 Jul 2020 16:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O9JhqSv1EFdMLDdEiCha5Qewz9Q=; b=c/ioZ2
        zTIOk6HsjQQKn78jRLGza8cUkcGGVYylqbRjc48Q8TgFGBXXwpzrCMxia80CVyji
        qlfUUuh5C2e6WEQk9eJ4ps2NbsvU9UTLa55EYuQOInDWoiBdoiWCtF9X1jnGZ8u8
        mKiK0FJgeBTJFDLKOKNt1q2NUruHzwMyJ4ong=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QjfYpajGmqQYZbGf7kqrSjsZqmkhhknz
        XaYan5FfiRnNM8wkIccVyIvXFJOzwY07niW19tg2832eBCbA/eCgohVeZ76GaQJR
        sYGMNGo7BgYFproFNC3FuMCYlR6r2c/r5jLB1rXPt6sZM4lsUavqvgBWQHWQddkF
        gC4TCzZGtzo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E54462467;
        Tue,  7 Jul 2020 16:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F108462466;
        Tue,  7 Jul 2020 16:57:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RESEND PATCH v2 0/5] t: replace incorrect test_must_fail usage (part 6)
References: <cover.1593576601.git.liu.denton@gmail.com>
        <cover.1594101831.git.liu.denton@gmail.com>
        <xmqqblkr3x6q.fsf@gitster.c.googlers.com>
Date:   Tue, 07 Jul 2020 13:57:55 -0700
In-Reply-To: <xmqqblkr3x6q.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 07 Jul 2020 13:08:29 -0700")
Message-ID: <xmqq7dvf3uwc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8825025A-C094-11EA-AA9E-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Changes since v1:
>>
>> * Add a code comment to force_color()
>>
>> * Do not allow nested env's in test_must_fail_acceptable()
>>
>> * Clean up the env-processing case code
>>
>> * Give an example on how to use `!`.
>
> Thanks for a resend.  Now part #5 is in 'master', I can queue these
> directly on top.

It seems that the patch series lacks coverage for t9400 where we
have

test_expect_success 'cvs server does not run with vanilla git-shell' '
	(
		cd cvswork &&
		CVS_SERVER=$WORKDIR/remote-cvs &&
		export CVS_SERVER &&
		test_must_fail cvs log merge
	)
'

which obviously needs to be converted before we declare that it is a
hard error to feed a non-git command to test_must_fail.


