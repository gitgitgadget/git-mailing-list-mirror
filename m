Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33453C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 01:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDE021744
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 01:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZ5wZBUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbgGaB1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:27:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59578 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgGaB1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 21:27:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C040EE0A4B;
        Thu, 30 Jul 2020 21:27:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JW0dzZIznX1EkW2Xu8J2atytVt8=; b=iZ5wZB
        UM7QP+Tl4L9HyZL6mez6oOZpOwdBXj8wVhzNttxZcR1ignKTUv0TdEnABSYagX7g
        qz8zFyRjzy9+0ZVLB4UfJ8E35a9hu2hw0u9RHi8D5J7aWQWvRnSQm6StBUYKnJuG
        HS4neE9N66Gz2m65859a60N2NMIzJ9fH1xiNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w9pSrwb0gajV3CUCcBp02oABQR11lCjw
        zPdXFMGS+ue3JIQ4Vd7q7rE60s+u6dqlQoFDU5MJaNzbe52kutFQeMA1B+/o/n63
        ewj+Oj7Pgz+YIAYL16e60qwRR9YqSC/QcTGExP7iNM1+zuDp5rUo2fhtEgojJdTh
        FzpkUy8bYjA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7B70E0A4A;
        Thu, 30 Jul 2020 21:27:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0F2EBE0A49;
        Thu, 30 Jul 2020 21:27:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2020, #06; Thu, 30)
References: <xmqqo8nw5zwn.fsf@gitster.c.googlers.com>
        <20200731010307.GE240563@coredump.intra.peff.net>
Date:   Thu, 30 Jul 2020 18:27:41 -0700
In-Reply-To: <20200731010307.GE240563@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 30 Jul 2020 21:03:07 -0400")
Message-ID: <xmqqk0yk5v8y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07E44B6E-D2CD-11EA-8165-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 30, 2020 at 04:47:04PM -0700, Junio C Hamano wrote:
>
>> * jk/strvec (2020-07-28) 11 commits
>>  - strvec: rename struct fields
>>  - strvec: drop argv_array compatibility layer
>>  - strvec: update documention to avoid argv_array
>>  - strvec: fix indentation in renamed calls
>>  - strvec: convert remaining callers away from argv_array name
>>  - strvec: convert more callers away from argv_array name
>>  - strvec: convert builtin/ callers away from argv_array name
>>  - quote: rename sq_dequote_to_argv_array to mention strvec
>>  - strvec: rename files from argv-array to strvec
>>  - argv-array: rename to strvec
>>  - argv-array: use size_t for count and alloc
>> 
>>  The argv_array API is useful for not just managing argv but any
>>  "vector" (NULL-terminated array) of strings, and has seen adoption
>>  to a certain degree.  It has been renamed to "strvec" to reduce the
>>  barrier to adoption.
>> 
>>  Will merge to 'next'.
>
> Do we want to do the s/items/v/ thing before it gets merged to next?

I do want to get rid of that items[] thing.  An array with a plural
name that is accessed one element at a time a lot more often than
referred to as a collection as a whole is simply stupid.

> I already posted a replacement top patch in the thread:
>
>   https://lore.kernel.org/git/20200729003720.GA1653374@coredump.intra.peff.net/
>
> and I don't think anything else needed a re-roll.

I missed that one.  Will replace and adjust the conflict resolution
but I'll have to wait for my attention/focus to be recharged before
doing so.

Thanks for reminding.

