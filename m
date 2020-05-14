Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C4AC433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 02:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4642065F
	for <git@archiver.kernel.org>; Thu, 14 May 2020 02:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZKagXpOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgENCBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 22:01:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58649 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENCBD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 22:01:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E52155733E;
        Wed, 13 May 2020 22:01:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z2RiM0e+QdAFed8OE2Y+vD5br7Y=; b=ZKagXp
        OMjucWqipPnCZpn3wEd359+6MG70vuTdWsqnalKdTpJFk3J0Kmqa994onow/tuGh
        QqywguGkQDIP8fOsQgoDv77Q1imEmQsEKyeIncdkEC3hz2GMO2L+A3+5kBq3ak5B
        ML7EAhw94Yld6xIEEK0Vd2buZeHtP0u90//3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tUch50BtK3YolZe8OW8c0ADQ6RK421nN
        i4xeqopxliviXFUg+EthXII/l5WneT/hZqFbg96qdLbM4kdPkhVyJE60Fb7qw7e9
        5mvqROvP5dVnJ2HOtvYXvYSuF9m8oSVlBOJv6h41Mj912trzdI7K9hnyEAx2CcgN
        EKQSy3l9krg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1DA75733D;
        Wed, 13 May 2020 22:01:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 258ED5733C;
        Wed, 13 May 2020 22:01:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 08/11] cmake: added checks for struct stat and libiconv
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <f496cd7d8aa12047db7f6c0212fbcb2497469785.1589302255.git.gitgitgadget@gmail.com>
        <xmqqblmsc0r1.fsf@gitster.c.googlers.com>
        <CAKiG+9VrKsckfnJiaf1xMYnOtJ6wvnbtZv4-3sz6H7h3aZH3Cg@mail.gmail.com>
Date:   Wed, 13 May 2020 19:00:59 -0700
In-Reply-To: <CAKiG+9VrKsckfnJiaf1xMYnOtJ6wvnbtZv4-3sz6H7h3aZH3Cg@mail.gmail.com>
        (Sibi Siddharthan's message of "Thu, 14 May 2020 01:35:57 +0530")
Message-ID: <xmqqd077qnqc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C208CCE2-9586-11EA-9E1B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

>> All of these compatibility stuff makes sense, but how do we decide
>> where to draw the line between the checks we saw added in [01/11]
>> and the checks added here?  It feels pretty arbitrary to me and if
>> that is the case, perhaps we want to move all the "add checks" to a
>> commit separate from [01/11] (whose primary purpose is to add the
>> basic rules without these build tweaks in the file at the final
>> place)?
>>
>
> The checks are added on a "demand" based the target platform.
> In the future, if apple support is needed, we need to add ST_TIMESPEC checks.

Well, let's ask a related question then.

Given that the primary reason why the project may be interested in
adding cmake-based build system is because of its support for
Windows build, how much smaller would this 11-patch series can
become if we discard support for any platforms other than Windows?
Let's say we add support for other platforms only after the series
proves capable to build on/for Windows by going through the usual
"queued in 'pu', merged to 'next' and then down to 'master'" route
and appears in a tagged release.  Would it reduce the time we need
to spend before seeing a cmake-based build for Windows by doing so?
