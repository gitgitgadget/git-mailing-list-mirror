Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80BFC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 18:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiGYSwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 14:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiGYSwX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 14:52:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D79312AF7
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 11:52:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC86C1A3CDC;
        Mon, 25 Jul 2022 14:52:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=58vvIUpwR06T
        0IiBoSGBqKCSKX6MWwKPZNVTwOCYQL0=; b=dYS83jfA1O2JlmUEs2sfHF7zs4nQ
        HD57iagLuhNDL9UqLxdLxiyPFoWdfKJiBipkTeykGDUMTEFMmwLntzSBsmkPR311
        yudJifxz2tZ0+oPRzW1hkY4U7m33cBjyobkC5XWmm/iwdb4fsZ6gtntVv56X/P+7
        Opzes6XHgkub16w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C5D831A3CDB;
        Mon, 25 Jul 2022 14:52:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 792871A3CD8;
        Mon, 25 Jul 2022 14:52:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 00/10] typed sort of linked lists
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
        <xmqqk08bv0ax.fsf@gitster.g>
Date:   Mon, 25 Jul 2022 11:52:17 -0700
In-Reply-To: <xmqqk08bv0ax.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        17 Jul 2022 15:31:18 -0700")
Message-ID: <xmqqy1wh3tzy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E86FFDB4-0C4A-11ED-903C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> It starts by making llist_mergesort() leaner without reducing its
>> performance:
>>
>>   mergesort: unify ranks loops
>>   mergesort: tighten merge loop
>>
>> This matters for the next step, which creates the macro version of
>> that function:
>>
>>   mergesort: add macros for typed sort of linked lists
>>
>> The next two patches show the impact of using the macro on performance
>> and object text size of the test helper:
>>
>>   test-mergesort: use DEFINE_LIST_SORT_DEBUG
>>   test-mergesort: use DEFINE_LIST_SORT
>>
>> Then all llist_mergesort() callers get converted:
>>
>>   blame: use DEFINE_LIST_SORT
>>   commit: use DEFINE_LIST_SORT
>>   fetch-pack: use DEFINE_LIST_SORT
>>   packfile: use DEFINE_LIST_SORT
>>
>> ... and the final patch removes the function which has become unused:
>>
>>   mergesort: remove llist_mergesort()
>
> A nicely presented coherent story that results in an overall code
> reduction.  Thanks for a pleasant read.
>
> Will queue.

No comments or objections from anybody?  I am planning to merge the
topic to 'next' and to 'master' soonish.

Thanks.
