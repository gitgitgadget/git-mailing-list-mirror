Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5E1C636C9
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83FC60FF2
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 17:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhGUQad (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 12:30:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65171 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGUQab (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 12:30:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F23DF142A40;
        Wed, 21 Jul 2021 13:11:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6mSHB6l+1AWeB7j7bvX/hkG6cP71vFIZcnYrw8
        hVKgo=; b=dGhHs6O24jQO1QHnlvTEOywK9pdCYeF2UYIzJrQGlzPSXzBf/3O3l+
        /ycR7FgbdRg3LuN/WS6RS4g3PPqN44IBZbMo4yBBqpD+IyFPLtJdyesouGn8rZT6
        wfa2EPyexkuK/kk7rIEn05s7DywxcKF0xHqICSl1YfXG6cdmbw7S4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EACCF142A3F;
        Wed, 21 Jul 2021 13:11:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 403F8142A3D;
        Wed, 21 Jul 2021 13:11:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git List Mailing <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH v2] pull: introduce --merge option
References: <20210721134650.1866387-1-felipe.contreras@gmail.com>
        <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
Date:   Wed, 21 Jul 2021 10:11:03 -0700
In-Reply-To: <CAHk-=whf-9kNV3y5G-VVA2K5EZCnvv94paAEj6p=i2R4RM2emQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 21 Jul 2021 10:06:11 -0700")
Message-ID: <xmqqeebregns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2144E50-EA46-11EB-9A24-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Jul 21, 2021 at 6:47 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> Users need to specify if they want to either --merge or --rebase, but
>> unfortunately the former is missing.
>
> Ack. I think it's just historical, because long long ago it used to be
> that 'git pull' always merged unless told otherwise with --rebase.

The "--no-rebase" option, which is documented as a synonym for
"--rebase=false", has been there, but the implementation is buggy in
some corner cases, which has been worked on recently in a separate
thread.  I do not think it is too bad to add "--merge" as yet
another synonym for "--rebase=false".

